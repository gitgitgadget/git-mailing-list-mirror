Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F072533F370
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543042; cv=none; b=B8TK2sU04pEILNp/tkhQe2e0p7YBP7jY377oLD39maLHXIhWrvK41hkZlbMomt9V8QnRacA6uevr5Sb29ncu8byAw/NdMnBn12hM5x1dGxfDXELIpSmP+dAPPqYxS5lAp5bfMagwjVtNGmLC8iUL7/6ZAuunY9Ws8KioBBizaek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543042; c=relaxed/simple;
	bh=YI/dxi7H2BTr3JIcpgpsw+bEDlBdRPsq8/tOGxfEPGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g3r7XqK6t3NyPIaNxKStLUfh0zXFX8caweO3aT1R6Wi4lC+dsNfkhUpkGR1vX73z3SnSymqyEMZf17+YTz1yDvA/qHMo+jeYOKXt89rUoETo6rZySbPAF7PhhAcaAHTiDKehLKXCtzsAl5KTvAJg+FaeEfXFP7bjSR7jD6SMgXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b2WFSfuT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OCqEA6OZ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b2WFSfuT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OCqEA6OZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 23728EC016E;
	Thu, 26 Mar 2026 12:37:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 26 Mar 2026 12:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774543040; x=1774629440; bh=3lcq7WnmI1
	eLcp8Xx++rhPxYsT9IF3beLXY2tXZG9Cc=; b=b2WFSfuT8i2osbzE1XofbAKe4w
	JT7m9H57Klhw7Fkw5Z2Vx3DM6hYQGY+wEmW6+k8LYTvHzNEux97yICDO2c6VAK/m
	9xWyQGEK0osQI1M/93Rccdkk65kxZysfyKSTKK0PAcL4EX6th/jaSafJTv1pgjAq
	jVmF3HWqvDCpJmahqNeRLmRu8hCp8BeY3TKLG+aRKzBUKf8FCdkEGwFYk8O4aaF6
	Cx36He+2HO3a9FD3f4yeWkgUtTnSxwgK5DE7fhA0e7zFpoPgwEtVn0k3CvG9Wg3o
	dpMlLR2kZS7qR7VmAZdWDo3HFyifZ0056s/98aebancEGtZX1AONHxGUNcJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774543040; x=1774629440; bh=3lcq7WnmI1eLcp8Xx++rhPxYsT9IF3beLXY
	2tXZG9Cc=; b=OCqEA6OZSYMz00LEr+3KugowyBtQBJbxEOwi/eXqiNM6L9fcUyl
	iwaNYKHfee/w40fpCRo6AFe1ZcX9GPJjEKVncOo0twKdhSqIP+YE0f3EmUmvTIIh
	kpP/3g9MoUdzQR0FDlBXdFcj28eqrEVB4CtWvU9CmUIguwc2o56l4JGNfUvpAX3b
	KAvfWwdxPbcB+lT8dN2PDoRveVeX8fFv3Xcizgi5vBbyNCRfEw4+Z3UD1rJCIxqu
	vJjRShsRIUGW2nqRZFNk97cW+qyOhpO0mYItUKKb4MOu6FjZ7bkQlCXpD0asf/Dj
	b4KPSMmzeB42wDG2j1cnj59+GJ75rJuOjPg==
X-ME-Sender: <xms:vmDFaU-Z-APZBrdtgt751F46vYhFl_k548N9MpKU-aTdahvmCp_7JQ>
    <xme:vmDFaTknl_zhzO0LhS-VUygoRI2nkYJjuGdf6x1DE9XGmASLLvYpHPtT3O1_ztRla
    ozBi3yvhEOIHPrJUJ5drdBAL_B8D7N7CvVNtnHN0GaHs9BIOmQDHg>
X-ME-Received: <xmr:vmDFaSV8N5Oj6Bu7XpwFC7VzOc4ymn6Dhs9vWd_4N1_fPdNv3DPWL-o8DOvXXOn-Q8MZ8z8gSNedlslUsy1y1kdkW5_xtplXmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehmrhhoihhkseguvghlrgihvggurdhsphgrtggvpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:vmDFaQFE5pWUbMJCn1QFanJmb59-zrjJR7hX0IDD3GTef532CNx_nA>
    <xmx:v2DFaWeXJXiJhU7IIdRV4kDGmalVLNh8gDMoHomTSMeCVkAR99pEHg>
    <xmx:v2DFaZJa-NYMmxcDoJImVQd4q9botT8SrO4fUWypgIvWgasQuDmVhg>
    <xmx:v2DFaTEE7xlGg2mFI6tJ4TltEYhTuJfcGm7E7YG34IViko7YeRDebQ>
    <xmx:wGDFaa2yMQi8dOKJ1H9i-u9nBDDaAR1zxtTsZtsfjFl4qgxnAfBkor9p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 12:37:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Mirko Faina <mroik@delayed.space>,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 0/8] improve "git format-patch --commit-list-format"
In-Reply-To: <ad6a32f9-1b48-4bb5-97c5-96d1dfea3074@gmail.com> (Phillip Wood's
	message of "Thu, 26 Mar 2026 14:29:38 +0000")
References: <cover.1773959395.git.mroik@delayed.space>
	<cover.1774284699.git.mroik@delayed.space>
	<xmqqqzpa489h.fsf@gitster.g>
	<ad6a32f9-1b48-4bb5-97c5-96d1dfea3074@gmail.com>
Date: Thu, 26 Mar 2026 09:37:17 -0700
Message-ID: <xmqqpl4qr1he.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 23/03/2026 20:10, Junio C Hamano wrote:
>> Mirko Faina <mroik@delayed.space> writes:
>> 
>>> Not much has changed, just applied the suggestions Kristoffer made.
>>> Thank you again for the review
>>> ...
>>> [7/8] format-patch: add preset for --commit-list-format (Mirko Faina)
>>> [8/8] format-patch: --commit-list-format without prefix (Mirko Faina)
>>> ...
>>>   Documentation/config/format.adoc    |  2 +-
>>>   Documentation/git-format-patch.adoc | 19 ++++----
> I've just had a look at what you merged to next and it looks sound to 
> me. The tweaks to the new feature in this series are very welcome 
> improvements.

Yup, I tried "modern" and generally liked it very much.

The appearance of the list looked a bit odd that each element in a
list of things with heading was shown without any indentation before
the heading, though.  I'd probably use

    --commit-list-format=" %(count): %<(72,trunc)%s"

or something like that myself.

I seem to be getting spurious blank lines between the lines with the
above, when I lengthen and shorten 72 in the format string above,
though.  I haven't figured out what is broken, though.

