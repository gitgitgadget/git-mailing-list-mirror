Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F15626AE
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578010; cv=none; b=KglKZ8Rm1ZN+ZaJ1pTpojdM9SgSXVjzp2/OK1566DcEujn2XlLGhI6Bh8h8q8ynwy6mG6W6eJNud5HzrnFJSEyJvIT8+FI8MLnaYDjpD63S88NjnjJ8jZy60N2s00IIFrRhy6dfZ4sZgnFCqfJm5nDOQgsdbkrkSCx5H9Vr2KKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578010; c=relaxed/simple;
	bh=fndSBONmXpCqjktnd3Y9NGpzm3rH/oKumYNIckDWWss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HcoYWB3Qf+OC+x2RPeeinTla+kZpijEhMXZVCC8Tp0UX0s/h2i0BCXbSJXDY3Np0xt3jXpsBijXaurZG7GjIWtH5dqqD65YO+CwWfyMWWMQ2pqrpf24GCP9cQyeVprwKunPC4UeOawe0tN2vz75jkPYkGmO51Tg2RpTNm7TMDyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KbREXb7M; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KbREXb7M"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 502821F3868;
	Mon,  4 Mar 2024 13:46:48 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fndSBONmXpCq
	jktnd3Y9NGpzm3rH/oKumYNIckDWWss=; b=KbREXb7MDobJQ5SP3ObzBmCyg89g
	U1S/qD0jY7hNonO2gcghVzQdJaH9H+RewaUOWHr+WXpxYZG9yJZgC+ot+dTfrO1x
	WvH+e89VXe+dJcXoxOdaHch0mMEtkR/2uy/ObTe8Hi52a2mD6/00KRl3SxphmiMI
	IAs9ZqSLKRenWQk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4737F1F3867;
	Mon,  4 Mar 2024 13:46:48 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A68EF1F3866;
	Mon,  4 Mar 2024 13:46:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Christian Couder
 <christian.couder@gmail.com>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>,  Achu Luma <ach.lumap@gmail.com>
Subject: Re: [PATCH 3/3] t-ctype: do one test per class and char
In-Reply-To: <ZeYUZZ6Z8VtYnBn7@google.com> (Josh Steadmon's message of "Mon, 4
	Mar 2024 10:35:17 -0800")
References: <20240225112722.89221-1-l.s.r@web.de>
	<20240225112722.89221-4-l.s.r@web.de>
	<CAP8UFD0Wi3ot-t0Q7ruMauwj4zkMfd89Xr9SmxYa4eQ3=2VKOw@mail.gmail.com>
	<d96aaf45-f073-42d0-b69c-703393634848@web.de>
	<ZdzfYPim2SP22eeS@google.com>
	<CAP8UFD2t1KRo01eenK_RVndyVx5Vp9F4FepTgnR+mwhTGTvXnw@mail.gmail.com>
	<bd48f19b-0600-4e64-835b-98d3a97bb7f2@web.de>
	<ZeYUZZ6Z8VtYnBn7@google.com>
Date: Mon, 04 Mar 2024 10:46:46 -0800
Message-ID: <xmqq5xy1q1gp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 8E276720-DA57-11EE-B6C6-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Josh Steadmon <steadmon@google.com> writes:

> On 2024.03.02 23:00, Ren=C3=A9 Scharfe wrote:
> ...
>> I was starting the programs from t/unit-tests/bin/ individually becaus=
e
>> I didn't know 'make unit-tests' exists.  This is much nicer, thank you=
!
>> Especially after adding 'DEFAULT_UNIT_TEST_TARGET =3D unit-tests-prove=
' to
>> config.mak to complement the 'DEFAULT_TEST_TARGET =3D prove' I added l=
ong
>> ago.  It would be even nicer if the former was the default when the
>> latter is set.
>
> After js/unit-test-suite-runner [1] is merged, then using
> 'DEFAULT_TEST_TARGET =3D prove' will also run the unit tests alongside =
the
> shell test suite.
>
> [1] https://lore.kernel.org/git/cover.1708728717.git.steadmon@google.co=
m/

Nice ;-).
