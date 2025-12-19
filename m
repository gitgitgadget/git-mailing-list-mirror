Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8394329C41
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766153389; cv=none; b=VzAKeOpqjiNKTJNuGNzTcvKL09U0e1PMRl4bj2xfh8slrgG2p2A/XXYc7Wl8cgNSkO12q/+QZxRlgsb7NPRDdTDELhmtW46SEU5MxbzybojuU6Bo84KQPbErKxKEJZFr4KNtsJog0qfbRNNr2Bv2o7a81WJvR0fg+adfwsLJk7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766153389; c=relaxed/simple;
	bh=JTW1kZC6fWEWg+16tHtjxLzej+xHzTrTAr9XC6CqBE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVIdIQ8NEeEwGKgiK770R2+l/dpOk0tUOOD8B5bJ3P6KUhQKJ22vP2oR44KGHJ52olNmo2eVJwOIdwVXe0nYWmYJx7ENxPTRFkAtIQVlcaso4hDm5h1WcItur0tbj4wNyFIOPGMguweNGvoZeXITAX1X1/w/j7VryiZRngLoKRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KjlctI5r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LpitkXcs; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KjlctI5r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LpitkXcs"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C726C1400077;
	Fri, 19 Dec 2025 09:09:46 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 19 Dec 2025 09:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766153386;
	 x=1766239786; bh=FdGB9HwXdYeybk9P1TCyKZfdQBwf5hDpIkzVBeK3xbo=; b=
	KjlctI5r+D6pKUANqBLE3CMekgGHF7W10xwDGx4ZPg5pU7BkaaoUGqsaKlT1Ml7i
	INaozfUaJaE6o8nbbCuiCTjeArtqMjuhA0vPicGEhfH1NFH9E7eLZm0QncPGC+5h
	aN024GsuJwal3WIa8A7yuACQiazGDS8FXX5MkApfeAvstTGF0zlqgxqz+DrziRfs
	WQlaFHcvuaNepq1QpB+mFn8vW+ZOmdFe898EEp0YeV8JNzVxjzsgisXPnegBXq5R
	kitAxJW8tZQPtFpKKVqRfUIwU+7QEjFDfuIOwO00HnBNo79gYniItBl0qbFHejB/
	MX4zmTYS+sLipit58U908Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766153386; x=
	1766239786; bh=FdGB9HwXdYeybk9P1TCyKZfdQBwf5hDpIkzVBeK3xbo=; b=L
	pitkXcs/oSvybUybP9rvjeaqKXjsOOrCP95wf0vyxYbXXmZCEV4tvmoqJ8DEFyRE
	C7gPIwUQnFi3W5O+gq9zQeEPfLy3h0q/TIXaBKTLsIB8qaiOpWK4sdtnX32h+lc3
	FvBeVCLqz7ocNikQG1PbeBeXqBqnzZbOl8JMZBCrTbMky6B1ycZad3FdLMe2tEMI
	ibCibLICaQqbmzhFfgg2QBiYYGyD6tOWFi5tR0Cznve6gmsYj0DI5F9S2t1ef8v4
	+hPEuLdsiAkFlhCiR7M1BI2YQ1C4X5lXFb8Kk4q1oHDb3EN6cJ0wd14WzoRVUrSn
	3GVgdz1zUD8Xu/T/gdhCw==
X-ME-Sender: <xms:qlxFaRPwII_TcJUUHzc6UjUckgnBNbXfa5_laWQLY6RqSCtXUFisEQ>
    <xme:qlxFad9nJMkD6447gvX11lApizkTSwOYJmV2k8ogfSAxA-XAutgoLRKM8gnnUGz_F
    qG4iaxQlv6u_Vy5-XwOefITA_vx_Cfw-aIbb7pf30MsiLfosbkctQ>
X-ME-Received: <xmr:qlxFaW4ipaVKBqwKpIB0A12JH0OLkDPESAQQvdGFQDoFE3mmgsmg9gyXKUztBsVjrKVpo_SyN-q_2qPl2XY1A4QyueJP1okgGzusn2npAKf0lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegkeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehmrghilhessggvhigvrhhmrghtthhhihgrshdruggvpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthho
    pehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhope
    hmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qlxFab56XuY_5YCDjoewtv1jsmbyjNimUevMbOoZQwrodfGN9ID20A>
    <xmx:qlxFaXpHbGY-Qull9RZecREVPpkrcGKlDblschjjHns3OFqE2rjgoA>
    <xmx:qlxFaUPrfce3ogtnFCju7a10clDN7wI8xxXj28LLTTsEucbpHiYYfw>
    <xmx:qlxFaX0y3ZTPIG8juU8FhK1QkaHEpUeVgBsvpOkDfhz4fPrKzb2hfg>
    <xmx:qlxFaaoLBrFIX0l2k9CqI3wlf3iOFoTbVexGLn2Dvbud4H3nh4jk5bNt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Dec 2025 09:09:44 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d0cd6689 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Dec 2025 14:09:43 +0000 (UTC)
Date: Fri, 19 Dec 2025 15:09:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Matthias Beyer <mail@beyermatthias.de>, phillip.wood@dunelm.org.uk,
	Martin von Zweigbergk <martinvonz@gmail.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
Message-ID: <aUVcowmpU7VMLpE4@pks.im>
References: <CANiSa6gXbrZaMLVq-AAg38sm+7qgzn4w98WWowLtUHA2P+BdLw@mail.gmail.com>
 <aKs3tqjE510MF0T-@pks.im>
 <aMsWL2cSoytbmRjA@szeder.dev>
 <4m6rmefbv4hftclimitz5rp6yapswjtnjsxymrsdkuan4jbg3u@dm5jzdiq5cxz>
 <bc01706e-b9cc-4cd4-953a-971a3ccd6c79@gmail.com>
 <paqf2ko6kcm5qdcqxqz57qu6gjw3vf6boabjsryeugfnlzzb7z@4dzqo6jug6l2>
 <a6efc710-4062-4955-8fe8-bb6d428a44c1@gmail.com>
 <xmqqms3qh13e.fsf@gitster.g>
 <aUVDax0PbkaXGB61@pks.im>
 <aUVaEPGoOkATQGl3@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aUVaEPGoOkATQGl3@szeder.dev>

On Fri, Dec 19, 2025 at 02:58:40PM +0100, SZEDER Gábor wrote:
> On Fri, Dec 19, 2025 at 01:22:03PM +0100, Patrick Steinhardt wrote:
> > On Wed, Dec 10, 2025 at 11:18:29PM +0900, Junio C Hamano wrote:
> > > Phillip Wood <phillip.wood123@gmail.com> writes:
> > > 
> > > >> Its mostly because I don't like too much magic and because I think being
> > > >> explicit is always better than not.
> > > >> 
> > > >> So from my POV, I would expect "the simple case" to be "the simple CLI
> > > >> call" and if I want the tool to do magic and "rewrite all the
> > > >> things"^tm, that I would need to specify a flag for that.
> > > >
> > > > Thanks, that's useful to know. I'd assumed rewriting all the branches 
> > > > descended from the rewritten commit was the natural thing do do but 
> > > > clearly not everyone thinks it is.
> > > 
> > > It probably depends on the way one looks at the tool, as a building
> > > block (in which case less magic may be preferrable) or a complete
> > > solution for one part of workflow.  I probably fall into former camp
> > > more often than other people, but for this particular one, I tend to
> > > think it is less confusing if we moved all branch refs away from the
> > > commits that are obsoleted by rewriting/replaying.
> > 
> > Okay, so the majority of folks here seem to favor rewriting all
> > dependent branches, which is also the default that JJ uses here, and
> > git-replay(1) does it, too.
> 
> I can't find the word "conflict" in this subthread, so let me bring
> back that little history snippet from around the beginning of the
> subthread:
> 
>   Let's suppose I have this piece of history, I'm on 'branch2', and I
>   drop commit B.  Which commits will be rewritten and which branches
>   will be repointed?
>   
>      A---B---C---D   branch1
>               \   \
>                \   E---F   branch2
>                 \       \
>                  \       G---H---I   branch3
>                   \
>                    J---K---L   branch4
> 
> If we were to rewrite all dependent branches after dropping commit B,
> then besides 'branch2' we would rewrite 'branch1', 'branch3' and
> 'branch4' as well, right?
> 
> Now, let's suppose that dropping B would cause conflicts when
> rewriting commits G, H, I, J, K and L.
> 
> When does the user have to resolve these conflicts?

In the current proposed subcommands there cannot be any conflicts, as
both reword and split do not change the resulting trees.

> If not right now, then how exactly will those dependent branches be
> rewritten?  (I understand jj can store conflicts and they can be
> resolved later...  But are we there yet?)

No, we aren't. I think Elijah wants to work on that, and I agree that
for a subset of commands it might be a required feature.

> > the set of branches that we'd need to rewrite is any one
> > branch that points into that range. It keeps the UI simple as the user
> > still only has to think about a singular commit, should be sufficiently
> > fast to compute in most cases, and it allows mega-merge workflows like
> > JJ supports.
> > 
> > Does that make sense to everyone? If so, I'll revise my stance and will
> > adapt the current implementation to do exactly that.
> 
> I would very much prefer that the tool would only rewrite branches
> that I explicitly allowed to be rewritten, with an '--all' option that
> would allow the rewrite of all dependent branches.
> 
> Or at the very least there must be an escape hatch.

I agree a 100% about there being an escape hatch. You really don't want
to rewrite dependent branches in all cases. I'll include an option that
allows users to pick what to either:

  - Rewrite all dependent branches.

  - Rewrite only the currently checked-out branch or reference.

  - Only give us what _would_ happen, so basically git-replay(1)'s
    "--ref-action=print" mode.

Thanks!

Patrick
