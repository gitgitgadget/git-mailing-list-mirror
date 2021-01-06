Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80829C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 23:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DD4A2313E
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 23:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbhAFXqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 18:46:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60936 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbhAFXqg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 18:46:36 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 58E34B4AD0;
        Wed,  6 Jan 2021 18:45:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dHMizQgmqw7C
        UH+AKNWFUb44gwg=; b=LSiHNq5z6oMo5+nyu6Zeb/e7FEWJRO0xQuXfMws4bmfS
        n5Kk6rY38cKC3z5AOtA9IgXtPlZz9AQoAAFQp59xKAVDg7ykN/0l6nfEDH58ojDJ
        tfzms/uvFVs+W8eI9nan9V4Sw+IE8Gh2KoaCzNZr0MctrDyM2GJig0iech6Hf+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=gTSHZT
        aQnO45OSpxWQsXehqBb+0La1i92sEbw30OdYjj0Wd/Izca6RyhPT6VHzlsl1SunY
        IK5a/OOVqlyFSAhmEGhabk5zy2ppVHRHKo9SVYa5Tzi5MU6JgniETzL+MwMNSAdU
        Kl6lA/x9KSrwqM6v5a+P6yXkFBR4IM9SqbNLE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EE53B4ACF;
        Wed,  6 Jan 2021 18:45:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C65BAB4ACE;
        Wed,  6 Jan 2021 18:45:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Matthew DeVore <matvore@google.com>,
        git@matthieu-moy.fr, olyatelezhnaya@gmail.com,
        samuel.maftoul@gmail.com, Johannes.Schindelin@gmx.de,
        karthik.188@gmail.com, pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com
Subject: Re: [PATCH 3/5] ref-filter: add a "detached_head_first" sorting option
References: <9bd85516f91c3e2fdefdafd51df71f75603e51f6.1560895672.git.matvore@google.com>
        <20210106100139.14651-4-avarab@gmail.com>
Date:   Wed, 06 Jan 2021 15:45:50 -0800
In-Reply-To: <20210106100139.14651-4-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 6 Jan 2021 11:01:37 +0100")
Message-ID: <xmqqy2h5oci9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4F6781C0-5079-11EB-938E-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +static int compare_detached_head(struct ref_array_item *a, struct ref_=
array_item *b)
> +{
> +	if (a->kind & FILTER_REFS_DETACHED_HEAD)
> +		return -1;
> +	else if (b->kind & FILTER_REFS_DETACHED_HEAD)
> +		return 1;
> +	BUG("compare_detached_head() is guarded by an xor on [ab]->kind & FIL=
TER_REFS_DETACHED_HEAD");
> +	return 0;
> +}

OK.

> +void ref_sorting_detached_head_first_all(struct ref_sorting *sorting, =
int flag)
> +{
> +	for (; sorting; sorting =3D sorting->next)
> +		sorting->detached_head_first =3D !!flag;
> +}

This, taken together with existing ref_sorting_icase_all(), looks
somewhat ugly, especially when you ponder how you would add a third
similar option to the mix.

Perhaps "ignore_case" and "detached_head_first" shouldn't be
separate bitfields, but bits in the same flag word member in the
"struct ref_sorting", and "set/unset these flags to all the sort
ops" helper function should just take a flags word that has two
bits?

Or maybe it is good enough for now.  I hesitate to say so myself,
though, after already saying it is "somewhat ugly" ;-)

>  void ref_array_sort(struct ref_sorting *sorting, struct ref_array *arr=
ay)
>  {
>  	QSORT_S(array->items, array->nr, compare_refs, sorting);
> diff --git a/ref-filter.h b/ref-filter.h
> index feaef4a8fde..3b92e0f2696 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -30,6 +30,7 @@ struct ref_sorting {
>  	int atom; /* index into used_atom array (internal) */
>  	unsigned reverse : 1,
>  		ignore_case : 1,
> +		detached_head_first : 1,
>  		version : 1;
>  };
> =20
> @@ -111,6 +112,8 @@ int verify_ref_format(struct ref_format *format);
>  void ref_array_sort(struct ref_sorting *sort, struct ref_array *array)=
;
>  /*  Set the ignore_case flag for all elements of a sorting list */
>  void ref_sorting_icase_all(struct ref_sorting *sorting, int flag);
> +/*  Set the detached_head_first flag for all elements of a sorting lis=
t */
> +void ref_sorting_detached_head_first_all(struct ref_sorting *sorting, =
int flag);
>  /*  Based on the given format and quote_style, fill the strbuf */
>  int format_ref_array_item(struct ref_array_item *info,
>  			  const struct ref_format *format,
