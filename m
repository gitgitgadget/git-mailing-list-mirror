Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9460E27932D
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198582; cv=none; b=VSVJ3+Dgy3+FF43Dt2T9rP6AtO4yTX2EM+k1/1MkfXzeJLCkNZSVyk6F/v9F9vuq2C9vStClVAupFyxc/7/G1UBz4YW0g5zj31lUG6Ap4x+wvWw37j9v8SW9YIAn1BVlMYP9PlDAvBrafY7fMQ/8s94yNQYt3jAg64vM9pDqi7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198582; c=relaxed/simple;
	bh=KXG5trzWdgLlT9Pvd6iXZr0JOX7HcaCUUJJSnUvXqwk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=apmYZ9LverWYHVzTMfZ5Dmsp+0L26hHTZMu1qUuwBdUytxBU7SOfD6EXtTuwJSavRwZu62D2eR6SIAULfnUgw0iirJw8hNnpvuKKFG+bC8EHLbiHiF601wRMUqN35H65vCDfSv6/9tyhfKLN99lI3jDleafMUuphj/dk+eU7yGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=It54fbIF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QkeaMBKJ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="It54fbIF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QkeaMBKJ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B61CB14000F7;
	Tue, 22 Jul 2025 11:36:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 22 Jul 2025 11:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753198579; x=1753284979; bh=f1I6Kji7h5
	tYf0nyRr+i83pK9XcfgDxBFbE7ltsQm90=; b=It54fbIFh3EquaG+hbxM4+7bus
	PfP3f9hXb38/E4Smi+dngN2PAItXAQLNNbaYGzkPcY/gM2yBl9iuPmXi0CnM0PN0
	5TOPCqQ72Y57/WqBmPRY7LlnNnOwoDGoNh8+QOJTTWYgISTGc9wrgDvSvGcHOVR2
	SBweDxXe9cW1TlgAw5cRppNOOTEQzcRlpaMRkqpkDGXpMYAuqai+UhsNN6/jl5CA
	v/jTLvh9c5ORuGHpRQWrmeDVAglunbhi665KqKLZEA0ETHK4wn6yU6+2yqbt2APi
	fPsnTerkbUS/kqYociWDabZX6Q1Dx5Fo2noXB9paljltUdYSf6h+15wSimIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753198579; x=1753284979; bh=f1I6Kji7h5tYf0nyRr+i83pK9XcfgDxBFbE
	7ltsQm90=; b=QkeaMBKJOBl8ZVfr32VHPcIpXRrXf6Ielt91+00U6MhDWeBqWNd
	Y10X9LM0ZEhbNR99sE/tzJT5fsjf+zXXPuQHDFOEwKGc+wBfbH24SRhPSqnwXnec
	bS7X272+DNqxVAMw4RNkc3y9gDwRV/kTof53EqJw/G/xtDrWyMrP++ilP1yXMYzo
	ycsCGv0d/JlFX4dJQSsZpVlmkTT6J/XHb+65ddtYwcjqUEa5sIlRRB/NbJA06jHU
	c0iHbdbZHUCKzwp/gPIEjopbpJ8pG44aDGM1mBiUGKvUCbMRQ9ss8oZ+Jka+X7CB
	nJKO+hUH4pbmsLS4J6BGaZ/93SQtTT5o5HA==
X-ME-Sender: <xms:869_aBexli64KORAgkpGrbQGSALw0hLcNdF143foJahLr7oA4IOgsQ>
    <xme:869_aMzsu1epVU0rCfjmZnEbrHr3GQBfSX02KAQWodWZK8YcQasFKcP8Tqgf-4H9q
    OnTIaMNRl-RLjp3mQ>
X-ME-Received: <xmr:869_aA-JgvRNJ5qrD3tHjBaK0xERdnE_dki_0NTzZk1pgj1RSEsc8Rv5lu9zVwnJWsC0k_WJMBxN32Cf-AAkIsobCkc55WO_CBw17qA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejhedvjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:869_aMipQAaOBF4TbzAmY2ShN-QVvT4kinq3cO7BVlDipP7IwJhUiw>
    <xmx:869_aPFZvwhAuT1gXl5niG6OivJhEmonou6efh6PyaFZwAD7v-QJ3w>
    <xmx:869_aD8tTgA2eVRc9DvOQaI_YCGP52mZYCtWSQELbqXEw2zB-viP2g>
    <xmx:869_aOzYbET2tnz757zYspAiK4mtvA7ngWnOSNiUI2JjatONhXNTBg>
    <xmx:869_aIRgja1wGQV5S59wePregGuy593GRfFjUy7UzzpHnoQF-YxqOuKs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 11:36:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] send-email: add ability to send a copy of sent
 emails to an IMAP folder
In-Reply-To: <PN3PR01MB95973B291F0A52A19DA8BD49B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Tue, 22 Jul 2025 16:54:51 +0530")
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
	<87a890182591c9c21061e85834fc99a766252611.1753092192.git.gargaditya08@live.com>
	<xmqqpldtxsp7.fsf@gitster.g>
	<PN3PR01MB95976A7BE0F9A54E836FA2F5B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqq4iv4x15e.fsf@gitster.g>
	<PN3PR01MB9597B8D3D84D9F7660F15E94B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95973B291F0A52A19DA8BD49B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 22 Jul 2025 08:36:17 -0700
Message-ID: <xmqqo6tctez2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> Also, as far as B2 is concerned, users can already do something like:
>
> git format-patch -2 HEAD --to=someone@example.com --stdout | git imap-send

If the above command line is sufficient for users, "git send-email"
does not need its feature to drive format-patch and do

    git format-patch -o outgo/. -2 HEAD &&
    git send-email --to=someone@example.com ./outgo/*.patch

I used to think that way and I was naive ;-) But such an argument
completely misses the point of various send-email options that allow
the user to tweak CC: list programatically, compose the cover
letter, etc., doesn't it?


