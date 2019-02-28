Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64FB820248
	for <e@80x24.org>; Thu, 28 Feb 2019 10:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbfB1KCZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 05:02:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40962 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730215AbfB1KCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 05:02:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id n2so21203413wrw.8
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 02:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=filenko-ms.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version;
        bh=TkzvAcJAIHYwydEwGGJuf2bvx6NCEEho+vaxiQUsh8s=;
        b=Kl2SJC5ZhNS5x2j6HzUMPk5kynvu1uuc/6FupK8sbNyzG6JE+jMcAqpu2t5YaaE5jR
         X486PHyeENan4K/qgOUddzU+13xAk3UScTekbGjK2mJ+TNO32OpdMpbOxbuBinGPjN51
         m393wAPMnIiPzVBeh/HU5StOvX+KkbjF5llksiytJEnCbsRfUdARXMnKvZ9Hp/uGUO4g
         EW2uV3OWvuYUg58Ej+wX0zXlmA3mAno0WuGaohZ/H4nzbKliWHjEhdP2pWyFlZbV0H3W
         5WT/eUiXD/FysRMt96DAP2BkZfeKJ6cmHO+FSpXqVuItQ70QDOboLGyVNaNikCrx5W7G
         S0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version;
        bh=TkzvAcJAIHYwydEwGGJuf2bvx6NCEEho+vaxiQUsh8s=;
        b=DphDD4IlWIOitp5PWsL5yQMbLHAbEGNYN4BK8qmDvUsSIq7FMhX4Sz1EK1gcz4wdSy
         AG7dUQmo5EjW7mKmSLhV4ydhAdcICahlQBFxC1UT4DRf+sTxZCEOM9mJHVDFque6t0mt
         MxIa/VI1M0tCtXjnrLh3uw8XxYEJ4ilHuuEJMY1YEL833HeMutCwgi1BJqdHrhk26FJu
         frf13wq+2GzpbhJarUInnYipsGQrALoa5COoxIQhbi9LGIXkgoPx88IjTLo6nIwpEH32
         x6Y7a8WKgl4HItarY1+aeTpIjslAdAe/A3Kpj+QP/KeR8j1LBLRQfyYqMoaqUfCa19k3
         vv5w==
X-Gm-Message-State: APjAAAWW2wixeNxkcI8iO8AhWkuVUTGr92GHUyuoUUuur+NP2/YUcrtL
        YoiUwKRvQj6NBQ/CoAjd7fqq7ocYUJE=
X-Google-Smtp-Source: APXvYqzC2Zsxv9Uxw44qoeNf0L0X/SjSItorlxzm3ZXmVxSfy6orW+HARRwqKZ3Jpz18g4qeqMLB+Q==
X-Received: by 2002:adf:a49c:: with SMTP id g28mr5396559wrb.147.1551348140781;
        Thu, 28 Feb 2019 02:02:20 -0800 (PST)
Received: from bouncer ([213.61.81.99])
        by smtp.gmail.com with ESMTPSA id b10sm15241887wru.92.2019.02.28.02.02.18
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 02:02:19 -0800 (PST)
From:   Max Filenko <contact@filenko.ms>
To:     git@vger.kernel.org
Subject: [BUG] git-am: all colons in the beginning of a subject are lost
Date:   Thu, 28 Feb 2019 11:02:11 +0100
Message-ID: <m2wolk6xjw.fsf@filenko.ms>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

If there are colons in the beginning of a patch subject line `git-am'
will drop them.

Consider the following patch:

    $ cat 0001-four-colons-prepended.patch
    From e8213a2d10a61c9dc75521d88d656b8d5330e6bb Mon Sep 17 00:00:00 2001
    From: Max Filenko <contact@filenko.ms>
    Date: Tue, 12 Feb 2019 12:21:21 +0100
    Subject: [PATCH] :::: four colons prepended
    
    ---
     file.txt | 2 +-
     1 file changed, 1 insertion(+), 1 deletion(-)
    
    diff --git a/file.txt b/file.txt
    index 4dd1ef7..b5da95d 100644
    --- a/file.txt
    +++ b/file.txt
    @@ -1 +1 @@
    -This is a file.
    +This is a plain text file.
    -- 
    2.17.1

There will be no colons in the beginning of a commit message if I apply
this patch:

    $ git am 0001-four-colons-prepended.patch
    Applying: four colons prepended

The four colons already gone in the log message above. There are neither
no colons in the commit subject line:

    $ git show
    commit 6341a6a2872f850ecb376c268b1b3bae54a6a74f (HEAD -> master)
    Author: Max Filenko <contact@filenko.ms>
    Date:   Tue Feb 12 12:21:21 2019 +0100
    
        four colons prepended
    
    diff --git a/file.txt b/file.txt
    index 4dd1ef7..b5da95d 100644
    --- a/file.txt
    +++ b/file.txt
    @@ -1 +1 @@
    -This is a file.
    +This is a plain text file.

I was able to reproduce this with git 2.17.1 on Ubuntu 18.04.2 LTS as
well as with git 2.17.2 (Apple Git-113) on macOS 10.14.3.

I was able to trace this down to <builtin/am.c>. It seems like there are
no colons already in the `state->msg' which to my understanding is being
filled by `read_commit_msg()' function. I would really appreciate a hand
on debugging it further.

I'm re-submitting this bug report because the original one [1] wasn't
really noticed. Hopefully, it's just because I've missed the proper
prefix in my email's subject line :)

[1]:
http://public-inbox.org/git/m2lg2lxmmm.fsf@bouncer.i-did-not-set--mail-host-address--so-tickle-me/

--
Best,
Max
