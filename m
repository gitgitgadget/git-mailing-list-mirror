Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908FF2DC768
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 12:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017213; cv=none; b=aGuZjs/FfkRKC195Ui3C0yoWfN8xbHMxxC2ATOt9H5vQPf0xwbPzuSYv40jlsva021DQmeHccOSNKtU0/lgcBTH0WCuG3xw2D0VPQqs4hrXCLyo0c8UbTFvbrN3zjZUY+DJPe6AXWL9zNxlakQblklwhL/I6Jdy1GKQeYvMt6cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017213; c=relaxed/simple;
	bh=r10w/KLX1506M7clYE1QpkJzVDtfGQpHVnmKXp6n6uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPTi61Z7n9cIZcdcKlO3KwBQvIXCnFTu7a/1PHmC3pOtQ5EnVVhBwwL7S8DqzVfw2C0rkGLxsE/5TffvgnKuIOEes6Ym2TK3DIu+ML8K15Z7Mra+8/zZ8XppEUSAcqlwtvKUgHKjBllG1Qd/ufv0fgCeUZS/fcsCc0Q5B20yex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dyA4kECh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kZ9Y970q; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dyA4kECh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kZ9Y970q"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 92B9311402A2;
	Wed, 30 Apr 2025 08:46:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 30 Apr 2025 08:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746017210; x=1746103610; bh=j6pLHZ6FUT
	F932PqWuenuTfawLEk8lE7eZh3r4Ujqd4=; b=dyA4kEChuKOxwQfmxXYNWsEa7R
	AT5Evx6MNoz0calvxCvB/DD8DwtEcxmdAUDpCRPgoy4/w8IYD1gPBL7dqhL4Qvh+
	cxjSdvZyrbVUhA76foz+meYBrI5hZFlw1KZSn7Z7Tye4oS2PUOH1oX89tckg4z8q
	tkWaC2tJUmnpEn1yFtcO81Ga59/VqW++YErcsI0B9fO+YiNVTP2kRAf3AALRYtQn
	l1eHvsYQhUnXfSA9zTmScVjxKUpZ9CfSavezc08C5rqOSrSoxMvX2mYgfyMcwAM7
	PnEvrmTIU4bg97XXhztBnwQVJWL8edV15sUxD6JbGKxscz0MSarZ/kwiLeEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746017210; x=1746103610; bh=j6pLHZ6FUTF932PqWuenuTfawLEk8lE7eZh
	3r4Ujqd4=; b=kZ9Y970qJTz4GfpsKdg90Iek6GLQMPHmBwXPR/DNg0yPD5/w3Eh
	ezHRNty8FVk81f7f9At9kSOotGV48FqqZZ97ymYsGzMKP0FiOxsokFQcNuK19LS+
	vdYltNT3XH4dzvO5GbXYZRfknDbAuZNo3cOVFOinF/+3o5PAV9EU9TH7DSELKKMh
	abKFfuZeJP6JbDO+it8NS0SaCYvqBnlhRrsJBIAbxfU2brP2f6tYmPdjQQIw1plz
	mAvcTVAbvGHHUWO0k2iwDa/CrfY3T7GllVvA3unN756/Rczvu3lXIiRk5WLeyMia
	grRC3BWsN596MfoURHtVTF98XkJ2Z4t90iw==
X-ME-Sender: <xms:uhsSaBwGtrFVe6SmYvm8JOOXoajZUZbU9euJ9cEzNW4Dh2kNMB-WUA>
    <xme:uhsSaBTew2XitsThbAXhjnnmaTABAQs6smJ1A_V7TVD4nvxEfAIsWChJyquLtTAep
    RlV0Y8SvwTikfsfAA>
X-ME-Received: <xmr:uhsSaLXeu1eV9in7zIR4MplGYIG_iOChdA70R7IZmLYRliJ1SvwdSj6hldDrV9_v5_U8f9Xx9gMV3rbAfttMIT82eQdVozPYFdNc7d819pUT3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeijeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepjedttdegffekudejjeegudehgfehtdfgtdeiudel
    ueelgfeuteehledugeeuueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhho
    hhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:uhsSaDjd067XXgqfgV9CUh8e3DRzjP75jT4OIAEi7xgfRvm7xy6b-w>
    <xmx:uhsSaDBF2YRtv6fYm9XWBE-FSKJv72oXxmwcdQuOJ_HWKfPBM2WTwg>
    <xmx:uhsSaMIx0q1Yokwyiuk5q1lE6i8ojPUnngTBdqbYY8nzkAyxZ0W6KA>
    <xmx:uhsSaCANqWife8MTXqgXqvmBiGkIlZm7t4p075qDF8xGOYLADMW8Qw>
    <xmx:uhsSaFuLMxnAOFaPxoPLlB007rM6_SuveQNvSr9RyR1u0YwAxfMXqRsG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 08:46:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c5b05cd3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 30 Apr 2025 12:46:48 +0000 (UTC)
Date: Wed, 30 Apr 2025 14:46:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(win+Meson): build in Release mode, avoiding t7001-mv
 hangs
Message-ID: <aBIbtykdjseJRzwr@pks.im>
References: <pull.1908.git.1745593515875.gitgitgadget@gmail.com>
 <xmqqmsc4uv6d.fsf@gitster.g>
 <aA8ymUzWM2t0QkFP@pks.im>
 <xmqq8qnkdxu9.fsf@gitster.g>
 <aBDD-NeN2YoQbU9S@pks.im>
 <xmqqplgu4ru5.fsf@gitster.g>
 <aBHmMKqhVDEl777o@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBHmMKqhVDEl777o@pks.im>

On Wed, Apr 30, 2025 at 10:58:24AM +0200, Patrick Steinhardt wrote:
> On Tue, Apr 29, 2025 at 01:48:18PM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > 
> > > @@ -213,6 +228,8 @@ int cmd_mv(int argc,
> > >  	struct cache_entry *ce;
> > >  	struct string_list only_match_skip_worktree = STRING_LIST_INIT_DUP;
> > >  	struct string_list dirty_paths = STRING_LIST_INIT_DUP;
> > > +	struct hashmap moved_dirs = HASHMAP_INIT(pathmap_cmp, NULL);
> > > +	struct strbuf pathbuf = STRBUF_INIT;
> > >  	int ret;
> > >  
> > >  	git_config(git_default_config, NULL);
> > > @@ -331,11 +348,17 @@ int cmd_mv(int argc,
> > >  
> > >  dir_check:
> > >  		if (S_ISDIR(st.st_mode)) {
> > > +			struct pathmap_entry *entry;
> > >  			char *dst_with_slash;
> > >  			size_t dst_with_slash_len;
> > >  			int j, n;
> > >  			int first = index_name_pos(the_repository->index, src, length), last;
> > >  
> > > +			entry = xmalloc(sizeof(*entry));
> > > +			entry->path = src;
> > > +			hashmap_entry_init(&entry->ent, fspathhash(src));
> > > +			hashmap_add(&moved_dirs, &entry->ent);
> > > +
> > 
> > OK, this collects in moved_dirs the directories that will get moved.
> > And then a separate loop, ...
> > 
> > > +	for (i = 0; i < argc; i++) {
> > > +		const char *slash_pos;
> > > +
> > > +		strbuf_addstr(&pathbuf, sources.v[i]);
> > 
> > Shouldn't there be a call to strbuf_reset(&pathbuf) before doing
> > this?
> 
> Yup, indeed.
> 
> > > +		slash_pos = strrchr(pathbuf.buf, '/');
> > 
> > And start from the deepest directory, going one level up per
> > iteration, ...
> > 
> > > +		while (slash_pos > pathbuf.buf) {
> > > +			struct pathmap_entry needle;
> > > +
> > > +			strbuf_setlen(&pathbuf, slash_pos - pathbuf.buf);
> > > +
> > > +			needle.path = pathbuf.buf;
> > > +			hashmap_entry_init(&needle.ent, fspathhash(pathbuf.buf));
> > 
> > ... see if the path being moved falls within that subdirectory.
> 
> Ah, there's another gotcha here: when moving a directory, we also add
> all of its children to `argc`. So this would now always fail when we
> move directories around.
> 
> I guess we can handle this by introducing another `MOVE_VIA_PARENT_DIR`
> mode -- we'd then skip the verification for any entry marked like this.
> 
> > > +			if (!hashmap_get_entry(&moved_dirs, &needle, ent, NULL))
> > > +				continue;
> > 
> > If there is no overlap, we need to do anything special.
> > 
> > > +			if (!ignore_errors)
> > > +				die(_("cannot move both parent directory '%s' and its child '%s'"),
> > > +				    pathbuf.buf, sources.v[i]);
> > 
> > Otherwise we are in trouble.
> > 
> > > +			if (--argc > 0) {
> > > +				int n = argc - i;
> > > +				strvec_remove(&sources, i);
> > > +				strvec_remove(&destinations, i);
> > > +				MOVE_ARRAY(modes + i, modes + i + 1, n);
> > > +				MOVE_ARRAY(submodule_gitfiles + i,
> > > +					   submodule_gitfiles + i + 1, n);
> > > +				i--;
> > > +				break;
> > > +			}
> > 
> > So with
> > 
> > 	$ git mv a/ a/b x y z/
> > 
> > then a/ is left in the argv[]/sources[]/destinations[] arrays, and
> > upon inspecting a/b, we come here and in order to ignore a/b, we
> > shift it out; the resulting arrays would have a/, x, and y being
> > moved to z/.
> > 
> > It somehow feels troubling that it would lead to a different result
> > if I give a morally equivalent arguments, i.e.
> > 
> > 	$ git mv a/b a/ x y z/
> > 
> > where a/b survives and a/ gets omitted.
> 
> Fully agreed. I was quite surprised to see that git-mv(1) already
> behaves like this with a couple of other error conditions. So I simply
> continued to build on top of this behaviour, but I'm not a fan of it at
> all.
> 
> Note that this behaviour doesn't trigger by default though. So your
> above command would cause us to die without doing any change at all. You
> explicitly have to `git mv -k` (whatever 'k' is supposed to mean --
> maybe "keep going"?) to opt into this weird behaviour. Which makes this
> overall a bit less awful.
> 
> > One thing that came to my mind (without concrete "here is the right
> > way to solve it" that I am myself convinced) is this.
> > 
> >  * Should this code path even have its own ignore-errors handling?
> >    "git mv a b z/", when 'a' does not exist, may ignore 'a' and move
> >    only 'b', which may make sense.  But the original command line in
> >    that case is a plausibly correct one if there weren't missing or
> >    unmovable paths.  The command line "git mv a/ a/b z/" seems to
> >    fall into a different category (aka "total nonsense"); no matter
> >    how you fix the items in your working tree files, you cannot make
> >    it plausibly correct.
> 
> Fair. I guess the intent of '-k' is about handling the case where a
> subset of files might be missing, not the case where the original
> request didn't make any sense at all. I certainly wouldn't mind to
> tighten this code.
> 
> > a totally unrelated tangent that made me scratch my head while
> > reading the original ocde is the dest_paths variable.  It is never
> > used as a collection to hold potentially multiple paths; it is a
> > strvec only to be able to call internel_prefix_pathspec() with, and
> > used only once with only one element in the vector.  At least it
> > should lose the plural 's' suffix to unconfuse its readers, I would
> > think.
> 
> Yeah. From my point of view this isn't the only confusing part about
> this code.
> 
> Patrick
> 

I have polished this patch a bit now and sent it via [1]. Thanks!

Patrick

[1]: <20250430-pks-mv-parent-child-conflict-v1-0-11a87c55ffb9@pks.im>
