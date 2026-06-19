Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E38379EF7
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781872688; cv=none; b=X9Em6VU3xv57RiLx26k4RIsbWhWeWZjxwWQ1vKLpyYe54+i46zXFnYyCs5evhkCPB8qA015bRYWxK3o/7h3WUF7SBebFB7Z8VRhNbZIVbMdOpAARz4kgq+NIHySzOSYhz3qh/AjijgA9jm+M/dNfmbc8U5c7At4h30XQ42FR7mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781872688; c=relaxed/simple;
	bh=oehlEOqKff29YAfHR2t4QQmPPaZ/o+qloTifJ6BluNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdvM/3Ds0NwZ8rh9RpTDG3it7zkgsF8uo6ZSyAlxhdwRgqLUVwdW4fb7b/FaXiicyCFvablaBBunbvkQSas1It/Y95vOnJcC9TtcawMQvdGJIxwWSk2t6tuwL5tHFwsCbw1IB/tL1ZIH9K6V8ncVBgMGmWvVcCu5hu0R/wRr9N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=koCaaIK3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PoMGFI9q; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="koCaaIK3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PoMGFI9q"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 2FCB91D00123;
	Fri, 19 Jun 2026 08:38:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 19 Jun 2026 08:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781872684; x=1781959084; bh=RGPgsqHWsL
	O3vtpihWBad77sEtc5F4gy9lolVPD429M=; b=koCaaIK3xleQzsUYbjowbV+Xl9
	Te1Ct1FnNITZHuxlxsmOatzXVkvhwAzWU3dpKKO/Mo5uI0Wi+EyKqceI0hhDWS8n
	NZfHMywP9qrxT9bqqCRtzyBs7ynS4eeBPCpBtjUOA26VeR1h6itbslgpQLYDrx7G
	ZuDl0xLHFDKSE+zvX99W0SYYeK8QucbuC3PQSynRN2dNIslGq2jWmQ71kk3phgTX
	B6rZJZjMDqf8NlJGc2m+ZSMhyHLuHFarbYSOvY9XNdVAuHprut/Zfx/+9OVxa2wH
	4Gn2FByMcz1Qjg4yVqC1tC+xl8I6soN0DFbpIbSSXMzUxXzMKFGhlvkIuZAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781872684; x=1781959084; bh=RGPgsqHWsLO3vtpihWBad77sEtc5F4gy9lo
	lVPD429M=; b=PoMGFI9quO0AT8tpLzzsECDA1Vq/2ISOzLL5ogAidkoRgtJtqyV
	eLeUGyseza55t1jch2NVbeoCIxRqRZd4jXFjobu3Bzfoza+ItEUYLEY0jHOymV4s
	aHSSJgefMLxnM48s2n9rPIOAPZqDoYnjH8yBor6ypxYVfFVoo5yJZaqRwSQsIL2O
	4FSJl+Bxamnp48sTFVnJoqBwPYDOPCUDQXWsrCSKgRtnERNtUJC63c5Ca0TYPMaH
	WMFvii7qXqB83Bim0L6pWPvp5AS5E3cmmHPTKROQ8snuJN8/RtOYRamAACHizEy4
	U+PiOCC3oBMtA5uBl4z9FF/8LP9+sXFz/7g==
X-ME-Sender: <xms:LDg1aipdE-p8rOkKgJzo3Smg121LF8ec8XFnqt_-9Yn-eIacey9m_w>
    <xme:LDg1anon2cHf_0AZFNmTWEwNA0MdO11WJmnuwextgQAfvevHFxaHRbAXAd8p-Ognw
    a7C3b_No7ewNKA9Kq8V3veagRXymfRObNRVnCDg9cMHxABLg5t_9FY>
X-ME-Received: <xmr:LDg1asN4T0HtQkSru2zCYYDmlNnsDyWxTubFoZNZMBGnvAWiUVoZFrckVMMn47_eFqMQ9c2lZB4UUKefANtWky8NUv0pomOcTR9OTNorzNs>
X-ME-Proxy-Cause: dmFkZTFca0C1w1tjCzbKfW8ORALqfdnECvd7gVuXsFZlGxvzt8wfneYQeOhalVzOY1lyQA
    9WstAmWBqYuwHGLUuXben6I1DWEAuWICKrt8H3CY4ue+L0qeGquWav4vMUpNj7UsUT30yB
    DXrDoLLYc+RgPDVJIACRAQwotDCit3Rv5sZuvJV7kSHhumquSb9kmPx/BMNKLZfhMN0oxS
    96dMUnqXCpxhcNGZ/npWflxNoadaLtE5QBdQ+fev9+FwJzZan8vE6a5kIhxOYgsutBUwgC
    J5cANvPqYRY0WL0HiwnI2pKn/noHFf9AMPhwX5sEjNFbV+/D8UA7nwA692jMIR20oIbdBJ
    z7HQxgjFzhHoY4V4m40c+dQSPH6GPrwjtM7ksaVTrztcz28MO3LNL52YNfh1VCwf96Aj/P
    RM0HUael5YxB1DN571/4euU1lXtByykRGb2avfM0txGLf4xu3NoQbBP/7H5B3QohKLmSA9
    n06EUcI9fvboYmlhSqkwEz+xVeBtRaUuZpiRlpDWnv2jmLfvrHsWNklkX1GWsKT21ZwJZi
    1/9exyVBnPiXLr9fpasPhzMLAsKQHB1+arT4g6suB0KsZb9cj/keB5q2AYe48NPyOKcNCt
    mASshJBUy5c+UiWu7ep2AH5AmvsGsYt3GO7VxEyabI1K/y5zJKfxLR9mW0qQ
X-ME-Proxy: <xmx:LDg1agyrOXyukFnEeJMMaJMV1e061mkkSj7Grz5w-CVD6mc5jZ4HUg>
    <xmx:LDg1atvRi3ipMj610PWOV4i6tEtAsiEqoIkEtenDvNBrB2vl0vj_Sw>
    <xmx:LDg1ah5qjaDXmr-TYVl7XLcGZ5sJ0dEz03yWmNbs1DtoMbZA9auVOA>
    <xmx:LDg1akQ2IMkP41P4ofKWLIYwP98VCGDOUNoqI12Rc4F370IzaYFO4w>
    <xmx:LDg1arsQFfTK29tfQzHKq1G9A6eLToM09yhRklYlS6Cj8e0zk3txuw9p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 08:38:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4f85fd10 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jun 2026 12:38:00 +0000 (UTC)
Date: Fri, 19 Jun 2026 14:37:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3 0/4] history: add squash subcommand to fold a range
Message-ID: <ajU4JYYUTz5r-Xgc@pks.im>
References: <pull.2337.v2.git.git.1781512625.gitgitgadget@gmail.com>
 <pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com>
 <xmqqo6h7nza3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6h7nza3.fsf@gitster.g>

On Thu, Jun 18, 2026 at 05:34:44PM -0700, Junio C Hamano wrote:
> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > Adds git history squash <revision-range> to fold a range of commits into its
> > oldest one, reusing that commit's message and replaying any descendants on
> > top.
> 
> One thing that just occurred to me.
> 
> When you have a linear history
> 
>     o---A---B---C
> 
> you run "git history squash A..C" and come to
> 
>     o---X
> 
> where the tree of X is the same as C, with the log message of A
> reused for it.  That is simple, clean, and easy to explain.
> 
> But what should happen to refs (i.e., branch head) that point at A
> or B?

It's a very good question. I had `git history squash` in my backlog for
a while, and this very question made me defer that topic repeatedly.

> I am adressing this message to Patrick as this question relates to
> the grand vision for the "git history" command.  I think "git
> replay" wants to rewrite all the refs that are involved in the
> rewrite operation, while "git rebase" (without "--update-refs")
> wants to leave all others refs intact and update only the branch it
> was told to rewrite.  Is it the same design as "rebase" and
> "--update-refs" controls if we update _other_ refs that happened to
> be in the range that are rewritten?

Yeah.

> Now, assuming that there do exist a mode where the command can
> update these refs that point into the history that got rewritten,
> there probably are at least two possibilities.
> 
> On one hand, I think it is reasonable to _remove_ these refs that
> used to point at a section of history that disappeared (like the one
> that were pointing at A or B).  Perhaps A and B were pointed at by
> two branches or tags that were used to mark "up to this point things
> are broken" and "from here on things are fixed" (i.e., imagine a
> manual bisection).  After squashing all of the commits in this
> section of history, the result no longer has such transition points.

I think just pruning references would be extremely surprising to our
users.

> It also is plausible that users may want these refs that used to
> point at A or B to point at X, just like the ref that used to point
> at C would now point at X, even though I cannot offhand think of a
> good story (like "there used to be transtion points, now there
> isn't" I said above to explain why these refs should disappear) to
> support such a behaviour.
>
> Thoughts?

There are two more modes:

  - If a reference points at an intermediate commit then it stays there.

  - We detect this case and reject the update. Optionally, we may ask
    the user what they intend to do with those other refs.

It really is kind of ambiguous what is supposed to happen, and I can
think of different scenarios where each of the possibilities would be
the best choice. So ultimately, I think the last option is the best one,
as it also gives us a way to iterate.

If so, a user would already be able to achieve that other refs keep
pointing at X by saying `git history squash --update-refs=head`. The
other modes can then be added at a later point in time as the need
arises.

Patrick
