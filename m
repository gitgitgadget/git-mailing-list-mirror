Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2296A10E0
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 05:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729573373; cv=none; b=VIuan0Sb5ZwEJb2bxJ1BonOS+jQFAZXIbiAJI8DctN4WT2MOZkwd9meE8ziMhGcVs32ZnRKQsHuWOW0CcZW02C9LesiKVpBW5udtLzp/Dz/8CiXJ9cmrnNEfzZwF0Em2J6PSPkgGyssfZg4I3fuU8F+TBeYLSAYabAfUupNUt6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729573373; c=relaxed/simple;
	bh=apIminW1o9eu8wxTKLBWtabm340Z6+BCwxYYhN1xEuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfHS6krVo+VjaP7cj1C51FjcN0ZVl/CfQa3qe2662RvYf23IvGrj1yPP3sx9MLPSoAQuAttRWsEAVRBTS4FGpjUs+P8gXSftsj9xc0yHTQT8iT8cyroXzT1+21zx9m2fiAV3A+ysYv6tJL+LeLTJ6anr0VxQrF8JQQhuxUpOtAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YordLSbR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dOUuoRWb; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YordLSbR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dOUuoRWb"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E81511140202;
	Tue, 22 Oct 2024 01:02:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 22 Oct 2024 01:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729573368; x=1729659768; bh=K3qnnN5QYt
	tpd9FcLjYWOf9KARfOJBA6d6FA+NoFEMw=; b=YordLSbRrTRdkwXQcCOuNoCl0o
	yT19a+Eky6dy2ZmUQKMdWMtLLq37ybS5KNF3OE22UdW4FZHdPgvqiVfZQgLfXqvc
	ABvjPGGjDn+JxRx3Xr4tcdpJqQykOnBp1+GQQTAjz++CCdDARt9S0XYxTKydPY0h
	rvjInvwkkExA7AFpDrM1bLY3cnhkJZsnz2Z9Y+nY1Sxo5vxsxRD5+AWmACDlgi2P
	ZFgskIgmUikKJanAB/RI/6OCGUDfolyYP8k9Qp8D+NMGyfgqnjVi3Mc1pdlGXa2a
	hIo0FCdAPLHRQz5Br1/zAeCLj6eMwoJZyA/vzCtqdeKDvGXVK0zf8KeOOK4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729573368; x=1729659768; bh=K3qnnN5QYttpd9FcLjYWOf9KARfO
	JBA6d6FA+NoFEMw=; b=dOUuoRWbzAa1UCHLnEP0SpTHRvUC+6v0r8ZJXutuvTKF
	nMv6i45LfjhS8Pyh7hxccLKQTDOIPJEP7Poeds86sZ9r7yoepujzSpnYyW1YAdME
	HfLDZTbrWRJW2t1XWCh5JGjUEkZoMNIT/DQu4bYXCdbfGSzEoFCfDpZmtebsZlDq
	kFobRmPAMUXTQgibU0Ze2UvaBGry5x3iZFmItQGDcCqYiSvVBFSeL6Y8X4G42rZX
	ArWiCcr0RHab6AlSfEHSstWbhncBDaDERw0LPp9pqeCpafkGVYQOKygud4VbNgH0
	u52QqeTZGnsghsHP5t7pOJVHJJF1U0QgKohw1qr3Rg==
X-ME-Sender: <xms:9zEXZwRRj-rVPGir5t4ycQG3icQjMnpd1nIwjsq9gQo6YJl9mG_mig>
    <xme:9zEXZ9wydREePnWqAQmX3OPZL_N3yLkU_zE4h77b1dWKfgOXVW65C6MoEqsgXqYqV
    91p6dcUl271lSS10A>
X-ME-Received: <xmr:9zEXZ92nyFyXF-vga6q-nIdRIUlN7jpQcQmeZfRaHaK7w5MeApxGXkzbwNfLyKyH-AJ_Y8_HA_EF-YIh02dM9UmDWNpsff292eEapDVErEym>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeifedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhh
    ihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopegthhhiiihosggrjhgrmhgvshdvudesghhmrghi
    lhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-DEXZ0Bz33K1uZMOZ0PUn55mc31FGCVxaI4xdngQHGDVqtPqA5g0hg>
    <xmx:-DEXZ5hW86XqdV7dDL3stagWKWcfLWGNonnmdAI9GxzxkLoR9AX7GA>
    <xmx:-DEXZwoLb20c_uMObmY2NVQM1R6wVHcqemRyld34kD7rToz6MuFp1A>
    <xmx:-DEXZ8hACKi3vG5toK9MkXYQLXkFNhCMduUZeY26RDpYmNfTauaQYg>
    <xmx:-DEXZ3aAALqfJ_sbOVtGHRfRDC8z-doOK9-5wzQboAMcwXZEWrQ7oDdV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Oct 2024 01:02:46 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4a6bebf1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 22 Oct 2024 05:01:15 +0000 (UTC)
Date: Tue, 22 Oct 2024 07:02:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: chizobajames21@gmail.com
Cc: git@vger.kernel.org, gitster@pobox.com, phillip.wood@dunelm.org.uk,
	sunshine@sunshineco.com
Subject: Re: [Outreachy][PATCH v7] t6050: avoid pipes with upstream Git
 commands
Message-ID: <Zxcx6otjnmn6LLJ4@pks.im>
References: <20241014152411.11052-1-chizobajames21@gmail.com>
 <20241022012701.8959-1-chizobajames21@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022012701.8959-1-chizobajames21@gmail.com>

On Tue, Oct 22, 2024 at 02:27:01AM +0100, chizobajames21@gmail.com wrote:
> From: Chizoba ODINAKA <chizobajames21@gmail.com>
> 
> In pipes, the exit code of a chain of commands is determined by
> the final command. In order not to miss the exit code of a failed
> Git command, avoid pipes instead write output of Git commands
> into a file.
> For better debugging experience, instances of "grep" were changed
> to "test_grep". "test_grep" provides more context in case of a
> failed "grep".

Thanks, this version looks good to me!

Patrick
