Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AB4480DEB
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791204082; cv=none; b=rxLq5OmmBhTLpk9zmPHbLyhGU4GhCSXICFlb9h1w2xvLUjkQjse2n+hqm/AZ0Wk62HTDDpgRm72x6Fh0EgEBSmEaObRYOfpEbKJDxGytrr6k8EwLLRmKiNMuPZx68Rb9JnQPnu6J8rYn357TsMYUWDIsntSIg5hXb2++P3oVLj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791204082; c=relaxed/simple;
	bh=EbMJRIe8Lu4V04eYrwT6HjHdh/yGjB4wikp1BLMyDAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4+6FG0Yo0OvIox32NWI69cqkgNUt8HtaiIHM+vDISfUCD6MSTcQvcmDYUGN0GHoAhziNsXpiFNz9+TCaCDHjViV7tKmd0O0dER/+lfJmK3D+wKJ6EAxPmkqaAvJqUhHSP5Ek5F1YBxZiqZ2TKVIwrFtkIGE1eODnQB9YF3D47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pbbnkbd6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cycB1w5w; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pbbnkbd6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cycB1w5w"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AFE06140015F
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 08:41:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 05 Oct 2026 08:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791204079;
	 x=1791290479; bh=TXlndN5AsB2nBdP/pqp6VkNf1gMaoUt7o35NRsgXuI4=; b=
	pbbnkbd6Vf+BtVl/qm4Wlsvb5gCmaPnnC0CXcWrOB8zo8iks+UIGlNbYwBVkFMIa
	RjSX7gmse5Whq2gamSqNSPQWasHFyuprjQvCVgmsyGCPI00opdDknrJoaTwsawNd
	PFoUWm8TzLuvNMLeBJx3OvaXP7C8jMc5vNEt9ZRy3fGuES21TVeykVvJbcQXoj19
	IeX8/BM9dbO7sLcXYnielBKIoChLk2KuH+u2Beq10wqiGMwRUToOEjILEP4R0KTX
	aZhWzScwV2SdYp62JWqsexF05mjloQu+IWS3NCCYNKToqG8S3qrvYutEfOdSwP2a
	9DUITtnPGjibkL1J471e/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791204079; x=
	1791290479; bh=TXlndN5AsB2nBdP/pqp6VkNf1gMaoUt7o35NRsgXuI4=; b=c
	ycB1w5wedOCzRu5W9ns31EOih+fOSgoIs+MdGoTxL9hEoZkzJUmrPWdFiIWv6uRt
	hizF0eV+MNomqsoJYLRQrKgKJnW/Wof8D3VuVFdehWKruCJSU6PphDED2dfh+6AY
	sySnozoWYhannWEVR1AORKYK/65XdODOryObeROUJrBp0xeG7+5ujcumIi5bz1VE
	gb3ALD0dweAbfOBFe7q5NtwTNJ37Ll41B1Tu/qCtLgfeESAN3IgXFtgr2uwa9IcC
	LLJn5X96IIiY2g1Ap5Po6S6vynm31Fr1kVmjDbRNWI6PZUhdCybXu35r6CrZw3Qh
	4ykzfdZGptVdt/mWmrqmA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791204079; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:b10aq0nr1A6vlU56GKXWtoLvs+Fmomwx/A+/o4PwyVbhvTC
	b7SBABC2g7l7TPWgjUkt4GnKFGh1R2MAXUcsh1JYUmzXWs0W3XhVe6K6FiiS6gOP
	hT5a2dukdL3MtWDSw8Q74z7/gTIL7lgR+kdNXsq1RCgnCKrHpJYKcPUIlHF43lwX
	CmkhwschSlkP9DurAxuzZ3iLouJOvO2shdk3AOzEF1ig3w7uG5zTJquhDVGlf5Vg
	2MlHZLjq6HvR9IXFwIuo+66CfsGl3EA5kTisCkArU+zuntUw8//3E8KtJUYGUKWn
	ui1Sg/KFo/UAdtb8yIZTcalJ1O2o+Ulc7+DtROQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:QhHdF1+hCgsuKtKx4pZM7nFbiUxvo4kWOQ8p4vLTCdg=:EbMJRIe8Lu4V04eYrwT6HjHdh/yGjB4wikp1BLMyDAs=;
X-ME-Sender: <xms:75rDalGwF0JqY1Ei7T_Txknnf87Y_SiS08KweyJ3fdvoD0Ney8yAEw>
    <xme:75rDahWZWZiYE3wTUVIYwTmHtB3rHNOga5MdZ1RqNDxseGY1oeTdh8iIJQs7PjJcL
    eisvHN2Hj1WOzsH3A7elLs66BnkoNpJYSPuzd2CfihKwS-yYacxU0g>
X-ME-Received: <xmr:75rDasIZ9SDOu73-sXpO7BPVQwlVlD0Wx3WkXk6gBONRbkda_UGQQ2MIGnDoF81zRxXdM6E>
X-ME-Proxy-Cause: dmFkZTEv1+a1nkiUme8WFkCr10o4aIqmx5i/5NMqW/yQ4xGOdwnUzsnH1ZMDGHyr6KVe29
    x/6S785OjC1SEt3N9tfGZ24jPDFqnoKTJ9CLF5o7pD5aOEIC6zClIEuASt6khoz6Hrucy7
    Uqt+DsHZlf4vaFXnQz2KwHzr6pAnD72JD3DfvmT5Tqv2yl+Nl1fiiAWQF8TpL9nl58pVOa
    ftO64Vlwo74XKh03gCLZ9ufxDjJpDXXlRfFVIuZznLL8x0Y/RGfcPIbn8i/YZYF4nnmPl1
    k/qqMx/2oJF47p94BV7zzWAy71Llb3c/h73Jt4z2jtzVxgM/fEmYTDn1kgiP0R/45+VHT5
    k+qKtvj/QZ8xLZNOEt/AUuh+ftNzoyYNh9pvIgJE3/PIg5oGiBpTDKkroEqU55YLDq6EkP
    m/z++bMCzpFdSBpv98HODkSzq4TxYP5i9BBztxBDSQw2SpxmP6wqIYHUerfcVXbZ4IkiGQ
    8snCFST5qkDSFBxFq/2J9caqATDNS/LJ4tAVLhvLnCeKvM4aC1lvub2DirmR6kY1/OtOjn
    pQ2lTZ9tNwMiSJ5aEtaWRSWlRUbXy6eluWB683ztuNiPwVJgAv+eWcVXYZUt1u/7BrhHF/
    noPF5xxTIM554D8A7M9kjk5K7Ud+sPKNwrmkxyLXEwZzTNvX5zuNnyoO3ktg
X-ME-Proxy: <xmx:75rDap9ReBEQDmXF0ZUSy92OvuEjB1PXsTUXtGPHaHK-FYV43WzFYQ>
    <xmx:75rDanLQZFfOETRu4UR-AoucxLOWP-2K9gjG99pmKA6c_UPHrIKQWQ>
    <xmx:75rDaml64RzGXGXobcarqPOQIj_clcwEsmqI5Rgl8MLswoZL5PTm-w>
    <xmx:75rDajOIsk5HR5NU6EvolErpz8ZF24-sS2SbjQI4Fq1ONJt-SviNdA>
    <xmx:75rDaqlRer4bxJzJz-JbzAoYS9nw54RV1zUbXnhy11AoOF7rH9eiQQSx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 08:41:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9a80e706 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Oct 2026 12:41:16 +0000 (UTC)
Date: Mon, 5 Oct 2026 14:41:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Scott Chacon <schacon@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Scott Chacon <scott@gitbutler.net>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] sign a SHA-256 digest of the tree in commits and
 tags
Message-ID: <asOa6dgpj0qV5QAU@pks.im>
References: <20261002081846.25144-1-scott@gitbutler.net>
 <asAAn8NZwB29WhGR@fruit.crustytoothpaste.net>
 <CAP2yMaKF4CRvtfTQDVe51SqEm_DnoVOmED5kcUSg7UvLkBp4Xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP2yMaKF4CRvtfTQDVe51SqEm_DnoVOmED5kcUSg7UvLkBp4Xg@mail.gmail.com>

On Mon, Oct 05, 2026 at 11:32:54AM +0200, Scott Chacon wrote:
> On Fri, Oct 2, 2026 at 9:06 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > On 2026-10-02 at 08:18:42, Scott Chacon wrote:
[snip]
> > Every major forge has support
> > for SHA-256, whether publicly or in preview,
> 
> Nobody has access to this for GitHub, which is where almost all usage
> is and where the kinks could theoretically have been ironed out. If
> 3.0 comes out in March, there will have been no time for anyone to
> give feedback or make substantial changes before everyone is forced
> into real usage of this highly incompatible change.
> 
> So Bitbucket doesn't, Gerrit doesn't, GitHub doesn't in any practical
> sense (I'm curious if anyone on even this mailing list has access to
> it's "preview"). GitLab has it under "experimental". I'm hesitant to
> agree that Codeberg or whatever constitutes "every major forge".
> 
> If anything, this is one of my biggest problems with this breaking
> change proposal - it has not been tested in a real way by nearly
> _anyone_, nor are major parts of the transistion plan
> (compatObjectFormat, pack index v3, fetch/push compatibility, compat
> sig verification, etc) fully implemented even a few months out from
> the cutover.
> 
> As one small but interesting example, I'm honestly fascinated that
> there is only now a thread here about the GitHub specific usability
> issues [2] with mixed odb repos (between several GitHub-y people,
> nonetheless) that hasn't been previously considered (the "limbo"
> idea). This is the kind of thing (among many others, I'm sure) that
> would come up if people had time to use this at all before a default
> switch.

The biggest problem I have is that the ecosystem has been entirely
unwilling to do anything about the SHA-256 move before we announced that
this is going to become mandatory. Only then were developers even able
to convince anybody (especially those paying the wages) to get the time
to implement support for it.

So there is some kind of ossification happening in the space. But things
are finally moving now that the due-date is drawing closer. I would be
extremely hesitant to change course again and drop this breaking change
now that there finally is some movement. Because the only consequence of
that would be that the ecosystem will stop working on it again. And even
more so, I would even expect that this will make the next time we want
to do a breaking change exponentially harder as the lesson learned is
that nobody needs to do anything.

Maybe I'm too pessimistic about this, but I don't think so. We've been
working on this whole transition for almost a decade by now, and only
now where we're forcing the ecosystem to adapt are large players like
GitHub even moving.

Patrick
