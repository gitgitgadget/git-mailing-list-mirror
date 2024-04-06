Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4852C85C
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712405498; cv=none; b=fhRG7Z9RSJnxU3Btw1pFZQTel4upnIhlgY9lhn5/Siehjiu7sZWMnr94uxrDY3EcUOty4we/Vrx2E1S3k9JYzEQgIuLo4uYDTmR3Wrr/klQhCLG9cGFrdxecvxuE8VD/2TsQHxbjuY/0pwbRPXsqBDet08oEahhX9/8qnmv8Wyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712405498; c=relaxed/simple;
	bh=p3slL3tdTLMiOLOWcVlOOtA8r/mgCf1jZDWm6pUvl/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PzeeVQrlQKcPC2V+v6V3A1xGPiVuC6OH8ls39ml/zCHItus/IggoZEZeI4ZQdn9etHlSS/77tLrgnJxFK+ZsITOOlmatcBPIkSRRRNOUYuyZzJ+n2AdJJETG+VYrEtMWFVb+rEt0o8jJuZSC/d1BoQR7CLIcxYV39LSUM/7Gesw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=q5oluWTG; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q5oluWTG"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E7912BB04;
	Sat,  6 Apr 2024 08:11:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=p3slL3tdTLMi
	OLOWcVlOOtA8r/mgCf1jZDWm6pUvl/0=; b=q5oluWTG9NXVJ2EgcA5Nz57bkA4n
	8TBxUrFHDy5QDh6QfJtlj4X/tiMe22wDVavZS/2oCMSrVDGolA6Thsbe4IzF/Kmq
	/Uk9oIeXTlqMmJxdD0/FaSdE6clTvSb+ZIUVb6mTxss4x3F3VQVtg1MhODilgFke
	GcpLEk9/Vp2TdG4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6720A2BB03;
	Sat,  6 Apr 2024 08:11:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D21C02BB02;
	Sat,  6 Apr 2024 08:11:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t9604: Fix test for musl libc and new Debian
In-Reply-To: <23a4298eababe54ca4b43d7b675b858605d20ec5.1712374021.git.congdanhqx@gmail.com>
	(=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Sat, 6 Apr
 2024 10:29:10 +0700")
References: <23a4298eababe54ca4b43d7b675b858605d20ec5.1712374021.git.congdanhqx@gmail.com>
Date: Sat, 06 Apr 2024 05:11:30 -0700
Message-ID: <xmqqsezylmh9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 CE0D2A0C-F40E-11EE-AF86-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail.com> writes:

> * Note that since our tests are pre-2007, I use the old rules in the ti=
mezone.
> * We can also use IANA notations, which I believe is better, but that m=
ean we
>   will depends on IANA db

I know of the ",start[/time],end[/time]" thing tucked after the
zonename, but haven't seen it used in real life.  How confident are
you that it is widely supported?  I do understand that you saw these
current tests do fail on some platforms, but we'd want to make sure
that we are not breaking other platforms by switching.

> -test_expect_success PERL 'check timestamps are UTC (TZ=3DCST6CDT)' '
> +test_expect_success PERL 'check timestamps are UTC (TZ=3DAmerica/Chica=
go)' '
> =20
> -	TZ=3DCST6CDT git cvsimport -p"-x" -C module-1 module &&
> +	TZ=3DCST6CDT,M4.1.0,M10.5.0 \
> +	git cvsimport -p"-x" -C module-1 module &&
>  	git cvsimport -p"-x" -C module-1 module &&
>  	(
>  		cd module-1 &&

A few things curious about this hunk.

 - The test title says America/Chicago but that timezone is never
   used.  Would it make sense to actually use it for tests?

 - If not, shouldn't we at least use the actual timezone we use for
   tests?

 - Do we really want to run cvsimport twice?

> @@ -38,9 +39,9 @@ test_expect_success PERL 'check timestamps with autho=
r-specific timezones' '
> =20
>  	cat >cvs-authors <<-EOF &&
>  	user1=3DUser One <user1@domain.org>
> -	user2=3DUser Two <user2@domain.org> CST6CDT
> -	user3=3DUser Three <user3@domain.org> EST5EDT
> -	user4=3DUser Four <user4@domain.org> MST7MDT
> +	user2=3DUser Two <user2@domain.org> CST6CDT,M4.1.0,M10.5.0
> +	user3=3DUser Three <user3@domain.org> EST5EDT,M4.1.0,M10.5.0
> +	user4=3DUser Four <user4@domain.org> MST7MDT,M4.1.0,M10.5.0
>  	EOF
>  	git cvsimport -p"-x" -A cvs-authors -C module-2 module &&
>  	(
