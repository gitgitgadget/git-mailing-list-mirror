Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86042A1A4
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 04:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729227565; cv=none; b=O92RFua87bSs648KkHtG/nF6Ul5Dqwe2X4Bnqmf+A4Js8cbfl7lc5OgxMcmdYndmx1aVe3u0mC01cNIr7jssLy23G7h08/fKEuR0FXlgWbSWwEZryP/FmcfVmFqc/LL+o0EJpZoS6zqi4ynJrcjEgmiFbnypDxJnbnCZkVFma8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729227565; c=relaxed/simple;
	bh=t50AnD/ycRleQlA2EOyA/WCmr+cXU7aqgEPQ7koHUfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bi9nswJuAKccE8Gvu9wxYuPENvuxogWT+aL2vj8tSFBYkB+hDXHjjtvwiGgTtBYvn+DHLVwHLIB2MQky0Rufyh67q9TstPOQqDT5exRw461cmLpKaV+dS2PZqaa/fPnfGInkzhAdyS/3N7/sIG0w/IbC80W9tPE6DkA75AgVn00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QjDsJhLw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JbF2Xq18; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QjDsJhLw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JbF2Xq18"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E644311401EC;
	Fri, 18 Oct 2024 00:59:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 18 Oct 2024 00:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729227562; x=1729313962; bh=+RBg39n6IL
	iRwYqlX2OJ+77pNqDXUlQBjMiMTA92Vrc=; b=QjDsJhLwYW37n4F/eVUq9JJMnw
	xXgWzUFW7lr5TCrsS665kYlLMRCfRdxKu3DsHtXBHswAViyPzzjqIv4W1uBBxEG6
	oT5nHNfCtm3KxwjHNqMJGMHc9VD20sRPkaGaHmecBuC7V+Fg0Pr8B9/Ok6UbHM1D
	xsyJtxnXh+7sVIxrU5t3jiw3XVe3Rr2WBY4k/5MjYmVoKFHmVn9EEIDP9tlm0rLm
	ZNjhjTDtOGFFpmsFfdV+/1plM9mAYJXRVF3q7MtxmpGQlZYpkdC/D/qI/wiQvYnF
	DCq7lk2mZAwq9LYeeGPJcoRbDHthud/wJlSH3nLeaFCMpbupJj38ak7KQBSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729227562; x=1729313962; bh=+RBg39n6ILiRwYqlX2OJ+77pNqDX
	UlQBjMiMTA92Vrc=; b=JbF2Xq18rOA6ATUAMqjJVxVr8x89cESTfcyXnBmyA0Gm
	Jbe6SiokON4SyeZZppo6Ng3a411CFD0Q+g1EvliGnmmtl9ZP4zy8pmnZU2r5nK/Z
	m1AbrXlee/1IKGojhDfgsSaf9kHd40Z3l+0tauWfnFBhU60JTNAEcuwU353fzdjX
	vPrHF0GpODp/JpnnuUKj/fsq8l0I0Upts7MKSoXud+HEuojialSkhaAZ78b2ObBA
	3VjaXAd0w1NWms/S5Elj7vPwo8grPuRgL9lbflleJ0+h1jMW8VMmEUs2pw1fyDPj
	I/3dFsY4LUbZGffo4YoGigmizan4fWYdf01+7GehiQ==
X-ME-Sender: <xms:KusRZyQ4e8pZTYEZo5AxjoFQAyuWBlTEgsiWSSnr9mbCprfNqnTbhg>
    <xme:KusRZ3xbDSz5P3ruuQwLgXk2wf9ZG4vX3Zx95Z8yq-0LD0_r7ShQVExl2i7ng3hFg
    qkFZXcCbmOv6AYnrQ>
X-ME-Received: <xmr:KusRZ_2zkZeayFaVlLh-l1rSUq4qrB_qkMsf4d0K5ExbaYmuDGKlfZLrnNZ35c3_85dytQb0tBV-Is1PvqUCH0oqLxqch9XIV_OdBKtK6Q3h>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehvddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejtddtgeffke
    dujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegsrghgrghsughothhmvgesghhmrghilhdrtghomhdprhgt
    phhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:KusRZ-Bc3ggvXZjNpKcug7fbBwayUYFRf0KCpPR7xFeBYXW-OPXxiw>
    <xmx:KusRZ7iP4qjjzMAbY9VlKwT64qUriAJl2wktgHQ2WN3yxn1YWgUWAQ>
    <xmx:KusRZ6odHQTz86zvLJA_7LvlmUJweQJfdvj1vJ3l9QjOQXa6c4CuOQ>
    <xmx:KusRZ-juYSDdlgXz6JwHUD3HiigkK_Cv-KTkHFeJOEF-P4phiQ0uwQ>
    <xmx:KusRZxY4nahO3b11JK1yoyUCyNnssA0eVyKCP5uT0o51Z5inEe9v7lNp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 00:59:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9b8991f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 18 Oct 2024 04:57:58 +0000 (UTC)
Date: Fri, 18 Oct 2024 06:59:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: clar unit testing framework FTBFS on uclibc systems (wchar_t
 unsupported)
Message-ID: <ZxHrIBCdnwdRdXAv@pks.im>
References: <ZxCJqe4-rsRo1yHg@archie.me>
 <ZxESP0xHV4cK64i0@pks.im>
 <ZxEXFI80i4Q_4NJT@pks.im>
 <ZxGN9zzt55GcL4Qj@tapette.crustytoothpaste.net>
 <20241018045155.GC2408674@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018045155.GC2408674@coredump.intra.peff.net>

On Fri, Oct 18, 2024 at 12:51:55AM -0400, Jeff King wrote:
> On Thu, Oct 17, 2024 at 10:21:43PM +0000, brian m. carlson wrote:
> 
> > > We unconditionally include <wchar.h>, and your system does not seem to
> > > have support for it built in. So why doesn't the `#error` trigger? It's
> > > also not like this is a recent error, it has been added with 581deed72
> > > (The obligatory forgotten files..., 2002-05-06).
> > > 
> > > We can do something like the below patch in clar, but I'd first like to
> > > understand why your platform seems to be broken in such a way.
> > 
> > Yeah, this is definitely broken.  We require ISO C99, and according to
> > the draft preceding the ratification[0], `wchar.h` and its contents are not
> > optional.  The similar draft for C11 also doesn't appear to make these
> > optional.
> > 
> > I think users of uclibc will need to compile it with full ISO C99
> > support.  I expect that a wide variety of other software will be
> > similarly broken without that.
> 
> Perhaps, but...don't the current releases of Git work just fine on such
> a wchar-less uclibc system now? We don't use wchar or include wchar.h
> ourselves, except on Windows or via compat/regex (though it is even
> conditional there). This is a new portability problem introduced by the
> clar test harness. And even there I doubt it is something we care about
> (it looks like it's for allowing "%ls" in assertions).
> 
> Our approach to portability has traditionally been a cost/benefit for
> individual features. Standards are a nice guideline, but the real world
> does not always follow them. Sometimes accommodating platforms that
> don't strictly follow the standard is cheap enough that it's worth
> doing.
> 
> I think more recent discussions have trended to looking at standards in
> a bit stronger way: giving minimum requirements and sticking to them.
> Certainly I'm sympathetic to that viewpoint, as it can reduce noise.
> 
> But IMHO this is a good example of where the flexibility of the first
> approach shines. We could accommodate this platform without any real
> cost (and indeed, we should be able to _drop_ some clar code).

Well, dropping doesn't work as it breaks other projects that depend on
the clar-features that depend on `wchar_t`. But other than that I agree
and would like to fix this issue, also because it potentially benefits
other users of the clar.

The only problem is that the platform seems to be severely broken. As
mentioned elsewhere, we have this snippet in uclibc's "wchar.h":

    #ifndef __UCLIBC_HAS_WCHAR__
    #error Attempted to include wchar.h when uClibc built without wide char support.
    #endif

So if __UCLIBC_HAS_WCHAR__ is not defined, we should see the error. But
the report didn't show the error, which means that the define has to be
set. And consequently we have no way to patch around this, because the
macro that we're supposed to use is broken.

Might be I'm missing something with how uclibc is intended to work. But
if I'm right then this is just a broken platform, and I don't think
working around it would be sensible. Otherwise I'd be happy to make the
wchar-related code conditional as shown in the preliminary patch posted
in [1].

Patrick

[1]: <ZxEXFI80i4Q_4NJT@pks.im>
