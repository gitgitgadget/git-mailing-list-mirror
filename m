Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1E63D3B8
	for <git@vger.kernel.org>; Tue,  6 May 2025 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746568771; cv=none; b=nB6Wk6CvX286+PWfYvXFPhHqX2n+BPF16WMZ7zBgC9JuSyNd1AsHq1zYEe8Un+grraYfeYN9yRd5//lrO8iZroWAM236TDOq+28zqrjUhzpKjllJfirZCTbRkPof6fj3x7Y/qi5+w5/gc8eyRcBhh92HisnbLrNGHILrKbD78SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746568771; c=relaxed/simple;
	bh=UT0WBh8d7p5YDldWlhAid8SUi+gI+CUigmVsIf9M75A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p4WGPubXXe5fWzEuATWcqsxuLX4hO1g+g+O1iKAKOFKS9yCV4QrCEGsob3TrO6maN8gY4l3SQ6sa7Aad7oWHe/OzGGABB7RLPXlu/mNQeD6X1y+8RCU/sKbFQw745czYnoEltpqPdhPXSYDh8LHWBntefnmRFpJJnd7d4mSx61M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pj3uu/Ei; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YxKJUsFS; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pj3uu/Ei";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YxKJUsFS"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2435D25401E1;
	Tue,  6 May 2025 17:59:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 06 May 2025 17:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746568767; x=1746655167; bh=zScjSyEPjV
	H2Z1O8Fksw01HmpOHrItljW1B0YAsSCoQ=; b=pj3uu/Ei2RZmPP8L5w7vOFKmbk
	mpEojKozLgm6FWNT4c+9nt4bjdQUtmCe2jt9/M4SqfrBLaa2k6D3ChJgBHN4SzEl
	he39V9xbt6sgFBmd2AummBKKldpKRmCdPro4U+dpFnuPP2jldjT6Cnr5ID1wP2kX
	Q2WkrsBokIXro8WNHqzkzbWKv5fchYsOPw7QxMk3iU+1HkSyUpPVz6K2wS1M4Mfj
	LZ5jcQQmDwn7eoWeHouZKs74UZ10CF/mtMqVq24LM2s2ml5pnEwxVMQW1qqlLjWP
	3Nx0HVvpwegw3i9EXv/rNIe9jqCOnJt3NzNw65CYAMV3wq6rfbAGjaOH+THA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746568767; x=1746655167; bh=zScjSyEPjVH2Z1O8Fksw01HmpOHrItljW1B
	0YAsSCoQ=; b=YxKJUsFSO/kc/1GPtaH4tInfET0J4HHOZshKq8DLb8JnZ5P2adp
	vKU/TZUWcsr1vHGnueHZ+pcwlFncRKvoFZYYSFSY//iWBhQVWz0MBUKYX81N+1wZ
	aVRYzp9zStCxEk5nYUjzk0bQI8HOyqa1LE3/ZLTco9ld/jYRB7JF0XP/HsPfVYut
	jGkWYc89jXb74Ozzpv/zXfUVuQ8bgebyeyoPP2Gx9g/NrCaN/WpG3ylZUH+26D/j
	znn/IOlyG52JmocaOaA9T1/3M3hI4QD4ZostW/FrgO1OBbwkmmLDwDlRHCmtOCf3
	oMrrZQACqdPadxnQFc3VfDvx5A7+vb90/rQ==
X-ME-Sender: <xms:PoYaaApLXUOIAV5t6LVBCD7QElERB8Yzbq0Nu9LCqMzdXSeLYN0P4g>
    <xme:PoYaaGoLUqEFZvXiXCM4H4rP4iDB10U4cf1eyKRtC33Z5k-uYdnIlMP8zAU19GBNW
    mLWUo0LnvXuT35-XQ>
X-ME-Received: <xmr:PoYaaFNwSM80a4vGFua-fp2Dl29f7YA07_tJIfDNugRO8pLMQDGH-zjOhALFsKtp5QcQwQqWBI6OeBUmJ642WQLpih-DePUkMAkx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeehuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrghgrug
    hithihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhrugesghhmrghilh
    drtghomhdprhgtphhtthhopehjuhhlihgrnhesshifrghgvghmrghkvghrshdrohhrghdp
    rhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepiihihigrohesughishhrohhothdrohhrghdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehs
    thgvvhgvrdhmrdhhrgihsehgohhoghhlvghmrghilhdrtghomh
X-ME-Proxy: <xmx:PoYaaH7RKSJe-aWs_IkTG56Goi8MDQ77MhX5dyK1xgdzYi-XnqCxww>
    <xmx:PoYaaP4qcb7EnhyQdKhUsZuVYTLJDowpzRhCGbQGuU54o1WkDk7b-A>
    <xmx:PoYaaHge3in9dw1CY7_FwhSmNlebtZWAwzt5GjlSuYV_ijIM2B3o-g>
    <xmx:PoYaaJ5aMPw7Z-8AbFLNVVowxLExrXaAEq3AujsDmWMZigwy9lSZag>
    <xmx:PoYaaGDxjqq88UN5u7j4oV0nXwggI9Mo_pwCZguj3oZMU4vdBLtGd5IK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 17:59:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  M Hickford
 <mirth.hickford@gmail.com>,  Julian Swagemakers <julian@swagemakers.org>,
  "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Zi Yao <ziyao@disroot.org>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Steve Hay
 <steve.m.hay@googlemail.com>,  Steve Hay <shay@cpan.org>
Subject: Re: [PATCH v3 1/3] send-mail: improve checks for valid_fqdn
In-Reply-To: <PN3PR01MB9597E09838320FF9F403D255B889A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Tue, 6 May 2025 22:20:35 +0530")
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597BD33DB2C4F3BE9E5F4C6B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95971B8A202ADEA412010B35B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqplgmlisy.fsf@gitster.g>
	<PN3PR01MB9597B15F81AC6DDB35546C2CB8892@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597ED4DA3E781A6EFC03B9CB8892@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597E09838320FF9F403D255B889A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 06 May 2025 14:59:24 -0700
Message-ID: <xmqq4ixxh03n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> As far as the script is concerned,
>
> - The script currently checks the presence of a period in the fqdn.

I suspect that this is overly strict in a strictly local settings.

> - At the same time, the script does NOT check whether the fqdn
> starts or ends with a period.

As a DNS domainname, starting with is problematic, but ending with a
period (e.g., "example.com.") should be OK, as long as the last
label is truly a top-level domain name.  I however think 

> - Also, it does NOT check if 2 periods are together or not.

That does sound problematic.

> a fqdn without a dot at all gets accepted by my Outlook server, ...
> ... afterall no FQDN would have these things.

True; we need to be careful here, though---after all the world is
not necessarily RFC 5321 compliant, as your Outlook server shows, if
accepts a name without any dot and is not a top-level domain.

So I think "one or more <upto 63 octet run of alnum or hyphen that
does not begin or end with hyphen>, separated by a single dot in
between each" (which is probably what you wanted to say in your
regexp, even though it wasn't clear to me if you restricted the
second and subsequent labels like you did the first one correctly)
would be a reasonable check to have.

