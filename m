Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE70C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 16:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbiCCQWC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 11:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiCCQWB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 11:22:01 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62803199D5D
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 08:21:15 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x5so7265190edd.11
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 08:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ZJ5+pmy3quqDV0/547XEmy+CG95mrq2iTz0btjGWHdQ=;
        b=WnlzsE66jB+g+dzJ0ZvvFj/VrNMB++bkLVhtRXQVTTH2/fWy3jwYgsp9WX/bzQb1MI
         UlKMUrGkNeQMtSyF+AgF0KUNv1r32XyTYi6t83IqgfQ2KNugrqEMkPk39kZpC7CUXORS
         GcLzF+hnNNQv7BjP4HDp4INQ92p9YzRcnhVVJTsdHu2cQeHbmm+thP85XsqdXsedyqWH
         2KPsi50VZ10W6dQ1j7lPZqE2iCdSJ2LPzq7hr6OqbevqxZtlXHIsd5wZZ7qR33RPKpbm
         N2ajg6PGBAVJbuUOWEQxhQLdv84L82LsEPrFU5n3cW8ICM6VZSCGtCR8nIIwd7azrE4r
         GIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ZJ5+pmy3quqDV0/547XEmy+CG95mrq2iTz0btjGWHdQ=;
        b=Dx65hQaY0EQH4Xt5VvQ3V4sDMw+6DxFPFIv+D5DJRBAKno8QdPeQ+jNtPnfxEUgykb
         iBtpmYnf6ZxSO3TockFHvBbsL8KOQTJRb1+Gj4mfhhUygBQWRO5S2DNFpZNiuPOcYKAt
         PKDxYEk3eEOOtEOhh4iaOrpD+IjrwcREyGwEReHUeAyNTRd5fjn3xEBfAJRIeISTiaxv
         NwWx3Dufh3oDiNJ/FFSCTqObaA9AR4rF/k3sQ2aqCQp+D+7ExqiLDyo/yLuLoeQMj/VZ
         VXl/QK9F+T/Iq112U+t1kYmxPsN0kgadZNCjBu2mOE4vdoCYjeyArcnFBsvtq22FQIoP
         Rbcg==
X-Gm-Message-State: AOAM530+F6zpfRCX7ZUdDv4OAbGFNXJXOYxYDQ4Demcp0qKR60FTA5Qw
        i17Fc7hmInNCYrcigXi3gVuBQWALyzxKQw==
X-Google-Smtp-Source: ABdhPJy9rDttdZDXtRk1hq3b0e/UCqqnt9gQUgNI8e5P6Ux57v2ucbxRUTsWqo7laNjh9rx70URwAw==
X-Received: by 2002:a05:6402:68e:b0:415:d29e:dfe8 with SMTP id f14-20020a056402068e00b00415d29edfe8mr4980724edy.351.1646324473693;
        Thu, 03 Mar 2022 08:21:13 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7c0c2000000b00412b6b79d1asm1023801edp.10.2022.03.03.08.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 08:21:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPoCW-000dS8-5j;
        Thu, 03 Mar 2022 17:21:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/14] transport: stop needlessly copying bundle header
 references
Date:   Thu, 03 Mar 2022 17:20:49 +0100
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
 <patch-07.14-be62ca89bf5-20220302T170718Z-avarab@gmail.com>
 <dfa87840-e04b-972f-2468-f7f0afa0ad61@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <dfa87840-e04b-972f-2468-f7f0afa0ad61@github.com>
Message-ID: <220303.86mti72eiv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 02 2022, Derrick Stolee wrote:

> On 3/2/2022 12:10 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Amend the logic added in fddf2ebe388 (transport: teach all vtables to
>> allow fetch first, 2019-08-21) and save ourselves pointless work in
>> fetch_refs_from_bundle().
> ...
>> +static void get_refs_from_bundle_inner(struct transport *transport)
>> +{
>> +	struct bundle_transport_data *data =3D transport->data;
>> +
>> +	if (data->fd > 0)
>> +		close(data->fd);
>> +	data->fd =3D read_bundle_header(transport->url, &data->header);
>> +	if (data->fd < 0)
>> +		die(_("could not read bundle '%s'"), transport->url);
>> +
>> +	transport->hash_algo =3D data->header.hash_algo;
>> +}
>> +
>
> There are some subtle changes here that look odd, but it actually
> could present a behavior change.
>
>>  static struct ref *get_refs_from_bundle(struct transport *transport,
>>  					int for_push,
>>  					struct transport_ls_refs_options *transport_options)
>> @@ -136,15 +149,7 @@ static struct ref *get_refs_from_bundle(struct tran=
sport *transport,
>>  	if (for_push)
>>  		return NULL;
>>=20=20
>> -	data->get_refs_from_bundle_called =3D 1;
>> -
>> -	if (data->fd > 0)
>> -		close(data->fd);
>> -	data->fd =3D read_bundle_header(transport->url, &data->header);
>> -	if (data->fd < 0)
>> -		die(_("could not read bundle '%s'"), transport->url);
>> -
>> -	transport->hash_algo =3D data->header.hash_algo;
>> +	get_refs_from_bundle_inner(transport);
>
> The implementation of get_refs_from_bundle_inner() is very close
> to these deleted lines, except you removed
>
> 	data->get_refs_from_bundle_called =3D 1;
>
> and instead you added this change:
>
>> -	if (!data->get_refs_from_bundle_called)
>> -		get_refs_from_bundle(transport, 0, NULL);
>> +	if (!data->get_refs_from_bundle_called++)
>> +		get_refs_from_bundle_inner(transport);
>
> So, this is checking to see if data->get_refs_from_bundle_called
> _was_ zero while also incrementing it. However, this member is
> an unsigned:1, so you're really toggling it on and off each time
> we reach this 'if' statement.
>
> Using this "++" would still bother me stylistically, even if the
> type was uint64_t and the risk of overflow was minimal. If you
> put the "=3D 1" line into the inner method, then things go back to
> working as they did before.

Ouch, well spotted! Will fix.
