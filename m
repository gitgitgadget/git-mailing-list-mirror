Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9271D4D17A0
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791219266; cv=none; b=msQk6xBcsUwT2Dx5pcxCpPBZtHwEAkevWC1pdrvbt3JGb1E3NCpPJ97LyhZBvLISL2mBRT0+btWlo1cB96ugmtAObKVopM/cK0qgtCUwNQd8JiRxuSC/fV8lPczggj4wQiMJIaWBs5Egp5rLgVWhS82i3OHhBe5xWR0+n+H2zek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791219266; c=relaxed/simple;
	bh=ZqO4oSKZjGXPxkWmlnR6NNsspqq1y58QUS1Dk4B4MGA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mWzTvMNBDZI0LooOvrfV716WeVB6CnZ6xW4fPLjDigL6B/1oKqVV0Yabp3ubSxIdoshOy22MXLkLyGfimS72gNjxDzjt6V5Y+Mk57qTaTpAspobR5TrfZFRjwl1mfVQJSM8ibEX72K8ZIH6yQMviehLjHnPHyaB69lSvXSly/qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=ow+4qCfl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D5owUg+4; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="ow+4qCfl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D5owUg+4"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AAE96140018C
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 12:54:23 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-07.internal (MEProxy); Mon, 05 Oct 2026 12:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791219263;
	 x=1791305663; bh=vzae4i8sp3h8m6JLnrtcIGwzLWpQ6VEWCEvewuDtxRE=; b=
	ow+4qCflEGMpMDJj7mlX51gXQWSrrgNAYc0g55gdQE+9IFONjCKaxhuAv03Q6luH
	gfbN1h3dSQ80kSDfD54rOpfzioq2YID9f1SESqZW9ZnjewNRHhTmfHqjh/IfL6WR
	y4U5hgEKjE5LhPMRsos9/ldKa6hotoGPFqisKwIvsQMa16AH5Uw7rQ1NEDNj53Yv
	HnNnigtVfjY1D0yikBlYo9eAmBQpxQWrFMpb0SxFyEBEM+Q3YaEr+4yO2lS3lRpW
	XPEP0sAVa+70Anjay1WSstZbQj9gEWRMGi2ecpwKnFefnp2OFJmRED3DnQ4685RL
	YKqQe6YMxeDJQ2D89MyMZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791219263; x=
	1791305663; bh=vzae4i8sp3h8m6JLnrtcIGwzLWpQ6VEWCEvewuDtxRE=; b=D
	5owUg+4xRvCnILzvKoxLxoVsKK2o2ZWI07jS5MENQKSWcQcjooSYW/f8Hedy1Xoa
	TEwTEXSVZWpcDwK9H+6Q8NtcemESR4jK36SIyjbr+2Q8BuI9O//qXBH7ke23ptbu
	jz1686dCwO22SUXKkCeZB5GVC0YVTqycf1R+8rfCJ9i8IcYhdx0n8BAuiulaZ8Mh
	2L9yOVJ//idJkgZHiQqWyBOSYt8sjVql2mhXGyY2tOo1cTv7sMj3b1Izz4SLjm+H
	DGe2lOD2cx1Tsm/qcn8VTIoEa6r9VJawVqLTZs98Mn3vUCBRZDv7JWz1dcvu8mK6
	T2Y+dzJZ0tu2LKAzmG5Qg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791219263; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:vSyR7pAwogqQjmrfnySvt5MfZSoeGLGschb+pdgeIqbcLWF
	pB7BDsNUzWOK2qd96whj1ErwowGkX02vHOoMff75NXZBO8rwx+2R83R1P2Ik/J0D
	KeNSZtkQsotd9anbe5pXhx+fBniIZ/xLT54jBjw9Nl1JW5HUh2VK39zXo/xqyxNv
	PKvfU63ifhx0xcnmMdI+9jPckfkofL0YX1zWbWW8HuLrX4IPS463vUCnV2gAZ77k
	4+qGei34ztAWTA+Ewm2NoSQjbbrZcaGzZsCSZs9WMjw76eacqg6mpeQ0efAfVstm
	JCNuYK3y34hrWGN6OffXgtXJ7gNeJVRMAHNGiuA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ZifNdZVmHWvuRdPuZLM5TlC4YRuBTy/7+j/7kUTSWeE=:ZqO4oSKZjGXPxkWmlnR6NNsspqq1y58QUS1Dk4B4MGA=;
X-ME-Sender: <xms:P9bDakGXoVL69GB2_GoD1qP-xA10AleWPgEA--jOmOr7qv90-rnOPw>
    <xme:P9bDamwC39e4iEwJkz9PmRq-iGobAKQrTlX-YhKmFXm2aD--ZqbNm0hs2E4KM-X0d
    eYm6Bv20b6iq0j060sWJofeCQ5pqOQcfdKuCXVnRkJyeuBGitMJqts>
X-ME-Proxy-Cause: dmFkZTGeUcR8M7B1MIfpXYKw3O7VgqxL3IPuSJSTcMpFMb11z4QRwjn5N5h1sz+jHucDup
    2BkUxPhyMInV9ug+KiL22geOjb8wQ1UbkKpC4Ig2S+ezuUSpoTdQa8Kc9CrhNyLWkBV+3u
    IPIb4ixSwNYjF/fYw2s8vIG5TDcu0eNrK2fAcrUI9Uu7q9jATngPCBcQeBTn9ClI8q7VrD
    B980Q4paSuA5SizWMunliGj31aWYhgbcxzQ3dnknbJTkoBx/Mg+xdr8/2UsUkjlbx4IxAB
    cFpdjS97/GVKCJEXAHUCHxxQFDgZ6BkSDbgMCJMOTgfvQbJQLviRTjeDuo7AustND9GvOw
    nzs8HvjCcCKRZp5Fa+PsP3T28BWzS2mlYHIJoMCEP0sgv1fpgohuv49NI+UPt419gy8P4n
    WldP9ZIObD5NrPq88JRWIxzz210tZ1rAb51DiS914Ah7HDTr56JrU1vLI07/3djZ6zQSK/
    G0J3NpWKSaYovY1zP9IjCoizOi0YB+q/EEX4GrXwnacwYbpYW4GQxkoGTXMuuA1auC05a7
    XiCKcSg/OwAluVlpmup7crOejRC/sdRqVeNGc4RiwpuW83Z1hYObhnzuR+5b4cKMV2QlxP
    wrd7lUFN8Qom+lYUNrDgwEUesVkA4MQvUVZqF7S9pf7wb6e2FbCyUbNBXRfA
X-ME-Proxy: <xmx:P9bDarCbH7Sg4ltpmyX1uKtJmDsko-7i1G27r16m7rFTfRihQ2tuyA>
    <xmx:P9bDaucnItEcdOVc9BnI87N9kakNH2xkmgBOKvv9bvykPh4ythlQwg>
    <xmx:P9bDaiOlQUvLH5Yk3AEtG32nZjbQ3plGKK9h-Q3MmU8d5HNqkY5Nug>
    <xmx:P9bDamJQ08O283ChxVOtS__cU7QGNQEMbo0UforE-V9c6lqadOnHIw>
    <xmx:P9bDartFHhtUXhSpW--7cVF6-3zcViFipDFuUo1zWc3Awq7yM22hSsZy>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 750EA780077; Mon,  5 Oct 2026 12:54:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4MQIL0NZ3EZ
Date: Mon, 05 Oct 2026 12:54:03 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Patrick Steinhardt" <ps@pks.im>, "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <e593f3ca-4a03-45a7-b0cc-6295a3a4939f@app.fastmail.com>
In-Reply-To: <5ba2088c-4919-465f-8892-4ed0685f81ea@app.fastmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <ad4853dc36cdb883c9a8dc6bda747a5ea318e7a8.1790261062.git.gitgitgadget@gmail.com>
 <ar0MVRV5X8zgZfLy@pks.im>
 <5ba2088c-4919-465f-8892-4ed0685f81ea@app.fastmail.com>
Subject: Re: [PATCH 1/7] [doc] Add new gitmergeconflicts man page
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


>> [snip]
>>> +[[ours]]
>>> +"OURS" AND "THEIRS"
>>> +-------------------
>>> +
>>> +Git refers to the first part of a merge conflict (between `<<<<<<<`
>>> +and `=======`) as "ours" and the second part (between `=======` and
>>> +`>>>>>>>`) as "theirs".
>>> +
>>> +Normally, "ours" is the commit that was checked out before you started
>>> +the merge, and "theirs" is the other commit.
>>> +
>>> +But when the merge conflict was caused by a `git rebase`, it's the
>>> +opposite: "theirs" is the commit that was checked out before you started
>>> +the merge. This is because under the hood, `git rebase main` checks out
>>> +the `main` commit first before doing the merge operation.
>>
>> Hmm. This part is a bit confusing to me. "ours" is always the commit
>> that's currently checked out, and "theirs" is always the one that is
>> getting merged into the checked-out commit.
>>
>> How about a variant of the following instead?
>>
>>   In a conflict, the side between `<<<<<<<` and `=======` is "ours"
>>   and the side between `=======` and `>>>>>>>` is "theirs". "Ours" is
>>   always the side that `HEAD` points to while the merge happens; "theirs"
>>   is the commit being merged into it.
>>
>>   For `git merge <other>`, `HEAD` is your current branch, so "ours" is
>>   your branch and "theirs" is `<other>`.
>>
>>   For `git rebase <upstream>`, `HEAD` is first moved to `<upstream>` and
>>   your commits are then replayed on top one at a time. So "ours" is the
>>   already-rebased history starting at `<upstream>`, and "theirs" is the
>>   commit from your original branch that is currently being replayed.
>
> Thanks, your suggestion gives me some other ways to think about this.
>
> I think I'll try to write something shorter that is unambiguous, 
> instead of trying
> to use more words to make it feel more intuitive. I don't think I 
> actually know
> anyone who feels it's easy to understand the way merge conflicts are
> presented, and more explanation may not help.
>
> It might be more useful here to encourage (again) folks to use one of the many
> amazing tools available (in the "tools" section) to get more context.
>
>>> +These terms in Git all mean the same thing when dealing with a merge
>>> +conflict:
>>> +
>>> +* "common ancestor", "base", and "stage 1"
>>> +* "ours", "us", "stage 2", and `HEAD`
>>> +* "theirs", "them", and "stage 3"
>>
>> I wouldn't say that "stage N" is equivalent to the respective other
>> terms. These stages rather refer to the different versions of a specific
>> file as recorded in the index, they do not indicate a specific commit.
>> In contrast to that, all the other terms may also indicate a specific
>> version of a file, but may also refer to the commits.
>
> Thanks, will try to figure out how to make it more accurate.
> We could also refer to gitdatamodel if folks want to learn what the
> term "stage" means too.

Marie and I worked on the OURS AND THEIRS section today and I think it's clearer
now but also longer (instead of shorter which was my dream). We added an attempt
at humor at the end to hopefully help things a bit.

	"OURS" AND "THEIRS"
	-------------------

	Sometimes during a merge conflict, Git will use the terms "ours" and
	"theirs" (or "us" and "them"). For example, `git status` might say that
	a file was `deleted by us`.

	"Ours" and "theirs" are both commits: "ours" is the current
	`HEAD` commit, and "theirs" is the other side being merged.

	The first part of a merge conflict (between `<<<<<<<` and `=======`) is
	from the "ours" side, and the second part (between `=======` and
	`>>>>>>>`) is from the "theirs" side.

	----
	FRUITS = [
	    "apple",
	<<<<<<< HEAD
	    "cherry",                      <- ours
	=======
	    "banana",                      <- theirs
	>>>>>>> add-fruit
	    "mango",
	    "orange",
	]
	----

	During a rebase, it can seem "upside down" because the "ours" commit is
	from the branch you're rebasing on (for instance `main` in `git rebase
	main`).

	These terms in Git all mean the same thing when dealing with a merge
	conflict:

	* "common ancestor" and "base". The files from this commit are "in stage 1".
	* "ours", "us", and `HEAD`. The files from this commit are "in stage 2".
	* "theirs", "them". The files from this commit are "in stage 3".

	If you're confused about what something like "deleted by us" means, it's
	often easiest to use some of the tools from
	<<tools,TOOLS FOR HANDLING MERGE CONFLICTS>> above to get more context.
	Finding the commit that deleted the file and seeing why is usually more
	helpful than trying to abstractly reason through what "us" means.
