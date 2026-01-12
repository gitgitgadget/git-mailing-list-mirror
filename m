Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B383587B2
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222941; cv=none; b=i394E+cN5HjIN5ZVWdYUzhbJyWCn/ds1qHBpz5ksv3PuofIPE7CB58dyNRSIWMz7+HKI9fN04rX1KYE19dDhIEaw90oAteIw5tussEBQXdEiOyO7pa0UeI88KYf/0iRB+cdu1ZOO9A7TIWsbeuTU+3L3PDh5xAfj9Cpc5fwuziU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222941; c=relaxed/simple;
	bh=zSsR2EYJm7+oQjVYhVnH1Q1SBttsAIyXYCJuKnDNVNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hif49Q0wVQ4yIfrzDh8mOh0v+9jgWOQGqDe++byZRlR6G5VrphFYBjgDWq4XVsaqh7BbXilcdr+kHbdemEuiYkAinzfdLh1ExgxDZSXS/ukXPbyEEG/X5AkMMq/7c9Z0cK0tGj4A/rbVt6mo3EZoL4o/vY5/x9l/gGov0iKApFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZgcTrojo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kI1e22dp; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZgcTrojo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kI1e22dp"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 83274EC0226;
	Mon, 12 Jan 2026 08:02:14 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 12 Jan 2026 08:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768222934;
	 x=1768309334; bh=cZEhidk//K128qe51uKjoBuBW5xxkxXf/0u5MSWN7ZU=; b=
	ZgcTrojog3MmYanypt94h8HmlsY0N+CzWPffpGl6u49digor1Dtv7Hf6zqcxg0cv
	GNWVV3am+ZGIGQh4Yl8WiuaCOHXeZVJoz2YTHP9+IG83BxBoh9y3Z89kG3WKPSLC
	sx+pfntkI5/bYX6qPrqXNZqrzCKO09nIbXMLnNRHZxI+8NagqznVRLVqP65f4iCB
	plFfUHr2LZ1K0a/0oR0w6i3jLiZQnfC9WsJHfSMZspADSS0XoAgNZlHlc2u/GoD/
	sdKsRjyDLjuo00+E18CoCZkcEdK5c0CBlkFrVoajNka9+1PB6vC+5BuxHTZbRY8T
	snc/i79j1LzDPJWJJm+LZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768222934; x=
	1768309334; bh=cZEhidk//K128qe51uKjoBuBW5xxkxXf/0u5MSWN7ZU=; b=k
	I1e22dphEOSh9tnRVh9kHHVldqMHZ8WNSIq8pV1k30k70+QrqDFv0OC+dOf+bVFt
	x4mB+cPTQ0yPsTkkm7o/tr1KCZfKqOzm4FK0HlZTyJjmpbNb05Uqjw8Oc/DCS0xs
	+G5xb8T4Qingt23RYtDRAVDBbZtcW+9SjLuw8Nt0EqOBuVGamZaIwtUcGFhrtm6X
	GUWbXuDaFR5HLYsAtbWtPCZ5aZqUzvo7noeP3qaAHfinGtcav/weh+xougQehenj
	b1iahr6Rbr2KI3/hN6RVog/Kd/bvZEV2jAyCyO1RrQ8O2YNmYsKq+qdZV2UF52F8
	+6lxLkt/+wA/SlJx2vz0Q==
X-ME-Sender: <xms:1vBkaUud8Tr9MTyL1eh6g627otdnhY1YXpKCyb0nxo_hzXaKjD51Sw>
    <xme:1vBkaV2Upv9woJt_AGK96FjYH2EV7HTjiONs02VynEdKPjhWvNmbaGSsX3L9guaJF
    98uFysbakdgk5sZd_D4nyhA_4eNOjQJPPWIlLddkUCy5r8ir00qUKk>
X-ME-Received: <xmr:1vBkadr2oiEEeFKLrCH0prs1znqjRtJXkVm_QO3Dfb6R9zyuSusMRuU1w4rgiETJQBwtkLufnPNQBCSkbFiS4CeJFOv-h2fy-1NuCf2URg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeortddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeduteehffeguedtfeevgfethefhgeevfffftdevieffjeelueetkeetueejgeekveen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpth
    htohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsg
    gvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdr
    fihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvh
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:1vBkaVKNrZ_PdwtiuG3DuRtEmTXM9NDVy9EQh1-92TbwUNj1L096xQ>
    <xmx:1vBkaZSpc3g47HHcihhRwtptzEiKvgAyaKcbcP8bhE5zSszDVkJ-jQ>
    <xmx:1vBkadM5o6nzhDy_Dfdq0NShihvqfXmmNA7tgw2xj31AqNZaSDsmMw>
    <xmx:1vBkaWWvYXur5U968DCB1EnW39hwJArb76HaH0HN7608dLFlWv5Qaw>
    <xmx:1vBkacg9LIrwLWEzhoVzYW5_m6yAx1rPOHkT0cVuBarwrL6aOdHafhjt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 08:02:12 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 59c49158 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 13:02:09 +0000 (UTC)
Date: Mon, 12 Jan 2026 14:02:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Matthias Beyer <mail@beyermatthias.de>
Subject: Re: [PATCH v9 1/7] builtin/replay: extract core logic to replay
 revisions
Message-ID: <aWTwyiNuiybFIFAW@pks.im>
References: <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im>
 <20260109-b4-pks-history-builtin-v9-1-8766101814c6@pks.im>
 <CABPp-BFmQHjyeT0pXYV5eE5cnG5H6XXHeT_RsjWxq83ck3781w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BFmQHjyeT0pXYV5eE5cnG5H6XXHeT_RsjWxq83ck3781w@mail.gmail.com>

On Fri, Jan 09, 2026 at 05:14:48PM -0800, Elijah Newren wrote:
> On Fri, Jan 9, 2026 at 12:35 AM Patrick Steinhardt <ps@pks.im> wrote:
> > diff --git a/builtin/replay.c b/builtin/replay.c
> > index 1960bbbee8..df3b32a52d 100644
> > --- a/builtin/replay.c
> > +++ b/builtin/replay.c
> > @@ -278,6 +278,137 @@ static enum ref_action_mode get_ref_action_mode(struct repository *repo, const c
> >         return REF_ACTION_UPDATE;
> >  }
> >
> > +struct replay_revisions_options {
> > +       const char *advance;
> > +       const char *onto;
> > +       int contained;
> > +};
> > +
> > +struct replay_result {
> > +       struct replay_ref_update {
> > +               char *refname;
> > +               struct object_id old_oid;
> > +               struct object_id new_oid;
> > +       } *updates;
> > +       size_t updates_nr, updates_alloc;
> > +
> > +       bool merge_conflict;
> > +};
> > +
> > +static void replay_result_release(struct replay_result *result)
> > +{
> > +       for (size_t i = 0; i < result->updates_nr; i++)
> > +               free(result->updates[i].refname);
> > +       free(result->updates);
> > +}
> > +
> > +static void replay_result_queue_update(struct replay_result *result,
> > +                                      const char *refname,
> > +                                      const struct object_id *old_oid,
> > +                                      const struct object_id *new_oid)
> > +{
> > +       ALLOC_GROW(result->updates, result->updates_nr + 1, result->updates_alloc);
> > +       result->updates[result->updates_nr].refname = xstrdup(refname);
> > +       result->updates[result->updates_nr].old_oid = *old_oid;
> > +       result->updates[result->updates_nr].new_oid = *new_oid;
> > +       result->updates_nr++;
> > +}
> > +
> > +static int replay_revisions(struct repository *repo, struct rev_info *revs,
> > +                           struct replay_revisions_options *opts,
> > +                           struct replay_result *out)
> 
> Why have both repo & revs?  Can't we get repo from revs->repo?

True indeed, will change.

> > @@ -517,24 +578,19 @@ int cmd_replay(int argc,
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
> > +       replay_result_release(&result);
> >         strbuf_release(&transaction_err);
> >         strbuf_release(&reflog_msg);
> >         release_revisions(&revs);
> > -       free(advance_name);
> >
> > -       /* Return */
> > -       if (ret < 0)
> > -               exit(128);
> > -       return ret ? 0 : 1;
> > +       if (ret) {
> > +               if (result.merge_conflict)
> > +                       return 1;
> 
> This feels like a rather Rube-Goldberg way to get this.  Above where I
> highlighted where you set ret to -1 incorrectly, can we just set it to
> 1 there and then lose all this special logic in favor of "return ret;"
> here?  Or am I overlooking something?

You're not really overlooking anything, no. The reason I did it this way
here is to make the logic more explicit -- a simple return value is very
fragile, and I broke this in v8 of this patch series already.

Furthermore, this is preparing for us to move this code into a separate
library. Not all callers may want to handle conflicts the exact same, so
I think it's sensible to explicitly tell the caller about such error
cases. One way to do this is to use e.g. an enum to surface the info,
but that is somewhat limiting. We may for example tell the caller later
on what the conflicting commit was, and that's becoming way easier by
having the info in `sturct replay_result`.

Patrick
