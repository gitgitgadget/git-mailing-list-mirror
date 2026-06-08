Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D60738B7BD
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 06:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901328; cv=none; b=hxVeD5cgHY6ibqJeic8h8uIG7EPgaVGEEFURK3X27nzYYLyiM/sBxBCQyhY5i4mkigR2CgC98Tkd1OIxhTJMug5+MrGxWuZzN1cNoMtfwVD94AaKcfZYFyu+GJgbtHW5iWu8qai4gH+ps0YPAQMXvPf77JbaBR/JbMHG1SWhWVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901328; c=relaxed/simple;
	bh=OwTfvs8IF/5S97b/l8BsvM7Mvlhk7/ctKcm4sAlyCPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgHzzP8sipRDbhY3eJ2N070gfqtrY3bqNtHLLB0zx0xEs2YNSWlMzDPZUsY1UB8fTNpYMsKGh6bY1ZrE7UbUhUapFT0FUaOik6dtV3oGq8mG7+bGFy3BFsyspAPQ5yo4I3bHCSVablG6VCIkPStCzYUz1jVhyGiuDkbAw6FD6/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HRoTJztp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BJiMp3Nb; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HRoTJztp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BJiMp3Nb"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 360141D000B0;
	Mon,  8 Jun 2026 02:48:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 08 Jun 2026 02:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780901324; x=1780987724; bh=yn6vXmj5Iz
	9eiwTAO94doOwg5zdUWxwvjOiNYEdRFcE=; b=HRoTJztplz1I3RcXLmyNNZDnDe
	ssLHj5fzUKjgyA9csr0+zUUcUsm5vg1py8giTPUQZjftho0UA5ZErFVojgK24T+D
	RUpuFOLadWWzYUlUmgiXn94fYBcg5EP7IGKXb5bcxQ0elKGwGfRoYJGdvW5Kl2/e
	jhqM3846Ru3jZ9RLIuU+Kvrzqos5m8JQew4Y9J3D8k6h9pFHRG4lMcXQrPhYbys3
	jsIl9ghmuM/qOSliF0EZiVvEk9DydndFiEF+7TIJ4ifErd4BAjWf6ZSMrj2647l6
	0J/b8Uj3rL+R5wJINWZQBvUZUhqZVd8fc/jJVYqvO74tvsIgxM6Emj0IfEVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780901324; x=1780987724; bh=yn6vXmj5Iz9eiwTAO94doOwg5zdUWxwvjOi
	NYEdRFcE=; b=BJiMp3NbdmDSpNtQnpnqOq3O/VlOQs/k/bfMULjLLFo4T3SA+x9
	sEWiKff2o4w4onDG+/RZYn/hyhubNWJJNVqaD2dxSn0e/eH5ykiutAz6K7sLJXkB
	hU71fDMGP/LcpXGGFk8UyJ0OFOCVNQUHYE4yFnBTQluOBEmUncEdtVjh8EH84dvU
	/s7M9Ja3K0NWlPbh+csLoPtRtDfMjCxYDaHkZSFfyzBSk6u7+oO1k1YBUj+JbMln
	PP9Zx5dOQVTa7nXLAZbN08eeVjjUkGIhUgDp3d+74IYRk+Y7Atk6Md8QV9Xxkj9/
	nBKOPbFr8OOTZ8AkqnuGvC1JZXPE1b1nGow==
X-ME-Sender: <xms:y2UmajY30p3aE3HB-LqWqGeMXV3p7kDzFL60jYjiw4bg3YGfOIdxKg>
    <xme:y2Umart10a08xUgEn9GpoePshQMudENQwtaQdU2mpwVntQlf1d_fKG5ZQ0iwdDNV7
    5aHXQZ-1Kc1IVdtRTlj93J7PopohgNG5Wey5g5IpF-a7-yw6VlngA>
X-ME-Received: <xmr:y2UmatPxzkpaH2voXhoWZvlM7G9TBIkUQd7En1AzixVGbrVbwVvcAsjD6xULqo02OZSB3h1wPmfWrD4m6gDr1kSrSsxc2coVHai0KKrisg>
X-ME-Proxy-Cause: dmFkZTFaiulkSclKmK9XQBNhpL1XptUG5Mj/wgUWgbxLjPc44MKlrxjw4wVnTKEE2F0Ake
    Vq6xR17hI9nE2zlBpItPc2q3JJ2MJDprVPav0VnhUXKTAp91iTJ6dl83PcbSsOBCq03n0M
    QRRKwJ1epVRgv/CPAJ7qNVjU/iuL2Jd9kXJ49BpMizFA0I2TZL7vI8DHX71JwwHyc+el2X
    EKfZnViqza/GfOBwdBy/YgFWSLslVNbkI7vlVpe3Ln4L+pcPWzYPTYkqWtqW0KJ5Jzwkfw
    pJ0icGJKrUqnguMGQ740kdOyDl1+KDSnRgFJL1fyPvmCMEtXqylC5iuw0ZjC5yASaDSXGI
    09TQJVO3vc5ebNAjMQzLI6VzUvcIF2mpJ1GMKa17D3a4A4F26m+4UndkYVdKP6mmBAIDVe
    ruyP/nys/VjBJg47nSwj/3x3ww3+u/afgA2Tedir2m1zQmesMuNXLcz4ZyM/14HWy7BsQN
    SieDk0IPya1IHq+2AUFCIP3KPpriDJDgcAslLu+lo4YopWgYAyhrqAaRWUMXOrj9aAxPMe
    HxqcRlcUFiEWcceQjDUB17FaTVuszBGOErLduwT4ZrITO7N12B9KbBNNAcsYCLXiIuGuSO
    U/aRC6Nz79FqES/OKC3+K730fN7uk1ZO3Oyw9GSxiWwDf7kj9fXgRKnKTOuQ
X-ME-Proxy: <xmx:y2Umaq6nFD-NJuFgKFJzgdJu7mvH-vNTYBo_6RCaKrd8zLI_7oCqbg>
    <xmx:y2UmarQv4vD--8U5aA_7laq08Ss86pwIMH2DpvhjAkwo3J19hzFsFw>
    <xmx:y2UmavAL6NeMr1HrtGwB8IkfEy8ooA1lpESZfNrsy_H_et2zP92AZw>
    <xmx:y2UmajGRCnXl-FYoSfrMOB1bsQCXHfVGijmXUMxB8BhD766n-fmWjw>
    <xmx:zGUmagmTXE_X-4mvYXEr4ySqd6XjdWYLUtJLRfv43OTsUha-MnGQ1I5I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 02:48:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 431ec72b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 06:48:41 +0000 (UTC)
Date: Mon, 8 Jun 2026 08:48:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Tuomas Ahola <taahol@utu.fi>, Weijie Yuan <wy@wyuan.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 2/3] Documentation/MyFirstContribution: recommend the
 use of b4
Message-ID: <aiZlx-ue6N8gCIMr@pks.im>
References: <20260603-pks-b4-v2-0-a8aea0aa2c23@pks.im>
 <20260603-pks-b4-v2-2-a8aea0aa2c23@pks.im>
 <87mrxa27xq.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mrxa27xq.fsf@emacs.iotcl.com>

On Thu, Jun 04, 2026 at 07:25:37AM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> > index 069020196c..fc0b06ae67 100644
> > --- a/Documentation/MyFirstContribution.adoc
> > +++ b/Documentation/MyFirstContribution.adoc
> > @@ -833,7 +833,7 @@ This patchset is part of the MyFirstContribution tutorial and should not
> >  be merged.
> >  ----
> >  
> > -At this point the tutorial diverges, in order to demonstrate two
> > +At this point the tutorial diverges, in order to demonstrate three
> >  different methods of formatting your patchset and getting it reviewed.
> >  
> >  The first method to be covered is GitGitGadget, which is useful for those
> > @@ -845,9 +845,14 @@ more fine-grained control over the emails to be sent. This method requires some
> >  setup which can change depending on your system and will not be covered in this
> >  tutorial.
> >  
> > +The third method to be covered is `b4`, which builds on top of `git
> > +format-patch` and `git send-email`. This method is the recommended way to
> > +submit patches via mail as it automates a lot of the bookkeeping required by
> > +`git send-email`.
> 
> The GitGitGadget method includes Running CI, maybe that's worth
> mentioning the user is responsible themselves to run the whole test
> suite? Or is this outside the scope of this series, since `git
> send-email` doesn't include that too.

I'd say it's out-of-scope for this patch series.

That being said, I have been wondering last week whether we can automate
running CI in some fashion to shorten feedback cycles, bridge the gap
between the mailing list and CI and ultimately help both reviewers and
Junio. Some subsystems in the Linux kernel for example have tooling that
picks up patch series from the mailing list, runs it through CI and then
reports results to the mailing list (for example [1]).

Having something like that might be valuable for us, too.

Patrick

[1]: https://github.com/linux-netdev/nipa
