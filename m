Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4180B4DD3B4
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889681; cv=none; b=uKILfCU9+NKr77fYM4GRgzP5ci6gIzR2cMj05CpLaBipeIflm8hGRqaEc/NjOCym80fFfFtmxhJBwRpwcWEK3jJIoBdftqrgq3uouShyhNldgWdwmOoKzPltSLX1DY33OddtDqj6P0N2FhPiV93vtzor8gYSKF4nUEWtf+5YSXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889681; c=relaxed/simple;
	bh=Agcn2qrOSGOFeGFB0j2iAdss7JonRG7pA56/y9y0VKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqkyE7x1AObQnkRAWeMJYThVFoA5+dca4RMgI/kzQTD4dR/gOXXpJXOO7kQyHCd9H2BEUgl6ZhBH9C2bOUh4F98GXtmGF22UOzzwjQxLsZE4arB8qXm1H2zp2SwY44fe+FMkYb2l3HQ2sh3mOyf87E8hAWSQEXnqqRjI+9qVgME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B2Qt4xgf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pW2xt56w; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B2Qt4xgf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pW2xt56w"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3319B1400123
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 07:07:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 13 Oct 2026 07:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791889676; x=1791976076; bh=2BbSmRNqDV
	D+uurM2w/vUNd9l4NWxUpOaIJzXBPpN6o=; b=B2Qt4xgfILfmfHi4CVm1azZrP4
	8CseAY2/kEToiDm2HoQ7j/vsvCj28Lavg9F7/nJ3atFIVHwjP0gjLvZJIxtmyjo2
	o2UNX6yB9KmCCD3ceVrZkaoVuPKaH8GPF35GQvovkmv2pGI1d/7dtKL58N7D/clr
	FQiocXERMXnYis7eG3Fba6pnrIeQDCEiYUK0Iykj8J7qMZzAtnm0/8xcvnnSGlCf
	zyUZGyCkBpx86fGLBjkByS1ERLPqOYQHUE0fet0oEiwOD+G0v3L5gJv4YLbLxSEm
	6acd/eMraPqvMvhC1MdnQzU0pexgZWl6m2pmSERjkGxNLO/UUTOSFXW+E0iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791889676; x=1791976076; bh=2BbSmRNqDVD+uurM2w/vUNd9l4NWxUpOaIJ
	zXBPpN6o=; b=pW2xt56w/HeVSxwMFTMNRte6W5uccdbFTv2PGssRx2xjsbgNUdp
	o4ueCwiOSDa4+5V5+EAjN57cCKevPP2lzFNiBS26oQKSu5778zFv+VqTocdqi6GO
	fa/rw7rq6aCAqw3muj8/S4Eq43/cH0Eylqa1/+YnnIM5KDu45OOS9lBzzjHvONro
	BtVOW/BFsltUlOZUYjXigo1QcRLYpFXk9yc6u5ObsXwCljT793ihalzH67yO96Z+
	EDPxWgje/gQAm+yn7Buf0GMgDkTSVGl/OrEYmTLmLIEOYdz+iPVBZu9QuVPRg8sM
	wbq5OjGBazZDPNL/dYNyPzLJBrmYHIwM+ZQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791889676; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:B1QagGgawSq3XMA3ae7TZreo9H+TyOFwtdv/tf4jDUDpbvD
	ei6LwPzJjAwgW4d4ZeOpFaujz3J2soOycJxylSdFV95DmYdoiWB8brDT2MH76nW+
	1xeVuHb1D33spAUuHwv5dO7fQoexyAUhk584XFU0VFpbpbaVR1Alx8cWFogPZHvh
	XLVAyS4seO61HJ/WBy9Azw1YocU2dxGVyfaevrk//6duwXU3IUj7pTgPaJrIrbPz
	LzzynlT3pMgJOMLhn/99roQrbJiSn71tdeZsD4dEXWJQ44bgVb8WpX5lUMfzs3/n
	mIx1s9zJ79ECCbgGIr8DnxAfO7IA0wSy9aoJ80A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:YdxgqsoiF1Xb8d1BoVa9EPZm+mt3KdXRYutAi76DFtU=:Agcn2qrOSGOFeGFB0j2iAdss7JonRG7pA56/y9y0VKM=;
X-ME-Sender: <xms:CxHOaikuqWngiJm0G5jeyiFGfaBV0v6KxH05qF9KZQWs0ry6bsWHTw>
    <xme:CxHOagtkejNZUCfJbwFKaXOg4NBTtYYrK2OyCNsyJbJEd2dS0_tHZIlU9Ngi2zwmj
    qkVt_Y_C_ccGQoZn33VbqZ0d-6Moarpd7INNIt1zp0GgGeGsqIvE7E>
X-ME-Received: <xmr:CxHOao8NNUhaQGMzUxdCG8GXyRPUfjArdsUbhtO7ttjF3FFfVXMqkA>
X-ME-Proxy-Cause: dmFkZTGil2Llx5CNv86q0Wqt/1aIXet6vtXCqPXsR6zvOxI+Fv+vp34zM6oUnWzm52wdCL
    0rTElimY5IH5DBNhWrgs+mzEeKbdUdtzRxyqYeJC3PzjpoJu1GMxSTs6PRtN0tI9G1PQVy
    t5Xq6aHtE0Q0RQfCvQZSfBvDKhd0r9D7wafPPRjP1eQO/zrRVQQCRDDatU6mDfor92gQQn
    QWiuUR+B/0kKDfM+KUGR8CTifMhCns9RfXj42aaA7lxyLY5+ajgL6fD11AZURbYbOt5wxc
    QBsTGwNyZV01tTYJp/mYc0FmO/LkG6zRrACHUajirEKbx5il/4IlAyCRJ6mYtW7E980NBt
    0sKnvIp/2xq42w09Vdwt3fhnNMsCX7RRDMdk9Igeknvs2fRF0acAOSRPJw8aWZotcNgDXX
    8EyBcJwyZRTQnUBCfOVZo0lZa3aaOEcXTYotjFQAyXlWbp3lezQ8h097vbf+kew5TM4Usj
    3+EVKqqKGNxohfHf2+kIi+Kp7U2gWn1hwoW8v/e0oZh3MsgliLYPccW9AavipMrH/sSM2M
    hh6KRDuIwpbrFCyzEfj4ty/1nXUMlif4qVtLMb61h7BPzdD7N20AfivlMPt3ZjoFROYpjR
    1WPoF9XvUMLaL5QRo49Y+PuP96NWhwTMBXtpLc3s0rJQa1NGXU79U+BTf7FA
X-ME-Proxy: <xmx:CxHOaiNqOnDj2_rWaV1XAjEV_KO9XlXuPSTmUHYxWBC55hV_-Gb8bA>
    <xmx:CxHOauFflKsDWCBmEAfG2bdkgfiVsa9dCUHxEwOZGGXAxzL0IFAJcw>
    <xmx:CxHOaoRSueEQdP7ICM6TWRs1RqLC58T376LhBUTS7dI_URm06WqZpA>
    <xmx:CxHOajsC9HvIMFqeMZBbgEZPoKgwB4_dkPWCWVd3fBgT5n68t94OKg>
    <xmx:DBHOaksHUMBHyxmhKVDUqcAJIVsUSGmhYjdDq_udHJt-EYh4_bVScSsJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 07:07:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dfe50b9b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Oct 2026 11:07:52 +0000 (UTC)
Date: Tue, 13 Oct 2026 13:07:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"D. Ben Knoble" <ben.knoble@gmail.com>, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v3 1/6] doc: add new gitmergeconflicts man page
Message-ID: <as4RAcQxknZXcBVd@pks.im>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <pull.2237.v3.git.1791816795.gitgitgadget@gmail.com>
 <7aa0ae7ec3c1d02aa1533c27fa40f4815c03ba6e.1791816795.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aa0ae7ec3c1d02aa1533c27fa40f4815c03ba6e.1791816795.git.gitgitgadget@gmail.com>

On Mon, Oct 12, 2026 at 02:53:10PM +0000, Julia Evans via GitGitGadget wrote:
> diff --git a/Documentation/gitmergeconflicts.adoc b/Documentation/gitmergeconflicts.adoc
> new file mode 100644
> index 0000000000..3c6eaaddf8
> --- /dev/null
> +++ b/Documentation/gitmergeconflicts.adoc
> @@ -0,0 +1,330 @@
> +gitmergeconflicts(7)
> +====================
> +
> +NAME
> +----
> +gitmergeconflicts - Guide to handling merge conflicts
> +
> +DESCRIPTION
> +-----------
> +
> +Merge conflicts can happen during a `git merge`, `git rebase`, `git
> +cherry-pick`, `git pull`, `git revert`, or any other command that does
> +a merge. All of those commands use the same merge algorithm, and the
> +process for resolving a merge conflict is always very similar.
> +
> +There are 3 ways to handle a merge conflict:
> +
> +* Resolve the conflict. (see <<resolve,HOW TO RESOLVE A MERGE CONFLICT>>
> +  below for details)
> +* Stop the operation and return your branch to its original state
> +  with the appropriate `--abort` command, for example `git merge --abort`
> +  or `git rebase --abort`. See <<git_status,EXAMPLE: GIT STATUS OUTPUT>> below
> +  for how to find the command to run.
> +* Or (if you're in a multi-step rebase or cherry-pick) skip the problematic
> +  commit with the appropriate `--skip` command

Nit: the punctuation is a bit inconsistent, where the second bullet
point has a trailing punctuation mark but the other two don't.

> +WHAT IS A MERGE CONFLICT?
> +-------------------------
> +
> +When Git merges two commits together, it looks at the changes that
> +each side has made and combines those changes. For example, if one side
> +edited lines 1-5 of `hello.py` and the other side edited lines 20-25 of
> +the same file, then it can easily combine them since there's no overlap.
> +
> +But if both sides edited overlapping lines of the same file (for example
> +one side edited lines 1-5 and the other edited lines 3-6), Git will
> +not try to guess how to combine those changes. This is called a "merge
> +conflict".
> +
> +When this happens, Git shows you both sides' edits and asks you to pick
> +how to resolve them. It:
> +
> +* Stages all of the files which were successfully merged
> +* For the files with conflicts, it marks them as conflicted, puts both
> +  sides' edits in the file, and leaves <<markers, merge conflict markers>>
> +  that you need to resolve.

Same nit here.

> +[NOTE]
> +================================
> +Even if Git successfully merges both sides with no conflicts, it's
> +possible to end up with code that doesn't work. For example, this can
> +happen if one side renames a function, and the other side adds a call to
> +the old function. This is called a "semantic merge conflict".
> +================================

Good callout. We may also want to spell out the consequence of this:
"You should always verify the result of a merge regardless of whether or
not it has resulted in a conflict.".

> +[[resolve]]
> +HOW TO RESOLVE A MERGE CONFLICT
> +-------------------------------
> +
> +The process for resolving a merge conflict is:
> +
> +1. Run `git status` to get a list of files with merge conflicts
> +2. For each one, find the conflict markers
> +   (the `<<<<<<<`, `=======`, `>>>>>>>`) and edit the code to
> +   fix the conflict
> +3. Run `git add FILENAME` for each file to mark the conflict as resolved
> +4. Run the appropriate `--continue` command to continue the operation
> +   that was interrupted by the conflict, for example `git merge --continue`
> +   or `git rebase --continue`. See <<git_status,EXAMPLE: GIT STATUS OUTPUT>>
> +   below for how to find the command to run.

Same nit regarding punctuation. Or is this actually a thing, where you
add punctuation in case it's multiple sentences but not in the case
where it's a single sentence, only? Maybe this is just me not being a
native speaker.

> +[[tools]]
> +TOOLS FOR HANDLING MERGE CONFLICTS
> +----------------------------------
> +
> +Here are some ways to get extra context while handling a merge conflict:
> +
> +* There are many graphical "merge tools" for Git, which will normally
> +  show you the different versions of the code side by side.
> +  If you have a mergetool configured, `git mergetool` will launch it.
> +  See also `merge.tool` in linkgit:git-config[1] for a list of
> +  the mergetools Git supports.
> +
> +* You can set the configuration variable `merge.conflictstyle=diff3`.
> +  See <<diff3,DIFF3>> below for more.
> +
> +* `git log --merge -p <filename>`  will list all commits which

Should we spell this out as `--patch` instead? That's way easier to grep
in the manpage in case the reader is curious what the option does.

> +[NOTE]
> +================================
> +`zdiff3` is an alternative to `diff3` that makes the merge conflict
> +shorter by making it more ambiguous.
> +================================

"making it more ambiguous" reads rather curious. Should we maybe take
inspiration from its documentation and instead say "by removing matching
lines on the two sides from the beginning or end of a conflict region"?

> +[[ours]]
> +"OURS" AND "THEIRS"
> +-------------------
> +
> +Sometimes during a merge conflict, Git will use the terms "ours" and
> +"theirs" (or "us" and "them"). For example, `git status` might say that
> +a file was `deleted by us`.
> +
> +"Ours" and "theirs" are both commits: "ours" is the current
> +`HEAD` commit, and "theirs" is the other side being merged.

They may not always be commits, but they are always tree-ishs. But I
think it's fine to leave this as-is anyway, as the normal user is never
going to encounter cases where it's not in fact a commit. And when they
do they probably don't need this manpage anyway.

Other than this handful of nits I'm happy with this version, thanks!

Patrick
