Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A49C433E0
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 12:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C791D64E32
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 12:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhBGM4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 07:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhBGM4a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 07:56:30 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CABC06174A
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 04:55:50 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id j25so12878480oii.0
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 04:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=aF2jFHA6HhXAsnYyW6jL2+tqCLVvWQOnAbw4EJ0C2XY=;
        b=jpPJWA6Z6HuxcOS6KvKj1Ctt3rmTV6MIHNmF/eQ0Mbl5NUpeMtLUBzlpemV78YORyG
         wsRXRje9bzWq/1eUefh/dQlq3gOwmVAiPXQ4tkMXek6K8RiencXEG+nkTlwRXNb+bJJ/
         HzJYwnw3O+0asoXvvG3a3JgxHW06FY6LcvxDzn7z7GY5ak7c93sfICQ5a7/DTfjeTiTA
         VS8AyP6mp/oUluUY266GtfaafaQzaKEfQR22SMHa1DHsHySW+YM35SFBer72VcXSC6rR
         N45TRg6DYwfktHPhZnT89aocV4t0oG3qrWGaY2feQvkKStkF8RWaHoqgps7yqXK6j6hW
         Tncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=aF2jFHA6HhXAsnYyW6jL2+tqCLVvWQOnAbw4EJ0C2XY=;
        b=nfztDNBrfpoj/YZxWcq7tsItYCdGDLkkcLM1Z9RlM/inSWT52U4fbVJENVxqZ6dUQo
         leBIJWA1+QgBnOTlS8ORNZX3DmeI/0Qpgo+ZD3GW8PTqhkVWJ4ZULMYdkd4f0GRUeBaC
         DtTTl2kzlnPFiIuxF7bqouUYag8M4xl6I/wY63aIj0X2tSyxhbXB51Czr4+tbF8nhehJ
         MYP2UVjYD/XtieMi0uaTIZbui1pwLbGaTF1ADJRjLYAiC+GI2JAX8Q7WHwsMgJb2SF/0
         8SgknQ6cQbtR1gNFbST3WDf+WfNBHhyhbZUp6+9eZCQLjvYXE23ym5Z868cTFfxiHX57
         si8w==
X-Gm-Message-State: AOAM532jT7Nq/X4o018L1MIrzIMy/RYrRQ69TgFGasL4Ax6Ba6AS10Yf
        Ey5yclN3x7tU+7g+fbGKxLpWiPbCWiwuh7fga3M=
X-Google-Smtp-Source: ABdhPJxjE7SpPJVcOcI6cNzMvFm6UrTt6yJXAYRpVedHwt6JIdNWcB0lTYQ6SLP/CS+B6mDqywlWvb2CPNp/g09Spl0=
X-Received: by 2002:aca:52d1:: with SMTP id g200mr8712909oib.44.1612702549598;
 Sun, 07 Feb 2021 04:55:49 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Sun, 7 Feb 2021 20:57:56 +0800
Message-ID: <CAOLTT8S1xMS+MMiSbQNqpw+BVtu6V-TBSOCrWjJv-6pT4h5g1Q@mail.gmail.com>
Subject: Re: Specify resume point with git difftool?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, rtzoeller@rtzoeller.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,Junio,

I try to reslove this issue,but there may be a little change
in my approach:

>  - At the beginning, see if $GIT_DIR/difftool-skip-to file exists.
>
>    - If exists, read its contents.
>
Which have been read now we called it "SAVE_POINT_NUM".

And then,divided into two situations:
If the index of the file($GIT_DIFF_PATH_COUNTER)we are
viewing is 1,if $SAVE_POINT_NUM larger than
$GIT_DIFF_PATH_COUNTER, ask users if they
want to skip to last time save point $SAVE_POINT_NUM:
if the answer is no,we continue show difftool of first file;
if the answer is yes,we `return`.
If the index of the file we are viewing is large than 1,we just check the
if $SAVE_POINT_NUM large than $GIT_DIFF_PATH_COUNTER,if true,
`return` ;if false,we continue show difftool of files.

And everytime before we view the diff,we save the
$GIT_DIFF_PATH_COUNTER to $GIT_DIR/difftool-skip-to.

>    - Remove that file (we are at the 15th path and done skipping).
finally,when success viewed last file diff,we delete the
`$GIT_DIR/difftool-skip-to`.
>
>  - Update the "Viewing .../ Launch?" prompt and offer another choice
>    "Skip to?".
>
>  - Update the if/then/fi statement that processes the answer to the
>    prompt (right now, it takes n as a sign to skip the file).  When
>    the user says "skip to 15th", create $GIT_DIR/difftool-skip-to
>    file and record "15" in it and 'return'.
When we were at an index in the middle, I didn't think there was any
good way to go back to the previous index, so I didn't deal with random jumping.

After all, this question focuses on the save point of the last exit.

I have a question: If the user has two different `git difftool`
(e.g. first time user call `git difftool HEAD~` and exits midway,
second time call `git difftool HEAD~2`, the "GIT_DIR/difftool-skip-to "
still exists), I did not do the consistency check for the two.

But this is not a big hindrance, because the user can choose not to
skip before viewing the first file.

My patch will send soon.
If there are errors or omissions in my thinking,please tell me,thanks.
