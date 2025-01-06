Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC33F442F
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736149879; cv=none; b=W+nudh4gNUT94qgduwGuM9ofzpwuPSRYK+89jSja+JXbydMErQqIG6ax4E8Htu7N+9KckU43shDM59ECH3RhTP4yd+UpQP8Ml0KUPqewg0bdRjertRhvx8yEVvov8sbjCT91uN8uhx7H4m/QSiBkVqqkQdHjrUnBw1cJbCZegLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736149879; c=relaxed/simple;
	bh=zlVgerRpb64CbG8ZSZR4zDPXudpcRrYk5hnyM/naKf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnP6QpyVW8ACROgAJGqNvfWARv06XPIQiD3Ta9cBWTq89P7kEQw0aVi+y1EQQvIw7PNOnVg3grDpZYEFaPrG0H6NHVunkEmt2ORTX6S3XiWtO/CNdZgwqSQZyloay1TAl/csSLWORJtyRzK1BgViuPr4K4IOhjxNewcFTD5DCVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=abxlE7XQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nThJxr4F; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="abxlE7XQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nThJxr4F"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D279211405C1;
	Mon,  6 Jan 2025 02:51:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 06 Jan 2025 02:51:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736149875; x=1736236275; bh=/xuENKqg0b
	ZgYuSszqEdbEaEh/e1aZI7jkSdAxg2WD0=; b=abxlE7XQQWTJPbOGmT92HX2x8p
	5RD6y2g5m/He1BzlmiWeY6lZU/93KCXd+nKyhD2uPUN9lVtctxAUQd40gkYVS+VS
	jem/7GKp9vBfiHxIl9C8xF4MXPFvNi6c1X3Q97aQyIlnGBJKAeA1Grq5zOkr10Es
	POIFRMHkU7TXrMvZ/y9/NVOh0avqGCXHNQcySojsyATF5QMRgQztke1lSKwsb+uj
	2/O/c0X1hqjxU0MiHyIqZMGUDOMpdJZR+FX5oSf3pUAhz4pCK9+KfrSyqXco+ImP
	ouKDut+sGdwnIHNyGjsLxCb6u4yz4cC1o6gLQ3In8t94GgIlucr5QW6JotkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736149875; x=1736236275; bh=/xuENKqg0bZgYuSszqEdbEaEh/e1aZI7jkS
	dAxg2WD0=; b=nThJxr4FCtaN+OHtlhOE4HBpd4iOXmtKKS6gjexYtHa4DuDynLz
	LGcHJ5Y+qV538J3dwx/HZVimQAQW9xWkX4IbXr6dcI87HkSF+y7396E9zwLSMT6T
	A/3fFly5/whOeOVeG7MQYuNVpz7NgpZrHz80R0k8Th2t8ZpqmhUP6zkP37pMNCFW
	8ZzfkOq3DxOHE8Zp0c330AZvcR8vCLbt/INmmRHWwKd6Squ06X8pgM2w6tBzcvxC
	3Xi0ENC+T/EkL7XD3Mk8G0Sw7xWsuENfwo0Qz9uMmzbhj5DUlfMCcy/1FMaXN8vc
	TOTYmiIJYRGlYLeGx1zn/lZ+PsHJ1c4eijA==
X-ME-Sender: <xms:c4t7Z4KVBgo5eYvpoxb8tLz2f7yy0acCLVBoHN5pq5aRWNRV51phpg>
    <xme:c4t7Z4KQ7gYsrVsB7e9yoCPPPg6yCBYUos3dYHKzo8FAn-DCZqAAZoSG4jgbfEH9r
    pO-VEOlP6YgGYOfkA>
X-ME-Received: <xmr:c4t7Z4uroDQzeJqr0BzZtttLLHBCcK9F30tRNO3vyS7vspq7ss-EwZj2-OmL0rGm8XC-LIAHU78aidcvWaLx64fA38QfHoE7VzRca-RyAwmPpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefledguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:c4t7Z1ZYj7WMU7-LeWxAf4qBZtUSOyGdjveTjRSVmebwjjjACXOulQ>
    <xmx:c4t7Z_ak8VbXziX0mZtbZGsoKT0Lu30lXegzR5TxT6zHnzaY6N1Shg>
    <xmx:c4t7ZxDdxgYzA7DHuHvIqWRFyUt1MceO9oolbhv205JhpKVlKj35Fg>
    <xmx:c4t7Z1YRpqpbmv9E-hY66ecTPy2KgtNkfJjkoVMBrBdeqBRUwux5HA>
    <xmx:c4t7Z-ka9KhLtZdyjD61bNHYQo9PAaFYKVB_n0-63gs-UYJBAlf_TUPN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 02:51:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8e92b312 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 07:51:11 +0000 (UTC)
Date: Mon, 6 Jan 2025 08:51:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Git <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] remote: announce removal of "branches/" and
 "remotes/"
Message-ID: <Z3uLLv8DjEicYnNF@pks.im>
References: <0F4D68EB-27F9-4638-98CD-02515969D677@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0F4D68EB-27F9-4638-98CD-02515969D677@gmail.com>

On Sat, Jan 04, 2025 at 10:36:10AM -0500, D. Ben Knoble wrote:
> > +As our documentation mentions, these directories are not to be found in modern
> > +repositories at all and most users aren't even aware of these mechanisms. They
> > +have been deprecated for almost 20 years and 14 years respectively, and I am
> > +not aware of any reason why anybody would want to use these mechanisms.
> > +Furthermore, the ".git/branches/" directory is noadays misleadingly named and
> > +may cause confusion as "branches" are almost exclusively used in the context of
> > +references.
> 
> s/noadays/nowadays

Thanks, will fix.

> Is the first-person intended? "I am not aware" reads like editorial that doesn't
> match with the rest of the document (either "we" or technical-passive voice).

Hm. Yes, it was intended initially, mostly because I wanted to stress
that this is *my* finding and may not reflect the whole project's
stance. But while that would've been fine in a commit message, I think
you're right and it's less sensible in a committed document. After all,
the review process should ensure that the project also agrees with my
finding, and at that point it does make sense to say "we".

> (PS hopefully my mail client will get this to the right place)

Seems like it did make it to the right place. There is one weirdness
though: your mail client sets the "Reply-To" header to the message ID of
the cover letter somehow, so when replying I don't send it to you but I
instead send it to [1].

[1]: 20241211-pks-remote-branches-deprecation-v1-5-1431e2369135@pks.im

Patrick
