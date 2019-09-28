Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D68B11F463
	for <e@80x24.org>; Sat, 28 Sep 2019 03:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfI1DlA (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 23:41:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53707 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfI1DlA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Sep 2019 23:41:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0234D879B4;
        Fri, 27 Sep 2019 23:40:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=g+MXSTZMxNqj
        ruc/1Nm+emL9Qwc=; b=thQRHXdtIItCZMWBPKcjYavQaFoQTGH40erSqhJI+rTR
        IKnmLuhheWzvQOkbAMWzmlVkdiiJl9DBoR0W1pfb50lsWVGUuSv0pI5txLrdtA6h
        MqPZOeapocbhrYFjtM2ME3OFw7Y0PLnNhehosBEIXSzFPC5d5sQLuqlX82VV8os=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=TptZ4e
        tbabohxTg8CykMLnMWe1YjuGWrbiuKTwAAyd9Ldt5ZMD4Hu/GBWqu/d7TpDWntMz
        HqGZOiVsp7gIXAWEEh7PIpeZXMMSmiJ+ozcWkd0mDsxSUVkB4JGMGgiyqrJY++lj
        /U0ai2/H/kq8Iimn9GLkUFXpoRL2wyNdS1iv4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EED27879B3;
        Fri, 27 Sep 2019 23:40:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 29678879B1;
        Fri, 27 Sep 2019 23:40:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, williamtbakeremail@gmail.com,
        stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH v2 1/6] midx: add MIDX_PROGRESS flag <snip>
References: <pull.337.git.gitgitgadget@gmail.com>
        <pull.337.v2.git.gitgitgadget@gmail.com>
        <6badd9ceaf4851b2984e78a5cfd0cb8ec0c810f5.1568998427.git.gitgitgadget@gmail.com>
        <20190921121104.GA6787@szeder.dev>
Date:   Sat, 28 Sep 2019 12:40:52 +0900
In-Reply-To: <20190921121104.GA6787@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Sat, 21 Sep 2019 14:11:04 +0200")
Message-ID: <xmqqlfu9krzv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C6BE86EE-E1A1-11E9-A676-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Fri, Sep 20, 2019 at 09:53:48AM -0700, William Baker via GitGitGadge=
t wrote:
>> diff --git a/midx.h b/midx.h
>> index f0ae656b5d..e6fa356b5c 100644
>> --- a/midx.h
>> +++ b/midx.h
>> @@ -37,6 +37,8 @@ struct multi_pack_index {
>>  	char object_dir[FLEX_ARRAY];
>>  };
>> =20
>> +#define MIDX_PROGRESS     (1 << 0)
>
> Please consider using an enum.

If they are used by assiging one of their values, definitely a good
idea to use an enum.  Are debuggers clever enough that they can
tell, when they see something like this:

	enum gress {
		PROGRESS =3D 1,
		REGRESS =3D 2,
	};

	void func(enum gress v);

	...

        void caller(void)
	{
		func(PROGRESS | REGRESS);
		func(PROGRESS + REGRESS);
		func(PROGRESS * 3);
	}

how caller came about to give 3?
