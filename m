Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0FC392C2A
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145614; cv=none; b=Y2C9q/ZiiaCDPBzqm602uCLh5ZsXoZLN+JKHO8qiurxAc/GV2GRZG4QuEz075pdVliMamHT9iLcovhG0XGWELpb50g9RlWxy1CyuBD8AQoFFWFf6OxseSBrU4AFa1n00XmxZM7BTLQvQyx7SwWt2RlssKDk1+abm0wrjm3JetRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145614; c=relaxed/simple;
	bh=dfIaOJBHIalvR/uKbjjFDt889tkmg8QTd9TCy+MX49Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvdcV3hLGEF4fTwzgk5W43mkKigf4VKeEpJP1Dq4xzfG43dBaBSlyXVD9eVY/SMPlLFACs+Ls6n65PzH/dMPYVO7a73q3TOQkEIlLmFdFESnrbcZVUjK3lQ/0LpNgeWUUV1RsScCp8yoi8PMCBZAxdam6CcWITdkDa3qxMTqoEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c2ZszaEQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iOrhyXHi; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c2ZszaEQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iOrhyXHi"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE90414001B2;
	Wed, 19 Aug 2026 09:20:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 19 Aug 2026 09:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787145610; x=1787232010; bh=bGS7kr5zyN
	AiMboY4C/T3154YwKvsB+p/CXyy3cFoxM=; b=c2ZszaEQDVt/B1uwWPPqJE+ELi
	+NL6XACh9m+GenVpvab62yNSfQKtq1BXtuvOrOTZHI6LYeBVJdsZgs7EQNIcagQx
	X7Fv1w0zKp49REIr7hyosBmOtg4Mago4lxFFMNxgWzgJTnslJ5STQg44dt6dUTWv
	ql90xeQebPXjCsg9/j6rilu++xmMXcaGw2L9V03SV15mh2rBEsOeBNGjGO4jfTai
	mHVwZb/7ObLcv4kxaDdDkIOREPW4IOYgPuzHJTXsKCea8QRbU3XHzSATN9lRdhxk
	9XMxQ9z4lnkqTXwYeTA7jEP8WcpD+I11kpc2eiYZ5vGxIS0B+/uWGWJsvj8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787145610; x=1787232010; bh=bGS7kr5zyNAiMboY4C/T3154YwKvsB+p/CX
	yy3cFoxM=; b=iOrhyXHiFojKpQVMH28KcZ/6bpQJhUPixftP1bCpyHJXSqQVTGb
	RSz6HU/Kcd1Lsh5cWp8GHx4sG69Ctpmodm9oAgi9I3wMeqI/JloINgwlfvuoyHxL
	F6iCrNKrYE7pjYR4mTAFMyQrxQtErJQZgHzd7MEDfLtP8cN5KyYQXRWhcGmD3obT
	KC95lW7mqMMAshz7ZOKhukAaP1Em3UW9dq70C2LlhpEyEp2aMjEx+J1zuyebgQXG
	Pc/ImHgrqOwFwruCCsRb2C6eUTCNB6aj8NfF7YV2c7ETKjSVd7r9aMv5LAxtp7GG
	MYSrhFB3inHqILI4ENUKijoB9Lu84HP7ANQ==
X-ME-Sender: <xms:iq2FarSSl7E3TQjUbUMuDgsSu4Kb4CkNazU9bPsJ9-mUQiwG9GvS2A>
    <xme:iq2FaizO2vnhmlCHsBMNDfC3mcNbIi3BKQ2YAQkGmQjmkiej17wftIMoW720mBT4y
    7X8NpFh01YkcnyqWk1k2LRnonviNcsk3qC8g5SsjL_35a8-XK5O>
X-ME-Received: <xmr:iq2FaudGPmShhIm15vZaiN0z3qcD3ZqCkI88okkY1Tfx4VuXraA_pk2rGOlB2gC3r1IjNn4sGiJmqU3Nl0Xp_sshfhqTWGgcCf60PFmk>
X-ME-Proxy-Cause: dmFkZTGsXJgO1WmT3AOqjQ0u2eiQNsFMhHzkShtHrRgaAs6hK1gnFOB+lq8MoIOgpR9UEW
    YuKkHFUadGSwtNFemRg4fOqJdmZgSp2RplenteB/OQqn6PBS+bu5EHcoSxcgnDd/xUAZJv
    agN/bogqRi/9jMChukgTlcABFSN9SwsLfXad0nfLEmFdFPeMBfx1S1yNbXT1ILIz9qUhHo
    Iq+oqtOVRBcBpP/vMgnd7tA3USe3BkfP8xGtOXVEk+wJXTndwDlxWusfPsvw3NhMGPhX0C
    E/Kl5tUuODHYWbRdIrkk3OPJ5ElInQQhNR4SGoR8huEIobA7bZZs303jAr/vMnTrMLZ0qf
    AgIFBPxrpoaeWbkzIycyWYp504XXH6bJZxEooU+KFPYJZDowLnX2jnh4IAgMtOucbtEeRa
    j+lAz8jUJRgRSnwzMJL3i5C6YiJmKy3jq3qmxmAWrjx0Cj8weAPBz8jIBgKXZO+W0XdKpp
    ylOOT9zCnvgL7dMjabh8OwaDDQljM8x/bYNw37MrAW8JaafYJYf5JF1czAVIaR/5msrDrr
    HcCe0uGIY8sOzj96QED5L/tzoaHMojGbOuQGmcegZ2wUUE3DH0wWSeldjSRGyomIlQzKxj
    iHfqwQ1KQ7TFjWoqaT2HVF6CcFD/TbKCwUeaGqUdPLxqBVlWhQ19d/gWBlQA
X-ME-Proxy: <xmx:iq2FamIDBnl704cH4SfRmAm7dQMFNGjGBErS9WXBXXCn8Q_q7Wf0Iw>
    <xmx:iq2FanH6t_KWwKbTgenNYjt4oZ7PJeoOLuCeOXJ8Vagr6GGiXrOuJg>
    <xmx:iq2FaooTGx-2WzMDS46lXrC5gVrFkNM8lLtvoR0pfIO7r9B6l9_6Tg>
    <xmx:iq2FaoQA4hwfJKoT1vByJZQA4kfYujdTEhVWi5oYyU532F_A3Oi7Hg>
    <xmx:iq2FavCYNeANcXVMLj_kxcGDbPKyqLeD7xNOK4gPTpTcdZEr5Svi8qB4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 09:20:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d8ade555 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Aug 2026 13:20:07 +0000 (UTC)
Date: Wed, 19 Aug 2026 15:20:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] hook: introduce the report hook for git-receive-pack(1)
Message-ID: <aoWtgz8wWsb3v6du@pks.im>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
 <aoVdlC7myRFenPfV@pks.im>
 <CAOLa=ZTtOJLXkfZ8jKpuA9REg5CP_xxD8+kDxPAYLeRz_xR1Wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTtOJLXkfZ8jKpuA9REg5CP_xxD8+kDxPAYLeRz_xR1Wg@mail.gmail.com>

On Wed, Aug 19, 2026 at 03:13:50PM +0200, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Tue, Aug 18, 2026 at 09:55:55AM +0200, Karthik Nayak wrote:
> >> When running 'git-receive-pack(1)', there is currently no way for the
> >> server to intercept and modify the status report before it is sent back
> >> to the client. This is useful for servers with custom logic that need
> >> to transform or gate the report based on the outcome of external logic
> >> post reference updates.
> >>
> >> Introduce a new 'report' hook which receives the pkt-line encoded
> >> status report on stdin and whose stdout replaces the report sent to the
> >> client. A non-zero exit status causes `receive-pack` to die and the
> >> client to treat the push as failed.
> >
> > I think it would have been useful to add context why none of the
> > preexisting hooks work for us:
> >
> >   - The pre-receive hook runs too early, as we haven't updated
> >     references at that point yet and we need to have the full view of
> >     all resulting updates (both objects and references).
> >
> >   - The update hook is too inefficient as it runs once per reference,
> >     and we cannot trivially determine the last update.
> >
> >   - The reference-transaction hook cannot be used by us because we care
> >     about the phase where it was committed already. And while the hook
> >     fires in that phase, it does not allow the caller to modify the
> >     result in any capacity.
> >
> >   - The post-receive and post-update hooks cannot be used as they run
> >     too late, at the point where we have already reported success to the
> >     client.
> >
> 
> Yeah, this is worthwhile mentioning, I already have made the commit
> message a lot more descriptive, so it does become bloated. I think it is
> justified though, since more information is always more useful than less.

Well. Until it isn't anymore :) Just look at the walls of text that AI
is prone to generate, where one is essentially drowning in information.
And it's the worst kind of information, too: plausibly looking but
inherently dubious.

Anyway, I digress. I think in this context it's good to have the context
indeed, and I trust your information more than the one generated by AI.

> >> diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
> >> index ed045940d1..7e6643ad89 100644
> >> --- a/Documentation/githooks.adoc
> >> +++ b/Documentation/githooks.adoc
> >> @@ -527,6 +527,29 @@ The exit status of the hook is ignored for any state except for the
> >> To reject individual ref updates, rewrite the corresponding
> >> +`ok` lines to `ng` lines in the output report (with an explanatory
> >> +error string) and exit zero; standard error can accompany this to
> >> +provide a human-readable explanation. A non-zero exit status causes
> >> +`receive-pack` to die.
> >
> > We should probably document that we expect the hook to never return
> > non-zero, even if it rejects reference updates, and that doing so
> > indicates a bug. This is mostly because git-receive-pack(1) shouldn't
> > ever just die on the client without giving it a proper status.
> >
> 
> Yeah, this is a part I was thinking about but wasn't sure if it should
> be added in because, we could also do an implementation where we simply
> ignore the exit code of the hook.

There could be cases where just making the whole operation explode is
the only remaining option. So I don't think it's necessarily bad to have
it as the nuclear option.

Patrick
