Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8603A1C7B7E
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725614732; cv=none; b=gyU96pm/2rQglytYeI3KT1yZXG2LyVJZOA3KqX0lLKiliToE+5Jj5QqRCwSScM6n4zeGgEBEeN7dA/b6seFiPCeXPpSZlM16HAiX3GRuSTgB0kiAQgnzuQmbY8g82S0bFzPsWhDrNx6g2U9bDJ5C1l+5JxaRfpMfy7Zfzj2zeOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725614732; c=relaxed/simple;
	bh=u2+17bz4CmHkMBhC/1qAS+058hT5JGG2g+2LebdJLAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeiRsDYHBlxXD81cMQAcUI/H/uMxLLIw5nEaj0hq3f2lsrrgY+m+dR0L7TOo5elaEBc4Ky83idvujURvhJOwmv9VwgL8Dhv0nG2LF8iy8YQI+KYzK4C3YzRUjDNYkVRld33KsTkTsX/aDoOqZxMvpgg9nw87EFTGokLY787Emx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cLZYbns2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PY8o1/9D; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cLZYbns2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PY8o1/9D"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 98F171140102;
	Fri,  6 Sep 2024 05:25:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 06 Sep 2024 05:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725614729; x=1725701129; bh=aFVDRijYa0
	JkzaDJDaxdoJnVou5bXMJ3mxMyVs79ukQ=; b=cLZYbns2onsPsilbUmb8k1mfPB
	OQj6+vqI7zpiUARtJ3zqTFUO9bilXBWI/ccgg1loDUTaeV2xo2wM1moA6zk4kA55
	k2vZGFeJh3E/urH0BtV7HQhEevGvlHRuHzYR1WI7HvKbQiWDo1rAt9W4F54ta+Dq
	1Tyn6IdNFHCtc13Cc9W3c9F8WQiDjBpncC73uP/auNRFWmK+AHJfMSQMkkOPIeHd
	hrC3OF6VTZGEtzuQW2P/bdyt4NJDpGfnJBu96vpqdOm8KFBAgpWMI7cXmpB4UdDd
	9F2v+8plssBkSkXXjaTTLCiNZijv1F0DQwrzFOUyPD7KiRg5O9DP7RF57DpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725614729; x=1725701129; bh=aFVDRijYa0JkzaDJDaxdoJnVou5b
	XMJ3mxMyVs79ukQ=; b=PY8o1/9Dj1EJhCNU4ZS/CkpLKCuc8sMl07EJBnJfTI6T
	5VHUzM+VmIO0kzQzpdmtmjK6xHQL9IjVfmYYDKZy39Dhu/Ak9w6GqKzFL2WUs2fG
	yECNIjg/0vvCJ1M9rpngDmmDVHhgUPzIM2X6+aHRxK19xMinxdvfYFmt6AjOrzor
	LHwOpmcCOiIx1B0VEH2MUTdAAn/bVj6WARc3Hgyqpu14txT6KwwTN9kvWogcpyNT
	sLfoYK2ZgGccErW7zYmJShr2ewAri+Fuze6DONPi4CANDjR7j0iodDX4q8y7OLOL
	94V6QJpv8hkMZuc6XQlsL+5Dn2VwUHruIb8wjYH0hw==
X-ME-Sender: <xms:icraZpH13uCHTAo8V29s2EDy40F9djW3O6ZTVxClzNGrdrBzSUvgmQ>
    <xme:icraZuXwMHe8fCcKsOlVxGnL1298tv2cujgt3tQttylu4wNjB9K48Yoxp6v9x4aHi
    JyuL0Lrpi7g0uRfOg>
X-ME-Received: <xmr:icraZrKnwFjlDonbqQW0FjSzza55HD_XIeriE1k8wQlje2p3-futfOOtpo9EAo1vEas4AWZUixJYA9qf3zyR7s5JwBgz4A1I3OCh6tnHDpjx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiuddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:icraZvG-rBmZIsF7kRz-KG3ys_H8TGu267ZW7WOBgmsMGL5oarUPPA>
    <xmx:icraZvWWiWI85POcY5sd3r0DWWrzviQgJBcV1TTF4O66hGguza6B6g>
    <xmx:icraZqMA-LJqvBm85RSjRGsNMUBC0S0hWvRQy23WaFox66WD7gapfQ>
    <xmx:icraZu1IDGddwT6kWhp1vILZkDMa78rgAhZtJ7lkJr-D7Afjk-RT6g>
    <xmx:icraZqS3lFSQuAVWEx_UPOFgMtEgj4q1G2RIU-UnUtU2W2A4c3DSfaui>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Sep 2024 05:25:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2c41fedd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Sep 2024 09:25:12 +0000 (UTC)
Date: Fri, 6 Sep 2024 11:25:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] sparse-checkout file handle leak fix
Message-ID: <ZtrKf4CW_vxJt9eA@pks.im>
References: <20240905082749.GA88220@coredump.intra.peff.net>
 <20240906034557.GA3693911@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906034557.GA3693911@coredump.intra.peff.net>

On Thu, Sep 05, 2024 at 11:45:57PM -0400, Jeff King wrote:
> Here's a re-roll that fixes the use-after-free of the lock filename that
> Patrick noticed. I pulled the error-checking fix into its own patch
> (patch 2 here), and did Junio's suggested "goto out" as preparation in
> patch 1. Patch 3 is the leak fix.
> 
> Range diff is below, but it's much harder to read than just looking at
> the updated patch 3.
> 
> Thanks both for review on round 1.

Thanks for going the extra steps! This version looks good to me.

Patrick
