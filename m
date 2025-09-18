Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F003081D4
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226908; cv=none; b=nfwHpOTJVK/sw3tqTlIbpD6jW6GkC+zhKmq6dSYLKYX9xGqJrC3eY4DW/oqUvVsS+uDOoKiP7EN+dcDdy4bmDSS5juDfffrYU1muOOQwXNhontValuSCHswp5EGN4jzAUlFaqFkC58nxPOgFX5XyQfuxGShnZg+ZMZqLyQ+9V8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226908; c=relaxed/simple;
	bh=sNzIGYxwadTFgKnF/SsJg2PYzXFHg6/WB0PaWyEB9rs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fu8n4z1jbOnuZw7Uyu/MVPMMtNmQxE0aZadp7pQHxA6KLb4xkMKxBkyjmMeQYAs+Qrq3UvwFlToVeQ91ZU1OWdEYgNAhJ0iINk6NtKDQ0RnODGL6O2RQagbFInU7m3t3G6JRX1TvDZvJCjz9DrY3wYf6P2N+25HPJjmBO7xohfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e6DM7TtS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KZHgrq8g; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e6DM7TtS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KZHgrq8g"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 804741400128;
	Thu, 18 Sep 2025 16:21:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 18 Sep 2025 16:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758226905; x=1758313305; bh=sNzIGYxwad
	TFgKnF/SsJg2PYzXFHg6/WB0PaWyEB9rs=; b=e6DM7TtSIhgQAXLCmJBLMloFoX
	odd5mxPaPy0I+AlURgvVXXtl/xdo20OByAwJDl7aKY/QWGg3ddmq1I0AaDu1WcKu
	6u7kdKl26wQDE3I09NLCMblTOjtddrTMKD+wQgnTVzeI7C4uFsP93ueUyY7niTYF
	TvvVmHgZ3YbZKCaf+k3jDPAfJvjwZGqJuqgMdSUIXQNZp3Jnb/Vw1gaPgLWWljVD
	4FzCWAIVthBgi4pZUw5yTWmByq7m4EJtD/ZWF4WU4bfCNQbMp8UryktOR1euGLHj
	Ta08fGfaTWkv291iT6eIjmcSasYzqGXJs72SLi2Vs1ZykLgh0SB4cT69qoGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758226905; x=1758313305; bh=sNzIGYxwadTFgKnF/SsJg2PYzXFHg6/WB0P
	aWyEB9rs=; b=KZHgrq8gTU4CSCZPvI74oFuuGNQllvVzoCw0tStz9BnpjRZ60GS
	Bvc6ok7j4sKExP26suLYGNO6dkhQR4shK77tzm2uqEewVYUgAebgxH9dYAOGp0kz
	xD1yKWn+3tXuiDJgOw7TDwUAFc/aDcWi1x5uqVpSt0L1fp+0+FM5FkvtZKiVoRsG
	KHjDBiM/LtBDNERUJd8nltda8DvwkgukVQmcNJ0Etsvi0wBApZOiYPNwBde4Fy+Z
	SC1O2pGqfBGTnbKbdeHMc/3vf9vD7eXrmIjb5Z3M9ERDeqb4mBjqY+6gdDT5Zayr
	TSqAiwlfOGnmPBQl+EYkf5UO3Cg/uH1AUAg==
X-ME-Sender: <xms:2WnMaNmrcC3L0BBTssQSXof3lVdxYdDc7gAdQ4EyrL1z2rCsvSF7KA>
    <xme:2WnMaGb9rRjtQdOTOIUijX5uq33YsPR6Sjlg0ZgBk0PEJmwYnDzill4v9GBp4O3cZ
    AVw4s0tJcQgmcbfFg>
X-ME-Received: <xmr:2WnMaKH2dXAtKZve3nMKJ_G3HC8hvYM4Lqcg1kzprDqvD5ixdiqGmDakLrtITe2ttdaOQ8TskIY-rsWNJfZbQaZiJloV819feHmUwyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegjedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhu
    nhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2WnMaPJ87x8FDhSJElLrV0j3IQUo5UG0gj80mQ9JxLd5tm84k-__xA>
    <xmx:2WnMaNP-niBxVBX1Za5-DS_ZD3z7r8DXBXCOY1sQjeaLdt3F0opf4w>
    <xmx:2WnMaHltAhVuYL6m2vl7cULFBy7fX2CCytpAC89CaY0eK_DTLMkkPg>
    <xmx:2WnMaJ5NWIhiTg2OAtdaqSDCSFYNEPyBM3tn53fyVbPg1YZLGxta1w>
    <xmx:2WnMaHns6A2IGEjOlkSVVv9NDnZnr4bdfBt7Rpy8Bpx0mChBk2rIDFP4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 16:21:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: kristofferhaugsbakk@fastmail.com,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v6 0/9] you-still-use-that??: improve breaking changes
 troubleshooting
In-Reply-To: <20250918183117.GB1184978@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 18 Sep 2025 14:31:17 -0400")
References: <cover.1757879060.git.code@khaugsbakk.name>
	<cover.1758139856.short.code@khaugsbakk.name>
	<20250918183117.GB1184978@coredump.intra.peff.net>
Date: Thu, 18 Sep 2025 13:21:43 -0700
Message-ID: <xmqqsegj7bqg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I am a little troubled that even after your patch 1, the test suite will
> get confused by a stray git-whatchanged binary left over from an earlier
> build. That may become an irritation later, when the breaking change
> becomes the norm. But maybe it won't be too bad. At that point the
> matching entry in .gitignore should be dropped, so at least "git clean"
> will find it. In the meantime, building with and without the
> breaking-changes flag can cause confusion, but presumably people aren't
> swapping between them too often? And I don't have a clever idea of how
> to do better, short of having the breaking-changes flag explicitly
> delete git-whatchanged from the build directory. Which feels a little
> gross.
>
> So I'd say to call it good for now, and if it comes back to bite us
> later, it is not harder to address then than it would be now.

Yup, my "before pushout" local builds almost always hit a snag from
leftover git-whatchanged, until I tweaked the procedure to begin
with "make distclean" before doing anything else X-<, but this may
be good enough for now.

Thanks, both of you.
