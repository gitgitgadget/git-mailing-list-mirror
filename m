Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76201DEFE7
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 07:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741851983; cv=none; b=cFrgPDp90pyYNoEftA491ZLfjTEOAuKnIIXh0UI08qw8qPpgtf5ficu+9MMo8UyTrWp2FmD7q36TDsgFduXogy9NxS2bi3rvVaj3RdQrvyqoMgLKmQvaF8TRQFjNego1YupA5h/WW+7gYGDYov0+5VQrYNCJj6DxXD7qsRgGF6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741851983; c=relaxed/simple;
	bh=TEUN81iKJIOo8ee3lE5FBRXZkneDB427pg3X8i76zhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHb7LrZZqgRDyk/IcbiAeJ4vQuEEzdvcob5p4VfSoijeeO0cKONa/pYth5K8XmIhB8sZfZ+HMmstMlM34XxrkhO7VSGeaRrgJ411x0AH2ifcI62Fumk+LQSxbIVZJjzGclOssBWqRSQowC+jFpXhW3rTO5L8A+FxeifjIfRrLZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XoGbS/cb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JMtFjOTC; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XoGbS/cb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JMtFjOTC"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C43351382D86;
	Thu, 13 Mar 2025 03:46:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 13 Mar 2025 03:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741851979; x=1741938379; bh=pbxZIYNNiw
	p7bDZszVaf4S92WHN9Mazrw8bTLtYHtpM=; b=XoGbS/cbttAshPuEenQZA3/yBo
	dazCLXe2iQYkVDcRzMjun1ntVhSc6yyq0SbMlt2Oe1/XPrdYBAfhKaTTK2tmsVsG
	yrvq7L3L+EMZv6KU+1tyOTdW28zZUUQYJMnf7JWVH52eqMsJuHjB1ul0HtL/2u62
	O4OhVW27a1e5OAsIJF/EOiGCzeOs+uas2fIDaYoLApJ+/ahPJ028CIFDokLycqxt
	sguJ488CuAFzY12p6hng6blrR1JvVPKUllu+EGYzqBXhubVH8E8jcZRNBoN5hF5f
	9JklsvTYtnhZKR/UQ8m8LcyjcNPnwuaVNmHfoc+8zIs/oleyNDHlrHJJ5FOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741851979; x=1741938379; bh=pbxZIYNNiwp7bDZszVaf4S92WHN9Mazrw8b
	TLtYHtpM=; b=JMtFjOTCWj1ExulAzpfXCZOUWrlGYFPQGRov0CEsXYiVcMGrnxm
	3BVNjvDruoFaO1CKQyucNg6GK0oV0FbFmFOih9NpGMF5aAzxni8myVQnSHSlI9cG
	wvX3sBCEkh9qY2QWUaZtddLz5T82bkLPGj/SiEN7QA47WzkKnHMnhH54DzFNMD7C
	vdlVJVYs5cMlpbXwHpZlnKRMZvcyJPWp9/0+j/BVgZ5LwXPv8zxTBHveQM01ou+5
	C5XK8BsRoaYAWS6vh+Ep+rNN1s83qbo7BufNEBl9IiCm93t5cd56S33SgyVW2e68
	N9D8FsrtMSXQKHQPfCzhpyUszp7KoweT//A==
X-ME-Sender: <xms:S43SZ0eAHuBjhVe1CPn-rK3LHKtg66KB4unMxOWp29Lh2BRmB57Avw>
    <xme:S43SZ2OEpu_vY0r7i4CzF4ej4nDHWqeZ7z9LO1j8H9FvaNf4HYRX0XpI6NYM0Irkp
    pf1IuAYLUkMhyRixQ>
X-ME-Received: <xmr:S43SZ1ioe4EdWmY21wBtPNt2P3e0mANya0ejkqLpa9OxwcC05v5yBrQh0rb2wCOj2jewN8-B20YzA-Fcusq-mL95cGNYngFCTWvc6CSNiMGOpSHmXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdejfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhlthhosghlvghr
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:S43SZ58p6QCSvTNmID3NoYeNJ-G5djUEenerz6vQBrAZ9EuGaxdoQQ>
    <xmx:S43SZwtXg1ubs3DnSDo8SydDUAmVZkET8SC2Bnh33mzJIsBI2GAaIQ>
    <xmx:S43SZwGOKkCswss-kvYcm34D1I81AfsQfxOod_eXgXeIBdxErVXR-w>
    <xmx:S43SZ_PtPMc_OS1N-XUh41ch34uQLnFlJZAB6gDzu5s79vzbRqPgRA>
    <xmx:S43SZ6WY0XrqeZK9bqMU9kzmWvFuC41KKHH6Oqt-LP5PbzS9MNM9FGwU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 03:46:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e7bfb8fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Mar 2025 07:46:15 +0000 (UTC)
Date: Thu, 13 Mar 2025 08:46:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Justin Tobler <jltobler@gmail.com>,
	git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH 0/4] rev-list: introduce NUL-delimited output mode
Message-ID: <Z9KNQ8XliWrrYgAT@pks.im>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <20250311235720.GA73755@coredump.intra.peff.net>
 <Z9E60LG6ExSJzmuo@pks.im>
 <xmqqfrji1bvy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrji1bvy.fsf@gitster.g>

On Wed, Mar 12, 2025 at 08:56:01AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Tue, Mar 11, 2025 at 07:57:20PM -0400, Jeff King wrote:
> >> On Mon, Mar 10, 2025 at 02:28:25PM -0500, Justin Tobler wrote:
> >> 
> >> > To make machine parsing easier, this series introduces a NUL-delimited
> >> > output mode for git-rev-list(1) via a `-z` option following a suggestion
> >> > from Junio in a previous thread[1]. In this mode, instead of LF, each
> >> > object is delimited with two NUL bytes and any object metadata is
> >> > separated with a single NUL byte. Examples:
> >> > 
> >> >         <oid> NUL NUL
> >> >         <oid> [NUL <path>] NUL NUL
> >> >         ?<oid> [NUL <token>=<value>]... NUL NUL
> >> > 
> >> > In this mode, path and value info are printed as-is without any special
> >> > encoding or truncation.
> >> 
> >> I think this is a good direction, but I have two compatibility
> >> questions:
> >> 
> >>   1. What should "git rev-list -z --stdin" do? In most other programs
> >>      with a "-z" option it affects both input and output. I don't
> >>      particularly care about this case myself, but it will be hard to
> >>      change later. So we probably want to decide now.
> >
> > I would lean into the direction of making "-z" change the format both
> > for stdin and stdout. That's what we do in most cases, and in those
> > cases where we didn't we came to regret it (git-cat-file(1)).
> 
> I've seen "-Z", in addition to "-z", used to differentiate between
> input and output in some commands.  If we are not going to do that,
> I agree that making "-z" to affect both input and output is less
> surprising than having to remember which side is still text.

Yeah, "-Z" is what I meant with git-cat-file(1) above. I just think it's
safer to always use NUL as delimiter in machine parsing -- and while one
often thinks initially that it may not be needed either in stdin or
stdout, my learning is that eventually you always find an edge case
where you do need NUL termination in both. So I'd rather want to push
application developers into the right direction and make "-z" adjust
both streams.

Patrick
