Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4D11D6DB9
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752260906; cv=none; b=ZPZOkyahRAgNHeOaccoJHnDCZqmz6oV+KwNoO79FQWv+l3R0WRJ0eBV+LRfFQaLAMfybBJWr2plb/kOG1ke9FRzkpQNg0C6GBhqDgbwmnF/pUyocV9xq4ZvzDV6SQwyJfvRXTPVjrKdtT05KAi6Nkr8a60FlCcPYIpvMDVC1tOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752260906; c=relaxed/simple;
	bh=xOKIXjNjOfAfTaHUB6psVO88djxDx2qyHa0JMNEITAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gseDJFybB7S7B884oVEQF9gCE1kvA9exbOBujCgS169JYdJ+IgDDoolsVSQOnB+XF834Nj5MAe/Z627/TlbFmr7TIpfdNsZQzOVpd303kmImG80zwzaEls87ZFuVCenTOl46oNK6w6/q05sbgeVJkUMAlTd2T7xc30tIIzsIn34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ilnJUg3u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QFcBm4cf; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ilnJUg3u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QFcBm4cf"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 10A9C1D002A9;
	Fri, 11 Jul 2025 15:08:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 11 Jul 2025 15:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752260903; x=1752347303; bh=5gS4/gudNh
	8oRAlMmjA8QFF2rO0864UXtytWsggXcDE=; b=ilnJUg3u7SkvGjeO07+pNcUsrX
	N7UlrtbOk8hns7Qx0SIDt55MpBB7Mtdu5EmtHMjW+VAELrX3sE2qY1i3BALZ6s7+
	yHOiv9nHxfVhqOeHD8TqM7lWQGcQNsVqp4tHRAUOZeFDtU6rD8M96OFeqHkmt6/L
	ZpTGoXQGp3vbshDabhDr129HpF1t6FU/TDRSS7Qp9G+iHuRAk4CCaFGLwB/CoVXY
	1N1r8etEYRjvLie+5z0SCA3OHirdFbbWVJg9Xr29d6tCCb1JuT8HMiyiLEEGbKw1
	5Lysd6qhZjOsG/5Cqkrwai2XXLq+io9adIxLYXuh1KKSFuRFhSQUNw6NABRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752260903; x=1752347303; bh=5gS4/gudNh8oRAlMmjA8QFF2rO0864UXtyt
	WsggXcDE=; b=QFcBm4cff77l5psFDAoiDmSOok/2EVUjQ/1G4iG9ZWjc1yip5wF
	WI3F1FMlg4nj2HyBh1KjlIjMdcmodW77deOlN9ngpjcIcvEU6MJkMqzFdgRW/fLc
	UenkboMdlrbFCBldRiMOHqO/tH/eIV2UR9yTuwT19W13KZQ23XemBsmty0K84xi3
	BSYwFYr1ar9/8CZnkRlY3FjBUIIQVafDpChsprKEeFU4v5AOLwbbCpxTNV0owenJ
	PX97Uy0+x/2oLWjLrPOJx1sPK19vlEG40bz2Yv4/QtSrVb27OM/Z9vbWhu3ik6PK
	6mtuw5uxgyiI9pIYbEDLXoW5x4StEhoN06A==
X-ME-Sender: <xms:J2FxaAOj7XvJu_Ht-PjMlxQaJ0DXfZ4WP-dCMnkGvt85yJ65EYDvcA>
    <xme:J2FxaBgoUZMPcnfDPq0w8SPnQqHBoAU8Ka2EA0oLET2c8_bZmORscdM91Ebt54jyT
    JuQcORXiz-4WrgKTg>
X-ME-Received: <xmr:J2FxaD2w00I5Z0kaVik-Ybiy0joIQ0DwZPHLqAFicFOahUi0QUqieZXCjhkdixqXCzEgWfmHdL8ol7P0vB5bvLs3ORlLW8htKbrux9c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeggeduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:J2FxaLgN9q-m6G77lAulTCRjZXcXpfG1a_CEolKpqUESSTlK1HN99w>
    <xmx:J2FxaDd1TYAEkW3RN4H8hLkSG7vu8Ildwb5PJ8kFL4wEyCnkB_f-PQ>
    <xmx:J2FxaOll6YAtUM_UAS3qltXMsfr6GpaKDUOtY-mnMe4kNoOKEZzSSQ>
    <xmx:J2FxaMug6LCLPO-8zHsyhih0KZ5HMN7KMUSqscioRncP627-McZ0vw>
    <xmx:J2FxaNcQssjpJbEXfPp04nMac8gQ79X49-VO3xLoNKoAKcJWOsB7rKCE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 15:08:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Git Mailing List'" <git@vger.kernel.org>,  "'M Hickford'"
 <mirth.hickford@gmail.com>
Subject: Re: Suggestion: error "tag ... already exists" should distinguish
 between tagging different or same commit:
In-Reply-To: <00ca01dbef94$b155f380$1401da80$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Mon, 7 Jul 2025 19:12:58 -0400")
References: <CAGJzqsnvTnp3k8Ab2exaBAw5pszQRz00UcucnK=ECtY5vhG+1A@mail.gmail.com>
	<xmqqcybcrc2u.fsf@gitster.g>
	<CAGJzqskj803dUcEuV+P-yuWdT0tiaidb7h3YxQSCgYHWgBfaWA@mail.gmail.com>
	<xmqqzfefodje.fsf@gitster.g> <xmqqfrf73ahu.fsf@gitster.g>
	<00ca01dbef94$b155f380$1401da80$@nexbridge.com>
Date: Fri, 11 Jul 2025 12:08:22 -0700
Message-ID: <xmqq34b21r6h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

> Considering that git tag T O will generally require a git push
> --force and always a git pull --force in order to update tags on
> the upstream and receiving an update to the tag locally, I think
> requiring git tag --force T O when O is different from the current
> tag is a reasonable idea from a consistency standpoint. I do
> support the notion of git tag T O not requiring a --force if O is
> already where the tag is pointing.

Yup, that is essentially the idea behind that patch.

> The only counter case I can really see in this is when -s is used
> to allow the sign to be updated but even then, does --force really
> change anything when only signing (I think not) because O does not
> change.

In "git tag -s T O" (or "-a" for that matter), O may not change, but
the resulting tag object would certainly be different from the
object that is pointed at by the existing tag reference T, due to
tagger identity and the message in the tag being different from the
original.  So even without O changing ...

> If O changes when signing, I think that --force is almost
> essential to avoid messing up the signatures.

... we would require --force and that would be a good thing.
