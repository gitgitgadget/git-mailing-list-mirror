Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE74B31AF07
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599695; cv=none; b=ISA3mH/Q52gxaIKTUmNdTUvHjNym/oJQf3UjhkKhLuvClTjY2abdRdVTaSnUvGRTD+uT3X0bKglkpIMCsZKXKLO9HfTKNWbH9v+IhjPbe74FDm5d9a2u7s2I3QSpP44j/VoT/uyfR2C4N9g3u0AXiwy64zmLQlcBRRya36TCooc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599695; c=relaxed/simple;
	bh=YBYQW2gypQ8aaTUofvJBLsNiRreRWg+Msp6jrJxsmP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9LkzaQYxNkVtD8gazdkcAgE9YxG7NsaP6lorYE94Y/8ayc4KzDiowQxMrM1mhnjkGSRf7gZkrpFo9PGnIFsd2ThOC1N3yc1AzzC94rSoJezXKzD1R9jJcEZoh1UXSRodH9XwCmyX95gzZZ6StP1UleMPUiK2cLllffYt+BBL2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hEqEX/u2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oryZatSR; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hEqEX/u2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oryZatSR"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E6E071D000D1;
	Mon, 28 Sep 2026 08:48:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 28 Sep 2026 08:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790599692; x=1790686092; bh=XjHRu4KBXx
	RiXwB5ZzHo7kYk2dEBm5tYbjQ1Y5Y0I6g=; b=hEqEX/u22l+YONO1fMLNNKAuqh
	Pm5qgLLewqOSVrPGJQV5L1GJS67ZbfisJrOpVUPmV73h1vIA3k7JQQuH7IfbXZl3
	W2LIjzyxmtbSLR0/nGR0EaW2CjzoDH0mIhZ1bZAnuTHtreqZ4DsIgzq7VHFglx36
	FSAnYnWf361tcSLsvQln6kaihc6o4Zsf6ijjtE+fW1B9mM8sNvCevpUsmPzY+cmJ
	c1NSIgIn1Rh9OO3igTM+2NjgSqddFuhF4nM67nAhRBaVul9EKUqIK1pmJ5jfMwHD
	5H7odQlvyXEdgoaqdY6Oo9x6gNQR76QBQOqm1GEV5D44DM+dTplFvxi6b7Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790599692; x=1790686092; bh=XjHRu4KBXxRiXwB5ZzHo7kYk2dEBm5tYbjQ
	1Y5Y0I6g=; b=oryZatSRz7C5YboFgUPA/hZ5s4/I3wyqDjHSG0kH3ztLd5pozuD
	Q8JoEfu96mcnQCNEI2HTzoRZTrDSHAhDzJUOYGUvA+3l4NegxFAfnZMyihArvoro
	gva7To8j9nsxh5UQ+sevbRTiyrkIM44FE2fgo8XUwPmxWtMbJEWxZaQ0ppvtiEYj
	6EBqY+FT0otyKb6H4I0vw6ubkgtMleANnuGCsPGdJQiPaDxyDuqW5RVcSHeTytvN
	7I5rOY5cg3rqNFFr5zuBZPonUgKXiVdAWmb1+mxDjxT3MnS77WFNHuapz+IIrHBr
	k+p8exgFRusPa5qnBYzzq1dgv5n0GPr9SNw==
X-ME-Sender: <xms:DGK6agJRWV7j2Cpssgy8h5wgpFZp78yMHsLwbxxFEWvCq8Zr2uchHA>
    <xme:DGK6anlBeYaGRRNOdk0GYfpdySHu1wStpvZyPGDvrUI9P9a8zAFsdlEHBHHM09rNI
    EiXDq0fiQwc4c5c0fxX7kRZ_lBuyW7_B01rGNoNEAkRSEUhGnUp_Gk>
X-ME-Received: <xmr:DGK6auGefbC1FArKBSUQXd1ylheYkmHGDjaSYVJvyfxd2jE3fbiecg>
X-ME-Proxy-Cause: dmFkZTEuP9qrAlsRRgO3Tcbkimep8NTGsMPae526dK0wKrYBE4G/Ce6sZtPifbxOh4RTma
    /mr/htmDQz+boKM7RB0Yp0bYgLn57qE98ALEF4FBNm/p5lKfLUsrDJIcRI9SEfLPwbWlJa
    7vWmBBcaxsb0kAtoJ0J+iGwk25H4iB1nfVPcQZROi7qcByOf57YTA0AQHlK7uSZezRPvSw
    h7lpOJETWXWg9K8TT6h3GWSXQiifj4gUpyk+Bw8Fg9ZuvBsMjDGvLpCQomVXjQKtZB07QK
    0uvMnrwb78AAHfVk6N5YyVy3dS6ka2yujgfqW/EY6GsWXADvKjzUhdxMl8huKrKcitUiFb
    0KVwByNkx0HUCkcJHKQEq+v9XJjgo046qTHsoBfo90Or02z23VyLM/pngazw4hQbr9KHcV
    5ln0oul+uuxc7WofI8lYEMo5Rs73RmqOWalU2mH82Cmx9XKF/raXh0vXliYc/lhIf4mORW
    Cu04b8jrfThyretRmpkwDigqydHU0Lk5REHjMQ5navfs5RbuXqgErZliYwexsthQ/Cb+kz
    DGyOnrlVThFMQGRZ8LpF1lK7U/v4Cvhz37lcWuV5JlvKeh3V0RB8x25pk/zdZhYp40N1ud
    xMq6+PQhCSSutieuWus1gTSYgEU8tudGNQDUKEXz17qAXeWdIU+nawz0tOLA
X-ME-Proxy: <xmx:DGK6anFPcYBy_cn12nbpWmkkDvmDxaC80uUntNfpSej64fXBTzd8-Q>
    <xmx:DGK6arPUKyI-PFVNujaRCajyoVRR7mF_EEgQeqRCcXO8GKZtWUJnuQ>
    <xmx:DGK6amHjV0cFQjj3lhr6zBZQzjVrlGEobce9KTr6bvLG5OG1DFo0Xw>
    <xmx:DGK6aiMA9H-s7CrFZ4SyGDkXuiq937pTvViM5RiiG7GskFRlg4bisg>
    <xmx:DGK6alDJ5os51jKqv0D9pW6H40Yra-eERH7puqWQ0mJkgMMQr3badJZm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 08:48:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0549af70 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 12:48:10 +0000 (UTC)
Date: Mon, 28 Sep 2026 14:48:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 0/7] setup: enforce repo passed to
 `create_repository()` has no state
Message-ID: <arpiCEYBV-IzVTK3@pks.im>
References: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
 <20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>
 <b0ec2ef9-7aef-4f7d-b31b-7141b39c2d24@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0ec2ef9-7aef-4f7d-b31b-7141b39c2d24@gmail.com>

On Mon, Sep 28, 2026 at 05:45:00PM +0530, Kaartic Sivaraam wrote:
> On 9/28/26 15:21, Patrick Steinhardt wrote:
> > 
> > [... snip ...]
> >
> > 3:  3a7c197f1b = 3:  8dd89f144a builtin/init: refactor messy creation of leading directories
> > 4:  c3ced666bd = 4:  f37db1b17d builtin/init: move handling of "core.sharedRepository" into "setup.c"
> > 5:  25918a4ff6 = 5:  db76d32f2c builtin/clone: don't apply "core.sharedRepository" to leading dirs
> > 6:  a742852675 ! 6:  19388a188c repository: adapt `repo_clear()` to fully reset the repository
> >      @@ Commit message
> >           some state because we don't make sure to clear the whole structure.
> >           Refactor the function to set the whole repository to all-zeroes to avoid
> >      -    any kind of leaking state. While at it, make it a bit more robust when
> >      -    called on an already-blank repository.
> >      +    any kind of leaking state. Replace calls of `FREE_AND_NULL()` to instead
> >      +    use free(3p) to avoid zeroing out the data twice.
> > 
> 
> s/free(3p)/free/
> Rest of the inter-diff looks neat.

The "(3p)" is intentional, as we use that to refer to man pages. In this
case, it's free as specified in the POSIX programmer's manual.

Thanks!

Patrick
