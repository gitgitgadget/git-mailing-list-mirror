Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95121279331
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382944; cv=none; b=qAvfuPw57vxOQ641xwBnyeff+Hbo9lhFZO7Chz5P3EO+kR1oghqhghBhUbQNbx3l4gMF29l2p245Vj05j+oDBUzuRFlNYXEGQ+hbYjB8Q7GsKDFU512XJmon2Ot7+KDap0a5I3ZcAsF0wiab3awGXvUTu2L+hvrMcBmsNzCWcXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382944; c=relaxed/simple;
	bh=iOnuISAkRWY9LHI61SA5IjfN+n058Cn91qzl3A/odbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGtLqgsxJopVE/Q1xk9G9qJmiYqoD3dTolNSbpLGbS9Iyz9SIGe4sDI5d8YasoLUNfddIZ4Qt3GaF33hSDH1jp+edtOMjEqXNW6u1vEcqYi7PMvSuU+kuhdMsK5rRZAUHqYe5hORcILKgg5Awrs5I1cufV94nYtUo8Q2Hkk8sFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=XZXQLdaO; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="XZXQLdaO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751382931; x=1751987731; i=l.s.r@web.de;
	bh=jbkNpYNM4JkElcixo5hQagc3mhaicRmqMCAf71V59+Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XZXQLdaOYFn7LCzvLXEygmWtwAlF4rDKWXk5ei2q8C8dUcbIbgQxbNsJGjuL0bXf
	 pfzqNU+ryqAqVYGm1kCW7g5aniUJer/tmtwJoBUMlQXr/q8CDwwJ6qHH6K7Avl4cA
	 3sIFznSoMaIhLePwN+Tz9PpbUPtpR4mO6is6dDyL6hDqFWgLFiX2lKyLpW3K47vhu
	 P5jKt1qAcovpXBSX48qbZf1M2eRPFfwr028W3O3XnGpvcbCGT5cUvLfKd8pPtXiSm
	 IA9MG20UmNgpl52PO0A7BvHaH4zyx1eDd7LFMGBM6st3orFuIA1A8B7c+4c1jUCm3
	 C5yRl8AJgimzJEGrtA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Zs0-1utVCw3tfY-011XE3; Tue, 01
 Jul 2025 17:15:30 +0200
Message-ID: <e75c8da8-a859-4980-bbd7-1fb5b03a8113@web.de>
Date: Tue, 1 Jul 2025 17:15:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] parse-options: add precision handling for
 PARSE_OPT_CMDMODE
To: Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
 <d92697a6-5367-4412-88db-164ba4dd6230@web.de> <aGO-i6V6_iN678_7@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <aGO-i6V6_iN678_7@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/pwxTWX9hd16eqzSO1YCIiKXyQd9lvd3jnIXWJJU4iY9wTQOmpd
 l2XAmnNy+SaXaivU3phyH/RhH4xm5CNbyHYAoK50JPT2amb2gSW0ex0F9A2ojRP7WCtOSBC
 F+DSxXn8HZdPgPcGRw9q+QA0an+t0uUCvKDm40Zlwdl72uAirGB2pRQAY3ZVlhy9/gjx4OM
 269ndBQunC8CGXcTs5dYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zncUrFa2Yp8=;6PH2UtiL/lcDlrlZNPVodBwg7Gv
 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
 viKWgCsyJFFCHOJ+G45Q==

On 7/1/25 12:55 PM, Patrick Steinhardt wrote:
> On Sun, Jun 29, 2025 at 01:50:31PM +0200, Ren=C3=A9 Scharfe wrote:
>> Build on 09705696f7 (parse-options: introduce precision handling for
>> `OPTION_INTEGER`, 2025-04-17) to support value variables of different
>> sizes for PARSE_OPT_CMDMODE options.  Do that by requiring their
>> "precision" to be set and casting their "value" pointer accordingly.
>=20
> Makes sense.
>=20
>> get_value() needs to access all PARSE_OPT_CMDMODE values in addition to
>> the actual value it is supposed to get to detect conflicting changes.
>> Give it an example struct option pointer in cmdmode_list instead of jus=
t
>> the "value" pointer to allow it to use the proper "precision".
>>
>> Use optbug() in get_int_value() to report options with unsupported
>> "precision" values without requiring enum opt_parsed flags, as we don't
>> have them in build_cmdmode_list().  Use BUG right afterwards to abort
>> for uses outside of build_cmdmode_list() by aborting immediately.
>=20
> Hm. I have a bit of a hard time understanding these two paragraphs, to
> be honest. Might be that my brain is still in vacation mode.

Or it might be my needing-a-vacation mode.

get_value() checks all PARSE_OPT_CMDMODE value variables.  It does that
to detect changes to such a variable by non-PARSE_OPT_CMDMODE options.
"All" sounds grand, but actual commands only have at most a single
PARSE_OPT_CMDMODE value variable.  But they could have many more.
Anyway, the patch gives it a struct option so that it can use the
proper precision when dereferencing value, a void pointer.

optbug() calls the macro "bug".  It reports a bug just like BUG, but
does not abort.  It's intended for cases where we want to report all the
bugs that we can find instead of forcing developers to fix them one by
one and recompile in between.  That would be nice in
build_cmdmode_list().  I still force an abort by following it with BUG,
though, because handling invalid "precision" values would be tedious
in the other callers.

>=20
>> @@ -280,19 +297,18 @@ static void build_cmdmode_list(struct parse_opt_c=
tx_t *ctx,
>> =20
>>  	for (; opts->type !=3D OPTION_END; opts++) {
>>  		struct parse_opt_cmdmode_list *elem =3D ctx->cmdmode_list;
>> -		int *value_ptr =3D opts->value;
>> =20
>> -		if (!(opts->flags & PARSE_OPT_CMDMODE) || !value_ptr)
>> +		if (!(opts->flags & PARSE_OPT_CMDMODE) || !opts->value)
>>  			continue;
>> =20
>> -		while (elem && elem->value_ptr !=3D value_ptr)
>> +		while (elem && elem->reference_opt->value !=3D opts->value)
>>  			elem =3D elem->next;
>=20
> Hm. Previously we checked for the pointers to be equal, now we check for
> the value to be equal. Are we sure that this is always equivalent? Can't
> it ever be that two elements might have the same value?

The "value" member of struct option is a void pointer.  We still compare
pointers here.

Ren=C3=A9

