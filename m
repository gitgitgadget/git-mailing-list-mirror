Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDE1C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 10:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B92CA60F43
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 10:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbhIKKNR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 06:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbhIKKNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 06:13:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5643BC061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 03:12:04 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id e21so9476367ejz.12
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 03:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=TZTIswxjepikEoPUKLpdKfzFGnuJ/8bPvUVyWcBOfmc=;
        b=PAY/OYzYQaSBEtnZ2CSkDP7aXHWPQPTjVSGlIDSvpj6aQqupwVU7M6sbu42vS4Yg76
         nhE52vP0WD8+cYkDFsu+Ub4m2nMUJVOfEI4H82APeXt57WhksyCcMlEyTOAjPM0zaQ8B
         wUuwCVCdM81oyKSa5Q9ZzbJEN1JICZ05mVmSDiG1JnQBscZeNRf31+Iy0H2E+lzns85V
         eBpnuLKHjOQuIMQKwydHGLulHro85ZJOJE7AezF9LMigW58CRFSeLcmHsChiH2sGoqPq
         y4C51WHl82kMnz8xlS0gMfnT1aJcyK5UeyblktJCBEpSGXSmQH8OWdigotCriLh56Uu9
         eefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=TZTIswxjepikEoPUKLpdKfzFGnuJ/8bPvUVyWcBOfmc=;
        b=uGXk3nkp6KhRzmr3Oio+o0Pbz5m1hjnAejr8XP+D/TRD8GzBK9Wi1z1hcIY1/wCsQD
         a19Q4xArnrv1XOkFaMjWw+pbxXt/yDSNU2xz/ClEDmErh2nEmdHJWFI+AbGWP+0EK23M
         ALGUoA78G4kGHlApOxrqFLxonqNxHH4aTAODuMK2tYBth7aOyZMy82CBsoEYrqDJiYxm
         H2W/LZtshlyN7UfLcQD+jFxUt0GH/0MrgVl1hX3xbOKwoxdquSi6tv4ysxYSgEp9TzPE
         NHS+3CmQclYvdBE/y4VSEKBwBZGGNU+sV0R+mMo36hheiV+CDLrugPIAEGXZ+c8X8/nF
         3cSw==
X-Gm-Message-State: AOAM533ZSiPu1y+hDUxFa4eKoEEFoNyNcYCN0V+9kQ7hYPQOQ5Qhu2/b
        KQiL6BNykAc0okgW/dvHAnSiv6B1o8+ihw==
X-Google-Smtp-Source: ABdhPJySkvAOHHRPX2MdPKMZnb6D+29xDEapcvDw9hvV5iGxwO5NXt8fkXS+7pQdQ/nutgPHM/LlEA==
X-Received: by 2002:a17:906:51d4:: with SMTP id v20mr2202714ejk.9.1631355122856;
        Sat, 11 Sep 2021 03:12:02 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q19sm697684edc.74.2021.09.11.03.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 03:12:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 1/8] midx: expose 'write_midx_file_only()' publicly
Date:   Sat, 11 Sep 2021 12:07:57 +0200
References: <cover.1631331139.git.me@ttaylorr.com>
 <4afa03b972a1885c60fbf3716f22a7ab58056383.1631331139.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <4afa03b972a1885c60fbf3716f22a7ab58056383.1631331139.git.me@ttaylorr.com>
Message-ID: <87a6kja0b2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 10 2021, Taylor Blau wrote:

> -		if (ctx->m && midx_contains_pack(ctx->m, file_name))
> -			return;
> +		if (ctx->m) {
> +			if (midx_contains_pack(ctx->m, file_name))
> +				return;
> +		} else if (ctx->to_include) {
> +			if (!string_list_has_string(ctx->to_include, file_name))
> +				return;
> +		}

I think this is equivalent to:

		if (ctx->m && midx_contains_pack(ctx->m, file_name))
			return;
		else if (!ctx->m && string_list_has_string(...))
			return;

Just a suggestion/tip to reduce the diff size/nested if/if blocks.


> +int write_midx_file_only(const char *object_dir, struct string_list *packs_to_include, const char *preferred_pack_name, unsigned flags);

Let's also line-wrap header changes like in the *.c file.
