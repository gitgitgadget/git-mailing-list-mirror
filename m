Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E124772BF
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792007517; cv=none; b=bkTe8ERtyYhFjAHi7J/tZaLdlC3ZkF/MJh8Lvvgwg4rauAjuFNvT/EdPzoS3iX+28UfF7DWFTIOHnn9DgZFmknwaSRvx1xPcPrfk7fQdVsWLZ/1nLI5PrjMajCK4rb0/A0JV5AX+VgvOu5vKsjrjR4z6zhKE+bw41OlnGyHAwxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792007517; c=relaxed/simple;
	bh=thJjediHs+BEasamNvdCCqdwXz/xJcJsevKRvqjnA9w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HxBMd0JAe4fILbu3YWWTQ65RGv7560l9hSvV1HHR29BMYZ1zyUewjBdt7+ikJFbUYls157w4RYo1HmAFfZU8zyUfdk6NIVH+RfYgEdkWoBI1aIoB0Wdi3nyaFLKzyXFInONVEBkRK/FLTyrd9wqWoe/xJyxwxCJP3NGWksBiT4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=lz3ANcTR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gA5z1fKt; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="lz3ANcTR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gA5z1fKt"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 53967EC0177
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 15:51:54 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Wed, 14 Oct 2026 15:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792007514;
	 x=1792093914; bh=SN7KcN+1sHiS19EbPR/Q2ewi8OhFSsLKdAo78b0NTOU=; b=
	lz3ANcTR1sLo70Jvp2L5x1jJL9xqE+Q9M1fzV+w4/rNfcSnPOMFwAu9fKjhVTtn4
	k2dPYXg+NN6gqPQRCAokiiLiyBWPk3b176KvXDh3J3MXD768vcEekH2zXk02HSRg
	uBI0QKlQPW/iNR6wQhPwQQJegNtttdxnAlfVmu6yUuYK4R/2OWDtFKOje/QRURG7
	saNQ6Eua4cWw+2uWanyYZ4nAeIDu0VUPySJROHgWYsIHML00A15GLVYMeHXUhQBp
	leoAGPuh5+lH5oqPc1PcvuJ3/SneAXkm2Nl8kF9sACtNAWhTPSj0IzEs5lNYjcgq
	X14NPsLUN5lYg2BlrCgvAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792007514; x=
	1792093914; bh=SN7KcN+1sHiS19EbPR/Q2ewi8OhFSsLKdAo78b0NTOU=; b=g
	A5z1fKtaWBMVRqgo1Zv8KQurPaeG5P6rJpGIofIl/K/gf92dGbCX0vS+BByyX7no
	8IBYoZl6p9u9jT229nFw0pFxDo7s9khYzzZy/8Dg13vz8HtTqeFmcYLsMwrtAkrf
	23Qj/7BTFGNDgJvt2wou74mNW98fuC3tlVLHaHocQ85eilbpLAj+edmG54/okOye
	9TMdLogV6VmFOkNPS8qDR354yS6R/uKsnuSuAjGHaHxLjiDr33b0o9NRF8SYCfcB
	DuAL0tz9Fsyub091bGjy4xiSzY2eB5rIGmIN5iCHhuElIqLPYNEmjMQDrxU1O1m8
	Vvh4Z+h/s1Eb82yLEBLnw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792007514; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ssgAh25GviGA1rDxRPzMMTQxS134uIcDIoIANm1LRwDgaFD
	ExLFABbjfVH5lNzCDip14fVwrKJ0L0zTlBw4kEq0/5C+HKhLnlX4X10gfvIMyLL3
	AnHj1IZJJTtLUiOQ6KyfBplzLeFXxdefmWJiEz+A2BSH/mlZEmiFVXq3CYUlQ9n9
	fOjNvUF37Es1Muj4QxEfd66TG8uonPxZHWJRWODWUyp7RMIahv5W0jlBvzR/Nah1
	PPk/ici2pzL0UabaJwz3op0F+cWwZi8jJm9D7xWR4RN0HvCokM/pGYthRZEEnW2B
	5Olaf1aKppoW344Aq1ytJhZsaqD1i+PXwok5M1Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ugS2rciFwymGVJPLJYGm+fC0FTfy/ow5Yx/nyUaKS4c=:thJjediHs+BEasamNvdCCqdwXz/xJcJsevKRvqjnA9w=;
X-ME-Sender: <xms:Wt3Pap46ch63QR6zpSlFOyzonCsVG2J6FB8NroWurTjZ605HwerLIw>
    <xme:Wt3Pahu9g4BtC9JTUVdlGY4f9shyZk_ItFAdahsXLTrhcGwvq0NQiX4CdHL2_bPBF
    8F5hu5MeoBBeoBKaoUd1wgFQRfHoVsvb1QpQWZUdIuUalAowUVxujHJ>
X-ME-Proxy-Cause: dmFkZTEomg/Tk6sy4D3hup9hn7qAwoSa1fee5Znw5msK6w8Yg/GUcKaw7jQ7StJlh85Jrs
    53yOUSeouARQlKMDGoHUMauPFmPi83d0+xowV2465R6eigPc0KyU57Er4gvX2NTuUIaYy4
    cCoevnKElGz9aGvpkR0fhD8L7DBlPkohSbBuK8kzQaHW7QXkCW+VIphald37OAguGoDjoK
    R8wCHMFHlaeyPoWrXDCITygKhgVM4G3Tt/K5J2lLir6WGQhUV0nguX1vn/d/G3xEHE57Uz
    bkHmMZGXfTP2bvLSG23KuZdgNVLY80jNgNmyLv8eU+BUWJHuOjBh7Vc1Z0UKfdyFFXm/Pz
    DPyKXBWVOO/aBEjmJQk+sZDYaDHcJ1c86iWGm1kPKHtg2YEYOQj2u4xtJmBzD8zJZ5fILT
    o/0+BX4srHkq4sy8HFT3B9HLM9UnJlU2Y2Mu14HzdsrmulZbWhnKJMZ52O0DGEvXTPKvn5
    VGyLeDQXQuDfZf6zbwwiHj6cuMN+pAn2bfpWPIebIxF58E811q7brgnyMpo+rnfVv6qtr2
    qnu+cITGK+Bo9MhaQFeZWdMP7bjhSzb+882vkhK16c7wBpWLrCkY/F9C9IEM9W13O8RDel
    3vmaHt31fZR823KVsRSMV6+58q+dx6WNTjm5HbCcYr4l2uFXIzkJbOCC6CSg
X-ME-Proxy: <xmx:Wt3Pah8y3gMpXN9uY5DiYg0wzei7RHgNFmk5Zkjazjvwhiv3n2UhaQ>
    <xmx:Wt3PanNb2OKtdlwvcf8iXqKPPxikEG3ZMWLsOBAmkex58D0WlNTxYw>
    <xmx:Wt3PavH-YTXb61us3AaJEZLl_ttaicGYsZiGT80H3rdTzWZhb9AfCw>
    <xmx:Wt3PalRs7s3pMULl0fEQ6DKAmAROFTFA9RWu7mS3qxa2Yw00k1pbTw>
    <xmx:Wt3PapsWfqYPGaWyXy4ejciSaJXUR6uPLEq4nvTKh3cjgnaXDYxX2FQu>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E95A3782738; Wed, 14 Oct 2026 15:51:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AndINfi0Ib6w
Date: Wed, 14 Oct 2026 15:50:20 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Patrick Steinhardt" <ps@pks.im>, "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Jeff King" <peff@peff.net>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <695c53d0-6e14-4f4c-a3be-33a8e331f563@app.fastmail.com>
In-Reply-To: <as4RAcQxknZXcBVd@pks.im>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <pull.2237.v3.git.1791816795.gitgitgadget@gmail.com>
 <7aa0ae7ec3c1d02aa1533c27fa40f4815c03ba6e.1791816795.git.gitgitgadget@gmail.com>
 <as4RAcQxknZXcBVd@pks.im>
Subject: Re: [PATCH v3 1/6] doc: add new gitmergeconflicts man page
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Tue, Oct 13, 2026, at 7:07 AM, Patrick Steinhardt wrote:
> On Mon, Oct 12, 2026 at 02:53:10PM +0000, Julia Evans via GitGitGadget wrote:
>> diff --git a/Documentation/gitmergeconflicts.adoc b/Documentation/gitmergeconflicts.adoc
>> new file mode 100644
>> index 0000000000..3c6eaaddf8
>> --- /dev/null
>> +++ b/Documentation/gitmergeconflicts.adoc
>> @@ -0,0 +1,330 @@
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
>> +cherry-pick`, `git pull`, `git revert`, or any other command that does
>> +a merge. All of those commands use the same merge algorithm, and the
>> +process for resolving a merge conflict is always very similar.
>> +
>> +There are 3 ways to handle a merge conflict:
>> +
>> +* Resolve the conflict. (see <<resolve,HOW TO RESOLVE A MERGE CONFLICT>>
>> +  below for details)
>> +* Stop the operation and return your branch to its original state
>> +  with the appropriate `--abort` command, for example `git merge --abort`
>> +  or `git rebase --abort`. See <<git_status,EXAMPLE: GIT STATUS OUTPUT>> below
>> +  for how to find the command to run.
>> +* Or (if you're in a multi-step rebase or cherry-pick) skip the problematic
>> +  commit with the appropriate `--skip` command
>
> Nit: the punctuation is a bit inconsistent, where the second bullet
> point has a trailing punctuation mark but the other two don't.

Thanks, tried to make this a bit more consistent. I think I have some slightly
idiosyncratic personal rules for punctuation in bulleted lists that I don't
feel very attached to.

>> +WHAT IS A MERGE CONFLICT?
>> +-------------------------
>> +
>> +When Git merges two commits together, it looks at the changes that
>> +each side has made and combines those changes. For example, if one side
>> +edited lines 1-5 of `hello.py` and the other side edited lines 20-25 of
>> +the same file, then it can easily combine them since there's no overlap.
>> +
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
> Same nit here.

>> +[NOTE]
>> +================================
>> +Even if Git successfully merges both sides with no conflicts, it's
>> +possible to end up with code that doesn't work. For example, this can
>> +happen if one side renames a function, and the other side adds a call to
>> +the old function. This is called a "semantic merge conflict".
>> +================================
>
> Good callout. We may also want to spell out the consequence of this:
> "You should always verify the result of a merge regardless of whether or
> not it has resulted in a conflict.".

I think we should let people use their own judgment about how to use this
information.

>> +[[resolve]]
>> +HOW TO RESOLVE A MERGE CONFLICT
>> +-------------------------------
>> +
>> +The process for resolving a merge conflict is:
>> +
>> +1. Run `git status` to get a list of files with merge conflicts
>> +2. For each one, find the conflict markers
>> +   (the `<<<<<<<`, `=======`, `>>>>>>>`) and edit the code to
>> +   fix the conflict
>> +3. Run `git add FILENAME` for each file to mark the conflict as resolved
>> +4. Run the appropriate `--continue` command to continue the operation
>> +   that was interrupted by the conflict, for example `git merge --continue`
>> +   or `git rebase --continue`. See <<git_status,EXAMPLE: GIT STATUS OUTPUT>>
>> +   below for how to find the command to run.
>
> Same nit regarding punctuation. Or is this actually a thing, where you
> add punctuation in case it's multiple sentences but not in the case
> where it's a single sentence, only? Maybe this is just me not being a
> native speaker.
>
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
>> +* You can set the configuration variable `merge.conflictstyle=diff3`.
>> +  See <<diff3,DIFF3>> below for more.
>> +
>> +* `git log --merge -p <filename>`  will list all commits which
>
> Should we spell this out as `--patch` instead? That's way easier to grep
> in the manpage in case the reader is curious what the option does.

Good idea, will do.

>> +[NOTE]
>> +================================
>> +`zdiff3` is an alternative to `diff3` that makes the merge conflict
>> +shorter by making it more ambiguous.
>> +================================
>
> "making it more ambiguous" reads rather curious. Should we maybe take
> inspiration from its documentation and instead say "by removing matching
> lines on the two sides from the beginning or end of a conflict region"?

Hmm, I've gone back and forth a lot on how to explain zdiff3, from

1. Here's how it works and here's an example to illustrate
2. You shouldn't use it
3. You may want to use it but be aware that it's ambiguous
4. Here's more info about about how it works

I think Junio's diff3 example does a really good job of making it clear 
why diff3 might be useful. The previous zdiff3 example I had that talked
about the pros and cons of using zdiff3 didn't feel very compelling to me
and I don't know how to write a good one. I think a good example
probably does exist, but we might actually need multiple examples
(both to show how zdiff can be useful and to show the issues).

Perhaps given that we seem to not necessarily want to recommend
zdiff3, we can just not mention zdiff3 for now and add it back later if/when
we feel more confident about how to explain it. I'll try just deleting the note.

>> +[[ours]]
>> +"OURS" AND "THEIRS"
>> +-------------------
>> +
>> +Sometimes during a merge conflict, Git will use the terms "ours" and
>> +"theirs" (or "us" and "them"). For example, `git status` might say that
>> +a file was `deleted by us`.
>> +
>> +"Ours" and "theirs" are both commits: "ours" is the current
>> +`HEAD` commit, and "theirs" is the other side being merged.
>
> They may not always be commits, but they are always tree-ishs. But I
> think it's fine to leave this as-is anyway, as the normal user is never
> going to encounter cases where it's not in fact a commit. And when they
> do they probably don't need this manpage anyway.

Interesting, I didn't know it could be something other than a commit.

>
> Other than this handful of nits I'm happy with this version, thanks!
>
> Patrick

thanks for the review!
