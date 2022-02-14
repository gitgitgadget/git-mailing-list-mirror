Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169FBC433EF
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 15:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355975AbiBNPuO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 10:50:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355969AbiBNPuN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 10:50:13 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41835FF0B
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 07:50:04 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id o5so15108110qvm.3
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 07:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EUQ9mKVPVRjYtjX0beQ/C6KT7eJ0UTSna5WhdRUYTHs=;
        b=WA82xWa8D6wx54Jj/SKGhS6ANJEpkwQufRWnhFFQBEAKB79P0u+co2q8lOwgFT/ZJm
         6Bbow8wc5yVqdNSMM33bN7q0WF+zTSQ9n8hrYxsOEMgMJaJABlfR2sG6grWjhPEAgOQl
         xPn6nCk2YqLJBY1XH3psBC796NP6LW673ZwGOeZkLQlqHLTaCuM0mg1iza02mn5F8mH+
         N6Y6crd9BvXO98to3hfV1vq/alDaTy2Xlzc4dQNxmaDuA2cXEDSnMldbXa4r1u9D+3GT
         F9wwTDwbJZL9EK7VoE53vdVZPaqgRBaejx2425+PyGLV9lafKl2FehmyQ9avCve+WYQl
         80vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EUQ9mKVPVRjYtjX0beQ/C6KT7eJ0UTSna5WhdRUYTHs=;
        b=lW0ykmDNdZI+JSVfusOpFf1EanVWB6fn5oxhogIxeuFUJcMox515VFkrX2vu4flv7J
         BUlyh+cLBBPxHbgdcTemY2lQpyiw9mDIBpu1yXTjxo7ql5fA/L4TImLCjUTD8HxbK1Rg
         zfj3HjdwF+0NmkiWPj41PKYPRwVWrJoImojT3NJcuk7NXOwGWP3ICzytGt3QfclNalw0
         hcd9rSGQplvemG3XwiBYHOjJstx8VwcmoQGv1v+V2P45e1Fi6F9hnbg0+lBAE35jI8JY
         YadAKKwBtMTrZQYaF8PsWRcqb1My1/XpS3yfBpnOg0UtA0hwn4z76l1mfqmU6Qxinenf
         QPQw==
X-Gm-Message-State: AOAM530j38OnpWuDQkQtQG+iqiTZhP5lsZlicsnYxIBrluJ2Xs4VDvjP
        sXO51ymoCGC21bJ0RxQqir2b
X-Google-Smtp-Source: ABdhPJybj+UYMTWrjxr7SoLTq0Zjm5jnmNFXuo6lKRY0Mg5M5dIGIZbn2632WS1fPe8rthGivEfsEg==
X-Received: by 2002:a05:6214:5199:: with SMTP id kl25mr348351qvb.10.1644853803961;
        Mon, 14 Feb 2022 07:50:03 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:eccf:bfbc:c638:47f4? ([2600:1700:e72:80a0:eccf:bfbc:c638:47f4])
        by smtp.gmail.com with ESMTPSA id s1sm18068049qta.0.2022.02.14.07.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 07:50:03 -0800 (PST)
Message-ID: <b97d569c-3b5a-a2c8-cdf5-08d74406a29e@github.com>
Date:   Mon, 14 Feb 2022 10:49:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 3/7] sparse-checkout: pay attention to prefix for {set,
 add}
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
 <679f869ff11b5c3e61081018f7eafa81c334f3d1.1644712798.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <679f869ff11b5c3e61081018f7eafa81c334f3d1.1644712798.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/12/2022 7:39 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> In cone mode, non-option arguments to set & add are clearly paths, and
> as such, we should pay attention to prefix.
> 
> In non-cone mode, it is not clear that folks intend to provide paths
> since the inputs are gitignore-style patterns.  Paying attention to
> prefix would prevent folks from doing things like
>    git sparse-checkout add /.gitattributes
>    git sparse-checkout add '/toplevel-dir/*'
> In fact, the former will result in
>    fatal: '/.gitattributes' is outside repository...
> while the later will result in
>    fatal: Invalid path '/toplevel-dir': No such file or directory
> despite the fact that both are valid gitignore-style patterns that would
> select real files if added to the sparse-checkout file.  However, these
> commands can be run successfully from the toplevel directory, and many
> gitignore-style patterns ARE paths, and bash completion seems to be
> suggesting directories and files, so perhaps for consistency we pay
> attention to the prefix?  It's not clear what is okay here, but maybe
> that's yet another reason to deprecate non-cone mode as we will do later
> in this series.
> 
> For now, incorporate prefix into the positional arguments for either
> cone or non-cone mode.  For additional discussion of this issue, see
> https://lore.kernel.org/git/29f0410e-6dfa-2e86-394d-b1fb735e7608@gmail.com/

Perhaps this was covered in the issue, but for non-cone mode, it
matters if there is a leading slash or not in the pattern. Will
this change make it impossible for a user to input that distinction?

Will there still be a difference between:

	git sparse-checkout set --no-cone /.vs/

and

	git sparse-checkout set --no-cone .vs/

?

> Helped-by: Junio Hamano <gitster@pobox.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>

This could probably use a

  Reported-by: Lessley Dennington <lessleydennington@gmail.com>

> +static void sanitize_paths(int argc, const char **argv, const char *prefix)
> +{
> +	if (!argc)
> +		return;
> +
> +	if (prefix && *prefix) {
> +		/*
> +		 * The args are not pathspecs, so unfortunately we
> +		 * cannot imitate how cmd_add() uses parse_pathspec().
> +		 */
> +		int i;
> +		int prefix_len = strlen(prefix);
> +
> +		for (i = 0; i < argc; i++)
> +			argv[i] = prefix_path(prefix, prefix_len, argv[i]);
> +	}
> +}
> +
>  static char const * const builtin_sparse_checkout_add_usage[] = {
>  	N_("git sparse-checkout add (--stdin | <patterns>)"),
>  	NULL
> @@ -708,6 +726,8 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
>  			     builtin_sparse_checkout_add_usage,
>  			     PARSE_OPT_KEEP_UNKNOWN);
>  
> +	sanitize_paths(argc, argv, prefix);
> +
>  	return modify_pattern_list(argc, argv, add_opts.use_stdin, ADD);
>  }
>  
> @@ -759,6 +779,8 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
>  	if (!core_sparse_checkout_cone && argc == 0) {
>  		argv = default_patterns;
>  		argc = default_patterns_nr;
> +	} else {
> +		sanitize_paths(argc, argv, prefix);
>  	}

Code changes appear to do as described: apply the prefix everywhere
it matters, no matter the mode.

> +test_expect_success 'set from subdir pays attention to prefix' '
> +	git -C repo sparse-checkout disable &&
> +	git -C repo/deep sparse-checkout set --cone deeper2 ../folder1 &&
> +
> +	git -C repo sparse-checkout list >actual &&
> +
> +	cat >expect <<-\EOF &&
> +	deep/deeper2
> +	folder1
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'add from subdir pays attention to prefix' '
> +	git -C repo sparse-checkout set --cone deep/deeper2 &&
> +	git -C repo/deep sparse-checkout add deeper1/deepest ../folder1 &&
> +
> +	git -C repo sparse-checkout list >actual &&
> +
> +	cat >expect <<-\EOF &&
> +	deep/deeper1/deepest
> +	deep/deeper2
> +	folder1
> +	EOF
> +	test_cmp expect actual
> +'
> +
>  test_done

These tests could use a non-cone-mode version to demonstrate the behavior
in that mode.

Thanks,
-Stolee
