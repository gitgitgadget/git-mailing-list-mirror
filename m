Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D94C41604
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 16:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53E36206F7
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 16:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jlh5/Z7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgJFQo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 12:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgJFQo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 12:44:58 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61CEC061755
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 09:44:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l15so2642694wmh.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 09:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ewtRw3bNoToVlsseGMh1YSxN52f4jTrbMXSyGM+QbPk=;
        b=Jlh5/Z7u0nmBJrg1a13hNAl+7p6VhGiFyygBcp7PNyu0dQ2Orh37pdbdY6g+XQYhOO
         A395xYNWhklg4O6+eMJ7XYfpeINtZlNBEqeJGcZvUq1RQl0wuLizg8bCtlEyMV26siOV
         SSzGHDrfFXwZMxEJN3JLVO7o4Fw/AKWdFFAzHKMdRRmlMErDqs6pdXIfwZDaY8iNTInW
         FGc2I/HCayB+ODxvYI2JXJJlUt5zBTQt8h9n98IuA4G476lzl7kZXW/uOfkwko+/7mi3
         b6v90InBbsIAGXrharihAQQ9Bq7QeEbqgFG+ugn9scq2F9/t1QeK14OQcyZSHwtbzJwx
         uuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ewtRw3bNoToVlsseGMh1YSxN52f4jTrbMXSyGM+QbPk=;
        b=tM0enMDfJdM5yLyPofUdkFK4+eAwZioM0VmtbsHE2d3gdC3nreXpqOHGCYjS/DYYmA
         oTwy57KrT4OOU5pvuKMbd62QRmCG3kh5cXB/PhgTAq4kClKkeN0iRj8TuisWqV7gs94t
         Q6SKlAsJgSigZ6iWiy+1itJddKdXp4zyWBGmER+UD34eO4xbFT0QYJnpW+RmfXtgQF7q
         rsPl+9NoRqYVY3lsnf/VrTJIZVrmr+SMMW4dvd5QnmyVz8jwPIksYkVZCTs6dgYeWE9t
         t88P//hQIaWGTSRBQyQT5gAeF/tgrHDcedasW9yRCR0uJgkbJ1/SmVuyWucBU+bZzbKf
         36jw==
X-Gm-Message-State: AOAM533KqIIwI3DcQZAf7edwxuJJ5muBaO5OdjNwzry462b7FUAQuleF
        oRM52a4nQ0w3Y9e/6a1i9Ww=
X-Google-Smtp-Source: ABdhPJy3DkIXzSNQN2jDvUyJWWzWy2QdaKKSoyRa7w3EgUJy+eDllnjstSbwsULc1GTusWyYGYmhRw==
X-Received: by 2002:a1c:6546:: with SMTP id z67mr5570197wmb.98.1602002696500;
        Tue, 06 Oct 2020 09:44:56 -0700 (PDT)
Received: from [192.168.1.21] (88-105-142-27.dynamic.dsl.as9105.com. [88.105.142.27])
        by smtp.gmail.com with ESMTPSA id c18sm2580421wrq.5.2020.10.06.09.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 09:44:55 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] userdiff: support Rust macros
To:     Konrad Borowski via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Konrad Borowski <github@borowski.pw>,
        Konrad Borowski <konrad@borowski.pw>
References: <pull.865.git.git.1601986430388.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <18297f15-3b67-73a6-9ad4-cf477622fe62@gmail.com>
Date:   Tue, 6 Oct 2020 17:44:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <pull.865.git.git.1601986430388.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Konrad

Thanks for the patch, this would be a useful addition

On 06/10/2020 13:13, Konrad Borowski via GitGitGadget wrote:
> From: Konrad Borowski <konrad@borowski.pw>
> 
> This adds a support for macro_rules! keyword which declares
> a macro. It also includes a test case.
> 
> Signed-off-by: Konrad Borowski <konrad@borowski.pw>
> ---
>      userdiff: support Rust macros
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-865%2Fxfix%2Fuserdiff-macro-rules-rust-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-865/xfix/userdiff-macro-rules-rust-v1
> Pull-Request: https://github.com/git/git/pull/865
> 
>   t/t4018/rust-macro-rules | 6 ++++++
>   userdiff.c               | 2 +-
>   2 files changed, 7 insertions(+), 1 deletion(-)
>   create mode 100644 t/t4018/rust-macro-rules
> 
> diff --git a/t/t4018/rust-macro-rules b/t/t4018/rust-macro-rules
> new file mode 100644
> index 0000000000..ec610c5b62
> --- /dev/null
> +++ b/t/t4018/rust-macro-rules
> @@ -0,0 +1,6 @@
> +macro_rules! RIGHT {
> +    () => {
> +        // a comment
> +        let x = ChangeMe;
> +    };
> +}
> diff --git a/userdiff.c b/userdiff.c
> index fde02f225b..f13a913697 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -165,7 +165,7 @@ PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
>   	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
>   	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
>   PATTERNS("rust",
> -	 "^[\t ]*((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl)[< \t]+[^;]*)$",
> +	 "^[\t ]*(((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl)[< \t]+|macro_rules[\t ]*!)

I think you want the `!` before the `[\t ]`. We could probably get away 
with just adding `macro-rules!` as another alternative in the group 
starting with `struct`

Best Wishes

Phillip

[^;]*)$",
>   	 /* -- */
>   	 "[a-zA-Z_][a-zA-Z0-9_]*"
>   	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"
> 
> base-commit: d98273ba77e1ab9ec755576bc86c716a97bf59d7
> 
