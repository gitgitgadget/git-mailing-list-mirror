Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8534421B9F8
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 08:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003516; cv=none; b=NNtZ9jExWO9oJRPcbEn9/8N/BO9qEJzBdnwXmsOUuo2Bl6GGvuTxvBEbGgACNpUcs4eeJfPK3nH0Eq9UBTsuHzebcTO/yQjy86YNXBrzP/kIPztfBL1X6IoBflHOc5E20Waw2djnrqteKERfRy7j0LnZGm0U3juTWv9oxCg6dTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003516; c=relaxed/simple;
	bh=GeXeSjOeL+14V4r/tFvsYNC2W4BO9ZTjzxC41jdC4jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnAxi0xH4p/adxaxJEZed90HmHGANbRpvccNpZDs1a73NVuVdNSQDDh2A3uNRWtOtgRQxSm5a7nU8H/3VLiupTmuB6q8UT4yTLNm8KOoHBLLOtsAcdl4o26MmakhX3Ipj95L9r42/rtlR0o6SK2+/EnWyX41K2kTunefuht+0as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wqfhDOIG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ei9rcoGu; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wqfhDOIG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ei9rcoGu"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6A90625401E1;
	Wed, 30 Apr 2025 04:58:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 30 Apr 2025 04:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746003512; x=1746089912; bh=rbZZh0ie4/
	mKsR1rMKavpa8yclv6rZ/1itswYwG6dWo=; b=wqfhDOIGN8640edMX55i86CAfM
	vbaT2ck96eRnaehnkJCh89B6vJrmONKfXSLwr4UyPNoyvdShiYJgpWhUFicm4X1V
	49mXdowSEO5Dn5rVXlLP0M52AFZnYMPAYbOtiTVu8JpkUTr0ts5sdrBdJVTj53DZ
	V/IT3k8pS7XGpXAyqr6P4Ey3yVmzxPRe18tUqlm1rBt9HMkcJGbLOjiyeJsNusyc
	vTnCMFmkbx8rYUuHTeOZ6Nhnq/kNcTma1eJfIIwUtFhqqxPBnaZJzfft/mmKhKU0
	OZtOLclrPMakvx4Vx/B+KlMLPoucAQPRgskRwdHpqeSRVkgypvRIWH5wOLhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746003512; x=1746089912; bh=rbZZh0ie4/mKsR1rMKavpa8yclv6rZ/1its
	wYwG6dWo=; b=ei9rcoGuVuaD9vSEJ/0HdyIOFhFMGSISiKtO+E4lOup5sMbpnPn
	JuFgIeSfiUJCbFYimWb1tQ0BvJ54OQGrVGwsYV+cQiQ4bPLaWt++mNpapddIRZZ0
	KMPAOO67II3GAvyr+G2fWMDS8NgwrPIn/NpfChPBJaHXPyBYsWq3eWQOwyoW6J40
	WPcX7TXRuNfrGF9/US2eoy4QdlgkGxB5oJNb6PuibSqEqEdsx7ycSzgBzIvYNhcu
	S8t7MDmvsxWkIYh/pQDFeFEezG9Oi00fnNZNi8B8PLDX/kS1/CX+GBNEa6TD529c
	ojJutslkYzvikCmywz8BzZH4e8o0W8iWeEA==
X-ME-Sender: <xms:OOYRaLY_zpAWspnQ-LZqYpiS678ZKS1hm8D7tiPajbBADdn4Ua4_8Q>
    <xme:OOYRaKbAzMyjAZbQfPAGhz5da4vhgjRBuXOavMK-laMWSW5JJ3VHQ1K-z91wrZ8uv
    c8XUJQlFO1wxBF4DA>
X-ME-Received: <xmr:OOYRaN-Cq6ygRe3VWF2MNow4QUV-ccxDdgAVRTnd3GIjS-yWKW400vshKiZgXua04maKNXTcQ10KcsM8N3i2fajyHBFyzt9kB3NWAg_YQdZRyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeivdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:OOYRaBp_Eunv5vWFh3VqBRLgJiyIa737cPE25TBgkivmrKkBxn01_A>
    <xmx:OOYRaGo-Tc9HQUPTpO7T4OFCxhD9vZsLaIm3Gqu7ZoPcwOYp_koNUw>
    <xmx:OOYRaHRrlaC98T-ok2G-yF9nEqitbMJGFhjRK6Z3hde0qHhBkky0UQ>
    <xmx:OOYRaOqJtrdaZq0gFBCHl4VxWlRBwFZDW8fQleOWdX5focS-C-xb8Q>
    <xmx:OOYRaIXG0Bf3HaFXxkFwYZ4mlwLLsx_dINffTnZ1LwYhkMxCwkrMOaev>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 04:58:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 566d6809 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 30 Apr 2025 08:58:29 +0000 (UTC)
Date: Wed, 30 Apr 2025 10:58:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(win+Meson): build in Release mode, avoiding t7001-mv
 hangs
Message-ID: <aBHmMKqhVDEl777o@pks.im>
References: <pull.1908.git.1745593515875.gitgitgadget@gmail.com>
 <xmqqmsc4uv6d.fsf@gitster.g>
 <aA8ymUzWM2t0QkFP@pks.im>
 <xmqq8qnkdxu9.fsf@gitster.g>
 <aBDD-NeN2YoQbU9S@pks.im>
 <xmqqplgu4ru5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqplgu4ru5.fsf@gitster.g>

On Tue, Apr 29, 2025 at 01:48:18PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > @@ -213,6 +228,8 @@ int cmd_mv(int argc,
> >  	struct cache_entry *ce;
> >  	struct string_list only_match_skip_worktree = STRING_LIST_INIT_DUP;
> >  	struct string_list dirty_paths = STRING_LIST_INIT_DUP;
> > +	struct hashmap moved_dirs = HASHMAP_INIT(pathmap_cmp, NULL);
> > +	struct strbuf pathbuf = STRBUF_INIT;
> >  	int ret;
> >  
> >  	git_config(git_default_config, NULL);
> > @@ -331,11 +348,17 @@ int cmd_mv(int argc,
> >  
> >  dir_check:
> >  		if (S_ISDIR(st.st_mode)) {
> > +			struct pathmap_entry *entry;
> >  			char *dst_with_slash;
> >  			size_t dst_with_slash_len;
> >  			int j, n;
> >  			int first = index_name_pos(the_repository->index, src, length), last;
> >  
> > +			entry = xmalloc(sizeof(*entry));
> > +			entry->path = src;
> > +			hashmap_entry_init(&entry->ent, fspathhash(src));
> > +			hashmap_add(&moved_dirs, &entry->ent);
> > +
> 
> OK, this collects in moved_dirs the directories that will get moved.
> And then a separate loop, ...
> 
> > +	for (i = 0; i < argc; i++) {
> > +		const char *slash_pos;
> > +
> > +		strbuf_addstr(&pathbuf, sources.v[i]);
> 
> Shouldn't there be a call to strbuf_reset(&pathbuf) before doing
> this?

Yup, indeed.

> > +		slash_pos = strrchr(pathbuf.buf, '/');
> 
> And start from the deepest directory, going one level up per
> iteration, ...
> 
> > +		while (slash_pos > pathbuf.buf) {
> > +			struct pathmap_entry needle;
> > +
> > +			strbuf_setlen(&pathbuf, slash_pos - pathbuf.buf);
> > +
> > +			needle.path = pathbuf.buf;
> > +			hashmap_entry_init(&needle.ent, fspathhash(pathbuf.buf));
> 
> ... see if the path being moved falls within that subdirectory.

Ah, there's another gotcha here: when moving a directory, we also add
all of its children to `argc`. So this would now always fail when we
move directories around.

I guess we can handle this by introducing another `MOVE_VIA_PARENT_DIR`
mode -- we'd then skip the verification for any entry marked like this.

> > +			if (!hashmap_get_entry(&moved_dirs, &needle, ent, NULL))
> > +				continue;
> 
> If there is no overlap, we need to do anything special.
> 
> > +			if (!ignore_errors)
> > +				die(_("cannot move both parent directory '%s' and its child '%s'"),
> > +				    pathbuf.buf, sources.v[i]);
> 
> Otherwise we are in trouble.
> 
> > +			if (--argc > 0) {
> > +				int n = argc - i;
> > +				strvec_remove(&sources, i);
> > +				strvec_remove(&destinations, i);
> > +				MOVE_ARRAY(modes + i, modes + i + 1, n);
> > +				MOVE_ARRAY(submodule_gitfiles + i,
> > +					   submodule_gitfiles + i + 1, n);
> > +				i--;
> > +				break;
> > +			}
> 
> So with
> 
> 	$ git mv a/ a/b x y z/
> 
> then a/ is left in the argv[]/sources[]/destinations[] arrays, and
> upon inspecting a/b, we come here and in order to ignore a/b, we
> shift it out; the resulting arrays would have a/, x, and y being
> moved to z/.
> 
> It somehow feels troubling that it would lead to a different result
> if I give a morally equivalent arguments, i.e.
> 
> 	$ git mv a/b a/ x y z/
> 
> where a/b survives and a/ gets omitted.

Fully agreed. I was quite surprised to see that git-mv(1) already
behaves like this with a couple of other error conditions. So I simply
continued to build on top of this behaviour, but I'm not a fan of it at
all.

Note that this behaviour doesn't trigger by default though. So your
above command would cause us to die without doing any change at all. You
explicitly have to `git mv -k` (whatever 'k' is supposed to mean --
maybe "keep going"?) to opt into this weird behaviour. Which makes this
overall a bit less awful.

> One thing that came to my mind (without concrete "here is the right
> way to solve it" that I am myself convinced) is this.
> 
>  * Should this code path even have its own ignore-errors handling?
>    "git mv a b z/", when 'a' does not exist, may ignore 'a' and move
>    only 'b', which may make sense.  But the original command line in
>    that case is a plausibly correct one if there weren't missing or
>    unmovable paths.  The command line "git mv a/ a/b z/" seems to
>    fall into a different category (aka "total nonsense"); no matter
>    how you fix the items in your working tree files, you cannot make
>    it plausibly correct.

Fair. I guess the intent of '-k' is about handling the case where a
subset of files might be missing, not the case where the original
request didn't make any sense at all. I certainly wouldn't mind to
tighten this code.

> a totally unrelated tangent that made me scratch my head while
> reading the original ocde is the dest_paths variable.  It is never
> used as a collection to hold potentially multiple paths; it is a
> strvec only to be able to call internel_prefix_pathspec() with, and
> used only once with only one element in the vector.  At least it
> should lose the plural 's' suffix to unconfuse its readers, I would
> think.

Yeah. From my point of view this isn't the only confusing part about
this code.

Patrick
