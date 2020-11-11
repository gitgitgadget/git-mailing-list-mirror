Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F46CC5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 14:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8525E2068D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 14:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eC0/EMKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgKKOvm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 09:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgKKOvm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 09:51:42 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0953FC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 06:51:42 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id v143so1880947qkb.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 06:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hEcY9HNchr2UipAFizlmUlabhdVaBCYjYqNcW2GwLEA=;
        b=eC0/EMKydGlIrhkNYnC87IhjoPXADhB0wpQpRoy62fcgoqEHYPLH6HBVdAdUO57hkB
         ZlZNjLtw9LM6EPV0TZdTg024PaXUkupLaj4ngwX+gkYtL9sjENrrY3DLFweqMlx0xaOa
         M5ggv7TGEC+Wf0rk6xbU2m4iRflQa9Mtv3xUjvYrZ414l5nd1Is8bHgVghz2Z3NyGJ7/
         Up6spbdV3MI3FY63oXwCGDPWCehoF9zp0lVcEHdxz6p/Ylw+K+jfNh+IfztaxzY0TtMx
         MPsXM+vV9u1ro7mTJJCMCkSyB/GOPrtp0Ap1McOj03ZGmwCpQJRVKekhQIXU0AFi9BCX
         eDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hEcY9HNchr2UipAFizlmUlabhdVaBCYjYqNcW2GwLEA=;
        b=Wg2MqNp9E6W8wgkSevkJlTsBnGy1iGc+Ar62PB45xfznc6jl/kqCJkj07LU6YQpTyx
         EwZfDkVsmz8rwzQ6GOWT2qmnl5ZxEwpajUnmwiggIFsUDzyBoSYzDXsURG/Anpw/2ESg
         7B2AfP6MipcvYrQEA5/dncR6bZCNXVvfMjCza7YC7bnqW41FRd4FkgVY6jPTxlEaivnA
         eNISp0RopixdMWKI+JwvK49g+fr3pz2WC4Q9KrXHnwLSx6ll/SrrHQu476K4Pfy93RYX
         P2uD7+MzEe2it2j9G09FN/EGYWEexvI39QsNLTB6z58wLftj5z+vlAUZTdc4eoU8Zlqy
         bdHw==
X-Gm-Message-State: AOAM531yWby44PcSMVCKlF1yBRrLGnrO5ItDzZf4A2TfR+a85lVu15yJ
        2adRu93xVZ0jYSlPtoIjve8XCNgllTLqbA==
X-Google-Smtp-Source: ABdhPJwAdpFn6VD8VxBFGZnF1V8i+BqX3kIHWC+P935pUobxDoO5kV66eFwShcg+UfaOQTT+faf35w==
X-Received: by 2002:a37:a010:: with SMTP id j16mr676481qke.347.1605106298173;
        Wed, 11 Nov 2020 06:51:38 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:c9d4:abc:8d:1568? ([2600:1700:e72:80a0:c9d4:abc:8d:1568])
        by smtp.gmail.com with UTF8SMTPSA id n41sm2464892qtb.18.2020.11.11.06.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 06:51:37 -0800 (PST)
Subject: Re: [PATCH v2 07/20] merge-ort: avoid repeating
 fill_tree_descriptor() on the same tree
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
References: <20201102204344.342633-1-newren@gmail.com>
 <20201102204344.342633-8-newren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c4b9b64c-f0a0-5824-44b9-072370cfc465@gmail.com>
Date:   Wed, 11 Nov 2020 09:51:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201102204344.342633-8-newren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/2/2020 3:43 PM, Elijah Newren wrote:
> @@ -99,6 +99,15 @@ static int collect_merge_info_callback(int n,
>  	unsigned mbase_null = !(mask & 1);
>  	unsigned side1_null = !(mask & 2);
>  	unsigned side2_null = !(mask & 4);
> +	unsigned side1_matches_mbase = (!side1_null && !mbase_null &&
> +					names[0].mode == names[1].mode &&
> +					oideq(&names[0].oid, &names[1].oid));
> +	unsigned side2_matches_mbase = (!side2_null && !mbase_null &&
> +					names[0].mode == names[2].mode &&
> +					oideq(&names[0].oid, &names[2].oid));
> +	unsigned sides_match = (!side1_null && !side2_null &&
> +				names[1].mode == names[2].mode &&
> +				oideq(&names[1].oid, &names[2].oid));

If the *_null values were in an array, instead, then all of these
lines could be grouped as a macro:

	unsigned null_oid[3] = {
		!(mask & 1),
		!(mask & 2),
		!(mask & 4)
	};

	#define trivial_merge(i,j) (!null_oid[i] && !null_oid[j] && \
				    names[i].mode == names[j].mode && \
				    oideq(&names[i].oid, &names[j].oid))

	unsigned side1_matches_mbase = trivial_merge(0, 1);
	unsigned side2_matches_mbase = trivial_merge(0, 2);
	unsigned sides_match = trivial_merge(1, 2);

I briefly considered making these last three an array, as well,
except the loop below doesn't use 'i' in a symmetrical way:

> +			if (i == 1 && side1_matches_mbase)
> +				t[1] = t[0];
> +			else if (i == 2 && side2_matches_mbase)
> +				t[2] = t[0];
> +			else if (i == 2 && sides_match)
> +				t[2] = t[1];

Since the 'i == 2' case has two possible options, it wouldn't be
possible to just have 'side_matches[i]' here.

> +			else {
> +				const struct object_id *oid = NULL;
> +				if (dirmask & 1)
> +					oid = &names[i].oid;
> +				buf[i] = fill_tree_descriptor(opt->repo,
> +							      t + i, oid);
> +			}

I do appreciate the reduced recursion here!

Thanks,
-Stolee
