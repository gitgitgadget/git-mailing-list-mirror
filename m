Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1973D347FEC
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211071; cv=none; b=EW4ILG8AePV9DZ3/ydU8DXCaal9ePvErZ/h7rwMC+2AYZ1QQk1xwSxDEbf7Iywn1n3dmvuN8p6tl0NH15Jh/TJKTqH6pgdEyind+qjjhWcHuFgOitNMoT4LY51OAijzD8YC6VcN1axwfEQWLLEi/xmxGTtCMVaJsNV/pOHQB1qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211071; c=relaxed/simple;
	bh=XjiQ3wEcXKx+1plshOU9sLkB+bFJokaunIOgEDfxrX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eKJ5vYUvn+nqKb9DegXwlV0Z5pzjxb9NcUhBFk0RgMZIBna7D0Mn3jgvBSYFK9IX7Hxj99hRxRRRaztF43uDkgs9kuMut73M5IGRrXwhDhG+BPUodZBkafO/BD4Ehro3JKCIWzueECK5bH96jvDR8cMxQmoGxRjJyD3Fm2BHAW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bc9avJPi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v+uU3sJd; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bc9avJPi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v+uU3sJd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 35614EC0090;
	Fri, 27 Feb 2026 11:51:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 27 Feb 2026 11:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1772211069;
	 x=1772297469; bh=YV+1t2FOe+p+PtOPBWNR+G78fDbWOWUjj1iOyejFhjg=; b=
	bc9avJPiEpZwhVJy4GBj+FnaQVxGtTLRwVei+DUCVrq6H6U97lXo5uqf86CuGmCe
	NQq/ExcSilTVPobOodf8vwxXTKYEwzY9Uivwods1T8QGVxJgtcZaI61rzPA0GgH/
	16MDqPj1kmjdZQseEHSzP8970vPjD+h0Sq/n7w7DnHEBoQIVaEldTnF/JF4HSuLr
	swpuoremCpDMEJg6uPVsjy6nhhL399pYhqz0DD2S5mHTzomZgkVpJTnATCaHp1kN
	4LZn5Mtbw1IssajX0jcVl4VeD0G0RalyAEPrPsAv5e6yyhswLRbC4h2dqOPqHNEx
	ryEWHx3+5ZQ4JOsPS9qR9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772211069; x=
	1772297469; bh=YV+1t2FOe+p+PtOPBWNR+G78fDbWOWUjj1iOyejFhjg=; b=v
	+uU3sJdd+/E0vWbApd6RQEvyQOPT/kuUdyzCKGst/dGIrpdK61cColJ0SiMeCqBh
	p7Ae3LyGpJwHgEdwJg0Lx28ErMPdw6ZwIh3KZksSXXU7bna4AK7Q9DDHbGIHbtww
	NHJFt6L41PI1nh51H7PN3GRJyucS5m5nNK7FzPuGXRHiMa6YjV2JqpF+HCc3Vt1t
	uPArpn6DwzjECPbueYr5SaPV10zb+r82JEIWYxILv8YkPpfhfOF8ZrpQUXpPgTQz
	NP5T6HYBRJUOjbP6nxaO84nvJcr+d+BDhZvFTLcgG8Ltpi0/gDiHE55DfB34hR6o
	pDVCGebAXWL8FJlJQvCDQ==
X-ME-Sender: <xms:fMuhaRz2901Bgj3shmwr5_nEzDe3RXnzJsnIfW7noV01tTCTaUQPbA>
    <xme:fMuhaU8z8hoRFmP0hBmU9tuQOOlpd_G_7cj1EONJwJma1Y7jJ5lHzctRHtFHj_12D
    Yb05uzK75KmkOG1oQLlT9n0Z22GLoVHSMwW6k6I2dTRFgqMWyDKk7E>
X-ME-Received: <xmr:fMuhaVIt0Cql_nIagZTwyGIFoAWM64Jme9FnEOu0EJXVIJJRtZY3lzX_kN0r69XAf6enLooBTavU0FGucbsbnwvOTzqc3xN8Vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtph
    htthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:fcuhaadn4Ap7mSWPN5NbEDpyPVXvkPulxKROEZn8NtKLDQXZpqtMdw>
    <xmx:fcuhaU_7FQUZndRnuj-VHIa4ob13gugnSuW-8OPCnjKQX23Zl-vZWg>
    <xmx:fcuhaXoZKajpfyvxpzsCWYgXmbHdYhfgztxJnSFpD1QILP3-bVYbYg>
    <xmx:fcuhaZDr49w1iUmGwqfrNZ0sh_X4bpm7NTYInQt_aJLzl0oSh1iExA>
    <xmx:fcuhaaPyRP2AcJ9QwwB4nVJsWFeHdd-S0CU5TzXm6zY5VV85RgDLI6YA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 11:51:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: kristofferhaugsbakk@fastmail.com,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] doc: diff-options.adoc: show format.noprefix for
 format-patch
In-Reply-To: <ff86f877-4b75-403d-a5a4-10ab528a9691@free.fr> (=?utf-8?Q?=22?=
 =?utf-8?Q?Jean-No=C3=ABl?=
	Avila"'s message of "Fri, 27 Feb 2026 10:57:58 +0100")
References: <CV_format.noprefix_boolean.39c@msgid.xyz>
	<V2_CV_format.noprefix_boolean.421@msgid.xyz>
	<V2_format.noprefix_and_--default-prefix.423@msgid.xyz>
	<ff86f877-4b75-403d-a5a4-10ab528a9691@free.fr>
Date: Fri, 27 Feb 2026 08:51:07 -0800
Message-ID: <xmqq4in2t9j8.fsf@gitster.g>
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

>>  `--default-prefix`::
>>  	Use the default source and destination prefixes ("a/" and "b/").
>> -	This overrides configuration variables such as `diff.noprefix`,
>> +	This overrides configuration variables such as
>> +ifndef::git-format-patch[`diff.noprefix`,]
>> +ifdef::git-format-patch[`format.noprefix`,]
>>  	`diff.srcPrefix`, `diff.dstPrefix`, and `diff.mnemonicPrefix`
>>  	(see linkgit:git-config[1]).
>>  
>
> Hello,
>
> This kind of sentence assembly does not fit well with translations. Each
> hunk of the sentence is processed separately and it is a difficulty for
> translators as they need to understand the surrounding context of a
> segment when translating it.
>
> It is safer to just write the whole paragraph, or at least a sentence in
> the ifdef/ifndef sections.

Thanks, this particular patch in question is already in 'next',
though.
