Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C80035DA6C
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791572062; cv=none; b=mnV2EfaJhiEs8QZ294u0/sy1W5o7WHkeANiXuXCQ+oaDL/aTnXrtcnrccXazin5QzLlKyzYHFgYMMIywgZkipTy5q78c+dKrLkLPMGXhGfrAk2v1VAmaVZo1FGQexlWKXpx1dCcu7mbhN0guKv0MwVg6OwzmSDGoPOnV1wU1+aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791572062; c=relaxed/simple;
	bh=9ScZNQvfkxnKMO7/H6BcKjLUtfToVrt1tfFwernrOYs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OpIqLZm3ar/qQgRTEXvvMyjnBDssNLs+PWXKymz3ghXcGW+Q7QfDkRuFj07zyM2MLi+X+Z2VeA16/Rui5EjjPRQVTHEmFGORTAA4t4DN7kg7eK6MwMxDuXmaSVIwxDuM5Khy5V9xYJButt0pQMkKrTwcFkmVJAKCapG46BaqJsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=qamdQEpa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DneBZvpp; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="qamdQEpa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DneBZvpp"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 166651400141
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 14:54:19 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Fri, 09 Oct 2026 14:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791572059;
	 x=1791658459; bh=TQNVQZTXFL4fKkvbM3PJ4To/YvPLw49vssrF0nbRWqg=; b=
	qamdQEpaWV+AM5ce9KZJqSdlIbW+W+XnIw2hoEjLkHSwL8PmrdtxeVgdlwXaIC/H
	+upVVvoLAY63u87rryAnkQY7FJWo3cXx8Y8HiDs/wbXqq94NsLiQty+GN5i4XDRL
	+ued4TpdxSfVczi9z7801DF3IwVhJh2s+I3zoSanT7bEKuB2QTws/aGIIBiXs97S
	d66FOGR740KzpuQnyMZtF80IVvLDml0v+pN30+1Nr4QTuQUjFZsNhw6nLHUOovRH
	nv6fl2vkjWqoOo68sZMHe26ZHeCDXthIdcemOcO8YM8BPrTD7tecGBREo3oatsyJ
	dJo63Kb2p5cJEnlrS0qE0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791572059; x=
	1791658459; bh=TQNVQZTXFL4fKkvbM3PJ4To/YvPLw49vssrF0nbRWqg=; b=D
	neBZvppkT93zknW/xItrTFfP3NufB8Vq9D2VdR45uYBA4lY26xlM31nf9/uQoFU8
	CCgmzQAbLSqWn8+D9czYtBKWFQ4ARooxLNv8Np6SYz/s/LrGRGiYBQDLRFU2wYlC
	SnqQDZFzI+Z9HLHoUCrD8oG4WBT8rLlxq3rWFagU2HDTgQbqncfWQ/zpR/nR3N4R
	GvZVJBQntuGUFVwzX6nq2/wulwzh2pQJRPXxes2v6IkNkO6Xh/Rqm4ed1+k6KUBn
	zgD+T/hCiQRPGGOYKfv9x8OTQcxTkQ2NJ+WHzWjLn/TGGKQn9wIk4hwuxVxL+PtI
	hD9HDSQV6Kn+IKZXuYjOA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791572059; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:G5NCURCN0B73l4G5u8mSar7m5OqqlHhd/pV8QQ5KozfWLQY
	nzurg0odJ3a6esj17zl7+BxbwXN8Al3/1NgQL7Ad7msuqbGTBLH4jTZoHqxZundm
	VD2GxqorjvwKejq0eAYajVkzFZ5pctdQR0sGNagPhjHYZBuP5uVmFGiX2qLOD5Gn
	eO9LkMToHHCqgUXnA5HcLbXpQtTt+XTMVXISIluKcQ+nTqmVd4AQuB3/972kWAp6
	SWb0zSIj6mPSlDABq8kmCXLWAjSafd3TGQ4UNfZ/Vs9PaTcTLe17Ao8Nt0I3evSv
	T2m+IN+JP9Kpx9gF5k3ua/wrTnBGCy+zOnRmcIw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:or+Pe7KcnVaSCRi1PBU4mdcWfIe2HRs5vpHL4BHvxP4=:9ScZNQvfkxnKMO7/H6BcKjLUtfToVrt1tfFwernrOYs=;
X-ME-Sender: <xms:WjjJahsYa_SKOJlTMuQHRW1BNncWYTKyDFnb25ftjfWh6NK6LOKLgQ>
    <xme:WjjJalRZtMdQDqswmphN6YLU9a-PlAbclBN8niQ8lK27g47G3F7ZjSFlAaxpAYZ9I
    uPl-9yWr9Iic5UGfMdFqg0y7_GG92TpFobD7Ay7xMdORmD1PToe9a20>
X-ME-Proxy-Cause: dmFkZTGBq+2PUDP12Fiw5IAzH4iEo9t/stlo8TTcWdFGjIUC9xWbkrXoftvkbVn3RsUEBV
    GY0VMo6Ih662e3WXEadfHmHoxpuE4Cm/sTda2z4wRiXYVE0yUBwQwoe1T4XLIahxoEI31U
    i6hCbFAFxVOjhkrXzc9tbHARfw23ydEWtZco2IAh9Q0nsn+aRjxRHX2mmx2Mb70Fs9YtKx
    q7ZEiUm30oSWeHX6lGEuZTG1Ue0QokEQdxTmZIjcKIAF6RV0I+ukuOWzunfnPHKss8sWpZ
    ugcZxepD5ROa6l+uMh7SDjC1TMr8JGMIjCbYE2rAaHq0j6w5hWi8GoVx0WYN4q481Bv2Fk
    36lkkBDkH4UtHY7A7dZkqvH/zE+WUDy/lnHPRCFxWG3hB/tqj5A5YLqoi+NA7uVtaTYOGZ
    dATSQwBbfQmOKByR0u3vuSgh58WNAI2ljlsALgt9HIZ7qNwcrB0erK1q2oXA2bkY21hEKW
    9Pa7d1m6LUw8RsddsXtXTJV22Z16ZNP/pf2bsluP3sSzE0QVAINbxfvcf/Bi1mFrzUek9k
    prR97UiNZqk7ryHR9jbQtWr0D1siGuGEyzqSDPzPPq404XUoLAoEdW9hkqCb2Bmx4t2mfM
    zQRRz77ScRGyal5QRLu+nNccSdC6TCjEWF1NhadwHJtqRVb6b7k09aOfjWXQ
X-ME-Proxy: <xmx:WjjJarZeIkPvi7U6zzaLfK6vJn_RscO4962trHElL4a9Amkg02WwrQ>
    <xmx:WjjJajtHb34BM1BGwYm8yb8WrSU5YJv2o2aSHBYD4mY3QmnSYVzwMg>
    <xmx:WjjJalMlOgrlXTeOgbhLKT4E-p5QvUiEZ0wT3jsioXx-nxF1kwcYiQ>
    <xmx:WjjJai6V_onX7HfO1PFOD4-nF2_ny4fpI4eHCnq_iXlHMnIXQWpxIg>
    <xmx:WzjJap1zsPOGFPVVJbGtCoGQKGbzWwDirj1ZqmmHO0Z-EDa7VDt93lFH>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B0809780076; Fri,  9 Oct 2026 14:54:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AndINfi0Ib6w
Date: Fri, 09 Oct 2026 14:53:58 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>,
 "Jeff King" <peff@peff.net>, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <b40960d8-3033-4458-973a-67fc41e02b77@app.fastmail.com>
In-Reply-To: <xmqqik3arc2d.fsf@gitster.g>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
 <ab0344f947c252b1b7c8bb386586b8641223ba38.1791547213.git.gitgitgadget@gmail.com>
 <xmqqik3arc2d.fsf@gitster.g>
Subject: Re: [PATCH v2 1/6] doc: add new gitmergeconflicts man page
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thanks for the review, I'm especially excited about the idea to remove zdiff3. 

>> Co-Authored-By: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
>> Reviewed-by: D. Ben Knoble <ben.knoble+github@gmail.com>
>> Reviewed-by: Patrick Steinhardt <ps@pks.im>
>> Signed-off-by: Julia Evans <julia@jvns.ca>
>
> We want a sign-off by the coauthor, too.

Will do.

>> diff --git a/Documentation/gitmergeconflicts.adoc b/Documentation/gitmergeconflicts.adoc
>> new file mode 100644
>> index 0000000000..5b0ba1a1de
>> --- /dev/null
>> +++ b/Documentation/gitmergeconflicts.adoc
>> @@ -0,0 +1,333 @@
>> +gitmergeconflicts(7)
>> +====================
>> +
>> +NAME
>> +----
>> +gitmergeconflicts - Guide to handling merge conflicts
>> +
>> +DESCRIPTION
>> +-----------
>> +
>> +Merge conflicts can happen during a `git merge`, `git rebase`, `git
>> +cherry-pick`, `git pull`, or `git revert`. All of those commands use
>> +the same merge algorithm, and the process for resolving a merge conflict
>> +is always very similar.
>
> Is it deliberate to omit 'am -3' and 'checkout -m', perhaps in order
> to limit ourselves to most common ways to help new people by keeping
> the description to the absolute minimum?

It's deliberate, we talked about that a bit in the discussion of the v1.
Can add a note in the commit message.

> In any case, the first paragraph clearly stating that conflicts
> happen with operations other than 'merge' is a very welcome change.
> On this list, we often say "mergy operations can cause conflicts",
> with the understanding that readers know what mergy operations are
> and "conflicts" alone can convey the state you call "merge
> conflicts" in this document.  But in a document for end-users, using
> a longer term "merge conflicts" instead of "conflicts" and avoiding
> "mergy operations" like you did above may be a better direction to
> go.
>
>> +The most common ways to handle a merge conflict are:
>
> A natural paraphrase of the above is "A merge conflict is typically
> handled by these ways", but I thought the current readers are
> puzzled by "typically your side" that does not say when is typical.
>
>> +* Resolve the conflict. (see <<resolve,HOW TO RESOLVE A MERGE CONFLICT>>
>> +  below for details)
>> +* Or stop the operation and return your branch to its original state
>> +  with the appropriate `--abort` command, for example `git merge --abort`
>> +  or `git rebase --abort`. See <<git_status,EXAMPLE: GIT STATUS OUTPUT>> below
>> +  for how to find the command to run.
>
> Both are good options and I do not think of a middle way.  Perhaps
> we do not have to say that these are "the most common" and instead
> say "You handle a merge conflict by doing either of these two"?

I agree the "the most common" is kind of weaselly and I'd like to be more clear.
The reason I wrote "typically" is that during a rebase, there's an extra
"skip" option, so it's not strictly true to say that there are just two options.
Not sure if there's another option I'm not thinking of other than the
"skip" in rebase.

> Saying "return your branch to" is a bit misleading for two reasons.
> Conflicts presented to the users are primarily visible in their
> working tree files and the index.  A single commit operations like
> 'merge', 'pull', and 'revert' does not touch your branch if they hit
> a conflict, and 'rebase' works on a detached HEAD, and stops without
> touching your branch when it sees a conflict.
>
> If I were writing this, with the goal of avoiding the issues the
> current text has you listed in the proposed log message, I would
> probably say something like this:
>
>  * Or give up and return to the original state with ...

That's reasonable, I think "return to the original state" would be fine.
Will look at this.

>
>> +WHAT IS A MERGE CONFLICT?
>> +-------------------------
>> +
>> +When Git merges two commits together, it looks at the changes that
>> +each side has made and combines those changes. For example, if one side
>> +edited lines 1-5 of `hello.py` and the other side edited lines 20-25 of
>> +the same file, then it can easily combine them since there's no overlap.
>
> Many of the operations, even "git merge", is not about merging "two
> commits" together, but I do not think of a good way to explain it,
> so I accept that phrasing as a helpful white lie.  I mention this
> because somebody else may be able to come up with a better phrasing
> that I (or authors of this iteration) couldn't think of.
>
>> +But if both sides edited overlapping lines of the same file (for example
>> +one side edited lines 1-5 and the other edited lines 3-6), Git will
>> +not try to guess how to combine those changes. This is called a "merge
>> +conflict".
>> +
>> +When this happens, Git shows you both sides' edits and asks you to pick
>> +how to resolve them. It:
>> +
>> +* Stages all of the files which were successfully merged
>> +* For the files with conflicts, it marks them as conflicted, puts both
>> +  sides' edits in the file, and leaves <<markers, merge conflict markers>>
>> +  that you need to resolve.
>
> By the way, I think we should briefly mention what sematnic merge
> conflicts are, and that Git does not detect them and that this
> manual page does not tell readers how to deal with them.
>    
>     Note that non-overlapping changes from two sides may leave the
>     result in an inconsistent state.  With the edit to lines 1-5,
>     one side may have changed the name of a function, while with the
>     edit to lines 20-25, the other side may have added a new call to
>     the function by its original name.  This type of inconsistencies
>     are called semantic conflicts, Git has no way knowing that a
>     merge introduced semantic conflicts, and ends up producing a
>     broken result without merge conflicts.  This document does not
>     cover what to do with semantic conflicts.
>
> That is overly long, but perhaps you can condense it down to the
> essense and shrink down to 1/3 of the size.

I was thinking about that too. Maybe we can briefly mention that git's
merges are not guaranteed to produce working code even when they
succeed and point to an example further down the page.
Added to my list of things to work on.

>> +[[markers]]
>> +MERGE CONFLICT MARKERS
>> +----------------------
>> +
>> +When there's a merge conflict, Git will update the conflicted file
>> +to include merge conflict markers `<<<<<<<`, `=======`, and `>>>>>>>`.
>
> I notice that when you introduce `diff3` below, you silently add
> `|||||||` to the mix without explaining what it is.
>
>     `|||||||` may also be used as merge conflict markers (explained
>     later).
>
> or something along the line here may help.  Or explain what it is in
> `diff3` section.  Either would work.  Adding without explanation
> would not.

I think explaining it in the diff3 section makes sense, will do.

>> +For example, here's a merge conflict where both sides edited a list of
>> +fruits in different ways:
>> +
>> +----
>> +FRUITS = [
>> +    "apple",
>> +<<<<<<< HEAD
>> +    "cherry",
>> +=======
>> +    "banana",
>> +>>>>>>> add-fruit
>> +    "mango",
>> +    "orange",
>> +]
>> +----
>> +
>> +The code from one side of the merge conflict is between `<<<<<<<` and
>> +`=======`, and the code for the other side is between `=======` and
>> +`>>>>>>>`. See <<ours,"OURS" AND "THEIRS">> below for a full explanation
>> +of which side is which.
>
> If we said "one side wanted to have 'apple, cherry, mango, orange',
> while the other side wanted 'apply, banana, mango, orange', in the
> FRUITS array", would it help the understanding?  Or is it too
> obvious?

I think it could make sense to add something here yes.
Added to my list.

>> +[[example]]
>> +EXAMPLE OF RESOLVING A MERGE CONFLICT
>> +-------------------------------------
>> +
>> +If you see this in your code during a merge conflict:
>> +
>> +----
>> +FRUITS = [
>> +    "apple",
>> +<<<<<<< HEAD
>> +    "cherry",
>> +    "mango",
>> +=======
>> +    "banana",
>> +    "mango",
>> +>>>>>>> add-fruit
>> +    "orange",
>> +]
>> +----
>
> It would make your readers puzzled why the example is subtly
> different from the earlier one that showed "mango" as not touched by
> either side.  I see this lays the groundwork for later demonstration
> of `diff3`, so having both sides explicitly want "mango" is a good
> example.  Perhaps update the first example to be the same as this
> one, which would reduce the mental burden by readers?

I very much agree it's important for the examples to match,
will work on that.  It's a bit tricky with diff3 like you say.

>> +[[tools]]
>> +TOOLS FOR HANDLING MERGE CONFLICTS
>> +----------------------------------
>> +
>> +Here are some ways to get extra context while handling a merge conflict:
>> +
>> +* There are many graphical "merge tools" for Git, which will normally
>> +  show you the different versions of the code side by side.
>> +  If you have a mergetool configured, `git mergetool` will launch it.
>> +  See also `merge.tool` in linkgit:git-config[1] for a list of
>> +  the mergetools Git supports.
>> +
>> +* You can set the configuration option `merge.conflictstyle=diff3`.
>> +  See <<diff3,DIFF3 AND ZDIFF3>> below for more.
>
> These are called 'configuration variables' throughout the manual
> pages.  Be consistent and replace "configuration option" with
> "configuration variable", perhaps?

They seem to be both used interchangeably already:

```
$ grep 'configuration variable' *.adoc | wc -l
     256
$ grep 'configuration option' *.adoc | wc -l
      46
```

`git-config.adoc` uses the term "configuration option" 2 times
and "configuration variable" once. Is there supposed to be
some difference between these terms? As far as I can tell
from brief history spelunking Git has used those terms
interchangeably for a long time. AFAIK "configuration option"
is the term more often used outside Git.

>> +* `git log --merge -p <filename>`  will list all commits which
>> +  caused the merge conflict for `<filename>`, and the diff
>> +  of how they changed the file.
>
> Maybe worth mentioning that `--left-right` often helps when you are
> not super familiar with the histories being merged.

I don't understand what this does or what it would be useful for so
it's not possible for me to explain it  :). From my perspective
"ours" and "theirs" are already confusing enough and introducing
"left" and "right" seems like a lot. Is "left" the same as "ours"?

>> +* Look at the original files.  `git show :1:filename` shows the
>> +  common ancestor, `git show :2:filename` shows the "ours"
>> +  version, and `git show :3:filename` shows the "theirs"
>> +  version.
>
> Maybe it will help to say we will explain "ours" and "theirs" later
> in this document.

Plausible, added to my todo list to look at, thanks.

>> +* Use `git diff AUTO_MERGE` to show what changes you've made so far to
>> +  resolve the conflicts.
>
> Does a "See below" here help readers who haven't learned what
> AUTO_MERGE is?  If you can describe what AUTO_MERGE records (in
> other words, what you are comparing your progress against) in a
> sentence of two here, that would alleviate the need to assure them
> that we have more in-depth coverage on this topic elsewhere.

I think this is okay the way it is.

>> +[[git_status]]
>> +EXAMPLE: GIT STATUS OUTPUT
>> +--------------------------
>> +
>> +When you're in a merge conflict, you can find out what commands to run
>> +to handle the conflict by running `git status`.
>> +
>> +For example, this `git status` output tells you that:
>> +
>> +* `git rebase --abort` will safely bring your branch back to its
>> +  original state
>> +* you should run `git rebase --continue` when you're done resolving all
>> +  the conflicts
>> +* there's one file left with conflicts in it: `fruits.py`
>
> There may be users, after seeing the last point, left puzzled why
> fruits.py is still listed after they edited the file like instructed
> in an earlier example but haven't marked the resolution.
>
>     `fruits.py` is not marked as its conflicts resolved yet.
>
> or something?

Thanks, agreed that "there's one file left with conflicts in it: `fruits.py`" isn't
precise enough. Will make it more accurate.

>> +----
>> +$ git status
>> +You are currently rebasing branch 'main' on '58a9fcc'.
>> +  (fix conflicts and then run "git rebase --continue")
>> +  (use "git rebase --skip" to skip this patch)
>> +  (use "git rebase --abort" to check out the original branch)
>> +
>> +Unmerged paths:
>> +  (use "git restore --staged <file>..." to unstage)
>> +  (use "git add <file>..." to mark resolution)
>> +        both modified:   fruits.py
>> +----
>
> The approach to give explanations first and then an example the
> explanation explains next is refreshing to me.  As long as the
> explanations are short enough, this may work better than the usual
> order to say "you'd see something like this. let us explain ...".

Glad to hear it!

>> +[[diff3]]
>> +DIFF3 AND ZDIFF3
>> +----------------
>> +
>> +By default, Git doesn't include the original code when formatting
>> +a merge conflict. To include the original code, you can set the
>> +configuration option `merge.conflictstyle` to `diff3` or `zdiff3`.
>> +This extra context can make it much easier to understand what's
>> +happening in a merge conflict.
>
> I think most on the list considers `zdiff3` a failed experiment that
> reduces usefulness of `diff3`.  Do we want to recommend it?

I'd be extremely happy to remove this if the list doesn't think zdiff3
is useful. When I was writing this I was confused by zdiff3 and thought
diff3 made a lot more sense.

Maybe we could add a note like this somewhere?

   NOTE: zdiff3 was an experimental alternative to diff3 that makes
   the merge conflict shorter by introducing more ambiguity.
   It's still there for backwards compatibility but we don't recommend it.


> By the way, is it just me who finds those "Here's", "there's"
> contractions disturbing in an official manual?  I've seen many of
> them while reviewing this to be annoyed enough and had to blurt it
> out X-<.

I find "here is" and "there is" to be distracting and overly formal,
different people are different I guess :)

>> +"Ours" and "theirs" are both commits: "ours" is the current
>> +`HEAD` commit, and "theirs" is the other side being merged.
>
> Now, "commits" is again a white lie.  The story becomes more
> complicated when we talk about cherry-pick and revert, but if we
> primarily stick to what happens in 'merge' (which is what I've seen
> so far in this document), then it shouldn't add any extra difficulty
> to understand by saying "ours and theirs are history of changes
> leading to the two commits since they diverged from the original" to
> add clarity.
>
>> +The first part of a merge conflict (between `<<<<<<<` and `=======`) is
>> +from the "ours" side, and the second part (between `=======` and
>> +`>>>>>>>`) is from the "theirs" side.
>> +
>> +----
>> +FRUITS = [
>> +    "apple",
>> +<<<<<<< HEAD
>> +    "cherry",                      <- ours
>> +=======
>> +    "banana",                      <- theirs
>> +>>>>>>> add-fruit
>> +    "mango",
>> +    "orange",
>> +]
>> +----
>> +
>> +During a rebase, it can seem "upside down" because the "ours" commit is
>> +from the branch you're rebasing on (for instance `main` in `git rebase
>> +main`).
>> +
>> +These terms in Git all mean the same thing when dealing with a merge
>> +conflict:
>> +
>> +* "common ancestor" and "base". The files from this commit are "in stage 1".
>> +* "ours", "us", and `HEAD`. The files from this commit are "in stage 2".
>> +* "theirs", "them". The files from this commit are "in stage 3".
>> +
>> +If you're confused about what something like "deleted by us" means, it's
>> +often easiest to use some of the tools from
>> +<<tools,TOOLS FOR HANDLING MERGE CONFLICTS>> above to get more context.
>> +Finding the commit that deleted the file and seeing why is usually more
>> +helpful than trying to abstractly reason through what "us" means.
>> +
>> +[[automerge]]
>> +EXAMPLE OF USING `AUTO_MERGE`
>> +-----------------------------
>> +
>> +`git diff AUTO_MERGE` will show what changes you've made so far to
>> +resolve conflicts. `AUTO_MERGE` is a reference that Git creates during a
>> +merge. It contains the result of running the merge algorithm.
>
> The first sentence gave me "Huh?  You haven't explained what
> AUTO_MERGE is yet".  It may be just me, but I would have expected
> presentation order to be more like:
>
>     When merge conflicts happen, the result of merge algorithm,
>     together with conflict markers, is recorded in AUTO_MERGE.  As
>     you resolve conflicts, you can compare your working tree files
>     against it with `git diff AUTO_MERGE` to see your progress.

Can take a look but I don't think it makes a big difference.

>> +For example, if we resolved the conflict by adding both "banana" and
>> +"cherry" in order, the diff would look like this:
>> +
>> +----
>> + FRUITS = [
>> +     "apple",
>> +-<<<<<<< HEAD
>> +-    "cherry",
>> +-=======
>> +     "banana",
>> +->>>>>>> add-fruit
>> ++    "cherry",
>> +     "mango",
>> +     "orange",
>> + ]
>> +----
>
> Thanks.
>
>
> I was puzzled by this
>
>> - In "The only clean-ups you need are to reset the index file to the
>>   `HEAD` commit to reverse 2. and to clean up working tree changes made
>>   by 2. and 3.", it's not clear to users what "2" and "3" are supposed
>>   to mean
>
> and did some digging.
>
> The text comes from ffb1a4bed5 (Documentation: Describe merge
> operation a bit better., 2005-11-28) that had "When there are
> conflicts, these things happen. 1. HEAD does not move, 2. Cleanly
> merged paths are updated in the index 3. Conflicts are recorded in
> higher stage index entries and working tree files show conflict
> markers, 4. No other changes are done" well before the mysterious
> reference to 2. and 3.
>
> When ebef7e5049 (Documentation: simplify How Merge Works,
> 2010-01-23) tried to simplify the description, the list of "these
> things happen" were removed/rewritten, and yet instructions on how
> to reset are left behind, still referring to 2. and 3.
>
> We probably want a separate patch for Documentation/git-merge.adoc
> to rectify this 16 year old mistake.

Thanks for investigating!
