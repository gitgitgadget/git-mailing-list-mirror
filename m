Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A811474CC
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774629243; cv=none; b=RZlU55Sz/qLc6YmZ0kP9rGcJmwiGpBHIq1NIe46LyTKal0MA7MXQbcYoQLPjsN3zhPvlIKW+Xy/o9S0ggnT1uXGbYHuYnE5ZZ+OHPBxUhCvvJG3g9TPGRkljWh8L1h/Vi6RGl8zoGaG8K8zBItvWia5CzuTlWgk7NEs5Ki7zXFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774629243; c=relaxed/simple;
	bh=v3HuUoDaz1uYO1J3oCVLohdpFGJgcakJHYwkTe7obhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gNPXoHSjSInlEsDSI5aiLikCiQR+uu3lpdMTpy7kq7oof3ANiXnxCzgIj8DsqqDja6VzdKGvxBcZ4Lig4r3VMNTY/VYFSzFoJabM2yKPtvZ18PoWWzvtU2kf4v+Gbq1c0cOogy+6OugmOFjTN+RyQaHy0qlYoiuk0oTeYW67eeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S4BIwNGn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Je8gLtfD; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S4BIwNGn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Je8gLtfD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F1D477A0279;
	Fri, 27 Mar 2026 12:34:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 27 Mar 2026 12:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774629241; x=1774715641; bh=vKGI2dROv0
	mH5ob4fcO3Dv6zE2BJFlM0q7RM+yuTyw8=; b=S4BIwNGn94V0quYgQ1Cq7Lo5bV
	Lqi3ZR86TLU9noZkN9sTiaGBUSrAeSfliR+tNJhfx986DetTRqnvSMPwjknC8CDv
	PKDnuzPdmmzaW16DWNIkZ7LJy3Kf/qFco1NUOTLvkPYORHHZUNK5zQ6nH9HRvs49
	dDuzlQC3TicNZelBSsdxRK1KC+z93ljdg9QbL/dG7vzQ+tNd9hl8YN6r5OA1FYnD
	ampxxd9HXrkHy6gFP85YKhK/tE3t1Tza5mjFXFc+AZcLrrj3BDIEoPxo9/rwNcqZ
	mrhlnGio95lrBdSH+ui8qbY41tp228mk7rOpaXyqv5iYhbb8/V7juwJet/DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774629241; x=1774715641; bh=vKGI2dROv0mH5ob4fcO3Dv6zE2BJFlM0q7R
	M+yuTyw8=; b=Je8gLtfDCOYEVjc1PEeI4MjSqf3lY0f2pg/6Qu+Thk3pGwGBr0U
	QfTdzljrmlTB0rwzhHZgeakGmKC22WL5jf7lw/AgZzHCThm5COQT4bq82zNHA21A
	D13pbEnOc9ZUNFqs5ni5MWNdszJrJkKX656xv8JjHXnlleqtig96NDyEGLtduQ35
	N/tO54ZWuZ9QH2MYq/HoFc87YzINBt9fCSqpb3+M0vSBnHI94HT//tGdCeB8uzfq
	kTNpdzLnshYLuc28YNh69KK51ovCDL2U4RzP0GaYKovBvNvG1rTidLjDjz+b7pkn
	Ch05VqCpR73iSHxrBB8s7WZh6zAouD/332w==
X-ME-Sender: <xms:ebHGaazdSvOndaepmYetNrvOJQ649eSxAAhcb2A5eJlVfOh78aEIbA>
    <xme:ebHGaef6Ch83li0M_nVee-BVdw1z1Kq9h4aGUcBDISDdDh9Mpu3ie39h17NF6f3HI
    hJXdJ0bBRqQCkG8Umw61O8dB4mJ-orTmbLT9jXYckD89QMEkhKnGdc>
X-ME-Received: <xmr:ebHGaX4ghz1AuZfstuiJWuk9Kw-oRANBmrLDVKqTnZX710flthgwEzS2lvL_optwpi2UiTsboy9wJYcqylCx7dYwwnAfQjokJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgrsghl
    ohhoshgrsggrthgvrhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggv
    rhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtoheprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hsihguughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomhdprhgtphhtthho
    pegthhgrnhgurhgrphhrrghtrghpfeehudelsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epjheitheskhgusghgrdhorhhg
X-ME-Proxy: <xmx:ebHGabKPWjQOaoGVyH2wtyrvT_Awf-qWMpp3oL0LN9j8c0SjPCZf9A>
    <xmx:ebHGaXxeD3MhCQsvayQ25fiCW4NYET8Qa3numc86JhIYplZAwsYFog>
    <xmx:ebHGabJ1o2XmoFexqrwX8mLyjvprqhzYY1nr_Pqv6DLjV8l0xNPeyw>
    <xmx:ebHGaeUjOs4-XtHQT247NMgTR9h7DXSCEAmKxwuBAvi8REE2ONqX6Q>
    <xmx:ebHGaWT47h5Dw7oqW2qm7EzL6uGHuw4zb-jGHcSAeIok-yb0pFcVocZ3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 12:34:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  karthik.188@gmail.com,  jltobler@gmail.com,  ayu.chandekar@gmail.com,
  siddharthasthana31@gmail.com,  chandrapratap3519@gmail.com,
  j6t@kdbg.org,  szeder.dev@gmail.com
Subject: Re: [GSoC PATCH v5 1/2] graph: add --graph-lane-limit option
In-Reply-To: <CAN5EUNSyBjpZHHAAd1YGVRjkLwzgGzpafhBJVTTcHJCLKNU2gQ@mail.gmail.com>
	(Pablo's message of "Fri, 27 Mar 2026 15:22:06 +0100")
References: <20260323215935.74486-1-pabloosabaterr@gmail.com>
	<20260325174401.217577-1-pabloosabaterr@gmail.com>
	<20260325174401.217577-2-pabloosabaterr@gmail.com>
	<xmqqh5q3sgnm.fsf@gitster.g>
	<CAN5EUNSyBjpZHHAAd1YGVRjkLwzgGzpafhBJVTTcHJCLKNU2gQ@mail.gmail.com>
Date: Fri, 27 Mar 2026 09:34:00 -0700
Message-ID: <xmqqmrztkz9j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo <pabloosabaterr@gmail.com> writes:

>> Make a mental note that this helper function works on number of
>> lanes, not display columns (which is roughly twice the number of
>> lanes).
>> ...
>> And that mental note helps to convince us this loop makes sense, as
>> it increments 'i' one by one ;-)
>
> Ok, I'll add the note to graph_needs_truncation() and any other places
> that might need to be more clear about if it handles columns or lanes.

Sorry, I should have taken into account that you are new around
here.  My "mental note" comment wasn't meant to suggest adding extra
comments in the code.  Rather, it is "readers would make a mental
note here after reading this piece of code---and then what they
later see this other piece of code, what it does is consistent with
what they remember from the earlier piece code did, which is good"
(if they are inconsistent, you'd see a similar "make a mental note
here" followed later by "but this contradicts what we saw
earlier. what is going on?!?!" instead).

