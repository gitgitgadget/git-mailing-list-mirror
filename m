Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC99279335
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199769; cv=none; b=Iir/hyDXom38qGpqIO2tY75lY3i1+spnguWaosyNAzft7CwGWNjf0QDc7xmr02AoiM7f9ESodPxAUm3+1ASrBWR5/69n+f63iJtrJQ68baFGKmCV9GE9Cy7gglfojYdBmwQ4A/EnZgL52h/gUl0bvfrwCdJW66aKN7FtVqB6Zac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199769; c=relaxed/simple;
	bh=K49UslioShA66pLrI9nKfLmuhMd7ZjzgUflzQYyb8t4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PztaB/isO5kiojIASTrEEo6MoCiXIkjLdCdEp6hRVaSkYSDzVPeZjtd/KzWOlfVVfSM1K3eSjnyt91mcy92TbtCND60bWAvOfBccc8fMuqdAIzZ6qvZSVGmxxjlNHflFKa7HY/pe+UuZJwx2EVYrji6ifoaKeW5vPYhBqMyQ8Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R2LnSFtt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=avps5wza; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R2LnSFtt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="avps5wza"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id CFEE6EC01CE;
	Tue, 22 Jul 2025 11:56:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 22 Jul 2025 11:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753199766; x=1753286166; bh=VyFMxsmMSQ
	GyKmIP2EIIntna5iQFc46Jq5/Q3i+Q4t4=; b=R2LnSFttJ/z40qDGSW5CeESeGt
	le0KvklyXKzr5HoQqr5VnL555OXyZM87g4pz+hU5kojyYnCFDE9Mw9AX3D16GnMC
	jMuPTc4T3aR2Y6es9dksV9vtD8ep7Dhcg2xmeOD2JblBL2bGVg/BpjKUUxo9PAE5
	r9awX4mY6q3QQt/MpqyxzNNrRFtq6Z+T2hpjr6+grl8yeGpxMrZBrd9EBjXT4cYz
	USGbaMmjT+j4Wb1th/uYqtCjdLJ3S47YxbHZ4XzmpA6sNBgKf+jC/nB9gw/8m7dw
	mjnQ2MtFIWW0ONM+uyrfWgrOVOYLcO3/Dkcnx3fJpun9beb52q4wX2Z+IZxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753199766; x=1753286166; bh=VyFMxsmMSQGyKmIP2EIIntna5iQFc46Jq5/
	Q3i+Q4t4=; b=avps5wzaRvQsq5LQpr+Xpc26BJs6xbtLnPtwJc8qH2frNk/B98o
	rzF/scsgZ6TojZbPaqwqWr7j3l8LK1x4Yqvw6AeD2k4odUSsA7phN74eZOYUAnv5
	0b6wPCbVMUNzS688cFgGA3hurjBqDOLZm7Zvtp4N+EmKxVpgf6h5YkzRbTV+PNi3
	X4DuJJmRHp2UHnGMz6qt15LX7FS2GQvAV+7SuGcVNvwBP7NSPh2xN56FrD73CXjG
	e68VvYenS8AEIZjaYOYb5hV7XfIvpYzQ6fJfa8oeLaWO9sYnd4TcNaq7M5HjgUy4
	3olnkGLTl3qztoAsoUkpRTeKhalyunk1TGQ==
X-ME-Sender: <xms:lrR_aPh-m84RRdPtrzwrVA4MHozVoW1KKK7FBjR8FuosClPmnc8FjQ>
    <xme:lrR_aI-ddFzvODzMIt0M-R-CkzchYdSNLNO7fK5KOE3irmWgHwQS6QhzKKr6_hwXm
    9wivsATzRAL9uoXuA>
X-ME-Received: <xmr:lrR_aKut8tlZgDg4-V92ju-N8Ffv03VrXSIsl24FMGUNMS8dbgzWVR6oDx7Rlsax6SgE7ZNKbtEqPR0Fu84a5e-69xxvrTit8QQ33ZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejheefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshgrnhgurg
    hlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgiivghkih
    gvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:lrR_aEoiPmBLR2oURp-f0Dp2XFY6c4D-KoovKozy0Xun3VZnNzBM1g>
    <xmx:lrR_aGoTM3aFQ1hmiJpW2Bk8FHJRN8hj6x1d9mYJ0hPhprHGHjgGNA>
    <xmx:lrR_aLbQq4vJz1H_NblwWdB1xFVlpBt_ZKNdsQM1Z8eyLP8Vl5fK2w>
    <xmx:lrR_aM9BJ0Sws82OIF5xiwRYHCmdQW0c5ULj1nB2ucm_v5cpTPNBlg>
    <xmx:lrR_aNbOTxit5c6yItUUItqakluqpFJqs4ypYNeUa4c8AiPm-ylsqW2w>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 11:56:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Taylor Blau
 <me@ttaylorr.com>,  Ezekiel Newren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
In-Reply-To: <aH-CN0RYFmpm7fMt@pks.im> (Patrick Steinhardt's message of "Tue,
	22 Jul 2025 14:21:11 +0200")
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<aHlwZPbiKnakMN75@fruit.crustytoothpaste.net>
	<aHl4U98BBvpA5eKF@nand.local>
	<aHmVXDOiKzfKU8nb@fruit.crustytoothpaste.net>
	<aH-CN0RYFmpm7fMt@pks.im>
Date: Tue, 22 Jul 2025 08:56:04 -0700
Message-ID: <xmqqa54wte23.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Fully agreed. I've said so at the last contributors summit, but I think
> it would become awfully unmaintainable if we retain two implementations
> of every subsystem that we convert to Rust. If we decide to use Rust I
> would strongly advocate for going all-in.

True.  

We do not have subsystems with clear boundaries yet, and introducing
Rust in such a state would not allow us to pick some parts (e.g.
merge backends, etc.) and do them optionally in Rust, while keeping
and/or adding others in C.
