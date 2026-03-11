Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D1B2D2488
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 19:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258125; cv=none; b=Lywc13C9gXSwPTItTj2IPz4yGPD3sPef48cdnWxaXE9aDo6KkTqoVMR3KhoZmB+zKm3TelSLR78OFM0IySW6KHyxbXXxhgvq1pcnkIypoK8r5s+/ZAbEf/W3rhvwPA3/j7/UKnagrzjp3XNhNMO8tVvPz1lEZalHuhdNXsaPsUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258125; c=relaxed/simple;
	bh=arvTOwx0QEexdRmrfNp3rKqWN3oZGvY3tBHRbFD3tUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q67BF8RLqSlSznmZyqPSsYJ33jsTy2h6yLnYoZaRS0qTcgCVQQIwDpIymZpWcAxVk10xP0/8x02rDTRRXJ9CtqYscb4rtYxx6gAUYXBonvgIJehiPTbuObrdodbbe7pk6z/OBxqNBvTRIIAfW1YwMpjw0zbD4y/C4wuu4LU1/1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZYnmtYIP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OVMQ3u/9; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZYnmtYIP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OVMQ3u/9"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B29E21D00089;
	Wed, 11 Mar 2026 15:42:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 11 Mar 2026 15:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773258123; x=1773344523; bh=kb0P7gHudC
	rnfynW1EYV84ANmJSG/FN7VCtH3tMv5zU=; b=ZYnmtYIPPYuBmvg7WrCqrH6EuS
	pWwztrLfVW3U2zsG+/AYSDmPjnVg0evnKrfqUAL0SLF29GgZkT1kM35dBfxNURtr
	iqpPhbqkIUUonOOzs05rEz4jydtOHccvXQyMiMyOYdO3FKlkevtf7axNBUBjnBrV
	CJg0wCb5RkEMdRgzPjMxdQtOk4y9nn2p+X/vzSUVT0QsaMT4UwI7CHuRycjd60zU
	Cr9WniEuFDx0pkHMP3DCftfEVe/gji0YamI4F2xBW1hKqYSsiEXevI0oMt8/mOsP
	aBgZNPoN5ITwd3kH/7hlcNuSiA7YoBYPzQQtReBQE4lsyJuybeh+aieFX8Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773258123; x=1773344523; bh=kb0P7gHudCrnfynW1EYV84ANmJSG/FN7VCt
	H3tMv5zU=; b=OVMQ3u/9l8NBCd892PjXG1H3ZI5mn7b4ZO5hPl2Q1n+GNU6hQE3
	bhwrZiaeQNR2zQ9rSGlclkfmz+NX1rEwSvlHD/LEaKlQA4G4YM11En2rrZMKnWlW
	1waQompqBhwz/lRE4TSfZgXrhFYDBeZjDeVqXxxpI1UkUz2EbT1OD08rdjs2n4BA
	A6CxGAvzuX4fmpBW/Lk/G6SUKv6ICqy+Rt3Dd5nHNLAEzEf0pAozhPPymR87WmI+
	Nvq4aXoQJLJAuMYTIYM8qtkr50Ncfwfp64EjM8RDK51wnivWyOjFQY9vFOW3fabG
	QibYMp1C+G4z1Q5Jcc95/pG3sCWN8UdiOmQ==
X-ME-Sender: <xms:i8WxabYdqiC_y7vpYeBuLMJb8DrjqKnyu_F_JI5vwyqAl4O4jEailA>
    <xme:i8WxaR0iuqj0Vf3f66gp36EsPGA8vdsHLyxbcCLuAzL1zHFpE92mNh3JY4e4Fb8d7
    JJTjEM-eiy54WP5D5QudwecraKemMh2ab-h81JBTjV1_47RD8BBRQ>
X-ME-Received: <xmr:i8WxabWcIN8R2McwnfQsWRAX9R_cy7xQ5qHGCHzb7xfggl0u8rII6zyAeJixpNZ4UaxaWXZTB2H5T6mmEGL0Gq2LsjN442sO4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhff
    eggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprggslhho
    ohhsrggsrghtvghrrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:i8WxabXaU6NM58DfL7BIktw7mVfye66BaxRZLFRgrHQ7gV1CmQpx4g>
    <xmx:i8Wxaac4cOCcAdzWNAJ1jHk1BGXclmEkT_DJ-5c8kjX1yEnNrDwQvw>
    <xmx:i8WxaUWqM3maErbD0xYdAWUM3tOW2RL_4LD_sBGqeBFYkpoDd1zkyg>
    <xmx:i8WxaTeHaEFUNxaqAR_WNVxJaGP72YXXf6gAgdgQ52PbKy6bG0eowg>
    <xmx:i8WxaZ2y300ED5GzbgTyez7zeakmVYxYnolyfmDZE2HKxvG9U0O2EuBH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 15:42:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH v3] t9200: replace test -f/-d with modern path helpers
In-Reply-To: <CAN5EUNRZQP6ATE87AeZiJx-OTnNn_4NxhW4zyH6AspGUfnV7TA@mail.gmail.com>
	(Pablo's message of "Wed, 11 Mar 2026 20:06:26 +0100")
References: <20260309150935.578465-1-pabloosabaterr@gmail.com>
	<20260309230134.758107-1-pabloosabaterr@gmail.com>
	<xmqqwlzip82b.fsf@gitster.g>
	<CAN5EUNRZQP6ATE87AeZiJx-OTnNn_4NxhW4zyH6AspGUfnV7TA@mail.gmail.com>
Date: Wed, 11 Mar 2026 12:42:01 -0700
Message-ID: <xmqqbjgunofq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo <pabloosabaterr@gmail.com> writes:

>> Our test-path helpers should work even outside test_expect_*
>> functions, so this is not wrong per-se, but it somehow looks a bit
>> unusual.  A related clean-up would be to wrap the CVS initialization
>> part inside another "do we even have a working CVS installation to
>> make it worth our time testing 'git cvsexportcommit' command?"
>
>
> Thanks for the feedback, I can send a separate patch to wrap the CVS
> in a skip_all git move the git setup

Yeah, but if we are going to do so eventually, it would be pointless
to use the path helper in that "set up CVS environment and make sure
we got a sensible directory structure" check, no?  Upon failure, we 
will hit test_done that loudly says that their CVS installation is
not working as we expect.
