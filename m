Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9550179E1
	for <git@vger.kernel.org>; Wed,  7 May 2025 01:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746581549; cv=none; b=i5H26GbDEqOI3tlaxun6gYBsVvwzJXaom3yV0NCPzjfaZF2sO1GfeEVMnEQnp1ODUt3wj4HfS4MBwvTlAZsEei24EsxOYTTfJ6eE7HRFuk4ajD1WZvOw5v9SnO3C2KzqFAZk793leEownivxGEOIFVyPuneC2LpQxpkwrPSeBKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746581549; c=relaxed/simple;
	bh=/VYJBnzHglxc3mvh3vVTypQveRpIU+WYaOhfb+oGZFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUGw2g5V+/8smbMJfnLQ2ew6xF+qcLwfuqShvuFn4Mj0X3+97X6gtGzXF3tPuEhSJva6ZcgGvYsMckWUh9TZRiOC/TFq0sDgh2TptIWr7AHTeXL4irXQ/Qh4Iq8q4rQfQT0i2On/cFMKD4FiVlZzAsqrMWmkNoP5i8XcQlgxrGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f/2BlUig; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=elHElqfD; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f/2BlUig";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="elHElqfD"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5922A2540209;
	Tue,  6 May 2025 21:32:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 06 May 2025 21:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746581545; x=1746667945; bh=u8wmrAh1Nr
	NxZDazOg04wIIupCztZqVqLv4wkAJU5U0=; b=f/2BlUigErnXxu7N3MFaxqvqiJ
	bi7cTiuWQSb5vSWVh+AwebAeuxNVqyRGwHWbc59wXn50qw8gZav6fKrBkpuHdOfo
	oAILlJMnJDl79KGjAZsXtjDJEWnYWwK7JXqtZ4zacMeZPiguet01RMMYHSkLj2ZA
	tMH7DA7ZG3FVF0yylaPJcireSXVJA5xCIlS8dTHfvYCS37HXlU8a+oUnXqzhVwq5
	RRDUZGJWiRYKOncOvPQmqhuuxzrSmF0lZ7bt7X6slGBD+ctHN0Lk3IlWsugS/8QX
	fXRsp6vZnR4jbxl3iQoiO6MKvfc4e2Ei4met+h0xIVLwfiN3fBA4a/0k51AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746581545; x=1746667945; bh=u8wmrAh1NrNxZDazOg04wIIupCztZqVqLv4
	wkAJU5U0=; b=elHElqfDSdNsQLV3oG4PdjT2BKCRI3UL0gODUP96eSXIIft8iGV
	48Gy9S61BIrAHWlWNOuho7MpliCZm/LTeXrzukn91/OcWbMedtyKd55K5W9qOV4k
	0zN8OJH/HOYxKjLc18fPJa3sKB2jJhe0I2bgRnKHykTT8RI3iVMrxhybj4VZ2qJT
	ema+LSKuZzrVzHttjg8wv1mLmal6CyWQbH7dL9nR88TPqETn2+SAnsomAeyQYchp
	GErILXBSee5v3ltE9xMmT9Eh3Q5rcyEqcQRYwKuTWWAhOAvHRrfwJRy95SitdrR7
	jWQ4ALTNHv3FllYuFZOUCY8kP3AkTJadSnA==
X-ME-Sender: <xms:KbgaaJ4sb5Pg4F6pGivERSZ0PsC6JbSXs868Yqcx36-iunI8CDTmsA>
    <xme:KbgaaG4PChZmPByFySN-efZtzFsQKiP9zG3AIyKxzBE6TcR4bzAcwxGxl8Ry0yZFC
    Jy9HccB38K9CYjVMA>
X-ME-Received: <xmr:KbgaaAe-7QCy-tlzV3DhXw1cviMz2OxDo_xCBa0X0X6RAWGptD8hooDRt72pFF-MHnXESI8PIHr6ycrxvV2OSq99k_KuVu7RV-r5U1bOOWczulmMWIM4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeehheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepvfhougguucgkuhhllhhinhhgvghruceothhmiiesphhosghogidrtg
    homheqnecuggftrfgrthhtvghrnhepjeffleejtdfgffelueevieeuvdetkeevvdegfeff
    vdektefgteffhfeukeehueelnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KbgaaCKfS4OeUESFXRqDN8KSnI-JM4X27znajBCEmUIES7tgiZFuYw>
    <xmx:KbgaaNIRx0NwvJrnUNghA5yepvUhdsOMcmkZA1qZw7LZtgKxBffpFQ>
    <xmx:KbgaaLzeQ8DzL_pYEtmCpb6UL7ggKnPeBOCu4Tq5xaZd8Nr7qrfJTg>
    <xmx:KbgaaJJP8KZvriOx9PTmNeXZpQqsxgdr9LnlleX-Pd9gGM1dyPgh6Q>
    <xmx:KbgaaMpe0zJgIXTx0uUtfzI9S3ww5nkR9slJ0uVQlUkNtiXClU11Gfsm>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 21:32:24 -0400 (EDT)
Date: Tue, 6 May 2025 21:32:23 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Subject: Re: [PATCH 00/10] Spring cleanup of "contrib/"
Message-ID: <aBq4J6UTZVPF8rb4@teonanacatl.net>
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
 <xmqqmsbph3lw.fsf@gitster.g>
 <CAPig+cT6XbdzeOFoeZUmX+ozPa2XNOv=H85xQhY4y8NYmJZ6-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cT6XbdzeOFoeZUmX+ozPa2XNOv=H85xQhY4y8NYmJZ6-g@mail.gmail.com>

Eric Sunshine wrote:
> Although we periodically hear that someone uses it, git-contacts
> probably falls into the "tool has a clear alternative" category. In
> this case, git-related[*] is a separately-maintained more functional
> drop-in replacement which people could be using instead of
> git-contacts.
> 
> [*]: https://github.com/felipec/git-related/blob/master/git-related

It may be worth noting that git-contacts is suggested in
both MyFirstContribution.adoc and SubmittingPatches.

It probably helps that since 824503ce88 (SubmittingPatches:
clarify 'git-contacts' location, 2024-04-18) there has been
a note stating this isn't "part of the core `git` binary and
must be called directly." That is relatively recent, though.

I added git-contacts to the Fedora git packaging shortly
after 92a5dbbc22 (SubmittingPatches: mention the git
contacts command, 2018-04-11), presuming some readers would
want to use it.  (I never want to penalize users who are
diligent enough to read SubmittingPatches. :)

All that said, I don't have any strong opinion on whether it
is kept or removed, let alone when that might happen.  I
don't know that I've ever used it, other than for testing
that it worked while packaging it.

-- 
Todd
