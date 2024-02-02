Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1548F63AD
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 01:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706836823; cv=none; b=n/rhpXb8Q3PbNs8uHFH5Cue157EoUkrnmxDRFWLY98QPBQR+JoSFNPPE1NgHJWNQ7M3tJYhc6Lnt32VF6AyXQjulXJoHaHodvqtCUhoSZZJkuCnC8CxRUxbqZjzJu04VRLi3Ee4LveIKvKMDSuGIHk4fH+yuhSnaLr0jAG4ZtI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706836823; c=relaxed/simple;
	bh=xp0Anz7prJBTcqj6OsH/uDU/1WEbnFb9YGTdbfjcoT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F2qze/ON3VqMFPc9CwoHSztxxANDZHE1D8jInhC0wg052DB6NAiFje2jZVbIpzUo5YwKZrPHjSDTbYz/X7OeafkY0H/Jy0ZePEcl7FJxjPwMg/v6Mv2J2zt3oEwVX2DKiJPojzD11LQLXalKLhGNJZynr5vMLZrTb0iiJCYR/2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pz0S1R65; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pz0S1R65"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 67AFB1E3CB5;
	Thu,  1 Feb 2024 20:20:20 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xp0Anz7prJBT
	cqj6OsH/uDU/1WEbnFb9YGTdbfjcoT4=; b=Pz0S1R65/FCr16ZplAXlFYS3qoJ7
	P8WQVczzQrSYBSCuCOhvfz5BW4VkI66TndoqQHXTL4frqx2XM6X1u4FoyHeepDBQ
	fwePQ7AxgiCsKKHhb8eMnZ4OCmRT9QRfvI7zsERJVlr9uJ7ZQaY4z/ef1Bn03+rz
	RphZYKVHliXNR1A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F7D21E3CB4;
	Thu,  1 Feb 2024 20:20:20 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BFED01E3CB3;
	Thu,  1 Feb 2024 20:20:19 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,  Adam Dinwoodie
 <adam@dinwoodie.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/3] some unit-test Makefile polishing
In-Reply-To: <20240130053714.GA165967@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 30 Jan 2024 00:37:14 -0500")
References: <20240129031540.GA2433764@coredump.intra.peff.net>
	<20240130053714.GA165967@coredump.intra.peff.net>
Date: Thu, 01 Feb 2024 17:20:18 -0800
Message-ID: <xmqqh6irwtkd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 3AD89294-C169-11EE-8AA8-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> writes:

> On Sun, Jan 28, 2024 at 10:15:40PM -0500, Jeff King wrote:
>
>> The patches fixes two small hiccups I found with the unit-tests. Neith=
er
>> is a show-stopper, but mostly just small quality-of-life fixes.
>
> And here's another iteration based on the feedback from v1. It uses the
> mkdir_p template mentioned by G=C3=A1bor, fixes the $(X) issue mentione=
d by
> Patrick, and adds a new patch to handle the directory in "make clean".
>
> No range diff, as range-diff refuses to admit that the patches are
> related (presumably because even though the changes are small, the
> original patches were also tiny).
>
>   [1/3]: Makefile: use mkdir_p_parent_template for UNIT_TEST_BIN
>   [2/3]: Makefile: remove UNIT_TEST_BIN directory with "make clean"
>   [3/3]: t/Makefile: get UNIT_TESTS list from C sources

Merging this topic seems to stop all "win test (n)" jobs at GitHub
CI, which is puzzling (I would have understood a broken build, but
that is not what we are seeing).

https://github.com/git/git/actions/runs/7748054008 is a run of 'next'
that is broken.

https://github.com/git/git/actions/runs/7748547579 is a run of 'seen~1'
with this topic reverted (the ps/reftable-backend topic is excluded),
which seems to pass.

Does it ring a bell, anybody?

Thanks.
