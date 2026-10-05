Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25C04AF9D4
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791227504; cv=none; b=WOCygYk56UkILEJVZ727w6hBGB3EczamLxBHsovuqerqjwTVh/n2lPU//mEr3LJSin/kdzfN99t/9+/S2PVWAZvN/GI78Nn2RHN18TaXxO0Sj3MHszqnXwP0TSvsGTkriHTvu0WvppZOr4/6YVsxldfzxUfzVYmCPsUKivlCmvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791227504; c=relaxed/simple;
	bh=KjpUE4HLPe1QcFtNowsneiTtnJl90BdCmrFsOFcW9fU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ke4TrYcuAOS2dK/O7dJv2yDX3jQ4JHJPOIzLwcKpbWEs4Erw/fOjm+zxF+ktACWoauA4uRnah5s6vFk3TY10TsUe+mzdcNXh4pQ5PDAX7Dd6TD4ab8DQn+WyBAbaohC0L8oCn8gTiMFBwREWcdvTli9s7P52ip7FLFnXdGYJTwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=JWwJJWiI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kBMHWXkF; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="JWwJJWiI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kBMHWXkF"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DD37E1400081
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 15:11:41 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Mon, 05 Oct 2026 15:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791227501;
	 x=1791313901; bh=Xfee9gjkj+wpjegXuQKblBtyN3PlsfOSO9lt/j+afYQ=; b=
	JWwJJWiI0WI/YTSGhttWtYtmP+7XCVVe7+Jp3XIB8/hjD6PZt+SF75K6RdXPuWqR
	NtTOftxY255MOxYuM2sjPDALZYBMXUKiJBmwe2awnVin1BLugBNp3XXsl6uheXWu
	oOYaEATVcTVIGUNP1UNAp5Ejmh2nkQo3Cj5P+0XfeEtwTQqdyZgL8wPfQ8kuOSnV
	IGTOj2DL6PCdnOjDerrDqYVtiyENtBa5g7YkE5qYmufv23EQEPG9BhV9SWFIZ1s6
	j7V/010ONqM/GCOygjK1UlyqtRWWDA/fn1qdFLeU2ci1dJfZJ3rLTfwHisSOx/tF
	x+DueOdckZpH6HUwNA5EMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791227501; x=
	1791313901; bh=Xfee9gjkj+wpjegXuQKblBtyN3PlsfOSO9lt/j+afYQ=; b=k
	BMHWXkFGqoeLjs9vEdI8tRQet0SdMfRoq9SLlCbO5LVIFD7qO40KrcwBoiWV0b9H
	hv9pMW8R4/6aV/fP7eteF4s2g7jlmc714jMDA2EhBMLfyNag95cbjmjpk9yX1Qel
	gMsJKc3UPtGkNOnNQr4JzcgxE2ni4imqgPh1nNL/htFp+S7FsiiWM6amlaIfLRA8
	GFSVg8MOAa+ZCBvEZ/7KuOZqkevcmSLz9NkOc+G3xTpVjEOTpqsnVKwb5Dc5Fmls
	LKnmuDedfdoyokABCX3eJWklkoEo/sVy0Slu21cKzjBdXJ1GactzvWgPmrCvQ9yc
	e4ktboPAk9y86fFRv3ULg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791227501; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ecFM+V4IxMynlHMV4y3n3pcp9leienBVEMW4fJfQTRZ+A26
	v4coWk9yUSVCayijuYXffrqW98OysP+2tGikA1kEO7xyORG8TeKahdV75SxJrAgI
	W2T87qGEtkOfLc4HxVrfm5GToLJ4FHdA89GiBJXCM+FQ08IcaWkR966s2AcB1RLz
	IotbOylsMv3gQ/TBf32Hn0y/YB6GW85ToyDNdr7iirSSvufp6gpfApbKCoU1m+LM
	iXLcHDRnKx35Kjg1sHLNKTzRG2ceqaMWnPhTuQemiojRUGSQrDBR+JQR5URhv3mn
	liSh27vIn87AbONDxtsFMbEp7x6lfAHwpcsycOg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:d5yTb5ptHzkZgVJr5W2iXoT6VKQlhaJRFKaomKqJLTw=:KjpUE4HLPe1QcFtNowsneiTtnJl90BdCmrFsOFcW9fU=;
X-ME-Sender: <xms:bfbDahH0aQ_S5D7XdxImojcrIueijGyjwscKhN0-4b16jTPxsuajeQ>
    <xme:bfbDahIFn1oNLXN13KUGkK5XWrz4x-R1k6NxRZCJB6FF-pE-GJ5AavU8gpcMHJ-3J
    8AyEVfdGqh_lMdX1HQWWVOk-tRzflrHBCmFFi8jzJvUkCl7V7zg3Pc>
X-ME-Proxy-Cause: dmFkZTFdRZSFdwWVFQFyN2Y10KUHnHNiTet0RaHdfHCvLcOL+5PbG1NIdQdTFVGSP4Hk3r
    otb/HvMSK3fewAKlpsoUPz6zaxCvLdle1raNXB6Y5/lSEwjtHON7tbDjObvvNkd/mOE7YU
    EAfqtPUBaJbOaMZifhR3KJ96Bs9M8PnfqJXuby05iah3eV7BpIEh+IRtvyKQHuPR+TbYDM
    AHEs1NB3uAnwSKo2HM5hX/zDC0CbShJE1EaDe5kw70pt4OnP17LJ2WRjRTnBJl2EDWtp5C
    mg6NpWYTyOorm2GkX2KPULQGQ94gqmC71sN3XrdIbD9XihrHU1jI6/cXf/iVnjko0cddVq
    yMqiyNFUk3h4zDM/7p1r62+KlmCqlJyPzDtzDTH4xoHDzjBW1wglhEOlBrP7kfp+DoGTET
    qCIZpFDmgf48X6+s4RaD25a48kbN6C87lAVDQwqpoCqhzmqAPZ58X57IAVlRcXqpm3EWYx
    Nsg/ylgrnY1dLv/877q8po961a8igj3DSB8jtFLFQELK8XzWs0D2K1eRvCb6wOPVCdrLWT
    fV+ounGF387Dg0Aq5/vQrbk28TiSdNLZRbl0ttHQbcrzQtknjrnVIV+yhaAXE6pSh16XEg
    q19VsMJ9djUPZzpjZ/e9ojhLt39fsjyUe4NC3Ch54GNkAy+W6Csh03f5q8ag
X-ME-Proxy: <xmx:bfbDaiuvNbKtuB8rXKQOrAApKtk432Zkdlm2v1NTSatPjMysQA6vaQ>
    <xmx:bfbDalRFALtxnpoVfylL9bzoKrrtzTDATxCj8FmcpOGgrr0yt3_p8w>
    <xmx:bfbDaoMyGEzAFEVLb-tLDJu8FubAA7-t-EWJYJJKEVR2DI43La4tYA>
    <xmx:bfbDaqaBCZ2ENstPaC8synS_zXng34yQsRzB089NrcE1mMW982j0yQ>
    <xmx:bfbDamgb3tjNFd-FbJso6xUkgRnArsdNv2HV_WjUErP2t722J2axEQSu>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9D48D780075; Mon,  5 Oct 2026 15:11:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4MQIL0NZ3EZ
Date: Mon, 05 Oct 2026 15:11:21 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Patrick Steinhardt" <ps@pks.im>, "Julia Evans" <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Message-Id: <e2ef9cf9-a87b-4374-bedd-8f7ab1114961@app.fastmail.com>
In-Reply-To: <xmqqik3gjc5j.fsf@gitster.g>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <ad4853dc36cdb883c9a8dc6bda747a5ea318e7a8.1790261062.git.gitgitgadget@gmail.com>
 <ar0MVRV5X8zgZfLy@pks.im>
 <5ba2088c-4919-465f-8892-4ed0685f81ea@app.fastmail.com>
 <e593f3ca-4a03-45a7-b0cc-6295a3a4939f@app.fastmail.com>
 <xmqqik3gjc5j.fsf@gitster.g>
Subject: Re: [PATCH 1/7] [doc] Add new gitmergeconflicts man page
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

>> 	During a rebase, it can seem "upside down" because the "ours" commit is
>> 	from the branch you're rebasing on (for instance `main` in `git rebase
>> 	main`).
>>
>> 	These terms in Git all mean the same thing when dealing with a merge
>> 	conflict:
>>
>> 	* "common ancestor" and "base". The files from this commit are "in stage 1".
>> 	* "ours", "us", and `HEAD`. The files from this commit are "in stage 2".
>> 	* "theirs", "them". The files from this commit are "in stage 3".
>>
>> 	If you're confused about what something like "deleted by us" means, it's
>> 	often easiest to use some of the tools from
>> 	<<tools,TOOLS FOR HANDLING MERGE CONFLICTS>> above to get more context.
>> 	Finding the commit that deleted the file and seeing why is usually more
>> 	helpful than trying to abstractly reason through what "us" means.
>
> May I ask what is in scope for this effort?
>
> We previously discussed updating the conflict markers (the 'HEAD'
> and 'add-fruit' labels in the example above).  Doing so would
> require code changes, which goes beyond mere documentation updates.
> But if a minor code change like that makes the documentation much
> easier to understand, I think we should consider doing so.
>
> Along the same line, if git status stopped saying "deleted by us"
> and instead used a different phrase, would that help reduce the
> "upside down" confusion [*]?  Is it acceptable to bend the code
> a little if it helps the documentation?

I agree that would make sense. I have some changes to advice
(on other areas) in local branches on my machine already :)

I think of it as sort of "documentation driven development" (write the
documentation, and if it feels upsetting what the documentation is
saying, then try to change the code so we're happier with the docs!)

I don't have a clear idea for how to improve the way `git status`
presents merge conflicts to make it less confusing right now though.

Brainstorming a bit, here's some commentary on this `git status` output:

	On branch main
	Your branch and 'origin/main' have diverged,
	and have 2 and 1 different commits each, respectively.
	  (use "git pull" if you want to integrate the remote branch with yours)

	You have unmerged paths.
	  (fix conflicts and run "git commit")
	  (use "git merge --abort" to abort the merge)

	Unmerged paths:
	  (use "git add <file>..." to mark resolution)
	        both modified:   fruits.py

	no changes added to commit (use "git add" and/or "git commit -a")

1.  `(use "git pull" if you want to integrate the remote branch with yours)`
   is not helpful advice here, it's not even allowed to run `git pull`
   in the middle of a merge conflict.
2. `git add` is sort of not helpful here, all of the unmerged files currently
  have conflict markers, so the next step is definitely not to run `git add`,
  it's to edit one of the unmerged files. But perhaps it's unrealistic to
  be running the equivalent of `git diff --check` in `git status` just to
  help users out.
3. Not sure if "unmerged" is the best term here, maybe "conflicted"?
4. It gives the advice to use `git add` twice which is weird. 
5. One part of the advice refers to the process of fixing conflicts as
  "fix conflicts" but the other part calls it "mark resolution". Should
  probably be consistent there.

But as you can see those comments are all over the place, some of them
are just wording changes, some of them would involve adding a bunch of
conditional logic to the advice system that might not be realistic,
I don't know.

> [Footnote]
>
>  * I suspect that the "upside down" feeling is not really about the
>    terms "ours" and "theirs" themselves.  Rather, it comes from how
>    one conceptualizes what 'rebase' does compared to 'merge'.
>    During a rebase, we temporarily pretend that we are working on
>    the upstream branch and replay our local changes on top of it.
>    Once the user adopts this mindset, displaying the upstream state
>    first (the point from which we start building the consolidated
>    history) followed by the local state (what was done differently
>    by the local side) becomes consistent with how 'merge' displays
>    conflicts (where we start from our local state and merge the
>    incoming changes).

I will say that I know all of these facts but it has never helped
me to remember "ours" and "theirs" :). I'm pretty resistant in general
to telling people they need to adopt the "right mindset", IMO
it's normal for people to have different points of view.

When explaining Git I heard a lot of "yes I know all that but I just
don't like to think about it that way" and it really helped me
to learn to respect when folks said that and try to see it from
their point of view.
