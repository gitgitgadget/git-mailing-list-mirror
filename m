Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919FB3E9F93
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 05:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792042189; cv=none; b=iU36OzHZ2BHClU+l8qWV3TQA6geZORyas4cDc8C35/THxbuI3jlFX7+eDwpE9BQsQuia8yTsNvUdahuwwqE0S1Ni5s7r8uSjspnwk1bUaQF/5LluXsAbITBPcSmvHAQz9TMdBJ8OVJnjtPvSh26hC/0iT8xCx+auxuMiT5Zf+Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792042189; c=relaxed/simple;
	bh=ubiVRha1tSAyxQ+ifuHXK09UBzkzpRbq9ZHIhS+nrK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuotcNQbgfkkgPWoNQn/DtSLElVc7UrAq67BdNYim6+h0CxEt8FAWztY2iMRZ0djUudgAn9qH+glOyMk/KoyA9KZASt3Vw7JeRdt4LQ/cx9928rwQZLI/rstweeNu2tjtReRP/ufyu0iUXX+lyVU4ZY1jO+44jXLMXMRkKEJtfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pfWxYhbI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nevm8dR5; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pfWxYhbI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nevm8dR5"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C693D7A0195
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 01:29:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 15 Oct 2026 01:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792042187; x=1792128587; bh=K5L5Z5WT6L
	vtMHt0+uu3K60dGbrQTgkqPkTJJGDSRcY=; b=pfWxYhbIRj01afO5x4vkBLFj1D
	x5dNZMu5AqokHjPzq6+OrJAyjbyiFAp4/GXkLFkjXeWRYu/xjqk7c9IP7vnKapDl
	mfoNRpcuXMZMFN9ODeB9JV92JwhXEzJEegSxnper0ASFcKVdJVQVRsNJhXZjdl2G
	abZiY6f0QmQNLVthC5O3uEOrPnz1tK/TfzdTMElG3k2LjMEDDm3SXgxv0oAibKFZ
	UnoUjkzIYnhFkQRRLdr/WRHN3zBGxtXQuEI3UVR41W5K47X4vkg0G387hnoeDIm4
	hLq4qNiOI7Y/Kp+a2a5NBGKCitZu66ccSJoKUBDa9XKaSyhf/Q5YueB5hGlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792042187; x=1792128587; bh=K5L5Z5WT6LvtMHt0+uu3K60dGbrQTgkqPkT
	JJGDSRcY=; b=Nevm8dR5Qa0Jknw5eEAKD80ilNYGj5p6Vn2AXKxD8ADErQ7GcTo
	FhBVpaRMAXh1/dXT0lycjd13us1Htcxz7J+OETSV7pxja7pX20UywILABCEV3GJw
	PAh7DkYO+tIqJl0d+kaoYFiy92P3v0PInUIXdMELg1/2jUIeTY4rSsuxF8GYkJNn
	ZVlfBz9HpIc7p6zlHoQ40P1dUmNtPEGcW7JEOra71hsMCM2H6cvWxSJ9SwC9d/3T
	gC+qTH1F0DVqQnwF3/IGGgiuLpe7LVgKc/ZiHeR/aHoUCqNs6HzKeIY6foIzH/d4
	JU1xCq/fURM6TEIRHLbRv5dHoqJsj7LpAFA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792042187; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ERItmdt+tBDNyK9qvHWTtLrgL7ww/eNCaSBMmCPec7ygIC6
	o68mg66+mt7S2CvwwwI6OJbvrywMNlvg7JBYUa1mDIe5CvL9z1jJAiwqLEqhX7b2
	f1VI9CKRWkctohTM9ojfCU9p5+CVEFpYtkOoCpODRLRChPvHxL1YQ58SgGdyW4/g
	j+wbtTogbn7wpW5QjzK3RvP1ITNU36EjnuTnUXywfNYLhfsey6uC9IFppJPsSEYI
	mYaJyhhy7uZ43Had+BKz9KLypxYrwu2VG/IC1ue2bGIGIHxfflsCIZ9DZnPWYHZA
	OCfF2ZKeorymjYxmMEO+pzxSoJ9IURXHFJzth+A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:gqt6Yq8yQqWO0N4FPdn6NfJc0ir9WYMkR4uD4lpoA5s=:ubiVRha1tSAyxQ+ifuHXK09UBzkzpRbq9ZHIhS+nrK4=;
X-ME-Sender: <xms:y2TQanJDcVUKMo35ian7ccji9o5-Vx2tKmLEVCNpaUvK9N9bgez6iw>
    <xme:y2TQaiLkGJACSXxjHLbmCpm5cA-DL8wbJY7P2hDiq9pdoY8b7lO-ymBLvaSRWmNnF
    zsYoJXH02JO_kQMTW3oa29nE5rnGqTCzEeSaOUZt3A3tZiCu8yEOg>
X-ME-Received: <xmr:y2TQaku80fAcWz5sF8G2LGIxqUopfjStZHfdbE1b6rMdJRvwPkF3Fym_GyHJNl8hcc8UviA>
X-ME-Proxy-Cause: dmFkZTFJV1nltFEmAqB7LI2zs2JK8NzI7U/CBIQdWdvesL3aXnEgUXZzz9jdA+Mou61BKS
    NIckmUE70Jz3RQjdoMyKenUf/5Whc4RJDevbyIzY12wf90g6iBGzCfOGyQtQCFCgNQ87gx
    wW/D4O+nWCcJpLYCJvp56f+LdCNF1tCuNC6npo4XmQacgmksOl2ImH/SMf+ihITLDCWPja
    1Sw4vC6hPAyo9PqvhzTZwYwtru09fWRyE4FsKkGSXiOT4VRlG1iEjz7GuXkmOOF4eT3v5G
    d08SLVri8d8sE2bze3XENdbbZwX25h6wh882NANvsl9cmGPPs7xImh6gvsA5aN4Q8EjCES
    iI7XdMfa6H5FyQyc5i91REe17WNTRQwIcjfJD2NpE7/iS8hOIIg3Epo43DKmQSD/FEHwa5
    vDlGqwvhb22Jzeo87azXrKC6qwceLH524NWtP1qLFVH6hGuERCLiIWBxCMpxJ73aFWMSiq
    rSVXoVX88KOEGkeq0f6Q/Cg95jyJSahO8GHJA5xyfWyp0oUBgveV0CgX7zD+TVPDydU5/3
    EaJVKtO6stM9cA0B7+NdU9/dVMv4lf0ojr/QjzVAd1JxzmkW3KxsqnRDfxob9wrRTNZjZ+
    OATyse3rX9zorfuZoeKrzMg1011mGcN77w1hQWg5wjXYzk8uRkFDvq8H8gEA
X-ME-Proxy: <xmx:y2TQavSbvHADDUs7YUhlzISIBI4cIdcJtgV1UlUfSJvADHv5cLpRCQ>
    <xmx:y2TQaqPUnH5U_Q2HuqyyoiHN46Lyc28zZgWlOgRK_pwWDmX7xNYH-Q>
    <xmx:y2TQakZJq37W2y6DEh0btX-5kuhQSNZxuG2YR0vdaV9jrs9dewrbCA>
    <xmx:y2TQakwqNptaoJN4gYgupy33J00440fKWgBPN-WH-PYAOiXI7YX9Rg>
    <xmx:y2TQavuL-LvkzQkZJNuiELj55ZRJgeH4vCVfnR7_EGR6Nyln4PCcUpEt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 01:29:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bad87157 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 05:29:45 +0000 (UTC)
Date: Thu, 15 Oct 2026 07:29:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wolfgang Kritzinger <wkritzinger@atlassian.com>
Subject: Re: [PATCH 5/5] odb/source: drop `local` flag
Message-ID: <atBkxlGbTfm1g_e8@pks.im>
References: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
 <20261013-pks-odb-files-alternates-cleanups-v1-5-b7030ff2b26f@pks.im>
 <as6palGWxRlky0bS@denethor>
 <as8njPHSZVabmb4Q@pks.im>
 <as-iH9JtWaKacK4T@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as-iH9JtWaKacK4T@denethor>

On Wed, Oct 14, 2026 at 10:43:23AM -0500, Justin Tobler wrote:
> On 26/10/14 08:56AM, Patrick Steinhardt wrote:
> > On Tue, Oct 13, 2026 at 05:44:11PM -0500, Justin Tobler wrote:
> > > On 26/10/13 09:36AM, Patrick Steinhardt wrote:
> > > > The `local` flag indicates whether a given `struct odb_source` is a
> > > > local source or not, where "local" is defined as being the object
> > > > directory that is directly attached to the current repository. But now
> > > > that alternates are handled in the "files" backend, this property is not
> > > > something that even makes sense anymore to have on the generic source.
> > > > 
> > > > In fact, we already have a partial replacement for this field in `struct
> > > > odb_files_dir`. The only other site that requires it is the packed
> > > > object database source, because it propagates the bit into the packfiles
> > > > it is opening.
> > > > 
> > > > Drop the flag from `struct odb_source` and instead move it into the
> > > > packed source.
> > > > 
> > > > Note that we stop considering the `local` bit when iterating through all
> > > > loose objects with the `ODB_FOR_EACH_OBJECT_LOCAL_ONLY` flag. This is
> > > > fine though, as we already handle the flag in the "files" backend
> > > > itself, where we skip over any object directory that is not marked as
> > > > local.
> > > 
> > > I do wish we could also drop ODB_FOR_EACH_OBJECT_LOCAL_ONLY. This flag
> > > also feels rather leaky to me. I guess though we still need a way to
> > > ignore objects from certain sources when iterating over all sources such
> > > as the inmemory source.
> > > 
> > > Overall, I happy to see the `local` field dropped from the generic ODB
> > > source structure, but IMO is does make each `for_each_object` callback
> > > handling of the ODB_FOR_EACH_OBJECT_LOCAL_ONLY flag a bit ambiguous and
> > > awkward.
> > > 
> > > Naive question: Do all odb_for_each_object() call sites that use the
> > > ODB_FOR_EACH_OBJECT_LOCAL_ONLY flag have "files" backend specific
> > > reasons to do so?
> > 
> > It does make it awkward, I agree. There's only two callers that use the
> > flag right now:
> > 
> >   - git-pack-objects(1) with its "--local" flag. I consider this command
> >     to be too specific to the "files" backend anyway though, so arguably
> >     we could just let it handle this directly.
> > 
> >   - "reachable.c" via `add_unseen_recent_objects_to_traversal()`. This
> >     is invoke by git-prune(1) to mark reachable objects that are recent,
> >     and it's dubious that we only enumerate local objects here.
> > 
> > So we might be able to get rid of that flag altogether. But I'm inclined
> > to go one step at a time and leave this for a future patch series.
> 
> That's fair. I don't think we need to get rid of this flag as part of
> this series, but it seem like it would be something nice to eventually
> remove.
> 
> Do we want to leave a TODO comment to mention this?

I think I'd rather keep it in the hive mind. It's a bit more intricate
to get rid of this, and TODO items often invit rather mindless
approaches to fixes.

Patrick
