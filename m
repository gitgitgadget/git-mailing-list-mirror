Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE9B2E36FD
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 22:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753396231; cv=none; b=Vyp09PT9qzDSY+lRbUL8Wr7R88qIGf2Jg2RqXFLq+KUy2RJnVGFYK+kC0tamhYmH9YuCATen36MxwGfOthOcGyhUH3LGhOZpnIqkU1l+f+0WAgwpd05JGMbMMn7vkK8Or4ycTVdCRNYXzaN9Dse+TTPHaMlrCLaKkn7yfEhK6UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753396231; c=relaxed/simple;
	bh=OK5J2mSa71aYALBwxG5U79noFzUXqe2wxGgbyh6GWpQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=civMH9jfp+ntnd9hHd65/w+sCWxLvKw/BM+IaEC1nFtroKnZajM/nS8ULLBxmDKjLDUFcuq2cdyHFoWhS2MeiDCGbBrClxKU+ezB9BivgW3HvyGGPFBkjKE36I5ggAWpsJx6m0KF584Eesz8Sr3GZFEPQgZG0rjIbKXfD124ybk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F3UCwFvi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I8N3r6fv; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F3UCwFvi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I8N3r6fv"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 961F3EC0228;
	Thu, 24 Jul 2025 18:30:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 24 Jul 2025 18:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753396227; x=1753482627; bh=iJy/XRaswO
	ltV8YsAQ99nfODPKzFYOer0L6DPomIlAk=; b=F3UCwFvioRQrNbvM/3oQtWS5Ag
	uJZ6ffxkHNb/hTK8wxx1ETpn4ypmastYkf+hk2EfU9V2fFKd8eKHgYFj19o1zOD2
	fKZKHozOHH9+OEaIDJbeBflJTiMkFk/JA5T4dJ+aVszzi0wXBpn12ymPB2nPFjeG
	7GLS2AqWTrNx+4V13qBOEZuoe6gcUBfJaNuLPLF8bNi5kmzfHHWU/XW/M/SVleAb
	MlIIawMCtZ2AX8U0Zh2n7hwne9POV+IiWaQDNP30Bj/BZBUIS00uJxmOUU082Exa
	QKPZwrEfjxlY6vilK3UDohvwbiT8oGuJ3qEy88WcJdsEoSG1QkjoDnuilB1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753396227; x=1753482627; bh=iJy/XRaswOltV8YsAQ99nfODPKzFYOer0L6
	DPomIlAk=; b=I8N3r6fvpOqn0diaaDj7WUw0aFSuowYP/FV5mx6mqDmht5+2Y5M
	kylgCM4kb74tlPEu0rU+72EMv3akZWYRXZ1AREUVGHrUDlGs6jl4wURzOyMZRK8Z
	yA28ur4Rrc2718CzWXTaO0JbTxVOsQ6AWstOzmpVsIaNemkOq99jrYWd7op0HFEV
	7pxRjrYoOZPUqDF6JSE35FLwxYG/31jnl6K8zIbykEW6+eajHJIkjPMqBsi47B05
	wuu+Kdsx1i7dfc5gEfQgSWw40TteGLujMdWK+fFpLicBAxW2WDn8CldAszay1KBm
	14wxzdTWEHt02k+Y9mItkv1MnJwQE82K81A==
X-ME-Sender: <xms:A7SCaGqozp0NFq0n4OriJBdJDY4eZrsaD29NguXAdQb0dVuLvfWMjw>
    <xme:A7SCaAKEF6005lSExY-r-8T2uYBu-2M0PwDKPT--mcPjCdPOU9OV7mY0plN04FFR4
    cO0fHLw60xRHCdkGw>
X-ME-Received: <xmr:A7SCaBorFsc7WYON_MuNAwtziNJ7CVedOyymbEV-KYTgo4stZmgpE2n5ZjbBte4E86Zo9Lnt05_DYQAQu_Gulv76JT6RtPvW8j4dcTM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekudekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    phgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:A7SCaAxzNyyf3dEx3TbGpdH1-b-PSOh0dFrUNIGEjpgvI3sNXW1qow>
    <xmx:A7SCaNMdBSCSAKQRZ5aJQ0OQIcB09QQ76jW7dYymdjGPVCX3IqAw2Q>
    <xmx:A7SCaN6Mtgl3eN1wkEfkeN6H5QHlNf98ZYS46839lfjHXtTZds1HRQ>
    <xmx:A7SCaOmvYn1vtorn-X99EmrFIiMTvrfBnT2HoXK7vA4ct3W0P1RSuA>
    <xmx:A7SCaPp00fkxxg07dagL21zleSU9wcZrZcJS6SUdmJ2GQ9Q43Z8PviLx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 18:30:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  spectral@google.com,  peff@peff.net
Subject: Re: [PATCH] ref-cache: set prefix_state when seeking
In-Reply-To: <20250724221136.693120-1-karthik.188@gmail.com> (Karthik Nayak's
	message of "Fri, 25 Jul 2025 00:11:36 +0200")
References: <xmqqbjp9ikvk.fsf@gitster.g>
	<20250724221136.693120-1-karthik.188@gmail.com>
Date: Thu, 24 Jul 2025 15:30:25 -0700
Message-ID: <xmqqseilxlvi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> In 090eb5336c (refs: selectively set prefix in the seek functions,
> 2025-07-15) we separated the seeking functionality of reference
> iterators from the functionality to set prefix to an iterator. This
> allows users of ref iterators to seek to a particular reference to
> provide pagination support.
>
> The files-backend, uses the ref-cache iterator to iterate over loose
> refs. The iterator tracks directories and entries already processed via
> a stack of levels. Each level corresponds to a directory under the files
> backend. New levels are added to the stack, and when all entries from a
> level is yielded, the corresponding level is popped from the stack.
>
> To accommodate seeking, we need to populate and traverse the levels to
> stop the requested seek marker at the appropriate level and its entry
> index. Each level also contains a 'prefix_state' which is used for
> prefix matching, this allows the iterator to skip levels/entries which
> don't match a prefix. The default value of 'prefix_state' is
> PREFIX_CONTAINS_DIR, which yields all entries within a level. When
> purely seeking without prefix matching, we want to yield all entries.
> The commit however, skips setting the value explicitly. This causes the
> MemorySanitizer to issue a 'use-of-uninitialized-value' error when
> running 't/t6302-for-each-ref-filter'.
>
> Set the value explicitly to avoid to fix the issue.
>
> Reported-by: Kyle Lippincott <spectral@google.com>
> Helped-by: Kyle Lippincott <spectral@google.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>
> Here is my version of the same patch!

Thanks!

>
>  refs/ref-cache.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> index 1d95b56d40..ceef3a2008 100644
> --- a/refs/ref-cache.c
> +++ b/refs/ref-cache.c
> @@ -527,6 +527,7 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
>  				level = &iter->levels[iter->levels_nr++];
>  				level->dir = dir;
>  				level->index = -1;
> +				level->prefix_state = PREFIX_CONTAINS_DIR;
>  			} else {
>  				/* reduce the index so the leaf node is iterated over */
>  				if (cmp <= 0 && !slash)
