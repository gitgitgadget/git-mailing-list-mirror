Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3588C2BE7A0
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404967; cv=none; b=ESI/Dx+xKt+JkMT4fqB/QMIGJ9h12nmKhEBS2aX1hl2hYhH6TxVF8f6FqQyUS8qt4+h1mPBq4QtO6W8T9hh0UKkmUzaPI3b9ODIUvkOGpB7Y1FUf2lfl/M5PnwlA78PzzWYFAO8X0z67YHxKNqfGAJ1RztgH0BQXdXi8VLkiR40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404967; c=relaxed/simple;
	bh=/jEoV/96QEEvA2YlmTmxN8gx0DCz5qsNt1KdAOei1es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bme0/cJ4ynRtvy0pcEi11hGewVhzOvFxpLPmJcL82yFGwUvwdKWfjwn3AuPkhXRdlOKDbIWgMIoye0n3H2MsPZ5yCfUyGokvfp6oU0evEfhfdlZG0KkC9i+tIrtFfjm7CPhpBKdNoRq2nekikQ/HXwqaZAB59CUWxWXwrxUZ/CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XgeWad+L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RxjAG3oB; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XgeWad+L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RxjAG3oB"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C59D1D0013F;
	Thu,  2 Oct 2025 07:36:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 02 Oct 2025 07:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759404961; x=1759491361; bh=4X8KCjb4G2
	AbRU3h56XLQrlB2F8oeCZfAkX7n8Xvg1Y=; b=XgeWad+LQv9ACUDGMaaSxThEYc
	iItGQaKEgd8w/puiF0imj7KAt+30gih8KnqTFeCHx8BVrg45qt72tvBsAr9xnPyp
	8OUT72vDhOZAha6A7A8tZ2DFaRJPsF0GpYeGtHqCcuuPVVBc3/LigVBBBWiqkDNh
	/d2gCIWnnr9eNoevJ6LdYUak2YYG2VeSkZ2nDz0tBWdUJUxzyNxYJinQr1fnG+DX
	d1zexD1BWWGZqLucywSoV8Z7CyNoI0xaRa00eODKHGhJpRDpQ2z869im0BA1WBD9
	B7EJaCA6BcCShZIT64MEpkCEXYVoD177F7E4mM6uh5wePxuPp+5TKrKD/2UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759404961; x=1759491361; bh=4X8KCjb4G2AbRU3h56XLQrlB2F8oeCZfAkX
	7n8Xvg1Y=; b=RxjAG3oBw61ZvOrZr8iMFV2XJTneLVI6HVsotHUbKt/dX7IHA+O
	3kcMraMOvdeb6NYm5htLtbe/QGs20c2zLPVNBuumjmWJ6RM52HrfzcNlDSM7zJ0h
	9pkWyaVUkOGjkhEouomaCb9ViOn0Li+WWvQ1AQHWKwravoFxfhzsQTjSKSCvCIUT
	VnRQi6NXon7/BO1bLP7udlybRZzYuFpwVTJYkDVFFPsfg+6NTrx+EAAcGXv+hhM+
	aATBIHQPQ9Q0IcGaSRCrJ8X3bQNs5RfyfbX/9fhxKqqv8W4DpvxYBVaTiQ92pfMV
	yzO3OUDWKBmhS9C1N802+8UhJDmN8i3YRLw==
X-ME-Sender: <xms:oGPeaGhnAv2P6Yj9pxctb5KDeOmZQztOufI_R6ep8t6U18H7EwZrQg>
    <xme:oGPeaOA3_Mkh8XGnivN9Q6Jhf1onNfbb79fA45g3-0hF3dkBSoxz6go7Lhq7wRF9F
    Gbtia0zZWcFT6Y-IrST6-_OkfxUOPQjH1dAhPT5m3gagsSy8-sH>
X-ME-Received: <xmr:oGPeaDEYAcuwV_s_HAhbcKyf_99jVSsDI7edxTSnbklOA1uKHuoChhRttFvTD06M32H63zPCFR_cy9TzqzRuHi-8CV-Vrcf0nhcFYwi-fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:oGPeaOJgfw8u6ywJsAr6oEDHwKvIo-jL9YMW23xqFlXbBhFkma392g>
    <xmx:oGPeaPmB4ANGE506FchK6m4yio5Iv-IPw1ByJDL8zdy_OsDtVX7Bsw>
    <xmx:oGPeaORaf2kdJDiDPR3Ov7N9ZKEWlmvJ428ACC_Wpep9HdKvNXv5Tg>
    <xmx:oGPeaJKe_WDkTOvxnfqKng4TJFE68fvbzArUfbpDzMsmgqFRElNuqA>
    <xmx:oWPeaPG6jafOMakmBMIxDLwaBwzOcuUmc2dAJlrXvnOTvzadQK-MojQ1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 07:35:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3e188b51 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 11:35:58 +0000 (UTC)
Date: Thu, 2 Oct 2025 13:35:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/6] odb: track commit graphs via object source
Message-ID: <aN5jm9zXMD8E7Slq@pks.im>
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
 <xmqq5xdx7qx4.fsf@gitster.g>
 <cf7aeda1-297a-4805-b0ae-e379ce11bbcf@gmail.com>
 <aL67U0-tw7O-y6_X@pks.im>
 <4e67fb02-bbbb-4cd8-9892-6f65b4f82b26@gmail.com>
 <aMFjGoPhGsRCTihO@pks.im>
 <xmqqo6qyfijl.fsf@gitster.g>
 <aN5gPoPC4WEYw9CF@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN5gPoPC4WEYw9CF@pks.im>

On Thu, Oct 02, 2025 at 01:21:34PM +0200, Patrick Steinhardt wrote:
> On Thu, Sep 25, 2025 at 12:17:50PM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > 
> > > There is no inherent reason why a new backend would not be able to use
> > > the existing commit-graph infrastructure indeed. But there are reasons
> > > that specific backends may not want to do so. If objects are already
> > > stored in a database table, then it may make way more sense to store
> > > additional metadata that is currently stored in the commit-graph in a
> > > secondary database table instead of in the commit graph.
> > > ...
> > > This is roughly what I have in my head right now. And I realize that
> > > this information really should be sitting in a design document. I'm
> > > working on that, but still need to land two more patch series before I
> > > want to send such a patch series to the list.
> > 
> > So is everybody happy with this line of thought that makes it
> > mandatory for each backend to decide and implement the commit-graph
> > support if they want to?
> > 
> > My reading of the later part of Taylor's message[*] tells me that at
> > least Taylor does not agree with that position, and I am not sure
> > about this design choice, either.  Surely, each backend can have its
> > own optimization, but looking at the way data from the commit-graph
> > and other auxiliary data files are used to optimize real operations
> > (like populating the essential fields of the commit object first
> > from the graph, only to read other things lazily from the object
> > database, or switching to completely different traversal machinery
> > when reachability bitmap is available), we cannot say that each
> > backend can store whatever side data they please and leave it at
> > that.  The code paths that are supposed to be generic need to be
> > aware of these side data used for optimization to some degree, so
> > conceptually it is much cleaner (well, at least to my eyes, that is)
> > to declare that the auxiliary data files like commit-graph and
> > reachability bitmaps are defined on the objects in the repository,
> > no matter what backend is used to store them.
> 
> My intent here is mostly to allow us to swap out how exactly the data is
> being cached. During the Git Merge I heard from some JJ developer (I
> think) that they also have a pluggable cache, but they approach the
> issue differently: instead of making the cache a property of the object
> backend, they instead make the cache itself pluggable.
> 
> I think that's a worthwhile angle to explore. The cache would still sit
> on the repository level, and it wouldn't have to care at all whether we
> use loose objects/packfiles or any other backend. But in theory, we can
> still swap it out for a different representation as desired.
> 
> Which overall means that we can defer this to a later point in time, as
> we can make it pluggable independent from making the object database
> itself pluggable.
> 
> So I'd propose to merge the first six patches, as everyone seemed to

Correction: first five patches, of course :)

Patrick

> agree that they improve the status quo, but drop the last patch that
> moves the commit-graph into the ODB sources.
> 
> Does that seem reasonable to everyone? If so, I don't really see a
> reason to reroll at this point. But please let me know in case I miss
> anything that needs addressing.
> 
> Thanks!
> 
> Patrick
> 
