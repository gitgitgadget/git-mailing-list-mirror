Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5FA139D1B
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727464819; cv=none; b=LE/4xYG0gQNEiItBL09RxfHFsMOrf4LL3qjpDQKsCurZ++Cpi/TnXlxx+MsfvjmZTUqifEN98RNUwo60BlopJ/1cTHXD4oBdcWoosFjU5VumFzMMGAgble6ZSDJwbnQYyuaCYDTt67+CWYXyn2gDaT1VCjFrJHLZFLVveEq+G6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727464819; c=relaxed/simple;
	bh=CtQHBqGRwP/aKGNlq+t5SpDIWMM8KLfcGp3lzKI1J8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rQmTzFdXdgkGfGP3XHax9x/rzkyDYYtKMdWso0BfpfmyCTlDvVrjZg6kdgs5fGpkLTWs6KOd3Didyp7V8jAzWLRrb6AcKaNWZqVcnZHmRSWsZ2804nt1aIo9Gan3s9UYQfS45RJSkWLIqRJ2diL3tK8TFTFkbIDZRVrPFie5nQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Kznk3jJ2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O8PVokkz; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kznk3jJ2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O8PVokkz"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 53A6413801BB;
	Fri, 27 Sep 2024 15:20:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 27 Sep 2024 15:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727464816; x=1727551216; bh=Si3+UbELiY
	+54HlXT3HKi/L6B/J+npgUKC4WQoF/VTc=; b=Kznk3jJ2NeCEcxXyI9ekDZDFIO
	kyn0qzPSQ9sWXzlKlcuuJ4eFf8m9K4VJnstdq06WVXYeHkm1Cf8A7T/JGfNOMt5N
	WoEJplrN6ox28q4rEtOY26zPEWLBo2WMf+DLNYercOkSZXwg7EpPj7wQpKL1CNRX
	iN5IO1BYJmz3/SLo60eYXoyJmTs0y1hERt3upBWjXqkhWEeoVVrvK/6a/it7jJjt
	0w0mShsSZOLiJYDnGAXAQJgf9YzoNOnvnQWacZ28kBKWcH1kYVW9kVmDj1rMjvsB
	7tiGQoHCu1xg5IL+exgkQdnoG10trlx/kBuBiESjhPfcL2wp0VHlA54EKVvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727464816; x=1727551216; bh=Si3+UbELiY+54HlXT3HKi/L6B/J+
	npgUKC4WQoF/VTc=; b=O8PVokkzALVjn/ftgwo/FHmhggcTqtHKGYT1BftlTFV5
	IWIsBO1Iv7//oBHyCyzmiD07nnl/Og4GyS7YpAtOKqxwhPCvO/aqIUYGAAAej4bn
	zyXaSsIePWcuAjan00qTdh0Qsr0iGLNoJnp3gNOMnl4fHNVSIMu/FgjMIdoY0yk2
	WDJ5UhrduKhicLf5AThXnCQRXFSJ2/sCpI0cY0srE7rEEwRQyBX4JXS2SUW0PTXB
	fH739tWNyCMRm8TPAlVGIOib7wWGunp7HugV4q/oiWWYWS5GxoeFNc4CQ5bZgm/q
	IZKdd2VxMIyPPXqTHTLnHLYJGJTZLg3IJwH21/1UfA==
X-ME-Sender: <xms:bwX3ZuBJ8HYxj7RWxotTfAsBuW-T_U9rlyPO9QMwh7yPSXGWHheCrg>
    <xme:bwX3ZojQJCljzyoGdR1V_ImpaAX7LdQLe87GpKqf2W1Q2z7afTvqdLfwW_Rn6FORX
    Rk_oWQ80XqB3KscOg>
X-ME-Received: <xmr:bwX3ZhlSx7xO1MoPtXKLmngzVd6KQSkK6W416gdz_kb0pEWc29fDgbs09stkrI_Rq_TRV5MbCdQ8u6O5dcUf0ZP7RKNSidIQKYHSlDE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtledgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhoth
    gtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bwX3ZszWjxZzBsoAHVpnUJgkp6B5eAhJaGiIIQ632Iytbj4nPbnpcQ>
    <xmx:bwX3ZjSBjf5jciuClzSDZlesatl_mdBUpiGF48Sx6mHpIKeJ4GWayg>
    <xmx:bwX3ZnZXKzl-gW8R5bfGaqS2VtQSnBNGka9ZC4NsoS2w6NWgWhg07g>
    <xmx:bwX3ZsTSba-9Q54CbJ9hJhR6SvXx8aj6bW8Nu36CPMDV1-oYzblkNg>
    <xmx:cAX3Ztf1nh2t_5kxImzWOMNrHEm3wTmzdAC3VlHsg1MKIGvgVPcOAFbj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Sep 2024 15:20:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] builtin/clone: teach git-clone(1) the --ref= argument
In-Reply-To: <20240927085438.1010431-1-toon@iotcl.com> (Toon Claes's message
	of "Fri, 27 Sep 2024 10:54:38 +0200")
References: <20240927085438.1010431-1-toon@iotcl.com>
Date: Fri, 27 Sep 2024 12:20:14 -0700
Message-ID: <xmqqikuggaz5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Add option `--ref` to git-clone(1). This enables the user to clone and
> checkout the given named reference.

Define "checkout the reference".  A ref that is outside of
"refs/heads/" MUST NOT be pointed by HEAD, so giving a tag with this
option should result in an initial working tree on a detached HEAD.

If it is what the new option does (which is similar to the way how
we handle a tag when it was given with --branch), we should be more
explicit that the ref is *not* checked out, but a deteached HEAD is
created to point at the commit referenced.  I think the documentation
part of this patch does a much better job at it.

> It's pretty similar to --branch and
> while --branch takes a branch name or tag name, it doesn't take a fully
> qualified reference. This allows the user to clone a reference that
> doesn't start with refs/heads or refs/tags. This can be useful when the
> server uses custom references.

"when the server uses custom references" is a rather weak
explanation.

The answer to "Doctor, it hurts when I turn my elbow in this
unnatural direction" is usually "Well, do not do it then".  The
answer to "Doctor, I cannot use the --branch option because I use
non branches to keep track of some histories" should be the same.
Why do you want to turn your elbow in an unnatural angle in the
first place?

Stepping one level higher.

The usual way to compose a log message of this project is to

 - Give an observation on how the current system work in the present
   tense (so no need to say "Currently X is Y", just "X is Y"), and
   discuss what you perceive as a problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to the codebase to "become like so".

in this order.  The first paragraph that describes what the commit
wants to do is better moved down to the last.  Justify why you want
to turn your elbow in a way other people do not usually do (or why
you want unusual hierarchies on the server side), explain that it
hurts (or say --branches is limited to branches and tags), and then
finally give a solution.

> +`--ref` _<name>_::
> +	This detaches HEAD and makes it point to the commit where the _<name>_
> +	reference is pointing to. In a non-bare repository, this is the ref that
> +	will be checked out.
> +	Can be used in conjunction with `--single-branch` and `--no-tags` to
> +	clone only the given ref. Cannot be combined with `--branch`.

OK, so it is an error to give both --branch and --ref at the same
time?  

If you say "git clone --branch foo --branch bar ...", wouldn't the
usual last-one-wins rule apply?  Shouldn't this work the same way,
meaning "git clone --branch foo --ref refs/some/one ..."  would
behave just like "git clone --ref refs/some/one ...", without
treating the "foo" branch any specially?

What if --ref is not pointing at a commit-ish?  If I in any
repository with non-empty history checked out do this:

	$ git update-ref refs/some/one HEAD:

can you clone from this repository with

	$ git clone --ref=refs/some/one $URL

and what happens at the end?

> diff --git a/builtin/clone.c b/builtin/clone.c
> index e77339c847..384923703d 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -69,6 +69,7 @@ static char *option_template, *option_depth, *option_since;
>  static char *option_origin = NULL;
>  static char *remote_name = NULL;
>  static char *option_branch = NULL;
> +static char *option_ref = NULL;

If you want to make "With --branch and --ref, the last one wins",
this would not be sufficient.

> @@ -141,6 +142,8 @@ static struct option builtin_clone_options[] = {
>  		   N_("use <name> instead of 'origin' to track upstream")),
>  	OPT_STRING('b', "branch", &option_branch, N_("branch"),
>  		   N_("checkout <branch> instead of the remote's HEAD")),
> +	OPT_STRING(0, "ref", &option_ref, N_("ref"),
> +		   N_("checkout <ref> (detached) instead of the remote's HEAD")),

Ditto.

> @@ -531,32 +534,64 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
>  	if (option_single_branch) {
>  		struct ref *remote_head = NULL;
>
> -		if (!option_branch)
> +		if (!option_branch && !option_ref)
>  			remote_head = guess_remote_head(head, refs, 0);
>  		else {
>  			free_one_ref(head);
>  			local_refs = head = NULL;
>  			tail = &local_refs;
> -			remote_head = copy_ref(find_remote_branch(refs, option_branch));
> +			if (option_branch)
> +				remote_head = copy_ref(find_remote_branch(refs, option_branch));
> +			else
> +				remote_head = copy_ref(find_ref_by_name(refs, option_ref));

This makes --ref ignored when --branch is given.  Intended?

> diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
> index 72762de977..51452bdd6f 100755
> --- a/t/t5612-clone-refspec.sh
> +++ b/t/t5612-clone-refspec.sh
> @@ -17,6 +17,7 @@ test_expect_success 'setup' '
>  	git tag two &&
>  	echo three >file &&
>  	git commit -a -m three &&
> +	git update-ref refs/some/three HEAD &&
>  	git checkout -b side &&
>  	echo four >file &&
>  	git commit -a -m four &&
> @@ -236,4 +237,38 @@ test_expect_success '--single-branch with detached' '
>  	test_must_be_empty actual
>  '
>
> +test_expect_success 'with --ref' '
> +	git clone --ref=refs/some/three . dir_ref &&
> +        git -C dir_ref for-each-ref refs > refs &&

Lose SP between ">" and "refs".

> +        sed -e "/HEAD$/d" \
> +	    -e "s|/remotes/origin/|/heads/|" refs >actual &&
> +	git for-each-ref refs >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'with --ref and --no-tags' '
> +	git clone --ref=refs/some/three --no-tags . dir_ref_notags &&
> +        git -C dir_ref_notags for-each-ref refs > refs &&
> +        sed -e "/HEAD$/d" \
> +	    -e "s|/remotes/origin/|/heads/|" refs >actual &&
> +	git for-each-ref refs/heads >expect &&
> +	git for-each-ref refs/some >>expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--single-branch with --ref' '
> +	git clone --single-branch --ref=refs/some/three . dir_single_ref &&
> +        git -C dir_single_ref for-each-ref refs > actual &&
> +	git for-each-ref refs/some >expect &&

I would expect refs/some/three and nothing else comes from refs/some
hierarchy, as the clone was done with "--ref=refs/some/three".  Is
there a particular reason why this for-each-ref is looser and take
anything under "refs/some/"?

> +	git for-each-ref refs/tags >>expect &&

This is because the above is not giving --no-tags, I guess.

> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--single-branch with --ref and --no-tags' '
> +	git clone --single-branch --ref=refs/some/three --no-tags . dir_single_ref_notags &&
> +        git -C dir_single_ref_notags for-each-ref refs > actual &&
> +	git for-each-ref refs/some >expect &&

Same comment on the looseness of this one.  Lack of refs/tags is
expected and it is a good thing to test that.

> +	test_cmp expect actual
> +'

There may be others, but three cases that are not tested but should
be I spotted offhand are:

 * "clone --ref=refs/some/three --no-ref" acts as if we gave no
   "--refs" at all.

 * interaction when "--ref=refs/some/three" and "--branch=main" are
   given at the same time.

 * the command gracefully fail when the given ref points at a tree
   or a blob.

Thanks.
