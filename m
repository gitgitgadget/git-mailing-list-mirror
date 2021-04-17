Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D928C433ED
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 21:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7DC06100B
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 21:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbhDQViK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 17:38:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50427 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237106AbhDQViJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 17:38:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85EA9D0078;
        Sat, 17 Apr 2021 17:37:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+zUEGchbwLpi
        vm/S8S/G6yk6fj4=; b=ilUTBNuAShsJ5BHuwJM4oqt/dohQzdXOSmF1FPWZM65C
        eK2DOdq4bapCb2D/6Mnn6S5WSlRDu6p4MDV6AkIEkSGZblnfTQC8Ll755dFhgXNn
        BtRy5GWZOrNmmWtTfZhQbG7YvshJqLOdJAiEj8sWkUyZTG4uMwEfpam7v2SoUu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=jdTIeM
        DJwzGd5xg67Pqan2pDKVLnsuY237YXFRpI3LhKplqmRia9SFUbTH7p6gRJfW/kch
        SXh1NXbb9JjiSa3Qo+1Qigh6t30ZCcT6fRsxyw/HxvRyn78mXh664rkfO6YCCUhw
        5xGDTqyquwTOj5anX6ZzCF2HNvGga60+Rc8+s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C4C9D0077;
        Sat, 17 Apr 2021 17:37:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DE52DD0076;
        Sat, 17 Apr 2021 17:37:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/3] config: rename `git_etc_config()`
References: <cover.1618238567.git.ps@pks.im> <cover.1618297711.git.ps@pks.im>
        <34bdbc27d618d7467d2caf6844d8c06bdcb8545b.1618297711.git.ps@pks.im>
        <20210416211451.GP2947267@szeder.dev>
        <YHqf9zjSzpYl7IAW@coredump.intra.peff.net>
Date:   Sat, 17 Apr 2021 14:37:39 -0700
In-Reply-To: <YHqf9zjSzpYl7IAW@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 17 Apr 2021 04:44:39 -0400")
Message-ID: <xmqq7dl0d23g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 22FCAC78-9FC5-11EB-B008-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Apr 16, 2021 at 11:14:51PM +0200, SZEDER G=C3=A1bor wrote:
>
>> > @@ -1883,6 +1880,7 @@ static int do_git_config_sequence(const struct=
 config_options *opts,
>> >  				  config_fn_t fn, void *data)
>> >  {
>> >  	int ret =3D 0;
>> > +	char *system_config =3D git_system_config();
>> >  	char *xdg_config =3D xdg_config_home("config");
>> >  	char *user_config =3D expand_user_path("~/.gitconfig", 0);
>> >  	char *repo_config;
>> > @@ -1896,11 +1894,10 @@ static int do_git_config_sequence(const stru=
ct config_options *opts,
>> >  		repo_config =3D NULL;
>> > =20
>> >  	current_parsing_scope =3D CONFIG_SCOPE_SYSTEM;
>> > -	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_O=
K,
>>=20
>> Removing git_config_system() from the condition breaks
>> GIT_CONFIG_NOSYSTEM:
>
> Good catch. My gut feeling is that the new git_system_config() should
> check NOSYSTEM and return NULL if it's set, and then we can get rid of
> git_config_system() entirely.

NULL -> /dev/null I guess?

> That is slightly different than the old behavior; right now
> GIT_CONFIG_NOSYSTEM only prevents reading during the normal sequence,
> and not reading (or writing!) via "git config --system". But I think it
> would be an improvement to prevent those (the whole point of the featur=
e
> was to avoid the test suite accidentally accessing the larger
> environment).

Yup.
