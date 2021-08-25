Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2678C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 14:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 963D961073
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 14:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241642AbhHYO1X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 10:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241691AbhHYO1T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 10:27:19 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C60C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 07:26:31 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id f22so17608868qkm.5
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 07:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kGUnOOVT2Rx/hXSpoXPBzDr4CkDqr5DNxn3UVUSdeA8=;
        b=QFwobi9Yd79on2N+oLOz3aEFtH737Q91uPvKxOVy/xGttFqgKTCHdlKhiwk1TcQPAA
         hFIGEcznDaEYWdj8tS8enJHfMmUsiAp4q2g916dotT6E1cfk6GdS2l3y5y49rE/aK1ag
         ORumNBIwhHINEOJTDRiOjuiTl9oaTpwbJ4zKmOnC96SQBDOmpzUekswTrZn+dMq+C0mV
         xNuw++VfpxtDZbpFzVg7suRdUMLfMB+qPXjuSPjsyoekqi8zjcsoMMK3/6IpK5o2huO7
         gfUhdomD2nutfN7NfkYJpK31SUePRHv2Tee+yyuFQ8B8tXO1Qfrow5xUC5Su8xLiDNJo
         1n+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kGUnOOVT2Rx/hXSpoXPBzDr4CkDqr5DNxn3UVUSdeA8=;
        b=pxZlXB0HqG+2wyUq1oSuOVbmpoTDExWKfn39Fm8s3DzyIN0Hhn18ckXG8ieV5bmLH2
         L+/IyORnh9Qpb0RDn9wJiiNlvYbxdTdqdZlt2z9x/LAlf07iKM7v+enZxzKwRtk4VTCB
         fp4JaQRdUyyp6zTp+inIgCC7IrUrKT4szw7Za6ka+EE+zLou0hNJ+B80vwM1CYP7FzHA
         Zo+3APWqP9FEwaLXCDzMtMVrUlTOQrntjUpj5VGrr+pPV1YQ2TKpFoCVv/OjujcmyOHS
         22B7D+UmFxRA3iEM3H60780pFCwHJqIW4CsrNBG+LB+BKFJZTwzKAmV+UFWLUTmUOVQJ
         N1cg==
X-Gm-Message-State: AOAM532h3E530cxpDGAhjawlWo2LdAMBKxWV54KtnjJVlwCQGEkH85ix
        3kaU1lGSq8bmRGVJWN6pmBs=
X-Google-Smtp-Source: ABdhPJy7b6GxBgoRKhyJYiFKF4GHx5SecV3DwTURdz8rcArefWaUWfxALtD9k5U2+mgRyrJsI5qhEw==
X-Received: by 2002:a05:620a:1298:: with SMTP id w24mr31539401qki.61.1629901590327;
        Wed, 25 Aug 2021 07:26:30 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:6d81:bb65:3870:d879? ([2600:1700:e72:80a0:6d81:bb65:3870:d879])
        by smtp.gmail.com with ESMTPSA id i6sm9445946qti.30.2021.08.25.07.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 07:26:29 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] fetch: merge fetching and consuming refs
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <cover.1629452412.git.ps@pks.im> <cover.1629800774.git.ps@pks.im>
 <31d9f72edf5c178b2e80c30bb7c0a9bc164ca5eb.1629800774.git.ps@pks.im>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <439cb382-a4d0-18ad-5475-0cb29fba98e7@gmail.com>
Date:   Wed, 25 Aug 2021 10:26:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <31d9f72edf5c178b2e80c30bb7c0a9bc164ca5eb.1629800774.git.ps@pks.im>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/24/2021 6:37 AM, Patrick Steinhardt wrote:
> -		if (ret) {
> -			transport_unlock_pack(transport);
> -			return ret;
> -		}
> +		if (ret)
> +			goto out;

You were just reorganizing this method in the previous patch.
This "goto out" trick could have applied there instead, which
wouldn't complicate that patch and would simplify this one.

But perhaps it would look strange to have the following ending
to the method, even if for only one patch:

	return 0;

out:
	transport_unlock_pack(transport);
	return res;
}

So, feel free to ignore me here. Decide based on your taste.

>  	}
>  
> -	/*
> -	 * Keep the new pack's ".keep" file around to allow the caller
> -	 * time to update refs to reference the new objects.
> -	 */
> -	return 0;
> -}
> -
> -/* Update local refs based on the ref values fetched from a remote */
> -static int consume_refs(struct transport *transport, struct ref *ref_map)
> -{
> -	int connectivity_checked = transport->smart_options
> +	connectivity_checked = transport->smart_options
>  		? transport->smart_options->connectivity_checked : 0;
> -	int ret;
> +
>  	trace2_region_enter("fetch", "consume_refs", the_repository);
>  	ret = store_updated_refs(transport->url,
>  				 transport->remote->name,
>  				 connectivity_checked,
>  				 ref_map);
> -	transport_unlock_pack(transport);
>  	trace2_region_leave("fetch", "consume_refs", the_repository);

This transport_unlock_pack() is leaving the trace2 region. I think
it is unlikely that the loop of unlink_or_warn() calls will take
significant time that affects this region, so it should be fine to
move it.

> +
> +out:
> +	transport_unlock_pack(transport);
>  	return ret;
>  }
...
> -	if (!fetch_refs(transport, ref_map))
> -		consume_refs(transport, ref_map);
> +	fetch_and_consume_refs(transport, ref_map);
>  
>  	if (gsecondary) {
>  		transport_disconnect(gsecondary);
> @@ -1610,7 +1600,7 @@ static int do_fetch(struct transport *transport,
>  				   transport->url);
>  		}
>  	}
> -	if (fetch_refs(transport, ref_map) || consume_refs(transport, ref_map)) {
> +	if (fetch_and_consume_refs(transport, ref_map)) {

The end goal of making these consumers simpler is worth it.

Thanks,
-Stolee
