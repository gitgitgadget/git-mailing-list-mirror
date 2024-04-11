Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9FF13C818
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 05:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813531; cv=none; b=QkXy/oTgPpkW4SMPKmSvA37cqYa4moKeDj4iEu90D07Ki9M+YqQscnBOmngvA1DlfkLrMZhGVaFuuNwLdpp0rtJLYZDskzegXyGzXH/szsc3jvThq2LUhO+7nzrKeL9rXmeu4xPSBzDl2qeyA+LPvCxWtD+57ts739yo293j5/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813531; c=relaxed/simple;
	bh=M9jKV16QQWfn13AupSU1fM5X48xarwD32GX0naR02CA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mJpi94kAaiqJ2T8TcPV8tIYv6RC4wqS9B2zG3PJoeFWShtfj2E+NpPJb+BarRR4lkHwJiQOtZXadddKk9p8/2sKAoD2WrTCTCsNNEfoaSq37WI47n9jX9/lT0Al19NKMCogJBdFhNFM/rxpCqfcZR1nGhbcVO3TUs+A/Wb01fmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fG5SpxZ+; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fG5SpxZ+"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5978C1F2BD3;
	Thu, 11 Apr 2024 01:32:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=M9jKV16QQWfn13AupSU1fM5X48xarwD32GX0na
	R02CA=; b=fG5SpxZ+m+CKP8JeqdJGKyFN/7+BgQkZ7aaNnorBrRSCmLkWwJ2kS/
	kXV4VJZjAAwJ2DKaiq+XNDEUrzE2lXzlopH8SjUMxa2+MsabLHu1oeexx24cIJLy
	1eVLt22NdLe1YDp6apPQoAdCogsaqKtZAPrnUFAygwmEK4KosrR2U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F2761F2BD2;
	Thu, 11 Apr 2024 01:32:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A3751F2BD1;
	Thu, 11 Apr 2024 01:32:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Chris Torek
 <chris.torek@gmail.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 6/8] fast-import: document C-style escapes for paths
In-Reply-To: <FEF264E3-B671-4F0C-AE41-FC8EE44DBE28@archibald.dev> (Thalia
	Archibald's message of "Wed, 10 Apr 2024 22:50:21 +0000")
References: <20240322000304.76810-1-thalia@archibald.dev>
	<cover.1711960552.git.thalia@archibald.dev>
	<cover.1712741870.git.thalia@archibald.dev>
	<1b07ddffe000ed2ab34bd41f4f0558ae8b2dd663.1712741871.git.thalia@archibald.dev>
	<xmqqjzl5t6mn.fsf@gitster.g>
	<FEF264E3-B671-4F0C-AE41-FC8EE44DBE28@archibald.dev>
Date: Wed, 10 Apr 2024 22:32:06 -0700
Message-ID: <xmqqy19kqxbd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D6537B08-F7C4-11EE-AC79-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Thalia Archibald <thalia@archibald.dev> writes:

> I expected more pushback with 3/8, where 9 tests were indented to place
> them inside loops in order to test them with multiple values for root,
> so it seems not to be purely about whitespace changes in diffs.

Well, if I read it, I may have (or not have) comments on the step,
but because Patrick started from front, I was reading backwards from
the end of the series, and I didn't reach 3/8 ;-)


