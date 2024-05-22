Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F75E5234
	for <git@vger.kernel.org>; Wed, 22 May 2024 00:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716338953; cv=none; b=NfxYa9P9GNivoCX7uTVRM7dF/hw0biXUhgRtV92nv+TgEM+LxudjujxXziH5PCy6E6jLJgjf9RmwwUxGNg1n8kupiK1KTkwf/t++Nkvm+CGLB21dMC8dD/mK4rUmJCeh6IGWl94PgSYp4tAemOL7TJ8Yat7reMOPiFy6Dshnj0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716338953; c=relaxed/simple;
	bh=IVOzAdZw6JyAsZhiQMs74tRj893BxOznebnCfJ4EOvM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l7HUv5BCDFAC/6etqfr4856DF3FbAuvHhyFe1cDMzL0q/j343K3bu08bKLfFC5Tk+jAET3mNQbdlGl+sbHp5KCL3mDEOBO3t+/byeN45VHVwP1GpDE9X/3VTYit2KP8EKp3H4zi7jxUIQPgdz7Yh1jgl236Lmg6JduEKo5JSp0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OIPP8PIo; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OIPP8PIo"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2192832DA1;
	Tue, 21 May 2024 20:49:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IVOzAdZw6JyAsZhiQMs74tRj893BxOznebnCfJ
	4EOvM=; b=OIPP8PIoBiieOuYqszoPCiUJPisXQLd1L2EqvkDtKXHl8tySaORfga
	LmZzsYZVoV3rS4wUuAltTavuFhU3hxTajFyYz75yrQ6S+l1vXzBXCGt5fV6b7bd/
	EzwZRvbeI5trvcdFzCp+Qb3WEq0EC2gBhKdh2FIiq4XLLBfpglNb8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 18F7F32DA0;
	Tue, 21 May 2024 20:49:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 80FF632D9F;
	Tue, 21 May 2024 20:49:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2] add-patch: enforce only one-letter response to prompts
In-Reply-To: <CAPig+cTcmpm5kHLwOzcJ4RfmfJwfO1qB4VVcngcvh=_zL5mm9w@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 21 May 2024 19:36:23 -0400")
References: <xmqqr0dvb1sh.fsf_-_@gitster.g> <xmqqh6eqiwgf.fsf@gitster.g>
	<CAPig+cTcmpm5kHLwOzcJ4RfmfJwfO1qB4VVcngcvh=_zL5mm9w@mail.gmail.com>
Date: Tue, 21 May 2024 17:49:09 -0700
Message-ID: <xmqqcypeisca.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1A1EC52E-17D5-11EF-85DD-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

>> The two exceptions are the 'g' command that takes a hunk number, and
>> the '/' command that takes a regular expression.  They has to be
>
> s/has/have/

Thanks for a typofix.

Input to possibly update this part ...

>> As we didn't think of a good reason during the review discussion why
>> we want to accept excess letters only to ignore them,...

...  of the proposed log message, or convince us that it is not such
a great idea, is also welcome.

Thanks.  Will queue but keep out of 'next' for a few more days.
