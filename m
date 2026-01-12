Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AE42D47E3
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222953; cv=none; b=M4A2WbV+g+cSksRQ973UshcaaL3lmNKPhrfsV01lU389IxxnFEl7fz8VonxeOosB4Iec0c8FNz9ByUf98PQ95lnFOnU3AapCwbMHfGajJ0a7E7kZ0mGiKReFy/2jdugESNcoDDwfhK517zzzHBJVojjZQqMWg9HuQECTsWHTHBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222953; c=relaxed/simple;
	bh=hPGKTg86hbYKLSINDbD++7EjaIAJGysTz2uhti3l4As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3gvvxW8E4/5vNv76Eyd2gFLVyzZTre0K5L1txBeIY4jgCP/YMehNSzbVzEJVmtzzz0v73OL3iQuAwbv67w8lDGTtU7FfWqlnbHocV3IlP5vmDgQZNpWTCQKl38H7l0dMdYosilTNfKI3AHNXkkjpVvmpEatWo3tVK6qObykxOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PK4rB0Tt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s7+RG6JP; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PK4rB0Tt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s7+RG6JP"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 993F9EC00E7;
	Mon, 12 Jan 2026 08:02:30 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 12 Jan 2026 08:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768222950;
	 x=1768309350; bh=snYZ4jEjpliX7Lw7rppfUC3BAIztCv7xwE6TR6qs+CA=; b=
	PK4rB0TtR/AN8r87Hh7tav9JyNJ1aj2t9UpbUm5UFreLjEVJY/A9RN5BvWpl776R
	FTYzRPauxBDp7JvyuVHss6KJLHGx5B1SiTDhhcF/+hrTuCb6ZVf+oEm3pu3TSwSe
	LZ8e+J6XE1v0/CPty+8v38l31hAQnrzayo+5fhibV7A5euphkdPshjRwhdnO/bPf
	wir1kpkn/yE44JmKuKfS6qEjUQd92bskF9HZMDfuqZvRgzLnQMVbJ03qorFGZ6vE
	vqmDxS4vlGIe3h7JFsT03gr9Mn0gEkP7+xlnOaIjRmbaoCltrsX3bJGQT3AvJzvL
	dbq4nIBa8bEFUxt6UQ/kyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768222950; x=
	1768309350; bh=snYZ4jEjpliX7Lw7rppfUC3BAIztCv7xwE6TR6qs+CA=; b=s
	7+RG6JPbvxrNSeeIthZ87LmaqUFb/isacc8qEtlmrT9hvKfUph49dbB95h0ybtJd
	AvHzWDfmCcKYv5e6v51XKd09sq149vmip3EWUaQqHUrhiugN/X6iS6m3VWRXUzvv
	0sWdB+/Fb7MzcRfaHSReqelCezPU8kuCiHbBRDyO064Wwxp/N5eISsLbVB5Bs8WC
	EqDWrC6uUFvVq2PMbioxCjSaIZ3VCJb+3Rd43p26bZkxQdQqeXZvAAcNjoKhwoAN
	lNy0UY8KX6ufill61j2sz7c1+4BsJVmIW3lIQJVc3RB4UzvIzhbcvI171c4G0GlC
	Z0iHSSXRr8cINXloL1O9w==
X-ME-Sender: <xms:5vBkaUuxFR6xWhBu840BUvV5zK6ekZKtQb9-yt_4nHN32RuJJ2bcxQ>
    <xme:5vBkadRJ24Rbp_h0xE8WQhNrtLUms8uoUgy5SAK4VoSIAMO900azsOnbwQfpkQCWs
    JVT9wkz_w5UXNOaW_RBLVNfCSu-5gsgch5x-OY9IUfYlHwd4uD9lQ>
X-ME-Received: <xmr:5vBkabIgdEVdKhDDnZTiAnv2WooW2MqkWUZJK5tb9vrwJiholq2UptHOecNLvBbosvS18xuMC9NM4Yq-yb94efdxx9Mtde8b4FGbA5KVaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsiigvug
    gvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeek
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpd
    hrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:5vBkaQsVmJp9wzJFmDMZ6VoSMokQs0NePqmmd1WF_QzMinoMJzEqRg>
    <xmx:5vBkaS9uV6zXwSuAYhGaba1mXzfpf0UfZU3rAqT4NbgwS6rVSQ02uA>
    <xmx:5vBkaa31im7ss_-BQS0o4K9qoZM2cWMJEMN0QJbY93WBjvAemYlXOA>
    <xmx:5vBkaXgW-TT74u0Tp97DEL63-cnyIGIS7PUQDznNG8rDK6flgTUBSQ>
    <xmx:5vBkaVtdnwVyFc3EK4mJ1l2nO_1_2NvDCbB8ukq4QM-KYT6FlokrJeWC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 08:02:28 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c68db48e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 13:02:27 +0000 (UTC)
Date: Mon, 12 Jan 2026 14:02:25 +0100
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
Subject: Re: [PATCH v9 2/7] builtin/replay: move core logic into "libgit.a"
Message-ID: <aWTw4ezgeloLB0R2@pks.im>
References: <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im>
 <20260109-b4-pks-history-builtin-v9-2-8766101814c6@pks.im>
 <CABPp-BEo5jGBgJBkCdu_GHstsbEm4mCpKO3NWvNfcjDVC+SbLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BEo5jGBgJBkCdu_GHstsbEm4mCpKO3NWvNfcjDVC+SbLQ@mail.gmail.com>

On Fri, Jan 09, 2026 at 05:16:41PM -0800, Elijah Newren wrote:
> On Fri, Jan 9, 2026 at 12:35 AM Patrick Steinhardt <ps@pks.im> wrote:
> > diff --git a/replay.c b/replay.c
> > new file mode 100644
> > index 0000000000..fc7186ef09
> > --- /dev/null
> > +++ b/replay.c
> > @@ -0,0 +1,355 @@
> > +#define USE_THE_REPOSITORY_VARIABLE
> > +#define DISABLE_SIGN_COMPARE_WARNINGS
> > +
> > +#include "git-compat-util.h"
> > +#include "environment.h"
> > +#include "hex.h"
> > +#include "merge-ort.h"
> > +#include "object-name.h"
> > +#include "oidset.h"
> 
> I don't think oidset is used here?   Although, come to think of it,
> I'm not sure it was used in replay to begin with.  Looks like I added
> this include during the switch from t/helper/test-fast-rebase, but
> never used it even then.  I must have thought I was going to use it,
> and added it, but never did.  Anyway, maybe this is a good time to get
> rid of it?

Yeah, let's.

> > +#include "parse-options.h"
> 
> Why would parse-options be included here?  Oh,
> die_for_incompatible_opt2()?  Feels a little weird that we have option
> parsing logic outside of builtin/, but...maybe it's all fine?

I'm not a huge fan of it, either. We could for example change this so
that we `BUG()` here and instead have the option in "builtin/replay.c"?
Something like this:

diff --git a/builtin/replay.c b/builtin/replay.c
index 4a11ef0f1b..649c93200e 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -177,8 +177,9 @@ static void set_up_replay_mode(struct repository *repo,
 	if (!rinfo.positive_refexprs)
 		die(_("need some commits to replay"));
 
-	die_for_incompatible_opt2(!!onto_name, "--onto",
-				  !!*advance_name, "--advance");
+	if (!(!!onto_name ^ !!*advance_name))
+		BUG("expected either onto_name or *advance_name in this function");
+
 	if (onto_name) {
 		*onto = peel_committish(repo, onto_name, "--onto");
 		if (rinfo.positive_refexprs <
@@ -191,9 +192,6 @@ static void set_up_replay_mode(struct repository *repo,
 		struct object_id oid;
 		char *fullname = NULL;
 
-		if (!*advance_name)
-			BUG("expected either onto_name or *advance_name in this function");
-
 		if (repo_dwim_ref(repo, *advance_name, strlen(*advance_name),
 			     &oid, &fullname, 0) == 1) {
 			free(*advance_name);
@@ -478,6 +476,8 @@ int cmd_replay(int argc,
 
 	die_for_incompatible_opt2(!!opts.advance, "--advance",
 				  opts.contained, "--contained");
+	die_for_incompatible_opt2(!!opts.advance, "--advance",
+				  !!opts.onto, "--onto");
 
 	/* Parse ref action mode from command line or config */
 	ref_mode = get_ref_action_mode(repo, ref_action);

Yeha, I think that's cleaner, even if it repeats some of the
conditionals.

> > +#include "refs.h"
> > +#include "replay.h"
> > +#include "revision.h"
> 
> Shouldn't strmap.h (for strset) also be included?  I think we get it
> as a side-effect of something else, but since we use it directly, it'd
> make sense to include directly.

Yup, will add.

> > diff --git a/replay.h b/replay.h
> > new file mode 100644
> > index 0000000000..84bc8a7a5b
> > --- /dev/null
> > +++ b/replay.h
> > @@ -0,0 +1,64 @@
> > +#ifndef REPLAY_H
> > +#define REPLAY_H
> > +
> > +#include "hash.h"
> > +
> > +struct repository;
> > +struct rev_info;
> > +
> > +/*
> > + * A set of options that can be passed to `replay_revisions()`.
> > + */
> > +struct replay_revisions_options {
> > +       /*
> > +        * Starting point at which to create the new commits; must be a branch
> > +        * name. The branch will be updated to point to the rewritten commits.
> > +        * This option is mutually exclusive with `onto`.
> > +        */
> > +       const char *advance;
> > +
> > +       /*
> > +        * Starting point at which to create the new commits; must be a
> > +        * committish. References pointing at decendants of `onto` will be
> > +        * updated to point to the new commits.
> > +        */
> > +        const char *onto;
> > +
> > +       /*
> > +        * Update branches that point at commits in the given revision range.
> > +        * Requires `onto` to be set.
> > +        */
> > +       int contained;
> > +};
> > +
> > +/* This struct is used as an out-parameter by `replay_revisions()`. */
> > +struct replay_result {
> > +       /*
> > +        * The set of reference updates that are caused by replaying the
> > +        * commits.
> > +        */
> > +       struct replay_ref_update {
> > +               char *refname;
> > +               struct object_id old_oid;
> > +               struct object_id new_oid;
> > +       } *updates;
> > +       size_t updates_nr, updates_alloc;
> > +
> > +       /* Set to true in case the replay failed with a merge conflict. */
> > +       bool merge_conflict;
> > +};
> > +
> > +void replay_result_release(struct replay_result *result);
> > +
> > +/*
> > + * Replay a set of commits onto a new location. Leaves both the working tree,
> > + * index and references untouched. Reference updates caused by the replay will
> > + * be recorded in the `updates` out pointer.
> > + *
> > + * Returns 0 on success, a negative error code otherwise.
> > + */
> > +int replay_revisions(struct repository *repo, struct rev_info *revs,
> > +                    struct replay_revisions_options *opts,
> > +                    struct replay_result *out);
> > +
> 
> stray extra line?

We typically have an empty line between the last declaration and the
`#endif` in our headers.

> > +#endif
> 
> It feels duplicative to have replay_result include a merge_conflict
> field and to have replay_revisions() return an int which signifies
> whether there's a conflict.  Can we remove one of the two?  (Perhaps
> the merge_conflict field was only a workaround to the weird ret
> setting from the previous patch?)

The idea here is that we have a generic error code that tells the caller
that _something_ happened, whereas `struct replay_result` gives the
caller a bit more context around what exactly has happened. This allows
callers to handle merge conflicts differently from any other error and
makes the different failure modes a lot more explicit.

Some context: at GitLab we actually have the use case to surface more
information around what commits have conflicted, so there will be a
follow-up patch series that extends `struct replay_result` to return
more information about the actual conflict. I'm already planning ahead a
bit in this patch series.

Patrick
