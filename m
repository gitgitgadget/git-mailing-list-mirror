Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E7417A2F6
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753456847; cv=none; b=dWMHSflkwE0tnko9zugVWqXsbUvpyxdii2Op6QsmfvGUC3ar4QJX7nMNyvaNaAyYKyBBLVhm4DIyjff2lRVYVrV9XeHY0UdUIz41bbV/w5b06ZFnKrWcjGSyqjohyJ98Ik+B3Pu+kDtVEopVvUGE33xMxkbFYVNTzEU4Vzur+5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753456847; c=relaxed/simple;
	bh=FIWpi28YHye0WeHIlg1aTsx7Tscee1GC8EH7FRDe1Z8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sJ9Y6LudGMmrwlxCOOLfN8dJm04PYrAxbA+OWToYc/OMem4w0g9/AjpmRjw+QCsSJm0SpAkFOvNTAtEwyileAbmS7t7slLp4EylA+3v5Mcnd5U0yNgZg1aK6RiFTQrXKbKposP2S9gcdg64ObYcaKUJDtuI0kYedGgn0Yi1k0yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fyTsbDNe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=klW8gAo8; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fyTsbDNe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="klW8gAo8"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0D045140054C;
	Fri, 25 Jul 2025 11:20:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 25 Jul 2025 11:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753456845; x=1753543245; bh=z2TJepsxUD
	yTD9NBUHM249BVUXrqg8ZYJ5e38NfkC1Y=; b=fyTsbDNejA7PWOKoWs/RfEFdaf
	lCTT5IIylTp8saXT9FgoNWkOzkw4vXzZDPHCyHsm0dYeS17wIaKufm/VTuLnOyYk
	MYc6V/leyc1W7C5MMe+LTkg6jawzJGOiyC9QkB5ZCqQYnpy4fFQwZmnTiltiowuy
	cJHiCB/FssGcxx3JbJwp+NN2roCxnDVeXPWrjoX8l7Q/S3+Kmwgkvn63W/DrP02t
	h2u7VBwTuT1heJbmhFRZnYCKwdbHeEjGQF0q1h2BY3QD2GFc6fGhlfZYnCL62cHU
	itLGIIE0a5r96ubFxDriyK2nAw8y+KpciBoLiqABmpI72kcEK7UA8+60f0HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753456845; x=1753543245; bh=z2TJepsxUDyTD9NBUHM249BVUXrqg8ZYJ5e
	38NfkC1Y=; b=klW8gAo8hxU5ChR10EqxZOQZz9i4qNEcKQfpDPFANruBmDbh7NI
	1ifmyvOsX8zoJJx8tM4xDLp0nxEW6ZPnSgp9PYEIjP3NucYneWZvi+lOMEwxVuTh
	QW5prTqWU5Gu+Cmyl9FebwKawQz2TAYuDSltNJoUTeEFE8BVVZyp/4oEJdZDdwqk
	eQeXMcxecPL1NQ+xaduwN1fPWxfKFWEZd6HIJF4zSVYIm6X0S5qZzNB+rjAa4xQr
	M1OUpVS+wwzXrxMcUN3SyrsaMiswIiOJg+9Usg1huMY93AV3zYYE7NqlaPdfa4tr
	VVX+MuB6GYTSH2hLXRWg5ihR/7e+ap0cWJg==
X-ME-Sender: <xms:zKCDaJuEW5uq9f5jF6XqaHeqGwLgghCuRXG98kLtWkOuwW2YRgis7w>
    <xme:zKCDaK4SwlCnIeLMhDM1pIk9k0w_qa1KPp46CQdCJjmB-QnaeC2QuQLh6569ni2Xx
    LhfENWDLkQ_ZJlb7Q>
X-ME-Received: <xmr:zKCDaNO3v7-ra-uuMZaR9V1u63YnRTT-1MaeSN643p68B76hOwsI6a4jANRJjre9MOBpk5_wMVlHuGlIb4QyimTeODE3XMZIjP73wWo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekfeekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohephh
    hisegrrhhnvghsrdhsphgrtggvpdhrtghpthhtohephihlughhohhmvgdvugdvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmihgthhgrlhesihhstgdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zKCDaAumwroYpzYNjyTkCq3jGwwCq3BQFNVZYW1AHPPvxKrs0tIRqA>
    <xmx:zKCDaIazYpGvzbQHgdhOYM9YKGCYabQurXyRjpPJhCrB4fWK2WMwwg>
    <xmx:zKCDaKxK4VXSCPb5ukjR-I6vKvh-DHcJdLVlUIOTYtcDiC4Jh75Wjw>
    <xmx:zKCDaIhXYfcZlh30mAV-t8AntuCPecJ01b3aV-UuhFbvAz-rFebqhw>
    <xmx:zaCDaExYvLlO40vhgcFd333BfLYQCI3TTpuRmcfsVV6vDqY2co4vhfYq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 11:20:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: hi@arnes.space,  Lidong Yan <yldhome2d2@gmail.com>,
  git@vger.kernel.org,  =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?=
 <michal@isc.org>
Subject: Re: git-diff: --ignore-matching-lines has no effect on the output
 when --name-only is used
In-Reply-To: <20250725111139.GB3014187@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 25 Jul 2025 07:11:39 -0400")
References: <87a54v8nmz.fsf@arnes.space>
	<12095AC3-BC38-48DB-95B4-394F9F7DE054@gmail.com>
	<xmqqqzy6omul.fsf@gitster.g> <87v7ngstc8.fsf@arnes.space>
	<6A35A7CF-966B-4EC7-B575-86E6CCB68D03@gmail.com>
	<87ldocsnew.fsf@arnes.space>
	<20250725111139.GB3014187@coredump.intra.peff.net>
Date: Fri, 25 Jul 2025 08:20:42 -0700
Message-ID: <xmqqikjg47qt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I think Junio's response earlier in the thread discusses this, and how
> we already respect "-w" for "--quiet".
>
> I'm not sure I agree with this part that he wrote, though:
>
>> It is just --raw, --name-only, --name-status, and --checkdiff output
>> formats that deliberately ignore content based ignore mechanisms.

Ah, from the end of that non-sentence, something like "[these
formats] haven't been adjusted to the new world view".  The new
world view was described with things like "-w vs --quiet" that
changed the semantics over time.

> I can see how it gets weird when you ask for --raw, but ...

The "--raw" output should never change its behaviour (as that
designed to be machine readable, and the reader is expected to make
good use of the object names by grabbing the contents of the
blob---instead of learning a single bit "are they different?").
"--checkdiff" is about detecting malformatted code, and omitting the
path from output only because it is a patch that does nothing other
than making the indentation worse (hence with -w, diff will say "ah,
no non-whitespace chagne") does not make sense, do practically
"--name-status" and "--name-only" are the only things that could be
updated.

> I do wonder if changing it at this point would somehow break somebody's
> workflow or have unexpected fallout, though.

That is certainly a concern.

I won't be touching the code for this change myself, but I can help
reviewing if somebody writes a proposed change.

Thanks.
