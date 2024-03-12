Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D3A365
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 20:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710275434; cv=none; b=thx4QuFUWPI/eEULjbFF1cKZ6Y4qXe0ncpn1d+RpAnV2dGgAZKXbQQ7nxqu32Yucoj+0ccHjDvg7sgrJz2V3Eo3s1mlelbTiOl1ybFtR17AntBE8HgHNZNKmz+bBIuSE16xg51jd0WeojarNhl/VnYKHgf0IiHLOXKFI0MzRlyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710275434; c=relaxed/simple;
	bh=r+sZ1YPe3Idvs/BBBhhYqFxljtp/2Zoc9RQASzV58Uc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=teI3z5FQreWaRBZ11JqtUFb4K/IpG1l8jODSYNQEmu5A4DQSoLMD7/FlXm2xyfOt3uqIjLTtKQVwMwb0Qe8hoyKKHnBIPa1zn3mjzhQ8yQMkLpTqKJLp5QJ8udfXnPGry9Hugs0KLYH4dDIXxkptp5XDqiwLXFgEBeORhRA7azk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jh/FSx3R; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jh/FSx3R"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EC0A230C59;
	Tue, 12 Mar 2024 16:30:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=r+sZ1YPe3Idvs/BBBhhYqFxljtp/2Zoc9RQASz
	V58Uc=; b=jh/FSx3RSD38RU/tS0jIQioY2w5/ZWAb5LiClgLmgdhrYqUrbY7I+w
	nNUabVzquxMPI8JFFHVIK8TcGoY+kNMBhh+ZARd5MsLRjwOvMMU22b0w1u/jqOBz
	Ta86f1gI6p8NoCQM+3ET30aYpXa1Lcb1a5WH/2210gAwST1zjqx90=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E425230C58;
	Tue, 12 Mar 2024 16:30:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8F43E30C54;
	Tue, 12 Mar 2024 16:30:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Dragan Simic
 <dsimic@manjaro.org>,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Manlio Perillo <manlio.perillo@gmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,
  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/16] allow multi-byte core.commentChar
In-Reply-To: <7cc7d539-7f31-4cd8-bcc8-a98a67a5079f@gmail.com> (phillip's
	message of "Tue, 12 Mar 2024 14:40:18 +0000")
References: <CAAToxAEE-2B_8Wqrquk1peOnqTbOpV_8KZmsJ2dgk-mfCZXHiA@mail.gmail.com>
	<5e10f1e5-b87f-43cd-ac1e-d7c01b7dad21@app.fastmail.com>
	<xmqqsf1466eh.fsf@gitster.g>
	<52d6850914982ffaf15dda937d611ffb@manjaro.org>
	<xmqqmsrc4osm.fsf@gitster.g>
	<20240306080804.GB4099518@coredump.intra.peff.net>
	<20240307091407.GA2072522@coredump.intra.peff.net>
	<20240312091013.GA95442@coredump.intra.peff.net>
	<7cc7d539-7f31-4cd8-bcc8-a98a67a5079f@gmail.com>
Date: Tue, 12 Mar 2024 13:30:27 -0700
Message-ID: <xmqqsf0vjiqk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5E004D92-E0AF-11EE-8AE6-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

phillip.wood123@gmail.com writes:

> Looking through the range-diff it addresses all of my (sequencer
> focused) comments on v1.

Thanks, both.
