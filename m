Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C80C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 14:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F80820786
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 14:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFJzBX/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgHYOde (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgHYOdb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 10:33:31 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92A7C061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 07:33:30 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k18so7491599pfp.7
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 07:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iK8mPfVOOmZKvrNfgbAuTqeL7ojHrkJLWKZtqx4DuYc=;
        b=QFJzBX/S0vJnP50DYfH5Lm10stVXsYLZhJHzM0u4AEQRAK+5xPY+tBG0zReEtr/VPl
         ozOFc+VPjrYVBtiP6i0857X1MBYapIbf+rvsaXgJUssDwqT9jeQXOvTRlhYCZHa3rXji
         tv3yPJ0uwuLQtJXeLG5JCJeDvLvE1G2W7oT6rMGk+p6DBoS5yEcZiYquYBfGe06aELHH
         MmGM8xq6VNPMewAbyljoTRYvtzc9Hkf0hKzKWulWxaz/awIXGQzLgm1Ly9fJta29kQI2
         4+g0ewsy527OZJ96o0zUisr30WFjWe+mee11nsrGBH/4lGYmdTy3Fes7hPYv+caVc7dn
         ebWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iK8mPfVOOmZKvrNfgbAuTqeL7ojHrkJLWKZtqx4DuYc=;
        b=KRdLrRrOL4kDIO04RszgHl8jzGIYw5hO22t51kSiLW8Bt5P52Erl3ElIOvPsKGPIuk
         zpDcO2tqnGZ43jyPjWbXyW7LcNCai3UWs5LFfqBJPRP8GZ55ca8WkaWz1JYC8riUyWoX
         6TlQwdWHTlhNJybbISA0gljCoTj3LUmmPrgQojrDRvd4Zf5xqglphQcJR24tgbH5vbsv
         CG2aMSvQwCSzjYrpLjPx9mRiv/GyTP5s3/ldk0difBHtikZNqJf3TfMMEfn+cmj0Jql6
         nuxYaBDme244i8SgXZFt/Rvw1YvronrfU42y6+cd51z94ChXolyrJTNBSo1gj4KjD/D9
         d7vQ==
X-Gm-Message-State: AOAM530uQ/jRrCNcnTvy/rxV+Ux8PhZuW1aKKRZvt83a5QY57CjbqMCa
        cpjhBb1nzRnUCxnj3rs6CAo=
X-Google-Smtp-Source: ABdhPJyPD/jKsT/4Y8eG4YWM4Z7WWjPgLLLN6zynBzRr/yUmnKL9zIYKKDcT7rBVhwykfsprigsA/g==
X-Received: by 2002:a63:6d4c:: with SMTP id i73mr4828738pgc.63.1598366010350;
        Tue, 25 Aug 2020 07:33:30 -0700 (PDT)
Received: from [192.168.208.37] ([49.205.78.114])
        by smtp.gmail.com with ESMTPSA id n12sm16593854pfj.99.2020.08.25.07.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 07:33:29 -0700 (PDT)
Subject: Re: [PATCH 3/3] t7421: eliminate 'grep' check in t7421.4 for mingw
 compatibility
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, peff@peff.net, liu.denton@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>
References: <20200825113020.71801-1-shouryashukla.oo@gmail.com>
 <20200825113020.71801-4-shouryashukla.oo@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <2a1ea501-4974-4d74-fe3c-d173bbe76855@gmail.com>
Date:   Tue, 25 Aug 2020 20:03:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825113020.71801-4-shouryashukla.oo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25-08-2020 17:00, Shourya Shukla wrote:
> The 'grep' check in test 4 of t7421 resulted in the failure of t7421 on
> Windows due to a different error message
> 
>     error: cannot spawn git: No such file or directory
> 
> instead of
> 
>     fatal: exec 'rev-parse': cd to 'my-subm' failed: No such file or directory
> 
> Tighten up the check to compute '{src,dst}_abbrev' by guarding the

The change only affects `src_abbrev`. So, it's misleading to mention
`dst_abbrev` here.

> 'verify_submodule_committish()' call using `p->status !='D'`, so that
> the former isn't called in case of non-existent submodule directory,
> consequently, there is no such error message on any execution
> environment.
> 
> Therefore, eliminate the 'grep' check in t7421. Instead, verify the
> absence of an error message by doing a 'test_must_be_empty' on the
> file containing the error.
> 
> Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Helped-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  builtin/submodule--helper.c      | 7 ++++---
>  t/t7421-submodule-summary-add.sh | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 93d0700891..f1951680f7 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1035,7 +1035,7 @@ static void print_submodule_summary(struct summary_cb *info, char *errmsg,
>  static void generate_submodule_summary(struct summary_cb *info,
>  				       struct module_cb *p)
>  {
> -	char *displaypath, *src_abbrev, *dst_abbrev;
> +	char *displaypath, *src_abbrev = NULL, *dst_abbrev = NULL;

Unlike `src_abbrev`, I don't think we need to initilialize `dst_abbrev`
to NULL here as it would be assigned in all code paths.

>  	int missing_src = 0, missing_dst = 0;
>  	char *errmsg = NULL;
>  	int total_commits = -1;
> @@ -1061,8 +1061,9 @@ static void generate_submodule_summary(struct summary_cb *info,
>  	}
>  
>  	if (S_ISGITLINK(p->mod_src)) {
> -		src_abbrev = verify_submodule_committish(p->sm_path,
> -							 oid_to_hex(&p->oid_src));
> +		if (p->status != 'D')
> +			src_abbrev = verify_submodule_committish(p->sm_path,
> +								 oid_to_hex(&p->oid_src));
>  		if (!src_abbrev) {
>  			missing_src = 1;
>  			/*

-- 
Sivaraam
