Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A72C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 00:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiLTA2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 19:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiLTA23 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 19:28:29 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8823E10A6
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:28:28 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so14854708pjp.1
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGCJU0Ul7x1EbsdG75XcAgDHY/3F11evGsr2Sk8HL1g=;
        b=jL1yo/QAWeCFoasnCsZVRwjBfbIkISjdwgb8ZxdpAQZTRaC7qlGpz3m6KSe+HRxIgt
         hw8MIl91YoGW5QzehYSEoLIabGso/jVyB8Efkwk+BkX7uZJo+yIxbrxfyRoqlGAjN9cd
         YPY6v1kIwUrzLvhTiXsfKn/e9vY2NmNQLJ/L2g/kWaRqbhiiWGFjmaJLAPMCNZXmpU+d
         Dk48ubkNeZgfstw1QJLZbi/aYvvxKpIBKVqG0trMtjKsiIO9Ai5NmAAFxMt4Kcnt5p9s
         m6LNgDxFVxOwHqX9U46fAOM2I1wkEDaSBL/9NDwnkkj8PUpuYmgarpdWnwzhXIt1jqvi
         I0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGCJU0Ul7x1EbsdG75XcAgDHY/3F11evGsr2Sk8HL1g=;
        b=2w6tf1bTa79/k/201mnvvnGOP98cG8if7gaNxW+Yck75JeajHC+SDDdkepZTIHjgix
         ObfFvJkV7029vba3pFXKcxx1Ztxkj3aSVMRb+l5c8i6GKEAt8pyWDXlQYp6DGbNx/3Ms
         ayLM1lqf01A60V57BFmoiNv3m//AwYAV9+d8yRYegmKft1aG5ndhGCbvarsssUKXeB/1
         OgKc8hjtCR1kYFUqqRVwB/09QVHveNXP32mEHg+f/KJHUEw4zMujcmtYBI7lqnqbO9U6
         YFgc7NbJ+OfwdKYULRSFLP6XC8c064qa2pyDvc1y0r0ZyBq5Uq+FPz0Usc4Hd5rkOp/x
         Qw/g==
X-Gm-Message-State: ANoB5pl7bMO+ilXzitvJpx/LSOl0p40V9DufWKs4GztaN20vGc/ykegs
        lhVaDxJt3j8qByuRsnvD4zE=
X-Google-Smtp-Source: AA0mqf62HM19KKziLXY/4L7pC9VLkXzAT2jFfJlDMHUmsJON2qcvrjIVbxYDCwAb8zf4RcFZzbGi2A==
X-Received: by 2002:a05:6a21:164b:b0:aa:5fed:8d6 with SMTP id no11-20020a056a21164b00b000aa5fed08d6mr56243604pzb.15.1671496107916;
        Mon, 19 Dec 2022 16:28:27 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q20-20020a631f54000000b00476c2180dbcsm6808607pgm.29.2022.12.19.16.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 16:28:27 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sheepolution via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sheepolution <danielhaazen@hotmail.com>
Subject: Re: [PATCH] Fix word "does" sticking to "not" by adding space
References: <pull.1393.git.git.1671416810927.gitgitgadget@gmail.com>
Date:   Tue, 20 Dec 2022 09:28:27 +0900
In-Reply-To: <pull.1393.git.git.1671416810927.gitgitgadget@gmail.com>
        (Sheepolution via GitGitGadget's message of "Mon, 19 Dec 2022 02:26:50
        +0000")
Message-ID: <xmqqh6xq2a1g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sheepolution via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH] Fix word "does" sticking to "not" by adding space

Not incorrect per-se, but the above fails to say a more important
thing---where does the typo appear?

    Subject: [PATCH] mingw: fix typo in an error message from ownership check

or something, perhaps.

> From: =?UTF-8?q?Dani=C3=ABl=20Haazen?= <danielhaazen@hotmail.com>

Here is where the proposed log message goes, not ...

> Signed-off-by: Daniël Haazen <danielhaazen@hotmail.com>
> ---
>     git: fix word "does" sticking to "not" in message

>     
>     When a repository is on a FAT32 file system it will send a message to
>     the user explaining they should use git config --global --add
>     safe.directory. To prevent a long line in the file the message is made
>     up of two string literals. In this change the first literal has a space
>     added to it to fix the issue that the last and the first word of the two
>     literals stick together like the example image below.

... here.

     When a repository is on a FAT32 file system it will send a
     message that the path ownership cannot be determined.  Fix a
     typo in the message.

should be sufficient.

> diff --git a/compat/mingw.c b/compat/mingw.c
> index d614f156df1..af397e68a1d 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -2752,7 +2752,7 @@ int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
>  			/*
>  			 * On FAT32 volumes, ownership is not actually recorded.
>  			 */
> -			strbuf_addf(report, "'%s' is on a file system that does"
> +			strbuf_addf(report, "'%s' is on a file system that does "
>  				    "not record ownership\n", path);

Thanks for spotting the mistake.  Very much appreciated.
