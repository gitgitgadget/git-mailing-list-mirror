Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424B2415F07
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 06:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960978; cv=none; b=Tp6Kwx9pvrLaGV3aRf3FeSTsTD9EW1hkknhPHHGhlOvEsNNzE5NFV3WJa6q3QRbcZ8oa6gDUFHQs2Wvz3wKqQc1U5jmah50Ff+bxMaTkGK/dGXqYbJzwvmUzQnc18WRsYHX/dkNKfGiVKtOVRLvZ6YestceOkfSivmkSYktRarE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960978; c=relaxed/simple;
	bh=Puwpjg09qmFHlXbrBM2lhx7RshhOv7p+6cC0jqGOOmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GepYgzshvsVd3M76hhQ4Z6tLnDPVcSmMjfUUguRJ5H0rZ8dADFTC7ZxzXPza0/LG2gaxuojOA1gSfugGcPTnAWwXI3WasWM5IEg046fU2jW5OjWmGx6FzcqJh+1Ljqx2grOOWKLIC8zIAtlajQEy+6If/oVdl3iqLN1Xb7gc0/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Uee7JXfi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A8cR/llC; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Uee7JXfi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A8cR/llC"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 6FB1EEC0259
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 02:56:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 14 Oct 2026 02:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791960976; x=1792047376; bh=77Ca1duhfP
	lmzKz804O3LlMgb5Rg1Vc8x7F6ny/LffU=; b=Uee7JXfi1ycMUUOJkyPjG1PcmZ
	8eIpLcPfVKM6r6NoFrc8MKMt+j5j4+vGGenuqglXHKl0MraAFRSMu+DDX2kZ9XmV
	8MrSBmWIWDnH9VPVCBLpZsyCP82kwPV6/4WwFDwcqpcyt7pc0GMwtJMBlkCpmHXU
	93D3oPJ5jiHxFxceQeLUqFAXhNl5YoI66Dzfz+u5MqNJ53nl79jkhnf7lOIwmMzt
	ZLBOBiqE8RgbM6ZSdDXLlkYek36HZbNWi48BxlOKrTjBSq9RAKWkyDug1lc+vc+m
	5WvtJvIajeVGODqq7ZdVbKwX2c20aq58i1l8Tk6cL7b/3XNqGHb+Vr5WeGXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791960976; x=1792047376; bh=77Ca1duhfPlmzKz804O3LlMgb5Rg1Vc8x7F
	6ny/LffU=; b=A8cR/llCjaMT1ZNouG5b/aZILSUaxxPbGwxQ5IilpDhGXxdvm4K
	W6ZN0kFtzEftnLi+YVM5cuoIFvhd4az5GQUXxBOJWMtwhM/kXf+iKgEpJj6S3oiN
	ltxv9xNgACcVHY4jn8RxwIuQN41TM0PP0hWrZGBxfxKaqaj6U+ApPS8gabMRK5ky
	3ZBLoAMrg4s7kutC+7hulym0Tx2pgtd0lUu9H/ttEs/UfiSG5GErzEwW90gppzU9
	irZSIQg+S5ejDA1XKMN6MK6rZRQcBd4GdmUgcr71//5EbTCIgtNbbarhxAnH0BIF
	wCgBBvRFUVvtAnqFY+5jzCVTDItZkdWGm9w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791960976; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mSW8S1I/AY4U05YHRmqtszfyD8DUdccN/1PCqS/Uvxt4Kwu
	huxeVhj4XKHZj/lq0oZfl2BtrlQv9B9scS9kXcx2SMslfFRJevB9bhovm9g1q9Xt
	qDbKJ5ZjKIESRjCSqFZd6YPTsEwtg3wEvUowf+yjV05VNTITC+BLBPyEAefrk9iA
	DyOG2mlQ0ZltnPudmYOZdQ0n4MF9rc7WptyVusw+fNkYnmuyfuRySRiB2XK7kUMi
	BAfX6ZocNBrg0UM/Kx18++NoFzxqwonW0b4C0gE/C46wMPaqdbhPLdtHgy5KmToZ
	YbEgAaQSg8ZiCBFw8Nbrt7aggxfMeZr8fzbKqJQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:7mz967M8cybHHm+3UjaK2MhswCh0H+3MZ7fMLdZkGlQ=:Puwpjg09qmFHlXbrBM2lhx7RshhOv7p+6cC0jqGOOmg=;
X-ME-Sender: <xms:kCfPagpdyEQTaYK5Lu2GHqCmpkD1gYvhYtQcUFOQZ0lGpybcaHcnrg>
    <xme:kCfPatpZTSEgqKEk4rFiz-qKJhuJqi7KL93Je9u3VpnaMHFLl4fzwG8IF9D9meQX3
    qLid8h_30S-Fr1pojxBWSQZcYnEm1fBTc98aKbKQ5osdOtPAQRY2w>
X-ME-Received: <xmr:kCfPaqMri_vH25uyw_MziBAel7LPXTFadAvZoUpSGIP6hwWyV4TTYw>
X-ME-Proxy-Cause: dmFkZTFON8dSSZH2/U5G9GPL1LNK+zo2t5xauwS/+yR+BbFodLZpc8hxDm/MfNbaO53PVH
    Q42Dftq50cWbslfxnCGVTXz3YT9BemSGiXS/zVpBxzwBlwYXAEwBJIPDeWo1R0DbFkERvb
    Yp1NrBgaPSDPmgsKt1qGhiTUXAAMuRLzDU9sw6O4taQvZQL2h60H1GBAQY8oXl0v7+LzO4
    e6F0MF2TIHjaJEMUzkUrLsyrVLwjB8A9ZW1dbZk3/k01atC6VpWtuLCrsDun5I+w/kiWrZ
    Lbs8to1RCwr+Za54hAyzsahzSbNfMPMMRoqhunyUMsYl2XfAzjAVV63hNt75FHhlkjmlr8
    eQ0sy1vHuxnIsEzTiLjORG7Cem/DRbEu592iCE0eIai76tjwSM10dTmqSB16tsd3vkQSWh
    CE0q1fmR49qnJvlnL9cftn31rQcuHp1UGKY94eOrUqaZErCI59qmklatDFyg5y0qRVemWl
    oaIQZs4TaCZXA4habJXDBOqHB+PR7qUkI6skcGDeLNTBMtQe4VhgKejzrFE/16QjUPFv2G
    SsUVE7nAirx+wBgp81WPKCdAoiTBFkNQysKraV2+Ke9ENAwZEU1nHuAJ92MP0w4HpPEORr
    7VUVndmim8lUJLcHaHrrTd6HwfCTvXfZ0wnp9PEu6bmAEuj6QhGQiUp9nNrA
X-ME-Proxy: <xmx:kCfPamwU2pA603FJ0AlrBWIxw77m5kzvy2uPYPPfisw31Tf02yh9ag>
    <xmx:kCfParvvBMTOwR3bbRMCVq7nxaMlPWjMJG-B7BD5afsc7S886BshcA>
    <xmx:kCfPan5idl6koG2oU3m9BgsxLFL4jmjFzawmfDBSpNdf8rRpvt4dFA>
    <xmx:kCfPaiQ3-Cz5DJZQ1jAMxXTJZL9MKOZCfsc7w1eD88HwB87q9AL6XQ>
    <xmx:kCfPavMnztNSo2r-j8xZ8IpidBYStKPxHhxj8ectzjJnnGN2qsWzkROO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 02:56:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 95921521 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 06:56:15 +0000 (UTC)
Date: Wed, 14 Oct 2026 08:56:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wolfgang Kritzinger <wkritzinger@atlassian.com>
Subject: Re: [PATCH 5/5] odb/source: drop `local` flag
Message-ID: <as8njPHSZVabmb4Q@pks.im>
References: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
 <20261013-pks-odb-files-alternates-cleanups-v1-5-b7030ff2b26f@pks.im>
 <as6palGWxRlky0bS@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as6palGWxRlky0bS@denethor>

On Tue, Oct 13, 2026 at 05:44:11PM -0500, Justin Tobler wrote:
> On 26/10/13 09:36AM, Patrick Steinhardt wrote:
> > The `local` flag indicates whether a given `struct odb_source` is a
> > local source or not, where "local" is defined as being the object
> > directory that is directly attached to the current repository. But now
> > that alternates are handled in the "files" backend, this property is not
> > something that even makes sense anymore to have on the generic source.
> > 
> > In fact, we already have a partial replacement for this field in `struct
> > odb_files_dir`. The only other site that requires it is the packed
> > object database source, because it propagates the bit into the packfiles
> > it is opening.
> > 
> > Drop the flag from `struct odb_source` and instead move it into the
> > packed source.
> > 
> > Note that we stop considering the `local` bit when iterating through all
> > loose objects with the `ODB_FOR_EACH_OBJECT_LOCAL_ONLY` flag. This is
> > fine though, as we already handle the flag in the "files" backend
> > itself, where we skip over any object directory that is not marked as
> > local.
> 
> I do wish we could also drop ODB_FOR_EACH_OBJECT_LOCAL_ONLY. This flag
> also feels rather leaky to me. I guess though we still need a way to
> ignore objects from certain sources when iterating over all sources such
> as the inmemory source.
> 
> Overall, I happy to see the `local` field dropped from the generic ODB
> source structure, but IMO is does make each `for_each_object` callback
> handling of the ODB_FOR_EACH_OBJECT_LOCAL_ONLY flag a bit ambiguous and
> awkward.
> 
> Naive question: Do all odb_for_each_object() call sites that use the
> ODB_FOR_EACH_OBJECT_LOCAL_ONLY flag have "files" backend specific
> reasons to do so?

It does make it awkward, I agree. There's only two callers that use the
flag right now:

  - git-pack-objects(1) with its "--local" flag. I consider this command
    to be too specific to the "files" backend anyway though, so arguably
    we could just let it handle this directly.

  - "reachable.c" via `add_unseen_recent_objects_to_traversal()`. This
    is invoke by git-prune(1) to mark reachable objects that are recent,
    and it's dubious that we only enumerate local objects here.

So we might be able to get rid of that flag altogether. But I'm inclined
to go one step at a time and leave this for a future patch series.

> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> [snip]
> > diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
> > index 868e723c81..75cf29fa9d 100644
> > --- a/odb/source-inmemory.c
> > +++ b/odb/source-inmemory.c
> > @@ -161,8 +161,12 @@ static int odb_source_inmemory_for_each_object(struct odb_source *source,
> >  	};
> >  	struct object_id null_oid = { 0 };
> >  
> > -	if ((opts->flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) ||
> > -	    (opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY && !source->local))
> > +	/*
> > +	 * In-memory objects are neither promisor objects nor do they live in
> > +	 * the local object directory, so there is nothing to iterate over.
> > +	 */
> > +	if (opts->flags & (ODB_FOR_EACH_OBJECT_PROMISOR_ONLY |
> > +			   ODB_FOR_EACH_OBJECT_LOCAL_ONLY))
> 
> So for the inmemory source, we don't want to iterate over the objects at
> all if we are only interested in "local" objects.
> 
> Naive question: Are there any scenarios where we even would iterate over
> an inmemory source and only be interested in "local" objects?

Not that I'd know of.

Patrick
