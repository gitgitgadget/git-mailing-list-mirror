Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDCF2D594F
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608861; cv=none; b=D7oCBfMSg1HbdxVd7+xjCurPTrrGqsGQgwEI0p9ipctUxd7UGldi9ETk/ikD5MM5DuZvsXmNpr6fVgHU8rUUglRjwnO+Qix8oNswD7mDzMXQGq3X5J5GTgo2jE4gKKlIvdBqawPHBYAwCpEPhwl3iRpwydMBuEh8FcNAOqVznSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608861; c=relaxed/simple;
	bh=e3PfZDmXTKVOWB9zyokJCOZqD6AD6lpXv/Sole2AYeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuR7p4OM8Myyd8slK3tuCBw2TcWFikGLvaVWMyP9W/nRILGcrk5kq0N7NDZlhZGUwK1COIucNzvnp39T84LqIvKzcTfjaHB7KKCo3dAsMJIz6xwOCv7xbWbnzgrXPPvkqs35MySe9yZ1bp8Uh+LOPZZFufMRkvGm5pEJqi6mpfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FBw8KiT7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lygsaObT; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FBw8KiT7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lygsaObT"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 395E07A00D7;
	Thu,  9 Jul 2026 10:54:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 09 Jul 2026 10:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783608859; x=1783695259; bh=ie4+ZUps1Z
	VCCWs9JrQ7CnO1HaJvrXKX9+9k7aTtvVY=; b=FBw8KiT7ev7hXgRrtCIAV52JTq
	K5gaoydFEfi91SG3HrowYOz4U+oZyHd182U9sBkLbluIOouXjEUpjsTrBG7y63Lm
	Dwv6i8NyAPaYY0D80CncQ9jBSCae+a72p0aYK57CrPCsH3Sao+xiz7jTPhmIwUbv
	dL7mmYNOmTz3rZwTPpArWq33jPpx/sPMJGNfjN+eeM+Mo9YbgCGUFNbuUVYrVSn5
	ZlZ7/TU2rntCe++RSrUEg4j54A+QC8hu6UyIHkXLcOpjXbpWdh1ZW+jTX824Umr2
	LtmLn/MiF3t1OQdsWYy4D05D/w5fe9Rd/cM9QyDQ5piHr8TaUlZ7iIIvcBCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783608859; x=1783695259; bh=ie4+ZUps1ZVCCWs9JrQ7CnO1HaJvrXKX9+9
	k7aTtvVY=; b=lygsaObTBJzLQ8Eqzg1bQTyyfDEN91K8eiPxhqterjzNhmkCKZS
	BoCdFFh/mmhXpnZ1lv4lPtk2MqDcMKy9l4EbzvjMT7kO54OFQrKgPhom/R2TL7fQ
	coyDCSu+US2qjD7anZ7UJYRI/sR5cxbo0Oa7F4zTsETXHndXLEktgbhbl/7bQ2GG
	IocR0vkWXu5i7S0KTX9s5mcsBswv0zd7Ll95s8jsVG4EQy+3YuofVIdfGji8qn03
	Q4bp8b2y4KhqvNQ7WvvCVzCdE755sVrDkAUBbqEszgzZf8LAO1tMCHq9teIqNJN4
	/DUl+b4ewBeYnvVTQjwBhljqGXGd5WgVRtA==
X-ME-Sender: <xms:GrZPagVAivHAF2w0RQRXInkFu-NV3gS-eM3foHP8AsgZAKOLEaDpEA>
    <xme:GrZPasC3zxkLqJETgVRtt3ueArZagnYDh5fHNDSv7VvCnRxv8CHejHxytyFz2o-o7
    26wULnE_rzBV9-z0Kl6-BA2DdIQG09bGlZfuOevSgKlART3KU1c2w>
X-ME-Received: <xmr:GrZPahzFBba2ISN__ZjefwBmmnpbHp3weuZZXs6wEdgMx6n-Q_WBgzHHXbe3JQL656Iqxl85DQcfdWtqfH-BtDSj1gTIAaug3aW3Kw8XmQ>
X-ME-Proxy-Cause: dmFkZTGZWFRq+tWT8yZyHqwwQKOnucCl6iKIMkYqt+seP/hVNdAPejXHHVJM9CmJieibpX
    QKjN3+azJsxbZag9MjRAOqS5P4vyVZca0muK/e8j84st3WB2MMPWoW/n46GwAWAWe+3DN5
    f85Eqj9dSkix27Tr3ajxQFOy/5eNLPUK5EoDtXQq2wTWPm9kTjJ1W8C0ncq/ttp8QB6cuB
    /6SaWjPrChNWNqDDMLN2ddGCErI7rN0Cu74OsMxXUb91T1S1OPF9vUFouNKq67uPTPEnKP
    nKKcddJVgIlP4G+w4ElrYwJqjBMqaR9Zw3UJF2yfC/V7KT75+LQ3xvGOtaIm5w4iOBECNP
    0C7QlnMHgaMXKPjc5lZOrmcD17NQLzuSAD94q+VRUDGsYt2EcRtCCq7FXZZuk8b9A+VewT
    3fzunGUIiCO/8n0SiEIQkh9keSaJtOgTzw5uLYNsa0CnS0cFKHw9kPhXXQOEta0mJwHdGj
    dvC+gakDPZLzIhTZymRRoRHfnmAhyY38j6CvPVRe0NpRBcCGKQpTh99SgxPK/4LtUrzeVv
    Zy/h5VgoFscZcsoUZRDEKzJh9lZkdC+mphKiuX68FGI6Sq+4V9yyYxktkJjbgWrKewSU7a
    l8vhI1sFV33RmiYehqh8LBew1Biw5prRN+oLDKNTCMoQ5yiEdjSOV2Ls7+uA
X-ME-Proxy: <xmx:GrZPapCYJpbA4dh4hdB0_z0AmIOQt6Sofy-G4LY_XYO-HRCtsPlZnw>
    <xmx:GrZPaubQoYoFRoPJom1YNKibxDuzIbKv5dmOJoxnnH2IlKNiHUSolA>
    <xmx:GrZPahgXLnteIGlrpZNdo650BHxXRGBrjrY3fjvh1PWlcMlAeoI-Xw>
    <xmx:GrZPag5vUmM1Sa8X2fkbJMgwtrfTxkXaiIiYCnu20LHuq0_ORz1FYA>
    <xmx:G7ZPapQEPjeiYVd7CIhcTuux4MwgJI972MFp4HrGqbSJSDL52CYmGwlh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 10:54:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c20feedd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Jul 2026 14:54:15 +0000 (UTC)
Date: Thu, 9 Jul 2026 16:54:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] reftable: fix quadratic behavior in the presence
 of tombstones
Message-ID: <ak-2EHY6YlFkW9p6@pks.im>
References: <pull.2166.git.1783344957.gitgitgadget@gmail.com>
 <pull.2166.v2.git.1783598912.gitgitgadget@gmail.com>
 <c13f15ddc20f721443fa1d462ea1b7c2356fbffc.1783598912.git.gitgitgadget@gmail.com>
 <ak-n6K4heV2kHviZ@pks.im>
 <CAL71e4PrtZwB8TMg3eBj=LzC7ik+C8yxLYEEEP7SDgMPiWSs0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL71e4PrtZwB8TMg3eBj=LzC7ik+C8yxLYEEEP7SDgMPiWSs0Q@mail.gmail.com>

On Thu, Jul 09, 2026 at 04:48:43PM +0200, Kristofer Karlsson wrote:
> On Thu, 9 Jul 2026 at 15:53, Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Thu, Jul 09, 2026 at 12:08:31PM +0000, Kristofer Karlsson via GitGitGadget wrote:
> > > diff --git a/reftable/stack.c b/reftable/stack.c
> > > index ab12926708..fd7d8f3f1e 100644
> > > --- a/reftable/stack.c
> > > +++ b/reftable/stack.c
> > > @@ -337,7 +337,6 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
> > >       /* Update the stack to point to the new tables. */
> > >       if (st->merged)
> > >               reftable_merged_table_free(st->merged);
> > > -     new_merged->suppress_deletions = 1;
> > >       st->merged = new_merged;
> > >
> > >       if (st->tables)
> >
> > Okay, we still retain the field after this patch. But the question is:
> > how would libgit2 now set it? I think we should rather extend the
> > `struct reftable_stack_options` so that the caller can control whether
> > or not to suppress deletions at stack creation time.
> 
> You are right, I (still) missed the compatibility problem here.
> 
> I started thinking about a way to make it fully backwards compatible,
> but then I looked at the libgit2 repo and realized it will need
> updating anyway since it predates the reftable_stack_options split.

Yeah, that's something I'll handle soon(ish).

> I will add suppress_deletions to reftable_stack_options as you
> suggested.

Thanks!

Patrick
