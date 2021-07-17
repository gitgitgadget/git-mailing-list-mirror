Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D9DC636C9
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 18:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B07B861154
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 18:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbhGQSRz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 14:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbhGQSRy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 14:17:54 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220C3C061762
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 11:14:55 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id s2-20020a0568301e02b02904ce2c1a843eso2921027otr.13
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 11:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=B6CL7VhgdtOcbai+lr9rBeBcJ0cjJf03vZz7iU12sgc=;
        b=XhYtcZA4hIRZJ5v1cEmebp/bASZcm/Wigl4EVWVBmRBqa/CJuinxDodtjJQT23Vfta
         lHGPSnJtAcmpb/BvuW1zJo1DqjEG35DLqUaurt//KGmgPWUug8jyOGwSBoNcbIABZ33Z
         TeYoQyThIdHI3zV2LI6E9oZfWCfEv/yDIZxlnMYibd7ffe8N/siENmKGHumrP9oYFpek
         MD3o1XopdljiOXxHL12bZVxLw26sUF412GDSaoyFXJTrJYKuQsUe+A18LVDGm9xqdVoR
         URKr2NtlJTjtA7d7LPK3rBF0C84g396FmBE7zxLWOwTSHMqhTpPlBbFar/zDrz5vjIWx
         1j9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=B6CL7VhgdtOcbai+lr9rBeBcJ0cjJf03vZz7iU12sgc=;
        b=DxeZQbJ5WYCH4mCiubKEDT8kJrqV3b+Y8mDVG170yWeHdHQV7yeWHAlvy2nSMCLBve
         84Q2dSd1OyU4tSd/aDGXsrJ+Jb+ArslLegyI/8PeqfOneu9+20s1hDpdJOalJLGEH+7p
         pb5/MwJsHpMIyCjh82IqzKD2yO4msskB7yogMVaSniYhCnywEAF38ITd9UCLN+5G4m/W
         0T3R4MilGFYw5jXuwOqSOi7cntj3UG9Eszv4u2h4x3MMeMH1KGWSWUt24CGyc2O43cZk
         97ru5dHzRxEiLdxvOi4MLgzgty2Q55FXTO4mgCvDpTZmZ4pjuiJtsrw4bFF+76UxzCpc
         1eIQ==
X-Gm-Message-State: AOAM533TjrNG4gvemfyu0WmP/KsUKe2Hwb6lTUHa+4SkeLRvQ996eYUj
        6pMjYpIsYr7UtUE7ZFgmF+M=
X-Google-Smtp-Source: ABdhPJypPFMOblJAAczDbU6lt3eg3H8s2IyJDAaVYyZFlfwc1BYTLgtc5skHJjyPhE4ivedNq9VZMw==
X-Received: by 2002:a05:6830:114f:: with SMTP id x15mr12833132otq.356.1626545693357;
        Sat, 17 Jul 2021 11:14:53 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id m129sm2884193oif.15.2021.07.17.11.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 11:14:52 -0700 (PDT)
Date:   Sat, 17 Jul 2021 13:14:50 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Alex Henrie via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Message-ID: <60f31e1a928f2_25f2208cb@natae.notmuch>
In-Reply-To: <ae54afd8b0118aa1e2b90503aee75a8fddecae1a.1626536508.git.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
 <ae54afd8b0118aa1e2b90503aee75a8fddecae1a.1626536508.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH 3/9] pull: abort if --ff-only is given and fast-forwarding
 is impossible
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie via GitGitGadget wrote:
> From: Alex Henrie <alexhenrie24@gmail.com>
> 
> The warning about pulling without specifying how to reconcile divergent
> branches says that after setting pull.rebase to true, --ff-only can
> still be passed on the command line to require a fast-forward. Make that
> actually work.

Once again, this behavior is not explained in the documentation.

And this breaks existing behavior.

A person currently can configure `pull.ff=only` to tell git that by
default she wants `git pull` to fail if the merge is not a fast-forward,
but she can override that default behavior with `git pull --rebase`.

Now that fails as well.

So even though the warning has been saying that users need to specify if
to merge or rebase, and the user has specified a rebase, it now fails,
so it's a step backwards.

-- 
Felipe Contreras
