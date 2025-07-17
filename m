Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436BA2FCFFB
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771540; cv=none; b=BWco6cbEYRHoSP0uKtGTlQj6N5PtLMY0RTrrwKLBNbE/mIASTx1HNKGGy8ld5ygs3dGipotqZWTY5JMSw7/I5rTsn97QbsF5hn7mlnF1nGXBZ4yk3McbxUTyjqHsyBecP8QTM/bnCxGMH1T43WRPhQpRdnKJqdKkl4it4jT74xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771540; c=relaxed/simple;
	bh=stN3NfQCgHPNG1aKLpRKaO6qpi3lC4J3LEDuZo6WCA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EV+1lfDG9TqksUo5wmUFzRNH6zGQ0J5pyUTnAguwhutKM/bW+PB/mKzBrioVn2dI6E/Ef2vvIvX3xYK2BCZ94+s5Bw3P2VFb92ExTzbE5pSmREfy5cI33hJQDL3cZpzv5Vj7Hss94na6xBpQhE52EuGLhwfXcMz8J/nDgN7OrSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZgclzyYo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=drmbrn3G; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZgclzyYo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="drmbrn3G"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5D12E7A018F;
	Thu, 17 Jul 2025 12:58:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 17 Jul 2025 12:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752771537; x=1752857937; bh=a6MghT4kUD
	1mMg1COufxfHgorOuYmJxgoGl1uK9k4bw=; b=ZgclzyYo6cFuORvxkO8V6x/+vO
	z0HG2rOKxLIFDOMoI+I7/TculPzISwduq60c3VT4RyB/yuWorT4xmhMEyY6MXnjV
	be03fY5BqpIPMNnbaA5EtkqXOFwmvbiICmO6RCmxino9mZ8GiXTIuNPNbuS5toKA
	MA8GEiShTDQHwFqJUeiPo8mcijilw8PNXmHTpkmKTDR5tVhlMd1kC4hS4fq/ZmhG
	6gDOU04XcsOsvxqsttZhEIuPLJOWZ+95Jl22fbGwDDZnOQd+Rq/3+mzPCdsx4jB9
	62Rnuv07ZKbCylJPyqhusBRPIbgyNrEDWnIO+6kUqWKzCqXYH96NOMPzkEqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752771537; x=1752857937; bh=a6MghT4kUD1mMg1COufxfHgorOuYmJxgoGl
	1uK9k4bw=; b=drmbrn3GKtRQ0TWFNOvPNFzOhdotPB3Rp9fDBeyJ0cxnJO1OWtP
	9UZJQjGr2K1kd+3zvyPjZTkILCUOckh0wm5w3ej34OxHbn0B35Mp/0zaBOP2CVns
	EUmXqIB/GknwuROP/CPL2h7iUqXDgXQM8Xlkw6x3+gl5A3OPb+Gd0LxdKIINDGsx
	pYSdCKUWSPDe4r97xUSfYqfjSbkhNlbkVtaQo+JerCzuGVgtxw1W6cytbffaY2yz
	u4y0f7YI/kxJOcxAZxqw5uarxSnFAp+zpxchZpo+/qJ3Tjbqkg4bF0dILtQt9k48
	1J4jR8+pxkB8J35fhaQbrPu7Q3Gf1cWH85g==
X-ME-Sender: <xms:0St5aA78DKlvDpakQM5zhpp90SIOXGGMm74YB2hUEEhwfHp8safNxA>
    <xme:0St5aFLuYVo42lmmutDB94Gzlqq6CmxLQbFMesNXCJ9euy_cihPK96siyL_OEF5lw
    ATVQ3Zn7wgPvoAvBA>
X-ME-Received: <xmr:0St5aI6oMjD-Iy3-e8GNUr0wBQ8igwkscfIdztWrY-CNMJiR4TfeYK6-HCVl2MfdynS-ZTNfxyA-Xt4Wy-rXKFbOv8uwoslqZf6uPKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeiudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjrgihrghthhgvvghrthhhkhhulhhkrghrnhhivddttd
    ehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0St5aAzUSvqRV3mcwJQSPrhzGsuP29Eriei6q5nPCy-1IUkrqb_NRg>
    <xmx:0St5aEaSALqZZ12TPjVtuatU4y9s8efHjuyIAgj6_uZALD51UH_wUg>
    <xmx:0St5aKQ1BLDD8cV3farFbL-P0FV12_-tqQhQVHp4jTgzmsZqXCxlrw>
    <xmx:0St5aGzvWsh2sWuZfrFJ2gLikyHQch0dXThX2SPV-spzXvox8C751Q>
    <xmx:0St5aFy93jmK9cGhnwUgEnqisjIR-RzV0mXH60RSEeeRSlxr38V8CAGf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 12:58:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v8 2/2] submodule: skip redundant active entries when
 pattern covers path
In-Reply-To: <20250608032705.11990-3-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Sun, 8 Jun 2025 08:57:05 +0530")
References: <CA+rGoLdTT3kdELUyHdZLWyy8e6AbfRU7kDFcVUdCmVtDi11hMw@mail.gmail.com>
	<20250608032705.11990-1-jayatheerthkulkarni2005@gmail.com>
	<20250608032705.11990-3-jayatheerthkulkarni2005@gmail.com>
Date: Thu, 17 Jul 2025 09:58:55 -0700
Message-ID: <xmqqa5527nzk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> +		if (!matched) { /* no pattern matched -> force-enable */
> + 			key = xstrfmt("submodule.%s.active", add_data->sm_name);
> + 			git_config_set_gently(key, "true");
> + 			free(key);
> + 		}

Somehow these lines begin with SP and then HT.  If you are going to
send an updated version, please make sure to fix the whitespace
issues around here.

In the meantime, I'll tweak the version I have in 'seen'.

Thanks.
