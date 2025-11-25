Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B3A334687
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 19:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098587; cv=none; b=bsd1gVCfhdhQoUaIMbzgtwn5FWxJAG/2/RLeOYWFBC9nVkdevrvE4Y5T7VY0E3dgPdhlI3+JJhqwYkNo+P66b/1LLs1zaVXkgE3lsuUnr0G4mVsvdmvxdjEMudGOdM0mdnpwGusuJZ0/Wbu8xbrNgDzdlZP6kWojjiQWqQ/vKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098587; c=relaxed/simple;
	bh=jrmw6fmfgZBP7ed4DRyVWv+/D2HUPco1Tvaf0fbda6U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WTMgT1vDH/YUOXJVyB3hc/jRnURxoNzxcfBUBlUdQClDV2DdEHdadsZxPefkcZ8ZryTISMlj5Sl2WmlI8NHkhN9DTJ7x9OcbUoWzEleShSNU/gZG6OFzgetZv5hEjN240OS2gltBNLVhG0e55ZlS5Ge40wcT4XmC8YyLCeqxNBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UVU+UjZC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OTpatUfl; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UVU+UjZC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OTpatUfl"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7F87514001B2;
	Tue, 25 Nov 2025 14:23:00 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 25 Nov 2025 14:23:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1764098580;
	 x=1764184980; bh=jY+9pRI1LsfCDN6lU6Rw1xXC1mH5czDHoxy9iKiKPto=; b=
	UVU+UjZCD8LzSLQAlOp0pPzuqf6J9xSjuGawchlBd9NlxN9gyR7PSNhwFRuuHbEz
	cjckxHtJGBEJK7h/1u9Uou2q1uiTpz447No4rJUprq3RtUCrhdGtPib+7AuDCslX
	XJDewqXl3s+BRZWy2SDsR1p6Gl6k6qvR/J/8HpDD8GSDqPcgBT/mkJGvkJaWqKFi
	6BqPNR9Wgl3jyPcEjUqMBXdxaIWHcY7FKCVCfcDn9SXXy9Rwasd1AHHqNbSKxFg3
	HeGcoiXutU23pAD2YO97wdAmHgHJlPvkrk+lIu9wwFSHhtL2oLYJ92pKLqwMalJf
	xsA+inlgOhrhnqCNj4PXLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764098580; x=
	1764184980; bh=jY+9pRI1LsfCDN6lU6Rw1xXC1mH5czDHoxy9iKiKPto=; b=O
	TpatUfl94AEF8ExOMU12rzqT82X25RypAVg5jjSJPMrlF4nrofRSUlul7inQvMrl
	uB2KcnRuJFxCTqlUH8nmaQ1kbu5NsNrzIvAJAj6FkpHV1+qz7BLR7kIP/SGdgzrW
	wOkIUG7lCwGiaPNKq7qSgS72AwPy2/H0MZePKe/0fwIyTZhkm8JExFYYPusdH66o
	uNIYhwPCrnyABTY2qbXytrFu0jk2R+nOnj3gnG1edHwM9JAPsbeXU4+L0+4QgHRm
	xctFaiBPmswWHyxmzLkLOWB/GRUMTcghAGUvhCWmz63lK8DkSNkxEsZKZmMx9Q2c
	IdNa7R3Y1NexjR63xw2+g==
X-ME-Sender: <xms:EwImaUDNruPg47WT0cr0R_nptCrdSjcbqqVlUMEN2IQR7K_0S_R66w>
    <xme:EwImaQ75CTwfb1yEvLOuYTLdggcW4pt5iaFYTA2356Y632-BbUoFY0cZhF_j5LL-B
    88E3qkC16ZEnV-hxypn_VSEzKmtG4Bg535bGqMsctp9dfyiU6BZbg>
X-ME-Received: <xmr:EwImads-sO8Ed99kLGeUeIzwgI1A1zAywJRLrVSR-2nB_2cmRBvHB7kCC4r5SuMc150lqQsyFaJYXtc9CmFDvkvHnNN6_PWlX5_o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedvfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduhedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfeduse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhg
    rdhukhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:EwImaV6pzl2ZyOzysQxyW7PgXXSUe2vlcWXNFvFtxKLkxWnZ3CsRMA>
    <xmx:EwImaR2W-9cu8mrLH_YCbD8Ld21B1NzN3EYYwLo3zGLid_iamwadAg>
    <xmx:EwImaYhrY7ttlVLZlT_kWbaHs273C-r_EiNUASy0QHHRQAHiFzF2-A>
    <xmx:EwImaRppNI5J3SeZBm0etogm2aGQIHT6cN8LibCeuqOtNo3cX45lEg>
    <xmx:FAImaV_jGFYPTDkIjOQUUzp_0PaXHF4Ru4CzFb1TT19WYbXho4LJKayx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Nov 2025 14:22:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  newren@gmail.com,  phillip.wood123@gmail.com,
  phillip.wood@dunelm.org.uk,  karthik.188@gmail.com,
  code@khaugsbakk.name,  rybak.a.v@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com,  johannes.schindelin@gmx.de
Subject: Re: [PATCH 1/1] replay: add --revert option to reverse commit changes
In-Reply-To: <20251125170056.34489-2-siddharthasthana31@gmail.com> (Siddharth
	Asthana's message of "Tue, 25 Nov 2025 22:30:56 +0530")
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
	<20251125170056.34489-2-siddharthasthana31@gmail.com>
Date: Tue, 25 Nov 2025 11:22:57 -0800
Message-ID: <xmqqwm3drk6m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> The revert message generation logic (handling "Revert" and "Reapply"
> cases) is extracted into a new `sequencer_format_revert_header()`
> function in `sequencer.c`, which can be shared between `sequencer.c`
> and `builtin/replay.c`. The `builtin/replay.c` code calls this shared
> function and then appends the commit OID using `oid_to_hex()` directly,
> since git replay is designed for simpler server-side operations without
> the interactive features and `replay_opts` framework used by
> `sequencer.c`.

When I review a patch that claims to refactor existing logic into a
separate helper function to reuse it in more places, I look at the
diffstat to see how many lines are removed.  The logic for
generating the message does not seem to be "extracted into", but
rather "duplicated to", the new helper function.  It gives the two
message sources opportunity to drift apart over time, which is not
what you want.

In do_pick_commit() where TODO_REVERT command is handled, we find a
code block that is almost identical to what this patch adds to the
new helper function; it should be rewritten to call the new helper
function or perhaps a shared helper function is introduced and
called from there and also from the sequencer_format_revert_header()
function, if there is still some impedance mismatch.  If such a
refactoring is done as a separate preliminary patch in a N-patch
series, the resulting patch series may be easier to follow (and
there may be other opportunities to reuse existing code more).

> Mark the option as incompatible with `--contained` since reverting
> changes across multiple branches simultaneously could lead to
> inconsistent repository states.

This, and the documentation part, does not seem to tell what
"inconsistent state" we are worried about.  Is it just a buggy
design of --revert can be implemented that produces wrong result
when used with --contened, or are these two options inherently try
to achieve contradicting goals?  I am guessing that it is the
latter, but if so, can we make it clear why?

> +--revert::
> +	Revert the changes introduced by the commits in the revision range
> +	instead of applying them. This reverses the diff direction and creates
> +	new commits that undo the changes, similar to `git revert`.
> ++
> +The commit messages are prefixed with "Revert" and include the original
> +commit SHA. If reverting a commit whose message starts with "Revert", the new
> +message will start with "Reapply" instead. The author of the new commits
> +will be the current user, not the original commit author.
> ++
> +This option is incompatible with `--contained`.

I have never used the `--contained` option, but is it so obvious to
those who have why these two have to be made incompatible that the
above statement does not have to be followed by "because ..."?

> @@ -141,6 +153,27 @@ all commits they have since `base`, playing them on top of
>  `origin/main`. These three branches may have commits on top of `base`
>  that they have in common, but that does not need to be the case.
>  
> +To revert a range of commits:
> +
> +------------
> +$ git replay --revert --onto main feature~3..feature
> +------------
> +
> +This creates new commits on top of 'main' that reverse the changes introduced
> +by the last three commits on 'feature'. The 'feature' branch is updated to
> +point at the last of these revert commits. The 'main' branch is not updated
> +in this case.

Is there any topological requirement between 'main' and 'feature'
branches?  Naïvely, I would expect that it would be perfect if
'feature' branch has been merged to 'main' (then you'd be reverting
the top 3 commits of that branch), but that would be something you
would do to correct 'main', and not 'feature', but the description
explains this is a way to update 'feature' to lose the three topmost
commits, so I am not sure what this example really does and when it
would be useful.

> +To revert commits and advance a branch:
> +
> +------------
> +$ git replay --revert --advance main feature~2..feature
> +------------
> +
> +This reverts the last two commits from 'feature', applies those reverts
> +on top of 'main', and updates 'main' to point at the result. The 'feature'
> +branch is not updated in this case.

The same question.  If I assume that 'main' has merged 'feature'
before, this I can understand and match what I often do quite well
while working on integrating topic branches.  I may merge a topic
that is not yet well cooked enough into 'next', regret that the two
commits at the tip of the topic were premature, and revert these two
commits out of 'next', or something.  This example can be explained
well if there is topological requirement that 'main' has at least
these two commits from 'feature'.

> @@ -261,7 +286,8 @@ static struct commit *pick_regular_commit(struct repository *repo,
>  					  kh_oid_map_t *replayed_commits,
>  					  struct commit *onto,
>  					  struct merge_options *merge_opt,
> -					  struct merge_result *result)
> +					  struct merge_result *result,
> +					  int is_revert)

Are there other ways to pick commit imaginable (if not planned to be
implemented), other than "revert"?  I am wondering if this is better
done as "enum { CHERRY_PICK, REVERT, } pick_variant" for readability
and maintainability.

> @@ -273,21 +299,41 @@ static struct commit *pick_regular_commit(struct repository *repo,
>  	pickme_tree = repo_get_commit_tree(repo, pickme);
>  	base_tree = repo_get_commit_tree(repo, base);
>  
> -	merge_opt->branch1 = short_commit_name(repo, replayed_base);
> -	merge_opt->branch2 = short_commit_name(repo, pickme);
> -	merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
> +	if (is_revert) {

It may be just me, but it would have been easier to follow if
!revert case is given first, as that is the common variant the
pick_regular_commit() function.

> +		/* For revert: swap base and pickme to reverse the diff */
> +		merge_opt->branch1 = short_commit_name(repo, replayed_base);
> +		merge_opt->branch2 = xstrfmt("parent of %s", short_commit_name(repo, pickme));

That is an overly long line (sorry, I notice these things when a
line does not even fit in 92-col terminal).

> +		merge_opt->ancestor = short_commit_name(repo, pickme);

> -	merge_incore_nonrecursive(merge_opt,
> -				  base_tree,
> -				  result->tree,
> -				  pickme_tree,
> -				  result);
> +		merge_incore_nonrecursive(merge_opt,
> +					  pickme_tree,
> +					  result->tree,
> +					  base_tree,
> +					  result);

OK.  These are applications of the standard 3-way merge trick to
(ab)use ancestor to implement cherry-pick and revert.  Looking good.

> +
> +		/* branch2 was allocated with xstrfmt, needs freeing */
> +		free((char *)merge_opt->branch2);
> +	} else {
> +		/* For cherry-pick: normal order */
> +		merge_opt->branch1 = short_commit_name(repo, replayed_base);
> +		merge_opt->branch2 = short_commit_name(repo, pickme);
> +		merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
> +
> +		merge_incore_nonrecursive(merge_opt,
> +					  base_tree,
> +					  result->tree,
> +					  pickme_tree,
> +					  result);
> +
> +		/* ancestor was allocated with xstrfmt, needs freeing */
> +		free((char *)merge_opt->ancestor);

And the "else" block has the original sequence of statements.

> +	}
>  
> -	free((char*)merge_opt->ancestor);
>  	merge_opt->ancestor = NULL;
> +	merge_opt->branch2 = NULL;

Not a new problem, but what is the point of setting these two (but
not branch1) to NULL?  If a later caller misuses ->ancestor left
behind without setting its own, it would result in an access after
free, but if such a caller misuses ->branch1 left behind without
setting its own, because it is not allocated, it won't be an access
after free, *but* it is nevertheless wrong as the string in ->branch1
is *not* computed suitably for that caller, isn't it?

>  	if (!result->clean)
>  		return NULL;
> -	return create_commit(repo, result->tree, pickme, replayed_base);
> +	return create_commit(repo, result->tree, pickme, replayed_base, is_revert);
>  }


> @@ -350,6 +396,7 @@ int cmd_replay(int argc,
>  	int contained = 0;
>  	const char *ref_action = NULL;
>  	enum ref_action_mode ref_mode;
> +	int is_revert = 0;

Ditto on "revert,cherry-pick".

> diff --git a/sequencer.c b/sequencer.c
> index 5476d39ba9..e6d82c8368 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5572,6 +5572,29 @@ int sequencer_pick_revisions(struct repository *r,
>  	return res;
>  }
>  
> +void sequencer_format_revert_header(struct strbuf *out, const char *orig_subject)
> +{
> +	const char *revert_subject;
> +
> +	if (skip_prefix(orig_subject, "Revert \"", &revert_subject) &&
> +	    /*
> +	     * We don't touch pre-existing repeated reverts, because
> +	     * theoretically these can be nested arbitrarily deeply,
> +	     * thus requiring excessive complexity to deal with.
> +	     */
> +	    !starts_with(revert_subject, "Revert \"")) {
> +		strbuf_addstr(out, "Reapply \"");
> +		strbuf_addstr(out, revert_subject);
> +		strbuf_addch(out, '\n');
> +	} else {
> +		strbuf_addstr(out, "Revert \"");
> +		strbuf_addstr(out, orig_subject);
> +		strbuf_addstr(out, "\"\n");
> +	}
> +
> +	strbuf_addstr(out, "\nThis reverts commit ");
> +}
> +

Dedup with do_pick_commit() where this was taken from.  Possibly in
a separte patch before the main one.

