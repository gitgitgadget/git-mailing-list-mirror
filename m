Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C47C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 08:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiKCIi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 04:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiKCIi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 04:38:28 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCADB8
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 01:38:21 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id f27so3350568eje.1
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 01:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DAxhhp6L3GdfAqe6QvwWsLqeuDk7hhchhaFo3GvRlX8=;
        b=khBKItWk2bOq7A2S/ba+mYieCokQmrkJkb3YTvYmsOA8tfPJG/rW1asR3AroyFrGCZ
         sMWE7BthfrClm/H270Si2xRtOH5nJLktTuCLvaHSMbm4wxo5I0UxSIfu/txbgSbVx+Qo
         aYvFxJlpkNQJETAwc7sk8x4YVAzSSE5UmdIvL8CZRsYvQr24HCuviGhjgB2KaatbCd0y
         Ua5Hyo54aUf7SLLegzRM5n9Lq06zqS+YlCbI3cbDYYeiNa/5Yj0TXVFNFDoZIknh6hwM
         6K2ICRGXhj9G+1HfmQIr+Lyo7kj+iG4buRKRl02UIC7FfbvPd3Ev7fxucig1gnM9V+xf
         rQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAxhhp6L3GdfAqe6QvwWsLqeuDk7hhchhaFo3GvRlX8=;
        b=sWsyGT6yM2xvYOQLeJO62dkSO/sHCnhofkf7h7O6EXCMFVbxVAokpvjIhgBjcbnlpU
         vbyGrGrV4FPUQZ3VURJJxKeEJ9neYB8NMcvN/n9pJkQd4u+srjwIyQqeDrDNpo6+9FVI
         MS/3ct5LUJd9pvWVtKIu7oF8P+x+3qjCSjF+k/n8taqVM8SCZis2T/Ujg3HRV3WFQlEH
         wuGDARVNAzOQi8itr8m9M9K0YmQt/JHN9ny4+GsU25hM6BI3DVmwQnTBx7Xe8vzHOqSq
         tJhYoaMHn+usChlAsb+3fxJ3wrQdyup6Az8QcZfJZrEgfDmwF01Cz35anlgOvZ5Xk32z
         f81A==
X-Gm-Message-State: ACrzQf0gv1p5cvIuULQFuXYaEdLOSZylY4MhCq2uU9xkoU/otPkzYnHj
        Sm+JO3a7TGUr3kxQdz/ciLf8XpoC0+w=
X-Google-Smtp-Source: AMsMyM7q5Eb7Ro8GddqSIDfsggG7NiS9/WZVBhRk0NslBUizIP644f2tlkGhs3p0N3YR5pgZ3THAbw==
X-Received: by 2002:a17:907:3f0c:b0:78e:2090:6924 with SMTP id hq12-20020a1709073f0c00b0078e20906924mr28515138ejc.332.1667464699593;
        Thu, 03 Nov 2022 01:38:19 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id bg9-20020a170906a04900b007ae1e52805dsm205408ejb.103.2022.11.03.01.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 01:38:19 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqVju-00CKKQ-0F;
        Thu, 03 Nov 2022 09:38:18 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Kyle Zhao <kylezhao@tencent.com>
Subject: Re: [PATCH v5 1/2] merge-tree.c: add --merge-base=<commit> option
Date:   Thu, 03 Nov 2022 09:36:38 +0100
References: <pull.1397.v4.git.1667292904.gitgitgadget@gmail.com>
 <pull.1397.v5.git.1667446182.gitgitgadget@gmail.com>
 <01df0d1a6a7319beada3a3a94b8e36818be2a4d2.1667446182.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <01df0d1a6a7319beada3a3a94b8e36818be2a4d2.1667446182.git.gitgitgadget@gmail.com>
Message-ID: <221103.868rks301x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 03 2022, Kyle Zhao via GitGitGadget wrote:

> From: Kyle Zhao <kylezhao@tencent.com>

> [...]
> +test_expect_success 'specify merge-base as parent of branch2' '
> +	# Setup
> +	git init base-b2-p && (

It's good practice to nuke it after the test:

	test_when_finished "rm -rf base-b2-p" &&
	git init base-b2-p



> +		cd base-b2-p &&
> +		test_commit c1 file1 &&
> +		test_commit c2 file2 &&
> +		test_commit c3 file3
> +	) &&

Could avoid the subshell-ing with:

	test_commit -C base-b2-p c1 file1 &&
	[...]

	

> +	# Testing
> +	(
> +		cd base-b2-p &&
> +		TREE_OID=$(git merge-tree --write-tree --merge-base=c2 c1 c3) &&

Ditto sub-shell.

> +
> +		q_to_tab <<-EOF >expect &&
> +		100644 blob $(git rev-parse c1:file1)Qfile1
> +		100644 blob $(git rev-parse c3:file3)Qfile3
> +		EOF
> +
> +		git ls-tree $TREE_OID >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_done

