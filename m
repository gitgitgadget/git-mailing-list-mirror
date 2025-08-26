Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064231C1AAA
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 23:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756251305; cv=none; b=C5e/rxAf0EcdIJIsFQsW8nTwgdz1g2rGqzIIKf5OoVddBtXP+LCQuIPsNsSp0ISfxwJUpZJymJMnfdslTfQuRcarXPdo8X0Vec/MloTV68ekn4y1WhdoCtCAMSePvwTD3XpwJe4rNPZQVnndgJ7huEwyq0WmVoB6UNiSPoMaUk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756251305; c=relaxed/simple;
	bh=Yhnp9ytGW+unuo+/cUzNCd4gENDy8dlG/xaKY4IXLAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VT3CpVTMCot5eawEDvNHP0LgPZBzjYeghBW/pt9L4aCatrVfb1MR2L6frGVVZDUv0rRZxljHcmQg4dQDGUIk+Dvw2mkMP8lFH3IeDfI2ei9GS8f0Nd5q3WUKyuh22avUy7Qjw/rPAXwuRngrIZ6vIlTTHYaZdsEJuCCLb8bj6zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uXbWYPfe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dpldiXxB; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uXbWYPfe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dpldiXxB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 084B41400093;
	Tue, 26 Aug 2025 19:35:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 26 Aug 2025 19:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756251302; x=1756337702; bh=xqOITd2s3U
	8zJw8a+lIi65HYfXKwcyMOAfwOijO+I8E=; b=uXbWYPfej6TOjnIwkcV0mwPVOG
	Rl7FmmLTBE/d/lFjxVclPb4v7XML6VKfK8Vak836hPTyvaYsNEHZNn57ZIlLaMA9
	QXmrdUePrx7QLtD52e3rtPxhad0ZbpJEz1DYvXOQ8nZAZZtIhUeMreTXYuEAetjj
	s2TpURpzcS44Wv8N6IKqZ0rS8jvD4pVmE2tN3x29dT3J0pTXYquw3BtA1qhxutt9
	2tSMbCi8aqi54qvi9aK/6/NCl0p1lNX+XCiKX5IpJTL+LADa+wKTamJBxqCtJCTJ
	9ScUHSgUVSyNxPz0TqsuedGuNSQ25Rg6STZNMyhj1jTIWsbZ8yyRJqmJONfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756251302; x=1756337702; bh=xqOITd2s3U8zJw8a+lIi65HYfXKwcyMOAfw
	OijO+I8E=; b=dpldiXxBYAwFbeTfISX46T87FYfrMyg07kfdEv2KzarzDNTzJWS
	g7JaRJyDo5btSj16r80KpcAHaOQNZQhSf8Wod/hVbRY4t5jEpmFpKwfhdYlZVvdl
	BukQ3Ig8FthcP+Wj/V5Wq7JwOc2rx5AU8w2n6a8DIR+7hy97sxT2sGERvn8cS8S2
	VgpEhLu7CkdZJpVsPZVeGhulItJLI4oq5InIlVBSzEjgdbV/pJy3zCv0Lz2CzKu1
	9EpC6XcwF+QRZ2EHi5DfBAiGKdORIHbi67d+go68dWgpaGoaXzhO9ggI/VcQdgtO
	ouFe8hffxnXmys1kwQHz4tnRJ2y0nRGdFfw==
X-ME-Sender: <xms:pUSuaPc7W26JBHYhpYAn3wP8a4ihnuSLJXSUCsfOPuOrRbYPz2F7Dw>
    <xme:pUSuaPx_VtxnG8sXCyGXjY76Vz4BBI0g0zwJGWisHyT4fAR96r-x1SNCJCEO-MvcK
    kQuhEESVjUwmKMJxg>
X-ME-Received: <xmr:pUSuaFH0QOUFnE8yGcpilgSzmt0r3mFtLWELwlKAGEUVI7ZqT07cCIwh_osyam_WSaxnGThyVuPeltGUVE4f7AHFCsz7IHJk0nP3skw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeeiiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:pUSuaDwCFh4Uw1T95ofhZgiffjgF5otrPVcr8MR-bXE4b5nDnWSMiA>
    <xmx:pUSuaGspR_uIJT12igaS0WHRsfY_AK1LSnsUY9SdQ3S4k4KxHyFWEA>
    <xmx:pUSuaA3YEW1QYmPQw5sr2TEmdJZgUMU9MBMlSB6Gua_Rv9SbmxFvDQ>
    <xmx:pUSuaB-S3QUbImx51TUf1VYhPdxEvDv3OjEKRvSqsEQD5sB5xkF1sQ>
    <xmx:pkSuaFtRvW0sCCVYMpkXZr9j5MNauHeb6yVAEylajC86PwEWp52Ly5VE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 19:35:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 4/4] doc: git-push: rewrite refspec specification
In-Reply-To: <72114133aafc94354c8b7f3c8ac65456421ce34b.1756240823.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Tue, 26 Aug 2025 20:40:22
	+0000")
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
	<72114133aafc94354c8b7f3c8ac65456421ce34b.1756240823.git.gitgitgadget@gmail.com>
Date: Tue, 26 Aug 2025 16:34:59 -0700
Message-ID: <xmqqsehdfyho.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> - Originally it said that a refspec was `+<src>:<dst>`, but then later
>   contradicted itself by saying that the `:<dst>` is optional.
>   Mention that `:<dst>` is optional much earlier.
> - Put the complex sets of rules about different refspec forms
>   in lists instead of in long paragraphs of prose
> - Add examples for the various types of refspecs
>   (negative, deletion, pattern, etc)
> - Previously `*` and `^` were not mentioned, mention them
> - Explain what `+` does earlier
> - Remove "might be added in the future" (it's a given that software
>   might change in the future)
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/git-push.adoc | 164 ++++++++++++++++++------------------
>  1 file changed, 82 insertions(+), 82 deletions(-)
>
> diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
> index 0232195515c9..78d433c60c51 100644
> --- a/Documentation/git-push.adoc
> +++ b/Documentation/git-push.adoc
> @@ -57,77 +57,74 @@ OPTIONS[[OPTIONS]]
>  
>  <refspec>...::
>  	Specify what destination ref to update with what source object.
> -	The format of a <refspec> parameter is an optional plus
> -	`+`, followed by the source object <src>, followed
> -	by a colon `:`, followed by the destination ref <dst>.
> -+
> -The <src> is often the name of the branch you would want to push, but
> -it can be any arbitrary "SHA-1 expression", such as `master~4` or
> -`HEAD` (see linkgit:gitrevisions[7]).
> -+
> -The <dst> tells which ref on the remote side is updated with this
> -push. Arbitrary expressions cannot be used here, an actual ref must
> -be named.
> -If `git push [<repository>]` without any `<refspec>` argument is set to
> -update some ref at the destination with `<src>` with
> -`remote.<repository>.push` configuration variable, `:<dst>` part can
> -be omitted--such a push will update a ref that `<src>` normally updates
> -without any `<refspec>` on the command line.  Otherwise, missing
> -`:<dst>` means to update the same ref as the `<src>`.
> -+
> -If <dst> doesn't start with `refs/` (e.g. `refs/heads/master`) we will
> -try to infer where in `refs/*` on the destination <repository> it
> -belongs based on the type of <src> being pushed and whether <dst>
> -is ambiguous.
>  +
> ---
> -* If <dst> unambiguously refers to a ref on the <repository> remote,
> -  then push to that ref.
> -
> -* If <src> resolves to a ref starting with refs/heads/ or refs/tags/,
> -  then prepend that to <dst>.
> -
> -* Other ambiguity resolutions might be added in the future, but for
> -  now any other cases will error out with an error indicating what we
> -  tried, and depending on the `advice.pushUnqualifiedRefname`
> -  configuration (see linkgit:git-config[1]) suggest what refs/
> -  namespace you may have wanted to push to.
> -
> ---
> -+
> -The object referenced by <src> is used to update the <dst> reference
> -on the remote side. Whether this is allowed depends on where in
> -`refs/*` the <dst> reference lives as described in detail below, in
> -those sections "update" means any modifications except deletes, which
> -as noted after the next few sections are treated differently.
> -+
> -The `refs/heads/*` namespace will only accept commit objects, and
> -updates only if they can be fast-forwarded.
> -+
> -The `refs/tags/*` namespace will accept any kind of object (as
> -commits, trees and blobs can be tagged), and any updates to them will
> -be rejected.
> -+
> -It's possible to push any type of object to any namespace outside of
> -`refs/{tags,heads}/*`. In the case of tags and commits, these will be
> -treated as if they were the commits inside `refs/heads/*` for the
> -purposes of whether the update is allowed.
> -+
> -I.e. a fast-forward of commits and tags outside `refs/{tags,heads}/*`
> -is allowed, even in cases where what's being fast-forwarded is not a
> -commit, but a tag object which happens to point to a new commit which
> -is a fast-forward of the commit the last tag (or commit) it's
> -replacing. Replacing a tag with an entirely different tag is also
> -allowed, if it points to the same commit, as well as pushing a peeled
> -tag, i.e. pushing the commit that existing tag object points to, or a
> -new tag object which an existing commit points to.
> -+
> -Tree and blob objects outside of `refs/{tags,heads}/*` will be treated
> -the same way as if they were inside `refs/tags/*`, any update of them
> -will be rejected.
> -+
> -All of the rules described above about what's not allowed as an update
> -can be overridden by adding an the optional leading `+` to a refspec

All of the above is fairly accurate, even though they are densely
written and at places somewhat redundant.

> +The format for a refspec is [+]<src>[:<dst>], for example `main`,
> +`main:other`, or `HEAD^:refs/heads/main`.
> ++
> +The `<src>` is often the name of the local branch to push, but it can be
> +any arbitrary "SHA-1 expression" (see linkgit:gitrevisions[7]).
> ++
> +The `<dst>` determines what to update on the remote side. It must be the
> +name of a branch, tag, or other ref, not an arbitrary expression.

Concise and simpler beginning is good.

> +`:<dst>` is optional.

It may be technically true, but I am not sure if it is a good idea
to say it here.  Without "when missing, <dst> is inferred with these
rules", saying just "is optional" naturally invites a puzzlement:
when do we need to supply it and for what?

As you are going to say what happens when you omit it very soon, and
you already have said with [:<dst>] that it is optional, perhaps you
can scratch this sentence.

> +`+` is optional and does the same thing as `--force`.

Ditto; this one is less bad than the :<dst> thing, because at least
it tells us what it means.  But we are going to talk about when an
update is not allowed (we haven't even hinted that some updates may
not be allowed yet) much later, "the same as `--force`" is probably
a bit premature at this point in the documentation.

> +You can write a refspec using the fully expanded form (for
> +example `main:refs/heads/main`) which specifies the exact source

This example is not fully expanded.  refs/heads/main:refs/heads/main
would be, though.

> +and destination, or with a shorter form (for example `main` or
> +`main:other`). Here are the rules for how refspecs are expanded,
> +as well as various other special refspec forms:
> ++

I am not sure it is easier to read with numbered list.  It is not
like these rules are applied in this order, or anything like that,
right?

> + 1. `<src>` without a `:<dst>` means to update the same ref as the
> +	`<src>`, unless the `remote.<repository>.push` configuration specifies a
> +	different <dst>. For example, if `main` is a branch, then the refspec
> +    `main` expands to `main:refs/heads/main`.
> + 2. If <dst> unambiguously refers to a ref on the <repository> remote,
> +    then expand it to that ref. For example, if `v1.0` is a tag on the
> +    remote, then `HEAD:v1.0` expands to `HEAD:refs/tags/v1.0`.
> + 3. If <src> resolves to a ref starting with refs/heads/ or refs/tags/,
> +    then prepend that to <dst>. For example, if `main` is a branch, then
> +    `main:other` expands to `main:refs/heads/other`
> + 4. The special refspec `:` (or `+:` to allow non-fast-forward updates)
> +    directs Git to push "matching" branches: for every branch that exists on
> +    the local side, the remote side is updated if a branch of the same name
> +    already exists on the remote side.

Good to see that the oddballs like this and an empty one, originally
described elsewhere, collected in the same list.  An entry like this
that describes a special notation, not a concrete single refspec,
however is a bit hard to read when mixed with other more normal
rules.  Perhaps move it down together with the "push void to remove"
at the top of the list?

> + 5. `tag <tag>` expands to `refs/tags/<tag>:refs/tags/<tag>`.

A tangent.
Is this a refspec you can write in .git/config, e.g.

	[remote "origin"]
		push = tag v1.0"

If not, it might be easier to explain if we tweaked the command line
synopsis to say that the command takes, after the destination
repository, zero or more refspec or "tag <tag>".  I dunno.

> + 6. <src> may contain a * to indicate a simple pattern match.
> +    This works like a glob that matches any ref matching the pattern.
> +    There must be only one * in both the <src> and <dst>.
> +    It will map refs to the destination by replacing the * with the
> +    contents matched from the source. For example, `refs/heads/*:refs/heads/*`
> +    will push all branches.
> + 7. A refspec starting with ^ is a negative refspec.
> +    This specifies refs to exclude. A ref will be considered to
> +    match if it matches at least one positive refspec, and does not
> +    match any negative refspec. Negative refspecs can be pattern refspecs.
> +    They must only contain a <src>.
> +    Fully spelled out hex object names are also not supported.
> +    For example, `git push origin 'refs/heads/*' '^refs/heads/dev-*'`
> +    will push all branches except for those starting with `dev-`

Good.  Somehow we have added the description of these to "git fetch"
side, without updating "git push" side of the documentation.

> + 8. If `<src>` is empty, it deletes the <dst> ref from the remote
> +    repository. For example, `git push origin :dev` will
> +    delete the `dev` branch.

OK.  This is specific to "push" (you do not delete your local branch
by fetching :refs/heads/to-be-removed from elsewhere), so even if we
wanted to unify the descriptions on both sides in the future, we'd
need to be a bit careful around here.

> +    Deletions are always accepted without a leading `+` in the
> +    refspec (or `--force`), except when forbidden by configuration or hooks.

This can be read in two ways, making two opposing answers to this
question possible: when forbidden, can you make a deletion accepted
by giving a `+` in front?

"except when forbidden, deletions are accepted with or without `+`"
might be less confusion-prone, but I dunno.  I just wanted to make
sure that it is clear that forcing or prepending `+` would not
change anything when forbidden by configuration or hooks on the
remote end.

But because you haven't mentioned that not all updates are allowed,
this might be a bit out of place in this list.  How about limiting
this bullet point to only say that this is the syntax to use to
delete a ref from the remote, and move the "deletions do not have to
be forced and operations forbidden at the remote cannot be forced
anyway" down, near the "Not all updates are allowed" below ...

> +    See `receive.denyDeletes` in linkgit:git-config[1] and `pre-receive` and
> +    `update` in linkgit:githooks[5].

... together with this?

> + 9. If the refspec can't be expanded unambiguously, error
> +    out with an error indicating what was
> +    tried, and depending on the `advice.pushUnqualifiedRefname`
> +    configuration (see linkgit:git-config[1]) suggest what refs/
> +    namespace you may have wanted to push to.
> +
> ++
> +Not all updates are allowed: it depends on what kind of destination
> +you're pushing to. In the following rules "update" means any
> +modifications except deletes, which as noted above are treated differently.
> ++
> +All of these rules
> +can be overridden by adding the optional leading `+` to a refspec
>  (or using `--force` command line option). The only exception to this
>  is that no amount of forcing will make the `refs/heads/*` namespace
>  accept a non-commit object. Hooks and configuration can also override
