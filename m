Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5021EB5C
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 21:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821454; cv=none; b=dA5acSUbyBPXn4o25cPU8YEqgjHFpGueNlIqXdlsfN9K/J+81qbr9abcCAOE1OfmNBcCMO/gFpZTdc3FbWOI9Qb1S2QFEQglQzUfRsdVttFWSeqYFgtDhlp7EF965rzC+sVe7C0x9QWNHrAxUCXGIctjg1oVCzz1oj04cU8tr8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821454; c=relaxed/simple;
	bh=iJaO4g8BykE/SmRI5exNSU0FFSGpF6DOH5vFTVJJ8Cg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fJNVm/eoa4h/w4H68i8h4Mku7lgsQnrW23bV0UdzS5ui8rwLEnk08HHNrG2+KJwqPw8hCSnduDaVaTEXLHl8v78PnwyTxHkjPKtliZ8YufsoIz9AWy1h/hDkqzsqQBWrEHyT/8tl0OX8PhHIoRYN7fk8/H91DZRgfrzngS7upv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xst5pZ2a; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xst5pZ2a"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AC2F42B91C;
	Mon, 22 Apr 2024 17:30:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iJaO4g8BykE/SmRI5exNSU0FFSGpF6DOH5vFTV
	JJ8Cg=; b=Xst5pZ2amdo8vqS5iPiMPdAQXf9+K2m6XAf6gHoblVPlnY0xMTQziT
	oULtF4bFiUgwwtMb4eHaT2KTu/sq2yfqCPiUKlFcCxCOvrXqbfbYuqJrq4gntIYH
	48+24HT+P6gzOdg0WEdzfs9CE3Mwa7BNii7FopCO/LNRqt8VbPbpw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A2CFF2B91B;
	Mon, 22 Apr 2024 17:30:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0F7C92B91A;
	Mon, 22 Apr 2024 17:30:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  avarab@gmail.com,  christian.couder@gmail.com,
  me@ttaylorr.com
Subject: Re: [RFC PATCH] doc: describe the project's decision-making process
In-Reply-To: <ZibSUPezSU3ZV1HA@google.com> (Josh Steadmon's message of "Mon,
	22 Apr 2024 14:10:40 -0700")
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
	<xmqq34rmi28h.fsf@gitster.g> <ZibSUPezSU3ZV1HA@google.com>
Date: Mon, 22 Apr 2024 14:30:47 -0700
Message-ID: <xmqqy195t794.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 96506578-00EF-11EF-AAD1-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> While clearly nothing has been decided on those topics, it seems to me
> at least that they follow a pattern of "discussion now, consensus
> (hopefully) soon, implementation later".
>
> Or do you think it's more accurate to say that we rarely/never make
> decisions without patches?

As I said, I do think it is rare for us to start with only "ideas"
without anything concrete to comment on, and that is why I asked
some references (e.g., URLs into the archive) to a discussion in the
past of a larger decisions where (1) something is proposed, (2)
discussed, and (3) declaration that a consensus has reached, if a
document describes the status quo.

> Does that mean it's pointless to start a
> discussion without a patch series attached?

It does not necessarily mean it is not worth trying to do it more
often that we have done it rarely.  

Is it desirable to make more larger decisions to implement changes
that take longer effort and deeper commitments?  As long as we can
have a meaningful discussion, the "anything concrete to comment on"
I mentioned earlier in the previous paragraph does not have to be a
patch series.

> I'm trying to decide whether it's worth editing this doc for V2,
> or just starting over with a much smaller one instead.

And if the lack of documented process is a factor that contributes
to the rarity of such decisions, it is a reasonable goal to have a
documented process.  And learning from past sucesses (and failures)
by starting a document that describes the status quo is a good idea.
