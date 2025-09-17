Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A026621CA00
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758148550; cv=none; b=q+NKy6hzww0mSC4OS2vVnxzj/bCgSYnHafOgCkd+NXqzIdwQ7Ksv0nu2wWDXN2yrpeXIcEc6JrWpFy5CjmzpT7nsHaLfGt7DjPkTuElQbT/kp+/7/5d1LrJIfgoHAziQGuYJnYMwoy7DUd4zgpHrQDWbJhRWPbnuRg93lb8EkD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758148550; c=relaxed/simple;
	bh=hbe4lJF/9T3V7lBi+HqHsFb7+5UbMEgonKf729QD+VI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=POSqXV1MejR7unZtQ3ic3lxzbJwoTKrEGHvvoXST1zfpcK3mKmRQFtTl0UZ1Z6D1csbZOXvi3TyaOd3xcozRDKd6u3eMenLIz3jF8985Hbe1BfJWoopYlopKK6ufQzvoOhD4MQ4wiMwTNpZLngbJSJ9NO0yu8OfOrqOkFIn6VeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ilK4LJhk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=We0k/2RX; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ilK4LJhk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="We0k/2RX"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C439AEC0176;
	Wed, 17 Sep 2025 18:35:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 17 Sep 2025 18:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758148546; x=1758234946; bh=SqVpPeEy2H
	dFCv+HQsmJQhr/TpdrhpjudMDl0Svw5Tg=; b=ilK4LJhkZUenbYg9cqJypubwzT
	Q2kqrgz5C6e0dArK7lXoC3RvWPWUmgA+0HMJyF9uyQLH3INcYnE67Is7EkkXJjGv
	kivnu6ItihJvbFvRIYBLQuAoNuVL2rU0kNJBJsutvPkLTEuLEXJHQU6+FSeYc7nQ
	vzJfoKoFP8oTu1Ag22pSGjrDna0JtGU7dkaLsHiKH6hy/Es8a/Zlzt9J29GonA8h
	Z/GRGgu30rqOKvkk2wqKC3xWIimpaVuixuPeg9C4JpxyTlCXAvhPvEeMwC3CiyXR
	EdThCZEicbAkXxpCkdczurmp/poV91EYaXEp+M/KLG0RM3Xi2sEGNL245XBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758148546; x=1758234946; bh=SqVpPeEy2HdFCv+HQsmJQhr/TpdrhpjudMD
	l0Svw5Tg=; b=We0k/2RX4JSHOqjgxwmaWa5Nr+CrDlXU6fKabM+ax7Zpfh2IiaX
	azmc58JbkxyuBxkDtX4Ee55EyRDtS/FbvrFhoavqys36Y1GM0RHiNHsWw4EgakUP
	z/ZY1nrHBdYYRFuaDJWQWwkt0GuT6L2/cYgRJOwDfOnWMuzfMtJZ3eS0supJ2/0R
	ou8hC79iZY15FT+E7aUHY8tp6XSkkwvC3C2gFJWtcxsWzEPxeqbwgUOaSku5aLp3
	CFR5hmj73fObnLHXpGZ/nlQdYW+LI3LrBAz0ZEkYzpiWlA+72T3WEYM8E1zeYWT6
	rUUoMkdhu19TgSD4lbSh93iAA69JbBmnGkw==
X-ME-Sender: <xms:wjfLaAWcABPduxkAcHhdf_-DgxiiFMoKujE83cxMiUR2ns_UfaBqaw>
    <xme:wjfLaPL59DtLc_3NusCDOu7PKCk5ykblKqwpQpAELvshcQ0xr226ogJpXdxU2iQkl
    -KtjAfVV1Z1ixpN1w>
X-ME-Received: <xmr:wjfLaA_mFcBfJZ4BjXg-Uj4nTEwD_jNu0CBR86_QN1lp3mNGk-hGWMRQPaZoMiRgb8Bkgyqp1-baeQcVtgfhhhkCIBnDtelRN0CcJKc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:wjfLaCKkGTupvuq1aitGiJb7zfCv8E3Zke-KIHGDfUsEa7jeICukrg>
    <xmx:wjfLaFm8T01MyCHjdgdDfGb3ne4yRWp1KRjepQIoPdnQeLEqF0FgKQ>
    <xmx:wjfLaGM7IuZq9bFgXAMukmM9LRjou3ynGB8B4OYgXHuMu1NuvoFZRA>
    <xmx:wjfLaL0hX3LTLuDWj1R0E6fmgH9FPWZRul1n7lkl1H0g4tfk3l9YCw>
    <xmx:wjfLaJmcDIWcmlijZ7F2grb7zX9EDuWTs9r_XKl76K_d9_4RzhYizfA4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 18:35:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 1/2] doc: git-push: create PUSH RULES section
In-Reply-To: <2f2dc22c47530445bce50f1bdef9630b046677bd.1758144815.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Wed, 17 Sep 2025 21:33:34
	+0000")
References: <pull.1973.git.1758144815.gitgitgadget@gmail.com>
	<2f2dc22c47530445bce50f1bdef9630b046677bd.1758144815.git.gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 15:35:44 -0700
Message-ID: <xmqq348kbtbz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  --force::
> -	Usually, the command refuses to update a remote ref that is
> -	not an ancestor of the local ref used to overwrite it.
> -	Also, when `--force-with-lease` option is used, the command refuses
> -	to update a remote ref whose current value does not match
> -	what is expected.
> +	Usually, `git push` will refuse to update a branch that is not an
> +	ancestor of the local branch or commit being pushed.

I read this as "there are two conditions, and satisifying only one of
them is sufficient for the push to be allowed.  (1) the local branch
is a decendant of the remote branch being updated, or (2) the commit
we push to update the remote branch is a descendant of the remote
branch being updated".

But of course that is not what you wanted to say.  (1) would mean

    $ git reset origin/foo && git push origin anything:foo

would allow us to push literally anything to overwrite origin's foo
branch.

I think

    "... not an ancestor of the commit being pushed to update it."

would be a way to avoid such confusion.

The problem the original description has is the phrase "the local
ref used to overwrite it".  It wasn't as commonly done to push a
specific commit that may not necessarily at the tip of the branch
back when this paragraph was written.

> -This flag disables these checks, and can cause the remote repository
> -to lose commits; use it with care.
> +This flag disables that check, the other safety checks in PUSH RULES
> +below, and the checks in --force-with-lease. It can cause the remote
> +repository to lose commits; use it with care.

OK.

> +PUSH RULES
> +----------
> +
> +As a safety feature, the `git push` command only allows certain kinds of
> +updates to prevent you from accidentally losing data on the remote.
> +
> +Because branches and tags are intended to be used differently, the
> +safety rules for pushing to a branch are different from the rules
> +for pushing to a tag. In the following rules "update" means any
> +modifications except deletes. Deletions are always allowed, except when
> +forbidden by configuration or hooks.

One important operation is omitted.  "update" does not include
"create" in the following, no?  Obviously since refs/tags/ would
never take any "update" (unless forced), if "create" were thrown
into the same category as "update", you cannot push a new tag out.

So, next to "Deletions are always allowed", shouldn't we describe
what rules apply to creations?  I presume that they are also always
allowed?

> +1. If the push destination is a **branch** (`refs/heads/*`): only
> +   fast-forward updates are allowed: the destination must be an ancestor
> +   of the source commit. The source must be a commit.

Reads very well and also correct.

The first colon might be acceptable (I find it a bit odd, though).
The second colon is very weird.  ": only" -> ", only" & "allowed:
the" -> "allowed. The", perhaps?

> +2. If the push destination is a **tag** (`refs/tags/*`): all updates will
> +   be rejected. The source can be any object
> +   (since commits, trees and blobs can be tagged).

Again, I might prefer ":" -> ",".  I cannot decide which I prefer
between "all updates will be rejected" and "by default no updates
are allowed".  Either should be OK, so let's take what has already
been written.

The second sentence is not wrong per-se, and I can see that this was
inherited from the original, but gives me a strange aftertaste. When
you list object types in the context of "tag" and have only commit,
tree, and blob, a little voice in the back of my head asks "oh, what
happend to tags?".  It is made a bit worse with the phrase "can be
tagged", as it typically means either (1) to create an annotated or
signed tag object, or (2) to create a ref in refs/tags/ hierarchy
locally, but usually you do not think of pushing to refs/tags/
hierarchy as "tagging that object remotely".

I think the untold assumption here is that refs/tags/foo at the
remote is being updated most of the time from refs/tags/foo we have
locally, and "any kind of object can be tagged" is trying to say
that refs/tags/foo we have locally can be an object of any type, as
the act of creating a ref "refs/tags/foo" and pointing it directly
at an object is "to create a light-weight tag" for the object.
Since we can have not just tags but any kind of object locally
(because any object "can be tagged"), a push can ask object of any
kind to be pushed to refs/tags/* hierarchy.  But it is an awkward
concept to explain.

Would side-stepping what exactly "tagging a thing" means, and
phrasing it like this

    The source is not limited to an annotated or signed tag object,
    but can be a commit, a tree or even a blob.

work better, I wonder?

> +3. If the push destination is not a branch or tag:

Here, I do understand and support the colon, so I'd equally support
the first colon of the previous 2 sections for consistency.

> +   * If the source is a tree or blob object, any updates will be rejected

OK, so this is the same rule as the refs/tags/ hierarchy.

> +   * If the source is a tag or commit object, any fast-forward update
> +     is allowed, even in cases where what's being fast-forwarded is not a
> +     commit, but a tag object which happens to point to a new commit which
> +     is a fast-forward of the commit the last tag (or commit) it's
> +     replacing. Replacing a tag with an entirely different tag is also
> +     allowed, if it points to the same commit, as well as pushing a peeled
> +     tag, i.e. pushing the commit that existing tag object points to, or a
> +     new tag object which an existing commit points to.
> +
> +You can override these rules by passing `--force` or by adding the
> +optional leading `+` to a refspec. The only exception to this is that no
> +amount of forcing will make a branch accept a non-commit object.
> +
> +Hooks and configuration can also override or amend these rules,
> +see e.g. `receive.denyNonFastForwards` and `receive.denyDeletes`
> +in linkgit:git-config[1] and `pre-receive` and `update` in
> +linkgit:githooks[5].

Very well written.  refs/heads/ not taking any non-commit, and
receiver side hooks that may reject a push, are not something
"--force" can override.  The mention to "the only exception" above
sounded as if it forgot to mention the latter.

Looking mostly good.  Thanks.
