Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EEB1CA9F
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708969498; cv=none; b=Hao6JvQrg0Cc24ZBBjZkuX64Av7BO0Wq3lPuVpf0wTZ8POeS5AzTHI+NDBpl8HuST01dj09F5HSrFGKX9+lUbAApB6rgUqnJau795XsCjT8/utI2QI0453zK6q/mEIB3V1aT1BaCZKQrxgVjkPyfvGcH8KKGLqPuVv7diAZh+FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708969498; c=relaxed/simple;
	bh=XZq8JBm2MaVCQT/43fhZiTwGFHBYeLfvXONFa3LsH6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SOxAxuYWPDAdlXNA+VsGkDDGwEdq4QmTpBRZlzA05ySCYVpNa6jS7e3IoE2Ss4885js0+dkoLFPZhHPDZQgqPsyTlq2vKb7RK0mejpnOhlPdY5KtKI5XD7wCXto/EjIDNNF02J2n4kiYvL3BjTm4KhEtYG7X65FR8q6wCRaZbuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=alFdHx4F; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="alFdHx4F"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7493F1B131;
	Mon, 26 Feb 2024 12:44:56 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XZq8JBm2MaVC
	QT/43fhZiTwGFHBYeLfvXONFa3LsH6E=; b=alFdHx4Ffcilm3VvbNv3HJ9ZtdQT
	gUlKhaSBGrMcsqzJWKJd91CGKFnYK5bzVwacX7sJ1E6bWQhnMFPdwlUuvqVPff3l
	XGWdL2cEXNVguEPD/Uae/QpSyjoqTCFma5m3kgWhkD4s/Gh52FrEXEVUnuW7YpkN
	gxN4COqX0kt3QDU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C4D91B130;
	Mon, 26 Feb 2024 12:44:56 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 13A2D1B12F;
	Mon, 26 Feb 2024 12:44:53 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  Phillip Wood <phillip.wood123@gmail.com>,  Josh Steadmon
 <steadmon@google.com>,  Achu Luma <ach.lumap@gmail.com>
Subject: Re: [PATCH 3/3] t-ctype: do one test per class and char
In-Reply-To: <d96aaf45-f073-42d0-b69c-703393634848@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Mon, 26 Feb 2024 18:26:48 +0100")
References: <20240225112722.89221-1-l.s.r@web.de>
	<20240225112722.89221-4-l.s.r@web.de>
	<CAP8UFD0Wi3ot-t0Q7ruMauwj4zkMfd89Xr9SmxYa4eQ3=2VKOw@mail.gmail.com>
	<d96aaf45-f073-42d0-b69c-703393634848@web.de>
Date: Mon, 26 Feb 2024 09:44:51 -0800
Message-ID: <xmqq4jdvp1bg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 BF2F5604-D4CE-11EE-93CB-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Filtering out passing checks e.g. with "| grep -v ^ok" would help when
> debugging a test failure. I vaguely miss the --immediate switch from th=
e
> regular test library, however.

Yeah, "-i" is one of the most useful switches during debugging
tests.
