Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17AB25F984
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 22:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760740090; cv=none; b=HmMWApPUgdHcC4bx8S9E/jAKWP6P4neUqYitOFA+Wag0ImOl2HUNzKa+mxNtjtFEAlMwTlQN8OoyGy6NHx09zEHMg3ygbI+l0kEBskTOIygPrU7/swlOv2YZzIUz75oH9gZeBEtN1jKj6olfykyKDBG43nQSor5lPRkqqv2pZCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760740090; c=relaxed/simple;
	bh=fjuPm60YrF9e4ufv3fkHOppCfSuNNuSiniQq8L2lpG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIfq+FG87I/halL8/yDPN+xzxda8MUDVKrtTgg1KAXd2pbHfVpZwBn7+DPMVFEEnuI7Y8Pw9akv89D2nXp36BVAgeO05vvyYkLxQ80eodUOiQLXSHOND0CfYp8y5ze3H67GF5vnJTJzzR3G8yVFQ+fnxAzENsTaFPHugJcgrqiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ITVxzMky; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ITVxzMky"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-93e7468e84bso96631239f.2
        for <git@vger.kernel.org>; Fri, 17 Oct 2025 15:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760740087; x=1761344887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OozgQD9AoyHMZgmZjixpNsi7l+vu2NYpPYVT6+iXB5I=;
        b=ITVxzMkysFCCiMeNsIuVN4ZZPdwC8izSpiV69Ty7DEbpZSLToijTWEQeDY0t98oJaM
         t10NyjUSJ3JE27Yh0sAZXEpmhwP77OqljM04Wr6UvztZI3APRetnq+bNERjuAVNtJZpX
         jrpYjsmXUH/ZRFoqZ0ZPfW7VS6t9TpDPlf9GrqYiwlv4sKPtfWID/NG+oGnzFy5O9IfQ
         v6aiPZFVqG6sKYoOFCqGqrNnMB40agBkOUtdmQrLh3RO1nU612wZvWlPHlztVDhampy8
         mfzVtVBrKCMLzb+b1OmCcQHkX5TXe7JHGvB5fdBNOyyKX7sVzBsdsvaSQGR7nfTfDgD4
         5x9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760740087; x=1761344887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OozgQD9AoyHMZgmZjixpNsi7l+vu2NYpPYVT6+iXB5I=;
        b=V6lImHMl30qePS7Wk7J+ns78rgWTSes2UFvgp2xxwjSwjvKjV1Qq5vbtUHKQu3Tobm
         oAq0psaAGllx6yqDeRpq1zEUvS8A1uaolBxDXr7CQdGGZb9xFSa7uilzppvkUUMeWYmq
         gvQq+g1Olx0SmdgRavY/ZGjNC00xP6BSvLDwMl18jTtg5sXbFuukaXMnQTzFX0ijzGbI
         t63ZH7WLmrf0sI0CMrLXDXfz9hRlJiyohecsWlISpbKbHToqojv1YTXX101SP1I1tXqC
         gZ0GXK3bDv2QmIN2Lw4esIcYSeTjRLrW883upNouOy9W0yQg3w+fidXJAnTTYCKDYo7q
         P24w==
X-Gm-Message-State: AOJu0YznChztQGtX7cPVHNcADK8llE5YgCpwRtuR7O44RO9AerKWQu7w
	gCFboHErRiFJuxVpdisGA8AXtamZXxLEcWfACRtkosRrB3pFvBU035nLJNtnRPLWPuE=
X-Gm-Gg: ASbGncukl2ewNOiIkHBNQ3gcjY4WYPYUyw0qSQIN+Ap192repwfgORT07NitX13Zy8v
	IiuK7Qs4vb3SdvvTwmLQuICkF13wJxbWmthh25jf3WA3pvWfQNFK2dpbgVN/0Xug/Q6kseQDkq1
	22RmL542yNH5BeFav82loNweCyEvs0k24I12Iy4VINeZPL1t34E1I5AT0HIMWBYPUF1iHS/iTdi
	n3QwKLVTPvGlaUCwN30dNvfIOU+ApA3bQae+gC94+nT3HAQ7DcxDzp1xQhMtD/RLEoe/n47LaZg
	JGUb2yT2RBSnQnRJmJO8ZqZ1ELYbNWudxxmodUVMYMxMKaKmEk1g1VAfvVGskgGqMwFUXTynqGL
	CIXWzU7NdeSl28F82JvZS3l72tTEXozxs2B/Y9oDnDnEzs8wPL3Ha3iyaXa79bz6lm3SdOh54zT
	8xKETC6esIR9nxei2SJC9AqZnC2D+scMnXD2kM2oD01ZYwYzFzG6TYYK6Aoz/J2EwiSEq/yLI8O
	5ij02mD44hUkh3wKA==
X-Google-Smtp-Source: AGHT+IGI/EIGrRLkPj8rzsfCj3pDMuSgwzoEk1HrJ29SeDFeR3zb+JqUxgTtvkojs/XF2vGY3vUntw==
X-Received: by 2002:a05:6e02:152a:b0:42d:7dea:1e04 with SMTP id e9e14a558f8ab-430c529fb82mr83498185ab.25.1760740087442;
        Fri, 17 Oct 2025 15:28:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-430d071e820sm3947705ab.15.2025.10.17.15.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 15:28:06 -0700 (PDT)
Date: Fri, 17 Oct 2025 18:28:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/8] builtin/maintenance: introduce "geometric-repack"
 task
Message-ID: <aPLC9FIDR8Y3ayn+@nand.local>
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
 <20251016-pks-maintenance-geometric-strategy-v1-3-18943d474203@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251016-pks-maintenance-geometric-strategy-v1-3-18943d474203@pks.im>

On Thu, Oct 16, 2025 at 09:26:34AM +0200, Patrick Steinhardt wrote:
> Introduce a new "geometric-repack" task. This task uses our geometric
> repack infrastructure as provided by git-repack(1) itself, which is ab
> strategy that especially hosting providers tend to use to amortize the
> costs of repacking objects.
>
> There is one issue though with geometric repacks, namely that they
> unconditionally pack all loose objects, regardless of whether or not
> they are reachable. This is done because it means that we can completely
> skip the reachability step, which significantly speeds up the operation.
> But it has the big downside that we are unable to expire objects over
> time.
>
> To address this issue we thus use a split strategy in this new task:
> whenever a geometric repack would merge together all packs, we instead
> do an all-into-one repack. By default, these all-into-one repacks have
> cruft packs enabled, so unreachable objects would now be written into
> their own pack. Consequently, they won't be soaked up during geometric
> repacking anymore and can be expired with the next full repack, assuming
> that their expiry date has surpassed.

Well put. Geometric repacking today is really only what objects appear
in the packfiles, not whether those objects are reachable or not. That's
partially by design: geometric repack operations are meant to be as
lightweight and quick as possible, so performing a potentially expensive
reachability traversal defeats the purpose.

This mirrors what GitHub does today with their own repository
maintenance implementation. There is some number of geometric repack
operations interspersed between full repacks which collapse the
geometric progression and move unreachable objects out into cruft packs.

So I think that what you did here makes a ton of sense to me. Ultimately
I think there is a middle ground for geometric repacking (well outside
of the scope for this series ;-), don't worry) that could make it do a
little bit of both.

If 'git pack-objects --stdin-packs' (what ultimately implements the
portion of geometric repacking that combines packs together) knew the
current state of a repository's references, it could mark the objects in
the packs to be combined as either reachable or unreachable. Then in a
specialized mode, you could exclude any objects which are unreachable
from the resulting pack, and take a separate pass to write out a cruft
pack containing those objects before ultimately deleting the combined
packs.

I think that is all possible to do, and I think there is a way we could
do it relatively quickly without harming the performance of geometric
repacking. When traversing and marking objects, we can stop as soon as
we see an object that is not contained in the packs that that we're
combining.

So I don't think we have to do a whole-repository walk, which would
indeed defeat the purpose of geometric repacking. The above procedure
would cause us to write out small cruft packs, but we could use the
--combine-cruft-below-size option of 'git repack' to prevent too many
small cruft packs from accumulating together.

Anyway, nothing of that has anything to do with what you wrote here ;-).
It was mostly an excuse for me to write down some of these thoughts that
I've had in my head and alluded to briefly a couple of weeks ago at Git
Merge. Expect some actual patches in this direction from me in the not
too distant future :-).

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/config/maintenance.adoc |  11 +++
>  builtin/gc.c                          | 102 +++++++++++++++++++++++++
>  t/t7900-maintenance.sh                | 137 ++++++++++++++++++++++++++++++++++
>  3 files changed, 250 insertions(+)
>
> diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
> index 2f719342183..26dc5de423f 100644
> --- a/Documentation/config/maintenance.adoc
> +++ b/Documentation/config/maintenance.adoc
> @@ -75,6 +75,17 @@ maintenance.incremental-repack.auto::
>  	number of pack-files not in the multi-pack-index is at least the value
>  	of `maintenance.incremental-repack.auto`. The default value is 10.
>
> +maintenance.geometric-repack.auto::
> +	This integer config option controls how often the `geometric-repack`
> +	task should be run as part of `git maintenance run --auto`. If zero,
> +	then the `geometric-repack` task will not run with the `--auto`
> +	option. A negative value will force the task to run every time.
> +	Otherwise, a positive value implies the command should run either when
> +	there are packfiles that need to be merged together to retain the
> +	geometric progression, or when there are at least this many loose
> +	objects that would be written into a new packfile. The default value is
> +	100.
> +

OK. To make sure I understand: this limit is the minimum number of loose
objects would cause the geometric-repack task to run, unless there are
pack(s) which would be combined as a result of running a geometric
repack, in which case we run it regardless.

Is that right?

>  maintenance.reflog-expire.auto::
>  	This integer config option controls how often the `reflog-expire` task
>  	should be run as part of `git maintenance run --auto`. If zero, then
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 026d3a1d714..2c9ecd464d2 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -34,6 +34,7 @@
>  #include "pack-objects.h"
>  #include "path.h"
>  #include "reflog.h"
> +#include "repack.h"

Hey, neat ;-).

> @@ -1566,6 +1568,101 @@ static int maintenance_task_incremental_repack(struct maintenance_run_opts *opts
>  	return 0;
>  }
>
> +static int maintenance_task_geometric_repack(struct maintenance_run_opts *opts,
> +					     struct gc_config *cfg)
> +{
> +	struct pack_geometry geometry = {
> +		.split_factor = 2,

I wonder if this should be configurable somewhere. It might not be a bad
idea to introduce a 'repack.geometricSplitFactor' configuration
variable, defaulting to two, and use that here. It would also be nice to
be able to run 'git repack --geometric -d' and have it fallback to that
split factor, since using "2" is so common that it's frustrating when I
forget to type it out explicitly ;-).

> +	};
> +	struct pack_objects_args po_args = {
> +		.local = 1,
> +	};
> +	struct existing_packs existing_packs = EXISTING_PACKS_INIT;
> +	struct string_list kept_packs = STRING_LIST_INIT_DUP;
> +	struct child_process child = CHILD_PROCESS_INIT;
> +	int ret;
> +
> +	existing_packs.repo = the_repository;
> +	existing_packs_collect(&existing_packs, &kept_packs);
> +	pack_geometry_init(&geometry, &existing_packs, &po_args);
> +	pack_geometry_split(&geometry);
> +
> +	child.git_cmd = 1;
> +
> +	strvec_pushl(&child.args, "repack", "-d", "-l", NULL);
> +	if (geometry.split < geometry.pack_nr)
> +		strvec_push(&child.args, "--geometric=2");
> +	else
> +		add_repack_all_option(cfg, NULL, &child.args);

Makes sense; if we're not merging any packs, we do an all-into-one
repack, otherwise we do a geometric one. Looks like the function
geometric_repack_auto_condition() below controls whether or not we even
take this path, which makes sense relative to the documentation you
wrote above.

> +static int geometric_repack_auto_condition(struct gc_config *cfg UNUSED)
> +{
> +	struct pack_geometry geometry = {
> +		.split_factor = 2,
> +	};
> +	struct pack_objects_args po_args = {
> +		.local = 1,
> +	};
> +	struct existing_packs existing_packs = EXISTING_PACKS_INIT;
> +	struct string_list kept_packs = STRING_LIST_INIT_DUP;
> +	int auto_value = 100;
> +	int ret;
> +
> +	repo_config_get_int(the_repository, "maintenance.geometric-repack.auto",
> +			    &auto_value);
> +	if (!auto_value)
> +		return 0;
> +	if (auto_value < 0)
> +		return 1;
> +
> +	existing_packs.repo = the_repository;
> +	existing_packs_collect(&existing_packs, &kept_packs);
> +	pack_geometry_init(&geometry, &existing_packs, &po_args);
> +	pack_geometry_split(&geometry);
> +
> +	/*
> +	 * When we'd merge at least two packs with one another we always
> +	 * perform the repack.
> +	 */
> +	if (geometry.split) {
> +		ret = 1;
> +		goto out;
> +	}

Hmm. I wish that we could somehow pass this information to the function
above so that we don't have to re-discover the fact that there are packs
to combine. I'm not familiar enough with the maintenance code to know
how difficult that would be to do, but it looks like at least the
gc_config pointer is shared between the auto condition and the task
itself.

That's kind of gross to tack on there, but I could see a compelling
argument for passing around an extra void pointer between the two that
would allow us to propagate this kind of data between the auto condition
and the task itself. It's not super expensive to do so I don't think not
doing it is a show-stopper at least from a performance perspective, but
it does seem like a good opportunity to DRY things up a bit.

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index ddd273d8dc2..83a373fe94b 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -465,6 +465,143 @@ test_expect_success 'maintenance.incremental-repack.auto (when config is unset)'
>  	)
>  '
>
> +run_and_verify_geometric_pack () {
> +	EXPECTED_PACKS="$1" &&
> +
> +	# Verify that we perform a geometric repack.
> +	rm -f "trace2.txt" &&
> +	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
> +		git maintenance run --task=geometric-repack 2>/dev/null &&
> +	test_subcommand git repack -d -l --geometric=2 --quiet --write-midx <trace2.txt &&

Makes sense. I do think the test_subcommand thing is a little fragile
here, but verifying that the resulting pack structure forms a geometric
progression feels like overkill for this test, so I think what you wrote
here makes sense.

As an aside, would you mind wrapping these lines instead of putting the
command-line invocation all together on a single line?

> +
> +	# Verify that the number of packfiles matches our expectation.
> +	ls -l .git/objects/pack/*.pack >packfiles &&
> +	test_line_count = "$EXPECTED_PACKS" packfiles &&
> +
> +	# And verify that there are no loose objects anymore.
> +	cat >expect <<-\EOF &&
> +	info
> +	pack
> +	EOF
> +	ls .git/objects >actual &&

I wonder if there is an easier way to check for loose objects here that
doesn't require you to know that the "info" and "pack" directories
exist. Perhaps something like:

test_stdout_line_count = 0 find .git/objects/?? -type f

, or even

    find .git/objects/?? -type f >loose.objs &&
    test_must_be_empty loose.objs

> +test_expect_success 'geometric repacking task' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		git config set maintenance.auto false &&
> +		test_commit initial &&
> +
> +		# The initial repack causes an all-into-one repack.
> +		GIT_TRACE2_EVENT="$(pwd)/initial-repack.txt" \
> +			git maintenance run --task=geometric-repack 2>/dev/null &&
> +		test_subcommand git repack -d -l --cruft --cruft-expiration=2.weeks.ago --quiet --write-midx <initial-repack.txt &&
> +
> +		# Repacking should now cause a no-op geometric repack because
> +		# no packfiles need to be combined.
> +		ls -l .git/objects/pack >before &&
> +		run_and_verify_geometric_pack 1 &&
> +		ls -l .git/objects/pack >after &&
> +		test_cmp before after &&
> +
> +		# This incremental change creates a new packfile that only
> +		# soaks up loose objects. The packfiles are not getting merged
> +		# at this point.
> +		test_commit loose &&
> +		run_and_verify_geometric_pack 2 &&

I wonder if you want to harden this test a little bit to ensure that the
there is only one new pack being created here, and we're not seeing
e.g., the removal of the existing pack and creation of two new packs.

I dunno, that may be overkill for this test, and I certainly don't feel
strongly about it.

> +
> +		# Both packfiles have 3 objects, so the next run would cause us
> +		# to merge both packfiles together. This should be turned into

Perhaps s/both/all/ ? What you wrote is not wrong, of course, but I
think "all" more clearly communicates that we are only doing an
all-into-one because the geometric repack would have combined everything
together anyway.

The rest of the changes look good to me.

Thanks,
Taylor
