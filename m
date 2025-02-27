Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6177231A30
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665432; cv=none; b=mCjcz+ntz+rFdoe+CKHEvgRHt76IR+ZGSN8VAiqZQS7koMiP2+NKwP9JqDSlP9IK3lgvMM6jhVKWRXaCyqIJ2H0IdRCPBNyrdqHoI2N6tcXVeAKP/fKugHpr9yxArJ29d7t61SVr5xCTB40guwCZC/GmdqKpDnC7sMi/rj9r+CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665432; c=relaxed/simple;
	bh=OJ0qGkYZHaGa7V9PrdP4Qaik9Bc3H2Z6H9z9fpjmLZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpLlo3PUgQ7omEPxg9MPygKE0OwpmzapEklzbxYtbzuF6oKOrzYe85IgaZpnE7q3p67TWmTnG/DPirY1ARxMy3SpFW4tBYvgBX2gQzcQ3VEUAFDczrUJ6FAshz9Tol7rzjAwhavYDvBlV7rqWgdrNM1DQ8bogZgRQ0xyCepM6vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OmixJTcd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mRm3b5Cy; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OmixJTcd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mRm3b5Cy"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CBAAB1140B7F;
	Thu, 27 Feb 2025 09:10:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 27 Feb 2025 09:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740665429; x=1740751829; bh=pBTRJew53p
	zt88LD8h1dDeDr6Gz+mjAa9IbIYLJmiyA=; b=OmixJTcdHs2AT8aschVjQyv3dd
	I11VKH73kyV39CzOAaueEM3owzJZMCm/Ikv/ZY7UBDxkAA2gMQUksBajxikV6nnQ
	tgfkDcoCPDjBs1L9NWhVEFkbgwGhCozUtLCZZq/+6zUnGF/q0pdHsBRjDqtdc4qL
	Ie6+WFUbf7epq3lYjwqCDCXOBy0SMZUojmJRpfWutde3nFuAVnNm9dXRBB7Sx6Yp
	n+F33vHs8UASURK73sJzZC8pWRh+3jJZyfszEOo/w+p3fNCje8LsOfFVvIOHJMJ5
	B/6x6qLX7/wJ959jXFkpnVveUWq+tYPr7G0+MIn7g4qAlIVo9d3wZHBLqHsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740665429; x=1740751829; bh=pBTRJew53pzt88LD8h1dDeDr6Gz+mjAa9Ib
	IYLJmiyA=; b=mRm3b5Cylo0Oefd65GprVzw257qSTXOIB4JHw65HOZ5Pv6Whwbp
	NpnUnOlzWMu34L7WguOIlCGxe1dhobfYU2bcF+pEwwnQU3zuaZ36YsuYC9A95S66
	QgWdFNU6X3T+miQQcVJK+S3G+jFwmBSriujNTM2WN+/c6uQgbEYxZgcU+/16KAat
	AsH0K9qPzh4BQKeq1AIPsITj4ueFfHk9bdgGTYFJzGUjNQPFiEggG6drCtbokYXh
	/AjmDB4qK0mhh4CEtd+M4V1sfUUi3HkreriSbN2NmgcwKS9y1hrWX2Gcep8+q9QD
	ARheq3BOPveEC7ic2khf6TCfcDeEXeIOQ2g==
X-ME-Sender: <xms:VXLAZ9egayGUi525ZkbdSK8QGTj8jSNIQoIdQiC5lbu6h56E9g5_Og>
    <xme:VXLAZ7PBfu2QqcnajwuSOxJuJCcYfjEakF163Z6tp8xj0iO_erk0hsqttgC6tsMJl
    o6iOiq7bxXS3YVMMQ>
X-ME-Received: <xmr:VXLAZ2ijY8PhZDTqgoo06_IwpBXNblepLNlTwTtsVtR6OHMqkPWdNMOOMDVm_efSosqXKXZ1HP6jVE6lf5raG-gwLpJcfOwcIHfDd6j_5QSW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehm
    hhgrghhgvghrsegrlhhumhdrmhhithdrvgguuhdprhgtphhtthhopehshhgvjhhirghluh
    hosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:VXLAZ29v_86fjU3LbVnoOayMOFViw0KDSgvJw2gVbsXhz30tpipqFw>
    <xmx:VXLAZ5vwd9loJI5v-sfgHa-rK9qZfEQ3sElmI0a9FIwcC65INircWA>
    <xmx:VXLAZ1FQBxTwq78rWd_33QHQ4ingyWi2SP_X59Wvnmcz2ugNV4cnYA>
    <xmx:VXLAZwOKj9QKTjw0zA8VeMWE9WzJuzBhnYh05Z85rhChC3JzGCe5kw>
    <xmx:VXLAZ3X1TcsvUAcVQIbDymuiBvqsgr8WpnsaTJMaN9rcozoT1-RWkVpE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 09:10:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2756b4a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Feb 2025 14:10:26 +0000 (UTC)
Date: Thu, 27 Feb 2025 15:10:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v7 3/9] packed-backend: check whether the "packed-refs"
 is regular file
Message-ID: <Z8ByUakK-YNyfwuL@pks.im>
References: <Z78bmBSrDR20GY6g@ArchLinux>
 <Z78cAU69IUSDgpuD@ArchLinux>
 <xmqq5xkwd042.fsf@gitster.g>
 <Z7-4XRCVvLjFCFR8@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7-4XRCVvLjFCFR8@ArchLinux>

On Thu, Feb 27, 2025 at 08:57:01AM +0800, shejialuo wrote:
> On Wed, Feb 26, 2025 at 10:36:29AM -0800, Junio C Hamano wrote:
> > shejialuo <shejialuo@gmail.com> writes:
> > 
> > > +static int packed_fsck(struct ref_store *ref_store,
> > > +		       struct fsck_options *o,
> > >  		       struct worktree *wt)
> > >  {
> > > +	struct packed_ref_store *refs = packed_downcast(ref_store,
> > > +							REF_STORE_READ, "fsck");
> > > +	struct stat st;
> > > +	int ret = 0;
> > > +	int fd;
> > >  
> > >  	if (!is_main_worktree(wt))
> > >  		return 0;
> > 
> > I do not think it is worth a reroll only to improve this one, but
> > for future reference, initializing "fd = -1" and jumping to cleanup
> > here instead of "return 0" would future-proof the code better.  This
> > is especially so, given that in a few patches later, we would add a
> > strbuf that is initialized before this "we do not do anything
> > outside the primary worktree" short-cut, and many "goto cleanup"s we
> > see in this patch below would jump to cleanup to strbuf_release() on
> > that initialized but unused strbuf.  Jumping there with negative fd
> > to cleanup that already avoids close(fd) for negative fd would be
> > like jumping there with initialized but unused strbuf.  Having a
> > single exit point ("cleanup:" label) would help future evolution of
> > the code, by making it easier to add more resource-acquriing code to
> > this function in the future.
> > 
> 
> You are right. Actually, I just want to avoid assigning the `fd` to -1.
> However, I didn't realize that I would initialize the strbuf later.
> After waking up, I have suddenly realized this problem.
> 
> If other reviewers don't have any comments for this new version, I will
> send out a reroll. We have already iterated many times, if we could make
> it better, why not?

I don't have anything else to add to this version, thanks!

Patrick
