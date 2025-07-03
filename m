Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D9B2DE6FC
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 05:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751518831; cv=none; b=RJRhGeZdyBME+H3cccDfvZGGuZLrTp43+Mdb59MWhINFewPirY3WPEVObMe8vn6rF2ZPaLNc3z7OhUVcnEwOecNKPntqVaBbxpqeI4pz5jRLaDMfM+qaNylkzrDC/lKyBHD7iMhtBgJ9dyaKqFI06Qw3khb489V8b+OGtlvp4kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751518831; c=relaxed/simple;
	bh=+8kAZ1QkNC3gO79MGF1pvy2a4XcKLrktyRmjWSANKTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfq+HpF5II/foQBSWeuf6GMzghf1iUR08R2JtXwGFx3xL7O47+srkG7qOSLXEnfs5tktOOPF1UiUAgglym7+FzxzBSyA17Ycesl8gzC2cd2ywlJ346UeOlwKdeTOvDyH2Eb8CkRkPEm+2KEGvApZTLfr/yFHycuWq1aRbZb53qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hN7lIXcy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gGxuuQYq; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hN7lIXcy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gGxuuQYq"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0FA1C7A0256;
	Thu,  3 Jul 2025 01:00:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 03 Jul 2025 01:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751518827; x=1751605227; bh=ejaFX5bWUy
	W0pcwqA8xmYxG56TirlVezCklOZIDn0Uc=; b=hN7lIXcyAru3svPbCGxwj4a4JG
	Si3zSYtWJyUc68oMdPG//uYTlCV5NQ3399YR5W5Pp6+Zb4sKS1sa/isFaawS3HS2
	3MY8s/E87tuFuSkZQEXONXcCqLbB/UjFTWNAlYWlKiGmIFQ3YNBtOkexdI4nUpl4
	xSyRaUrjdz6IsImyzJNmdUzn65jmZ7tpwiplYGODj1pNS4Xq54EO1PRWps39n3Dn
	Pur33KsCGJ8cCt3X2nZoBRQXX0Y+YLnX2wcDx+JMwx0Z5bXN6sje+BZ37yW3FcG0
	b/TSKPz8qIIwnVnkLlfxQNKDNNIcRZMcLdS3WRY2Fghz/yOsreKOVunAdXMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751518827; x=1751605227; bh=ejaFX5bWUyW0pcwqA8xmYxG56TirlVezCkl
	OZIDn0Uc=; b=gGxuuQYqsgd7gH74S80Vlrb5yiKSJEmWTs1Pf/apb5vSWWtmqiz
	14FH0kN7Ge93DOKNr/FDGQbkeRN47+fxGtvdZIew/QnpClGh56j2TQJv+88cCkyr
	po3MPDjxwZmBVyGx8MKVAeFjZ5WGbdbCRy8x7Y0LnrcaSzgpFMpp5xpRNzGqXuuG
	kWxEv13QorrJ7CkumkMVOYt2pX+HJehYBvP5ZsDW/XQJ8A0QmTZ/r81+IUjaNSBy
	u7AANljjwB3yq/HhVyyGNtf68eADq+k3bzXqXQX/1xti7febKdZ+ecG61GGfZmwD
	u5EK6N2PhgV3e1LjfRZsax4sMWlBDSDPlIg==
X-ME-Sender: <xms:aw5maPtqxr-8qk2GN8DK7hfUbBZG-3dT0uz9wzEqpRHKpfux5lAgOA>
    <xme:aw5maAcr83wzLoQzBQCD3VQcZxBolVHnRNpw-ejD1LjlMy6n_VKUUu0ApXkxJ5_aG
    axaPi1fq68vdVTC3A>
X-ME-Received: <xmr:aw5maCz0BWBXyL50kXzHGMRn-JmSUZGzCd4FboLfDgDLa4Yx2T2VTEIPt7HkmUJEoDjvRIYaZKO1qkkn0I6r3mptJgL_lNOh4kYwG4steg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhihvghnuhhs
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehj
    rgihrghthhgvvghrthhhkhhulhhkrghrnhhivddttdehsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:aw5maOPqW8HT7d_eiADynKIMjHzmbinJCnQfo1v0GoehjLnLFzkEWA>
    <xmx:aw5maP-4soiwTATmCMr4t9nnH-LNaYM48kblZCwLBb1Ij71LOPc-pw>
    <xmx:aw5maOV6SPS1iS5GZWOQdKYjad7HzYzLml4OT186_5NgJ6DqPyrvZA>
    <xmx:aw5maAej_3TeqgA__QE2xXMq4KKVvMPOnBKd2MzYnreNBNasiZI1zA>
    <xmx:aw5maIIk0wIVyEeoacLPjyw2shsgUSMpUEJp-hFQvt68DBKmaUnDH_OR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 01:00:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2ecdeaad (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 05:00:24 +0000 (UTC)
Date: Thu, 3 Jul 2025 07:00:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Karthik Nayak <karthik.188@gmail.com>,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] BreakingChanges: announce switch to "reftable" format
Message-ID: <aGYOZVyaR_OYIhtl@pks.im>
References: <20250702-pks-reftable-default-backend-v1-0-84dbaddafb50@pks.im>
 <20250702-pks-reftable-default-backend-v1-1-84dbaddafb50@pks.im>
 <q6zyvqpyxobtp65ptrmkdg3kvc2plxmsltaurqf52hglitikir@5p5jpcqc577o>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q6zyvqpyxobtp65ptrmkdg3kvc2plxmsltaurqf52hglitikir@5p5jpcqc577o>

On Wed, Jul 02, 2025 at 12:17:50PM -0500, Justin Tobler wrote:
> On 25/07/02 12:14PM, Patrick Steinhardt wrote:
> > diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
> > index c6bd94986c5..c96b5319cdd 100644
> > --- a/Documentation/BreakingChanges.adoc
> > +++ b/Documentation/BreakingChanges.adoc
> > @@ -118,6 +118,45 @@ Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
> >  <20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
> >  <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>.
> >  
> > +* The default storage format for references in newly created repositories will
> > +  be changed from "files" to "reftable". The "reftable" format provides
> > +  multiple advantages over the "files" format:
> > ++
> > +  ** It is impossible to store two references that only differ in casing on
> > +     case-insensitive filesystems with the "files" format. This issue is
> > +     especially common on Windows, but also on older versions of macOS. As the
> > +     "reftable" backend does not use filesystem paths anymore to encode
> > +     reference names this problem goes away.
> 
> I believe even modern macOS by default uses a case-insensitive
> file-system. Maybe we should instead say:
> 
>   This limitation is common on Windows and macOS platforms.

Okay, thanks for the clarification. I thought recent versions of macOS
were case-sensitive by default.

> > +  ** Similarly, macOS normalizes path names that contain unicode characters,
> > +     which has the consequence that you cannot store two names with unicode
> > +     characters that are encoded differently with the "files" backend. Again,
> > +     this is not an issue with the "reftable" backend.
> > +  ** Deleting references with the "files" backend requires Git to rewrite the
> > +     complete "packed-refs" file. In large repositories with many references
> > +     this file can easily be dozens of megabytes in size, in extreme cases it
> > +     may be gigabytes. The "reftable" backend uses tombstone markers for
> > +     deleted references and thus does not have to rewrite all of its data.
> > +  ** Repository housekeeping with the "files" backend typically performs
> > +     all-into-one repacks of references. This can be quite expensive, and
> > +     consequently housekeeping is a tradeoff between the number of loose
> > +     references that accumulate and slow down operations that read references,
> > +     and compressing those loose references into the "packed-refs" file. The
> > +     "reftable" backend uses geometric compaction after every write, which
> > +     amortizes costs and ensures that the backend is always in a
> > +     well-maintained state.
> > +  ** Operations that write multiple references at once are not atomic with the
> > +     "files" backend. Consequently, Git may see in-between states when it reads
> > +     references while a reference transaction is in the process of being
> > +     committed to disk.
> > +  ** Writing many references at once is slow with the "files" backend because
> > +     every reference is created as a separate file. The "reftable" backend
> > +     significantly outperforms the "files" backend by multiple orders of
> > +     magnitude.
> 
> The examples above do a good job at explaining individual technical
> benefits. I do wonder if we should include a more general statement
> aimed at users as to why the change to reftables is beneficial. Maybe
> something like:
> 
>   The reftables backend addresses several performance concerns as the
>   number of references scale in a repository. 

I think this would be a bit too handwavy. I'd rather want to point out
the specific cases where we know it to perform better.

Patrick
