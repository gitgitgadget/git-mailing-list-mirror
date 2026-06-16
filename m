Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C56040803D
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781595728; cv=none; b=srUPHmqeH33U4wC54rPqqqzhAhsmuHEvaXlskVgXE8I6zcCM+buqsi0XK1YVyb9PzRO7P8kliuRlArWeCbvAGi4rUevxNyOxc2qTO9ncPLXYg8UCbyc8fQgxHxFT0dyWXUqNqTtuQ+rMls282xhrJZfUSHhyqWNgiK4vFchAML4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781595728; c=relaxed/simple;
	bh=6kSx/12Kyy6ZBNkJIHmlDTOqjy/FOha0Ocv+fmsfMvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFvwDwjzSSfOKyCTrcSg3k0F0YawZ7HnkvfyogsN3x3vIn8Gc3ZmB9XUIa2/z8NsUw8xNVaCh4s60Yishx6EK7YdV+FDlpZo/TXSXHTQsOQP+uxMt6kilwHzLDJzWFuEGPZ5qsRpHZOzKCioM/gJZpI2y17CqO8JOBlQdp39eCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EWeyOoPS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gGJTO5kt; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EWeyOoPS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gGJTO5kt"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 38A1D7A01B6;
	Tue, 16 Jun 2026 03:42:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 16 Jun 2026 03:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781595724; x=1781682124; bh=0hiiRWHnJK
	J/IL6Osjn1SIinUp3KXvh+0Je89Hlucj4=; b=EWeyOoPS9eCgx9x/uKkM+gDuEZ
	31UbIvd0PY2hwWTLuLioiDPeLX+yuq3z0Onf8z57jsBMUTFdiVL6992aSkZQdSK9
	xq2oy/BUzw1kaT9j/UJm9XbwxwgO/zOpISGeTQb3f7bGZX/eFLxU7rF5zvrvITUm
	gRq9UHp3yIR+PMPBzRHNhrB+qZfcQabjj0k5OfOY/4gdwd83il9ZmXeMXo6G5Je+
	9mIh0ACENztKJHXbD9qhbkP3EgybE2chDRtRtJj2QXqeTBt88lmc1by5gUDtPNcZ
	mk2WocHsg4yT9WWIzV/I3grzBmSKSE63T3qyJ7dD2kGF/ToWSKvjlQaierMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781595724; x=1781682124; bh=0hiiRWHnJKJ/IL6Osjn1SIinUp3KXvh+0Je
	89Hlucj4=; b=gGJTO5ktwZ5V5QyiWeginDyE7lVTxFdzPeA4u3Wa0D61+j5i3Ep
	XRbYLXCtCyssyd8M0wZKjIC0NKJt6Lp6L9q9dpgZ71HvD9gDn9pU9McIL2+WQxA+
	qUCC1GMBe7LdqPJcTCqVdTUNdfLUmQZcFdUvh7tHCJdUt+8XR43QmkfJqZM/ACKV
	TvckfKLa/+5ueeDcHktO55os63xhrSC3Z/bQUJO8V1TuFSMYjWTdkLR4ppxYOSyp
	0V/0l8be+tF0g1p/SHpLpjUoqBLbl19TWnlTYZp2io7UDg/He7IdmLdH4EA8FKO9
	ipqiY1uazlTczATggzBQF1tKZ6/x2KgmTTw==
X-ME-Sender: <xms:TP4wau_ArWwu6DHJOqOhjw5BXEgQPDLfmy5UcshvpWeFrGRMbxnApw>
    <xme:TP4wakt_OVhCPb105tMnmOkkBl6ReG_rIilNkKF0qwkSo7QcYaEzrBHzU9RsOlOpS
    OuhIC2zTniXoVFre26YTcT_2TBQ2y845wEJJ7H8-_WppeQmLpWv>
X-ME-Received: <xmr:TP4wahqLRdA5ufUDp7AUSlbUDV1l6nfNzlKeq0rqLb50MKUvnSr3g0XSGccXFPFZdw0Fkc1fRxmv_FGMYJQXgjbJthzlOlTDC4bAHWrj_qiQrg>
X-ME-Proxy-Cause: dmFkZTFn3kfCz0/35al0dSSLBZANfsm8obkWWR+Jdf3Np+X8T2fTXvhSgt00TUb7qXIbtd
    hS02s7EVA31ehDF0ySyA0oh124eVORmJqVexNHCXPRdKtLZs/bB5WIeJFqYKpCwfp6K/Gm
    IEvxxALf6xMoogHJHltiWvwfonlh9zQxgxyzccwkct3dQxekiT9MVdYMtGlhq01qUTh7Ej
    f5z5bTCYx/VSI8amlEGN2n3+ZIGRyaE/8T/amWdUBdVNgsUb2Q3k1n2rqt5uG5HkJemCef
    S2d0au+rgzAs3lVJe2wYjwOmi5lAtvBizdC8n70fYNGCBOJiYcHtpva6EgvsKLWQONutpd
    +CY2I2KAhInEWO2t22Ly6kFMKSka7pQiEopnmbwyxWx2V37sSCy92OhwPWsCII6ccAmx5K
    RZmUG0PzDNRxB8u4o+Dg7nZ8MRGbpf99Tn/and8G2S9Sg1TvfKiOyuwlGr+VeDO1ixleuC
    LvU/cKtBgnW+HSQWGWNqpjGq5CKGRAgOrd8kScI+IjTOFJPjjyEgp5XP0KqLAdmWjhYHXd
    GziqXcNEr84rLmjpS8f3cdTirgm9BYL23dVLDc9m29/ISZViDk2tZE+1OZx8nuidwJ/jUR
    pkkK7kLwfL9OODZH6XHyjvGwLUC2jWqkwLkdADOSGh3oZs3CQGktmgVqvL6Q
X-ME-Proxy: <xmx:TP4wahnfZxiCYEI__Mk0Q3PCYt29jYRm7HGcmHC05luQvIlY-mWShQ>
    <xmx:TP4walzxfPkc982NfQQnOGP_g7mUpOW2fykWX7D5rkStjJktDN0PCg>
    <xmx:TP4waplXc2HBYeP1MEHn5LBbM-DFusmlDyaNPYYKvMYZzlNrothVzQ>
    <xmx:TP4waud0cGmsZjnHySyyagszJi8YrII2tPdy_ea4Yl6l0S86jAy-kA>
    <xmx:TP4waqXyODAF9ooe_6TPi9HScB7ckemRMsfA0jjng1ck1Jt8e6VYHrpQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 03:42:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eb49b9a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Jun 2026 07:42:01 +0000 (UTC)
Date: Tue, 16 Jun 2026 09:41:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] update-ref: add --rename option
Message-ID: <ajD-Rt3ow4wpTNkq@pks.im>
References: <xmqqv7brz9ba.fsf@gitster.g>
 <xmqq7bo4n4ge.fsf@gitster.g>
 <aiugat0gvprSX5yr@pks.im>
 <xmqqqzmbhikj.fsf@gitster.g>
 <ai--jEk23E7RJPnc@pks.im>
 <xmqqv7bjbusb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7bjbusb.fsf@gitster.g>

On Mon, Jun 15, 2026 at 10:03:32AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > On Fri, Jun 12, 2026 at 08:41:48AM -0700, Junio C Hamano wrote:
> >> Patrick Steinhardt <ps@pks.im> writes:
> >> 
> >> > A slight tangent: this is part of why I really don't like commands that
> >> > determine their mode via flags: you now have to worry about every
> >> > combination of flags and whether they even make sense. With subcommands
> >> > we at least only have to worry about the set of flags that directly
> >> > apply to that given subcommand.
> >> >
> >> > Makes me wonder whether I should have a look at extending git-refs(1)
> >> > further:
> >> >
> >> >     git refs delete <ref> [<oldvalue>]
> >> >     git refs update <ref> <newvalue> [<oldvalue>]
> >> >     git refs rename <ref> <oldname> <newname>
> >> >
> >> > I always wanted to do this eventually so that we have one top-level
> >> > command that knows how to do "everything refs".
> >> 
> >> That may indeed be a better direction to go, but isn't update-ref
> >> the "everything refs" command already?
> >
> > Well, it doesn't handle reading references, which is something that
> > git-refs(1) already knows to do.
> 
> OK, fair enough.  "git refs" should become superset of "git
> show-ref" and "git update-ref", I guess.
> 
> So do you want to take the topic over and add it to "git refs"?

Sure, I can do that.

Patrick
