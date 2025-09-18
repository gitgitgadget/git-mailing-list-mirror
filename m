Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C86221265
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 20:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758228382; cv=none; b=fBqqPvEkV9bpfAlotKb9kGNSVv57AhKzV5iHb3gIoX3ZQggQybS50GLfK5WsTS44s+GtbhjfIQjXXC4UvlHIo0YZvyf/NkeonOAa0M/UDjKnZci3kBfCa+Vt5quW9HZBnI3FtrAspc4O77OGnGKXUuNpfHi72zJHKrRD3P0B/SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758228382; c=relaxed/simple;
	bh=cbULWG9lXcHU0QFdTHWL592yb6ynTpfmAPbycTMAhl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TH42kA7aJzmf9gB6AXUyMy39k9kRhXUHEWJUydouSXXESz0STKTVfqoPSNpEGTdMwy8AD1kiJwh/gR+86VHzUqBfMGc19K36YPzR71f8wL6acC01ArgRm4ksMsC07+9eM47ZFkX62QSbs4+B9k8Tsso3AQ6Nykstgead+PmF6Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SHfFrXym; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=duyNlmNf; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SHfFrXym";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="duyNlmNf"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 33789EC0296;
	Thu, 18 Sep 2025 16:46:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 18 Sep 2025 16:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758228379; x=1758314779; bh=+gDtv2KuOk
	C4s7qyS8edXBJtc63gzhrMKPrN7poXAPA=; b=SHfFrXymez5tU0citwoyt3NTIK
	b9tpnmXfgR+s5DYTjJVMzsndyEjoY/EZZ6SxBa36Tb5wIftASHr9rq7i3iXEcAFX
	9Dp5nT5OK/xXRbUWWq9Pyr+nS0LPUggU66BvyhUG3seV1yX6h5iR2dPBNwRr7KVk
	gk/9CYjYy+FahbKcYm+gDkicYsBNLOJ+zPkz9a7I9FUHx6etX7F4vVr02+R84VZn
	6iqAUbJ3bzyhaPZhAzAIKL0fFiEKhtvLnG6cE2JkRS3kXszuoiGZdHuSqldBSyw4
	bHggIhTZdUkntVhKx5aqX1mH6feEXeuQWkckiJoklr/AkD+A2nUEJKf3GP3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758228379; x=1758314779; bh=+gDtv2KuOkC4s7qyS8edXBJtc63gzhrMKPr
	N7poXAPA=; b=duyNlmNfiFEAxNnCXL1B6mbB6XWPLBkq9L8XS3RFEbxePR815vi
	iRlCYsJOOcEOo2pOQc7BSKRO2fG3/S0qSHzr2KLXOLs83VibFn37W30k/KfYZX7N
	wxSqCZMUqhsY6MFmEuMg+pDxPBA9TOJYnd9GYjRw2E7f8KgE3G49fzEtjH1mb45P
	ObA8p6PKtZHiwtJf7BIm4lIyN6e0tSj9Wpxl7+c34cQVdyLhqccCI08Ge0sXihTM
	BGO3wzL8BpYI6S7fVTQd8yLuKvfuB9RFk0e+KL4IVPAX6f5/yN1froFQbvC1iKSF
	gUcUMQNNrjMYU5xRfcbeBmFCn/8taBfqHFg==
X-ME-Sender: <xms:mm_MaFxHlapqrESOfNUEuGp7zp_8Gbx8223lQFpW4ASkYFdtXJ0c2w>
    <xme:mm_MaAydjvNyiimn0zEXDGUOFbeWGVbb9n2zjDOnBnJSsYqUxLDZ-WPD8amb880Tt
    CNym4-dvnhyf1XIMQ>
X-ME-Received: <xmr:mm_MaFzQgokKkvaiGWAdRoUhQokUSUyvUSsIfw24gJoGIzPe28MzmIW_zafGczl6IiEZNRmPawCys-tlbdRs-3JOnm5WNKGBSUvkjd4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegjeeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepph
    huvghtiihkvghvihhnrgesjhhohhhnuggvvghrvgdrtghomhdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:mm_MaCYcyyXKcpsb8Oq2RcWzBs-btjTZP0xyWQPonYE5flhp1QrzSA>
    <xmx:mm_MaOV5yX39G2NFZvrJje_hWsXbBEMEfOv1-3woe8B9JpEpVYLcUA>
    <xmx:mm_MaIjsod1zBqzX9lmgGARqTpmTdQydvQcztgWbcD6mq5x9ghBOlw>
    <xmx:mm_MaEsnRc2sm6TFd5PgyKKPtv0xAyDKg1e62uN3Adiezz2pAk87JQ>
    <xmx:m2_MaFwCvBBy7mTMruhseVMRO_vHJgK1i1bbrDODrm_vjywNZDNJmw24>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 16:46:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kevin Puetz <PuetzKevinA@johndeere.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: [Bug] git fetch --dry-run --filter makes changes to .git/config
In-Reply-To: <20250918203916.GA1199728@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 18 Sep 2025 16:39:16 -0400")
References: <CY8PR05MB100119985C7C25A72E530556DB517A@CY8PR05MB10011.namprd05.prod.outlook.com>
	<aMsmbU_Cg0L6kOlm@fruit.crustytoothpaste.net>
	<DS0PR05MB100132C058A3D9D5AA735D905B517A@DS0PR05MB10013.namprd05.prod.outlook.com>
	<20250918192045.GA1187769@coredump.intra.peff.net>
	<xmqqms6r7bf7.fsf@gitster.g>
	<20250918203916.GA1199728@coredump.intra.peff.net>
Date: Thu, 18 Sep 2025 13:46:17 -0700
Message-ID: <xmqqecs37ali.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> ... It is unfortunate that doing so updates the repo
> config, though. That may show a mismatch in how the promisor information
> is stored (it is really a property of the packfile in the object
> directory, but the config mechanism stores it in the main repo). But it
> is probably not worth trying to revisit at this point. It is only when
> you start to play weird games like "this repo's object directory is not
> $GIT_DIR/objects" that you run into these distinctions.

Hmph, but watching from the sidelines Patrick's topics that revolve
around (re)defining the boundary and relationship among repository,
object store, and on-disk packfiles with a more clearly defined
abstractions like object_source, I am hoping that we somehow can
find a good place to move this information out of the per-repo
configuration to somewhere close to individual packs.  I dunno.


