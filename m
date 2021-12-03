Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A8AC433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 19:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353723AbhLCTbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 14:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237366AbhLCTbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 14:31:09 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D108C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 11:27:45 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 8so3803981pfo.4
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 11:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GPfN3L6zC+5/fVxY9+/JkYg6RqEmkftKB2Tg3mmLdX8=;
        b=o9mwvvG6MPfUCN7pZzRabwUrb5ECPcsWrF40SUwYdS8Zaa7iKTiuWumK/oFL2Uv8aE
         dgqaA5B7D9xP7RIVm3jMmb0vTCU3lzRfanQ5ENg4+wzhzhIs481zFO/XhwdofRykI51A
         QJ0htKJKxU+Uo0d3+XO5nc0islOG9Nqs3CPDzUXJe+z8TeVCgduu/fUj5RPXri0+qfk3
         6GAzYQ2hedZyq6qdf+j8lWR8KYr/gaJJ4N0UomvH5bTqMk7VGvZWSE/WgyDlrPBtERUx
         VCLgwgS968aOdLU3J3GWEnDjYyytTc9+XuZgIXoPFQYfT4yZwJmmCalkoj2PMnIruoiV
         sIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GPfN3L6zC+5/fVxY9+/JkYg6RqEmkftKB2Tg3mmLdX8=;
        b=W4FJAuGQF9fV8y63NHCszpghlT19xYQNk/A1ujMK/PaJsyhW0gaFL69U+r3yaIqGpY
         QBfTtsIqMh0IO7Z12UwB8j5AYO93uPhjRLF5AVCIudL5cQaWVGUl66eAmLSzc+lryfuf
         h7ceNPovRBvR/4vWY4lxRmHxZz5AM6+u+ziA+SwzP3hpvSzHLu5KcUwTqiPbDPOdl5Zt
         Ue/nI54tDUy6MQMVZ2DXpiGIUerxHIJPhS0NMMtLvydg/mTwM2odDa9oC85JRZ8jb+MW
         1VcIC/kEvMmaqBVmJ8FVTq4TOgRmqc+t+sevHU5kbat6RZPz1VVPv/wKgt7ciC842mka
         4Vpw==
X-Gm-Message-State: AOAM533hYBFgiRU2VQNmJ3xJYkspG5rTRc/ThVFonS6wQRjqYJIFvu74
        HiEKblTzxq5DoyO4cNwiBbWSKRQ/UaXKTw==
X-Google-Smtp-Source: ABdhPJy0d+n0+UBQYYb/0LvhSyC2NRDH9bdn24asgwccqMIg+eA8iEAio07cmSLPugDHqU9QlzQOiw==
X-Received: by 2002:a63:60d:: with SMTP id 13mr6047051pgg.359.1638559664686;
        Fri, 03 Dec 2021 11:27:44 -0800 (PST)
Received: from LAPTOP-FJDAS7G4.localdomain ([157.40.237.213])
        by smtp.gmail.com with ESMTPSA id l6sm4227490pfu.129.2021.12.03.11.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 11:27:44 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [RFC PATCH 1/1] push: make '-u' have default arguments
Date:   Sat,  4 Dec 2021 00:57:16 +0530
Message-Id: <20211203192716.18444-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <xmqqtufpsikp.fsf@gitster.g>
References: <xmqqtufpsikp.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> That of course is not an improvement but actively hurts them.  We
> shouldn't be making it easier for our users to hurt themselves.

Hmm. In the scenario you mentioned, the proposed change is clearly
breaking. Thanks for notifying.

> Shouldn't the rule be something like "if 'git push $args' (where
> $args may be nothing, or any options other than '-u') pushes a
> branch (or a set of branches) to a repository, 'git push -u $args'
> (with the same $args) should set the branch.*.{remote,merge} for the
> branch(es) to the same repository" for the introduction of default
> to be truly an improvement?  Or is it too strict and makes the rule
> not to trigger even for the intended audience?

Sounds good to me. But what if 'push.default' set to 'nothing'? Do the
proposed default arguments (I am saying about only the default arguments;
not the changes in code) are right fit for that case?
