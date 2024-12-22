Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837F52B9B4
	for <git@vger.kernel.org>; Sun, 22 Dec 2024 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734892612; cv=none; b=OxAoB52c+CPSF/LEMviBtGR7G/pp9R86e+sfXIGqx9Ae/MvQI3iuyrckwMnYF8AysESX+pzfRPqq42a5d9L3ambiY2mmmVXK4o6/7Lp6UE5vDn4O2XgVnpYB710rSta/GPwsHwjeEFXPCoTuYg52tIGYFaH21ishG2uwH+w7mGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734892612; c=relaxed/simple;
	bh=uxkQvgeWw4uvYIMiX/NwKvXvYx2BybbfDvmivMqd4VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYFP+99QJmOBhduRXM4koD2pE+JIC7AzQDl2SRSfMiYey4l9AhWNEKsORR2nYWoXKFLK2ACaoA6iE1daHMLH3AV4cFbkXWiSGlYto5oWCUISlmyZARBW9j/ZinRy9P1YwxlJkcYoypsquftsXzD/KmGp+kB3gEhD4lULYNgkbrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sSzpOrd7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GCMhkhLP; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sSzpOrd7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GCMhkhLP"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 5F82611400BA;
	Sun, 22 Dec 2024 13:36:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 22 Dec 2024 13:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1734892608; x=1734979008; bh=xrjm+ybSy1
	DGwx26BO8q7ycT6jyMsQQ0S+zGdL2lLS8=; b=sSzpOrd7QLv1q2LtPR8h13Pon8
	FZimGCKMfnVvEODc/THaJ0MmCHce6noW2+SuL77WdDVmo8j7whMM5rF/ORjc9A0m
	bYXsuC/mtAqVraMVg3YUjvuj64lSLmJBqs/Z2ORA9OtP9y9SlG3Tl5pw1l8l1IVT
	BsYPAuMyhX2GV5sAiyK3q9nxYyafKua9mn3gvQ9aLlsGDBq3qF9vXxdYpBPxkm9y
	hvTMuu7HuzeMWViF30l7y0NueHGhfDRXocVnh+Dv3iq/pRYpeJ0qL9PMsym74Xg1
	46tTLb7dSnznf9suqSkP71cXgdqPbQ6LidQsQiv12Uh+A6414Vo5xPpsRByQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1734892608; x=1734979008; bh=xrjm+ybSy1DGwx26BO8q7ycT6jyMsQQ0S+z
	GdL2lLS8=; b=GCMhkhLPFJJWM3ChNdbZl26uH5Syp9KH/X/svMYnE7zIHnfIawG
	HHZyJpHw2k+u+HrHry00xhfHOXKy4gUmPqInz3S9U+boxgCMgzDxfCctjIhPBvGf
	p99SAZWBVuWkztdsl/pjdOh7aN0clFPV3i5n23jUObBndM+uwLyDCaXfzja4fCUH
	kNu/wMfp+smTeUonlb/RJUJb3FfUNzOjsFxvJaOZiGnkZG6I68KukxwqHdY7Tb8j
	Qj01peWxK5yX5Y5H/efWbsJorUo/D/kwIjApcsJ2k+R9mo0BTXI4hwmrQbKWlDZ1
	WyfKB2U80vy3RnIUeBDvKj//iOI3pBhzqaw==
X-ME-Sender: <xms:P1xoZ_coRF6lLKM4Htg8cEC-tvlggzYAJrWgtMnLcsonjzaU_oOK2g>
    <xme:P1xoZ1N3fZ2RW5y-DQxDRDw6JR5b7itPHKYwz0zEEgjNyt5EmVU0Ce6sFWqXf_DGV
    vielXyDgiYevF4-lA>
X-ME-Received: <xmr:P1xoZ4i4hLm5RrrAk6hbkp49hH3kGZDZUhKiY7pNH9UMJiNYe7g2AV-J1NMC8JJ27i9b9Tle88NgwhDgSwltNqyqHMnjeL83Bebxc-BzPa9qXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtkedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehrrghnuggrlhhlrdgsvggtkhgvrhesnhgvgigsrh
    hiughgvgdrtggrpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheprhhssg
    gvtghkvghrsehnvgigsghrihgughgvrdgtohhm
X-ME-Proxy: <xmx:P1xoZw8ukI201_8FC1Ig6hM0B2rbxTsyKD0PmW10BR944OTyZ9CA8A>
    <xmx:P1xoZ7va3IM4NEjh8rZ1vrEDWeRcZGl7g254NK0bFWtJ1D5Ac2JRoQ>
    <xmx:P1xoZ_G_1-B7TePEKaxqJItfkTaqgTLtIhVizhyzuwF8nWv7I6oCCg>
    <xmx:P1xoZyPRGPUtVm8FZ2ZIMjjxI2m1jtlQ4feG4Xe3MlqtOzfj1f0bKA>
    <xmx:QFxoZ1JBGE6D7yb3nQs4I-ValVAJ9xwIdiYFr26jz4KTaj_rl2Ybnx_C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Dec 2024 13:36:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6b690e19 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 22 Dec 2024 18:34:46 +0000 (UTC)
Date: Sun, 22 Dec 2024 19:35:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: rsbecker@nexbridge.com
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
	"'Randall S. Becker'" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH 3/4] reftable/stack: fix zero-sized allocation when there
 are no readers
Message-ID: <Z2hb2CenfZ7bJ7Zj@pks.im>
References: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
 <20241221-b4-pks-reftable-oom-fix-without-readers-v1-3-12db83a3267c@pks.im>
 <xmqq34ihc4zt.fsf@gitster.g>
 <xmqqmsgoc42a.fsf@gitster.g>
 <01b201db53d3$0b5953d0$220bfb70$@nexbridge.com>
 <xmqqikrcc2i6.fsf@gitster.g>
 <028801db549d$bde37240$39aa56c0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <028801db549d$bde37240$39aa56c0$@nexbridge.com>

On Sun, Dec 22, 2024 at 01:17:15PM -0500, rsbecker@nexbridge.com wrote:
> On December 22, 2024 12:48 PM, I wrote:
> >On December 21, 2024 1:31 PM, Junio C Hamano wrote:
> >>To: rsbecker@nexbridge.com
> >>Cc: 'Patrick Steinhardt' <ps@pks.im>; git@vger.kernel.org; 'Randall S.
> Becker'
> >><randall.becker@nexbridge.ca>
> >>Subject: Re: [PATCH 3/4] reftable/stack: fix zero-sized allocation when
> >>there are no readers
> >>
> >><rsbecker@nexbridge.com> writes:
> >>
> >>>>Applying these on the author-supplied base (ff795a5c5e) yields the
> >>>>same
> >>> tree as
> >>>>the result of merging my manual application of these four patches to
> >>> ps/reftable-
> >>>>alloc-failures into the same base.
> >>>
> >>> Ready to test this. Please let me know when and I will report results.
> >>
> >>If you want to start sooner
> >>
> >>    $ git checkout -b test ff795a5c5ed2e2d07c688c217a615d89e3f5733b
> >>    $ git am ... these four patches ...
> >>
> >>should give you the fix without anything else mixed in.  I'll push out
> >>the usual four branches after integration testing, but it will be
> >>queued in 'seen' (just above the point that corresponds to
> >>'next') first, before merging it to 'next' (and then down to 'master'
> before -rc1).
> >
> >FYI: 'seen' looks better now. I am having issues in t0211-trace2-perf.sh
> with
> >undefined SSL symbols (SSL_get0_group_name), but am able to use git init
> again.
> 
> 'seen' looks good. Operator error on trace2-perf.sh - used the wrong version
> of OpenSSL.

Thanks for confirming!

Patrick
