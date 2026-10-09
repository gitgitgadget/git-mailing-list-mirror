Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35C1501291
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570040; cv=none; b=dhbctLPUlAn/6D9kliYtFBOA3mjEJ9eZbPSlI7atSIf/Arl07DcIVr2cohw2sw7X04Ydzhe3Af5XkIYVl8BR5ferMnpElQ9aGaOJJ/6p2zWg63Q6JVVq1T3P8NLIlgAbxYxwwAuZGLt7HcfQ/oAUl2Wykhcfq4Bwz2ZGx9at8Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570040; c=relaxed/simple;
	bh=mc1IK/+LuJEh2IrIRYWOfW/ZWGZukICDL0QIt6LUrCw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J1awpxH8JsWc4nDJTHxbf+KNjBSg9il6Ge3c4r951p9rzUiYj3nYbTqGictg7c8BHnZVWxmMmb+ks6CBEWEFGogwqncpqBknWYtWDBUQpKz+dnA/COaG/q/pMNDdalw+zxUZnWQMMTvO2FX8fAJ0SYDIBtbnmdYl3VlSkxeE2nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LttL+9Oh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tmpqyW53; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LttL+9Oh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tmpqyW53"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B86541D000CA
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 14:20:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 09 Oct 2026 14:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791570036; x=1791656436; bh=snsL4L3ih9
	a+X7Ko7jD8jyHbt0ij5h0hA7lEOtgtigE=; b=LttL+9OhEjBv4SNYG9NS7xSI3s
	Y4FJYM4kqfjHunlXGFmg0aDNYEItOOTFGs3E7M1qOdADptinf5gi5Vy7fcL0i5pv
	y4IkRH/pA8t0O+DTS70XDySA0W5EoNMvSeKPvzgehZActD1FVvzADKXN3o18ni4d
	tJoZtizRLAmXT0ViMhTliBO/tgaVusDNtuGrr7ZB5MAuk4myeW7rYNNY+4A64cpa
	3Q5IyRJ1xjbh+CQjo3DyHmLhCT7UUzv7T33/5m+htD+CCmu/4Ph+ue+IVD6IS2jN
	ySIvKTXRCCbMnhJO+lN9gA2sXwu7adQMq+18uceeGAl4E8aY8rapuvBWdsEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791570036; x=1791656436; bh=snsL4L3ih9a+X7Ko7jD8jyHbt0ij5h0hA7l
	EOtgtigE=; b=tmpqyW53L87jl8me9N+c8bl8H+bZPySRAayLsvreK53YAvbIb9b
	yF0aVjy8bJYtVaieX7VnRQVylZGBXSg2GWy4uV6p8YYUfQS2pkY9OAeHAO9vbPE4
	7pLwiV98AAwPbBjcj6XkWTH/V+USaJEXHD8x/HxqsyNPzU+oYPwrBUkF+yvMYqy0
	jl10kwo5x5GjuDdJdqTbG2VLNkU/tCsR5d6wtBMyudMyZpGaMu+pHwKEvKb8UZQO
	dufZFKn5l7FCjs2txk7xhTmBE/Q7JPK870Xd6e+J/fDII4mvwjk0mSE/4OcUySIo
	VLv1VMdVRKOI63xn+f/gOvmjzmiqMMMPulQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791570036; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:VO4OUJi9SJNlVsqcuNkNujS+Xu+8oTTJGnVTXAnKD8lqurp
	a7yTzEIKEDJhF42pZqgSsACCbTgj30g6QhObnPnQMJaV6l/AV579HHVF7I1euuPy
	8wdfdW97IRWsupWi676APCDz3XfJ6p2jE2e7njtrPmpYES1qIdTxSCYOPkhOOgnj
	eRrpIIGhJlK5OSqkra/H/VG+eJB0yfarO4HYk+rV6BGlPhsmfiCf5A+f8RLoce2C
	/rgn3jnXo3ghhJFKrEqB7W+F+/jhhe+rkqG3RypDz4cx9CBlQnKVQRkyoBCmtngU
	TAahhmOVvgvhWYNAhNfIOfhF1v1v119unlHrlqA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:et/hk86L2aDf4/dJ37yGxDwXW1NtFgxpZEVzBOCZ22A=:mc1IK/+LuJEh2IrIRYWOfW/ZWGZukICDL0QIt6LUrCw=;
X-ME-Sender: <xms:dDDJat0v5SoyoPzZn-vEi1DA6HcC72A2Fxs7MkVOlTRYecRqIxXcdw>
    <xme:dDDJamXzH_HsmsL1OYQyFGERZr6LKPHirO_xLdDFwE0-LiYHgCMg96FVkoqswsG7b
    wN6T2IevUPvO7-D55qSg-HF9n5_TpxVmJOdqemdvDQIxr-EJfm9p9U>
X-ME-Received: <xmr:dDDJagI8p0Ea-4cxDgECBpL4ufW4zfHSGUyHa5CfqVlAg2zTCT_NaMVB4fusBaMJih2-_huedXIDwR2i_u6Kcjzp8LOv1zNCuzaH>
X-ME-Proxy-Cause: dmFkZTGVMXz5t7moeZWdP6veC1rAbxbZq0MnuluKh0zxRsgYvciEPz3ym0/UhLMVIpYPNf
    OADtxA62KumUnjNmywf0viUzi+HpI86uopEO+EH/FiuAb9nbd3XOi+oaJE0nZVQdli3/ek
    Ul6/A150Ysl/bQEu0e9CTIQOqg8H1yw+fiq/3nKjX8xlcLdQ9xJqRdA/Pg8OCKaj7N/XgF
    G2Tbl+bj2r6cNtochA2V0RXG52FNqXhSXrEsEdsENtRTULtv51eSmjxP4WNDtbTRQs1bCL
    aiE8a+I4A9i32uiGTbCE1Or/iFL9jjjUMGJYRL7UMzdWm+FsGSChLb8NxvRTmr/dLzeHI1
    NXOoWo1atI6BPztTG8Nbq5iAFDS8yGNa8CqK3VNET0kDRW0FJki+ez/pZYtBU4DtHSiqnv
    uzlKL364anrZlKnoMSybQYrDxFVEuALPsu2SlY9WkALQrD835pYj5z892s/A8pOyIkmU5q
    NiLVvdXyMfb33S+IJOGELQ0s/aiN2V1xMjGCEopQ5t6PPogPGUAV9PaCdiAPLkWxcfwXld
    Pt+ko0Ic0WusgS/6v3fCchRheI5t8fetL2tJhIqSfco6mjA7oLnxw3ymVRw+ujW4xCou+d
    ufF0lFKtkhEPkyaSFm3IqATRXpOC+XJrjZB9/0AywG4OC0nW5UT4GMhhTDmA
X-ME-Proxy: <xmx:dDDJag3HpdBupWrhNDOIVYSeZAS3WdXqDrIdn78AUQpPhrYglHzMtA>
    <xmx:dDDJau5CHNUWTUzcPgttiGwxkhJAo99d30-rPSvdJ5HKZGqYyFw6eQ>
    <xmx:dDDJah-z34pUoA34Jfh5eXz3CcCInTlYWVI4fV1cvTeSppzJVoqKcQ>
    <xmx:dDDJatV5m5JVAjjPjMeqWSmCEVp-V54US1DfRmy23cwKfxyuDP59PQ>
    <xmx:dDDJajavdR6Sbrbw_x-uD5nQRZZDr_2UNjYBXGWFaGVin363a2EyWPyt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 14:20:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Jeff King <peff@peff.net>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 2/6] doc: git-merge: link to new merge conflicts guide
In-Reply-To: <d5241eb901a2cc405bdebedc30d7e8c359898ba4.1791547213.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 09 Oct 2026 12:00:09
	+0000")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
	<d5241eb901a2cc405bdebedc30d7e8c359898ba4.1791547213.git.gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 11:20:34 -0700
Message-ID: <xmqq8q46rb0t.fsf@gitster.g>
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
> All of the info about merge conflicts has been moved to the new guide

In the body text end the sentence with a full stop.

And I just went though the "new guide" with fine toothed comb, I am
very much qualified to judge if the above claim is correct.  Let's
see.

> @@ -231,127 +232,6 @@ git merge v1.2.3^0
>  git merge --ff-only v1.2.3
>  ----
>  
> -HOW CONFLICTS ARE PRESENTED
> ----------------------------
> -
> -During a merge, the working tree files are updated to reflect the result
> -of the merge.  Among the changes made to the common ancestor's version,
> -non-overlapping ones (that is, you changed an area of the file while the
> -other side left that area intact, or vice versa) are incorporated in the
> -final result verbatim.  When both sides made changes to the same area,
> -however, Git cannot randomly pick one side over the other, and asks you to
> -resolve it by leaving what both sides did to that area.

OK.  We said working tree files are updated.  We made a weak
reference to "common ancestor" but with my suggested updates I think
we sufficiently cover this.  "Git cannot ... and asks you ..." had a
nice nuance that we may not have captured in the new document (we
stop at "will not try to guess" and say "asks you to pick" in a
seaprate paragraph, which feels a bit detached than the original
here [***]).

> -By default, Git uses the same style as the one used by the "merge" program
> -from the RCS suite to present such a conflicted hunk, like this:
> -
> -------------
> -Here are lines that are either unchanged from the common
> -ancestor, or cleanly resolved because only one side changed,
> -or cleanly resolved because both sides changed the same way.
> -<<<<<<< yours:sample.txt
> -Conflict resolution is hard;
> -let's go shopping.
> -=======
> -Git makes conflict resolution easy.
> ->>>>>>> theirs:sample.txt
> -And here is another line that is cleanly resolved or unmodified.
> -------------
> -
> -The area where a pair of conflicting changes happened is marked with markers
> -+<<<<<<<+, `=======`, and +>>>>>>>+.  The part before the `=======`
> -is typically your side, and the part afterwards is typically their side.
> -
> -The default format does not show what the original said in the conflicting
> -area.  You cannot tell how many lines are deleted and replaced with
> -Barbie's remark on your side.  The only thing you can tell is that your
> -side wants to say it is hard and you'd prefer to go shopping, while the
> -other side wants to claim it is easy.

We covered all of the above, except for the reference to RCS which
we explicitly wanted to lose.  Good.

> -An alternative style can be used by setting the `merge.conflictStyle`
> ...
> -In addition to the +<<<<<<<+, `=======`, and +>>>>>>>+ markers, it uses
> -another +|||||||+ marker that is followed by the original text.

This is what we were missing in the new guide, which I tried to
rectify without looking at this exact text.  In any shape it should
be preserved somehow [***].

> - You can
> -tell that the original just stated a fact, and your side simply gave in to
> -that statement and gave up, while the other side tried to have a more
> -positive attitude.  You can sometimes come up with a better resolution by
> -viewing the original.

We covered this with "fruits from both sides" example, and I think
the explanation there is shorter and simpler to understand.

> -HOW TO RESOLVE CONFLICTS
> -------------------------
> -
> -After seeing a conflict, you can do two things:
> -
> - * Decide not to merge.  The only clean-ups you need are to reset
> -   the index file to the `HEAD` commit to reverse 2. and to clean
> -   up working tree changes made by 2. and 3.; `git merge --abort`
> -   can be used for this.
> -
> - * Resolve the conflicts.  Git will mark the conflicts in
> -   the working tree.  Edit the files into shape and
> -   `git add` them to the index.  Use `git commit` or
> -   `git merge --continue` to seal the deal. The latter command
> -   checks whether there is a (interrupted) merge in progress
> -   before calling `git commit`.

The new text tried to have a wiggle room with "most common", but
nothing is lost from the above if we tweak it with my suggested
"there are only two" [***].

> -You can work through the conflict with a number of tools:
> -
> - * Use a mergetool.  `git mergetool` to launch a graphical
> -   mergetool which will work through the merge with you.
> -
> - * Look at the diffs.  `git diff` will show a three-way diff,
> -   highlighting changes from both the `HEAD` and `MERGE_HEAD`
> -   versions. `git diff AUTO_MERGE` will show what changes you've
> -   made so far to resolve textual conflicts.
> -
> - * Look at the diffs from each branch. `git log --merge -p <path>`
> -   will show diffs first for the `HEAD` version and then the
> -   `MERGE_HEAD` version.
> -
> - * Look at the originals.  `git show :1:filename` shows the
> -   common ancestor, `git show :2:filename` shows the `HEAD`
> -   version, and `git show :3:filename` shows the `MERGE_HEAD`
> -   version.

We covered this in "Tools for handling" section.  This version
groups AUTO_MERGE together with other tools, which may have its
advantages and disadvantages.  The latter two bullet points in the
above list is about static view, so is three-way O A B diff.  Use of
mergetool and 'diff AUTO_MERGE" are more dynamic "how far have you
come" view.  So separating the "git diff" that shows three-way
comparison and "git diff AUTO_MERGE" in the new document sounds like
an improvement (even though 'mergetool' blurs the boundary between
"how the conflict looked like" and "what your eventual conflict you
are working toward may look like", though [***]).

Overall, I fully agree with these removals.  We may want to take a
few points (marked with [***]) we learned during this review back to
the new document from here, though.

Thanks.
