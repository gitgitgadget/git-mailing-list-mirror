Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C44DC001DF
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 20:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjHGUkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 16:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjHGUkI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 16:40:08 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E05F19A9
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 13:38:45 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso48762555e9.0
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 13:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691440721; x=1692045521;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbDTo+FDVUP7vhaUUO6Z8RfkGyjCSJqvXkMYVYazoxc=;
        b=ggD6SKGwhoeTRQIg7+jjDJtRoYwgiZuXNRkAZNzGvqf9eJkTDqD/dCIduaOIxUwuYa
         c/90AliANzTjVJbmAIVzOysBqyy4WjjagDoTwOG5lH4jlvDJ5EJyuJZjAnoJVOn17DPw
         RmUPPh7WI/sYALOZ82euTb5LlGb0rxX91c7mDNLlWzgdbhggyECcopWXIoYG3Ksx22cq
         Fx1m3EQ/bGvxMaI9D7aCAWTmPmaZPsnhc3TpmQJvimxhlPRolhIoZLheg10GFhkSsAS0
         ziBfJBHGyut/bn4zZyo7W8ubM7FQbUDtF0z2HVtl5os5uXmJBd06sebpsliGOMgmKtMt
         y2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691440721; x=1692045521;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbDTo+FDVUP7vhaUUO6Z8RfkGyjCSJqvXkMYVYazoxc=;
        b=WIOKlLjeiAYt3nCcEKE2gYv2hHFv5dlwk2SN6tKj2XXb/Y8ym7LMY35631FSTYnWwD
         tRsfeddHQOoIMkPB+GQA5xVqgvJYsZjinLxt/BHr7aEe6tFVYcyFbbs5D7bzqdlpC32S
         vONSmTCaG4KT+ruTL2GykOfnbXkVM4BgseKkWZbzbvWbxIjH2ne5j2tOnQhFoWK3/AVx
         bPpGdnnYE6q4G9cU1BIPBWXbsatAJJc7GINB0bwqp38bIt9tavNALCIhUqhc4fKLTxJF
         GSwfoCaWqfCRJ3fN2gW74swMHCHQZDYs7T522gDhYIeF8UBQRaBX5eAhT9Gr/fQAbyzE
         gVlQ==
X-Gm-Message-State: AOJu0Yx3x/yEs/07CZuyalIh3/HheJvyMAkcYwm2jyCg4yvsJKFo5vHW
        vr20YD2eXEIU/jiGvpKuAysG/6TIvPE=
X-Google-Smtp-Source: AGHT+IEdbbz2mdGaE0XA314J0SYYDBE5FUvSYwFiTzNqr5Bgm1cyOfjhf/Dn++P0PhOlXgDXtFQzGA==
X-Received: by 2002:a05:600c:ad8:b0:3fe:2120:a87a with SMTP id c24-20020a05600c0ad800b003fe2120a87amr7954615wmr.37.1691440720402;
        Mon, 07 Aug 2023 13:38:40 -0700 (PDT)
Received: from [192.168.2.52] (225.red-88-14-55.dynamicip.rima-tde.net. [88.14.55.225])
        by smtp.gmail.com with ESMTPSA id l26-20020a1c791a000000b003fbb06af219sm11723415wme.32.2023.08.07.13.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 13:38:39 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH 0/2] branch: update error messages
Message-ID: <7710c002-0832-d8f6-59b8-30119bd5efe6@gmail.com>
Date:   Mon, 7 Aug 2023 22:38:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A message like "branch 'frog' checked out at ..." may be confusing to
the user if the branch 'frog' is not the currently checked out branch,
which may occur while rebasing, bisecting or other operations.

Let's reword those messages as it has been done in 4970bedef2 (branch:
update the message to refuse touching a branch in-use, 2023-07-21).

Rubén Justo (2):
  branch: error message deleting a branch in use
  branch: error message checking out a branch in use

 branch.c                |  2 +-
 builtin/branch.c        |  2 +-
 t/t2400-worktree-add.sh |  3 ++-
 t/t3200-branch.sh       | 14 +++++++++++++-
 t/t3400-rebase.sh       |  2 +-
 5 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.42.0.rc0.2.gbb987841e8

