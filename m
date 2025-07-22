Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9904D242D71
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753190650; cv=none; b=lI+FF0s3W3z+P/o0Z9FvcT2IbzmAIgKCR9e1FT0GfgrJA3IghmZfvXxok3Mq+prsvoKM0d94kzJDldi6gMbIO0nWmpHy7tWpVfoUmN0VPtuyw6uQl+ejt5nf7rN3AMQiCVReDYBhu5B/Qb/KQhn17CRMrSpDxIhDe5Ydd/dhBaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753190650; c=relaxed/simple;
	bh=3BvUTrvJRrKZ2TMbN/K92X+bpCznaGmpuBhROZ3HJ+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PHlWuMgeRTpvd2KiQY9l98CpDK8vWjU3dE+Wn0XtShSfOv5NG8Yedx+2Da5wvJPaLvgSq4mJSso55mc5x/CkNdMDB32Ajl6ZVdyLef5UhOCGXyNO+sZ87b3O0n52ePSGFs33xa1KzK2tJf+1VQLuRXowGO0AhwCtIP0rFwAIM1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U5LzWp5+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jBefmIS4; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U5LzWp5+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jBefmIS4"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B5C7AEC0358;
	Tue, 22 Jul 2025 09:24:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 22 Jul 2025 09:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753190647; x=1753277047; bh=3BvUTrvJRr
	KZ2TMbN/K92X+bpCznaGmpuBhROZ3HJ+Y=; b=U5LzWp5+ToDWaLI6od7VOcRV8f
	kk75oYweQoqj3nooe39s3i+O17fMuOySSjZSt15SINJTN1Ub+WC5sZPIEiR8iy4G
	9SzUN8NHC88SWLsmmjA6eQlufhrV6kQhe9e0587WDM6Vfx+WkgFK3O0/7t+N5p8g
	MGA+lIkQ/MP8PKexTq87hCI82Oh5p+ttu76W8ZhIzHyJ4b+cgQChPb3cnXmA7fSc
	+s78g9GI867DqhxrKmk98nRQN+MsVILQGSwmtxxc5e0zULZ/NOO72Br16xJMuKsi
	FW+QkIB3bDxPMmGLXcC1+ggdENVDTiIHK/RvpPQcpGaz4OntCzmHF6YbEd5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753190647; x=1753277047; bh=3BvUTrvJRrKZ2TMbN/K92X+bpCznaGmpuBh
	ROZ3HJ+Y=; b=jBefmIS4hdSTdCQWPi5VWoA1Y13PrUMo4VhFm93tjCmOD0Ri09v
	IORf32rYab8Zgh2PRkVm16BH8LX8owy9PyNm2dAu6sNIjtpQSUG4nTfQLQQVnqIY
	Mw9DpP2e94EavccQs0YecU3zm6DNgs6gyLdkqqCWhlsPhBWyZdHVg4+Hbr/A+93p
	/5uNUFS/9b76vJWzFFvdI9MLR8vhOk1/dfQPArmTxA8Fh7HjKBxqbJpJf8UNxPSC
	JYUN+duAbR9cn+q4H7YtRN/aro7kuzikgZDhzYVCBHhcEC6j5Pdwt92/x+O2dh83
	XE+l5LOXsidc4382QEvS/hTe8T+/A6aKjRw==
X-ME-Sender: <xms:95B_aJ1VKAJMuePmt5Z8vcgcv7umRB9h16XltuBVgPlMRwLtbUCAGA>
    <xme:95B_aNpdFya8quNAy2O_b6cE-pmzEJQp-OLkS1qrYy-ZlWKtcEBLzsH_uFUjIF4yf
    9SwrZXmzYz3GKsGgA>
X-ME-Received: <xmr:95B_aAVA7FVCnNiYmQ7kBclekFzPAKbQSUC29mN2I6ul4-ahdslt35ge4NORg49-r-i4oNLSE90CGQXCsTS69umuxOSVfQTV4rORvZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejhedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgrghrghgrughithihrgdtkeeslhhivhgvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    uhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:95B_aIaUbHnomb7vItS8Ypgxs-H_rHb0QU2gXds9Y1uTMPVSFgIX-A>
    <xmx:95B_aNcAgbKqL2PKWMrKcGvGI-EIM3jDfdofdowGNBN4g7nFr2np2w>
    <xmx:95B_aC3hvJN_-denusAMMii9ql39lyjmAv1Npcet2QlO47IeupaQMA>
    <xmx:95B_aEJJn8M4TH272W1k9O4cI7TbAiLf6SmKhd5gmKXx1ow7RyjI8w>
    <xmx:95B_aBLODbc9AN02tKad0A8oJctfee7GP4Th5acCzKDKCqhwMCdldJil>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 09:24:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] send-email: add ability to send a copy of sent
 emails to an IMAP folder
In-Reply-To: <PN3PR01MB9597B8D3D84D9F7660F15E94B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Tue, 22 Jul 2025 11:44:28 +0530")
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
	<87a890182591c9c21061e85834fc99a766252611.1753092192.git.gargaditya08@live.com>
	<xmqqpldtxsp7.fsf@gitster.g>
	<PN3PR01MB95976A7BE0F9A54E836FA2F5B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqq4iv4x15e.fsf@gitster.g>
	<PN3PR01MB9597B8D3D84D9F7660F15E94B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 22 Jul 2025 06:24:05 -0700
Message-ID: <xmqqtt34uznu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> I'll rename it to imap-sent-folder, but the name looks more like
> it is only for "Sent" folder, and no other folder can be used. For
> example I like to keep a copy of the emails I send to git mailing
> list in a seperate 'git' folder in my mailbox. I can set the
> folder name as git, and thus have a copy saved there. What do you
> think about that?

Sorry, I am puzzled.

The reason why the option "--imap-sent-folder=<you-name-that-thing>"
takes a value, and not a "--[no-]imap-keep-copy-in-the-Sent-folder"
Boolean, is exactly because you want to give whatever name you want
it to use, so I am not sure why you are even asking that question.
