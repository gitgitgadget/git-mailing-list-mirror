Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB9D3EF0DC
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527558; cv=none; b=jNaNsb7A/Hp/9F4IBUh9xqOJTI7x7NtqFnCfMWPS9zJbKfQm5msEACh2Dv8kjThCJzjPXr4hvLlsh5+stkG5SFCylX8Ka18zamvuSuM9T5dq4EaBbt6Wx5vFM7Uv+dw4w1wlaFyTsPuqmRvW4y+EIEeMTc96zHYtYkPS6tH3YiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527558; c=relaxed/simple;
	bh=jUIYbjbSSBf2hFxRraaFKsXX2PObExuFvFjiPoeq8uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWOs/mktN9l+W8z3txmoqA02LHybBBHZt5g48TiNA5v1hNSGzHv3RFFFqnF9tOshtD+7j12cz1ma2pQ7oCNXk+/PsrDjD6ccnPBJCZKkHORp2L4Sl9HLJLHaZ5AQMBAtBJNe8GQK7tm7RFtyOTBuEcESjFgL0t8NL9lUPIoS0hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qAcCLesg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pd7I9svC; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qAcCLesg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pd7I9svC"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2C850EC0222;
	Mon, 15 Jun 2026 08:45:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 15 Jun 2026 08:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781527556; x=1781613956; bh=p7kDoBMxdo
	JOaGefthBlGQWAy73gYzq9hKBGQMFf3+0=; b=qAcCLesg2gYFpmEmPVaPPjMbVg
	TsZjvqmb0DLbsj4PHbqgag7dzOFuzTXXDegxSsuOJ/sv+a50gMVr3ctFHA3T4bFI
	xmKghzIBrkRAGs1j3CiU3ncAqrkvBXVq5yLVOLpYQ5yBo3OEf7ydg1ZpeC8U6FCp
	kBFb510/kdd8OLs4VtM+ilrg6lA2iBsfg3un+0tnPAIeK11uCUCPClKewO9Gu2ag
	WC46ftcYx04A//7IXVF2tcPXrwhcNiEPSW6TBUkXqurQq4ayb88vtQk9zGGRmRoT
	6lgrxvujqcgc3rWqdTvJLDcKDesDLLyQULkfnZOGjg4WmMFyVKhD+W32cLpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781527556; x=1781613956; bh=p7kDoBMxdoJOaGefthBlGQWAy73gYzq9hKB
	GQMFf3+0=; b=Pd7I9svCQ/6342Pzh5OmX+xLR6ncuGZr88cQGYL2zWl/lsOaAwH
	wi1k8uBwtdpmcwRw/+xbUVbFm3N0Ub+pIu918RbH8006hcz4kfxoTSwiKsumEj5x
	qjc+UA2t1h9Zzw+NxxOSdVLLVyT35KaY4Tnz27OLyy7HTP8qSluywwV1WzCxA13N
	zIp/rdyLleiD8AFZrG7hO+NN9T8TwMmZnbJliXTrlyz9LqxA3+Hl+tgmwJe0hutC
	DcjoaEwDx59NSNvWIGPoIzCNFiFvf+ffmuZAe2FulHYlw9oK4PuyPkMuB951zhqm
	3AKid/RxCuMH9TWmB+GzELRKfnW6DqUQelw==
X-ME-Sender: <xms:A_Qvaq2LCXqCoWlPLuxFqu4y45wxtJ3UmUAJBfYlZzUYbNa5tovhAQ>
    <xme:A_QvaukQq9iPdiIbpJ02P7x4QM1Ltit6lVGh9tDqiAfDk31CKSGtKg6zetE4mk-j8
    fC9PH4TGxLxnXiJlNnmP-ARvrxPZYV7R2v65aikofiWtyB_Vq4kIpA>
X-ME-Received: <xmr:A_Qvai9G6ctoMB_DE3lFzKDxxKW2bLEe0cyXPSwse7i50bRFx7tDFcqRMlrFXwY5fcUgMSkDGSMQHQNhvera3cEEecrf7lIDHihv22JGUg>
X-ME-Proxy-Cause: dmFkZTEDLwpN6MCsEzZDf23pCwJfm4ASTPvcosX8PSzIqJ+BLBExFC3NAqlCMUCIo/T2vV
    oFIZ0kX03cSXCajbgLqpFU/JzbXvAo1U6sJwdsvF0Eh5aFufJfVQCP++gE5pqZnBo0VDWX
    yd/UAUvWUCTH+FBLQxuk8gvbhO98/N7Nzdu6Yvd1M5Qa4mRrW86k0xfp2RVzrSKkoGAdpO
    WhQaqDdWWNW9EXvEV3jFIEtq0Bt/cQNu1+SBcCPFdQYGjlqmgdIUTzQWFjSHjsHv2/Ssy5
    +tfSpsuOvWhlhBPOMf0bPqxanZNX1biqYpQlEFWV6fPQRWs7q8Tu+4nWIaMAMyY8BmqJDb
    EzgdbFU+KcSop/ecVppiEpEXVYXKWxSWHWdAikPQSlfKah4XM/317AX71jDlCS5EYHwp6l
    QLaxlbsKNFe4ULssm/2iltBttJt7oPkpGD7211ekCrp05fGOcMabGoC3fyo9LQ+EFDd74f
    94kolYadzjNgYblqIjCcaI49myKAPftFR5TxjwLnGmGPsKHduCfbiyavIGbwdzWObwius1
    7ExK8fhfXsGwJuzr2GekVTCZatkqrM2jM2zUk7pvqHvUKANlBCiwllHzODDF+uQu7Bx3NV
    VPj5K5WqurJj9/TK2ASj2Uwwqi0aj44AbsyqFjEdB3jthCDQTcvX9A5XzjEw
X-ME-Proxy: <xmx:A_Qvarp1seC48G-VpDQfK5h2LLgXT_oq3oRsEK5gPprUz1B71n4Sow>
    <xmx:A_QvajmEBUVl2DlNssX4whClBuNQrZaJ6WwT8tQacqJ8aZ0X9kB8_w>
    <xmx:A_QvaqjDIaKcDzIV7BBfD9hBiTsJLYDyY_LnjSqxxpGM7uBdp8qjkg>
    <xmx:A_QvajeZzLWY49AFUoqJGtNMVwx-_Nc5OBq5OJQ7Tymkfk5_IlhTtQ>
    <xmx:BPQvan4RU0w0vpdsumX7KmoAeHTTMXXFS5Vl6o3_AhIe86_OgCFnUi6U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 08:45:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 372047be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 12:45:53 +0000 (UTC)
Date: Mon, 15 Jun 2026 14:45:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Pablo Sabater <pabloosabaterr@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5 06/10] reset: introduce ability to skip updating HEAD
Message-ID: <ai_z_vloLEwxxmKg@pks.im>
References: <20260611-b4-pks-history-drop-v5-0-34d35725559c@pks.im>
 <20260611-b4-pks-history-drop-v5-6-34d35725559c@pks.im>
 <xmqq33ytneiu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq33ytneiu.fsf@gitster.g>

On Thu, Jun 11, 2026 at 11:00:25AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Note that in a previous iteration we instead introduced a flag that made
> > callers opt out of updating any references. This was somewhat awkward
> > though because we already have the `UPDATE_ORIG_HEAD` flag, so the
> > result was somewhat inconsistent.
> >
> > Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  builtin/rebase.c | 14 ++++++++++----
> >  reset.c          |  9 +++++++--
> >  reset.h          |  9 ++++++---
> >  sequencer.c      |  4 +++-
> >  4 files changed, 26 insertions(+), 10 deletions(-)
> >
> > diff --git a/reset.c b/reset.c
> > ...
> > @@ -129,7 +133,7 @@ int reset_working_tree(struct repository *r,
> >  		oid = &head_oid;
> >  
> >  	if (refs_only) {
> > -		if (!dry_run)
> > +		if (update_head)
> >  			return update_refs(r, opts, oid, head);
> >  		return 0;
> >  	}
> 
> So when refs_only and update-head are in effect, we will call
> update_refs(), even if dry_run is given.  update_refs() does not
> seem to pay attention to (opts->flags & RESET_WORKING_TREE_DRY_RUN)
> at all, so wouldn't this mean that we would update even in a dry-run
> session?

Ugh, good catch, this is obviously wrong. Will fix.

Patrick
