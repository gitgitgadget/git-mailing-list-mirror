Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8846A3EC684
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 08:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918627; cv=none; b=JjfxnuD0ADJ2RWsVeMnZx6M8It3uKkm5d1f2bjubquRDl/vaQv/UN5euESDogRXz3lmrVOEef1OSnIw/pfy46Ly2+Br9of0sENO46VxZrHbocDeFPgYgFJwU9vI2udS+1Eqh2gPQJ+nNi0SyPlkOiWjQmkCfPO7MEypcuevrwMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918627; c=relaxed/simple;
	bh=pxP0iGxXKhWPGtGGhdjsofLVSyWBvyaEU1o3RIanJW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJnMybwUj0TpzE5itgGqSTfv5Ri5hdphZJfRtf3/jA3M+Ntt80f+ZB1ZTzvyqVQ9U0wwhKXpp6P6S+kVrj7kYApIGJPa3hAtPjfH9yRIbr9WoY6yfyVmg3QsI2/ijI8DGiCYpxVFKe0UFWnAN7+8ZRLK4ri58sVYgpWie8BkIkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AkZBruoE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cjUCM0Jq; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AkZBruoE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cjUCM0Jq"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id AB391EC01EF;
	Wed,  5 Aug 2026 04:30:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 05 Aug 2026 04:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785918625; x=1786005025; bh=It09r1LYgD
	SNn+bOh0/KlblnwwF6i7Qa+f1/sB0829M=; b=AkZBruoEE0bbCVgVw7kto5NThV
	L8vGW1U0h53FaMbViNOyn/khiip8dY/OzChmHjHYCKfMg7FtA1JjYSq8y0oM5O62
	ZwokplY1pzKrokD0fb2jUkY3phhKtIYL4u7zEWKpYUWzV3Wy/pxPcTbmKPi9MOOs
	8fcmhhJF2RyK0Elae+rSCQ36SjvY3VeJXlWfA7FBwBhrd6Ic/b8P8+jdFXN917x9
	V3qfaYgsklnItbirb6WR/4KXUDNUHSWH/mSV6hSUfg+YjcRjs0M20De/HsHH7qh5
	AObSQcaDRI2IzjjbPv46v0HRDJbaYy+gQK/zYLKtsutov0wcxNlW2/PDjBqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785918625; x=1786005025; bh=It09r1LYgDSNn+bOh0/KlblnwwF6i7Qa+f1
	/sB0829M=; b=cjUCM0JqqSU4AFFltKvbH5UZPj9r9etfDIa8AabhP5qKBKvlXv6
	VNBN86Ubqj2veNhbx/k/kXAbVcONoFJUzp0k32WINXIST4PqGsyCnqO7v9LONcnF
	0BiQ3Pmw4jp3P4mxWUJoQ86NKUdr/8zuSiVL/XowgfAeh79h8yF68s7vhetRCXVg
	Gjc7TVSr59VG53WB0soQzffHgbg9v944sXhisrAfsJ3PXOE6zA87fJM5FylL564q
	cqGBjnQRJDZ0n4YotX8jyWaKQpSZ3fH7Y5M8XDSD+q6WJDw20MNn9JjjnpCcrQui
	lHF4Ko/XisoHzPwoVsBZKmDypFDDZ2eFdVA==
X-ME-Sender: <xms:ofRyaunM-_RuZZOkmuPJzJjfgH7PDVGhLJMCiAIQByFmvDOf0rWM4A>
    <xme:ofRyaqxKqItEO9VLMNfd8WCH8gLYN29qDUNODTC1jbPinxkyXs1kwN_W0Odc10I_E
    UeacTdSco8wqnm33BYmSPqGB0JrG4-Os_hI4ZadadL27tvoxeqMzQ>
X-ME-Received: <xmr:ofRyag6DzimCXpa4VsfKBzulySNEpP5uezpILgLpiFQhs5XWPS_4u-L-kOCukH4-AYlH7eu15PC8wn0BA9-g-UNKML-rZ4azslxjZk7w4Q>
X-ME-Proxy-Cause: dmFkZTGwklLSkR3i+hjaTFX2ttjNI053F9nnRGfpVGir4ReUa0ijBULj7ARb56jK/Nqfiu
    JUJRV4Iczsf+zPp4LSbReQiZzeMRzgjmS11O3h8rViJY0fLQxzVIF8W2SBi4RFkOQOMItx
    oBNZHSl8dK/FM6BjJs77TKXFOIcnxrguuieakPfAFdSOKYrg7+atBk5Byi+FthAY1NlgiU
    qqRlSC6+7IjKjyZcQG68mReTZFMr3QKj5rJjQXqY7t9HVBQDiXrjqUOOjK8r8SlqY3WBfP
    TLWK2HbMpMTzsn2jdQK+up9iJF/kCpj7Z2krzQZNYCq4EATV2Nh/OfHMYxw+zwzDFIoUex
    euBCz2FpkUHxZZJmCzLEMqO8Pti1HNh2cD1PzAEh+WE37/n/SjL0jaOWbzqeMASvGzsis9
    idROgbSMhALkmUt+y+OuZAUbVpv9pWeUzYEq6cIgxRs34GwauvP+/HJ5MDh2ZuQvBnHkla
    XdEYRDb7bhe2/Pv8Zvmba7lOcDMxr0VM+g46A3nwPRegIwxa9/rkDpRzRKUm5kxrRXyd4u
    IkkPhy2sP4RX0Qgv83iQ0n6aydqV0eq3ChnQAoUSqS0AU5FRFDyfqmJGfUnAaZqM3o/SuS
    qLqjRmASuxVKUWeTDhfZDsTyiGrrMfaOzZL+H+EcmH1S95WEfsrG2W0tQ3Og
X-ME-Proxy: <xmx:ofRyaiUXNl0pujHk9OECFziv0UwXavox2PyeOzFMM1odgEaiT8XY8g>
    <xmx:ofRyagIV9n0zOot9TpUAQaBUY5JFPRRgVXno9tNpQdh8TJbca1KPXg>
    <xmx:ofRyasukSkqinQ2dwB5hyCeKVEKtzzRM80KDfHWUK2fGUtFsR69j7w>
    <xmx:ofRyalLFoBqcM3krkR8YZrPG8UxI-4VQrmBsDzMf5sJ831_8ImjAOg>
    <xmx:ofRyahFVGXPmBSfZYau4UB_NLGRSuBd4sztrvOa-49pk9U1twSZQwMHv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 04:30:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c437ec5e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 08:30:23 +0000 (UTC)
Date: Wed, 5 Aug 2026 10:30:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>, Ben Knoble <ben.knoble@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"Randall S. Becker" <randall.becker@nexbridge.ca>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/5] Reintroduce writev(3p)
Message-ID: <anL0nIk6uzkYR9Oc@pks.im>
References: <20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im>
 <f8050598-392f-44c9-8d66-0454740a7a12@kdbg.org>
 <xmqqo6fso2s8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6fso2s8.fsf@gitster.g>

On Mon, Jul 27, 2026 at 08:44:39AM -0700, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > Am 16.07.26 um 09:52 schrieb Patrick Steinhardt:
> >> this patch series reintroduces the writev(3p) wrapper. This wrapper was
> >> originally introduced as part of Git 2.54 [1], but was ejected due to
> >> issues on NonStop [2].
> >
> > Please don't call the function "writev" so that nobody associates it
> > with the guarantees that only POSIX provides, but none of the
> > emulations. Call it "write_gather", for example.
> >
> > Also, clearly document that its only purpose is to reduce sequences of
> > write() calls to a single function call, but that the additional writev
> > guarantees are not needed.
> 
> It is philosophically more "pure" to have a two-level abstraction
> where write_gather(), which may be inspired by writev(2) but with
> specific subset of semantics that the application needs, is used by
> the application and have platforms with good enough writev(2) to
> implement it in terms of it.  Other platforms may implement it
> differently, like a series of write(2) calls, and as long as it
> fulfills the need of write_gather(), we are OK.
> 
> Doing so would also help in a minuscule way to avoid adding to the
> complaints we sometimes hear that our internal implementation
> assumes platform support for POSIX API and semantics way too much
> even when we do not need to.
> 
> So I do not mind going in that direction.  It feels a slightly
> roundabout approach, but in the longer run, I think it would place
> us in a much better place.
> 
> I think Patrick's writev(2) follows the pattern our previous compat/
> routines have taken.  We use real writev(2) where it is available,
> and in the fake implementations in compat/ we have comments that
> essentially say "the real function offers X, Y, and Z, but we only
> want X and Z and do not need Y, so this implementation does not
> support Y".  It is harder to maintain because the application side
> may be tempted over time to start depending on Y.  If some platforms
> cannot easily provide an equivalent of the real function, it is
> easier for them if the rules explicitly state from the beginning
> that we do not require and will never require Y, needing only X and
> Z from either the fake or real implementation.
> 
> At that point, we are not describing the real function anymore, so
> your proposal to give it a specific name is one step away from that,
> and that step is in the right direction.

Yeah, I was mostly trying to follow the precedent that we currently have
in our code base, where we assume POSIX functions and paper over any
gaps that a specific platform has via compatibility wrappers. And I
think that the compatibility wrapper we have for writev(3p) is close
enough to the original semantics of it to not really matter much in
practice.

I overall don't disagree that it would've been nice at times to have a
higher-level interface that abstracts over such platform specifics
without assuming POSIX semantics. But I'm not really sure what it buys
us to rename this to `write_gather()` without rethinking the bigger
approach we have to I/O. That is, what does it buy us to now diverge
from the current practice, and where do we want to end up?

I feel like that's a much bigger discussion to be had, and I'm not a
100% sure whether I want to open that can of worms now. If the only
thing that I need to change is to rename from writev to write_gather
then I'm happy to do that. But as said, I don't really think this buys
us much without the bigger discussion, so I'm a bit hesitant to do this.

Patrick
