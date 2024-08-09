Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4711BDCF
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 22:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723242417; cv=none; b=DjakEXdph/0hK14m7KmoCdXORh8GyYkOFsqQmGE55oFIu0YL0jsdYybpxoeWkSobwfhx+5WGDp5UG9PehFusFyuoviA8wgcAI2Z7qj9VoXtt3UNUoq9cKuGWacIXwae0MYNWJCYJXmeoFOQ6KxhY4XYfBBhZxM6rdhJWOWCREIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723242417; c=relaxed/simple;
	bh=NV7L1H2fI2SrRzxjoGLu1Cg3VqC9Hnee5PrGNagUq1k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MDBrvx7INhh2yfASopVprNRl1EiVG/+1KIg9jLHoIxyzlA5OixOPfTm3YY0zsYhusBSy+yvd2Onkvs0PPIn7NmGQ9RvxgzY0Yi/NHM760xvuzKsoCCQX07VbBiDOsIMgBdoUdiMRHYuHIH3BfuhQ7qSILw2jhE+ySEZ/o11qU1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=t7qZOgr4; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t7qZOgr4"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C1B81E5B2;
	Fri,  9 Aug 2024 18:26:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NV7L1H2fI2SrRzxjoGLu1Cg3VqC9Hnee5PrGNa
	gUq1k=; b=t7qZOgr4QH8C9Qveh5hAnolN8qvS/vtuHTv7+DWqfeYLhZMCTQ/00T
	Unc/nsGWsox5cBH+nimLOBXNRI5/Lb6FTtt052vI0wTO+t9kOwIS2W1c5KbINRLt
	cFW1uBXdvYVaW5c9FTPyFFcNostxk9mutVgs7CAMMhMe6SUsbDgGc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 219DA1E5B1;
	Fri,  9 Aug 2024 18:26:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 86C991E5B0;
	Fri,  9 Aug 2024 18:26:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  spectral@google.com,
  emilyshaffer@google.com,  emrass@google.com,  rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 0/6] [RFC] Introduce cgit-rs, a Rust wrapper around
 libgit.a
In-Reply-To: <xmqqv809beoe.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	09 Aug 2024 13:54:09 -0700")
References: <cover.1723054623.git.steadmon@google.com>
	<xmqqbk21cxhn.fsf@gitster.g> <xmqqv809beoe.fsf@gitster.g>
Date: Fri, 09 Aug 2024 15:26:47 -0700
Message-ID: <xmqqa5hlbae0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 77C04E02-569E-11EF-BFCF-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>>  contrib/cgit-rs/public_symbol_export.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> There is another thing.
>
> Listing this file in $(OBJECTS) means that you should be able to
> pass "make sparse" to build contrib/cgit-rs/public_symbol_export.sp
> but it seems to fail rather miserably.  I am tempted to suggest in
> the meantime to futz with $(SP_OBJ) to filter it out in the top
> level Makefile.

FWIW, this one _is_ actionable on your end ;-)  Make sure "make sparse"
does not barf due to the addition of libgit-rust.
