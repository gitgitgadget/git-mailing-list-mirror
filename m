Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88A94078E0
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900359; cv=none; b=WkxxcTs04CNB2dwm2L0t4u7Olk6zPF1aDeDE5CzYE4FTMsM+zqEl0r7c83QiZNMVoaegXdqXsxmyD9v24M+exf+juVxFj0LQMG9b1SvjmtgRdvM1m8Cga3geiKX2MFvotyZs6GxhsGYEGyqghPCN7G17W8r3z0Arvdfi25SebgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900359; c=relaxed/simple;
	bh=Bi8y1mPjuQP9i+0TlmM0IrNwXV6PTOEnwYyvP6ABpJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxsG0yJTuc8kqvVqFD9PaeEkc5KarNvJJaxxyJMKhRDtXJHPRD394NwgbaIzXhWWw3Rt2b6ruCDIvEINU0K9y+HiGKhlqw6qm2H4Fiy9A+q8qBNfdaMJO8LozOyVNJolVlnTi1eRBpHV9PyCSyS5Za3INR16ByIO+Pu1AAjTDgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B0l4gGog; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LiqhwVWQ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B0l4gGog";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LiqhwVWQ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DEF1D7A01CD
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 10:05:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 13 Oct 2026 10:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791900356; x=1791986756; bh=2UJs0kihDQ
	sHGcAommWE2bVn0nEh6V1qZvpgHBLnons=; b=B0l4gGog/z3WzsnR65qcDHDn5o
	G7PideeQ/IdWlHL9VtMbnO6P0fOZYT/KKhRAwAUJNSEJkC8ZHHrtzXuC7Dsj7ulO
	bcdsysSCCYOpXEhaLEHvbNlrBVAR3pSizV6zdgIVBt5g37jxLgpZpX0VOpCwEbH5
	NL1obnR5SncxnxUkMtagVyGik2kLjOXTtyXY445HMaEIzO5G5uLQKmdZmXV3MoS2
	brXRiqagoXmx2tDg8R1g26WbU8ls4vuS9Eoq9O5yVAUAwRmGRQ9ynbWeeAFBbKaI
	CAjntaljjct6uGs9Q5oVsDXb+g6swCyJ+LzBoHFUWerzUI/R3X5/xnznfwgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791900356; x=1791986756; bh=2UJs0kihDQsHGcAommWE2bVn0nEh6V1qZvp
	gHBLnons=; b=LiqhwVWQjWcQSSBZwBXD+mPGbpwgy4DikbMSxsAqJHHVXO97P1x
	PXsAyNYpGInAi1d7ex+4QP66NU45iw7HAMJ1jTCdvXvxYv1isTPjIkEUegfmFEAj
	CH1xHs+koYKYDmbaWnq7C/5VDGkv10AVhrlLNAkD9YhDscrbioqmqOV0tWlA9DQC
	Mhwj/YZRcoyjRnnktCcvB6xNpMxZUzyaq6AwWUgAXO4MubSFZsTQ8+E3xU/LA9qY
	NSD7mlkNgBzhZ/qcrYw7fTGeJHR5F86VkpOwGMKvM3Td/Y5P5tSF6cIx/E3tHlGJ
	GgTOyiBgrJMg9b32H0HzD4AOyNyK7d7jc4A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791900356; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:N/uqnMW6abP9D7vLWXtXSeHmKrc2t7+NTfOHEu5Z3hGtMbc
	Ss3OWMJ3qClYMRxtAjIWaXzNkoSZvBSb8c50xUG+R/zWDFGRs5lQ8By9bLfL9l6v
	4liYcdv4Y5WJ4IQLQIk6IWaruT+iQC0DXdU7YmcKrviM8m5aO0sQd5n7zIK4W6ev
	1ZrHsTp9Im7e0mhai82BgjGqAEhNDiQfOZ8Txy/G0b4G6QvKCSmXlyXY+7rMh9wI
	wLc5t8CGkbzl0vdRCdcGCQWSoMKZR5PnuD5o9vJzZ3avot+WwcEwQM/0096IQjM5
	sl25uxrdEfqnPjH1tnGZ4BfbFP44y36OtCzqm2Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:d8TMlncD77PzS7lYDnpI0WP3yVylXmrZaYGMU6SvN3o=:Bi8y1mPjuQP9i+0TlmM0IrNwXV6PTOEnwYyvP6ABpJc=;
X-ME-Sender: <xms:xDrOaijNonSPcJQxILBR-bbyQae4XifP5bQpoT9DnAvma-FeMpZmzA>
    <xme:xDrOaqdBVXB4eBMQyh-gwanbmNrIJeRhWSuc9Twn86X9stBjkeoi_rhIXRwkIM7bb
    YRZt25BBDt3uRtM6BXiNrBRpgNRx5LkeLPRJLHJR_5RN18fUgIG9g>
X-ME-Received: <xmr:xDrOancGu_ljA9oMX7T1MCwLRBXemG4XF2ndMQy1_IVnT5dr7fI4EA>
X-ME-Proxy-Cause: dmFkZTGsvcl5LmgzcyejJ46V12Dgw0LGFIxt6Vlq0PKUP2lyyPN/LY43U720EKljhIFSpZ
    e6Xv5pRmAPIZkL2m/wakJq5kbREkOg5vcQHZpBv4HwrMPGexkObsb0xt/T4xWAfcRmfJNX
    tSM6zlJyfPHKJoGTnzSYzZSi0PWVt1sjqk/g8+so0RvpKHdB7xlmh8cqs1gIqY2y884+fu
    fA72n8u70GKX02CMHaAT22w4Fjsc7hJJ8x0YiS4U/zFQIAGXdqqrA0/glFnL6ZyHHvbfHc
    BnamKiRwsEiVUN2AY8XbRyRGFd9NHPBqKu89AR5L5wEIzbgmREpYooGeREZ5ujnc40OuTN
    xmZfERhwdkz1+EGlMXF3V7cDSwtYeXN2XWoUhxMIIR+w9rA/ixdEw/y5su3hxu+TKTJK+I
    f17LYp6SBMD7Pe6nPo34qZpQ9O91evyRLjiannQHSPYayR/PFERQ3ZFsHEDjAvKCfGEquf
    l0j6hWZGKywP0/Tq414gMeuAEBfzp3z9bChwyDEUNQCW/pTHbN3HeT0jjcD9dk7FgwQBCt
    JARIGszR3IPraNkrZpeZCov+S5jEiokJiGvlHdHPGPqU0PX51U4sj0KwT9MSI3FjcSPoeP
    ZD2kaUW68yo1P2DsRZKUt4aedZkNeeYfhaOMMdba/gNB5Ky+Bh0J828TnBlA
X-ME-Proxy: <xmx:xDrOak8u72xk65I4TDCIfVCRO56xGHjVcUPzkrydPv9aBuH7w_bwxg>
    <xmx:xDrOajktp-LMRfO_1QZ9zxWJ3LlFEd-i0iMxgwQKOQb4_-6z0YBz7A>
    <xmx:xDrOam_47NxSZOc1Qc9pG6p4PTesdH2mkW_KRw5Y6ve5RCxN3qY0Ww>
    <xmx:xDrOahmLQK4iLdwmhFUvsBXXiWbq3UqCBto1wDTxddynSXmdOKWMnA>
    <xmx:xDrOaqfi_9CIOWq2CtnAidPaXU-CNa-dg6m5KjpKpNLG5FJEwbwfeM3p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 10:05:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d93cc287 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Oct 2026 14:05:54 +0000 (UTC)
Date: Tue, 13 Oct 2026 16:05:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com
Subject: Re: [PATCH v4 1/1] repo: add filtering options to "repo structure"
Message-ID: <as46v5NEne3SKajZ@pks.im>
References: <20260924164503.119506-2-markchucarroll@fastmail.com>
 <20261010150539.930614-2-markchucarroll@fastmail.com>
 <20261010150539.930614-4-markchucarroll@fastmail.com>
 <as4a7t-NEQi-4Yqp@pks.im>
 <DM3RGXVFVT35.1EPI4MJB0RDBB@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3RGXVFVT35.1EPI4MJB0RDBB@fastmail.com>

On Tue, Oct 13, 2026 at 09:56:53AM -0400, Mark C. Chu-Carroll wrote:
> On Tue Oct 13, 2026 at 7:50 AM EDT, Patrick Steinhardt wrote:
> > On Sat, Oct 10, 2026 at 11:05:41AM -0400, Mark C. Chu-Carroll wrote:
> > [snip]
> >> This implementation makes an awkward trade-off involving
> >> "setup_revisions". In order to accept standard the standard
> >> revs parameters, it uses `setup_revisions`, which does a ref
> >> walk and populates the pending objects list that will be used
> >> by "repo structure". But this ref walk doesn't count refs in the
> >> way that "repo structure" requires, and because "setup_revisions"
> >> doesn't support a custom callback for its ref-walk, that's not
> >> changeable.
> >
> > It's a tradeoff indeed, but I think it's a sensible one. I see these as
> > counting two different things, refs and objects, and the revisions only
> > filter objects.
> 
> I guess my wording wasn't clear. The tradeoff here isn't that
> the revision filters don't affect refs - it's that when we use
> setup_revisions, we end up doing the ref-walk twice. 

Ah, right, that makes sense. I really don't think that's much of an
issue though. We of course shouldn't be unreasonably wasteful, but it's
not like `git repo structure` would be on any critical path. Also, in
most repositories I would claim that the time it takes to enumerate all
objects is going to significantly outweight the time it takes to
enumerate all refs anyway.

> >> diff --git a/builtin/repo.c b/builtin/repo.c
> >> index 84e012f83f..081940a85c 100644
> >> --- a/builtin/repo.c
> >> +++ b/builtin/repo.c
> >> @@ -766,10 +767,12 @@ static int count_references(const struct reference *ref, void *cb_data)
> >>  	}
> >>  
> >>  	/*
> >> -	 * While iterating through references for counting, also add OIDs in
> >> +	 * While iterating through references for counting, if we didn't already
> >> +	 * populate the pending list in setup_revisions, also add OIDs in
> >>  	 * preparation for the path walk.
> >>  	 */
> >> -	add_pending_oid(data->revs, NULL, ref->oid, 0);
> >> +	if (data->add_to_pending)
> >> +		add_pending_oid(data->revs, NULL, ref->oid, 0);
> >>  
> >>  	ref_count = get_total_reference_count(stats);
> >>  	display_progress(data->progress, ref_count);
> >
> > Right. An alternative would be to simply never call `add_pending_oid()`
> > here and always let the revision walk handle this by defaulting to
> > "--all". That'd have the downside of walking references twice, but the
> > upside of making each of the steps completely self-contained.
> >
> > I think ultimately it doesn't matter too much which of these two
> > approaches we pick. I'd have picked defaulting to "--all" myself, but I
> > won't insist on it.
> 
> I went back and forth on this a fair bit. Both approaches work,
> and both have their downsides. In the end, I felt like munging argv
> to add the "--all" was uglier than this. (Plus, when you do the default
> "--all", the command will always fail on an empty repos, because the
> "all" logic tries to call "refs_head_ref", but there are no head refs in
> a newly initialized empty repo.) 

Yeah, that part is a bit ugly indeed.

> >> diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> >> index 02cc2b594a..e35b46a277 100755
> >> --- a/t/t1901-repo-structure.sh
> >> +++ b/t/t1901-repo-structure.sh
> >> @@ -21,58 +21,6 @@ object_type_disk_usage() {
> >>  	fi
> >>  }
> >>  
> >> -test_expect_success 'empty repository' '
> >> ...
> >> -	)
> >> -'
> >
> > Huh, why did you drop this test?
> 
> When I was floundering about whether to use "--all" default, I found that the
> command will fail on an empty repos. Even without the "--all" default, it seems
> strange that some version of "git repo structure" will succeed, and others will
> fail with a confusing error ("'HEAD': unknown revision or path not in the
> working tree."). It seemed to me that when you consider that running this
> command in an empty repo is pointless, I thought it made sense to drop that.
> I'm happy to either add a line to the documentation, or to reinstate the test.

I think we should ideally know to handle this case alright. It's
probably fine to abort in the case where the user explicitly asks for
refs that we cannot parse, including in the case of "--all".

But I really think we should succeed in an empty repository, because
that's a state that is quite common. So I'd definitely retain that test
and make sure that at least `git repo structure` without any args works
alright.

Patrick
