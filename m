Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013553090C6
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 06:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791183464; cv=none; b=VELKOR9QP+srwQlesSSDyzDUIs8qxTwtHXGepjU9tNfJz6srqMMJc2IeFiOyJS+sKOGs1mpHFE+Kl+kXB7uRar2EaypLhek491ZnhMa6Rb1Pb37oBc2ujUO5f9vRwA/r6Vy0FHrwB+CLnTeM1pffywAnqoTk3Ts28kemELx5HE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791183464; c=relaxed/simple;
	bh=gnt+5y1fgPG6SNrHu1kS6IcdogDyZfOUmKOcO4El+Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7qT/GbnikuzfrZApdioHvWJ7UZDdBWMipGV6MdEjk0Cq4TeXpqrMF4pNAkBMNjsHw3zwPwcWfyn/0Srq4kd6nWf3uw+o0sbJ1wBEAS1Ov0l8aBZm8Y2q15wEcmGFSkRATy9NSJVMKvDpgr4LnHaI4pxcmbCxTNMLpREcv5pyiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B/nNTcrd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H6nDnAqb; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B/nNTcrd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H6nDnAqb"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id EF578EC09B5
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 02:57:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 05 Oct 2026 02:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791183461; x=1791269861; bh=7nqqp4JjhZ
	TxXJJGodJSICWimK13V3bWxOBWPf8RGN0=; b=B/nNTcrdavltrO+GnbsRJLPV3T
	pEb/gXIGuPpix4awm5sJe/9a/pYC79moNQNSB4cqOvysDrg/N701XiPxaKPyVDlw
	DX++JZWAH6Eq7IQoqPIcjuffbYJosvhKx1tNHwOYrz7wqSbKvYS/UdqNY5tQ8Buv
	cwW9sqVctWO76KXrae9wGAmgY1t+6UqsGWO8xYPVgg+zFvX0nGIfi86ohkUo1RUo
	QPUygMXyXcH3XB5Bn/FksOQkdqgJHArp19O3Z+2pbF8AfSPR9gx3iyor2C3yE7xj
	twWOdWn+qgHSTq0NfAM0AWSZxAwPyT3kvCdvYZm1udsgOUfZ63wX2RyyJgVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791183461; x=1791269861; bh=7nqqp4JjhZTxXJJGodJSICWimK13V3bWxOB
	WPf8RGN0=; b=H6nDnAqbBoXaUaoZU7I3cio9Dpa5ddX1xQ7Axyyol3Z6dErOZKA
	Kps3VU+jne5zl5rf33pcOaA1jTRf+gFfwN6VW64mgRJQR2mDHUsrmoeDXVlqgkCg
	SQCTuy8NPt1wKetEkR2HO8Ad1Ru8dbXP4LyLKqtreDmEkppPleo+5XOJx6H6zO8f
	7A0TGKac7qUMpZ2AUwIEKcwZEQpQMgVNkxlRYknX+elT5PZfCKhUCFEXJFyhiY5S
	zD++Gjrs96Krzo8JJgC5RFdOAXfutQr+kiui4hxylThyoRH76RF8K2MBJajsBynM
	4b7V9EoIWhnaen7YjCVL//Nl9c6/547QoIg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791183461; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:XJt5nbj57gBd+ZLdY90pCSJn11GqzH4XkZvbNOrG+66u8NN
	AVFFDpkikITtyTGormQ1l9ocYpPlH/3PiJn5RHkflhCQ711qpafLjr052FmBf7e3
	Cft/XI1JuS9Z37thQbp/N+TPVX+Z0XjwORePdrA4XdTtvppuqattOzdRWHbYtyTY
	9SBhbXpBsQNtt3bDbhHLUPN90TFSxcLcOYz9DTW83cEVV2R8imo0OQJqcNB6WVaT
	KVmrOI793n77jKZi50WByYzZgeSsW1jeKkDkWpNwEGM0ELjzn89ZxgR2ggKIAUk7
	6QXNThpU7VF/AwaSe7GBh9kAtyJbc93p5G8QwNg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:qaP0Czi6Wcrd04C4o5TDv43U2p16roObUsdg9NIySKw=:gnt+5y1fgPG6SNrHu1kS6IcdogDyZfOUmKOcO4El+Go=;
X-ME-Sender: <xms:ZUrDaiwUsycacOHHO9NAbuDG2GjZ-9zkMgXSlv6uNP-XO5j7GW24_w>
    <xme:ZUrDalsWwT2hzjd9vSa2VohErp0q7Whj6A5WY6pP9gd1m02V6s_crM-niKPzKKTpj
    gSW393i87ja2x97pNgQmr4pwoFlGf9Z5CFkOYXAc4AQuQhQ-ahurw>
X-ME-Received: <xmr:ZUrDahtPrn9gIvE7TjEjC8fmNlgprd8FGLI7mWT2Qy4UtjlNYASOlYbQQP98qYW-b8Jhqfw>
X-ME-Proxy-Cause: dmFkZTFb1DluFJCXq7aiPhhDIOn163slf1dZpQT9WY2SyV7uup16WoU7ESzvrt1UhnyeZW
    20z0uqiuHeZ7hsahSEbVWELp+MNWTQYgFX6iRmeYAw7D431wKyGnaBTP2Oz1Lu+jeOwH+q
    9wpy2vtRxok7B4Pu7mIDntuSJ6r5Tajabk9j698rO3oLLxMxRVrTh+rLCFpsAC2GS2ohqH
    B95oNRy0xqFZE7DiGOBxgYTgyY/uhzuyHme437us+q2ebyC4ILsnSqoDBl7k2zAwZoSujb
    9JAK3preqxElFOx46u6j21jk16+NOHbo5pZAiT+TS2SCg1vWEs7AHLjfjU8jl852xa5VaA
    mzmE/yd6LzlR/UoDa6X+KqYoveBUvNNQy/M77Lmx7ZiisPi5ysZ6iKtlPy4Jcfbv5qDHrf
    LURl+2YDTfI2L3lVqX2eahK9GW1JH99qIeeenF7I0hmBc+Mq8LN1xVXQp+iyJWvUchKQom
    x12ovMM19VSJXoMLxp1H0RQ6mcUpDo9ak71oq8Y13EarhzpBLP8ZUyPegIsxm/dA42F0ov
    fAGCdgP4tj97VTKDCBjOJxpgOmeRTVNEoD5Bz2YZrDh2P7GmfTzMjTpxQfTkwO69yLe6bu
    Cc0qHJ4or9vTlmRxOXOglFwvGXcp1ajkW5qZNGQVNeyc2jolo3Ana3phwSvg
X-ME-Proxy: <xmx:ZUrDaiN0-De_15FJO8b4d3PWjGsjhcTbXoThP5qZNe_XQIo3tRZTTw>
    <xmx:ZUrDan1gxuFlbj2cdPFE-4JX4X8iolMHmp7TWPbgshyy6mKkeMXXgw>
    <xmx:ZUrDamPk9L93yqlPSLZJls7R8cy2qQ2zYkN8sGX2bJquZlkWrRcnEQ>
    <xmx:ZUrDav05jZO09lMAds_98HNMStVYKeyBMdK3pjI6HJO40J6smuW_Tg>
    <xmx:ZUrDalsgjX7Ws6sS1GpI_7DmuVtH2xfaCSBoqftRza6iWSmDY1mV2qEW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 02:57:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 24db5f1f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Oct 2026 06:57:39 +0000 (UTC)
Date: Mon, 5 Oct 2026 08:57:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "Carlisle T. Hamlin" <hamlin.carlisle@gmx.com>
Cc: Sphinx <sphinx9692@gmail.com>, git@vger.kernel.org
Subject: Re: Question: behavior when reverting a commit from a shallow clone
Message-ID: <asNKYAHSWJkFkhNn@pks.im>
References: <CALfz8Qx63qNoSbXq7C7u+KwX4=HCL7=uOUahpXd6j7KvW_c_Eg@mail.gmail.com>
 <54fac5f4-e49b-4384-af2c-615d7cc04ff5@gmx.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54fac5f4-e49b-4384-af2c-615d7cc04ff5@gmx.com>

On Sat, Oct 03, 2026 at 12:41:47PM -0700, Carlisle T. Hamlin wrote:
> On 10/3/26 1:54 AM, Sphinx wrote:
> > Is the following understanding correct?
> > 
> > An empty tree is a valid Git state, so Git does not generally consider
> > transitioning from a non-empty tree to an empty tree inherently
> > erroneous.
> > 
> > Git does not have a general safeguard that warns when an operation
> > will delete all tracked files.
> > 
> > If there are existing safeguards, warnings, configuration options, or
> > historical discussions that I may have missed, I would appreciate any
> > pointers.
> > 
> > The reason I am asking is that I am trying to establish precisely
> > where Git's safety boundary is in this scenario specifically, whether
> > Git itself is expected to warn about the resulting empty tree, or
> > whether detecting an unexpectedly destructive tree change is
> > considered the responsibility of the tooling performing the operation.
> You know, it seems to me that it should be reasonable for Git to assume that
> someone with the wherewithal to set up and operate a git repository (or at
> the very least operate one that someone else set up) knows enough to
> understand what's going to happen if they obliterate the only commit in
> their tree.
> 
> There really is only *so* much holding of the hand I think we should be
> expected to perform before it's not only insulting to the project
> developers, but also to the *user*.
> 
> My two cents. I know folk use Git for all sorts of stuff. Just, maybe... the
> sort of person who would be surprised catastrophically by this behaviour...
> well... shouldn't.

There really is no need to be this adversarial to a simple question like
from the author. We want to be a welcoming community, and replies like
this are the exact opposite and will drive people away.

Thanks!

Patrick
