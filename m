Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729913EDE7C
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791582867; cv=none; b=oXpcpxl8aQk98fDmk1mFVnXFrgS6fjcxtpB7jDAuxkZCLCEMuC3CTIZQIPYJej+GmBiYbZMXFhKpNWy6TDptn5yZ3kK/TKV74Yg1v0csgyX2K+DBP1vRJGVguuzvdMjixOV/Dwsq29A0P2LgwaE4MX1QxeAahHs39ORxIe0hf18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791582867; c=relaxed/simple;
	bh=0z2fnYm16KfvsJCKuBAucTr4xAtK3Tb7v+Kum5WiMWE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PeI2L5flkrGTBJ2qTZ3nf7MUiVywRZql2PLmfDsH6lbfnRNPja/AlPmD8M/WP7jDuQ3STD7iT+ecoghu6YZ+e9sxfE533i14eQ0y4oFjV7PcIX/wCEDbQuST9tr6wSDBvXuApRntGCqGD6uxqDwETKUCyBTQxGFewwtlAnvRikY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SfAeE2kP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wyk9YMAw; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SfAeE2kP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wyk9YMAw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 77E797A00B8
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 17:54:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 09 Oct 2026 17:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791582864; x=1791669264; bh=9JhYK3jf/R
	RbmaNMvzJJvWSepD4WARXh7SxJVKH15dw=; b=SfAeE2kPMjDFfOMU2S+GPEOKg2
	s5nB6MN7nP4KEqize7etlP9Y7qt6+SDkqiuFTkHJqsJa1boorICOSoZre+yYopo0
	wBYWrxm6/QDSwyT61I5n9gmG3R8U5VsADV2Af9g7sxuuFqXuoQ8fSbQ05eLpiIof
	BlfCLrO0wJvCvGoNxauxs3aFDQc5NEkeEFJJ22bpAm2AS9UjYppjnLoriaoUfNSc
	6n6Qih0jBbrxZCoryclrkIh+VBKohp5UldsZO23Znyn0QNct6rPMEg51eAwD76Bl
	jTjkLJubGSDffQUFdMZZBJZV3agCEoMwOuB9pOevKOVTF0fRdpf5dU38CaPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791582864; x=1791669264; bh=9JhYK3jf/RRbmaNMvzJJvWSepD4WARXh7Sx
	JVKH15dw=; b=wyk9YMAwtUyCaFJgVAUHWnPAoza+DMjDUdLYC8+Hn/pjqhsM7KE
	6VyzzQP4dCj8dKW5zWLzg0ZQr7Cg2isZEH1g5btVSmDZ4iEszP6/oG1wyzz+8yBR
	B7IkYiR2+2OpINczaAujdfwBRtU9th2DZ4iXO+g+tFP2y6ic0TKqqhh8EeenOJZY
	xARWwqkIe+3tbQ3ptHcl87hxseEiR7UIqesO9uNdBbI69HFDp/YjOPl+CfkyeYaj
	n+XN6ODCANYE3+9tf2cAuFxhFh6iCUzTz1/iUZtWXPPq12nqb1Pi4wHn8trLsO8G
	O6ro2/QznrY4VhRsAtUCPYwIlShoKx4GMQA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791582864; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:CB9bDvqYHqpsuo1g+qRclNHlOZGH+WgJXF32TXe/jbWaTsf
	tvxIj48zMWvlFd4Mhnfv/4q72vUfMOmkcmhnolkM/73tYSQctBqaH3yqxVdngA7t
	GSqnEBUfKA6dQaYQdzVQ8nA0XwQQ3O5CGPrex/3PJOBqyPM6esNf2VyNzYcZxaR0
	teSBG8eZ003Km2gj3dYA870ciKfQJLgJ0Ga+KE5bmjarzRgy5TVbCikk8VYRbfWI
	W+7CGVV4BkwGm3bSrGGnB7sNfGRToiNPqDYb0SpC1XwL1wkBBwBNJA+ThfJbXgZh
	/K+qju73yfpXIU7Op6/rcVtJwFcuZXlYUup11pQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:YCwfmO2LWUWh12ZK4iOFRF8aFLHvH/gs4qHRQnLIR1k=:0z2fnYm16KfvsJCKuBAucTr4xAtK3Tb7v+Kum5WiMWE=;
X-ME-Sender: <xms:j2LJanUziwWls5jAH-qxwf3f6kgIhSXRMamG8gcyb7BiaswMPLSk5A>
    <xme:j2LJah0LKlGwTtvgKwtEZQq87adBFkLfVwyfbxLhucyPuCU6GQ1TzasbsxeUiS1Qf
    s9lRHsaspcqlIiEKBtCLrOA1t345ZEIRz0F1sdZzGA9YrOJU5akA8s>
X-ME-Received: <xmr:j2LJalql4qQ1J04NmaBD8ufN7jnkhOnZLnsvBzHI-qjq5dcpkt0ha3ig1CmYQ__4JwIyViLD6ChNnoev2JYYue2Sr24PqRj1U6OF>
X-ME-Proxy-Cause: dmFkZTEqt6nLupzDnai4Hn3nZJLd7KZmelFdwVeSFkcptT2nQjRRh6VFROzcMgBnYYT0z+
    gutfkf+WMIV2/xI67MrGjJTCfnrGLEAk2vmlMRui5pBHcOwr4ZdVzTj6HKc2bvzV/qF0Zj
    SqXZFEHN5Qd3NjzIhjhYNxibcp83NZ6pJvSbtLO9svyxga/NqD30DD+T8UJJ3+M9uzuQRz
    cevXKxn7PV91MzRB8yF3VBS5iQ1EZdlM/FTw1VAAAKh/vtNPSiD6nS2vIdhLlogTxvOUyR
    eP8oZL9ANcKalgdh8AvrXIbBhi6pzCk7YdeNdUDSO/BclNQR7ZQGg+s8hTGFhLAXk95Fc0
    SZrRqknwk8xP7+BngfruDCNwIvjZSCs1ZcGSbAWX2eKRZT1cK5BrB/IpsTYENYXi9KQQpj
    2g757+pj3NNo3C+1X4wMv/j61Jvk7yDCXgxIxitaTH9mmmuw8iPy96K6EBgJUvNuNHOfON
    jNvx86dJ8jmAfhc0T1BH9lp1oaI5K9mF2QQxHh75Ne08xkiUAnC/N8ZaLWMg6yTXpJYkUb
    ajZh6Ja+bfrK5+c5IotWBnp+ZSso+m89jQwmO4Mfmq+TEYXWXZuBC/5Z++5VBkztq5WTyT
    i/dXxg6hNsFDA0HXqjv3y5bxYZ/WZdEX6NrSGl7qjzjdWY8couUhbGmKO5zQ
X-ME-Proxy: <xmx:j2LJaoWxtt6dyv_LtkqBb4rwr2sVK0p3Ko1WSrdQUxQHG8W1NNWuIg>
    <xmx:j2LJagbolzt79pugLb_KpTdGGdvAlYqA8AIYaAnOgtnXzQ0uZg1hww>
    <xmx:j2LJaleO-EWaQhVXXFnSijkNjvGqNvKaWGt8YqhWmC1_YJSke7xNXQ>
    <xmx:j2LJaq0gxTjFo7XlKmZN4BxOpcqYtFbmecgYmQf_YHNWTXKqUdbSoQ>
    <xmx:kGLJam6vTxzclC1fiJ2rm8cv_BIQznN1YeR9gkFSssn_0FLofHkMsxIr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 17:54:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Patrick
 Steinhardt" <ps@pks.im>,  "Jeff King" <peff@peff.net>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 1/6] doc: add new gitmergeconflicts man page
In-Reply-To: <b40960d8-3033-4458-973a-67fc41e02b77@app.fastmail.com> (Julia
	Evans's message of "Fri, 09 Oct 2026 14:53:58 -0400")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
	<ab0344f947c252b1b7c8bb386586b8641223ba38.1791547213.git.gitgitgadget@gmail.com>
	<xmqqik3arc2d.fsf@gitster.g>
	<b40960d8-3033-4458-973a-67fc41e02b77@app.fastmail.com>
Date: Fri, 09 Oct 2026 14:54:21 -0700
Message-ID: <xmqq4ieuleuq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

>>> +* Resolve the conflict. (see <<resolve,HOW TO RESOLVE A MERGE CONFLICT>>
>>> +  below for details)
>>> +* Or stop the operation and return your branch to its original state
>>> +  with the appropriate `--abort` command, for example `git merge --abort`
>>> +  or `git rebase --abort`. See <<git_status,EXAMPLE: GIT STATUS OUTPUT>> below
>>> +  for how to find the command to run.
>>
>> Both are good options and I do not think of a middle way.  Perhaps
>> we do not have to say that these are "the most common" and instead
>> say "You handle a merge conflict by doing either of these two"?
>
> I agree the "the most common" is kind of weaselly and I'd like to be more clear.
> The reason I wrote "typically" is that during a rebase, there's an extra
> "skip" option, so it's not strictly true to say that there are just two options.
> Not sure if there's another option I'm not thinking of other than the
> "skip" in rebase.

I do not think anything like "rebase --skip" in a multi-step
integration is what this document covers particularly well to begin
with.  Taking each conflicted step individually, with "skip", you
are stopping the operation without resolving the conflict.

Perhaps make it clear that in the above you are talking about what
to do with each individual opportunity to give back conflict
resolution to the command?  If you describe these two choices in the
context of multi-step operation, each "we stopped due to conflict
and gave control back to you" opportunity gives you these choices:

 * Give up, pretend this step did not exist, and continue.
 * Resolve the conflict, record it, and continue.

In addition, you have "--abort" to give up the whole thing.
And a single step operation like "git merge" is a degenerated case
of the above.  "and continue" part does not exist.

> I was thinking about that too. Maybe we can briefly mention that git's
> merges are not guaranteed to produce working code even when they
> succeed and point to an example further down the page.
> Added to my list of things to work on.

It's not limited to "GIt's merges" but applies in general.

>>> +[[tools]]
>>> +TOOLS FOR HANDLING MERGE CONFLICTS
>>> +----------------------------------
>>> +
>>> +Here are some ways to get extra context while handling a merge conflict:
>>> +
>>> +* There are many graphical "merge tools" for Git, which will normally
>>> +  show you the different versions of the code side by side.
>>> +  If you have a mergetool configured, `git mergetool` will launch it.
>>> +  See also `merge.tool` in linkgit:git-config[1] for a list of
>>> +  the mergetools Git supports.
>>> +
>>> +* You can set the configuration option `merge.conflictstyle=diff3`.
>>> +  See <<diff3,DIFF3 AND ZDIFF3>> below for more.
>>
>> These are called 'configuration variables' throughout the manual
>> pages.  Be consistent and replace "configuration option" with
>> "configuration variable", perhaps?
>
> They seem to be both used interchangeably already:
>
> ```
> $ grep 'configuration variable' *.adoc | wc -l
>      256
> $ grep 'configuration option' *.adoc | wc -l
>       46
> ```

Do not make it worse.  The latter were mostly added people like you
who responds like the above; aim to be more consistent instead.

>>> +* `git log --merge -p <filename>`  will list all commits which
>>> +  caused the merge conflict for `<filename>`, and the diff
>>> +  of how they changed the file.
>>
>> Maybe worth mentioning that `--left-right` often helps when you are
>> not super familiar with the histories being merged.
>
> I don't understand what this does or what it would be useful for so
> it's not possible for me to explain it  :). From my perspective
> "ours" and "theirs" are already confusing enough and introducing
> "left" and "right" seems like a lot. Is "left" the same as "ours"?

If you do not understand what it does, perhaps try it out?

"git log -p --merge" is to break down the ours/theirs into
individual steps when changes on these sides were brought in in
multiple steps.  It shows individual changes per commit, but if you
are not super familiar with these histories being merged, it is not
obvious which commit came from which side.  And --left-right option
is a way to help you tell which one came from which.

>>> +* Use `git diff AUTO_MERGE` to show what changes you've made so far to
>>> +  resolve the conflicts.
>>
>> Does a "See below" here help readers who haven't learned what
>> AUTO_MERGE is?  If you can describe what AUTO_MERGE records (in
>> other words, what you are comparing your progress against) in a
>> sentence of two here, that would alleviate the need to assure them
>> that we have more in-depth coverage on this topic elsewhere.
>
> I think this is okay the way it is.

Is it because, unlike --left-right, you understand what it does?
Not everybody shares what you know, you know ;-)

 * AUTO_MERGE records the initial merge result with conflict
   markers.  `git diff AUTO_MERGE` can be used to show how much
   progress you made to resolve these conflicts.

perhaps.

> Maybe we could add a note like this somewhere?
>
>    NOTE: zdiff3 was an experimental alternative to diff3 that makes
>    the merge conflict shorter by introducing more ambiguity.
>    It's still there for backwards compatibility but we don't recommend it.

Drop "experimental" and I am 100% behind that statement ;-).

>> By the way, is it just me who finds those "Here's", "there's"
>> contractions disturbing in an official manual?  I've seen many of
>> them while reviewing this to be annoyed enough and had to blurt it
>> out X-<.
>
> I find "here is" and "there is" to be distracting and overly formal,
> different people are different I guess :)

I would prefer to be consistent in a single documentation set, though.

>> The text comes from ffb1a4bed5 (Documentation: Describe merge
>> operation a bit better., 2005-11-28) that had "When there are
>> conflicts, these things happen. 1. HEAD does not move, 2. Cleanly
>> merged paths are updated in the index 3. Conflicts are recorded in
>> higher stage index entries and working tree files show conflict
>> markers, 4. No other changes are done" well before the mysterious
>> reference to 2. and 3.
>>
>> When ebef7e5049 (Documentation: simplify How Merge Works,
>> 2010-01-23) tried to simplify the description, the list of "these
>> things happen" were removed/rewritten, and yet instructions on how
>> to reset are left behind, still referring to 2. and 3.
>>
>> We probably want a separate patch for Documentation/git-merge.adoc
>> to rectify this 16 year old mistake.
>
> Thanks for investigating!

Heh, you already did the separate patch, which is [2/6], which I am
happy with.
