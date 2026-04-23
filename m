Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4463D4117
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 06:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776927308; cv=none; b=efyuT/fiJtSuYvreDCNW5WS0zbNR2IzPfxUuD6Q6u6NuL97CG6ezBLsRzFluVtoEYDFtuD6r/J/Dnp0bTIQHxVYkB7GXj1rWBOEMRRDGcPjVSRGy75EG6m0p+qQAuvmt5EOZkArjeAcgCTzccPR42b0la8UAEsjJIx9GzTQ4SMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776927308; c=relaxed/simple;
	bh=GC0zesULAbZWogXdkIypRFSeQIUigMe2e6p2YMjVeLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzLK/rcihq5Cl8IbwpsvWg1WmVTM7nNt/cD5zrq+B8SEhJIUBqTzW5R4cEsnxH102G7XOSqD1KxBRJ6gGwiGHEt/RSy0mekwxuTXoYT/ZGi51DWjhf/hgZuSEb6Kn64SbKUfybN6rP/Mp7TUaOPkwUGR+7SdRUL65LJBA6ir4Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n5YzemdB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LmZKEWgy; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n5YzemdB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LmZKEWgy"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 80CC11400109;
	Thu, 23 Apr 2026 02:55:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 23 Apr 2026 02:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776927305;
	 x=1777013705; bh=s6eAEbXthOoX9VJ6T+QXWFPfUZLRgja4LHXKRfRjwg4=; b=
	n5YzemdB2U2eK9ZnCF2hFf4vhGz3n9ZRw9TLl4+FSf78TOLdOantV9cwculaG4Sr
	5ZPugBpcGwLqBsBtR+jdnkShbjvzZW55sNz0R3ctF2I4Muyp016BNLisyAyoMeT6
	JdwvG2z9lTKJMW4C1a3IPF88cF93uGWhogTTnv1gpaq/Qx7tqrc0BG8ykA5cMhX9
	UP8L5IP4AgqhUp9ewaaEFxwvIc1EoftbyLXileq0Q5COdrBAesHC9O4ANoxaeVFT
	6wu7d5A2qfZdK6UBuMersgxcce5Ll9vRjWc/fPNwxFiULXTWlr2HEL8D+AasSsgI
	v/cH6hUatLrUNIcvqYw56g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776927305; x=
	1777013705; bh=s6eAEbXthOoX9VJ6T+QXWFPfUZLRgja4LHXKRfRjwg4=; b=L
	mZKEWgysGkbd9iyA9SEAvjUBsAXvIucUhJrfrkG8G+kJgdF0exnUlQz4Oif+wqTg
	II57+Wd0ipYj2ThoCftT0qO0Z22IL38ukEKzgxPAtQhg+yyGd41vZrNzr13i4XDk
	CFdcCpLWy986p5bV0FKyMqpkZMsqwFU1n3nSBU+non9gb2vBsLJ6VroEaTLChZNs
	/43BT1MuavSMQi6UM4J4AAiBLEFzFO4sBewsXWpFt+6hTjJF8nDhA5XTr3h3ChNh
	RKGX/tx7EiyZq7800vs2LPGstc158x/DV71B/vMZftU7ehugnAatA/Wb7dLEMx2Q
	xdUVzs8cfkb6gxWLypGhw==
X-ME-Sender: <xms:ScLpaXfjBvfYtInqfApCeRCJ9Kr38szwEBVOVY79fqFanGO0ZHh0cQ>
    <xme:ScLpaUq70fOS0l5XvC6dUQIeOzJh2Y7XaOCzVMrfetUIvInpDNXdtIMU65pnqPUxo
    yg3SldOGZIYoVK8AY7zGslCa2wnCMX9Fc4jSCvhdyEWFPwPjisWIQ>
X-ME-Received: <xmr:ScLpad5CR0f_pSE_8JP-RDu7rRqC7ddPqmgFOwR81y5nGSmZVO9AdxpM9nVw3QZlm2YQ_P8BWONV8e1nwWHu2tu_-XfFi2naABcoGR8M7yRh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiieegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:ScLpaSpw3XDl_NvCB-3jJD7-GP28JXXI105lEKBR5yhVp48wzqywyw>
    <xmx:ScLpaXj5Jz42YZLd88a_UKLBb-NGlJchXLIHLEIw_mze8wsBMGRWqQ>
    <xmx:ScLpaUKJWHZg1W_th3gyuN4s6IHTq794jnWX9nJu18UYs08YlwtAFA>
    <xmx:ScLpafDGriEJ8HHcI_huotNMlKhKVSkQTyqghfglOASIdJIrqT7qDA>
    <xmx:ScLpaTG4rq8qzMaYW0rS7eejedfU3bUeM3NKoXpmPqOYL9dFDJs0p5Ev>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 02:55:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 303da28b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 23 Apr 2026 06:55:02 +0000 (UTC)
Date: Thu, 23 Apr 2026 08:55:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] builtin/history: introduce "fixup" subcommand
Message-ID: <aenCRKxak1l6GE3H@pks.im>
References: <20260422-b4-pks-history-fixup-v1-0-48d4484243de@pks.im>
 <20260422-b4-pks-history-fixup-v1-2-48d4484243de@pks.im>
 <CALnO6CCBA=OSvKT8D6-YR1S=x3VOa_MpzWfK6FJWPSXq0ysMPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CCBA=OSvKT8D6-YR1S=x3VOa_MpzWfK6FJWPSXq0ysMPg@mail.gmail.com>

On Wed, Apr 22, 2026 at 03:06:12PM -0400, D. Ben Knoble wrote:
> On Wed, Apr 22, 2026 at 6:30 AM Patrick Steinhardt <ps@pks.im> wrote:
> > diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> > index 24dc907033..3cdfc8ba02 100644
> > --- a/Documentation/git-history.adoc
> > +++ b/Documentation/git-history.adoc
> > @@ -53,6 +55,19 @@ COMMANDS
> >
> >  The following commands are available to rewrite history in different ways:
> >
> > +`fixup <commit>`::
> > +       Apply the currently staged changes to the specified commit. The staged
> > +       changes are incorporated into the target commit's tree via a three-way
> > +       merge, using HEAD's tree as the merge base, which is equivalent to
> > +       linkgit:git-cherry-pick[1].
> 
> I'm not quite sure what, as a user of "git history fixup," I'm
> supposed to take from this. Does it make conflicts less likely when
> creating the new fixup? I imagine it doesn't help with conflicts
> between <commit> and HEAD that newly arise.
> 
> Anyway, I'd think the mechanics are less relevant than the end-user
> behavior at this point in the doc, unless the equivalence with
> cherry-pick is supposed to tell me something about that behavior.

There's at least two more or less obvious variants to do this:

  - You generate the diff between HEAD and index and then try to reapply
    the patch on top of the target commit.

  - You perform the three-way merge.

The second item is definitely more robust compared to generating the
diff and reapplying it, and we use the exact same strategy to perform
cherry-picks nowadays.

> > diff --git a/builtin/history.c b/builtin/history.c
> > index 549e352c74..6299f0dfa9 100644
> > --- a/builtin/history.c
> > +++ b/builtin/history.c
[snip]
> > +       /*
> > +        * Perform the three-way merge to reapply changes in the index onto the
> > +        * target commit. This is using basically the same logic as a
> > +        * cherry-pick, where the base commit is our HEAD, ours is the original
> > +        * tree and theirs is the index tree.
> > +        */
> 
> OTOH, this explanation helps quite a bit here :)

Hm, okay. I felt that this explanation here is even more technical. How
about:

    `fixup <commit>`::
        Apply the currently staged changes to the specified commit. This
        is done by performing a three-way merge between the HEAD commit,
        the target commit and the tree generated from staged changes.
        This is using the same logic as linkgit:git-cherry-pick[1].

Not sure that this is an improvement? Happy to hear other suggestions.

Thanks!

Patrick
