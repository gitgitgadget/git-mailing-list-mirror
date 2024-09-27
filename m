Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4396C17107F
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 05:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727414923; cv=none; b=kJaNTrYhUMzoTUGA6zOErOAE4xsDiGGsGUZ41w+AxcfYJWVVK6Oq7/foT+5nnbJEgbnrv0j/mgIgRsvih/4L6lQmaRhfctlScWUSMICYpWMeiByv70YP55H3BrodMald0R/y7ETbp4+0uJqkWDgQw+ny9R5uFjnl9OiU4ug2PR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727414923; c=relaxed/simple;
	bh=wny4IGvYoLUNzajLV5njyWpIvsbTSdLg4si4b5O1XA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjORlgaDIUfTp+Q5cAZBG8iLhZjjfK1RObgEUKz9GAMiWA9o+RC++fDPQItFNTB4KA4DroXxJP7jvrdjyXeK0ndhWEKL/noiKcdqeuPdUXUZ+1Takm1rJ0VIzJG0SGn19CIenE0QCaoOKkK/gckIcK7cRPpzmr/hF0josbLab/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OO//jynI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F9nk5Kb8; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OO//jynI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F9nk5Kb8"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F62711402F5;
	Fri, 27 Sep 2024 01:28:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 27 Sep 2024 01:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727414919; x=1727501319; bh=r8QVEagKrn
	FE1Ab3jsfYd8qPxzQeTwFEWdNi2FyJXEo=; b=OO//jynI9+K864lZDgKFmlhbS1
	RLWL0nRAImyox/DiCkNoHt/yEZLp/aMmvfubK5GcuRp/GJz0bXG35noX+oTQ2dH+
	9HOTuH8qU2pYsqiu9EyzST7SF3Yt9hhz5sKvqQqpHNGTbTt4NkAkl08kRXEtJqOo
	AD+HBZze7+Sy2fCErthKlDQ64ujlEnZac9GW4dx1ogohXkfwrGdyqMpEdiRt8QkC
	lPPnr0NrqkroBHVuygGEU26tEZTY9tNErShBb6uTpayhF9xVTSDb/R13ysMbMvF2
	z8uz8skHEzeU80m8bim3fJzaNg9tQVTsUMk05I7OfealwoIWm3taEXc/c7eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727414919; x=1727501319; bh=r8QVEagKrnFE1Ab3jsfYd8qPxzQe
	TwFEWdNi2FyJXEo=; b=F9nk5Kb8DmbJQcsbsLAqmjwFXZ9FKhuu3EpLvIfU8uhu
	OiThgDiOTxVkLtfSyUYCeiCnSPmDWs3UuDJiqyOGmUtvOMFqZyAGnYreLVvQslTl
	PP+H+Xvkfos0BF80jL3x+rfJChqdMpJviopqinErmQUEUeoY47BcLcUUMMtXZQkE
	iBMLBiLBV4V8enyy9Gvqu9I+YKEeaE7bziy3Qm6A+FlnVfzQ1+UA0QK/YytKLNT2
	iD/Ru8UnN+xrmfIReTmuew2jinhJsYVtvW8Csixe3s6JQzu4ptjUrNeGswGyLc7I
	91NNJlDHA20vXEHsjBQmlhQFtcKBVM51eO3sBd3iyw==
X-ME-Sender: <xms:hkL2ZnMc6DQUhiAAgO2jWN848QHu0yT1vbZQ-3MICiCinKG5Y1NW2Q>
    <xme:hkL2Zh-LXUy_sL3rA31xeDw1pWbW_lfoEc7bLjNcFyU1dfCfIWeZA5aiJt5KKsp6y
    sosF63_wGdGhbDyvA>
X-ME-Received: <xmr:hkL2ZmRuxqgtx24QYlvnBjEMCqEWRbFBPqRs7hrdEfC-PgsaIdk61TFWvYWH2yOoa9oEpnnj1Z7smqStqg7r8u2o8_QLq8MamNhg1FUMId94-n0kHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtkedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeefhfefleekueetudffkeelffdtueffuefhiedufeet
    tdeugfevkeffkedvtdefnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehhrghnfigvnhhnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvght
    hhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepshhtvg
    grughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehsphgvtghtrhgrlhesghho
    ohhglhgvrdgtohhm
X-ME-Proxy: <xmx:hkL2ZrtEvuTNO4WrUO7bCW0CUsiBkMP-lfuapHw4rC44ucWdGZZ8Vw>
    <xmx:hkL2ZvcJaxmiukIm4up0ItskMpaz4WtoDKWnWiY0AsXLcLE6bxlMkg>
    <xmx:hkL2Zn3EIeCybxi15bGhNYEaSHF0BvjYndy6edEKuFKi_7maE-BHVQ>
    <xmx:hkL2Zr-IwsCnv94Upqr8J3LItzdtQhM3Lz6br1JiKxqUrkHb7Ji7Sw>
    <xmx:h0L2ZhsbTLsE7HCGRpo2NVpX-3z5yGsxLGh-eMBB4ixr3ZjpFZ0Ehgvq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Sep 2024 01:28:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 87423dbe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Sep 2024 05:27:55 +0000 (UTC)
Date: Fri, 27 Sep 2024 07:28:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
	Josh Steadmon <steadmon@google.com>,
	Calvin Wan <calvinwan@google.com>,
	Kyle Lippincott <spectral@google.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 04/22] reftable/basics: handle allocation failures in
 `reftable_calloc()`
Message-ID: <ZvZCdcpifMpmKajx@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727158127.git.ps@pks.im>
 <f6ad92ffd01c442dacd3ac6aa448891028636636.1727158127.git.ps@pks.im>
 <xmqqikulugwj.fsf@gitster.g>
 <ZvVPiIzzLTTb75b8@pks.im>
 <xmqqzfnul7fg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzfnul7fg.fsf@gitster.g>

On Thu, Sep 26, 2024 at 09:13:23AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> But it illustrates why open coding is not necessarily an excellent
> >> idea in the longer term, doesn't it?  When unsigned_mult_overflows()
> >> is updated to avoid such a false positive, how would we remember
> >> that we need to update this copy we?
> >
> > I agree in general, but with the reftable library I'm stuck between a
> > rock and a hard place. My goal is to make it fully reusable by other
> > projects without first having to do surgery on their side. While having
> > something like `st_mult()` is simple enough to port over, the biggest
> > problem I have is that over time we sneak in more and more code from the
> > Git codebase. The result is death by a thousand cuts.
> 
> > Now if we had a single header that exposes a small set of functions
> > without _anything_ else it could work alright. But I rather doubt that
> > we really want to have a standalone header for `st_mult()` that we can
> > include. But without such a standalone header it is simply too easy to
> > start building on top of Git features by accident.
> >
> > So I'm instead aiming to go a different way and fully cut the reftable
> > code loose from Git. So even if we e.g. eventually want `struct strbuf`
> > return errors on failure, it would only address one part of my problem.
> 
> The dependency to "strbuf" (just as an example) was added initially
> fairly early.  Soon after 27f7ed2a (reftable: add LICENSE,
> 2021-10-07) added the reftable/ hierarchy, e303bf22 (reftable:
> (de)serialization for the polymorphic record type., 2021-10-07).  I
> somehow had an impression that reftable "library" started without
> any Git dependency and then use of our helper functions seemed
> through from the shim layer, but it was pretty much part of the
> library from day one, it seems.

I think the history goes a bit different. Initially, the reftable
library was developed completely outside of the Git tree in [1]. It did
not have any external dependencies and didn't use any of the Git code.

During the upstreaming process the discussion rather quickly swayed into
the direction of making Git the canonical upstream instead of using a
separate repository that hosts the code. See e.g. [2], which was still
tracking a VERSION file to keep track of the upstream version that the
code was pulled from. In [3] the discussion started about upstream
requiring a CLA, which was an (understandable) non-starter. I cannot
find the statement, but eventually we decided that canonical upstream
should be Git, and the VERSION file was never committed.

But with that decision, now that the reftable library was part of Git,
the reviews also started to note that it really should use functions
provided by Git. The initial version of the patch series didn't yet have
any of that. From my point of view that was a big mistake, as the result
is that Git is _not_ reusable by other projects in its current state.

[1]: https://github.com/google/reftable/tree/master/c
[2]: <2106ff286b1135f9428529d9fc392edc127e960c.1580134944.git.gitgitgadget@gmail.com>
[3]: <20200207001612.GF6573@camp.crustytoothpaste.net>

> > A couple months ago I said that I'll try to write something like shims
> > that wrap our types in reftable types such that other projects can
> > provide implementations for such shims themselves. I tried to make that
> > work, but the result was an unholy mess that really didn't make any
> > sense whatsoever. Most of the features that I need from the Git codebase
> > can be provided in a couple of lines of code (`struct strbuf` is roughly
> > 50 lines for example), plus maybe a callback function that can be
> > provided to wire things up on the user side (`register_tempfiles()` for
> > example). So once I saw that those wrappers are harder to use and result
> > in roughly the same lines of code I decided to scrap that approach and
> > instead try to convert it fully.
> >
> > So yeah, overall we shouldn't open-code things like this. But I don't
> > really see another way to do this for the reftable library.
> 
> But isn't all of the above what Libification ought to be about?  I
> was hoping that the reftable polishing would not have to be done by
> you alone, and you would recruit those who are into libification of
> other parts of Git codebase to help cleaning up these fringe (from
> the point of view of reftable) interfaces.
> 
> What do the libification folks feel about this (folks involved in
> libgit-sys CC'ed; of course all others who are interested in the
> libification topic are welcome to comment)?

I think it's orthogonal to that. The libification effort doesn't really
care about exposing low-level details like `st_mult()` as a library, or
even the `strbuf` interface. It cares about making Git functionality
available, which is on a much higher conceptual level.

Furthermore, to the best of my knowledge the intent wasn't ever to
provide the ability to take a couple of C files and have them be easy to
build as part of another project. The goal is to have proper interfaces
to our code, but whether the code itself has internal interdependencies
is not really much of a concern (globals are a different story).

My goal is different: I want to `cp -r` the "reftable/" directory into
libgit2 or any other project that wants to implement a reftable backend
without having to care about all the different dependencies that it may
pull in or having to carefully massage all of the includes.

Now if it was a single standalone file that one would have to copy in
addition to that I'd be fine. But "strbuf.c' isn't that at all: it ropes
in "gettext.h", "hex-ll.h", "string-list.h", "utf-8.h", "date.h". All of
which is not needed at all, but the person who does the porting now has
to carefully figure out what can and cannot be removed from both
"strbuf.h" and "strbuf.c".

So... it gets out of hand really fast. We would have to significantly
change the way we develop the Git codebase if we wanted to make this a
good experience. But enforcing very strict coding guidelines onto all of
our codebase doesn't feel reasonable to me, which is why I am instead
trying to reinstate the state where the reftable library was decoupled
from the rest of the Git codebase.

The difference here is roughly 100 to 200 lines of code, which I don't
think is much of a maintenance burden by itself. In fact, we'll even
start to share the maintenance burden with libgit2, because they would
be able to use the exact same copy as we do and thus contribute back
bugfixes and improvements for discoveries that their additional test
coverage brings us.

I hope that this all clarifies my point of view :) I've also Cc'd
Han-Wen in case I've made any mistakes regarding the original intent.

Patrick
