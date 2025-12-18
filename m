Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0203314DA
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766040656; cv=none; b=AcUF/4VgCTngrmwqTmLj1U3xXOpT0sdKaBdwVdgyjfVsl/9AgUtTTfuul4HMA94kri18CIIMKqf5lKxw4v6gk+YXZ+nwNgXr/zKf6MfE1oFsDMCU2DYSa+GjwyZb/44v4LSa8HDy3SgCugicyaUaz4It5Bd0uMT6Uj7tLQQ+9cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766040656; c=relaxed/simple;
	bh=u9LXBNyz5wDVvPoM+Meh860EdGB4ah6rQ59B1fsWAsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1XE9abwQcemRsQ2HAHXgHlTmNWYMgAoe20dRoxZkssewi9/KIOEJujWQbLci1nmsNuTcCkjiStmDYVAnUSPv9pviAqWLpI1FLiMjra1Q7x9rfv0JRo484ZiR0aegdg6hHjGd97fknl3VY41RtGE+bhTfP7Wk+GQ0nFM+0rqBRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b+diy+pw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B8qzxird; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b+diy+pw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B8qzxird"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 879C17A016A;
	Thu, 18 Dec 2025 01:50:53 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 18 Dec 2025 01:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1766040653; x=1766127053; bh=U7mVQGKaNk
	CpsrFQAHNclp20hEUV1kMk89Ree1iFzLQ=; b=b+diy+pwXtC0Xre3SHdZIVth4+
	Q2DJRh3LryzkoVugg6+HYf/f3zFVaCjfB4nLEedfdgYPRnP1JxAlMYaHC+wP5YJ9
	l53JUtL15uXA1inGeSrhTwAXb+6I9fQJy6hVsR0/AfZ01VMp2O7arPH55Q3XHmIr
	K63L/2IhCbwKlrE/VOeOD8pahIO5zWueMf+O6YVicjAYvtK7asFYzqRYmtDU4pm9
	IHXSebgj2ebmerLbu8+nm81ZxDvjueOSUQvdVY9PS03pjPAfE1xgkyNbx2i2kw+s
	2BaBi4lIUUB6QjhRFUTqlMr4s6kWxKqyW4FSXsJ65zsa8aMroKNxmpm8SB+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766040653; x=1766127053; bh=U7mVQGKaNkCpsrFQAHNclp20hEUV1kMk89R
	ee1iFzLQ=; b=B8qzxirdQG5RcOLSeug9v72oXbiZZ/iDzYZZ5d4XuGTZ/9q/C/Z
	l/jmnoaa/msxyo99JWWIRzOdCaYHL57Li0APcmoxH47OeRrB1XzSRaRDatThfjbI
	oYzhBajKTtXblcYKvxvd57ve32O6RrLpCvNULPcgAlpUGV1R4SblOncLY02z8yoH
	M//Zi7Q/5YliGlNq95pIjOg4H+mVdI+h6LRz20U4VTsE9E09uMW4pXdJ8ylPSkRZ
	NSvGMT4ouPRidhdXOBxIBIWl7flv34bkP3vhukZ9fU6XI4n8/7EuwpKhDIncoapC
	35iSWhV/9cc52ubyT3LsbLq8UOwBDuTsUyA==
X-ME-Sender: <xms:TaRDaeKrlXfducpLHtXxrPLuixO6l5jZ_HF7bu2VqPXLDJQZoFmNAw>
    <xme:TaRDacLaEqzoVIV1kFM4qPlszXIsWlMx-TkS56Kx_qe43F29cq0dnYog7jXeGFqZ6
    ciOSdspjuONXdpGcXH9k52tTOG1-BygkmbMHTeox_1NmA1cUx09bR8>
X-ME-Received: <xmr:TaRDacVmsk8sQkwMnHQTluiZSxr2p8t2EoBIVNsLXtTemXMQVFCuALuzxhFa37X_gZ09K7YhxO8EzCL0GYgioDixZ8jaG8J72F4JeXAPVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:TaRDaegIwfIJ2miWW0yeMRSrhZ29W5KqWnyLOeTYw5w4M6z9xtT8Og>
    <xmx:TaRDaX-41xlfQD49OScgwTRJJz_s2fzot1JcBsxNjF20c3BEMBjXXg>
    <xmx:TaRDaYCTR6Va8iqib0OR1npSbn96C2v5EE1sSyOrJqmaO31HlP10Mw>
    <xmx:TaRDaUKAk4PM9-aTJJsdvG9Z3VV27Vj5CSK5txqoKzxHoeTxboMhUQ>
    <xmx:TaRDaf4ULT9SR3PhroS_UNigmVtwNMALV8iO3y035Z7O71YXmxyxF-Qz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 01:50:52 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id de95666d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 06:50:51 +0000 (UTC)
Date: Thu, 18 Dec 2025 07:50:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/10] packfile: move packfile store into object source
Message-ID: <aUOkSDz_UTSM92YT@pks.im>
References: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
 <20251215-b4-pks-pack-store-via-source-v1-5-433aac465295@pks.im>
 <coihoxu2loroo4xrlog226c6ib7hy6wfsvlbfvanhp3xksezie@buisls2ii3d5>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <coihoxu2loroo4xrlog226c6ib7hy6wfsvlbfvanhp3xksezie@buisls2ii3d5>

On Wed, Dec 17, 2025 at 06:52:53PM -0600, Justin Tobler wrote:
> On 25/12/15 08:36AM, Patrick Steinhardt wrote:
> > diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> > index 7849005ccb..b8a7757cfd 100644
> > --- a/builtin/fast-import.c
> > +++ b/builtin/fast-import.c
> > @@ -900,7 +900,7 @@ static void end_packfile(void)
> >  		idx_name = keep_pack(create_index());
> >  
> >  		/* Register the packfile with core git's machinery. */
> > -		new_p = packfile_store_load_pack(pack_data->repo->objects->packfiles,
> > +		new_p = packfile_store_load_pack(pack_data->repo->objects->sources->packfiles,
> >  						 idx_name, 1);
> 
> Naive question: it looks likes we are only using the primary source's packfile
> store here. Is that fine?

We write the new packfiles to the primary source, yup. That's in line
how we write objects in general: they always end up in the primary
source. In contrast to that, reading data will involve all sources.

> > diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> > index a7e901e49c..b67fb0256c 100644
> > --- a/builtin/index-pack.c
> > +++ b/builtin/index-pack.c
> > @@ -1638,7 +1638,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
> >  			    hash, "idx", 1);
> >  
> >  	if (do_fsck_object && startup_info->have_repository)
> > -		packfile_store_load_pack(the_repository->objects->packfiles,
> > +		packfile_store_load_pack(the_repository->objects->sources->packfiles,
> 
> Does packfile_store_load_pack() also load stores from all sources?

No, it doesn't, and in this case here we also don't want to. The sources
have already been loaded beforehand if we have a repo, but here we want
to activate the new packfile that we have just indexed. This is done so
that we can then perform fsck checks for the objects contained in that
specific packfile. And hence, we really only want to activate that
single packfile with our primary packfile store.

> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index e86b8f387a..7fd90a9996 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -1529,49 +1529,53 @@ static int want_cruft_object_mtime(struct repository *r,
> >  				   const struct object_id *oid,
> >  				   unsigned flags, uint32_t mtime)
> >  {
> > -	struct packed_git **cache = packfile_store_get_kept_pack_cache(r->objects->packfiles, flags);
> > +	struct odb_source *source;
> >  
> > -	for (; *cache; cache++) {
> > -		struct packed_git *p = *cache;
> > -		off_t ofs;
> > -		uint32_t candidate_mtime;
> > +	for (source = r->objects->sources; source; source = source->next) {
> > +		struct packed_git **cache = packfile_store_get_kept_pack_cache(source->packfiles, flags);
> >  
> > -		ofs = find_pack_entry_one(oid, p);
> > -		if (!ofs)
> > -			continue;
> > +		for (; *cache; cache++) {
> > +			struct packed_git *p = *cache;
> > +			off_t ofs;
> > +			uint32_t candidate_mtime;
> >  
> > -		/*
> > -		 * We have a copy of the object 'oid' in a non-cruft
> > -		 * pack. We can avoid packing an additional copy
> > -		 * regardless of what the existing copy's mtime is since
> > -		 * it is outside of a cruft pack.
> > -		 */
> > -		if (!p->is_cruft)
> > -			return 0;
> > -
> > -		/*
> > -		 * If we have a copy of the object 'oid' in a cruft
> > -		 * pack, then either read the cruft pack's mtime for
> > -		 * that object, or, if that can't be loaded, assume the
> > -		 * pack's mtime itself.
> > -		 */
> > -		if (!load_pack_mtimes(p)) {
> > -			uint32_t pos;
> > -			if (offset_to_pack_pos(p, ofs, &pos) < 0)
> > +			ofs = find_pack_entry_one(oid, p);
> > +			if (!ofs)
> >  				continue;
> > -			candidate_mtime = nth_packed_mtime(p, pos);
> > -		} else {
> > -			candidate_mtime = p->mtime;
> > -		}
> >  
> > -		/*
> > -		 * We have a surviving copy of the object in a cruft
> > -		 * pack whose mtime is greater than or equal to the one
> > -		 * we are considering. We can thus avoid packing an
> > -		 * additional copy of that object.
> > -		 */
> > -		if (mtime <= candidate_mtime)
> > -			return 0;
> > +			/*
> > +			 * We have a copy of the object 'oid' in a non-cruft
> > +			 * pack. We can avoid packing an additional copy
> > +			 * regardless of what the existing copy's mtime is since
> > +			 * it is outside of a cruft pack.
> > +			 */
> > +			if (!p->is_cruft)
> > +				return 0;
> > +
> > +			/*
> > +			 * If we have a copy of the object 'oid' in a cruft
> > +			 * pack, then either read the cruft pack's mtime for
> > +			 * that object, or, if that can't be loaded, assume the
> > +			 * pack's mtime itself.
> > +			 */
> > +			if (!load_pack_mtimes(p)) {
> > +				uint32_t pos;
> > +				if (offset_to_pack_pos(p, ofs, &pos) < 0)
> > +					continue;
> > +				candidate_mtime = nth_packed_mtime(p, pos);
> > +			} else {
> > +				candidate_mtime = p->mtime;
> > +			}
> > +
> > +			/*
> > +			 * We have a surviving copy of the object in a cruft
> > +			 * pack whose mtime is greater than or equal to the one
> > +			 * we are considering. We can thus avoid packing an
> > +			 * additional copy of that object.
> > +			 */
> > +			if (mtime <= candidate_mtime)
> > +				return 0;
> > +		}
> 
> Ok, this all looks the same, but repeated for each source.
> 
> Naive question: If a the same OID were to exist in multiple ODB sources,
> could this effect the behavior now that there are separate packfile
> stores?

At least it would be the same behaviour as beforehand. We used to
iterate through all packfiles before, and we still do that now until we
find either:

  - A non-cruft pack that contains the object.

  - A cruft pack that contains it with a more recent mtime.

The idea here is that we only want to pack the object into a _new_ cruft
pack if it would have a more recent mtime in such a newer pack. If that
wouldn't be the case there is no need to write the object into the cruft
pack that we're just about to write -- it would be immediately stale
anyway.

So it's basically the whole idea of this loop that the object may exist
in multiple packfiles, and we're trying to figure out what our actions
should be based on that.

> > diff --git a/http.c b/http.c
> > index 41f850db16..7815f144de 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -2544,7 +2544,7 @@ void http_install_packfile(struct packed_git *p,
> >  			   struct packfile_list *list_to_remove_from)
> >  {
> >  	packfile_list_remove(list_to_remove_from, p);
> > -	packfile_store_add_pack(the_repository->objects->packfiles, p);
> > +	packfile_store_add_pack(the_repository->objects->sources->packfiles, p);
> 
> Here we are always adding the packfile to the primary packfile store. A
> thus relies of the primary source having a packfile store. In order to
> move to pluggable ODBs I suppose this is one of spots that will have to
> be resolved later.

Indeed, we will eventually want to grow a new interfaces that allows us
to write a whole pack into the ODB. From thereon, the backend can then
do whatever it wants with the packfile.

Patrick
