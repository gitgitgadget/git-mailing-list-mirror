Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EAD2D77ED
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154758; cv=none; b=BB+Ba9pTDNa4BV9JUTKBiHPc9fN2w0vS68UOrVO90xh5W6DnXrtei5MDhkJAkpPIsQ4RVxgTGnv1kteK4fCPgc3/D8AmMcVnbdohhtCON46v0ILwrflUgez0HYxZPpbIvx9IfH+ZH4rlDk/N4PcS8kCEOn/22oRWNPDNBp6RhbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154758; c=relaxed/simple;
	bh=SWML5sOpAODOSA46jWtS8xfbrr9yFdblQeqbgFaXsBg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S0TVSCQBMpTkQ8JGz1cjm19lmMAucEnhDIbyeVCIVGGn85WiZERzcFT2aEXD8fPBlwj0eTqgAf+iusTLAyawQbuPK85bMDCgLbjkpdl8Q2mfhIbZwgwrjS+iJl7EEdk/WAg7zqbYBcIIBvc6pbS7UXO0fPveKj9rS8suHo2FU0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IWic1McA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IciRB83m; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IWic1McA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IciRB83m"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 80C9714000CB;
	Wed, 22 Oct 2025 13:39:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 22 Oct 2025 13:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761154754; x=1761241154; bh=P4eDJWAbqX
	RqAR2Z/qwE4ranT2cIsurEAm/0D9t8DGE=; b=IWic1McAPZ28eK6541UFLL+IUj
	Sav3+xrPdapdV4ffwC9UDMULHR0zT30Q6IyZJC0z3xwhAn1WJtaUupFE530SEUEL
	SpId0LnebguLKzDgFOrj6CrBqVYmjIvTBZriO2sxOcj8PTaHfG6dvfnygeyO+ywq
	scttgiJCEwMMSEzN+u9AtOGk42CUMGCWASnqylOnbSqtdm6XpXJwMShvQGWvmggV
	bIwDdG/XL4+swHYxacdtIqqiojtYfIPf/Hs8Fvpym3qcujbLb0knvKQ46naE8SI9
	WTV1+99FOWkXKNhUaR2D656bdzXsL+8uKkVEM/kVDXVYE5jFnXxKJScTJUYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761154754; x=1761241154; bh=P4eDJWAbqXRqAR2Z/qwE4ranT2cIsurEAm/
	0D9t8DGE=; b=IciRB83mLkkb4S6RLPZBzjsO/3TXSvuw40+RBEd7hMWQaIBtCv6
	ptHSIZb2tq+kKit1Y2iuMp1gMWSdEzWXviWkLtnJyBTTKOPG0QhoNElYnMi5ojsF
	51Pa41+xJuO8lPRNZ14Uepqf9HEEYGcB7Mxq679wknAxVmWxk4M0Lon9qgdLoq92
	4siBzZTWHD+Ow8dtR07JQmhUbRXyV4Sc/OFvAXkw24z2WjIjhFSBNOWtaeCpYRAO
	NU6efz+Dk4P0ciOVjTznewWiaIqOC3zw3FxJxrVYFKj7fecC+uaGeKAw1HS5YmhY
	s9EKPg4SjJ0HwlrBTzHtmy75/N039A4vDNA==
X-ME-Sender: <xms:whb5aC7G21t04Fizz_ympNLw2izBt0uW6q5zW4EefTFgvzeerEq1fw>
    <xme:whb5aCycNUL0DZowE1TNvWFhz9pjYewCR9MSdEmPP_QN8Gg_xRtjA_-ZvIWnFne0i
    XHZqHl2d-2hf9-9IPMghKBvs9PIVfXM2-zYWIbseh1VhKyRtvhDFw>
X-ME-Received: <xmr:whb5aJyZxR6tpL2RShjm6szm7FFYzbSNM2Ihf3pkmGkVNFP0TCn3JzheXLbbKLkQKiJmYmfDJro2Xk-euMaq1SRUCme9oFAwg7vM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hjrghkvgesiihimhhmvghrmhgrnhdrihhopdhrtghpthhtohephihlughhohhmvgdvugdv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:whb5aKy5lQvrG8piJQHEHNgLG8tu7aDjga69gg2qgH5KFJbTH1yYmg>
    <xmx:whb5aDZTNvtUfsjwyVJAn8uWewDTGePdCzj-vCv6LL7aU20hVNLYfQ>
    <xmx:whb5aLVLqFJ6WYSorRE47oh5TzMeaOsUB0swx5RoGORoBApezyEB4Q>
    <xmx:whb5aBgiwnzRuioiVJ75gF5iHZwJYJbl28gekSTJpT0yKJbGVW79cQ>
    <xmx:whb5aEzRBHmtjBr7V4IfD0Z7DyOX9WGgQGzazdh8yNzUELgai01IZtia>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 13:39:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Jake Zimmerman <jake@zimmerman.io>,  Lidong Yan <yldhome2d2@gmail.com>,
  git@vger.kernel.org
Subject: Re: Regression in `git diff --quiet HEAD` when a new file is staged
In-Reply-To: <xmqqy0p4wcac.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	21 Oct 2025 07:38:03 -0700")
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
	<20251017075153.GA4078773@coredump.intra.peff.net>
	<xmqq7bwt1kyf.fsf@gitster.g>
	<20251018094037.GA1060824@coredump.intra.peff.net>
	<xmqqh5vww7xa.fsf@gitster.g>
	<20251021073640.GB259661@coredump.intra.peff.net>
	<xmqqy0p4wcac.fsf@gitster.g>
Date: Wed, 22 Oct 2025 10:39:12 -0700
Message-ID: <xmqqcy6ezvi7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> So really, the regression fix should probably cover both of them (which
>> it would if we move the /dev/null redirection into the flush_quietly()
>> variant).

So, here is what I ended up with.  Instead of redirect many times in
the loop, dealing with the two callers would be simpler and less
error prone.  If we ever have the third caller, that is where we
should consider refactoring this even more into a separate
abstraction.

This goes on top of your patch and intend to go to 'maint'.

----- >8 -----
Subject: [PATCH] diff: make sure the other caller of diff_flush_patch_quietly() is silent

Earlier, we added is a protection for the loop that computes "git
diff --quiet -w" to ensure calls to the diff_flush_patch_quietly()
helper stays quiet.  Do the same for another loop that deals with
options like "--name-status" to make calls to the same helper.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/diff.c b/diff.c
index 9b8d658b9e..ceb57d1ef8 100644
--- a/diff.c
+++ b/diff.c
@@ -6814,6 +6814,16 @@ void diff_flush(struct diff_options *options)
 			     DIFF_FORMAT_NAME |
 			     DIFF_FORMAT_NAME_STATUS |
 			     DIFF_FORMAT_CHECKDIFF)) {
+		/*
+		 * make sure diff_Flush_patch_quietly() to be silent.
+		 */
+		FILE *saved_file = options->file;
+		int saved_color_moved = options->color_moved;
+
+		if (options->flags.diff_from_contents) {
+			options->file = xfopen("/dev/null", "w");
+			options->color_moved = 0;
+		}
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 
@@ -6826,6 +6836,11 @@ void diff_flush(struct diff_options *options)
 
 			flush_one_pair(p, options);
 		}
+		if (options->flags.diff_from_contents) {
+			fclose(options->file);
+			options->file = saved_file;
+			options->color_moved = saved_color_moved;
+		}
 		separator++;
 	}
 
-- 
2.51.1-633-gaa2b1236d0

