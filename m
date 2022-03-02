Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B4EC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 20:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244423AbiCBUsA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 15:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244310AbiCBUr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 15:47:56 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889B36BDF5
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 12:47:11 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id i6-20020a4ac506000000b0031c5ac6c078so3345744ooq.6
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 12:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GHhHmiS9Z+o8d/K0nt2QRVQqviO1azuz/+BeHdR6UIM=;
        b=dgQqIkadEACgsmKXAzwDfK08mcsPpu8V8ThygDu8220gbRLTnO3ooFnc0BTGk8jcyN
         jP9vq55JUO23Duu6HExZs+xRmksCG+psZY0Qa2E2J5sj47cid3yEQK4UmFhdB2yMYfn+
         MxGU/uhB+xPDWlXFNUT0CIEKn8H3kZqfqdPgMqG1fYgT2wrD/hmTjxr2nuBGHBgorZeT
         ImYGTPptHr25rOXabD9ukzNPOgkilG7puy9BFkGwMVZdAfs8xgOtY5n9yQhQkn+vIadX
         OfQMYq6YSguPp5aq3LFpfFjZ/lVcfPXAj4d+yNhpkmcsTxCUq+K9GRTrwDoiOvG1lt00
         /Dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GHhHmiS9Z+o8d/K0nt2QRVQqviO1azuz/+BeHdR6UIM=;
        b=Dwfp6JHYVnoA13V3uCfZWXJOi/y3LSNF4+L9hflaUMe5sXckGZ2I419U27HIszkyOK
         /F6NfH/B+34vBHlaYYePjIb/PHpBrqCTJUr7CfFKm5TlIFCyjVoSxv+NQJwiK5mx/jCw
         1o6QXRBHcV8Tj00KrHMyfY0zobzUNc2mB9f9P2fi57yBmOYY+jZPkqA3pNRamCA1WokH
         DzZ5io7r9aqkLfhKTk15eAzefz+hPNS6u3+a9drpxx9tTUsaQ+ok1sT3LZjGGUEh5551
         8w/3CCSauq5ufyN4NL6nLQq+z4z9zVHRPv5Ptym3t3D0o5oe4pxcv9Bwj4/mtuJHudG0
         p0YQ==
X-Gm-Message-State: AOAM530yxKeAhImzCtyTopFplMfC2YqHCG2R+YqZ61ww7Bco8ZYmoOlJ
        GxeAbNJGuKySw3uvw4/RqG0JBp/cvU0R
X-Google-Smtp-Source: ABdhPJymHSILcXRUkuThAXuSs9SukO8J2+R0C0PbW/xXUezvbPl8LfhmKRoOQy/hJ4rmqE2luSdxuQ==
X-Received: by 2002:a05:6820:188f:b0:31c:f277:b473 with SMTP id bm15-20020a056820188f00b0031cf277b473mr16349562oob.51.1646254030865;
        Wed, 02 Mar 2022 12:47:10 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id r14-20020a056870e98e00b000d43a8c3065sm76810oao.28.2022.03.02.12.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 12:47:10 -0800 (PST)
Message-ID: <dfa87840-e04b-972f-2468-f7f0afa0ad61@github.com>
Date:   Wed, 2 Mar 2022 15:47:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 07/14] transport: stop needlessly copying bundle header
 references
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
 <patch-07.14-be62ca89bf5-20220302T170718Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-07.14-be62ca89bf5-20220302T170718Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/2/2022 12:10 PM, Ævar Arnfjörð Bjarmason wrote:
> Amend the logic added in fddf2ebe388 (transport: teach all vtables to
> allow fetch first, 2019-08-21) and save ourselves pointless work in
> fetch_refs_from_bundle().
...
> +static void get_refs_from_bundle_inner(struct transport *transport)
> +{
> +	struct bundle_transport_data *data = transport->data;
> +
> +	if (data->fd > 0)
> +		close(data->fd);
> +	data->fd = read_bundle_header(transport->url, &data->header);
> +	if (data->fd < 0)
> +		die(_("could not read bundle '%s'"), transport->url);
> +
> +	transport->hash_algo = data->header.hash_algo;
> +}
> +

There are some subtle changes here that look odd, but it actually
could present a behavior change.

>  static struct ref *get_refs_from_bundle(struct transport *transport,
>  					int for_push,
>  					struct transport_ls_refs_options *transport_options)
> @@ -136,15 +149,7 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
>  	if (for_push)
>  		return NULL;
>  
> -	data->get_refs_from_bundle_called = 1;
> -
> -	if (data->fd > 0)
> -		close(data->fd);
> -	data->fd = read_bundle_header(transport->url, &data->header);
> -	if (data->fd < 0)
> -		die(_("could not read bundle '%s'"), transport->url);
> -
> -	transport->hash_algo = data->header.hash_algo;
> +	get_refs_from_bundle_inner(transport);

The implementation of get_refs_from_bundle_inner() is very close
to these deleted lines, except you removed

	data->get_refs_from_bundle_called = 1;

and instead you added this change:

> -	if (!data->get_refs_from_bundle_called)
> -		get_refs_from_bundle(transport, 0, NULL);
> +	if (!data->get_refs_from_bundle_called++)
> +		get_refs_from_bundle_inner(transport);

So, this is checking to see if data->get_refs_from_bundle_called
_was_ zero while also incrementing it. However, this member is
an unsigned:1, so you're really toggling it on and off each time
we reach this 'if' statement.

Using this "++" would still bother me stylistically, even if the
type was uint64_t and the risk of overflow was minimal. If you
put the "= 1" line into the inner method, then things go back to
working as they did before.

Thanks,
-Stolee
