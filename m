Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13594C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 10:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E25116103A
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 10:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhHRKph (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 06:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbhHRKpg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 06:45:36 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DEFC061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 03:45:02 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id e19so1512872pla.10
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 03:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JQfE9dNRtbQYZi/llm0xSJF/+j26MxOPRS/HUm6oxwk=;
        b=dfwnKpwnKxM35nzm0x04QuagadPf2EjtsIcsPRIAcKgRtDGGaSWZ6UDpSTdyhLjtDQ
         HKJFdT91H6eOtGTsmgcIw/0K19ttYP0jknQP3ixI8xkk4a/zToMxAIonXhZwNPI5p+H9
         Zg+P+TmaeyPwO934Nt/ZYm1k2ZcrM6lHM9KeTALLECYd9NLwxaB7pR7yhxXpGHTSCgWV
         UYlR9RjYXsot1W+97C2K339cKrjn44yaWagJATd4T0XRfAn93Brnf+QTXUhJOXvJVJze
         9GUTxrbT3CMzWl6mnwnMgk3rWn8lgV8DeXOrL8uv0xkOvNibtaE8r0Cf8ou9VNUEnMMG
         7h0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JQfE9dNRtbQYZi/llm0xSJF/+j26MxOPRS/HUm6oxwk=;
        b=GeJQo94eYR1BLVXL6lIi+9c06tZ29cTe4LQvjNYzvkIf287pSB04J59QjyVKAk795H
         WPIizb0ukHDwpvTFaP6iuJfES7avnBVaT09pMw2NeHAvjokMC9HtpikiKk4SSjaI16C0
         t1/jS9erYhzSHKw6hw03vCoBauREPpBvDomerQAzSjktDRumjXVce9YnsA2IqoFFeetT
         dZ7B22TzdTPb/g+6hdisD2VBzbBS+7YsWedIeUIcx+giWw9qIvFPKihnWyGLCMGTfAr7
         QOluYSfnU/KVs5cwk66EE8wVmQHoTkM5DQQ4JmVycsONt4SDSVkXzQ02/G1jCYtxGbbd
         UPAQ==
X-Gm-Message-State: AOAM5332i8mECFXqh2T0Sly3xOoJ/4lV3bEjcsixflkvVDW8akVoJs8K
        RTdzfgcNMB7/X7+B4OnZLSA3xV5YjqU=
X-Google-Smtp-Source: ABdhPJw/cuGAz3WEU7Ou2DYG6iikNdWlFKLQq7asbWkslkf7XRGB7QjPf0k3XA/ijXty+m75h+4d1Q==
X-Received: by 2002:a17:90a:af8f:: with SMTP id w15mr8725800pjq.90.1629283501908;
        Wed, 18 Aug 2021 03:45:01 -0700 (PDT)
Received: from localhost ([2402:800:63ed:4478:964c:2b9b:388e:4b0])
        by smtp.gmail.com with ESMTPSA id p24sm6036224pff.161.2021.08.18.03.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 03:45:01 -0700 (PDT)
Date:   Wed, 18 Aug 2021 17:44:59 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Thomas De Zeeuw <thomas@slight.dev>
Cc:     git@vger.kernel.org
Subject: Re: Bug: Segmentation fault in git diff
Message-ID: <YRzkq47gOGfn8zsw@danh.dev>
References: <40BE2EF2-0AF3-45BA-9880-8A6011B38D03@slight.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40BE2EF2-0AF3-45BA-9880-8A6011B38D03@slight.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-08-18 10:42:45+0200, Thomas De Zeeuw <thomas@slight.dev> wrote:
> Hello,
> 
> This is my first bug report to Git mailing list so let me know if more information is needed.
> 
> Running the following command results in a segmentation fault on macOS arm64
> $ git diff --name-only --diff-filter=U —relative
> Segmentation fault: 11

MVCE:

---- 8< ---
#!/bin/sh

rm -rf /tmp/diff-bug
git init /tmp/diff-bug
cd /tmp/diff-bug
mkdir -p dir

printf '%s\n' one two three >file
printf '%s\n' inner >dir/file
git add file dir/file
git commit -m first

git branch side

printf '%s\n' one two >file
git add file
git commit -m checkpoint
git tag checkpoint

git switch side
printf '%s\n' two two four >file
git add file
git commit -m side

cd dir
git rebase checkpoint

git diff --name-only --relative
---- >8 -----

It's NULL pointer dereference bug because pair is NULL.
I haven't check further:

---- 8< -----
#0  run_diff_files (revs=revs@entry=0x7ffcc85ae270, option=option@entry=0)
    at diff-lib.c:196
196                                     pair->two->mode = wt_mode;
----- >8 -----

-- 
Danh
