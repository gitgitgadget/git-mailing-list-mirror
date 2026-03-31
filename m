Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FBB3321AA
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 22:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774994612; cv=none; b=ECwF47h63NWaI/Eq7IRkkrSOzWnMB3c2BVZZHVqiIxu19JA4iKQsRIU/biyrwiyLlHXPEQfEnsc4vLDyVljWWF3eTEs2SWGqm6gLUoLcLXdkVGh2n9yDMbTPCHGMFwVXlApC3mXdDgaUYIlsCuXNuEugtv0YNApgab7DCpbqCzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774994612; c=relaxed/simple;
	bh=JARR47yssmgkROmhZOBILLupyI1ihY6pHIVeiqi0/hE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LPWsrwPj0CPRX5pBFuxAuqK4Zqpl8HvJmC+R4YKpeZc+W1YH3nRZ8JTtXrP4D5vyx73CWZvERJfekMzfHnmGcT86VT2lT0FWOa9+nbeBnQ29d8Y5NNqMLSwBNFi76OURKhGlYStnysakgBa54/f8DgbyEeqU0uIIILx0ylsL8bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LX1iHa26; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qQKaLc0G; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LX1iHa26";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qQKaLc0G"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 0F7901D00124;
	Tue, 31 Mar 2026 18:03:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 31 Mar 2026 18:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774994609; x=1775081009; bh=Jkqlncp6eM
	4Txjh3qef6olXor+CXpT43OGa3HqatdvU=; b=LX1iHa267DKP+kbMpR5zhSlfX7
	WCMMBDHxI4EUymGHJLtAUi0B2sbiJGNXTgR/YQOp76PxM0kM4b9Ray3yQtPqyX8B
	q/OohKa/ZVVN9r17YT3ktou44M/zphqmog9gRDMzz3UB5ZaEfMU4KSPAt8RetSc6
	vQwt6vpc0CNi2bisa71kFtZydAG7ejOGqD3+EuvsHz7lHUC/HQzLOFHg3JcBP/Or
	GBDuBgaCTJS34GbgyQuIiEQGkOStggFcM1MoPOTICf62LegwP+UuI2PIVIm3ISNL
	usvgZAPUX0b0RfkZLFkrDW9WP+rsxkA8uSH84qLHapCpLriCsAyjNzjNtqPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774994609; x=1775081009; bh=Jkqlncp6eM4Txjh3qef6olXor+CXpT43OGa
	3HqatdvU=; b=qQKaLc0G10dIZ/D7WkH62jShvQuiK8Nw+gKl9X++8aVwpWvebjB
	QzxvdYyoYdml3lC6BVZXSTP6wFar2Bubdu4JjN6sss+Y1rptFNMHzTpQNb8aplHr
	SA/73ut4ROQf3tPRtoRGcEK5rij/Mt2w+/rQcJxV/f+M+0h33hsm8ZnyyVBLHOTH
	AdDbo3r6SekbNQ470uH9XrmiJguUh9HnwUb4gAIn3VXftIMNia5tEsiCefWLzwtv
	QHmzz6r9OoW2XDEmcOcbRAF6MNnBrZz3oOLP1ed96prMxK91EsjrklveUYMWwd7d
	MomLatTAnkC6ob87XeMG1TE0PX2PDTE+Kgw==
X-ME-Sender: <xms:sUTMaW0zFPPF94fdvJy8UU3iKlEaYrbQ0PlvgAohE3N79hVaS35SiA>
    <xme:sUTMaYLOsiI-M89UwZ_57EHIZIoFbPfarseoMK3m_qlxnjraZiPQA0pi5JcFq3xUJ
    lsNUoZi6kCoymBuW_vtkf_Rd8eseBer49_WP3pNHXVi7EZEKpeIhA>
X-ME-Received: <xmr:sUTMaVF3DxtRU3z4FUMlt6VavUHAFf2aTbTM7ztQaGO8CCqgn1F3JZiVo4PgHk8oqK2kvVDhiA8KBwR9E_PZ7AJD6vAanWZGuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholh
    esthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:sUTMaUWxXRwHP-I19nI_aa3Pco8q8hb3DS1goMJxCBdaaik4Xu4iDg>
    <xmx:sUTMadwGA6ucQt7zLfXGz4GC0ySx2X7v6bPzVuKdJhmt03K7GG0wdg>
    <xmx:sUTMaZSR-4NT0jUGVSdchhZ13NjGxGJjc8Wy61tIuJX5t9U0vDfvOQ>
    <xmx:sUTMaZhEG0a19cDynhntySh9lee6-1FP5v2ldboHkn0lB5yVw6a67w>
    <xmx:sUTMaW3tw7X6y91vTfT24iwP2S7_jl85VKEGasMIg3goge4feR_ALgjc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 18:03:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Karthik Nayak <karthik.188@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 14/16] promisor-remote: trust known remotes matching
 acceptFromServerUrl
In-Reply-To: <CAP8UFD2vAK_khTkJMP4QBfhYA5iYVW5sfB3i-vnzhf71BvwQ=w@mail.gmail.com>
	(Christian Couder's message of "Fri, 27 Mar 2026 13:17:59 +0100")
References: <20260323080520.887550-1-christian.couder@gmail.com>
	<20260323080520.887550-15-christian.couder@gmail.com>
	<xmqqzf3y4bsg.fsf@gitster.g>
	<CAP8UFD2vAK_khTkJMP4QBfhYA5iYVW5sfB3i-vnzhf71BvwQ=w@mail.gmail.com>
Date: Tue, 31 Mar 2026 15:03:27 -0700
Message-ID: <xmqq341fy7v4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>> Between the first sentence and the second one, I think there needs
>> to be an explanation on what "trusted" means in this context.  Is it
>> trusted so that the URL can feed random configuration variable=value
>> pairs for the client to blindly apply?  Or is it trusted to do very
>> limited things that other remotes can do, and if so what are these
>> limited things?  Without knowing that, the end-users cannot assess
>> the security implications of setting this option.
>
> Yeah, in the current version, the following is used, which is more explicit:
> ...

Do you mean by "the current version", the one you are preparing as
an updated iteration?

If so, let me mark the topic to be expecting a reroll.  From the
reviews by Patrick, I am not sure if I should also add the usual
"(hopefully small and final)" in this case, not just yet, though.

Thanks.
