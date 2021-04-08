Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F08DC433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 18:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23900610FC
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 18:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhDHSg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 14:36:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56994 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHSg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 14:36:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CE334115670;
        Thu,  8 Apr 2021 14:36:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rCwg3UlRqWWn
        pjFDXaf1MR4aDW8=; b=ClYv6st7Pm+NOs0ByuFW+5sDuj9WxtA50PpN3REp1J5I
        1ERfwtsKhKjoByyxiNE+M7k/7QEAcwzvxIbstZ+uEmMA4+05lX9T3QrWzDLSDHCK
        OG4f1dLFFJNTLBjHPVZ1dMXiBm/sviLVIo1jFcH5Ll0+mmdTDPcnZHdEXkE/iZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=IDeIn+
        z3LjlNFh5Gt+NO/z1hnKoCuFrxsD6X/H7tv4vLgweWrwc3+8KS1yzzGBEPrlWx/K
        XrbKVooOzoELH1JCGPuihDtOCvBCMTrMFAiEQAW2PgclN9LGs8GE8YDzwOJdWHzc
        FCernoB43W6Ukn9mDV3NdE6ox8GMsojgX+Orc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C6BC411566F;
        Thu,  8 Apr 2021 14:36:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2008311566D;
        Thu,  8 Apr 2021 14:36:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lin Sun <lin.sun@zoom.us>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 5/5] config: add --type=bool-or-auto switch
References: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
        <patch-5.6-9f8996a888-20210408T133125Z-avarab@gmail.com>
Date:   Thu, 08 Apr 2021 11:36:11 -0700
In-Reply-To: <patch-5.6-9f8996a888-20210408T133125Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 8 Apr
 2021 15:34:29 +0200")
Message-ID: <xmqq5z0wtyhw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4BA4D1BA-9899-11EB-A09F-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Now that we're using git_config_tristate() internally let's expose it
> via "git config" like we do "bool", "int" etc for completeness, and so
> that we can easily test it.
>
> Unlike the --type=3Dbool-or-str option added in dbd8c09bfe (mergetool:
> allow auto-merge for meld to follow the vim-diff behavior, 2020-05-07)
> we don't have or anticipate any in-tree user of this except the tests.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>

OK.


> @@ -263,6 +267,12 @@ static int format_config(struct strbuf *buf, const=
 char *key_, const char *value
>  				strbuf_addstr(buf, value_);
>  			else
>  				strbuf_addstr(buf, v ? "true" : "false");
> +		} else if (type =3D=3D TYPE_BOOL_OR_AUTO) {
> +			int v =3D git_config_tristate(key_, value_);
> +			if (v =3D=3D 2)
> +				strbuf_addstr(buf, "auto");
> +			else
> +				strbuf_addstr(buf, v ? "true" : "false");

Makes sense.

> +test_expect_success 'there is no --bool-or-auto, --<type> is deprecate=
d in favor of --type=3D<type>' '
> +	test_expect_code 129 git config --bool-or-auto
> +'
> +
> +test_expect_success 'get --type=3Dbool-or-auto' '
> +	cat >.git/config <<-\EOF &&
> +	[bool]
> +	true1
> +	true2 =3D true
> +	false =3D false
> +	[int]
> +	int1 =3D 0
> +	int2 =3D 1
> +	int3 =3D -1
> +	[string]
> +	string1 =3D hello
> +	string2 =3D there you
> +	[auto]
> +	auto1 =3D auto
> +	auto2 =3D AUTO
> +	[bad-auto]
> +	bad-auto1 =3D AUTOMATIC
> +	EOF
> +	cat >expect <<-\EOF &&
> +	true
> +	true
> +	false
> +	false
> +	true
> +	true
> +	auto
> +	auto
> +	EOF

Almost the same comment applies to the expected output as the
earlier patch.

Other than that, (and adjusting for 2 that should be turned into
symbolic constant in an earlier step in a reroll), this step looks
quite sensible.

Thanks.

> +	{
> +		git config --type=3Dbool-or-auto bool.true1 &&
> +		git config --type=3Dbool-or-auto bool.true2 &&
> +		git config --type=3Dbool-or-auto bool.false &&
> +		git config --type=3Dbool-or-auto int.int1 &&
> +		git config --type=3Dbool-or-auto int.int2 &&
> +		git config --type=3Dbool-or-auto int.int3 &&
> +		git config --type=3Dbool-or-auto auto.auto1 &&
> +		git config --type=3Dbool-or-auto auto.auto2
> +	} >actual &&
> +	test_cmp expect actual &&
> +
> +	test_must_fail git config --type=3Dbool-or-auto --get bad-auto.bad-au=
to1 2>err &&
> +	grep "bad tristate config value" err
> +'
> +
>  cat >expect <<\EOF
>  [bool]
>  	true1 =3D true
