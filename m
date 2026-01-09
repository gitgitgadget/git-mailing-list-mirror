Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FD3230D1E
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767944252; cv=none; b=c00J7p4jM8LeYhK4o3oUUeOk2IhY3jt9eRJU436QuuKQinE1s3prjm4wfS40oK72dAmJ/HOLyCEasD7tcmBvxDLtwN3wSf6aJETFbN99wfhwwEPtBaZWjJyBT0dRCchOxffola62GShBDaJEiI0/ojQsI/r46q4079ZNQ9NW1ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767944252; c=relaxed/simple;
	bh=qxC0LirTyVXQEBcjQBE4AOGdrYa0qVCVqhgT1iityeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfdKJkrW3gqEnO+VWcSOAqwaDTshUbtXKCTeXt+yD29Bm3rxvgZirRkSfZOynrXFLiV2YBydFQqQdyZxIrQomoPwREppVZdVrKmOQbixHfuQRAgcC+w3D+dp6dbgW4A83MhX2G8SX9iZ8vdW5laOZZqHi8x8PtyD3OviCjsckYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GEjyNaAu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NowZRS/i; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GEjyNaAu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NowZRS/i"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CD67C1400164;
	Fri,  9 Jan 2026 02:37:30 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 09 Jan 2026 02:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767944250;
	 x=1768030650; bh=vb7EyDiFFvmCJgDwF+6X1Az2kjDAdVlPtNDamt4F7fs=; b=
	GEjyNaAuHrnF4DLZmc1cjQwaoFTZcbXRHbX+X/TOa40vQYHB58OQFTlPPYTbeFVI
	zAGh2Fc9wrUgEyCOFKQ8coxN+ggkBHcIG1OhQJlPIVZbKRDqTUlqRHBwMMpC9NfD
	XnMhB4eAHZzRM2eliyuTJRB9OYKd370I8us8r2h9B50HDrPsnNaQuoLxvujy45y1
	zUomox8qj/VCTMj1enTHK09Z8DA3YoEhlweIEd5J/CtXgu6fc4rfRlj/FFLwsHbn
	a0kUGPl5EO6OqxoRLd8K9VxmOMiCmVx4W+B6MOZiqAOIuQ6Mc0aPKPD8x07ymiYV
	bKyIUf/m+S3oV+jMoefduQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767944250; x=
	1768030650; bh=vb7EyDiFFvmCJgDwF+6X1Az2kjDAdVlPtNDamt4F7fs=; b=N
	owZRS/iiMKfQTVdI/4RroLI+TbEvo0S++qCVrPa1/R4hSHvA+3EtDO6w+Nsja0iE
	uEpIeCa6w5CnneGMUYj6AW/z0usHeTCR54TZxe9pNCC8vEfJZMZrIFz4jqTRiFu6
	r/XeDzYoOHkN3e7C/yXGsl3z5qTFTV5G7bkNGbIFGtvcO2mpCcjKcHnQH53xCUqP
	NcJUKx1KtfIi0lP1Y+TgF3hd/28uzPhFliKQ/EktuNbrOkVNxrknetukmq/fLTMn
	Lsls+95XHE6e0fSbQntHohw1G6311mKeLiG08vNF9DCkKGNnrXlNl/ZRSRT4RpVs
	VDY558GNjDLuBMJdW9dKw==
X-ME-Sender: <xms:OrBgaUTEjAYouEFE5TalFJa0OzZ8MG5TKnEAxSDcPhMbGRbtejNV5Q>
    <xme:OrBgadkTJubaMyEbx4pzlfWZWtLJ1GLAsxs6oWs7_Xq7yhXuww-caoNWFiq23dDM1
    sDPPf6vMGJJ57J-8uaeki-1Ff69a2zc4qiy1I5LIhMb3NV4k2H2iw>
X-ME-Received: <xmr:OrBgadOiaHZGD-pjkY8eomU9EMmKpOhf_Y0qktw9uIobRLz1w3E7cnH3k__FqL07RQjpRfNmTCJdBnAp7yHR9dAE6Ne1LmPTnh6RKyLHXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtth
    hopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhg
    rghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrihhlsegsvg
    ihvghrmhgrthhthhhirghsrdguvgdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhm
    rghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:OrBgaRgjCbTUdSRukcGSFjGY9kBbxvPTpYkyL53WLhYDhH1WardsKg>
    <xmx:OrBgabgXFk4pNtU_IKBmscvmi_2YHQMdzjSC6hAcUQkm2ivGgbip1A>
    <xmx:OrBgaQI7VrGlFHXosS3QsSbbDFnpGQ7fniTPr9KrSrmMkHhh0EC2NA>
    <xmx:OrBgaan5K-b310HvbezN2la0ra2eFb6hS2lKSuMWBmzZCExBoDOJxw>
    <xmx:OrBgaYQo5DQjqMKzwGck2J1MYZ7fa77rgAnoR4C0f6tFG9-aaCoqOFP0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 02:37:28 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1139062b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 07:37:27 +0000 (UTC)
Date: Fri, 9 Jan 2026 08:37:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Matthias Beyer <mail@beyermatthias.de>
Subject: Re: [PATCH v8 1/7] builtin/replay: extract core logic to replay
 revisions
Message-ID: <aWCwNZrJl1w-Vibw@pks.im>
References: <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im>
 <20260107-b4-pks-history-builtin-v8-1-18e9779e3a26@pks.im>
 <CALnO6CAMX8K6oNzTmcg_stqkU2FCUepdvNfPTGaA-jSaTMzj0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CAMX8K6oNzTmcg_stqkU2FCUepdvNfPTGaA-jSaTMzj0g@mail.gmail.com>

On Wed, Jan 07, 2026 at 12:53:59PM -0500, D. Ben Knoble wrote:
> On Wed, Jan 7, 2026 at 5:10 AM Patrick Steinhardt <ps@pks.im> wrote:
> 
> > diff --git a/builtin/replay.c b/builtin/replay.c
> > index 1960bbbee8..d7523fdbc2 100644
> > --- a/builtin/replay.c
> > +++ b/builtin/replay.c
> 
> > @@ -517,24 +568,13 @@ int cmd_replay(int argc,
> >                 }
> >         }
> >
> > -       merge_finalize(&merge_opt, &result);
> > -       kh_destroy_oid_map(replayed_commits);
> > -       if (update_refs) {
> > -               strset_clear(update_refs);
> > -               free(update_refs);
> > -       }
> > -       ret = result.clean;
> > -
> >  cleanup:
> >         if (transaction)
> >                 ref_transaction_free(transaction);
> > +       replay_ref_updates_release(&updates);
> >         strbuf_release(&transaction_err);
> >         strbuf_release(&reflog_msg);
> >         release_revisions(&revs);
> > -       free(advance_name);
> >
> > -       /* Return */
> > -       if (ret < 0)
> > -               exit(128);
> > -       return ret ? 0 : 1;
> > +       return ret ? 1 : 0;
> >  }
> 
> I tried checking the tree after applying this patch, too, and it looks
> to me like the return code flipped here? In particular, some callsites
> that assign ret = error(…) are untouched, so I don't think the meaning
> of ret has changed. Now, error() returns -1, which is truthy, so
> returning 1 instead of 0 makes sense here… was this a bug in the
> original? I can't quite tell, but that seems unlikely.
> 
> The original blames to 81613be31e (replay: make it a minimal server
> side command, 2023-11-24), but there it seems like ret is
> "result.clean" (except for some error cases? which are handled by the
> negative conditional), and "result.clean == 0" is the success
> indicator (in other words, _falsey_ means success here).
> 
> So overall this flip _seems_ correct, but it was hard for me to follow
> at a glance. Hm.

I think you're onto something here. The intent seems to be that:

  - We exit with 128 in case there was any generic error.

  - We exit with 1 in case there was a merge conflict.

  - We exit with 0 in case the command was successful.

But the extracted `replay_revisions()` command always returns negative
on error now. I was initially returning that value directly, which has
caused a test failure. I fixed that with the above condition, but I
didn't realize that we explicitly wanted to tell apart those two error
cases.

I'll fix this code and refactor it a bit to make it more explicit,
thanks!

Patrick
