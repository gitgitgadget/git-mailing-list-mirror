Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A37A40BCA1
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791829020; cv=none; b=qOENozabYwaHZrESJs8aX0JfXW1BLCn5qLv/VKZF0mXvy070600p1++N6cYZD8ZyEWpZ1jnKOXYzjol60A84YjnEZO4gIcHtIidDEXi7Yq6FJaSo4saykg1Uivc0EdyIcGIj6A4b/aRttzRNi37O8KgmRwHYHE9CU+MTlWWAFxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791829020; c=relaxed/simple;
	bh=CM1lyxKinOm9j4FWNgz7UU+mWuy6BNiGNlM/ZYqWMIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bVVO3d/CyrgppSQd99qJnTSruFkK3tEiXuBH5LDUmkrSWO/6LhGCEYGig3Cmf91akz7Ot6IA/jz/6bIuPwbJ3MVX2Dbjl03C0uzJUvoKoc4guWmi8ImmfZJ2Ljrh/iTDiBYYSYyJLFkOBjtMuRD+qPQlwl+aBJZRnocp5VxKAJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HBNQwqjb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dBBQm23W; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HBNQwqjb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dBBQm23W"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 82D0A1400120
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 14:16:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 12 Oct 2026 14:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791829017; x=1791915417; bh=fGoye4LKuf
	aKaWfeybVBkvejc7EGHpECCJa3OgwdNP4=; b=HBNQwqjbe0wbkXpRBACVqozLnE
	cdGW4D8gRPHgw5tXaZEoLe0DG0Ys0e5f6nEiHi9LpazV38AJEzuy9xe4iIxexd/5
	5vEx3lCTycLOI5ibhcdRV6JQhqqM3Dw+MjCupJOIyi/VP1TtrK4QU0XKFbHxwGmo
	GuJ9YIFsSIYTIbMv9RhLGb6OcShq5df9nIO3tdekekDT+zeqp4t0P5dTlH0LUo0e
	hQYY/ehzADOWOl3QjR/WEIIFrPMZdGMcwnsC8qc1qjUBZ8DqUSAhgP7+RN98TEq1
	Pf5MhzW0bZPbeZfzlS2BvFB/kmAiqT/39ZIOpXBQ1aAFe+zdoFkTLJjTMU8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791829017; x=1791915417; bh=fGoye4LKufaKaWfeybVBkvejc7EGHpECCJa
	3OgwdNP4=; b=dBBQm23WELaGKBC8tcdiCH9RACt9sdDNFnQwU4SPIjA1Opi7aWq
	IES3XtV8peiqs3PYwZGoReWPXV+w7LEqo+EaYADyrOkl6Rz6HZXmw1oqCOW/R27x
	qPVo8iyHeKsA5yMz13sdDih/GmKki83hOGiFD3s7xoX0mKj8LOp/2yIfgyCmygVq
	qFf5wDb7VKTisbXOn8aytAF9Iz1FWNRUYZeoFhPXBYIQDJsvQ0h2d8qNrmbRjFjz
	xo6lS3pZtCLmndod831cEPZyZ7VeIm8VsKzEhA0nrDvv3t7xLzdDCZ3RPNQVEHTl
	C9Gre9ShhjdnEnkudo1+lCX9ZrctK9l/dQg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791829017; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ohxPOjL3kHGoijK2FEtfFFOldnU7VGzk0Sd3fiQ1587oq0n
	Pmy9r8F2j0Xuio116LocryMPGkYfyNqZ98kiwG1KlsSWHqhHsw8FYC8Si1U3q9uJ
	AcmmRh0H5Jxi+ldAkH2JJu6MSBEmDdw1hlnZLneIQYjrfILYFDj1K6fDB3rXuQaK
	JimXmUR2G4uiZ7CKN8CwFXH9zc5ZIucK+hP4nTlRmK83xCNF+sPhJv77r+GCsNcz
	/d398VWskWoCTWXAZjHRlbn2nDXvV+FtwlFcBtSbK2Dh235Pvd60lPZiyOiCeToi
	XRddO2IaeAMzJ9BBuco+NAnJQAyDAowMnFWiV+g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:tBwlZdCVwkfwP23st7K68EhOpeHPTLehD10uxOKJ/3k=:CM1lyxKinOm9j4FWNgz7UU+mWuy6BNiGNlM/ZYqWMIQ=;
X-ME-Sender: <xms:GSTNaj0Fj-KnZchfCXbYyMiBMtstu7dXrp41O26f866oiU4MJRVw_g>
    <xme:GSTNakUNpK7OOIFfu6bitpwYKGjgfF85uv3Mhz5UGLDlh_wxb50GUmZZ_32zmz6Tk
    Kf5t_1cGHNNcovIVQhIrYsG0W-5KZNv8FYE7SXk8wqOYsvojT_YKQ>
X-ME-Received: <xmr:GSTNamKApbzcnJMg-Ea3n4DCvsmV2mJ-L2IB5gkU49TguTOFJsrdEN0bGMwOE4DKs4egwSb7BmsoOEMDPfLtC5JYTM5RyVcstFRR>
X-ME-Proxy-Cause: dmFkZTFFqSO2LKs3FckOk5CdoiVyde2d+7S7fo+DRZT6GuiRqdKHaftVnwE4nrWE+iNotg
    nfTMS3g/TmDdaS0aTJSTfC0LScwz6odRxsOxm6lEuPckW7MQsD8BEPESQTcNQMJKNORywq
    mkLChMAUwTEGX82GxlUQB0OdPR6Vd4BFyKCZptzqgh7GSyJc5ivi70YMrsrlMlQH1Qnktp
    h/ZY9m/XwI62y/YQF9qvHZqx5LvWqHffFJlhV/9HN5DF7ScI1+0bPeMLQU+4o3MC4MHPUD
    +PGCw7ruDRKjgcEOfk7GJFnN6QDsaN725IcrKf0soc8/jdRzSOjPBy2SwgryWpCzrD9mtn
    6vmNvvczmj+YlYDs2oA8SO4udLwfx1tFLIW88/TXypoIPGR6cOWxIIwA3Pis+jD/WkoPwW
    SkRFJ5jr4WcLt+Lf3MnsCBDP3HnYa9jtNIexiUTuouqqkaf2wOIQNUkmMMY/mb6tPXnl4h
    Y88VzOC6q5GckG+jUbOL2rb2bsnJte+5Fv3/PEm8LOnaO60ol84GQp98zp3wDoBOG/bV+N
    Ui/ITWnN38g+wCkNOI+zi22KLph1yMGtAofN0x20gTkItMwoTBJ6ktZU1EaGUkeUY5OTp7
    V+KYnHtRFFN4U9u41pdg8JUj3Ub3/BPZp7X0GAAT8ch7EaSFjsC29zykE55g
X-ME-Proxy: <xmx:GSTNau0j1-gW8EOS74b5PxJs152Jt0k_CxvACeyMRgGmcN2I4zb0Vw>
    <xmx:GSTNak4OEloIULn3deiUOXhxaArbW-o8a3hm4_KprVTQe-FGIXOAKw>
    <xmx:GSTNav-Kv7h7pAooHskpeCHre58NE3T9bDAeIe5-Bxjw1XD8XYpgvQ>
    <xmx:GSTNajWkXXk_hoWQwcLBef1-mb8WGQ6xHR5HphZypsHNMrRzc1Q1Pw>
    <xmx:GSTNahY7qB8kq0pAGuvOEas6A0NsOXlKRMFH03eqEKgF0KO41jnYfkCp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 14:16:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Jeff King <peff@peff.net>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v3 1/6] doc: add new gitmergeconflicts man page
In-Reply-To: <7aa0ae7ec3c1d02aa1533c27fa40f4815c03ba6e.1791816795.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Mon, 12 Oct 2026 14:53:10
	+0000")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v3.git.1791816795.gitgitgadget@gmail.com>
	<7aa0ae7ec3c1d02aa1533c27fa40f4815c03ba6e.1791816795.git.gitgitgadget@gmail.com>
Date: Mon, 12 Oct 2026 11:16:53 -0700
Message-ID: <xmqqwlrm7pii.fsf@gitster.g>
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
>
> - The process for resolving a merge conflict is only explained in the
> ...
> - It sometimes uses the term "area" and sometimes uses the term "hunk"

It looks a bit annoying that these sentences in the enumeration all
lack their full stops.

> Only discuss merge, rebase, cherry-pick, and revert for now even though
> there are other ways that merge conflicts can happen because it's
> awkward to talk about `am`, `apply`, and `checkout -m`.

I do not know "because it's awkward" is a good justification,
though.  "awkward" why?

It might be tempting to omit some commands that are less common for
new users, but we are touching the main part of the technical manual
that are meant ot be used by everybody, so that is not a good reason
to choose covering some but not others.

I however agree that it is better to avoid appearing to be complete
and leaving others (including future ones we add) with "any other
command that does a merge" as this round of document gives.

> diff --git a/Documentation/gitmergeconflicts.adoc b/Documentation/gitmergeconflicts.adoc
> ...
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

The third entry is a nice addition.  multi-step anything are the
same, including revert, right?  I'd recommend updating it to
something like "if you are in a multi-step operation like `rebase`"
in the same spirit as the "or any other command" change you made at
the beginning of this file.

> +[NOTE]
> +================================
> +Even if Git successfully merges both sides with no conflicts, it's
> +possible to end up with code that doesn't work. For example, this can
> +happen if one side renames a function, and the other side adds a call to
> +the old function. This is called a "semantic merge conflict".
> +================================

OK.

> +When there's a merge conflict, Git will update the conflicted file
> +to include merge conflict markers `<<<<<<<`, `=======`, and `>>>>>>>`.
> +For example, here's a merge conflict where both sides edited a list of
> +fruits in different ways -- one side added "cherry" and the other side
> +added "banana":

You added "-- one side added ..." at the end, which I think sends a
wrong message.  With rcs-merge style conflict, you cannot simply
tell, because it is ambiguous.  The original may have had both
banana and cherry, in which case the sample output shows the result
of one side removing banana and the other side removing cherry.

The only thing you can say from the sample output below is in the
current state "one side has cherry where the other side has banana,
and everything else is the same".  You cannot say more without
seeing diff3 style conflict.

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
> +=======
> +    "banana",
> +>>>>>>> add-fruit
> +    "mango",
> +    "orange",
> +]
> +----
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

So, this is one possible resolution.  We cannot tell if it is the
correct one.

> +[[tools]]
> +TOOLS FOR HANDLING MERGE CONFLICTS
> +----------------------------------
> +
> +Here are some ways to get extra context while handling a merge conflict:
> ...

The incremental changes to this list looks good.

> +[[diff3]]
> +DIFF3
> +-----
> +
> +By default, Git doesn't include the original code when formatting
> +a merge conflict. To include the original code, you can set the
> +configuration option `merge.conflictstyle` to `diff3`.
> +This extra context can make it much easier to understand what's
> +happening in a merge conflict.
> +
> +Here's an example of what a merge conflict would look like when using
> +`diff3`. There's an extra section (between `|||||||` and `=======`)
> +with the original code.
> +
> +With this view, you can see that both sides fixed a spelling
> +mistake in "mango", and each added one fruit to the list.
> +
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

THis is a great example.  

But an even better example would be to give this:

        FRUITS = [
            "apple",
        <<<<<<< HEAD
            "cherry",
            "mango",
        ||||||| 1c22e48
            "banana",
            "cherry",
            "mangoooo",
        =======
            "banana",
            "mango",
        >>>>>>> add-fruit
            "orange",
        ]

and tell the readers that that the correct resolution is to have
"apply, mango, orange", as each of cherry and banana was removed by
one side while the other side did not touch it.  Having cherry and
banana in the result is a tempting but not always correct conclusion
unexperienced people would draw from the rcs-merge style output that
is ambiguous, and here is a great place to teach it in this flow.

Especially because it would make it stand out that the point of
diff3's verboseness compared to the rcs-merge output is to
disambiguate two cases.  If you start from ABCmO and one side has
ABMO while the other side has ACMO, the right resolution would be
AMO (the above case I added), but if your starting point were AmO
and the two sides ends with ABMO and ACMO respectively, the right
resolution would be ABCMO.  The rcs-merge output does not tell you
which is more likely to be correct, diff3 disambiguates these two
cases by being more verbose.

And telling that value of diff3 is about disambiguating is valuable
when ...

> +[NOTE]
> +================================
> +`zdiff3` is an alternative to `diff3` that makes the merge conflict
> +shorter by making it more ambiguous.
> +================================

... this note tells the readers that zdiff3 is a ambigous variant of
diff3, hinting its flaw.

