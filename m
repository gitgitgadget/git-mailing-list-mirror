Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0627E3B19C2
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896119; cv=none; b=TeV8rCsaMc6Q4XNJFRwuxHdCiuX+35zfljPs8nDUkCnFOhqQLxXWND709AQIErJMgYyVg/54FlH3BW8qLfnUkzQLka2JRxzRwYuHghMC6zz83U64aVLOn/zrYld4bLVdiXB1Za0/3b76vPrG2CKov0YjceStcKtxlRUCeo9YKTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896119; c=relaxed/simple;
	bh=dDtio0OKX16rQJSpDkMiwN3g/qJk6GhPo3TVTIguMaY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=vDz8SH6P9EJVc/ZDAvWFE04x824+zV4GHW0zq7AadxIVVfj3Slk1uu6DAHM0A1m2kzKaK7/r7f+0vS3U0ZJRrqZWExf+r9adNLJrjN1gAcPXjVyUDwB898wSAleS4GdaVnXygvxB9mtM1UVOjF+rY1PSyZLjES89/nmt8zkn7uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=WAmoQAhb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lWLRiyNb; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="WAmoQAhb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lWLRiyNb"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E2F6A7A00C0
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 08:55:16 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 13 Oct 2026 08:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791896116;
	 x=1791982516; bh=npwer/sDFGJeQSwvmru47qi/KxCRSVYZDxURestyX+o=; b=
	WAmoQAhb9zCQux1Em/gqd5e5mJ5wDt/FHJFjUMF+xyaEcQAlr8oP2o+URUbAb44l
	wbgQ+LvYV6yQWJ76pbaK7O1aNYvT+9O3i4VEzk6WBmQ/+EyXoUi0uRRFLwuTDIlY
	l5PoomSFE8UWtsfgMFzroK0pQh/nlWQTGfno+I6tzPcuxbG1jvT3Jtt2CaaJAQGn
	u/FHTREybBG5Y3aV91CfQivkRXTotutFWnV0zZquav+KnW9hrdYaVmdXAnOlKCxU
	iZ7hft316cPrmFmnXxD+qFkazjZij6rz5lDymKmYrVMtHl3VccDetyaAHd4tjbmQ
	weGpwnQFXNzYqLc96rLl+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791896116; x=
	1791982516; bh=npwer/sDFGJeQSwvmru47qi/KxCRSVYZDxURestyX+o=; b=l
	WLRiyNbmg35baFvcv9GOSt+VgsKtZ7qGcDLrVTMHXx6xbed1xn/0Qie/hzeNriqJ
	UbhbsySUPlOsI78F3CykQhYxGarW+5Wrd19CPfoeznBawYifrYL+x08C7qwJQ1MC
	rRYwNrRBsx0x21nvzN6GorSKFfU8d3WoUAYfhvIfxYXYsLvr9ODwDwMeCXJfNs3R
	Gc/WUbeE3PMpSYc7OBaP+RhpXxRckhIPr1xazHwKPLcgtFo4vSM2CEcljuExfY+u
	KVcFw/poUll5meYqkZGUQNp6odZDJGqJV0Z0cUg1isRHEUNVJ21XCOgw4Vtdougt
	ZLspzhwLW+z751K/8hxNQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791896116; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:R5VMjJz5eH1V3VzVMpedJxJvXeVSdNhNe53QYv8xcl7CX4K
	qKoY5WakMfmDpegCOWgBZEZgQo2MQkmtiXuFju2HqbURsJVZ7OQaKU9RWX9Cb6jz
	WhqzGNaGgF74355VyfPnMed2Kfx77G/w9j1N0mba7tPvvgCuiSXAS4cUW0JQ/iBA
	nKcq9JPSOOQx2tjkxqSlvbe8df3XWxMMzJJS8tUMcP6RVjJbS5MGn6PB/ZhwWUut
	bp7C0fdzpWfu7igOFtdOvi4brPeDtm5K9xEVYPrBoSMig0XtKU8CtiHknP31gN5J
	txcoZ/xieB9UmOydLArs9WRR4zBBB+GT0/K71VA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:NfrgzumH8HpeJpWvFQ/z3yZev8EDwJVxgLZwCaB0TrA=:dDtio0OKX16rQJSpDkMiwN3g/qJk6GhPo3TVTIguMaY=;
X-ME-Sender: <xms:NCrOan6-3hP-18KelUbliXdFIWWcqzGWacVVbkCeK_TLNE3iZ8PgTA>
    <xme:NCrOansjs1CxwyHz-v1oNxp9M3ssjbJx6DHSPNapOxIXEpGXcXZqtwDTWoIUshy30
    c3bDmNT1rJTuJLdqiwdfEOU2ERYWe4RkoCAXMY1nc0RNMNzUeN7TAvM>
X-ME-Proxy-Cause: dmFkZTGuMWsFoV+SSxzxcycPx4lSv+8aKBSgZO2BZQ4mkm1nR4jhcgIAOD4g1ISSaSm+O+
    lc++5rDOkD5AJeyAPXXql0GAHYvtCInwmuc4yUEVwvEyeZmx0klzjaGO/q/dVzTxN6bOYC
    ZGRx1Pmdh2TGCSyDKLxwTl2p6EhYBbPFnXe2xDDpQeUFirxIYfYd3NdML2Bm4Ibl9ilTic
    d1gIcS90k9P6S7fFZwagP0JYCqg+25fzO6cKg3Ks6nsqD6bpVIYNf2lO77sPM9mG35VnX3
    uGSUrKS5vjfP+YJ8ZV/dty3mwut1HwAdJeRkD4hsnvsp/lhfwMImiBQsPT9PXXzBSqJ6Pb
    Yr65R06sww4688kSFq2RP1ksnAeaqMZhhi1PVG2KIYie8pgmvgzw9wR811LN591lTCs9Bq
    Z6FBI1ffv7Q96lA2a8DidsbSX2I/r/6zsqg5pR2almAhlQswglW4ZuaOhKRe11o9dCAlUF
    3E9cifY1ogr98w/D7zkBQDvnLHbKVRwG3uiQq7XiGPUbcw9svC8uS34+TR9QrvQxballe5
    0G2ZP2wTgAtYj4AQDdNryT7v+qEdGEyvoQ8pq4N/B61OSRdCfLI+JDhede+akXxXl+kwcZ
    wzOeI8+09rGem/1F1EW7axxDBRdwml6w3XKxWxL28l7EmYNEmhaz51L+axLQ
X-ME-Proxy: <xmx:NCrOamWn6QCGqT0onzo9PnUuDbWvBkr4q8s97hyV-f3gZ5YzYDYxiA>
    <xmx:NCrOaqWHxx9Kv9xS04nqj3-0ICuNqMLZkAswlIG4P7u7aZvirQrOyQ>
    <xmx:NCrOatd6UFhR19oP4CwXsxkfIGt2304-xnwZ0ccfOyX1doDS1n-RNg>
    <xmx:NCrOarX4ZqMOmNrCqgMhBAeZw5mdgsJBJ-1UdnIB420FT8Zw20iTMA>
    <xmx:NCrOapycccB4YfPKqscKJBJym1hLxIJWTaXCkzo-PkK5zYQ27kFL0niO>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4F877782738; Tue, 13 Oct 2026 08:55:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1sfaQj8oK1o
Date: Tue, 13 Oct 2026 08:54:56 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <31f8c254-328b-405f-bc26-b077fa57b5ef@app.fastmail.com>
In-Reply-To: <xmqqik3da2bs.fsf@gitster.g>
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
 <xmqqik3da2bs.fsf@gitster.g>
Subject: Re: [PATCH] doc: checkout: rewrite detached HEAD state explanation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thanks for the review. I'm going to mark comments that I feel are about style issues
(like "could this be explained in a more clear way?") as just "style comment" to deal with
later.

In general if we really want to make sure that this is as clear as possible, I
think it would be most effective to do a second revision later (after merging
this) where we get feedback from users and find out what folks are confused by.

On Wed, Oct 7, 2026, at 12:43 PM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/Documentation/detached-head.adoc b/Documentation/detached-head.adoc
>> new file mode 100644
>> index 0000000000..1e00712124
>> --- /dev/null
>> +++ b/Documentation/detached-head.adoc
>> @@ -0,0 +1,43 @@
>> +`HEAD` is where Git stores your current branch. `HEAD` can either be:
>> +
>> +1. A branch, which is your current branch.
>> +2. A commit ID, when you don't have a current branch.
>> +   This is called "detached HEAD state".
>
> HEAD is branch which can either be a branch or something else?

Style comment. Probably this is the one I'd prioritize the highest.

>     HEAD records the state from which your current changes started.
>     This can be a branch (the "current branch"), or it may not be
>     associated with any concrete branch (in which case HEAD is
>     "detached")
>> +It can sometimes be useful for `HEAD` to be a commit ID.
>> +For example, it lets you look at an old version of your code
>> +(with `git checkout COMMIT_ID`).
>
> To "look at" an older state is more versatile than simply running
> 'git show COMMIT_ID:path', as it allows you to do anything you can
> do on a branch, such as building and testing.  Thus,
>
>  	A detached HEAD is useful when you want to tentatively visit
> 	an old state with 'git checkout --detach v0.1', without
> 	having to create a dedicated branch for it.

Style comment.

>> +The only problem is that if you create new commits while in detached
>> +HEAD state, those commits won't be on a branch.
>
> I would suggest rephrasing "The only problem" to "One caveat is" or
> something.  When sightseeing and experimenting, the ability to
> create throw-away commits without the need to clean them up later,
> or to invent a unique name for a temporary branch, is not a problem.
> It is an advantage.

Style comment.

>> This makes those new
>> +commits much harder to find later. Also, Git considers commits that
>> +aren't on any branch (or a tag or other reference) to be garbage.
>> +Git will eventually permanently delete those "garbage" commits during
>> +garbage collection.
>
> Correct.
>
> Perhaps it is better to clarify this by adding "after you leave
> the detached HEAD state" after "to find later".  While you are in
> the detached HEAD state, you can run 'git log' to find the commits
> you created there, as you can do everything you normally can on a
> branch, or use 'git reflog @{now}' for that matter.
>
>> +There are 3 main ways you can end up in detached HEAD state
>> +unintentionally:
>> +
>> +1. `git checkout COMMIT_ID`, where `COMMIT_ID` is a commit ID
>> +2. `git checkout v1.3`, where v1.3 is a tag name
>
> These I wouldn't call "unintentionally".  They are documented and
> supported ways to do so, and will remain to be so.  "unknowingly"
> may be a more fair way to call these gotchas, though.

Thanks, removed "unintentionally".

>
>> +The easiest way to avoid accidentally ending up in detached HEAD state
>> +is to use linkgit:git-switch[1] instead of linkgit:git-checkout[1] to
>> +switch branches. `git switch` won't let you detach unless you explicitly
>> +pass the `--detach` argument.
>
> Correct, but the motivation to 'avoid accidentally ending up' may
> want to be spelled out.  Most often checking out a tag is to go
> sightseeing, where you do not want to 'avoid' detached HEAD.

Style comment.

>> +To get back onto a branch, you can:
>> +
>> +1. Switch to the branch you want to be on, with `git switch BRANCHNAME`.
>> +2. Create a new branch at the current commit, with `git switch -c BRANCHNAME`.
>> +   You might want to do this if you've created new commits, so that you can
>> +   find the commit later and so that it won't be garbage collected.
>
> Very good.
>
>> +If you create commits in detached HEAD state that aren't on a branch,
>> +you can find them later using linkgit:git-reflog[1].
>
> This, as you already said, is "much harder to find later" option.
> There should be a better recovery option described here before
> resorting to "git reflog HEAD" after you switched back.  E.g.,
>
>     If you have created commits in detached HEAD state and then
>     switched away from the state, all is not lost.  "git checkout"
>     would have give you a warning message, like this:
>
> 	Warning: you are leaving 2 commits behind, not connected to
> 	any of your branches
>
> 	c816689 typofix the previous
> 	8e1bff5 decsribe detached HEAD state better
>
>     You can create branches to keep them, e.g., "git branch saved c816689",
>     by using the commit object names left there.

Thanks, added a mention of this warning. It's a really nice example of the ways
Git helps avoid issues.

>> diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
>> index 2aefea0228..4e9e94e24d 100644
>> --- a/Documentation/git-checkout.adoc
>> +++ b/Documentation/git-checkout.adoc
>> @@ -376,135 +376,8 @@ For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
>>  [[DETACHED_HEAD]]
>>  DETACHED HEAD
>>  -------------
>> +include::detached-head.adoc[]
>
> Losing the diagrams is a bit concerning.  However, if the intention
> is to have readers learn how HEAD refers to a branch pointing at a
> commit with history structured as a DAG elsewhere in a more basic
> concepts guide, I suspect that it would actually work better.  This
> could even be reduced to a simple "see also" pointer to that other
> guide.
>
> If an existing user only uses 'switch' and never reads 'git help
> checkout', they are already not seeing these diagrams, or perhaps
> they learned the concepts elsewhere.  They still manage to
> understand Git well enough to make use of it, so perhaps this
> approach is OK.  I dunno.

Thanks, good idea to give people a pointer to more info about HEAD.
I'll try adding a pointer to `git help datamodel`.

I'm not against adding diagrams, but I think if we want to add diagrams that
should be a separate project where we actually get feedback from users.
Similarly for explaining `HEAD` in more detail.
