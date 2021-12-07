Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB997C433FE
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 18:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbhLGS1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 13:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbhLGS1S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 13:27:18 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC37C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 10:23:47 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id k64so116480pfd.11
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 10:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ncHABJgZQ4GsWx4+UrxG99kqkusX6uuqXZFGxPpKDbQ=;
        b=D2GpWylhh4RZKBEmRIytZ3HedBZXQuGuJ5Q1SjQj9FDUW2gPMPXvm8rRyM2ZtTgI6b
         Jsbw/9ByyRh3mElSqV/ytZgH2gvMCncI0F4PrSqMSsWkZF/UYllpjtNl1hghCY9tQ1JM
         nZm+nGb54huiAzmBNZHNqc96Il2B9CNnBFLHuVMNECWGWEKIgcV1ZDiEsjiFpcFdDwG1
         tqk2bXyszzxMJS0mOW2DqHEh7plQ3YoR3TSYNhKqK6LtJ+Tm7zQdq49FAUd3d3jT/eK0
         dRb6nKpUN1g1bsqHp3m87HrsWJg9HvgJFqipIcOQWUW+SP4FgRWmogBgPt1dK2+3MU9a
         Mfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ncHABJgZQ4GsWx4+UrxG99kqkusX6uuqXZFGxPpKDbQ=;
        b=47qUuCWU1Odl6SF/adqWNOx1JduL27vUV44L9IOImbb6QVlqte0EVtvNtIcMQvGIx1
         E1tIJ9iiKIhc1ewbe7oIwRTaONjuM0nq07XeZubDXo5k40aQlpaB0OYJejKxmo0jAOiJ
         7P/TRUNrkYdBOh9JiBrBXVRF2iua0RWZf84HXlIqbhI8VnG9MrAFZnewpl5egY97OetW
         /ZFNNTa1wD0x9slrA2hztSZSjyhdcTGJGmk5gJTdDalRih/PNPROF6e3rhDT9NYhdF8R
         u2TMWKsf4PMUf2XJwUmG8tll6GbbLi6gCQAE+2Uvm+OHyn2jTRyqTQo4Cxam+olYeGhA
         9QWw==
X-Gm-Message-State: AOAM532TIbTzxy0d3hBwBC1dprMzqa5bcCKhF7Uhbm51Ttum4Ws6OCGm
        FW+iJMHQhUES9KBNjLJ4UZYKAQikug0=
X-Google-Smtp-Source: ABdhPJwnkgMZX/gzC2FEqT5utARGHA1KZIcN1GcLYW8Z4Erlgg0E5td091gsdT79ZaogtPoBCSb7Hg==
X-Received: by 2002:a63:7445:: with SMTP id e5mr25789802pgn.504.1638901426789;
        Tue, 07 Dec 2021 10:23:46 -0800 (PST)
Received: from LAPTOP-FJDAS7G4.localdomain ([157.40.240.182])
        by smtp.gmail.com with ESMTPSA id q8sm413574pfk.152.2021.12.07.10.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 10:23:46 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     git@vger.kernel.org
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v2 0/1] making --set-upstream have default arguments
Date:   Tue,  7 Dec 2021 23:52:59 +0530
Message-Id: <20211207182300.4361-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211202144354.17416-1-chakrabortyabhradeep79@gmail.com>
References: <20211202144354.17416-1-chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The changes regarding 'git push -u' in the previous patch version
were hurting the intention of using 'push.default'. This patch version
fixes that.

Argumentless 'git push -u' sets the default remote as '<repository>'.
'<refspec>' depends on the 'push.default' configuration. For
'push.default'=matching, it pushes refs to those branches that it
should and sets them as the upstream of their respective local
branches. For all other values of 'push.default', it uses the
current branch for the refspec.

'<repository>' value depends on 'branch.*.remote' and 'remote.pushDefault'
(if 'branch.*.remote' not found). If none of them are set then it
defaults to 'origin'.

Abhradeep Chakraborty (1):
  push: make '-u' have default arguments

 Documentation/git-push.txt |  10 ++++
 builtin/push.c             |  11 +++-
 t/t5523-push-upstream.sh   | 114 +++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+), 2 deletions(-)

-- 
2.17.1

