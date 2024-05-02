Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5F415E5B7
	for <git@vger.kernel.org>; Thu,  2 May 2024 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714679757; cv=none; b=VZ/NXENiuUlCL6Ep2y27SrU3Kl2uZOVho+TmMmdh+dv7zPMC6Ob6MYY5ay+3Fe6d5jJvKRu1rtUgQCKt3MvKpvSsb/huqcLaA2IB7kF0RTdVLvlRfllwcUUMOpQXPxa+9+5cSdyVZhlRuqR9xP+N7osR3X88Id8tyLwGg02ACLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714679757; c=relaxed/simple;
	bh=jyA2RBUrs1MibvBxLqgj4NXkh68y6PjvPPkS6rKI/lw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jonn272gMR/rahWg9/77vhMijPhZYksbRlH0FpkAsxTx3PA8gJVsZ0uvmdtKfl0AzH2xIyayznEMNX5lLMoQcn+m2SC3DLgNJLStY4WD6JwlWgaK62YoASLLJXbyu0pVtfj6iFMd9XCCZQdZpI1VUKMt/sN3KSPZBDRBfG790lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AGmYEGil; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AGmYEGil"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1D39731CFC;
	Thu,  2 May 2024 15:55:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jyA2RBUrs1Mi
	bvBxLqgj4NXkh68y6PjvPPkS6rKI/lw=; b=AGmYEGilxRQmOD8RfZWRWeI2IH9g
	k7suEWoZ50wrd6FalPcHZH9VwAUpLWfNgvFo/GJ1APgqjKkpykioVse84Kuuc6xZ
	Mh1JTMDzF4o29vlyZVLu05Er7BYLJ9JKaoxq6CGAaP3FN18RUrgm+2VtJ+eGPBr7
	5Ix3pFVWJTw0NwE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 157BC31CFB;
	Thu,  2 May 2024 15:55:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9259331CFA;
	Thu,  2 May 2024 15:55:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
  git@vger.kernel.org
Subject: Re: t4216-log-bloom.sh broken ?
In-Reply-To: <20240502192622.GA1841@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
	"Thu, 2 May 2024 21:26:22 +0200")
References: <xmqq8r0ww0sj.fsf@gitster.g> <20240502055621.GA29945@tb-raspi4>
	<xmqqsez0fbam.fsf@gitster.g> <20240502185903.GA11895@tb-raspi4>
	<20240502192622.GA1841@szeder.dev>
Date: Thu, 02 May 2024 12:55:44 -0700
Message-ID: <xmqq7cgcdm4f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F782B46A-08BD-11EF-A4B1-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> Yes, different mac, different MacOs, different $PATH probably.
>> ...
>
> 'mv' in macOS doesn't conform to POSIX, and asks for confirmation when
> the destination exists (is read-only?) even without '-i' and even when
> its stdin is not a terminal, which it won't get as its stdin in our
> test suite is redirected from /dev/null.
>
> This is a recurring issue, see e.g.:
>
>   https://public-inbox.org/git/20180616143513.10086-1-szeder.dev@gmail.=
com/
>   c20d4d702f (t1450: use "mv -f" within loose object directory, 2017-01=
-24)
>
> 'mv -f' did the trick in the past.

Hmph, while that is a good data point to explain why this one fails,
it is a very unsatisfactory workaround, compared to a world where we
do not have to worry about such a broken mv (perhaps by noticing a
broken macOS /bin/mv and automatically doing mv () { mv -f "$@" }
for them).

I am curious what other differences Torsten will find out between
good macs and bad ones.  Perhaps we can narrow down the bad apples?

