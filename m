Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D085417E
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742745489; cv=none; b=CZLFhsj/Vzh+zcKs2M62IJvvYg4ZJ9zkynEQSZjAhGDYATIKR7AHUfii/pPwhdML/hXosgEPHdyld9+coE0+qWoHML1G0eJsSnJs6H4tFT0bhTe3DZT97LNX9Z/qbH03QInKgdbkRHQpuKnXZfJ5B3SDmf1hGGzThxJIBxvxeJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742745489; c=relaxed/simple;
	bh=O9jRgoN2kAh5048pNYVIad5WakPg2zmuEChmLEjbHOY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gv44JWUPDHCMhAntWYISeuBfptVkoeAt69x+MY2X32RI4qSaxar1jurVLQnqslTubX3Dv9RxKAQTnzoDoH2k/L7SBtTsZq1m2cBRDrmnH2zcZmo7uLI1qoR0Fxgzbv/4REweOBoqaHImzYUPUBWXxFxyPVoEJwjcMW/4mjPpsCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rrltclPd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fDFaHolH; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rrltclPd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fDFaHolH"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 96B732540127;
	Sun, 23 Mar 2025 11:58:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 23 Mar 2025 11:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742745485; x=1742831885; bh=0VNiQ8v7sH
	FnjC6DUPGSSTU66WOeLaAovXR1vFy8EkI=; b=rrltclPdgkxD7B98BEqpzQSEAu
	SBrEEfN5ma3N/h5C3OmStnHjoRv8W4IXwqQEBPRg8jxYHO8o8QFKClMxJmMGRVMZ
	V7PnJreaDsyLZNcVP2sDBacNK+sC4fWNAd9MR/lHQLeEfGr+OHPiRT7EXhPu/lPN
	fqwna9pLhPuiikfKYWNWfIs3420UrsMs7lEUCbOM3fsow4oaxRS7pjJ7T24IzjpY
	PFU4y+B/HKGxtWqzp2G3/ejn01RV0YyF3DR6+eevXPpv3BuBRN4ibB87SOFv4lW/
	XZHQV7dK22+2RX/fE2bU/5uGH/adlp7fcyMuCfsfHjmn6Mmxe1M8JEnAr7TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742745485; x=1742831885; bh=0VNiQ8v7sHFnjC6DUPGSSTU66WOeLaAovXR
	1vFy8EkI=; b=fDFaHolHqMl5v+LN+ixb6aOSqLQ9jlUYKplmyrOj5tbLQW/OAjZ
	uOljTEQ83OF83/xDz49QrcTGP7KtDF+98+t33R5/oSjechi8U7K/lKD7HbbYc/nR
	OsbNSRzOKAtFX39DvPdTSA0eEktV9LnKQB2TmKrBpY6pSW3mt9Eghwc3fXW5Tavi
	5Gk2+RzMxzMg1e63Clm7nmBMGymHiuOiB5LVWDmKI8ebp4n7hqrW2enmazpOWkj+
	loNgTJabrSGXMkQFyubCVrPJku/ilBpWSMPNuyskGqJPKvT3LCyheIfyYI1htUBC
	UgkpU0CWJlRo8lVm6kgQsF9wK64fLRsa66w==
X-ME-Sender: <xms:jS_gZxw3ql9VtPFJPSy2mP3KEIChQdqWlpF4lyi2ZpOyVzzZSSHRng>
    <xme:jS_gZxS7wgZMLG4XjYULZp0bWwkc412e20wi1f9yZFWyqwXXdmez6QmFRnw8weq9k
    CCHl0kWea1GdlZpfA>
X-ME-Received: <xmr:jS_gZ7X3zZr6NCXghNwhXPk_kNkTVQlgQRXwumPMto3luYgqnYW83LmFhFuGQ-Ob6ndim9ECVENstjKYF30ooxQOagXlWqSJwPuUtHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheejvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jS_gZziC_ot-IJ0Y1ZnDKxc_A6hlMK6Oon-xKHj4TLPxM0KEfY9slQ>
    <xmx:jS_gZzCGPxwieiMMSO-ZnRaaYfaarXqs6rMEG0QSDcDY2RamDFu1lg>
    <xmx:jS_gZ8Lewe4j8FHjI0nnUSgWos_WLGCTyJ12-ogPRPHE3vDwckOrog>
    <xmx:jS_gZyC2I-DN-iVsZgBye4gcFWAdp5bwPMY1W6mzsshVGyQaJxRsiA>
    <xmx:jS_gZ-7dW0uRr2c5HnbS-oDOCtYIvudiRNKBSSwWacE2hh7UZDWgCH0A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Mar 2025 11:58:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH] blame: fix unblamable and ignored lines in porcelain mode
In-Reply-To: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
	(Karthik Nayak's message of "Fri, 21 Mar 2025 17:39:14 +0100")
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
Date: Sun, 23 Mar 2025 08:58:03 -0700
Message-ID: <xmqqzfhbrb78.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> However, this option was never extended to the porcelain mode of
> 'git-blame(1)'. Since the documentation does not indicate this
> exclusion, it is a bug.

I agree it is a bug when people added ignore or unblamable support
that they did not _consider_ what to do with their new pieces of
information to help porcelain writers.  It is not a bug in the code
per-se, but it is a bug in the brain of these people ;-)

But prefixing random garbage to the commit object name line in the
porcelain mode output does not sound like the right solution to the
bug, either.

When enhancing an existing output format, make sure that your
changes will have minimum empact to existing parsers that do not
know about your extension.  It is reasonably expected that existing
Porcelain scripts reading from --porcelain mode output works by

 - Recognizing a line that match "^[0-9a-f]{40} \d+ \d+ \d+$" and
   take it as the beginning of a new record;

 - Collect all info lines before the payload line.  Lines that
   describe per-commit information are not repeated if it is already
   shown, so remember them when you see the commit for the first
   time, and recall them when you recognize the commit you already
   saw.

 - A payload line is indented with HT and terminates the record.

If you start to add unrecognizable garbage to the line with very
well known fixed format that is used as record delimiter, you would
break the existing parsers, which is not a very nice thing to do.
Are there other and better ways you can think of to add new pieces
of information like this in a way with less severe damage?
