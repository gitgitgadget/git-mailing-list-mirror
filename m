Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F4F1E8337
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742502427; cv=none; b=n91f2KVeFynd+0SpgTvS9SsD2Fb7xC3Etyq6hJ3v12zsEVjwijPBIlzflcEBhIhzDgZ2OddLFElHV7/DNNYQanSPLULVi3IvRv99if9xUde3jgVZ1cIR7CaFqWrFqCgbMGQl6c8Wk2Ow27cvekUWOl2SU7q6v600V03cKlQpWEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742502427; c=relaxed/simple;
	bh=UW7sA99uKIoP7agNj/xy0Y98zNzwhIM5O9lKzEBS3rI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OIwvOpydijvAFsJZDlOplmnYJrWiadsOvr6qtLT6Zn7KjxVHtB/ruQ4JErzNzvWTSTEWssaW7tcAML4DcmFZ2xZvNwOP1qr7fnys34fZavG/6Em32QOeevD0FXuREG6zzRtRRoAArCReKt1G1NSstm3uX1MTHD8HxOYsg3EUHbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vGx1hwt5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fuT7Ace4; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vGx1hwt5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fuT7Ace4"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 89A0311400B4;
	Thu, 20 Mar 2025 16:27:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 20 Mar 2025 16:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742502424; x=1742588824; bh=UW7sA99uKI
	oP7agNj/xy0Y98zNzwhIM5O9lKzEBS3rI=; b=vGx1hwt5Z5i0Bw96lpqiOkRDLx
	3BgHOG9NOLstAcd4/oD3kHShz5xLQlRy5LasHPhe6NpA7OGSsJwf0m2fGK6ama11
	h3+F8RUEBTrToR2Q4Bs7MMu2kaKFFVef9VwBj8DSVXb8VDKyiP1boLUHemOcOPzD
	ey292MGsQ6lgZh96DQZR4tsgFwaaFU5fdToBCfn6XuwR0CYyWrda+lLA9VMJSrGC
	+twBnXvt6mO//avf4pRGbuEg2Q8xddZFBgqNWTfXdK4RWARItnTwZl+iaYHFTSj4
	TvNNKfJfNx+ZWvJeMS6w6vKwqyjTWzHWro7tJLusU7s7SjpIrMh+NtKSKWkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742502424; x=1742588824; bh=UW7sA99uKIoP7agNj/xy0Y98zNzwhIM5O9l
	KzEBS3rI=; b=fuT7Ace453fjONmRRIbA1szB3Bhrterm7xHKbc0U7DiAP7bRrLY
	kLBTogsczDIzn0j01qgqYSAzBD9SixGPrmBULvu/43J9l+3ZFeEMdTeNZ7NF7vaI
	KEn0/rZVK0zV1rcJmvL9P8Rg1fX+zuswkTBGVyGYbLT73fImHIi07A8cU6wrUVG8
	DTjsTlm4xiygJaOH06dBJmFPkAc6pVbiOvPUUqE7PuKGU+JH+xnWc/oMGvpDxmjv
	CPEeCKUZyPN5iImvPX29Vs995VEHhWfQFeFZ7HVO0ECJsv0d7JLGY1d+tA6scha2
	0/gOdHzxcwghehd6RJ81YaplbjQERv1OIXg==
X-ME-Sender: <xms:GHrcZ1ildwGO5WkkZlyNBw6zVp68VRY99OhAWzU1j_7hpJ8WTT5tkg>
    <xme:GHrcZ6CSlCOrmaOuUOsXvpudsFreoZzX7K2TW0N4Rpg6VBVV1WEYA1ypZv2WmNe4g
    6pw7ufFJwnVEPxmPg>
X-ME-Received: <xmr:GHrcZ1GG3oTWijWjbaMofkOABUENNvy1EELYvXCSOAubC6IGZIN9ZiMDanLSIIgejMlTisqCz_KEX-pEMY31JMO3l-9u8-Ly699rE3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeeludeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GHrcZ6Ri-9RohP35doBCYZvzNSo5i08RSkUCdyBjrzdRJYJ7VXW0eA>
    <xmx:GHrcZywcHO1E9xWR_DmJjVnYja5kV7AbEjUlp_yRS7-47esisjaAHA>
    <xmx:GHrcZw4jvteFwq_73Ucb7CPnhVbfEAzJKJv-M5A8NYMBZid0n9U5Mw>
    <xmx:GHrcZ3wS-ZbI6YlUZVq2DXIaOfOlyHEAwfKj_f-mH2CO83ATLYxjNA>
    <xmx:GHrcZ5qSunGc5XjEGLdYrIgcDwT1M-XF6Vf3j4rC7QEmbtR1YEnhv4gW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 16:27:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH] install meson for Documentation job
In-Reply-To: <Z9qNNq0p10YJCZYo@pks.im> (Patrick Steinhardt's message of "Wed,
	19 Mar 2025 10:24:06 +0100")
References: <xmqqv7sbfra0.fsf@gitster.g>
	<20250314184130.GA578421@coredump.intra.peff.net>
	<xmqqy0x7cg9h.fsf@gitster.g> <xmqqmsdi49h8.fsf_-_@gitster.g>
	<CAOLa=ZRODjYfDXQ8m+hDosV7RBGDWeehzSvsR-+-HCmbS+tAcQ@mail.gmail.com>
	<xmqqiko613a0.fsf@gitster.g> <Z9qNNq0p10YJCZYo@pks.im>
Date: Thu, 20 Mar 2025 13:27:02 -0700
Message-ID: <xmqqv7s3xxbd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I see 4451a164e5a (install meson for Documentation job, 2025-03-14) has
> been merged, but as far as I understand we also have to take Karthik's
> patch to fix installing dependencies? In case I'm correct, do you plan
> to send this as a proper patch, Karthik?

Yes, once the Karthik's discovery is properly fixed, 4451a164
(install meson for Documentation job, 2025-03-14), which is a
misguided attempt to work around the symptom, should be discarded.

