Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2C323C4E5
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751446268; cv=none; b=rR3ZKU1lQCo3A8kpH3ZGVRmFol1/HwpLMGtngBkyqpUuR1GE6GPTB5WZ59yY0qMnSQ0Ngju6BYXF+w8hdZoc6XugdGRqMcIcdX/Pu1WtM7H/5Gm0NBvu6X5jmI4ZlQOMuYKi2kn+kOtJhOzCY4Q+6znqvayiFfuoG82tWogOkLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751446268; c=relaxed/simple;
	bh=C9Shkq9sovK4sZYJFbMsZcdMvVS/GK4wqBu9MS+u21E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmcasR8s7zGMiGUlml3kXfnIQ4pTW0C3krWrfhrtiF36WRYxtE4eO0M1cDO/zSIVJiKw8/uYwpmx49/c4m/kyHd/1XT5q9dsmpDJtTKoRX7k+OLUzF1eo8WywwsZCSQ/A1Mw+nQR/EZ8S/4EH0gXosbdPZ357QCrUlv24jnRSG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LJrz591T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=emJbNqBM; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LJrz591T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="emJbNqBM"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3165A1400315;
	Wed,  2 Jul 2025 04:51:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 02 Jul 2025 04:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751446265; x=1751532665; bh=o1Zu+kz7ZS
	0ZGgS6qy0tfylIfaJPIMPXomyKIeYvJ/k=; b=LJrz591TbFvgCGKXzBzEHELR6E
	LjHXOeifBEqUjRnqOubUDhZDAUULdc6PjiVq+Le2u9vNfRAC245mm97IGo7vD/ap
	rT//7nmK2pXD0M73HAX2Uoq/IYfKrRoBVVzvI/c1SoJ5EovkrhMXXwl80ZPVVzaB
	U3s0oo8u1U6asX+ImNGYSq5wqcGkciPDLXGcLG9W4+k/nWzFGDyCFZbq8WYfW4TI
	16kSWjQ3cTK8PNOWmTQPkEprb+zn6wIZ1MlQIt+yJP2blRCjTqiXOXfl8xKHXZcg
	AEB8JrW+w80ynLrA+Dyf3uyaCCkpD3t+240laE+E0BqlHummelt/LCKKlfIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751446265; x=1751532665; bh=o1Zu+kz7ZS0ZGgS6qy0tfylIfaJPIMPXomy
	KIeYvJ/k=; b=emJbNqBMs5g9M8NHHyrWey8aA9v3XmjoZWBQcOeFA2pcFkQ0a0x
	L/tKMO22gm0dDY24rmoDE0yprB83acGqA2DujSv1WOh81+hl7vJAtZPaIuxgcvuS
	BODS2LRnLklISH+a1fDEQ68QBPan5tQ2BuvFeP+twA2TVH3CtMmYQB0l72NzCZxQ
	WFUU0JC9EHDMO9oSvXH7jyceB9Lp+AW9kDGntxz0G5AU2ZCkO+1dxUnDofuGsAC4
	X8mSn2ouE5Rdi5d9PUEerU4TwJ47vWL9QzH5+twN0x9DtKZ8hlm0QNIM7o7jV9IR
	HEMoU7D4po8cm/la/g5xPVMMYm6kgndHfPA==
X-ME-Sender: <xms:-PJkaMFoo2zf5jsmQNKJrmekgl57XTxPiMQNTVmUaHcWCsksoR1MdA>
    <xme:-PJkaFUck0mwU0UgEmSfoXw_y1f3-zQFSZNYxWk4VxU-U6w2zDmGRCKDdP4ACUG1R
    SPl_VDb_sIWYqc38g>
X-ME-Received: <xmr:-PJkaGLG00phJxaeY37CCysUTTwt9tIvaRTNWxyvza-SGVvfFPK83WQGQgebgICzDjsjvkef8KinqSZlyqY5O1YmVghPnomh5EmX4ZoTNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestg
    hruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhgrhigrthhhvggv
    rhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrhigvnhhushesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:-PJkaOHvokMpKRN3CP0wgldhN88RPxmyqrxnsCvb5lQ_Rld3oL1HOg>
    <xmx:-PJkaCUNlK0lEwpy64E5xzOtA7T99AJXZaooCu918T1ihtj4PpZcMg>
    <xmx:-PJkaBNz26AmS1H0ErqhHxhU-z4d9PbhAadMkg52QKcCtEtRYXJHDQ>
    <xmx:-PJkaJ2i9Kh-KhgEIhMt8cZgOjfUX6yINEbRT9VcTc_EdSEAofgVIw>
    <xmx:-fJkaCsxSO0QUQYwcPwCgHjNpNTLXdM_l3fhkXhheXnnAxO1v9nVLYpe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Jul 2025 04:51:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 328927c2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 2 Jul 2025 08:51:02 +0000 (UTC)
Date: Wed, 2 Jul 2025 10:50:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Karthik Nayak <karthik.188@gmail.com>,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com,
	git@vger.kernel.org
Subject: Re: Re [bug] pull --prune could not delete references due to lock
 file already exists error
Message-ID: <aGTy8qX9uvwWv_ap@pks.im>
References: <CAKkAvaw0sZ0sW9o_0NZdnZknS8M34UST3PetaPBQj5wwvJyjBA@mail.gmail.com>
 <20250625141849.78834-1-jayatheerthkulkarni2005@gmail.com>
 <CAOLa=ZSA273KGPnwZ2aRBU_ybcCTYogBHvUwpa+5CfDOc2bEWg@mail.gmail.com>
 <aGKdICvmKlumU0ru@fruit.crustytoothpaste.net>
 <xmqq1pr1lyur.fsf@gitster.g>
 <aGO46urHzZTZvDve@pks.im>
 <xmqqtt3vkhwk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtt3vkhwk.fsf@gitster.g>

On Tue, Jul 01, 2025 at 09:14:19AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > I bet there's also tons of scripts out there that just reach into the
> > filesystem to do stuff, but that's something that we cannot really help
> > with.
> 
> I thought you've done enough to make sure that common things people
> would want to do by direct access to the .git/refs/ hierarchy can be
> easily done with plumbing commands instead, so it would probably be
> a matter of writing and publicizing the "how to migrate to the world
> where you cannot write into files under .git/refs/ directory"
> document?

Yeah, all the tools are there. I'm not even sure whether such a guide
would be required in the first place -- tools are just what you are used
to already anyway. So I don't know whether I really need to explain how
to use git-update-ref(1) and friends.

I am of course biased here, so if disagree and think that this would be
required I might just do it.

Anyway, I'll hack something up and send it to the mailing list soonish
to get the discussion going.

Patrick
