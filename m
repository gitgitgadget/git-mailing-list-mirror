Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E09AC433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 17:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239777AbiGSR7c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 13:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbiGSR7b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 13:59:31 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8F7491F8
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 10:59:30 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-10d6ddda695so5006347fac.0
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 10:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CEvmGkZlGLBZvAZ5B0OuEvDtmnOcbO8fGbfIpVC+9Bo=;
        b=djFqFt0VMdUqwaom8GJkWpC/guwP8Y6RXUB1vJ0qzUqdguqTo2rPS4hzYRFUf2kuCK
         QhwteuSQA84oBz8IqJyosaBausO9r/4/7GrlJUHbr/3DQ8TcZWPLRv2SUI5boEn+13wJ
         xJMICiO+jnpGGM4i2QLp8cVECuDgIrPPGCXPUnyt0t2iXz6IE6SzF29tsobcsLxJmEEJ
         Fnq35aYq6EmONw85bv2Qb5WTpgtBxNToxBA5UDeegH8CTMeKrlaKHqlnifpZlmYITNjh
         kSTS7Mk021Ze7mUVwUdfEacVvX1/RoBSQExnoMX4I7d0cR0uUHEqSI6e787yzNzvF5jS
         e+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CEvmGkZlGLBZvAZ5B0OuEvDtmnOcbO8fGbfIpVC+9Bo=;
        b=OTt9Uc+gvPRYGnkZEEOSBa81uEvImXq1fx9dX/Aq35kPTqzH1VvYM+f3G5tp01+TsI
         dDX5cUsdtUQx7r5qMmWUFk6Rqkd72LPlD+AzNWPqRhwCrST7cJeWdvAIjWgNBYVVc0Cz
         dcSk9xBA9qzW5yEG9Aw/lpz+gLvK64CXY/qBzxKaz487Jo5t/HYpRBL1u177/wtEXo7z
         7MIsbddKtfDlZMpIKvj6ZIi3bX3759eUpSDHGcIVYW0UN+vbeSuYJVhvcF7ATiw1eT6A
         whOEK1bjrBtHTPAMDo95ekLraKua6kmTes74laY9dMNGim5+OVojOIVIm5kOm0Za41Ia
         kzgg==
X-Gm-Message-State: AJIora9t5+idXnPaXh2eGLX3SgR10r3v9YkZrjsjCggiLjJ1psarMabq
        cb+9VYEWpO0DErcmAX157XUUzVQVuXIL
X-Google-Smtp-Source: AGRyM1uLAt2gmrqNkzhnVOwLmqpOe/bN/0kLb0r57ca+CXfGL4WyP4X3AsjiPx0OSy+8apNa8hs2Iw==
X-Received: by 2002:a05:6870:819b:b0:10b:f881:e605 with SMTP id k27-20020a056870819b00b0010bf881e605mr343706oae.153.1658253569594;
        Tue, 19 Jul 2022 10:59:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3950:7a99:4a4a:8622? ([2600:1700:e72:80a0:3950:7a99:4a4a:8622])
        by smtp.gmail.com with ESMTPSA id i16-20020a4ad390000000b00435a4c8e3c2sm1781589oos.40.2022.07.19.10.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 10:59:29 -0700 (PDT)
Message-ID: <95263c88-6894-87bb-4d52-84d8d1cc5671@github.com>
Date:   Tue, 19 Jul 2022 13:59:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 4/7] mv: check if <destination> is a SKIP_WORKTREE_DIR
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220719132809.409247-5-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220719132809.409247-5-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/19/2022 9:28 AM, Shaoxuan Yuan wrote:
> Originally, <destination> is assumed to be in the working tree. If it is
> not found as a directory, then it is determined to be either a regular file
> path, or error out if used under the second form (move into a directory)
> of 'git-mv'. Such behavior is not ideal, mainly because Git does not
> look into the index for <destination>, which could potentially be a
> SKIP_WORKTREE_DIR, which we need to determine for the later "moving from
> in-cone to out-of-cone" patch.
> 
> Change the logic so that Git first check if <destination> is a directory
> with all its contents sparsified (a SKIP_WORKTREE_DIR). If yes,
> then treat <destination> as a directory exists in the working tree, and

"treat <destination> as a directory exists in the working tree" is a bit
akward, and the rest of the sentence struggles with that. Starting with
"If yes," we could rewrite as follows:

  If <destination> is such a sparse directory, then we should modify the
  index the same way as we would if this were a non-sparse directory. We
  must be careful to ensure that the <destination> is marked with 
  SKIP_WORKTREE_DIR.

(Note that I don't equate this as doing the same thing, just operating on
the index.)

> If no, continue the original checking logic.

I think this part doesn't need to be there, but I don't feel strongly
about it.

> Also add a `dst_w_slash` to reuse the result from `add_slash()`, which
> was everywhere and can be simplified.

>  	else if (!lstat(dest_path[0], &st) &&
>  			S_ISDIR(st.st_mode)) {
> -		dest_path[0] = add_slash(dest_path[0]);
> -		destination = internal_prefix_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
> +		destination = internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BASENAME);

Hm. I find it interesting how this works even if the directory is _not_
present in the index. Is there a test that checks this kind of setup?

	git init &&
	>file &&
	git add file &&
	git commit -m init &&
	mkdir dir &&
	git mv file dir/

Locally, this indeed works with the following 'git status' detail:

        renamed:    file -> dir/file

>  	} else {
> -		if (argc != 1)
> +		if (!path_in_sparse_checkout(dst_w_slash, &the_index) &&
> +		    !check_dir_in_index(dst_w_slash)) {
> +			destination = internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BASENAME);
> +			dst_mode |= SKIP_WORKTREE_DIR;

Looks like we are assigning dst_mode here, but not using it. I wonder if
you'll get a compiler error if you build this patch with DEVELOPER=1.

You can test all of the commits in your series using this command:

  git rebase -x "make -j12 DEVELOPER=1" <base>

> +	if (dst_w_slash != dest_path[0])
> +		free((char *)dst_w_slash);

Good that you are freeing this here. You might also want to set it to NULL
just in case.

Thanks,
-Stolee
