Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503B242903E
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693629; cv=none; b=msuLHb2fnMU8WsuP4N5gYpVP7XooJ32yJrKbVbxv8hyZ+kyjHRz//d0ACUa9qfWibAbs4BSIXLQZk5VSzyIesHBt2jS9qoZJMQPOOAPLoYEKETtP26+r/i1gNHoU8u6J4izufULlHkj7XrwG6An7G3jIFWTIRjYI0g6HIV+nlm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693629; c=relaxed/simple;
	bh=RTsi48FEa2BfStjP67zGjEWTFNbI+BHK/hJ3Kktbis4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AepYszlKGoF7FYvM+hhOIr+vnFUbDDVCuqD+PscYFbmSBZ/TUsgMs0Bqj0pmFlDGOinDDPKTndhT7WSFQYTs39hBpuSzOsQAP138tPCu5gsAtNb5eQJbgUPVfiPDm5TW/DEw5ee9ozyjKHS2cjp//3tpRggZxCmKknrg3JPxva0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j+ZKfQVg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hzXTfvl5; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j+ZKfQVg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hzXTfvl5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 0DA721D002E5;
	Fri, 14 Aug 2026 03:46:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 14 Aug 2026 03:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786693598; x=1786779998; bh=OKWVH8rmlQ
	kLeEMS36DE1GfDM8+FkiC0VMKruXIKiag=; b=j+ZKfQVgzyX2QSukLLflkiYsFE
	6vRioevpAd7LSVtHlmgfbPVDAgFeQOIW+G8pJZ/lJ9jLT+EwWP5X0d5tBw0KgdYA
	C2eDFXuHomYTwshE0ZO3Vka1qwS5mWrf2Bl2+bayMWVmenIHfgtFfpAkO1IbxMMJ
	ceoEOwnv46BKAeHJf5/VfX0GZ43kGZRQTw1D5u7RqDrddvAGcsR1WQADFNfWUE06
	Ery1R3yZHMqm0uNu55fRnsk/lloX/ByIh/N2aNp6XjddZLO3CUvfZRr4ZXGMLRWh
	Cl/RoIiEaQ34dZDmh/T9r07MhfVqTdMQoq/32wNb9DWhlMAdYtB2V10ppZMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786693598; x=1786779998; bh=OKWVH8rmlQkLeEMS36DE1GfDM8+FkiC0VMK
	ruXIKiag=; b=hzXTfvl5elpxtqHHWzvCLtlLjARrdZcoVkmSsF8/6gYLRG1ijPl
	Cpf63NMm6ySk7zEznFIRgzmSDhjfozp74oVoDx4+N01JsSkV+IPT4Ssmihacq21v
	nWR8BC71vDVFSBJsud1hByC1dCpFJARjwjmLeyUOa7iRr7Hk3N6WK+OsGcP2Xqg8
	pvFne1HZWmHXye2h5a0os4IiOd27mPqmxrCsTxY9HEXmvHvWT4G28oFc+zWrXOP9
	q1Q7uHzppOcP22wqU2C9vHsFircZOk12nwF8kxVTJYIPub6vLkr7xnDmxldt7TY6
	LD3NTjiqGu39Q3BOyeLZLMyFfv52WQvn1xw==
X-ME-Sender: <xms:3sd-aiNjhnkuR1w9pYWk9OYEIEGQeNd0rMwdTn0bQN32_zoKEBd2xA>
    <xme:3sd-aoafX-uidLygZlH_QP0cBEiMWQbEgmY86bQjc0cc97VYulxAPfe7FnIbS3lPb
    e5Ab5oFfp5EbvR3Gfr0sei8ezq2IxHl5HoPPnF84u57Q5vKjkgJsA>
X-ME-Received: <xmr:3sd-ampYD5kesF-4KMsO7vcUHR2HB2XEq6wmYXATHbGj_YwFlnF6JjNU3HCe_vSmoZ6v4mD4EW-ROrN0aPfJiRRrjfWgzsbFYFdhUOrX7G0>
X-ME-Proxy-Cause: dmFkZTE4AoYsRxqXsaKYH7zD0ToD1n5s9y/yGhzqtSZje39VMcbDWa585XnB60l85b/OBL
    WtT74rFs9ZsZDxPg1IWz1B89zgjaxNwDhLzVXKwO+Isa8iYUhSCdUlwsl73psuQlpPYi24
    Dyb3KFKwSezrEKsejLH/x6FhbnZdlhQYk0JjyD6IJ466YjTaPwO4mOHW2fSj8GKm8gwtt0
    sFAet79EsHDRZCRQMHNV0fi644xme13t08R8XaaIUZIGH3GhAcBo9duyAZNHEXRl3gDpl7
    N4JLjOjLRA1mWOQ+OvwkSNPxCJlJaEYrEwgO0Ul3F6g6H9glp0/fHTRe+tctMTkt44eTLl
    RQJ/Xd7mVeHQTUlqXQ+7HWhzX4PGXVDDEm2O/ZOQdvUchXlGQdGgzoNgW9ZfrvCcpssC+6
    y54NDazvWP8WINncip5Rr1aoiGhZsb2D1nEuA66eZjcdV0RmXARo91AHL3xlqwqDVCiJvt
    MmvhOtMBRVPfCSldwORQsgReeT3lQFErm+2fQrL8s+GNx+maRxGA4nvEcYDvq/hLGWoshg
    V5QL0FfOTVtYKYJqGRkdKymQE4F9MBREzZoP0ZHTxwK2AyA3EEj5hl/ePqhsfCI+MbNIPK
    OgjIm6XOK/HxBHBDiSapo2RpJVVdnpsJ34pYrnXehLghQG+/1zY/YZk/OovQ
X-ME-Proxy: <xmx:3sd-asZkekugU8FgO1m1BZs8IFQ29qmYxgWI9hSxw9OszfDEgl7-4Q>
    <xmx:3sd-auRHkB5YrYizzrnbpHHb5tWN32d4TuK0eGzcxlc4fVnUTLgXGA>
    <xmx:3sd-aj71xqzxYlKT0At114e5gXJhB-fT1DfCXbf8TRZYNHjJBIZ2Ug>
    <xmx:3sd-ajwpB5i1g8aFXXfmW0xbgekK7vm9C7G2KdkloROMbGPG0ooe6g>
    <xmx:3sd-akatNzYAsVDhaK0oTB_Zdr-HaVrMqM5gmji7RebxS8xE-rGugGbM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 03:46:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 96d943d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Aug 2026 07:46:36 +0000 (UTC)
Date: Fri, 14 Aug 2026 09:46:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 1/9] builtin/receive-pack: properly clean up keep files
Message-ID: <an7H2C3JKqEdbGXQ@pks.im>
References: <20260809190106.1565882-1-jltobler@gmail.com>
 <20260811175415.2044235-1-jltobler@gmail.com>
 <20260811175415.2044235-2-jltobler@gmail.com>
 <anwNonpw5SZuHADv@pks.im>
 <an41gSCa7EFGkB1r@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an41gSCa7EFGkB1r@denethor>

On Thu, Aug 13, 2026 at 04:45:16PM -0500, Justin Tobler wrote:
> On 26/08/12 08:07AM, Patrick Steinhardt wrote:
> > On Tue, Aug 11, 2026 at 12:54:07PM -0500, Justin Tobler wrote:
> > > When git-receive-pack(1) stores an incoming packfile with
> > > git-index-pack(1), a ".keep" file is written alongside it to hold the
> > > pack in place until the references have been updated, and is removed
> > > afterwards. The path used to remove it is derived via
> > > `index_pack_lockfile()` from the repository's primary object directory.
> > > 
> > > In bdee7b3013 (builtin/receive-pack: stage incoming objects via ODB
> > > transactions, 2026-07-10), git-receive-pack(1) started using the ODB
> > > transaction interfaces instead of managing a temporary directory
> > > directly. When starting an ODB transaction, the sources list is
> > > reordered to insert the newly created transaction source first as the
> > > primary to ensure writes are routed to it accordingly.
> > > 
> > > Prior to using ODB transactions, git-receive-pack(1) would only set the
> > > temporary directory as the primary source for the child
> > > git-index-pack(1) and git-unpack-objects(1) processes it spawned and the
> > > parent process would set the temporary directory set as an alternate
> > > only. By using ODB transactions, the ODB source list is also reordered
> > > for the parent process which results in `index_pack_lockfile()` deriving
> > > the ".keep" path relative to the temporary directory instead the actual
> > 
> > Nit: s/instead/& of/
> 
> Will fix.
> 
> > > main ODB source path. Consequently, this prevents the ".keep" file from
> > > being properly removed after being migrated into the main ODB source
> > > post-commit.
> > 
> > Hm. Are the temporary packs written into the transaction-managed tempdir
> > now, or do they still end up in the main object directory?
> 
> The packfile and associated ".keep" lockfiles are both initially written
> into the temporary directory managed by the ODB transaction. On
> transaction commit, they are then both migrated to the main ODB.
> 
> When registering the keep tempfile, we need to record the future
> post-commit location of the keep file that way it can be removed when
> `odb_transaction_finalize()` is invoked. This matches the original
> behavior prior to ODB transaction being introduced in
> git-receive-pack(1).
> 
> > > diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> > > index 86933d8d7e..d74b787148 100644
> > > --- a/builtin/receive-pack.c
> > > +++ b/builtin/receive-pack.c
> > > @@ -2412,7 +2412,13 @@ static const char *unpack(int err_fd, struct shallow_info *si,
> > >  		if (status)
> > >  			return "index-pack fork failed";
> > >  
> > > -		lockfile = index_pack_lockfile(the_repository, child.out, NULL);
> > > +		/*
> > > +		 * The lockfile filepath is expected to be the final location of
> > > +		 * the ".keep" file after being migrated to the main ODB source.
> > > +		 * This ensures the lockfile can be found and removed later
> > > +		 * after the ODB transaction has been committed.
> > > +		 */
> > > +		lockfile = index_pack_lockfile(transaction->source, child.out, NULL);
> > >  		if (lockfile) {
> > >  			pack_lockfile = register_tempfile(lockfile);
> > >  			free(lockfile);
> > 
> > Okay. So previously, we wrote the ".keep" file into the main repository,
> > whereas now we write it into the temporary object directory? Is the
> > packfile itself also written in there?
> 
> Not quite, both the packfile and keep file were written to the temporary
> directory and continue to do so.
> 
> Prior to bdee7b3013 (builtin/receive-pack: stage incoming objects via
> ODB transactions, 2026-07-10), the ".keep" files were also being written
> to the quarantine directory and migrated alongside the packfiles. The
> main git-receive-pack(1) process always kept the primary ODB as the
> first entry in the source list though ensuring that the "filename"
> registered for keep tempfile was the final location. With ODB
> transactions though, the source list order _does_ get changed and
> resulted in the keep tempfile not knowing about its final location.
> Consequently, it is no longer cleaned up.
> 
> > What I'm wondering is why we even need a ".keep" file at all anymore if
> > we're not storing it in the main object directory. It wouldn't help us
> > to avoid the race, because after committing the transaction the ".keep"
> > file would remain in the temporary directory, whereas the packfile would
> > have been migrated to the main object directory. So it doesn't have a
> > ".keep" file at that point, and neither have references been updated to
> > point to the new objects yet.
> 
> The ".keep" file does end up in the main ODB alongside the packfile when
> the transaction is committed. The main problem here is that it is not
> being cleaned up because the post-migration path does not match what the
> registered tempfile tracks.
> 
> > So I wonder whether instead, we'd have to:
> > 
> >   1. Start the transaction, creating the temporary object directory.
> >   
> >   2. Write the packfile into the temporary object directory, but don't
> >      create a ".keep" file.
> > 
> >   3. At commit time, first write a ".keep" file in the main object
> >      directory and then migrate the packfile over.
> > 
> >   4. At finalization time, prune the ".keep" file from the main object
> >      directory.
> > 
> > That would retain the current properties of the system, but as far as I
> > can see this is not what we're doing here.
> 
> With this patch, this is effectly what we are doing already. The main
> difference is that we are creating the ".keep" file alongside the
> packfile via git-index-pack(1) and migrating both when
> `odb_transaction_commit()` is invoked.
> 
> We could stop relying on git-index-pack(1) to generate the ".keep" file
> and instead generate it ourselves during the commit phase as you
> suggested, but I'm not sure that would really buy us anything right now.
> For now, I think it would be fine to keep the changes more minimal.
> 
> I'll try to clarify the commit message a bit in the next version to
> better explain what is happening.

Thanks for the explanation, this helped a lot!

Patrick
