Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF47C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23E4A2084C
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wq2rll3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgKBWV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 17:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgKBWV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 17:21:56 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E47C061A47
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 14:21:56 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id t22so7548694plr.9
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 14:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=z2/JX5D2gDgM33s09SWhukcj8+NBwdxFLzk1X8GzeZ8=;
        b=Wq2rll3K/ThSlMchc1YMCzwxHM/d9t2uHszfEYcuy/BNif/VBVpe9kOvlCvTGbdxbF
         btpdR/O/OrmdebEkaxDW6tL0IvNaT76mku9DNSENHvmXbQY3/GPXmxJ6R8bvgTsT7V4C
         XMcJ6PCt0d6XXMcc42AdhPxQt7Jawc3XcWOceNGfIGREJbwyaDsXjm5xLL9iq3XbbhNC
         uLM1mndbTbZ5UEABVhWUcOFIwvmAxIp2a8WvxHP/PWLnAqelUgN2F6gVQPx9yqPqeL/e
         Bol6RLuK0SCHPd64MzEn1ivy2o1hmsj1r2+TTCPgK+l+WwZjt9TN6gfBqe29NBMcvw1J
         D0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=z2/JX5D2gDgM33s09SWhukcj8+NBwdxFLzk1X8GzeZ8=;
        b=bYLQUOAhB3+JS5aZywUrl/XXDTeOW0cDCwx7puidomNBbcLYEE0Ep9JoXoeI3V406W
         BEX67gqOsowgsUvj6qz59ujmJ+zSWGwrih/kxjWY825foMRJq36+DZ2Q0p7fuXPMeJv3
         yK/bwLoQgtgd7FNB47cM5HmmGKalI5ycCIWxCvbU4RxyK9pchHyFoeji0VJwa/xf4jjn
         bVl0gKfB/iHcfK/EiE3SWxlxcid9RIJ4eifTPbK0katFK/KrGJ+kCYHepHBxmEjJSjTT
         5KQl7ZIo1MkpYA63yxfQJkgjiUSxDxrSkbgYXeE/VoIB4M2EHlWaHLmbejpM8k1BtT40
         g5fQ==
X-Gm-Message-State: AOAM531LPTqUTmcTHYeWt8FyEzHGQjvcMCkAlccSM4azlzbCelNIXxIg
        +L9AK9scGRC4fB1rXuZyIb14MEEa4CzUcA==
X-Google-Smtp-Source: ABdhPJxIMmTpWvpzwWG1C4GRKB5ICIaoGwU/5KtZDXhDiFOCS4CaKs6BgAi6cGBJ/ssQKszU6HqBTQ==
X-Received: by 2002:a17:902:d386:b029:d6:ad06:d4c6 with SMTP id e6-20020a170902d386b02900d6ad06d4c6mr14265183pld.31.1604355716182;
        Mon, 02 Nov 2020 14:21:56 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
        by smtp.gmail.com with ESMTPSA id q5sm473446pjj.26.2020.11.02.14.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 14:21:55 -0800 (PST)
Date:   Mon, 2 Nov 2020 14:21:50 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] upload-pack.c: fix a sparse warning
Message-ID: <20201102222150.GB1904687@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <eaf5ac83-af3f-5028-3a9e-1669c9cde116@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaf5ac83-af3f-5028-3a9e-1669c9cde116@ramsayjones.plus.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.10.31 21:04, Ramsay Jones wrote:
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Josh,
> 
> If you need to re-roll your 'js/trace2-session-id' branch, could you please
> squash this into the relevant patch (commit edb21a501e, "upload-pack, serve:
> log received client trace2 SID", 29-10-2020).
> 
> Thanks!
> 
> ATB,
> Ramsay Jones

Fixed in V2, thanks!

>  upload-pack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/upload-pack.c b/upload-pack.c
> index b7d097bf1b..2996b8083c 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1111,7 +1111,7 @@ static void receive_needs(struct upload_pack_data *data,
>  		if (data->allow_filter &&
>  		    parse_feature_request(features, "filter"))
>  			data->filter_capability_requested = 1;
> -		if ((arg = parse_feature_value(features, "trace2-sid", &feature_len, 0)))
> +		if ((arg = parse_feature_value(features, "trace2-sid", &feature_len, NULL)))
>  		{
>  			char *client_sid = xstrndup(arg, feature_len);
>  			trace2_data_string("trace2", NULL, "client-sid", client_sid);
> -- 
> 2.29.0
