Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 541881F404
	for <e@80x24.org>; Fri, 14 Sep 2018 16:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbeINViO (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 17:38:14 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:33616 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbeINViN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 17:38:13 -0400
Received: by mail-wr1-f53.google.com with SMTP id v90-v6so11230421wrc.0
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 09:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aYWYvnWfiXPU2qC+GLnjrhbYJBc2hIxdDeHz4488hqA=;
        b=oDZ+ULk2oKzd4HQhaOGJzz5WJ6p2o9C2fHRyZfraqV4TBrIWLOFb1Fal6J1DYL8fL0
         Ejy+AAGGUHILDk9dhZW75YKy+gBCxuEkIYau2fbbXWDlQr1zyIW0u2bGm10u+NQ7BiKS
         dwtMAOKXB326IeU0KshZLr6fOv/fthFL+nDB7Z0ahk2saN37HM3kH00Z2IHUADjWA/uR
         QcHsVvus4fW2ohCEmSUZ6TsgBTP5GxnyAd9YxTHxdHyJruMX/jXJilkDXjutp5huDCGj
         dgP7eJzd59IMt+M5FKu1zMqOpiDbzbeEA5NVxjFzKdNpWOct5HDCE/bAP7twroSOfrz1
         d60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aYWYvnWfiXPU2qC+GLnjrhbYJBc2hIxdDeHz4488hqA=;
        b=F7RSLyiyPj8znnW8XHUKTJgntld9we+GCQp+8Dzl8yqe2N8cttyUq0szZL/oKSDibd
         aDg4Al/8qbv42VH1XkgdNxpw+lpJ7IQDvE8VMGDgeFex/G+RXJG2IXCb1DjEbhex2Yxw
         W0vYcAnBQHZ7UYbYscLPI2fL6rePlhDwuaICRYJpXFv+yJUq2Sn3HgEXJJbP1Hsq+FVv
         I1GQl0m1Apnv3dDhgwUchn9p4Ud8pWCFP5vVbpkkUVgLn4+C7Xo4+MxvY99Y+aiuWgBv
         owj5u+VTJUPCrducgeICUHx/S01BhJIxS0KSixTs6+5Aw2zTbwuZO77/G6tXZDd7UjT4
         IwqA==
X-Gm-Message-State: APzg51AVfdwdFKR0d50jnsssWOQthpPyXj3ozVk1yplvjbiW+buF+fZz
        CMom5hqi0INxp6ZT4Z1dAGBN6fkt
X-Google-Smtp-Source: ANB0VdaFltKWsha0eceuiH+KRslrtNb/qGPwljisv7uLsUtnFQ69ZYszPHF3yjrcP9YHE6DiyoRGDA==
X-Received: by 2002:adf:a11c:: with SMTP id o28-v6mr10753937wro.169.1536942179779;
        Fri, 14 Sep 2018 09:22:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f18-v6sm7708540wru.51.2018.09.14.09.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 09:22:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shulhan <m.shulhan@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] builtin/remote: quote remote name on error to display empty name
References: <20180913131833.32722-1-m.shulhan@gmail.com>
        <xmqqpnxhdq0z.fsf@gitster-ct.c.googlers.com>
        <20180914151710.3261463b@xenom-bubu>
Date:   Fri, 14 Sep 2018 09:22:58 -0700
In-Reply-To: <20180914151710.3261463b@xenom-bubu> (Shulhan's message of "Fri,
        14 Sep 2018 15:17:10 +0700")
Message-ID: <xmqqva78cal9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shulhan <m.shulhan@gmail.com> writes:

> if source is run successfully before I know the patch was correct, as
> the "t/README" said,
>
>   Running Tests
>   -------------
>
>   The easiest way to run tests is to say "make".  This runs all
>   the tests.

t/README says that it is sufficient to run "make" to perform tests,
but that implicitly assumes that the people who are reading it are
now in the t/ directory.

We probably want to clarify the language there, perhaps like so?

Thanks.

 t/README | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/README b/t/README
index 8373a27fea..f95624959f 100644
--- a/t/README
+++ b/t/README
@@ -14,8 +14,8 @@ describes how your test scripts should be organized.
 Running Tests
 -------------
 
-The easiest way to run tests is to say "make".  This runs all
-the tests.
+The easiest way to run tests is to say "make" in this directory (or
+"make test" from the top-level).  This runs all the tests.
 
     *** t0000-basic.sh ***
     ok 1 - .git/objects should be empty after git init in an empty repo.
