Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0B244E038
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162562; cv=none; b=FFZbzC4LPOh/l1/KbCuMcbiU7jsbC6gH5ZjB3orH/SEG7HNU2hjBMsjLdTPsNC7ehLuVTmigVrPEqW1XVllvT84AoHZzJC8J90BT5IEJNDRJesvHBhyu7XCkPjyJqURoFlAn1ch97Qi9B57jXtvlCVlgrzX2koU90rj2OQPFL/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162562; c=relaxed/simple;
	bh=ZRgDje1TsUOE3fuGAfOsj/wyO0my3EpwboIuOM9SBcg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=f2ZE5c+6WUFwJTI//eVMVdgxglJz4lMpyccszAmtUuw6s6YgHO40uCOOuXzi5vkoshvgNswBxajS3OZ6ttOeRz+WiHu+QjuWGMOIRGdvDiLXliMNfx4D9if1NBcEKSZNbWpDus3Y0w9qAGKHpxWPXIu2kxPrzLaZlKRJvGssIgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=FWV+mBx6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PE6TEUIO; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="FWV+mBx6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PE6TEUIO"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 438871D000FE
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 10:55:59 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Fri, 16 Oct 2026 10:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792162558;
	 x=1792248958; bh=uLMVflq4vMihA6MmkGMrzWp2RR38KeE6YJLD7hsjqqw=; b=
	FWV+mBx6NlYNZ5ux/N33jweIWiX9gFQoijIDTbgzCY5Gq1VA+wlnJmNP9fbIzvvY
	RFMqE0xAVQMLftY3b2MDaySIZyysH2+y9900QtfAAOBjfF5h5PfjdynfBUmSsmNj
	xPwOZ0hSfjLLWccKPBAyYPo8KCiFr9/cQ5LEl3fJIeQvhyOX2iWHl3z07ePyj91m
	OY1LWqeLXhMeZPCaegHFcNckNGrqKvrrtfnrlLu4hDoviBtmzft1niGAeQ83WKFW
	Qq3GFE3ISMD905vUgSztfECOB4sSzZ5qN3OvV0lW+mnhAPQwfW7oGA4hKrCL4x40
	RRg8trLxbTYZo/1VFGmbzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792162558; x=
	1792248958; bh=uLMVflq4vMihA6MmkGMrzWp2RR38KeE6YJLD7hsjqqw=; b=P
	E6TEUIOZRy+tO0TPA/IOJoRZenkFl+LeegwyPqlAhYbDZa42c2+UJ3qla8aRA4SX
	iYf77xjGyXLRFdl05Qdz2Wxq0kw5pC18neLWJB5r2dNlnsTwDe6Clz27vXcQDCsn
	Sv92/hqROANoGMHcr4GZjjzRNGDqh1qFfJHStBqFWG81mgsk0yaU4vVvHRxfs6Yg
	/Gmy+3CyZ7NJxSfjUXmSuwU9XjWdDmtjnV15ZdMqhFUFZVYADVmXNRD2/ylqZZNA
	jKuSb5v0Ohu8xDZEOgoplqJinHXz49RypA7sfKrkheOwjPy117f9pfwXYbuPa0Gl
	+QjHAPq3xvJQ3icrMijug==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792162558; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mwK990aWKqHr1Y5kMS4MEQrPA49Bzb3LMdbdRjRfsFNWyLK
	AYLcBq9/1PH/P1tP8VeJT6IUl51PQqYWQaWN46+W5aYZZ235GHaG603C0gxX4lrF
	9L7YgQx62VEz3sVGvO9fMmCdxIbMwBjV3mi8IQflBNfHiGyOiGr1krXRJN89Zm+W
	JT6Fvnxq5XpMLGwtw0W6H38TGYFaGV7QrwbRNoOPWDFcNFYE9T6ohEPsk7re5Q5x
	HpEuATeA+nfKm377usDMWpqIez5htYTKG/nxb05DD10z5f7VLoyJhmoUveNLr9AR
	/+PHF0tLkI3b3dyCEe2liZeX08zt93m+fT4qsnQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:9mp+M7IchXVQvTYKvIfs/L6tnX8pxlWUS9pXVOj6YzU=:ZRgDje1TsUOE3fuGAfOsj/wyO0my3EpwboIuOM9SBcg=;
X-ME-Sender: <xms:_jrSakJ949pu3HL-vwtGg65WMZSKY04OEM0_UOJ8WZx71f8aLcwQjw>
    <xme:_jrSau90zCVZSW16mxv5JquUjQ0bzEu41u2PeX2RGt2ZJ-3xK6xizCT46glqHcCTW
    UPOhtK8MNFThwkt-wfImKHbTK4paVtZHfH_1NG7abrRRzEzABRXAEv41Q>
X-ME-Proxy-Cause: dmFkZTF6CgZ/kL2Avf30wrevy5ekemWJwXkfSKIaZvZvtUIBWmeH0tbbFp5mfsSOAM/Tfy
    Vx0U1A9nf6mN6D7iUrCNWsdK2h2ydjc4KhbvjYYgxmrzuJqKZQRFx8RQG92Yp+UL7EWp4K
    +z3XFQd4J3xl6dcmQ9T3JZm6W89IiyqvwUyMqx0qc67wOW0dv7fb9JYbXwLyiByz9g5Py/
    LVywSyN985ky/VyffGdVDPEV/zhPeVDukAw0ooONBBYD8CfZib5JOsDgWPZVBT3DmEDUqz
    4Im7F8/GzGMAshdCVwfOzULwigjkLzJ0rWOIymHrEy4ulFtHJupbygeGGFsRRf0sSmB6MB
    EAu+AP/A/IfhUGEu2wPLrworjQJvieP8dA6k9AXRq4V+U7lA2ImXx+Z/Ong9weO8HWE6cX
    j30mO4Mjqi3xZSsGNmNEcd4mItwVAU8ll6+VB2FVYPRAoElB5Pu+D1e8bZ0RrSrfb5LliX
    I8W+9ZSe7GNECKCm9uiZE75cU3IuvJLjo9ONSc4iLf15u6BxtAGeZ3OKjKguAgiy9Qvmzg
    TZiAU9QSBP2iKkj8h9trR8piwiBNMdJLNp15zqqAyYxvVHKH87HqUtG3QTsLSOkUdn5YGZ
    xC0Ljx9LpQ+aSQ+sxOzTut1OSOdKJvcejNFc2XmRONYhMeCy9wM9r4MaAAAg
X-ME-Proxy: <xmx:_jrSaswbhtULD4d-h9OgZjkBx-71WSG-PlazMwkVnPztASo92OxO9w>
    <xmx:_jrSauErQ8jE4UQDue58JOPprpNBYRIh_bE28VPG4s-PAF4hyrJ3yg>
    <xmx:_jrSaowKs9zC2PTq-giqo84bLSAQ_vNOmCXa2BLfoUrSt7V6RIvkqA>
    <xmx:_jrSanuTW0MKUzZ9MCv2CJxlUBUIRaMfs7-8nszRQCLPgyPZu0H_YA>
    <xmx:_jrSai1ikJIWvFGhztm8UIzpSt5fzEB2XgJMBXfUE9c7MCeeanjhRsRC>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 625C9782738; Fri, 16 Oct 2026 10:55:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1sfaQj8oK1o
Date: Fri, 16 Oct 2026 10:55:38 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <01232f89-6f57-48d2-b6de-d51c91b6fdb3@app.fastmail.com>
In-Reply-To: <xmqqecdqk2qr.fsf@gitster.g>
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
 <pull.2250.v3.git.1792097882327.gitgitgadget@gmail.com>
 <xmqqecdqk2qr.fsf@gitster.g>
Subject: Re: [PATCH v3] doc: checkout: rewrite detached HEAD state explanation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Oct 15, 2026, at 6:39 PM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>     non-changes: Left these phrases alone because I don't think the proposed
>>     changes would make it more clear.
>
> Those who contributed their time to review this document did so
> believing they were suggesting improvements.  Simply dismissing
> their feedback as "style" in 'v2' without explaining what you
> disliked about their suggestions is unhelpful.  It is hard to know
> what to make of a dismissal that lacks any supporting reasoning,
> other than "I don't think".

My job to is write clear technical explanations and a big part of what I do
is to try to reconcile the point of view of experts (who understand how the
software works) and users (who know which parts are confusing).
I think we've talked about this "curse of knowledge" issue before.

I'm always happy to have a detailed discussion when it comes to accuracy,
and I'm extremely grateful for the time everyone puts in when it comes
to pointing out accuracy issues, and when figuring out when it's appropriate
to occasionally tell a "white lie" :)

The reason I was a little brief is that these in depth discussions about how
to explain a concept as clearly as possible to users are not effective if
there are no users involved in the process. It takes a lot of time without
making substantial improvements.

There are some more ideas on this site about having a "user-centric"
mindset, like using learner personas. Happy to talk about that if you think
it would be helpful. Sometimes tone can get lost here so let me know if it
would be helpful to have a video call!
https://www.writethedocs.org/blog/newsletter-june-2025/#help-contributors-think-like-users

>> diff --git a/Documentation/detached-head.adoc b/Documentation/detached-head.adoc
>> new file mode 100644
>> index 0000000000..d8e59e10c6
>> --- /dev/null
>> +++ b/Documentation/detached-head.adoc
>> @@ -0,0 +1,57 @@
>> +`HEAD` is where Git stores your current branch or commit. `HEAD` can either be:
>> +
>> +1. A branch, which is your current branch.
>> +2. A commit ID, when you don't have a current branch.
>> +   This is called "detached HEAD state".
>
> Differences between v1 and v3 did not make much improvement in this
> area, though.  The phrase "branch or commit" highlights the
> distinction, but it fails to clarify what is common to both, which
> is equally important.
>
> Perhaps restarting from something along this line
>
>     HEAD records the state from which your current changes started.
>     This can be a branch (the "current branch"), or it be a commit,
>     (in which case HEAD is "detached").
>
> and polishing further may take us to a better end state.  An
> important distinction that is not captured in the above (or your
> version) that we may want to cover is that when you are on a branch,
> your changes will grow that branch, and when you are not on a
> branch, your changes will not affect any branch and stay temporary.

This is a case where if we really want to make sure it's clear, we need
to go get feedback from users. There's likely a better way to explain it
but I don't think that this conversation will result in an improvement.
Really doing a good job of explaining HEAD is a pretty big project.

It's not clear to me if you think the current wording is unusable
or if you just think it could be better.

>> +It can sometimes be useful for `HEAD` to be a commit ID.
>> +For example, it lets you easily look at an old version of your code
>> +(with `git checkout COMMIT_ID` or `git switch --detach COMMIT_ID`).
>
> We should use a verb stronger than "look at" to emphasize the
> primary advantage of having the entire state visible in the working
> tree.  If a user merely wants to read or inspect a single historical
> file, they can do so easily without moving their HEAD by running
> 'git show COMMIT_ID:path/to/file'.  Checking out a commit allows
> something much more powerful.  It restores your entire working
> directory to that exact state.

Changed this to "check out an old version of your project".

>     In the detached HEAD state, you can safely build, run, and
>     experiment with any historical version of your codebase, without
>     having to worry about clobbering your branches, and you do not
>     have to clutter your repository with temporary branches.
>
> I said "safely build, run" because you had "old version of your
> CODE" in the paragraph, but if you can give examples outside the
> programming area, that would be even better.  E.g.,
>
> - Writers may able to rebuild and locally preview a complete
>   historical version of a book or documentation site to see how
>   cross-references and formatting rendered at that time.
>
> - Game Designers may open an entire historical scene in an editor
>   (like Unity or Blender) where assets, textures, and coordinates
>   must all exist in a precise, interconnected state to load
>   correctly.
>
> - Data Scientists may execute and reproduce a specific historical
>   data pipeline or model run using the exact combination of scripts
>   and datasets that existed on that day.

I like these examples, added a shorter version of a couple of
them. Also replaced "code" with "project" to make it more general.

>
>> +There are 3 main ways you can end up in detached HEAD state:
>> +
>> +1. `git checkout COMMIT_ID`, where `COMMIT_ID` is a commit ID
>> +2. `git checkout v1.3`, where v1.3 is a tag name
>> +3. `git checkout origin/main`, where `origin/main` is
>> +   a remote-tracking branch
>> +
>> +Checking out a tag puts you in detached HEAD state because `HEAD` can
>> +only be a branch or a commit, not a tag or any other reference.
>> +So `git checkout TAG` will set HEAD to the commit for that tag.
>
> A more standard phrase for "the commit for that tag" is "the tagged
> commit".

Will do.

> Because we will recommend "switch" to be a way to require to be more
> explicit when users mean to go into the detached HEAD state soon
> below, I think we would want to move the "checkout <COMMIT>" and
> "switch --detach <COMMIT>" description to here from the earlier
> "sometimes useful" paragraph, to complement the above list of ways
> to detach your HEAD.

Agreed there's some duplication here we can fix, will do.

>> +If you switch branches after making commits in detached HEAD state, Git
>> +will warn you that you might be about to "lose" those commits and print
>> +out the commit ID. You can also always find those commits later using
>> +linkgit:git-reflog[1].
>> +
>> +Here's what that warning looks like:
>> +
>> +-------------------------
>> +Warning: you are leaving 1 commit behind, not connected to
>> +any of your branches:
>> +
>> +  48c09f6 3
>> +-------------------------
>
> Your readers can guess that the 7 digit hex may probably be the
> commit object name you are about to lose, but you should use a bit
> more realistic descriptive title, not "3", to avoid confusion.  I
> know many users do not write a good log message, but even a single
> word "bugfix" is better than "3" ;-)

Oops, I meant to fix that before, thanks.
