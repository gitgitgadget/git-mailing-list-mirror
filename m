Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229D328F4
	for <git@vger.kernel.org>; Sun, 26 May 2024 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716751404; cv=none; b=Jr6rTUmA+w/9S8OD5mFqY1h3eXnfphsYnEFRSsDkdw3p/XRNxhcqNSrlXeuDEatAS8ihD20Pxe1W+D/utujE/SyRFlk09lMbE0Syx6fdYm1xEPrd/9TQrPtyHBxRSMEfzoGkH5jUNz+Wzh4uLXvJN5WwiDBZWN0gjuDbF0+WI78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716751404; c=relaxed/simple;
	bh=/i0xLu3/6hj5aVRiXyrKKxVpoKlRddTJyq6RZ098cbg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A/mH91zZ1lsCBQ2UejWSQNMvuj79/7AfA3ztDFueoes1aWJCcfAsMXsdGB/QSC+Y3buDCnBSVlq4/+wxBgQlcXJ1EQ0ILxsQXd2Go6ofqit7LCNlf8SCDHNwqq3wFaDOGsdo3TzAWFbVdSvoi5QPV1e++hliJ6UoLnArCR3L360=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qSq6u9Zv; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qSq6u9Zv"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C4FF3709B;
	Sun, 26 May 2024 15:23:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/i0xLu3/6hj5aVRiXyrKKxVpoKlRddTJyq6RZ0
	98cbg=; b=qSq6u9Zv/Gu69i9BVyfx2/KxZUnwYdAxeo4VoXRySjCLENXfpBhv3m
	7rjy/+O9OQ6YadPa9C6/tENPdNPtTDrCmdZnJMUDR1BMxRGYmUZr05l/7YTBkdIB
	nMlNEj69B4ZclXfmv+B/1Iw4hdQG9vX9Br7WEO0P69ala084kaU7s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 54EA83709A;
	Sun, 26 May 2024 15:23:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 74E6737099;
	Sun, 26 May 2024 15:23:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Philip <philip.c.peterson@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>,
  git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Jeff Hostetler
 <jeffhostetler@github.com>
Subject: Re: [PATCH 3/3] ci: stop installing "gcc-13" for osx-gcc
In-Reply-To: <CAJ6X7_VSswj6pw2gyfEp=Hmx237MJEJA4bW+QkKNs88iRf=Hwg@mail.gmail.com>
	(Philip's message of "Sun, 26 May 2024 02:34:05 -0400")
References: <20240509162219.GA1707955@coredump.intra.peff.net>
	<20240509162544.GC1708042@coredump.intra.peff.net>
	<Zj3F9EVpSmQtyy0R@tanuki>
	<20240510201348.GE1954863@coredump.intra.peff.net>
	<Zj8blb0QqC2zdOAC@framework> <ZkX9w6etjDVAh-ln@tanuki>
	<20240517081132.GA1517321@coredump.intra.peff.net>
	<ZkcUcPhrTrbSbZO8@tanuki> <Zkc_zJGjwg0fZkRG@tanuki>
	<CAJ6X7_VSswj6pw2gyfEp=Hmx237MJEJA4bW+QkKNs88iRf=Hwg@mail.gmail.com>
Date: Sun, 26 May 2024 12:23:18 -0700
Message-ID: <xmqqr0doe5sp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 68D9AB8E-1B95-11EF-AA25-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Philip <philip.c.peterson@gmail.com> writes:

> Part of the problem seems to be that the Github actions runner has a bug
> on OSX: https://github.com/actions/runner/issues/884
>
> Based on investigating this for a while by setting up a self-hosted actions
> runner, it seems to have to do with a broken pipe triggering incomplete
> output capture / termination detection by either Github Action Runner (
> see issue thread) or maybe even Dotnet Core's
> System.Diagnostics.Process functionality.

Thanks for digging into this.

> As for the actual failing test, t9211, what I got on my machine was a
> failure during clone: `unknown repository extension found: refstorage`.
> In the trash directory, the .git/config did specify that extension.
> Perhaps some interference coming from
> t9500-gitweb-standalone-no-errors.sh, since it invokes:
>
>> git config extensions.refstorage "$refstorage"

Puzzled.  We run t9211 in "t/trash directory.t9211-whatever/"
directory with its own repository, so that what t9500 does in its
own playpen, "t/trash directory.t9500-gitweb-standalone-no-errors/"
directory would not interfere with it to begin with.  How would that
setting seep through to an unrelated test run next door?  It's not
like they share TCP port number or anything like that?



