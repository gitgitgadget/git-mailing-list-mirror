Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E139A365A10
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849262; cv=none; b=uHlhvVWAU3z7kAyHez1cxomyIyD7gki7a43kiRe9GSQzRfiRCuavIFskgQDdA+8zTJG3j7FpOt77eihUyp+s1lJ2Sz9OSrmas3WbcObA+UzM+KltJdRkfYauOE8/UKua64YsO97dyhSY1IMk2kfKMtlg7fm+YA5nl2h62h8HCkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849262; c=relaxed/simple;
	bh=bnTtVz4N9XqSKH0AP2PDcRPCFw5FaIfvSTd18O8chZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHarGMqZlNzq3m9l3HHGyBmcw6v3Bcxr/sTxJTJ7whniSKmgBwFMOZ/tsG9lUK//fxG1D/3jb/xp3qgzd5tPyOKd+tNpGhYvEH3EuNY1NngkKXdCmK8BBwCetO7cfDBhtUi89fRrNaMtGGMgW7H19T6FihiGkzfhOAAetwzEUbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S7huArRQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uERnHTjQ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S7huArRQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uERnHTjQ"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 31024EC05C1;
	Mon, 23 Feb 2026 07:20:59 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 23 Feb 2026 07:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771849259; x=1771935659; bh=iPRfHvA93E
	KsP4nzg7zXE8Q81Si6DOR/WCpwSRtU/t4=; b=S7huArRQfvhHOVX+ckKTRquigW
	mGKHn0NnhJevCCZN7JOqbkV2mDI2C7fsAG9O8tgWQyi8LS5taFq7u4jbL7tmtXXd
	N3JJ9noZ9zSPhL4EVOT5h+8DImuNGdrr9Ywtied266UTPhCww2xwsZ4MgW1G+802
	qk/kyF41fFOE6D6O8kKacTM8tqC3BLtGtMFuG5F90tJYit2zlQrlghAM90lGbPQw
	QWosAus1X/WC+i20IQi80OEzImA/y4yWNdDTsVJwL8E5JFF1OWizw8m2MGyx2XcI
	kqUZK6hKpL8eEuv4/kTKRSJ3j17IoEMbrrpd4oZh1OynSWYeKXXJSRqfUFdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771849259; x=1771935659; bh=iPRfHvA93EKsP4nzg7zXE8Q81Si6DOR/WCp
	wSRtU/t4=; b=uERnHTjQKkxKCWRS4mbL0NJ5s8e9bEZWztYu3nuH0A6Too6MN9e
	0nrg7GctSaFeVY04yd3KPwtC5EMIwd4rlqg9ZVRHrj3JWENwEBgxoImsN6JRFeAt
	XI4PlVyMr6SUezWDW4Rs9bn1rSdZswxQ2haZzZgcOGvFNXYXXwEJSaH8tLcvslAC
	4EtSYWHTimpLeihb4dVAW/NPCCTa7/PGs/15V4uIYFYo5apr6JQOMb4ksS1wncAE
	B31jf/Ha246rLjjRypcX0vQmTgtPYabZbw1QyUNvT1iSSMPqlMt9ifFKIG4GQrOs
	ina+dQ5oN0lUsk9z2PYqTQ72x/LFVUW3sHQ==
X-ME-Sender: <xms:KkacaVJWo9FkipC1ldcVJwQfEDnMN029EnnBKWSYBR8XvFLN1hu7ig>
    <xme:KkacaYIt4BTcV2xQwcr-XxkIYXHTqt4Nd6Z1eMu1feDQibih4QVKesUMeCnxmM86j
    LJP4IikQD0WZi6VOE-AvxpGS0fy0EVFKfqFnUKjC80vTk1G2zeN_w>
X-ME-Received: <xmr:KkacaSs6GGppG4IofNhMtBWey0SSlzaH0tQ7UPOrtCXHAkskF5Vmhiq2v6KjktaQGA68GRkmshjnEMOahOJpJqNe1IKM4Kwu2_BUpYNlcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnug
    grlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KkacaVR0V7PT0VEzgSD-f00OBdRYjiVg59-OV9wYwKU-Hmsh5sG3ug>
    <xmx:KkacaYM1cbFvHd4en0ZPgjE1xzfyiYukqeuOsznrt6A6EYazpH-PuQ>
    <xmx:KkacaabIoYB0jkACMIHpEVDjsJxDUG-fKnJC5A0i6kq8_0Z-DKbG0A>
    <xmx:KkacaSymGpSO8uU0HlSeAgkkJEg66kqgFDcUOVU6WWrwvxu5qhSPoQ>
    <xmx:K0acaSPZat5pVnyhS6xFMTdyhh-kA7_zBhb_H8IzcZK-ZKzit_Uo-Ffn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 07:20:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 484139ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 12:20:56 +0000 (UTC)
Date: Mon, 23 Feb 2026 13:20:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] t/helper: improve "genrandom" test helper
Message-ID: <aZxGJY7JH4Xwytwb@pks.im>
References: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
 <20260223-pks-fsck-fix-v1-1-c29036832b6e@pks.im>
 <20260223111346.GD215364@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223111346.GD215364@coredump.intra.peff.net>

On Mon, Feb 23, 2026 at 06:13:46AM -0500, Jeff King wrote:
> On Mon, Feb 23, 2026 at 10:50:40AM +0100, Patrick Steinhardt wrote:
> > @@ -22,7 +23,9 @@ int cmd__genrandom(int argc, const char **argv)
> >  		next = next * 11 + *c;
> >  	} while (*c++);
> >  
> > -	count = (argc == 3) ? strtoul(argv[2], NULL, 0) : ULONG_MAX;
> > +	count = ULONG_MAX;
> > +	if (argc == 3 && git_parse_ulong(argv[2], &count) < 0)
> > +		return error_errno("cannot parse argument '%s'", argv[2]);
> 
> ...I think the return value of git_parse_ulong() is boolean 0/1, not
> 0/negative.

Ugh, right. Will fix.

Patrick
