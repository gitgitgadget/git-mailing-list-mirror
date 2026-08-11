Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51020313E34
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 05:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786424809; cv=none; b=RDBtI7hqQ3IlcvtCorcJK7Paz1tWdRtOfem2P9jBtGJbZTFYi7u9rAnx83mJnJthelwnyP13nOAaGgDE77hY4qELj/dPP8tj/p2rSqWp8q8RQxgXryTDXKVyagXk3Uyv+IsU0tgOGiUxRr3Q5wA/3Ff5t9PRr+i5EvvlUY4I+DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786424809; c=relaxed/simple;
	bh=7pgp9wp8wc/EoVqPsMH7EHkKM7p5TWZ2HXmZxXG6m4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p16rJWKTxzhjlkSV8EfzoXs1x0YG+riOfeO2vGeauCCOA9pWIuBE7XM63aQEvhq9HLt+FDGSIBX7Rp2EPkFkf1gUazT5cLdeVKs9RxV0rgCT0j9fV9tTLaY5XbjF8c5PJN8QocPe9DypOQ4NBY3jCd3UUTUTzgvEGFzznIWqcaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZZs0zEvk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ixm9TlFc; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZZs0zEvk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ixm9TlFc"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 710B814000DB;
	Tue, 11 Aug 2026 01:06:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 01:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786424807; x=1786511207; bh=2iilttFZSm
	Ln7rC++Xg3yjtAz9yt6N6fc7YFWeCCrng=; b=ZZs0zEvkGLW77tnocD1OFVftSE
	fH4HXfniFGmInscjrfWO1+LKn9CNahOWf8EOf44UaDBQmWuWhAPyfCC543aP0Sxi
	Bj1l+mmhhQD2vwWcF7oCp+m8y1JXAdpQ08AQEfo1J41ZOId7H6jl9dYRGA77dlVw
	SrqSR7mv1nVGjWVd9yeFZvKUSFyoVyH5ht7QyAd1yUwBhNIWTZb2OJtXO5E2g+Ok
	QJnEThRSIr2FNKsM/sALb89CFDIj1P97J9eX5xQOdYmvxO87Dl9pCnmxys24iSIW
	QA+ooV6tPR4xNnWpq/LRF2UrPfw3Z+3KWqEfLhAOgIA6kxwFUbyUPr2WE/2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786424807; x=1786511207; bh=2iilttFZSmLn7rC++Xg3yjtAz9yt6N6fc7Y
	FWeCCrng=; b=ixm9TlFcpT8StOh2ss5v6443xlrdLkEm9Rn8ZcPH/Nwt2GJfApO
	zel2Hs+o9L3c+dIkAVZB/9bYXNt4UhyEBsmiuxffHy6i17MzuE8hb9S2HZ0wus4Z
	hdkYXwcC/kVnjcHOBUK1gN2DrrwYgNFONiwIjOnAkaEOMoIxmCUr9H5GuA1NKohI
	1DV/0CvtUtbxb3NdX/4R3jtvFX2v2TZlV1BQucuSEtBUiGMTndZfdJXuc4oPRXI4
	oE5e1hj/OGrZPFkqth0yTp6Lmsm5iLeN6v+ILI7qmiZLgONPU592uNChmvnfV52w
	3QS1wqr401VlAFu/RaNfmDM1NkTG2L7SuNw==
X-ME-Sender: <xms:5616akj1_VvVK_D_0JHAPLrKpEEbkfdQR0tykBUpq51QgapXWO-U4g>
    <xme:5616agthUdsadRSk2IHX_WKsb-ITy6UPKegrtcmZ2X9FN4319Qdk6XwWiyPbsk3hW
    BhIXMDSjVDPQcOLqKPG6YJfG8EpHpB697BMy4CjG3dVkV-LZ79r>
X-ME-Received: <xmr:5616al6Ovcc_F8x_Ekx-Zf9qeoRow0ROkzf4XnuJfsYucWBQ7iw4yJqPRo_0LGW2Izeu4SLQ5WOpoQit5ZHotyBUyQwqViCJhe4MGgfXqA>
X-ME-Proxy-Cause: dmFkZTEVPks/VZZIb7E8J6H9WYiV/Aki03i6Vw0nRI3IfpPDLoX2XIAmA/q5n1uwJkgWA4
    hq1KkCOqvqg5V6ew2kKlofUrQb6BdHExsyPsj7jh9O6yE7FKZ4suqCJzIwuSRqXVh5xtli
    jwcMMYAXIZLmg7CwV2Rc5efpmg5QNR60Kg8UnD1DFsSD/nLHHWUqriQ6598X5VkuhpSClf
    sKnPTIpQEHsV41Do4z0LSEpU2A6rsN5r6CjPvt+/6PrrT2KYz61WgoHzDImaypMyDWD4XR
    BZfkBf02RbEYvOnEJGqMwyAG9BHbkXGe+HEOdCV/B//LJCmqIcuP4Tsgeuh7h0pieDFXo7
    sSXz1fg0Vxn+AoZ8VZgWeSeYp4XGdS97H0LX0OVGRCuemzS9h+hZK8qUElofDHx39gskg/
    C18lvP6vwBqZq02syqjAKuAx9DfIM9eKoYLQabhvz26gyBttmz5l7SgBKakylXqWekE2ZK
    vTAdrEoQ2P6XZYSlFxmJeke8aC6DPw/YMxLHu5hbxuNBQ3cRWbN1/EuR/7kHWUSg3U6/0a
    lhYgbuyqo1f2CkxB0TBFOqxvBpdsVi0mnKdPaELGLnWWAo71tkD/FNewvaQCdNN30eVNs7
    bsqTFLyRGSW0OUxVqMWOs7p+mozbH23Eib39wCW8IQPfO4qG9tSObqZ08FsA
X-ME-Proxy: <xmx:5616asOBMwAEx6Zcyd0JwhCiQsreVhVpnCHB8W0ZkALcaX1UKGbwCw>
    <xmx:5616ajtBvXwkdzl759ThZZC53ZU7Mjrk1CtEQyz7GCjQuzAMtuFwKw>
    <xmx:5616avbmwwDqJMA8T3qbPDTTcXmk0NURgX5_ENdAqojahY3chys66A>
    <xmx:5616alzRuqHfohjT2upr1-WQncyTh54ynFrOCm2_Hhr8QavVcRNuFQ>
    <xmx:5616atvvm6AmATxcHQ-up2gPR8EWMPWbco2MbOWWxymXUJ25MytxIkZY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 01:06:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 183492c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Aug 2026 05:06:44 +0000 (UTC)
Date: Tue, 11 Aug 2026 07:06:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Stefan Haller <lists@haller-berlin.de>,
	"D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>,
	"schacon@gmail.com" <schacon@gmail.com>
Subject: Re: Can we do better than "git checkout/add -p"
Message-ID: <anqt4a7L49W3BmZQ@pks.im>
References: <xmqq8q6ih924.fsf@gitster.g>
 <CALnO6CBu8ZBDk9YwLW2jVJtBUk1=pvai5QHiLN6XLOOL-3KA=g@mail.gmail.com>
 <xmqqfr0qexps.fsf@gitster.g>
 <anlpmNSjBUJ8p9RL@pks.im>
 <26c2f7e0-03ef-4c45-8175-adcc2e0395ac@haller-berlin.de>
 <xmqqldae6luz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldae6luz.fsf@gitster.g>

On Mon, Aug 10, 2026 at 08:23:00AM -0700, Junio C Hamano wrote:
> Stefan Haller <lists@haller-berlin.de> writes:
> 
> > On 10.08.26 08:03, Patrick Steinhardt wrote:
> >> I've been playing around with the thought of introducing ncurses-based
> >> interfaces into Git. I've been mostly thinking about git-history(1) here
> >> so that you can just move commits around, squash them together, drop
> >> them and so on. But I think fancy stuff like TUIs can also be applied to
> >> other parts of Git, as well, to make things a bit more visual to our
> >> users and, as a consequence, easier to use.
> >
> > That sounds a whole lot like lazygit to me [1]; it does all those things
> > in a rather intuitive way, including Junio's original use case of
> > selecting a hunk and staging or discarding it.
> >
> > Is it really worth adding such functionality to core git? I like the
> > idea of tools specializing on what they do well; core git on providing
> > the core functionality, GUI tools on presenting it in a UI.
> >
> > [1] https://github.com/jesseduffield/lazygit
> 
> My philosophy has always been "do not compete with your customer".
> 
> If we add an officially sanctioned XYZ to 'git-core', it would hold
> an undue advantage over tools built on 'git-core' that perform the
> same task, not because ours is implemented better but merely
> because it comes bundled with 'git-core'.  I do not want that.
> 
> An exception is when our XYZ is truly of "we wish someone had
> written something better that offers functionality like this"
> quality, serving as a "usable but perhaps not pretty" demonstration.

I guess that's fair. As I said in my parallel reply to this message, I
could also see that having something like a git-history(1) UI might be
too much. But I think having a TUI for selecting individual hunks in a
better way compared to `git add -i` and friends might be sensible and
not significantly overlap with other projects.

Patrick
