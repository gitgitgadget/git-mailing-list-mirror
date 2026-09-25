Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3078C3F4DDD
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356672; cv=none; b=eKhOj9HN6s9B5Iuvmi7PEisGX41UL/YYrfkGFNwX1vMETLG5g6BqHlUhlAU197lHmsf0axCYzbE/saOHtvm6MNV5TzFwv8jTgYTYyEg+kstU4onfWkrFh7BlRJEmkwN+CUHkqMAlhpafZ3ock2Zr+HyFP3/IGDNhrZS33cuULrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356672; c=relaxed/simple;
	bh=WHVsLPZeryS0WEstULheiUH73BM3yzbUqQN1LMyJwg8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RbsXl6FuS3LR29f4IQDtLzR6dpZvzWPOKpGM+xYAeni+v8lEt+/tO5Sw/Sh6cC00n2w/GZMRKxxa0V/iivxjrqs1ObcecDeDJ4NSEDnYL00daHlDSYCTxVTNt1x4qRAL8Q1dKyMwutkI3v2V6NJNeBrDeAICStwThOuc1j4goPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=en6nfBgO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XCHhNK6r; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="en6nfBgO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XCHhNK6r"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5BC21EC00B5;
	Fri, 25 Sep 2026 13:17:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 25 Sep 2026 13:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790356652; x=1790443052; bh=dcnK9rLofp
	WqXqaVL2U5vGMIqd97MkAwjMIz6EY3rZs=; b=en6nfBgOIgptar9wuGslMqGVoM
	TPKQ5C8xATLDY/SZcgFsf55u5qGpJRLcfEEakLHbU2m3C2bMPbT+WBlS9PtSVMiG
	9/qq/j8xooMf9j4NsEWNHg//3QNn2sgJgBrUd7mXjY9O5OlzQt5Q2yQtQ92oID0S
	8UBQ6ACE7jaffAIAwawDb9hpPkNbmTHGcRjjpvVoDO54UGKO36Xb6uOVseatQPZG
	jPRI67aJwgh/qXIh18DwBVIqXEOurwf6GTmRcV7jdCVVN7jTKUkqn86e7i4n+uRC
	iooHn65UCiP37S35Fh31ZEHaL9Vd9jKFrKihtrOlVeyqIyig1VIbtNxVS/oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790356652; x=1790443052; bh=dcnK9rLofpWqXqaVL2U5vGMIqd97MkAwjMI
	z6EY3rZs=; b=XCHhNK6rOBK3vN/q4qO+cggx0kUOwhYAjdY2HpjPIjlEwUewPaU
	jQHQHT7sMeUdAG3VF2sbktjvLMzGQhlIuuaQcfyEp9A8B9YWgPGqX5NPcb4USkCs
	SGfTS1gG0uynypRHRLUtCfbsT4sMo2sdfwTo3cgOKbjlAXgfZnrmSTaube81EvT/
	X7OBqq4so1/u3AqHZD7XtTgenc2cK7pWdXYj+k/qmstslKyALhFfoTqSnKMj0uen
	NWKwnqGT5L8e0AXAi/VzXpzxDQ6FoM9NeQ5rP1hGISc19oUDRSPFJjnXPa5jY/no
	WN/wbuylxkzJP5Mehzw7HczjKoAiDuNafOw==
X-ME-Sender: <xms:rKy2algON22IgaFDnTX_s0kmY1RxiCwuWyRLDuUUQRpTaGJynp5hfg>
    <xme:rKy2ag4SoZvf7K-bdW4yzseHEPEC8t6zjHiPyxo41C5k3NihBbxKLcW5fe7R6GM0b
    3ifvqVbWWsvd25SaVQlxS8c4ydlIfAEEMRqg9B5IkfRxqVgOYSy8kE>
X-ME-Received: <xmr:rKy2atbWx2UHflhZ3T2dFK6fhkHDiXw3ntQxMv-0yaVrs-ztpQquZO09HREBpCfoLbJPexBhStocgJjexX1TLTsUXuGrhKh8d_vW>
X-ME-Proxy-Cause: dmFkZTF42A7oMx9EVp5QcWzlf3qMOAhJvLqOMPBA63o+vN2op4+1ZKkM8jMDWYBgkM5LbQ
    TOsAmmjpvH9H7BBvyG2kCWPz+TR/VG5J48Oc3v0dOq5D9aQq7tmVxknBgTKnSkRzYiXdUv
    saN22OIsw8YYEu6Cq/Qvwwi8gjGgckv9gV6d5MmaiBPdU0DKisUeHaJPnRDoWfVlVDA7dK
    TiBcIZiWpj1pXziHvKkf4d8AR7ad377yODXKTHCAMJEpEOJYUn2z5lvtenIzDTk+s5tTDC
    tX+6F27erZv+97zpx2AlXm99wXZ0ttChquxq/BpSXQVB+/Hb+J9MYZBpG875Plz/Snm0PD
    zgZ5oEAanOtssOgsqVq9IRoQcmBenqC4uOv09WXh4ccuDu9/agb2B67/+equ4aigsEhbuR
    QQc5qOJ/T+vfyqq1A9PvW7FfziEy1IqGNmYvMc/8IeFJreBe20NhoFSNUsN8flFm8imAiY
    jNb02V8PdLPy1g+IciQd4Bkj0aYHR7o1idU1pjN5Q5x0oKHFUmJNNhVsAdEKYOjRX3t5CT
    FkKEeVesCJYlSADqcKWwX5xufRwZ99Gu4lC/2Tol/9ctTQChg5jya157Zv0Qv1bzHZncG4
    XigNYf5w+iNSW2yqSCHFL1mjpBHjiy2QdDU+o0X9BxHQHN2LrUk4GC0e51UA
X-ME-Proxy: <xmx:rKy2al7nAwhgB-nu0lkdWvaeAePXQqXPIpfvYpeAospY0MOMOEzlnA>
    <xmx:rKy2agC0Re-YEV883BFFJt3DxUo9lz5TCmlbFPw-kVtIl68olCt4kQ>
    <xmx:rKy2arf9YXRjIGzM2LQ3Krb4p8hhL2AsfXCasp27zzPaatH5pZxFGQ>
    <xmx:rKy2avK4mIQmGuqn88LZyL3Yi5q-ahOEWTN5fF220p3LTTqQ5TWMTQ>
    <xmx:rKy2ahLrK_qF1a9TjSxYL_CPaNt0NOXurVmtbMeqdeV-FpEe4nH5UnbW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 13:17:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 5/7] [doc] git-cherry-pick: link to new merge conflicts
 guide
In-Reply-To: <03a6b43b5803e6bd9ebba1a49c34cb42202a7f44.1790261062.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Thu, 24 Sep 2026 14:44:20
	+0000")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<03a6b43b5803e6bd9ebba1a49c34cb42202a7f44.1790261062.git.gitgitgadget@gmail.com>
Date: Fri, 25 Sep 2026 10:17:30 -0700
Message-ID: <xmqqpky1uu6t.fsf@gitster.g>
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
> Remove the discussion of merge conflicts and replace it with a link to
> the guide.
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/git-cherry-pick.adoc | 23 ++++-------------------
>  1 file changed, 4 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/git-cherry-pick.adoc b/Documentation/git-cherry-pick.adoc
> index f4cd8b9db7..d93829600b 100644
> --- a/Documentation/git-cherry-pick.adoc
> +++ b/Documentation/git-cherry-pick.adoc
> @@ -19,25 +19,9 @@ Given one or more existing commits, apply the change each one
>  introduces, recording a new commit for each.  This requires your
>  working tree to be clean (no modifications from the HEAD commit).
>  
> -When it is not obvious how to apply a change, the following
> -happens:
> -
> -1. The current branch and `HEAD` pointer stay at the last commit
> -   successfully made.
> -2. The `CHERRY_PICK_HEAD` ref is set to point at the commit that
> -   introduced the change that is difficult to apply, unless the
> -   `--no-commit` option was given.
> -3. Paths in which the change applied cleanly are updated both
> -   in the index file and in your working tree.
> -4. For conflicting paths, the index file records up to three
> -   versions, as described in the "TRUE MERGE" section of
> -   linkgit:git-merge[1].  The working tree files will include
> -   a description of the conflict bracketed by the usual
> -   conflict markers `<<<<<<<` and `>>>>>>>`.
> -5. No other modifications are made.
> -
> -See linkgit:git-merge[1] for some hints on resolving such
> -conflicts.
> +When it is not obvious how to apply a change, there may
> +be a merge conflict. See linkgit:gitmergeconflicts[7]
> +(or `git help mergeconflicts`) for a guide to handling merge conflicts.

The new document may explain how to resolve conflicts, but are the
details removed from here that are specific to the 'cherry-pick'
operation also covered there?

For example, during a difficult cherry-pick, it is often handy to be
able to run 'git show CHERRY_PICK_HEAD', but now users are not told
about the pseudo-ref, which seems like a real loss.

The fact that cleanly auto-resolved contents for paths are recorded
in the index may be shared with all other merge-like operations,
and it need not be part of the "how to resolve a conflicted
merge-like operation" recipe, but users need to be assured that this
is what happens somewhere in the documentation set.  The list
removed here served that purpose for this specific command, but it
is now gone.

I do not recall offhand whether we explicitly tell our users that
all merge-like operations update the index with cleanly auto-resolved
results and only leave conflicts to be hand-resolved by the user,
but even if we did so elsewhere, I do not see any reference to that
in the existing text of the 'cherry-pick' manual, nor does this
patch series add such a link.  At least item #2 and #3 should be
kept in the list, I think.  A better alternative might be to add
your new reference, and shorten the description given in item #4,
and leave everything else as before.

Thanks.

>  
>  OPTIONS
>  -------
> @@ -259,6 +243,7 @@ $ git cherry-pick -Xpatience topic^  <4>
>  SEE ALSO
>  --------
>  linkgit:git-revert[1]
> +linkgit:gitmergeconflicts[7]
>  
>  GIT
>  ---
