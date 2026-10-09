Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A150C78F2B
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791568688; cv=none; b=qM+kFoAWxIcHjO6ivYCff20yUkWmH1ifId+qEupoFD5Sc8hbQuB708x+zgnFJMr4PHNoG7fCTMs44POp8mpsxIYzTajKFY2ulgKGMWTTHTjcFhlyE47ZO4bxalRfaM7h4uP/ETFObf5pqhjWTV7Gc4vzOVoCnpB5mlaigIL9HNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791568688; c=relaxed/simple;
	bh=isbjXD1Be5zaOZBo+J9ckwZpSbb6SxzVFSdg10kUkL8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nzcoFJgwMiu31Lx7AXvgSJ7Tq43WbWM4CByQjOTmOBcQ21C4pXYazXdmpGzPs0QUL83MSt3zTS9VnQ7YIGIbZBmAG8r1QT8c5b2QZIS5ZqViZ9vqugqgxwnqk1jyMAEVvwTQsBWZc9zDAfNmhVInSDYrksCUzjHMry8eDFOj1Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TJj3Fw0o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LTXdtJ4l; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TJj3Fw0o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LTXdtJ4l"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A8A80EC02B4
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 13:58:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 09 Oct 2026 13:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791568684; x=1791655084; bh=f9nMT+7t1Y
	1oAhVdFs0eceT6j/edYooHdJmbBBm886U=; b=TJj3Fw0o4Z8PvfcBX/0VSog2B9
	21ddzAEWgntnNqSUvYPNbmrupl34GxcNNbnEasv7qh6xRs0ThufyXiUGE6hnPg5Q
	A5EjaOKZ/a+AOuyF3hHetFz4HJGlj29/wPOQ8hvpe2CsZegQCRTLHFGfkC14NiK1
	LIEzqsW1ckP9QZPRgwSM4tA8MSA58xkQzMBexmziifDbCBSvV7JAcUBv53+yagZi
	L+Ahqa6mJt2+lVsnK8nOEq+KkqKqrenanAhqX+UchYVpgRc1ewswWxElkZQ38QK5
	w4MLMjECqLdLzMHSBmmXiyHXU/qwvuMnzyNLSB/7T5PuBx1Tn6AqUY9pnJhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791568684; x=1791655084; bh=f9nMT+7t1Y1oAhVdFs0eceT6j/edYooHdJm
	bBBm886U=; b=LTXdtJ4lNrKN/JeL34HLdQjlzVMImpuqyK9vePILk9exX0JUAB5
	eGlQtGRi5N7z11WeMjLe2nG9+O0tShCvYhfeufgqkMg2Ivbcco0AG71cF0f8BQT4
	yqmLZ3gx+PR4IMk57nuRDCkmEE+b5XPZPBgU0j8gisQ7Kf2bJ3Ijt9TeEc5inuUd
	z0Ntp/D5dbDfrPccGWVhJMm0PEocSB8Da771jsHD7n17A6e8FfoSxgzS/BpqtStB
	R60tMZ2TV5knGg0PH/3ZukL00l/9UATfpXFjlCPwow33HGjx3VHZi56Qq32XE3v5
	2+idBANuzedac+krPZdEk375ewmL8JZ7Kfg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791568684; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ZyGo4k/7YQYNpRTXiYxc5yBeD6Px0XHM7wxW922T7Ul7Fp9
	kZYY+/5E5wqRKJPVT56yLwBBXhzikHGBpPTniByaO8jf4k4zwZB7b9UKrO/ivqtm
	dbfg83Q4FFUmy5dqjv9duMAkU3F1PiOY3mjE/4v+X/AOYhlm/k3v+ctH5wR5DEUr
	GBMCZ3nVvkBR29Y7vIpgcqUdiSpI2cFqQkLGjOimtGvCghtha6LbPGZrjnb7zKFm
	K4/kk4oRb3dvRbM/ssuxRLXUj2GnnAMdoDr0Sy3EYJsTC6rUqnKvzEUOB/KKArg4
	woIFxlkiqX3/y0L8BjIi6Kt4MAw6CRvlhwFpTRA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:wQKP5dgASoK70swe5HsdR/kCuRoydx/zaT0flQZ5QhE=:isbjXD1Be5zaOZBo+J9ckwZpSbb6SxzVFSdg10kUkL8=;
X-ME-Sender: <xms:LCvJatgKjChB-XmMAv0aG_g8I4lgCEADrV7M2hUPHxMNgEWiiwwWQQ>
    <xme:LCvJakSyTGPYvA-A23KeWIgLu26odz7zNczS2rbPFktlSsNMwpQPI7t8zdXx4hC63
    QKn2g8dqBEOt_xIIho34l-rqFxFbenNnGxF1oi6j1ZKBa74POwpUqQ>
X-ME-Received: <xmr:LCvJavXaxGmSubC6YvrkMgOx26qNU5TJZDNA6Gf_EXjIB-96cv-t2d-QXMCc7Fj-_D9xy72TMQs6qleQQ_Nn5xXhPX4gTaw4z7L4>
X-ME-Proxy-Cause: dmFkZTE5fV2n0+KbHxmWzO80Kxth4Eo/BxzsASNl4+ctMw80TbsayYIHu+BorkCTd5eGts
    J5eOxwY8T+P5QCv/VBqxfLazZ4DxCNPWDpGjoAuS+mfWYMYWLVj7cERJQIM/eZMrswQgL1
    f2/iynXigTojLrNWpajzPXGoS++BGsjC6DoEfoLx6Hakyv19SelBuIZIxIu7mYvVFaBKTE
    YcLsPmbYAeTJI1nrS3qF/Jf2QTEOojtTlFPZn7brv3J4VhukLSAcWyRgujYUEL3rjNWor+
    5FmTT62+mV/9xS62MGEmLv4mokcZsWSNx0dtCme1VZHRJ6HLQJJ0hchoOH1D9MHNE71Lo4
    BdZVFHjyZ5+X1bA4sZKlBcRLbj9RvFYqGj9eZB4tU1hDwGsFnlfGtpGxs60wNHhpA6ay/9
    /c12iBRP/otdP0Rrl6FWevDnTPpOk+Gp5vSoDbsBOPaiaNfmXwRrIaYvLUfNsGcVhujunW
    KiO46VyBdvqKtz/RZdw2PdhX2tJyJAKDt11JI2SiXKE3IdRD3gkJAUoVBFsqgiDkQpqM2J
    yimM1frtcjFCBGUWbxnWsTtlaNE2LColSSvhAQB0OA8dQ4Z8+upjzpEkoewKlqnS4/Q6EQ
    Y/3/j3ztg1fV5dly+S94xQCwvsxsZtCMaxD+7+3EhBHrIhHgeAGWCV0yK+HA
X-ME-Proxy: <xmx:LCvJaoTGFMR8UrI7IMGSleeeHyOkUxSWpjR820tWzvhdtyYNj00HBA>
    <xmx:LCvJapnyl-hrAmtEa3MXb9yz4NU4aH0oKammECQOnCW0fTm7DWKlCg>
    <xmx:LCvJau4gATIYdUh1KqC8jJuzEc_V79nRxEQEhThBxT88c8hTmZ93eA>
    <xmx:LCvJavg0U4HU7h8hWu6KJ2leW8S44aICN-fGRtcvpXqbGgJvrkOt4w>
    <xmx:LCvJaqV48OV8SbseBoUiSqfMjhaym6-vUDgos9DWScnGV7KY36MNAitw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 13:58:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Jeff King <peff@peff.net>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 1/6] doc: add new gitmergeconflicts man page
In-Reply-To: <ab0344f947c252b1b7c8bb386586b8641223ba38.1791547213.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 09 Oct 2026 12:00:08
	+0000")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
	<ab0344f947c252b1b7c8bb386586b8641223ba38.1791547213.git.gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 10:58:02 -0700
Message-ID: <xmqqik3arc2d.fsf@gitster.g>
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
> Introduce a new page, `gitmergeconflicts`, that explains the process of
> handling a merge conflict in a way that addresses the following issues,
> which came from feedback from Git users on the current explanation of
> merge conflicts in the `git merge` man page:

Good goal.

> - The process for resolving a merge conflict is only explained in the
>   `git merge` man page, even though there are several other commands
>   which can result in conflicts
> - Sometimes we use "ours" and "theirs" to refer to the two sides of
>   the merge conflicts and sometimes we use HEAD and MERGE_HEAD. It should
>   be consistent. Also the terms "ours" and "theirs" are not explained.
>   Similarly, it says "The part before the `=======` is typically your
>   side...", but doesn't explain what "typically" means.
> - It introduces the merge format using an analogy to RCS, which very few
>   Git users have ever used
> - In "The only clean-ups you need are to reset the index file to the
>   `HEAD` commit to reverse 2. and to clean up working tree changes made
>   by 2. and 3.", it's not clear to users what "2" and "3" are supposed
>   to mean
> - It uses a cultural reference ("Conflict resolution is hard; let's go
>   shopping.") which is confusing or unfamiliar to some people. I think it
>   would be clearer for users to use a code example instead.
> - It doesn't explain the difference between diff3 and zdiff3
> - It sometimes uses the term "area" and sometimes uses the term "hunk"

It is a bit hard to evaluate this list, as we do not see any of the
above problems excised from the existing documents in this step.
But at least we can verify that the new text presented in this patch
does not fall into the same trap as above, so I'll keep that in mind
while reviewing this step.

> Also document the unified `--abort`, `--continue` workflow in one
> place, since it's a really nice example of a place Git has a consistent
> interface between similar commands.

Great.

> Co-Authored-By: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
> Reviewed-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> Reviewed-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Julia Evans <julia@jvns.ca>

We want a sign-off by the coauthor, too.

> diff --git a/Documentation/gitmergeconflicts.adoc b/Documentation/gitmergeconflicts.adoc
> new file mode 100644
> index 0000000000..5b0ba1a1de
> --- /dev/null
> +++ b/Documentation/gitmergeconflicts.adoc
> @@ -0,0 +1,333 @@
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
> +cherry-pick`, `git pull`, or `git revert`. All of those commands use
> +the same merge algorithm, and the process for resolving a merge conflict
> +is always very similar.

Is it deliberate to omit 'am -3' and 'checkout -m', perhaps in order
tolimit ourselves to most common ways to help new people by keeping
the description to the absolute minimum?

Or were they just overlooked?

In any case, the first paragraph clearly stating that conflicts
happen with operations other than 'merge' is a very welcome change.
On this list, we often say "mergy operations can cause conflicts",
with the understanding that readers know what mergy operations are
and "conflicts" alone can convey the state you call "merge
conflicts" in this document.  But in a document for end-users, using
a longer term "merge conflicts" instead of "conflicts" and avoiding
"mergy operations" like you did above may be a better direction to
go.

> +The most common ways to handle a merge conflict are:

A natural paraphrase of the above is "A merge conflict is typically
handled by these ways", but I thought the current readers are
puzzled by "typically your side" that does not say when is typical.

> +* Resolve the conflict. (see <<resolve,HOW TO RESOLVE A MERGE CONFLICT>>
> +  below for details)
> +* Or stop the operation and return your branch to its original state
> +  with the appropriate `--abort` command, for example `git merge --abort`
> +  or `git rebase --abort`. See <<git_status,EXAMPLE: GIT STATUS OUTPUT>> below
> +  for how to find the command to run.

Both are good options and I do not think of a middle way.  Perhaps
we do not have to say that these are "the most common" and instead
say "You handle a merge conflict by doing either of these two"?

Saying "return your branch to" is a bit misleading for two reasons.
Conflicts presented to the users are primarily visible in their
working tree files and the index.  A single commit operations like
'merge', 'pull', and 'revert' does not touch your branch if they hit
a conflict, and 'rebase' works on a detached HEAD, and stops without
touching your branch when it sees a conflict.

If I were writing this, with the goal of avoiding the issues the
current text has you listed in the proposed log message, I would
probably say something like this:

 * Or give up and return to the original state with ...

> +WHAT IS A MERGE CONFLICT?
> +-------------------------
> +
> +When Git merges two commits together, it looks at the changes that
> +each side has made and combines those changes. For example, if one side
> +edited lines 1-5 of `hello.py` and the other side edited lines 20-25 of
> +the same file, then it can easily combine them since there's no overlap.

Many of the operations, even "git merge", is not about merging "two
commits" together, but I do not think of a good way to explain it,
so I accept that phrasing as a helpful white lie.  I mention this
because somebody else may be able to come up with a better phrasing
that I (or authors of this iteration) couldn't think of.

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

By the way, I think we should briefly mention what sematnic merge
conflicts are, and that Git does not detect them and that this
manual page does not tell readers how to deal with them.
    
    Note that non-overlapping changes from two sides may leave the
    result in an inconsistent state.  With the edit to lines 1-5,
    one side may have changed the name of a function, while with the
    edit to lines 20-25, the other side may have added a new call to
    the function by its original name.  This type of inconsistencies
    are called semantic conflicts, Git has no way knowing that a
    merge introduced semantic conflicts, and ends up producing a
    broken result without merge conflicts.  This document does not
    cover what to do with semantic conflicts.

That is overly long, but perhaps you can condense it down to the
essense and shrink down to 1/3 of the size.

> +[[markers]]
> +MERGE CONFLICT MARKERS
> +----------------------
> +
> +When there's a merge conflict, Git will update the conflicted file
> +to include merge conflict markers `<<<<<<<`, `=======`, and `>>>>>>>`.

I notice that when you introduce `diff3` below, you silently add
`|||||||` to the mix without explaining what it is.

    `|||||||` may also be used as merge conflict markers (explained
    later).

or something along the line here may help.  Or explain what it is in
`diff3` section.  Either would work.  Adding without explanation
would not.

> +For example, here's a merge conflict where both sides edited a list of
> +fruits in different ways:
> +
> +----
> +FRUITS = [
> +    "apple",
> +<<<<<<< HEAD
> +    "cherry",
> +=======
> +    "banana",
> +>>>>>>> add-fruit
> +    "mango",
> +    "orange",
> +]
> +----
> +
> +The code from one side of the merge conflict is between `<<<<<<<` and
> +`=======`, and the code for the other side is between `=======` and
> +`>>>>>>>`. See <<ours,"OURS" AND "THEIRS">> below for a full explanation
> +of which side is which.

If we said "one side wanted to have 'apple, cherry, mango, orange',
while the other side wanted 'apply, banana, mango, orange', in the
FRUITS array", would it help the understanding?  Or is it too
obvious?

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
> ++
> +Note: During a `git merge`, `git commit` and `git merge --continue` do
> +the same thing.
> +
> +
> +[[example]]
> +EXAMPLE OF RESOLVING A MERGE CONFLICT
> +-------------------------------------
> +
> +If you see this in your code during a merge conflict:
> +
> +----
> +FRUITS = [
> +    "apple",
> +<<<<<<< HEAD
> +    "cherry",
> +    "mango",
> +=======
> +    "banana",
> +    "mango",
> +>>>>>>> add-fruit
> +    "orange",
> +]
> +----

It would make your readers puzzled why the example is subtly
different from the earlier one that showed "mango" as not touched by
either side.  I see this lays the groundwork for later demonstration
of `diff3`, so having both sides explicitly want "mango" is a good
example.  Perhaps update the first example to be the same as this
one, which would reduce the mental burden by readers?

> +
> +Then you might edit that part of the code like this,
> +which includes the fruits from both sides of the conflict:
> +
> +----
> +FRUITS = [
> +    "apple",
> +    "banana",
> +    "cherry",
> +    "mango",
> +    "orange",
> +]
> +----

OK.

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
> +* You can set the configuration option `merge.conflictstyle=diff3`.
> +  See <<diff3,DIFF3 AND ZDIFF3>> below for more.

These are called 'configuration variables' throughout the manual
pages.  Be consistent and replace "configuration option" with
"configuration variable", perhaps?

> +* `git log --merge -p <filename>`  will list all commits which
> +  caused the merge conflict for `<filename>`, and the diff
> +  of how they changed the file.

Maybe worth mentioning that `--left-right` often helps when you are
not super familiar with the histories being merged.

> +* Look at the original files.  `git show :1:filename` shows the
> +  common ancestor, `git show :2:filename` shows the "ours"
> +  version, and `git show :3:filename` shows the "theirs"
> +  version.

Maybe it will help to say we will explain "ours" and "theirs" later
in this document.

> +Here are some ways to track your progress while handling a conflict:
> +
> +* Use `git status` to get a list of files with conflicts
> +
> +* Use `git diff --check` to make sure you haven't left any merge
> +  conflict markers in a file by accident. It will print "leftover
> +  conflict marker" if it finds any.

Good.  This also complains about whitespace errors, by the way, but
the last sentence here would be sufficient to help the readers to
tell them apart.

> +* Use `git diff AUTO_MERGE` to show what changes you've made so far to
> +  resolve the conflicts.

Does a "See below" here help readers who haven't learned what
AUTO_MERGE is?  If you can describe what AUTO_MERGE records (in
other words, what you are comparing your progress against) in a
sentence of two here, that would alleviate the need to assure them
that we have more in-depth coverage on this topic elsewhere.

> +[[git_status]]
> +EXAMPLE: GIT STATUS OUTPUT
> +--------------------------
> +
> +When you're in a merge conflict, you can find out what commands to run
> +to handle the conflict by running `git status`.
> +
> +For example, this `git status` output tells you that:
> +
> +* `git rebase --abort` will safely bring your branch back to its
> +  original state
> +* you should run `git rebase --continue` when you're done resolving all
> +  the conflicts
> +* there's one file left with conflicts in it: `fruits.py`

There may be users, after seeing the last point, left puzzled why
fruits.py is still listed after they edited the file like instructed
in an earlier example but haven't marked the resolution.

    `fruits.py` is not marked as its conflicts resolved yet.

or something?

> +----
> +$ git status
> +You are currently rebasing branch 'main' on '58a9fcc'.
> +  (fix conflicts and then run "git rebase --continue")
> +  (use "git rebase --skip" to skip this patch)
> +  (use "git rebase --abort" to check out the original branch)
> +
> +Unmerged paths:
> +  (use "git restore --staged <file>..." to unstage)
> +  (use "git add <file>..." to mark resolution)
> +        both modified:   fruits.py
> +----

The approach to give explanations first and then an example the
explanation explains next is refreshing to me.  As long as the
explanations are short enough, this may work better than the usual
order to say "you'd see something like this. let us explain ...".

> +[[diff3]]
> +DIFF3 AND ZDIFF3
> +----------------
> +
> +By default, Git doesn't include the original code when formatting
> +a merge conflict. To include the original code, you can set the
> +configuration option `merge.conflictstyle` to `diff3` or `zdiff3`.
> +This extra context can make it much easier to understand what's
> +happening in a merge conflict.

I think most on the list considers `zdiff3` a failed experiment that
reduces usefulness of `diff3`.  Do we want to recommend it?

Is it obvious to readers what "original" we are talking about?  We
are not talking about the state we started the mergy operation from.
We are talking about what the common ancestor had before two sides
started working on the text to cause the divergence that conflicted.

One way I can think of to resolve this is to back to "What is a
merge conflict?" section and introduce "original" right there.  I'll
SHOUT my additions below:

    When Git merges two commits together, it looks at the changes
    that each side has made SINCE THE TWO SIDES DIVERGED and
    combines those changes.  WE OFTEN CALL THIS STATE THEY DIVERGED
    FROM THE "ORIGINAL".  For example, if one side edited lines 1-5
    of `hello.py` and the other side edited lines 20-25 of the same
    file, then it can easily combine them since there's no overlap.

If you later use "common" or "common ancestor", you can explain they
are "original" we defined in the above paragraph.

Or ...

> +Here's an example of what a merge conflict would look like when using
> +`diff3`. It shows, in order, the "ours" side of the conflict, the
> +original code (`"mangoooo"`), and the "theirs" side of the
> +conflict. With this view, you can see that both sides fixed the spelling
> +mistake in "mango", and each added one fruit to the list.

... perhaps you avoid "common ancestor" altogether, with the
intention to deprecate it, and introduce "original", like in the
above paragraph?  That is fine too.  Once we establish what to call
"common, ours, theirs", we should add them to glossary-contents, as
I do not think we describe any of the ones we currently use there.

As I already mentioned, just like you said <<< === encloses your
side and === >>> encloses their side in 2-way conflict display,
we need to say <<< ||| encloses yours and ||| === encloses common
in diff3 output.  How theirs is shown remains the same.  Here is my
attempt to do so with least disruption to the flow of the text.

    Here is an example of what the same conflict might look with
    `diff3`.  It uses a new separator `|||||||` before `=======`,
    and shows, in order the "ours" side ...

> +----
> +FRUITS = [
> +    "apple",
> +<<<<<<< HEAD
> +    "cherry",
> +    "mango",
> +||||||| 1c22e48
> +    "mangoooo",
> +=======
> +    "banana",
> +    "mango",
> +>>>>>>> add-fruit
> +    "orange",
> +]
> +----
> +
> +Here's the same example using `zdiff3`. `zdiff3` takes lines that are
> +shared between both sides (the `"mango"` line) and moves them outside
> +the conflicted area. This makes the conflicted area shorter, but the
> +downside is that it's impossible to tell if `"mango"` was part of the
> +original list of fruits or not.

Yes, exactly.  That is why I think we shouldn't promote it, but
write it off as a failed experiment, and just tell them not to use
it in this document, without giving an example.

If the original were "apple, banana, cherry, mangoooo, orange", and
ours and theirs were the same as the above example, then a desirable
conflict resolution would be "apple, mango, orange", because both
sides knew the original had banana and cherry, and each side
rejected one of them each.  It would be a good demonstration of why
`diff3` is a better format than `(rcs)merge`, so if we were to spend
lines on an example, I'd rather see it here, instead of zdiff3 example.

By the way, is it just me who finds those "Here's", "there's"
contractions disturbing in an official manual?  I've seen many of
them while reviewing this to be annoyed enough and had to blurt it
out X-<.

> +[[ours]]
> +"OURS" AND "THEIRS"
> +-------------------
> +
> +Sometimes during a merge conflict, Git will use the terms "ours" and
> +"theirs" (or "us" and "them"). For example, `git status` might say that
> +a file was `deleted by us`.

OK.

> +"Ours" and "theirs" are both commits: "ours" is the current
> +`HEAD` commit, and "theirs" is the other side being merged.

Now, "commits" is again a white lie.  The story becomes more
complicated when we talk about cherry-pick and revert, but if we
primarily stick to what happens in 'merge' (which is what I've seen
so far in this document), then it shouldn't add any extra difficulty
to understand by saying "ours and theirs are history of changes
leading to the two commits since they diverged from the original" to
add clarity.

> +The first part of a merge conflict (between `<<<<<<<` and `=======`) is
> +from the "ours" side, and the second part (between `=======` and
> +`>>>>>>>`) is from the "theirs" side.
> +
> +----
> +FRUITS = [
> +    "apple",
> +<<<<<<< HEAD
> +    "cherry",                      <- ours
> +=======
> +    "banana",                      <- theirs
> +>>>>>>> add-fruit
> +    "mango",
> +    "orange",
> +]
> +----
> +
> +During a rebase, it can seem "upside down" because the "ours" commit is
> +from the branch you're rebasing on (for instance `main` in `git rebase
> +main`).
> +
> +These terms in Git all mean the same thing when dealing with a merge
> +conflict:
> +
> +* "common ancestor" and "base". The files from this commit are "in stage 1".
> +* "ours", "us", and `HEAD`. The files from this commit are "in stage 2".
> +* "theirs", "them". The files from this commit are "in stage 3".
> +
> +If you're confused about what something like "deleted by us" means, it's
> +often easiest to use some of the tools from
> +<<tools,TOOLS FOR HANDLING MERGE CONFLICTS>> above to get more context.
> +Finding the commit that deleted the file and seeing why is usually more
> +helpful than trying to abstractly reason through what "us" means.
> +
> +[[automerge]]
> +EXAMPLE OF USING `AUTO_MERGE`
> +-----------------------------
> +
> +`git diff AUTO_MERGE` will show what changes you've made so far to
> +resolve conflicts. `AUTO_MERGE` is a reference that Git creates during a
> +merge. It contains the result of running the merge algorithm.

The first sentence gave me "Huh?  You haven't explained what
AUTO_MERGE is yet".  It may be just me, but I would have expected
presentation order to be more like:

    When merge conflicts happen, the result of merge algorithm,
    together with conflict markers, is recorded in AUTO_MERGE.  As
    you resolve conflicts, you can compare your working tree files
    against it with `git diff AUTO_MERGE` to see your progress.

> +For example, if we resolved the conflict by adding both "banana" and
> +"cherry" in order, the diff would look like this:
> +
> +----
> + FRUITS = [
> +     "apple",
> +-<<<<<<< HEAD
> +-    "cherry",
> +-=======
> +     "banana",
> +->>>>>>> add-fruit
> ++    "cherry",
> +     "mango",
> +     "orange",
> + ]
> +----

Thanks.


I was puzzled by this

> - In "The only clean-ups you need are to reset the index file to the
>   `HEAD` commit to reverse 2. and to clean up working tree changes made
>   by 2. and 3.", it's not clear to users what "2" and "3" are supposed
>   to mean

and did some digging.

The text comes from ffb1a4bed5 (Documentation: Describe merge
operation a bit better., 2005-11-28) that had "When there are
conflicts, these things happen. 1. HEAD does not move, 2. Cleanly
merged paths are updated in the index 3. Conflicts are recorded in
higher stage index entries and working tree files show conflict
markers, 4. No other changes are done" well before the mysterious
reference to 2. and 3.

When ebef7e5049 (Documentation: simplify How Merge Works,
2010-01-23) tried to simplify the description, the list of "these
things happen" were removed/rewritten, and yet instructions on how
to reset are left behind, still referring to 2. and 3.

We probably want a separate patch for Documentation/git-merge.adoc
to rectify this 16 year old mistake.
