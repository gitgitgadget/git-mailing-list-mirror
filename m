Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A0E3321DB
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051645; cv=none; b=DfTOLD70g2+0e6VVo/9+hJRW9txQBDzDHsDKMxZkubzwtpR7OxwyptsVRiWXJQ8R3jtlhmmTK91oXtaaS8+HkA8Hid0b9jOH7LbHr52Imfe5DIo6303EtjV5T+Q1ZxwyuIxr3LsgSimXFyxEyjWYT8KqRAtCCSW/rB+A3KFQ9NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051645; c=relaxed/simple;
	bh=QQ6XYoTXuYxplhpoW6mAu6NXi2D+56CofdCfrXYWxr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohy9Rv0gL1ozlL4ckWgGx8Omy8XKjyPmRpVDjZax1hJ9ySmtobiTbXwjZSM8vPrtEBJTOfgJW67mN0mzwdm7tBaYy7iTqdtcWuGwaCgxEuUtkBJH9kyt+EeOI3FA4Igz77RxYXP4v943r9jaOtf1OzxGFxO57E0fjnKpiJVoWj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VPrsvzY3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rhb6QGgM; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VPrsvzY3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rhb6QGgM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AD4A31400126;
	Tue, 21 Oct 2025 09:00:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 21 Oct 2025 09:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761051641; x=1761138041; bh=3pqcG2JQ6o
	KS91bUNaGXS8ubLZ2UefcZQmK5feA6wZI=; b=VPrsvzY3Lwu9dMy9SepIfh2aAC
	NbEbRwTM9mc/08MpKUS6QB8o/udugFU3D3bu46tUO3zM5+ptcz9gdUuiaEKu8K6K
	t5vUsNMnLMDq98oyN+Nr6fJIr/IuLkEZKBSw1BI4ihmmV7+fM3/R64FEqA3yoG8P
	jPfJZ7k3sH3xUPWlxCTdKu09KyReYc5ndVHMskkY/1Vmc99bUwYb0FnUdQx4Z2FT
	4lIe2/sfoE49urmfreW1XM5y7kqruk5l8ks9IWk6XxwMBH8aPMy3xNl01cQApvQf
	uvu9C0EC99zg+ExmUstscPNCroZ0RFmNUxIDkF0DiyujBj3LqoAA9HiSBHQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761051641; x=1761138041; bh=3pqcG2JQ6oKS91bUNaGXS8ubLZ2UefcZQmK
	5feA6wZI=; b=rhb6QGgMT5gJHjP00QVvNFtfFNhAd6cNHkeA7I9OdjCvTf7grrY
	FfKNui+wdkTCg6Ci623nYY+IkVWdHAj3GPtkZ7MXrBYEJ7agzW973fDFMqORzncn
	yJ8hIs+yzlHLFqrJePaqu2SGwBWQ1AlHONFeevcmtT6axZEldCNqpuT7K4lH774R
	uw8494oD7Q6s5SDsyCCezq4TPxSGjJTbw362Ht7HVBkW5M0CGoKBQH6sIr2+hvpd
	W8o8KtrukXA8xtfMzV9hN2Vn2omxmDH/OrJ68nwY3WsNNIi/SvGL6aeucGVNPWEA
	pANzdKecyg1AqvuKOfxKOodUqXVRFlRxwgA==
X-ME-Sender: <xms:-YP3aCXksIHTUSvFZXLD0nE7Siu-Sj4RccSeKQvBeVM7vsglZNB_rw>
    <xme:-YP3aGBZOD-gKDijuKqe5R-i7UNBxYMnydCE7B2wbDOK9n7lF6jnwcLgfT7xPgyrd
    7dPtL1X40GsFQiC-ed6EDi58kLIyiJ-FpdxPhhj59K8Z-l28vYb1w>
X-ME-Received: <xmr:-YP3aDxWSGTxFKBdr9KCCgsPNYr0tmeBZpau69pN5wbcPyizCL8T9drMqDicTUC6mofEQY-3m5pONWwYfrxI-rpccCoDg9I3wpgo2MlK0RPGrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epieefvdefgfekteeufeeivdffhffhuddtvdeviedvhfdugeeftefhgfffgeefleeunecu
    ffhomhgrihhnpehinhgtrhgvmhgvnhhtrghlqdhrvghprggtkhdrrghuthhopdhgvghomh
    gvthhrihgtqdhrvghprggtkhdrrghuthhopdhrvghflhhoghdqvgigphhirhgvrdgruhht
    ohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:-YP3aDAjYSBq2uY-W7atYQ_yvRpjeJBPDwxRolkTS8DP4esgzfij5Q>
    <xmx:-YP3aAaXmon46OUWz8vnml9d6n02IPl1I3eaqDowV7JwXiUImFgXNA>
    <xmx:-YP3aLgym_Jhf3IHzTVm5maig0l0tqJxkU-xInWhu5au9DcKCno5xQ>
    <xmx:-YP3aC7yGHt3cNaGakC5All2Y1oP1Y95obykL8LGXxelAcZElQaTYA>
    <xmx:-YP3aKcb0oitxrgvfBkX0ijwii3KmgXQAdC-fkcsf2jVX5thVRUMJVa9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 09:00:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b8b44c94 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 13:00:38 +0000 (UTC)
Date: Tue, 21 Oct 2025 15:00:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/8] builtin/maintenance: introduce "geometric-repack"
 task
Message-ID: <aPeD75W4FjtTZDYr@pks.im>
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
 <20251016-pks-maintenance-geometric-strategy-v1-3-18943d474203@pks.im>
 <aPLC9FIDR8Y3ayn+@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPLC9FIDR8Y3ayn+@nand.local>

On Fri, Oct 17, 2025 at 06:28:04PM -0400, Taylor Blau wrote:
> On Thu, Oct 16, 2025 at 09:26:34AM +0200, Patrick Steinhardt wrote:
> > Introduce a new "geometric-repack" task. This task uses our geometric
> > repack infrastructure as provided by git-repack(1) itself, which is ab
> > strategy that especially hosting providers tend to use to amortize the
> > costs of repacking objects.
> >
> > There is one issue though with geometric repacks, namely that they
> > unconditionally pack all loose objects, regardless of whether or not
> > they are reachable. This is done because it means that we can completely
> > skip the reachability step, which significantly speeds up the operation.
> > But it has the big downside that we are unable to expire objects over
> > time.
> >
> > To address this issue we thus use a split strategy in this new task:
> > whenever a geometric repack would merge together all packs, we instead
> > do an all-into-one repack. By default, these all-into-one repacks have
> > cruft packs enabled, so unreachable objects would now be written into
> > their own pack. Consequently, they won't be soaked up during geometric
> > repacking anymore and can be expired with the next full repack, assuming
> > that their expiry date has surpassed.
> 
> Well put. Geometric repacking today is really only what objects appear
> in the packfiles, not whether those objects are reachable or not. That's
> partially by design: geometric repack operations are meant to be as
> lightweight and quick as possible, so performing a potentially expensive
> reachability traversal defeats the purpose.
> 
> This mirrors what GitHub does today with their own repository
> maintenance implementation. There is some number of geometric repack
> operations interspersed between full repacks which collapse the
> geometric progression and move unreachable objects out into cruft packs.

Yeah, we also do the same at GitLab.

> So I think that what you did here makes a ton of sense to me. Ultimately
> I think there is a middle ground for geometric repacking (well outside
> of the scope for this series ;-), don't worry) that could make it do a
> little bit of both.
> 
> If 'git pack-objects --stdin-packs' (what ultimately implements the
> portion of geometric repacking that combines packs together) knew the
> current state of a repository's references, it could mark the objects in
> the packs to be combined as either reachable or unreachable. Then in a
> specialized mode, you could exclude any objects which are unreachable
> from the resulting pack, and take a separate pass to write out a cruft
> pack containing those objects before ultimately deleting the combined
> packs.
> 
> I think that is all possible to do, and I think there is a way we could
> do it relatively quickly without harming the performance of geometric
> repacking. When traversing and marking objects, we can stop as soon as
> we see an object that is not contained in the packs that that we're
> combining.
> 
> So I don't think we have to do a whole-repository walk, which would
> indeed defeat the purpose of geometric repacking. The above procedure
> would cause us to write out small cruft packs, but we could use the
> --combine-cruft-below-size option of 'git repack' to prevent too many
> small cruft packs from accumulating together.
> 
> Anyway, nothing of that has anything to do with what you wrote here ;-).
> It was mostly an excuse for me to write down some of these thoughts that
> I've had in my head and alluded to briefly a couple of weeks ago at Git
> Merge. Expect some actual patches in this direction from me in the not
> too distant future :-).

Looking forward to them :)

> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  Documentation/config/maintenance.adoc |  11 +++
> >  builtin/gc.c                          | 102 +++++++++++++++++++++++++
> >  t/t7900-maintenance.sh                | 137 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 250 insertions(+)
> >
> > diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
> > index 2f719342183..26dc5de423f 100644
> > --- a/Documentation/config/maintenance.adoc
> > +++ b/Documentation/config/maintenance.adoc
> > @@ -75,6 +75,17 @@ maintenance.incremental-repack.auto::
> >  	number of pack-files not in the multi-pack-index is at least the value
> >  	of `maintenance.incremental-repack.auto`. The default value is 10.
> >
> > +maintenance.geometric-repack.auto::
> > +	This integer config option controls how often the `geometric-repack`
> > +	task should be run as part of `git maintenance run --auto`. If zero,
> > +	then the `geometric-repack` task will not run with the `--auto`
> > +	option. A negative value will force the task to run every time.
> > +	Otherwise, a positive value implies the command should run either when
> > +	there are packfiles that need to be merged together to retain the
> > +	geometric progression, or when there are at least this many loose
> > +	objects that would be written into a new packfile. The default value is
> > +	100.
> > +
> 
> OK. To make sure I understand: this limit is the minimum number of loose
> objects would cause the geometric-repack task to run, unless there are
> pack(s) which would be combined as a result of running a geometric
> repack, in which case we run it regardless.
> 
> Is that right?

Yeah, exactly. I was initially thinking to only frame this in the
context of "how many packs would be merged"? But the problem with that
is that we wouldn't ever generate _new_ packs if the repository only
ever grows loose objects, and consequently we also wouldn't ever merge
any of them.

> >  maintenance.reflog-expire.auto::
> >  	This integer config option controls how often the `reflog-expire` task
> >  	should be run as part of `git maintenance run --auto`. If zero, then
> > diff --git a/builtin/gc.c b/builtin/gc.c
> > index 026d3a1d714..2c9ecd464d2 100644
> > --- a/builtin/gc.c
> > +++ b/builtin/gc.c
> > @@ -34,6 +34,7 @@
> >  #include "pack-objects.h"
> >  #include "path.h"
> >  #include "reflog.h"
> > +#include "repack.h"
> 
> Hey, neat ;-).

Yup, your refactorings helped a bunch :)

> > @@ -1566,6 +1568,101 @@ static int maintenance_task_incremental_repack(struct maintenance_run_opts *opts
> >  	return 0;
> >  }
> >
> > +static int maintenance_task_geometric_repack(struct maintenance_run_opts *opts,
> > +					     struct gc_config *cfg)
> > +{
> > +	struct pack_geometry geometry = {
> > +		.split_factor = 2,
> 
> I wonder if this should be configurable somewhere. It might not be a bad
> idea to introduce a 'repack.geometricSplitFactor' configuration
> variable, defaulting to two, and use that here. It would also be nice to
> be able to run 'git repack --geometric -d' and have it fallback to that
> split factor, since using "2" is so common that it's frustrating when I
> forget to type it out explicitly ;-).

I was also pondering over this. I think the way to do so would be to
introduce "maintenance.geometric-repack.splitFactor", as that follows
all the other maintenance configuration we have there, as well.

I decided to not do it yet as I wanted to keep the scope of this patch
series contained. But honestly, it's an easy-enough change to make, so
let me introduce another patch to do this.

> > +	};
> > +	struct pack_objects_args po_args = {
> > +		.local = 1,
> > +	};
> > +	struct existing_packs existing_packs = EXISTING_PACKS_INIT;
> > +	struct string_list kept_packs = STRING_LIST_INIT_DUP;
> > +	struct child_process child = CHILD_PROCESS_INIT;
> > +	int ret;
> > +
> > +	existing_packs.repo = the_repository;
> > +	existing_packs_collect(&existing_packs, &kept_packs);
> > +	pack_geometry_init(&geometry, &existing_packs, &po_args);
> > +	pack_geometry_split(&geometry);
> > +
> > +	child.git_cmd = 1;
> > +
> > +	strvec_pushl(&child.args, "repack", "-d", "-l", NULL);
> > +	if (geometry.split < geometry.pack_nr)
> > +		strvec_push(&child.args, "--geometric=2");
> > +	else
> > +		add_repack_all_option(cfg, NULL, &child.args);
> 
> Makes sense; if we're not merging any packs, we do an all-into-one
> repack, otherwise we do a geometric one. Looks like the function
> geometric_repack_auto_condition() below controls whether or not we even
> take this path, which makes sense relative to the documentation you
> wrote above.

It does, but only in case we do `git maintenance run --auto`. If you run
`git maintenance run` without the flag we unconditionally execute this
code here. But that's fine: if the repository is already well-optimized
we don't end up doing anything.

> > +static int geometric_repack_auto_condition(struct gc_config *cfg UNUSED)
> > +{
> > +	struct pack_geometry geometry = {
> > +		.split_factor = 2,
> > +	};
> > +	struct pack_objects_args po_args = {
> > +		.local = 1,
> > +	};
> > +	struct existing_packs existing_packs = EXISTING_PACKS_INIT;
> > +	struct string_list kept_packs = STRING_LIST_INIT_DUP;
> > +	int auto_value = 100;
> > +	int ret;
> > +
> > +	repo_config_get_int(the_repository, "maintenance.geometric-repack.auto",
> > +			    &auto_value);
> > +	if (!auto_value)
> > +		return 0;
> > +	if (auto_value < 0)
> > +		return 1;
> > +
> > +	existing_packs.repo = the_repository;
> > +	existing_packs_collect(&existing_packs, &kept_packs);
> > +	pack_geometry_init(&geometry, &existing_packs, &po_args);
> > +	pack_geometry_split(&geometry);
> > +
> > +	/*
> > +	 * When we'd merge at least two packs with one another we always
> > +	 * perform the repack.
> > +	 */
> > +	if (geometry.split) {
> > +		ret = 1;
> > +		goto out;
> > +	}
> 
> Hmm. I wish that we could somehow pass this information to the function
> above so that we don't have to re-discover the fact that there are packs
> to combine. I'm not familiar enough with the maintenance code to know
> how difficult that would be to do, but it looks like at least the
> gc_config pointer is shared between the auto condition and the task
> itself.
> 
> That's kind of gross to tack on there, but I could see a compelling
> argument for passing around an extra void pointer between the two that
> would allow us to propagate this kind of data between the auto condition
> and the task itself. It's not super expensive to do so I don't think not
> doing it is a show-stopper at least from a performance perspective, but
> it does seem like a good opportunity to DRY things up a bit.

The problem is that the auto-condition is not evaluated when running
without the "--auto" flag. We of course can conditionally compute the
split in case we figure that the auto-condition didn't run, but it does
get somewhat dirty.

So I'd propose to defer such a change into the future in case we notice
that this indeed is a problem. Is that fine with you?

> > diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> > index ddd273d8dc2..83a373fe94b 100755
> > --- a/t/t7900-maintenance.sh
> > +++ b/t/t7900-maintenance.sh
> > @@ -465,6 +465,143 @@ test_expect_success 'maintenance.incremental-repack.auto (when config is unset)'
> >  	)
> >  '
> >
> > +run_and_verify_geometric_pack () {
> > +	EXPECTED_PACKS="$1" &&
> > +
> > +	# Verify that we perform a geometric repack.
> > +	rm -f "trace2.txt" &&
> > +	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
> > +		git maintenance run --task=geometric-repack 2>/dev/null &&
> > +	test_subcommand git repack -d -l --geometric=2 --quiet --write-midx <trace2.txt &&
> 
> Makes sense. I do think the test_subcommand thing is a little fragile
> here, but verifying that the resulting pack structure forms a geometric
> progression feels like overkill for this test, so I think what you wrote
> here makes sense.

Oh, yeah, it's fragile and somewhat gross indeed. Couldn't really find a
nicer way to do it though :/

> As an aside, would you mind wrapping these lines instead of putting the
> command-line invocation all together on a single line?

Sure, can do.

> > +
> > +	# Verify that the number of packfiles matches our expectation.
> > +	ls -l .git/objects/pack/*.pack >packfiles &&
> > +	test_line_count = "$EXPECTED_PACKS" packfiles &&
> > +
> > +	# And verify that there are no loose objects anymore.
> > +	cat >expect <<-\EOF &&
> > +	info
> > +	pack
> > +	EOF
> > +	ls .git/objects >actual &&
> 
> I wonder if there is an easier way to check for loose objects here that
> doesn't require you to know that the "info" and "pack" directories
> exist. Perhaps something like:
> 
> test_stdout_line_count = 0 find .git/objects/?? -type f
> 
> , or even
> 
>     find .git/objects/?? -type f >loose.objs &&
>     test_must_be_empty loose.objs

This doesn't work though in case there is not even a single sharding
directory:

    find: '.git/objects/??': No such file or directory

I didn't really have any other idea for now to do this.

> > +test_expect_success 'geometric repacking task' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		git config set maintenance.auto false &&
> > +		test_commit initial &&
> > +
> > +		# The initial repack causes an all-into-one repack.
> > +		GIT_TRACE2_EVENT="$(pwd)/initial-repack.txt" \
> > +			git maintenance run --task=geometric-repack 2>/dev/null &&
> > +		test_subcommand git repack -d -l --cruft --cruft-expiration=2.weeks.ago --quiet --write-midx <initial-repack.txt &&
> > +
> > +		# Repacking should now cause a no-op geometric repack because
> > +		# no packfiles need to be combined.
> > +		ls -l .git/objects/pack >before &&
> > +		run_and_verify_geometric_pack 1 &&
> > +		ls -l .git/objects/pack >after &&
> > +		test_cmp before after &&
> > +
> > +		# This incremental change creates a new packfile that only
> > +		# soaks up loose objects. The packfiles are not getting merged
> > +		# at this point.
> > +		test_commit loose &&
> > +		run_and_verify_geometric_pack 2 &&
> 
> I wonder if you want to harden this test a little bit to ensure that the
> there is only one new pack being created here, and we're not seeing
> e.g., the removal of the existing pack and creation of two new packs.
> 
> I dunno, that may be overkill for this test, and I certainly don't feel
> strongly about it.

Yeah, I had the same thought when writing this, but it quickly got ugly.
I then decided to not do this and instead only verify that the structure
loosely looks like we expect, and that the expected command actually
ran.

In the end we can rely on t7703 to verify the internals of how exactly
the geometric repack works, whereas here we only verify that the
strategy works as expected.

> > +
> > +		# Both packfiles have 3 objects, so the next run would cause us
> > +		# to merge both packfiles together. This should be turned into
> 
> Perhaps s/both/all/ ? What you wrote is not wrong, of course, but I
> think "all" more clearly communicates that we are only doing an
> all-into-one because the geometric repack would have combined everything
> together anyway.

Sure, happy to reword.

Thanks for your review!

Patrick
