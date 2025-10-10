Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52F326980E
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760111583; cv=none; b=JhNFQupqcj/xKc+oFkFh8MhBzSD73PbQFkNwgsX3MFIu751Uamly81/svKjof6wlWPBgdmQtKCmJeoj/jre1GjelV7OyYxvJAHmT3fKLfE3OnIf8wMtL30BgjQM6GM4rDQxhb+JqX0D4BWLRoFCXls1KmroYBSFTxUnoVVey5XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760111583; c=relaxed/simple;
	bh=1HNFIBh0fi3gxwapfAjryDKNsSty+4lGfuEyKigu8b4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iXha8rrHHMUE9Ng0jU0cy2ze7pUvGQfJtyRettGtfsmZjfc8bBmQVZsxoGxBeAKJjE5KsYY54XGW8cTnNf1fB8UYpFX5H+5bXpNF89cnvVO0NZJx5pw9k9K8vwrMRAdHF65ikh6UF4OQCZFKduM4FHKpNwQ0zlXPiuEgc1FxTYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MeVmpexV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bhnKzvRl; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MeVmpexV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bhnKzvRl"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id C72A4EC0209;
	Fri, 10 Oct 2025 11:53:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 10 Oct 2025 11:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760111580;
	 x=1760197980; bh=hHl3TXw3SC8uP3UNUG+EXupQwzdDEwwq6TB+Unkyi8Q=; b=
	MeVmpexVw7uwpZr3A2xu2Cu4xbacm4P2PN1daPzBxem81tLs1Z4zvORBpBB1Drgd
	m4MzdZvL+7rjDKECY+hEoJznkiOWjhj/W8deizkFABnj37rUlpppE9FPaDMgq7xB
	c9uRiV7fRtejhiyofi4TUHd55hdPIdonSQU2FJfDj2yPbajLiczBSoTN7N1iA2zF
	+QrL6PK68b+Fw4cPMmp4oBubtxiESNcIHU/EgkPHlrxhFbCtxFriOK9ueCVoFDP2
	a1nXiPXp3ViLi6zXtHb82fGbx9OCaulWENS4NrvpsRFUzViVZbm0cu90FGcsy7Yo
	1M1As9MTclGx//8L8KnIvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760111580; x=
	1760197980; bh=hHl3TXw3SC8uP3UNUG+EXupQwzdDEwwq6TB+Unkyi8Q=; b=b
	hnKzvRlWQuF98MmXXaMlOUbR6Bz6Wi/BAnXnVK75uJdgWqW1PiRiz+qxSWKMv+IY
	Lms23Xl8VZ6ZLHNY9wUg0hBL2/CvNDFRwuSF/tbC94FC5UiaRYR5v3iloBR6A8mo
	ilW6EloSGcVoEsgCbSaAAJA9Hh1eVJfV8Aif5yzbt8YgtqQrbQsKbA9+jtQTzihI
	3JU4Ai+NfAQKAAdBi3diCB+Ng7OXFyTLi0RJfiJRBdmkWT/0Ts8R9zvnBdWaQrWy
	5HS/GRoex7IMunbD8xfkEX1/XA/RZwsSygUKm4zsPcJvb84nqoLCmGj+iya5AIoB
	vf5YgrixN1mlJG5U9NMyA==
X-ME-Sender: <xms:3CvpaJTS58wh5H2XYPKcyMWWMe4c6zuvMq_9DkHrg0xkLlqDoP18cg>
    <xme:3CvpaJqHghkb0fjYYSG0z2N4CrDVfT4NHsAsMM9letx1lcDQ-0UAk0ZyJfMb1sEcp
    vKdbqHlEeGthhqipRCF7NjRXBi_OQo7MzZbNT-Bickv-4RNAz7Vbw>
X-ME-Received: <xmr:3CvpaHKrclMoay3R6rROuKEQtQqyvYxLP2ZfRdhuL8cHL3HzVWXR57nf7TZEAUa8NRoJPAuyMK61uX__q5wRf2Wa3Q7x51RHw10p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdelgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtph
    htthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3CvpaMqVlPxwIaFFSItTlRunfxBnYy5a_TlQq_HuipCkp-eDzV6eAQ>
    <xmx:3CvpaPz_JIHCmIeZfxxG1CJN8K_T9XmoVPUTED1lCZZyukaS6wGW1A>
    <xmx:3CvpaAPACcNPvmIb2rdH9wLZmBGL1SAuOb8Wj1arJEzIGfi8czVJPA>
    <xmx:3CvpaE67psAXpIRnCk1RdNgSZh3zHDpG7jbxFSLHZakAI_Tft1c22g>
    <xmx:3CvpaCEgIphfH51cT53Dc4Ye9JFl3v9kLI_6y1fqR-w-ZFu2pmYhUVso>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 11:53:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Josh Soref
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/3] doc: convert git-stash.adoc to synopis style
In-Reply-To: <bb0f530b-96f3-4655-8448-1d322413cd1f@free.fr> (=?utf-8?Q?=22?=
 =?utf-8?Q?Jean-No=C3=ABl?=
	Avila"'s message of "Fri, 10 Oct 2025 08:40:44 +0200")
References: <pull.1969.git.1759698702.gitgitgadget@gmail.com>
	<3f3e5a87e834a6cd1d5d7769bdd2c0dcfaa4b6ae.1759698702.git.gitgitgadget@gmail.com>
	<02383db0-545a-4f4c-9fa9-30a819a30de2@app.fastmail.com>
	<bb0f530b-96f3-4655-8448-1d322413cd1f@free.fr>
Date: Fri, 10 Oct 2025 08:52:59 -0700
Message-ID: <xmqqsefqah44.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël Avila <jn.avila@free.fr> writes:

>>> diff --git a/Documentation/config/stash.adoc b/Documentation/config/stash.adoc
>>> index e556105a15..7fc32027f7 100644
>>> --- a/Documentation/config/stash.adoc
>>> +++ b/Documentation/config/stash.adoc
>>> @@ -1,19 +1,28 @@
>>> -stash.index::
>>> +ifndef::git-stash[]
>>> +:see-show: See the description of the 'show' command in linkgit:git-stash[1].
>> 
>> Okay, here you use 'show' and not `show` because this conditional
>> attribute will pass on `show` and render it as such, not as
>> inline-verbatim “show”. Bare 'show' is indeed better than bare `show`.
>
> TBH I did not spot the issue when I did this. I wasn't aware that
> Asciidoc does not automatically handle inline formatting in attributes.
> But it seems we can force it. This "show" keyword should definitely be
> inline verbatim.
>
> Wil try and reroll.

This is already in 'next', isn't it, though?
