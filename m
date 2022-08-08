Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B658C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 09:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbiHHJQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 05:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbiHHJQT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 05:16:19 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61D9DF59
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 02:16:18 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z17so10147373wrq.4
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 02:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=NBKrb3t+YU9p59vrYdv9vzaN8EjM5sOPV4npoYaBvM8=;
        b=NjtK/xAvM8/9pyfW44QZZCP2oo1bunfuCyQuVqYDoQy/8pDv7juLTgiSKUR33D9E3t
         mTO50wfxUbC+P5x1LjtMVrBIZ46yfOrzCHciF4yj+V9eDFr2XyQ4YepuvqPM5bfr2Ic0
         RJbDaNWBKvFm8ErVJBrOrObFIL4x1KTv4IJiQzB+vgF7x+Z/XkLZ/hlFK6JN/Cmwq6MW
         QTyVivZbccLMcmjUlO4BVci9x1tL16SJKR1g9Ec+GP+nX19cVrskRL0gCA0Mm60kBiip
         WE//WZ0LXtuJ3eppS1lyROQbFfUDXdIz5eSL889KsM9a4W1Ns65x3VrP6YWuWRrcPMbM
         Teqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=NBKrb3t+YU9p59vrYdv9vzaN8EjM5sOPV4npoYaBvM8=;
        b=tEfKdYAHlzQx17GaHXtK9Vrc/OkwHFwWwFvxmj/4YEuttM2DLPM4Cx4ifbwrmb7AbN
         1g35l0VyvAW9C/QykGZ9wbJawby+UIk/xzXV2E39uapGBPIDPpxeNuki+W0wMyE9duMa
         pGSwUEJkYMUNXiODkLd9/XnqPBWgWU4/byvUmCBuorEmMFTE5PgV9eIvrYY3xfs/ttLN
         7YWWSwTmX9v3wXzg0qdEbrAh1xhhhuB9oezVjDWMHGL9zHL/hCE0+UxwqZwgoYvjhTeD
         9CHA7tPaTBVaOPQwzkbkdh41z1ZjW1RqGQc5sYhAzXt7yKPaxNDXAIB91S3POBKmg/JB
         q6gw==
X-Gm-Message-State: ACgBeo1inGRpkug3yr2UVTNdBsN7IX2Sk3/9nptGJaZZ8ReSrWU2gkxZ
        /wQFoIfcLdYaZjQr+Iwvu0WHhLrDny4=
X-Google-Smtp-Source: AA6agR4rbP94eDBZV6cpff8vIzpKs0ArVunOxE0ifewpaKzq/wTg5l25lKcXSqw2NZ/otVN7DmGpBg==
X-Received: by 2002:a5d:6c6b:0:b0:1ea:77ea:dde8 with SMTP id r11-20020a5d6c6b000000b001ea77eadde8mr10956894wrz.690.1659950177437;
        Mon, 08 Aug 2022 02:16:17 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id m8-20020a5d56c8000000b00222d4dfcdffsm1345788wrw.87.2022.08.08.02.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 02:16:17 -0700 (PDT)
Message-ID: <00a58dbb-32e8-98dd-6c72-235e9c33af3b@gmail.com>
Date:   Mon, 8 Aug 2022 10:16:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 5/6] transport: add client support for object-info
Content-Language: en-GB-large
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
References: <20220502170904.2770649-1-calvinwan@google.com>
 <20220728230210.2952731-6-calvinwan@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220728230210.2952731-6-calvinwan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin

On 29/07/2022 00:02, Calvin Wan wrote:
> diff --git a/transport.c b/transport.c
> index 52db7a3cb0..2d503e2fbd 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -363,10 +437,12 @@ static int fetch_refs_via_pack(struct transport *transport,
>   			       int nr_heads, struct ref **to_fetch)
>   {
>   	int ret = 0;
> +	size_t i;
>   	struct git_transport_data *data = transport->data;
>   	struct ref *refs = NULL;
>   	struct fetch_pack_args args;
>   	struct ref *refs_tmp = NULL;
> +	struct ref *object_info_refs = xcalloc(1, sizeof (struct ref));

When git is compiled with SANITIZE=address then one of the cat-file 
tests added in patch 6 fails with an out of bounds access. The problem 
is that the last member of struct ref is a flexible array that is 
expected to contain a NUL terminated string but we don't allocate any 
memory for the string here. We could just add one to the size of the 
allocation but as there is a dedicated allocation function it would be 
better to use alloc_ref("").

I think it would also be worth delaying this allocation until we're sure 
it is going to be needed.

>   	memset(&args, 0, sizeof(args));
>   	args.uploadpack = data->options.uploadpack;
> @@ -392,8 +468,25 @@ static int fetch_refs_via_pack(struct transport *transport,
>   	args.server_options = transport->server_options;
>   	args.negotiation_tips = data->options.negotiation_tips;
>   	args.reject_shallow_remote = transport->smart_options->reject_shallow;
> -
> -	if (!data->got_remote_heads) {
> +	args.object_info = transport->smart_options->object_info;
> +
> +	if (transport->smart_options && transport->smart_options->object_info) {
> +		struct ref *ref = object_info_refs;
> +
> +		if (!fetch_object_info(transport, data->options.object_info_data))
> +			goto cleanup;

If we allocate object_info_refs and initialize ref here then we avoid 
allocating it when it is not needed.

> +		args.object_info_data = data->options.object_info_data;
> +		args.quiet = 1;
> +		args.no_progress = 1;
> +		for (i = 0; i < transport->smart_options->object_info_oids->nr; i++) {
> +			struct ref *temp_ref = xcalloc(1, sizeof (struct ref));

This needs to use alloc_ref("") as well

> +			temp_ref->old_oid = *(transport->smart_options->object_info_oids->oid + i);

This would be clearer as ...oids->oid[i] I think

Best Wishes

Phillip
