Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6D441A51B
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784839468; cv=none; b=hzrt3IQGAoWkKidSjOmXFpBUnhx/vxf2a59GRZi5p2psjNrIceXEDv2NcsJjcxr9+PMQl+kj/CpfioShPvs7uECC86eWs8zb5bcW1wHfJSxiwtD1Yn8xUY3/dj578UbZqN0bOEpW8Qrh2gMrPZ4/M4b9gsEcEKNT2I77BHu2ofs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784839468; c=relaxed/simple;
	bh=w9waVFSzZRrRbFAUiKSRRlLF7n8HkRKymagQgSUByfc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lgr6JTRsLxB3hKQ+XuPgQm58ID21zUBrvpNCYrKZUL+iHzZ86AG483QoaHpF986qVpgFskOJivSftXqEVTiQMk6O14BdMgZALQg+y23c6IwukcEpjB9jXpm+Qid6Ck5JETcbLP5zr+9f3pfHtumgCd6LClhRbKg1LBWqMZ9ufco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GZrsYAOy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=piMY2wJ8; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GZrsYAOy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="piMY2wJ8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A74807A0207;
	Thu, 23 Jul 2026 16:44:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 23 Jul 2026 16:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784839462; x=1784925862; bh=JPpqWY2gda
	8izvS+c45dTFO//rD34hRSnpspUSWdEIw=; b=GZrsYAOybnbshI0zazqZRob7WB
	zFg2mKQ2ER5sAJC7A1Qcvm+2bK4y8RSRsWshQuAdH6ATKTmFN+asj6iFQIAEBjit
	qfqwbqDDfFgJhjn+tB8uJanHizQ8qC1q+bQCeBeJH7kDJMaTEK6PKoTSazfdTK+U
	iqg5wPJgj+vDlb6zkBwk+fMiw3uaNf6ysG3pd0PQRk200/wmAi20HbSGlNsXVqza
	6zsO5PmSlfOLoilRpHlVr7Vm5Y+dD/XBl2P4QEsW6dX7EypDVapB4CvpUDuWNPnM
	hFwQ7p6+H9A3ihWGyJ+as9d7gp1hPEbHQ6c3dpETMuobR80YkYYZLEJNYozg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784839462; x=1784925862; bh=JPpqWY2gda8izvS+c45dTFO//rD34hRSnps
	pUSWdEIw=; b=piMY2wJ8GY3SI1ZVZ0h9k2SLX4wnWrM4pfLCqOOFWhLaJ/y2KxJ
	gXwjtprWeT34gxitpU8gjYVAKZYgRnz95g8mPULbhM/bTtw3fkg5zGB0FBX1IRmz
	gisFqDoLYVMrFmDqCpK/XHEr5+OyrLqb2yOMDDQTwXvjEMujcIu+iJOSPv7Y9Z4v
	TP9opnnhggdhysQS9+M3tU6GgsTR0X/95CnvQCfUSspVCbqZCuovtQle9nHFecKQ
	pim8laQeElPhxqIGa/sx5NEME1yctjns/KWyIVoQDyudB1HXNNvj+VULfkro9yMV
	gXMVzNsLD7hUKsVV6fXjXdCAftt1VVMY0pQ==
X-ME-Sender: <xms:Jn1iakvB85-kYO-pjTmWqTfMkoXTKBTy-i6XM8jzGqgfBcVoZyNbEQ>
    <xme:Jn1iao6maAdHBcosIX4db_SbSlSnJ4ZTp9wae2I6lGLfC7w-CJu3w3tVwKRw84yRG
    8iKX3D0OkLL_yXGuWIT-1h4oAlKomWDWkXQ36AUy0WC5PfdoYptug>
X-ME-Received: <xmr:Jn1iatKGmBByju4ph6E63tTjUZZJIvXvF3xQcd2rkIuAthdoMLyBfTmzAQsEhyX5R36jgYsrOdsu5o93n4HzA_n4FOzam0b9ng>
X-ME-Proxy-Cause: dmFkZTFJXjhzn2jN8WIr8bS4DnYxfUZ162UsHyFn9aYrsgouINP0Ke+zO1CQ9sdWO/PZyX
    BlkyDzVlYcvj/B7dexNV3vaWHUk/KQr+rrZ2dhjnIhucOnKKitBsnOt2a9+O26epmcQSgV
    CW0DYR5u9e9DZXdOt47Y8m9fC+CohZt/CJzIAWK3ZWykg+TWrtZb67bYqw5a4GofpXMHEm
    2xYrPEsZ79pvGy43rL9P7Fe7bGiJzqy2w9Ju/mG9Fd37RgFhiG3nb/iiq+y+OULs3zu4CY
    Nhdw5ZyBqSIMaZQVXY7zawuomlyx+UuIGDd+OJwt+WcVZJ6FQQNcleBWZrhECWzL1DXmq1
    uB26Cl/bnVB0a93uooScEMyH9HsnWrxz1i/vXREILtuNSriZw2KlCilx5pLeTnkJHi1bcc
    k6Yw43R0+hse1oo6HADcL9mrV1yQDwCmfS3NnYv7/h3rxNs0jN/c4yzpb0n4nhsLTlWEuo
    3Bm6LAQFWloyg66mU5/ynNUdbFpNIR3/AazkVlCo7jptRHvE4RD6bWQeDI9ZZRaTMuSERu
    bLRiD3QtDJQZ2b1EsLybUVTi4dHKJ1VzfoMPOpoOq/PMl1S/5Q5OuoJieYXxWk5FrC0Qpf
    0NzpIQsDGgN2SbY3e+F8Xs1rEnNcHGIJ2pu1N3yO9hTZGTDKpviwclCdsPtw
X-ME-Proxy: <xmx:Jn1iag6XdGhfx6bYRKsHQ-05sk1sw0NeFuFyta4AMmaLTRVxOh5-xw>
    <xmx:Jn1iaoxgpAhG80jElnJJCCm044Er6MLB0sjPn7q9qMiicCts8-YQFA>
    <xmx:Jn1iasZkXND0B36JiYC_AGSvdr9YNfTYvngmQD3XCsD3H6kUa1v5xw>
    <xmx:Jn1iaiTWO8JHe8clOc8jWrlC9B5fim-MjVphIQjGLh5mWAnM5A9_fw>
    <xmx:Jn1iak7OJNk55er419JNl9VvEFBKiFrk14laTXonwJ-Jtl6D12Ue1cwJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 16:44:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v10] show-branch: convert per-branch flags to commit-slab
In-Reply-To: <20260721203025.85044-1-gatlavishweshwarreddy26@gmail.com> (Gatla
	Vishweshwar Reddy's message of "Wed, 22 Jul 2026 02:00:24 +0530")
References: <xmqqzezkw4zq.fsf@gitster.g>
	<20260721203025.85044-1-gatlavishweshwarreddy26@gmail.com>
Date: Thu, 23 Jul 2026 13:44:20 -0700
Message-ID: <xmqqo6fxe8rf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com> writes:

> show-branch uses commit->object.flags to store per-branch
> ...
> Signed-off-by: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
> ---
>
>> Hmph. I hate to say this, but I am finding it difficult to trust
>> your "carefully" at this point.
>>
>>     $ make
>>     $ ./git show-branch master next
>>     Floating point exception (core dumped).
>
> You are right to not trust it. I missed this completely. I ran the
> full test suite but did not run the binary manually before sending.
> That was the wrong approach. I have now run every mode manually
> before sending this version.
> ...
> All tests pass. No crashes in any mode.
>
> ---
> Changes in v10:
> - Restore init_commit_name_slab(&name_slab) before repo_config()
>   that was accidentally dropped in v7. Without it, name_slab.slab_size
>   is 0 causing division by zero on first commit lookup.

I will not read the contents of v10, but I think it is worth setting
some expectations first.  I am usually pretty patient, but even my
patience has its limits.

First and foremost, this development community is built on humans
collaborating with other humans.  An author posts a patch, a
reviewer responds with suggestions or critiques, and the author
replies to that e-mail.  In their own words, the author might:

 - build on the suggestion, rephrasing it and proposing further
   improvements;

 - disagree and offer a counter-proposal;

 - concede the patch's shortcomings and outline how they plan to fix
   them; or

 - defend their original design to give the reviewer a chance to
   reconsider.

Doing this in your own words helps reviewers see how close we are to
an agreement.  This kind of discussion often needs a few rounds of
back-and-forth.  It should also welcome folks watching from the
sidelines, which means letting the globe spin at least once so
developers in other timezones can chime in before we declare a rough
consensus.

Firing off a new iteration before there is a rough consensus on what
it should look like is a total waste of everyone's time.

Finally, the space below the three-dash line is absolutely not the
place to conduct a discussion.  Those debates belong in separate,
threaded e-mail replies.  Use the space to remind readers that this
work is based on a consensus achieved in an earlier thread [*].

Also, to be clear, I didn't bring up the core dump because I was
upset about a lack of testing [**].  We are all error-prone humans,
and mistakes (like dropping an unrelated line) happen to the best of
us.  Maybe a cat distracts you, and while your head is turned, you
accidentally hit dd (or C-k for the Emacs crowd) and delete a line
without realizing it.

No, the real issue was that this deletion should have leaped out at
anyone reading the patch, immediately prompting some questions:

    We are removing this initialization.  Why?  Have we changed the
    API to make BSS initialization sufficient?  Does the updated
    code no longer use this structure?  Do we initialize it
    somewhere else now?

And until those questions are answered, no one can honestly claim
to have 'reviewed the patch carefully.'

It is perfectly fine to have some fun letting AI assistants write
code for you.  However, please make sure you are prepared to explain
every single change in the patch when asked.  It is already a bit of
a philosophical stretch to call a patch 'yours' when an AI did the
heavy lifting, but it definitely is not yours if you cannot explain
it in your own words.  If you are not yet familiar with the
codebase, it is OK if you do not have all the answers right away.
Just hold off on sending the patch until you do.

A suggestion I can give users of AI assistants is to have your AI
assistant actually help you.  And by that, I do not mean tossing it
a lazy, one-line prompt like 'please explain every line in this
patch.'  Instead, read through its output yourself, line by line and
hunk by hunk, and ask yourself if you can explain why each change
exists.  If you can't, ask the AI.  If you don't understand its
answer, grill it further in your own words, using the actual
questions that pop into your head.

Here is a fun little exercise you might enjoy.  If you can resurrect
and continue the chat session with the AI agent that spawned the v9
patch, ask it why it decided to delete that init_commit_name_slab()
call, and what it thought the ramifications of doing so would be.

I actually spotted a few more issues in the previous round, but I
left them out of my review.  Why?  Because I expected you would just
feed my feedback straight to your AI assistant, tell it to 'compose
a response and update the patch,' and call it a day.  And as Patrick
pointed out earlier, none of us want to waste our brain cycles
playing telephone with a human middleman who is just copy-pasting
between an AI generator and the mailing list.

So, there.



[Footnotes]

 * This is a total tangent, but as I am ranting here, this is
   exactly why I hate seeing 'X requested this change' below the
   three-dash line.  Sure, the critique or suggestion might have
   originated with a reviewer, but by the time the author writes an
   updated iteration, it has become something both of them agree on.
   At that point, it is no longer a mere 'request' because the
   author is now just as much on board and backing the change as the
   reviewer.

** If anything, this episode exposed a massive gap in our test
   coverage, since the test suite completely missed a breakage in
   such a basic use of the command.  We may need to extend our test
   coverage before making further changes.
