Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0382A2EA48F
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 06:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770359503; cv=none; b=FQPEnNu8zoaeBJoCjmN4JRx8ZfoRk409waOc5Yv/KXMpS3dBMqTVlmLb4Kce+nI/LiFnCcig4nwwqW+JTtimg6WhoBbkx7mAv5f8ehgmM+bVC1e4yq6jMW1tSNh4iuKTr/PoY6EeLSxYPfocKrGxwIH6t8u1PD32hJW31+An3I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770359503; c=relaxed/simple;
	bh=8H2XGUlJvsP/XBVJ6cLkNC5HBuCVWHkllkXryYokRyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q78Eds0nqY3rzrCZIDviwFAouiDdzqUTEntRc6QS4OANn9fYaVCT0Xkk7+pgo8kZeaRMYJJ2Ojk1Nxgk9C2893OXHyuYeaYzQ2N5LtNmyaCf55Pu1RK991dAXtxk7Ko03bq4v5tr+KT7+1eHcRLph16ZzD/Mgeb6SMDX3WBCgD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SwUrv9N2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lBXJAqWd; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SwUrv9N2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lBXJAqWd"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 358797A0018;
	Fri,  6 Feb 2026 01:31:42 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 06 Feb 2026 01:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770359501; x=1770445901; bh=du8/k+ThsJ
	UQLrPLjVnjHSiVvEq73Mpz5CEbyN8BjPE=; b=SwUrv9N2RMzRH0Wp1KWus8G6QS
	kBd+GqQo/+B4omBl0xeA/mTJDAoHmPGJ/q0FGs4GdbOk6wZZNWe817F4hTsETBoH
	MJEQPNrLSa/gsx+3Fi1DwScC0x8gfc9IY4RmbkUB53AA++f+OAhbNHivrL4DrV+m
	dmc5NWuE3yypvOUSI+2K48nep3VUX/8vjEagKe0/c7lz1lq/qq5qDxPO+lqTiT3W
	oMGdG86PuR2orymbY+UFbdVmoXSeZ4kHfGhNtIgwGS5vuy39AFsptyxudiocqe2f
	6eBZheLb3XdQ0G7D6VSynB2bcnS5zmwWnv5vWUdMOgnyX5/UsNizSDA5nt+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770359501; x=1770445901; bh=du8/k+ThsJUQLrPLjVnjHSiVvEq73Mpz5CE
	byN8BjPE=; b=lBXJAqWd3DYb3E5cJcoW+IsQerjwgNWI5jH03CHgRmbjZWPGq6/
	geUEf1BWZvaBC43nDqOqrmVaHxyDaaIQX6aJcg6ImrEwu3fUvA/ReN6JCQbsW1L7
	OVlFdkvOWfIckJUUmudLIeZTgQHSBJXAYTMLWAelvovmuacf4lo4E2W4MZFYWYd8
	pWZIKnQDlYkTa0o90QT30pSawhDUIfotvKK967fw0GmhXL8oyaOL3RLlfkDo7tJ0
	ZD69d49oLdayKcIeaRMGr3NGMQbM1M6t9IuogvZoj2rMxNVZZwC3uGnLtYuaBIGs
	I5JPqMcSpEBOzgjYWcAzrIotA9gN0rujy2w==
X-ME-Sender: <xms:zYqFaQ3-6L51TMxizFW_qjb5nOQuOPds_L9CGv-eNN3EMJ9KL8HqTg>
    <xme:zYqFaRF5A_DUe5mIL8A4mfu9dJ4_Em6NjDWzULzWbeVUvY3A7m_YH7FiUVZSQPjN-
    -etmGdh8EYUVIEXnmMbIuqEpHhpC8imMeQP2Y48aRqd2BaF355RP3c>
X-ME-Received: <xmr:zYqFaWjINN5Qu2LzTvrTa3iX7JY7uZTCfg1tK6bB5qgm77-M66tavKONAKdPxeU8GRglDbHXe9VGLtKzY9TCB89_s0HX3rrfh8CN3ZVQHeI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeejgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdortd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeejtddtgeffkedujeejgeduhefghedtgfdtie
    duleeulefgueetheeludegueeuveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:zYqFaU8NQSBwHGustvh0zg2ChYFdV1Pbs7FRxIZSLYx_o5N3WztLFQ>
    <xmx:zYqFaVoiQt5SpcjpauawSfJQruFrzFWh4Wc1coaxKjMgU8zSmmDTzQ>
    <xmx:zYqFab9nlWH5vcsheZHmXYx_dLSbxCIymt1FO4Qopk_DvxZBFfd64Q>
    <xmx:zYqFaRV5e-nex-OLwr1egM2R0JbYaQkS5PuS4HV4aPlyTv0AXTG4zw>
    <xmx:zYqFacMWn4EcT5XVjsHZnM1FGaKi0OA9NNjOuPssNHgG61LMDKnC7_p9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 01:31:40 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0689a5c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Feb 2026 06:31:39 +0000 (UTC)
Date: Fri, 6 Feb 2026 07:31:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] whitespace: symbolic links usually lack LF at the end
Message-ID: <aYWKyOIMPLiDxqnj@pks.im>
References: <xmqqecn0nqyt.fsf@gitster.g>
 <aYSLP1LqBiMwur3O@pks.im>
 <xmqqms1nmbog.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqms1nmbog.fsf@gitster.g>

On Thu, Feb 05, 2026 at 07:50:55AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > I'd suggest that we only disable this check in case either:
> >
> >   - One side doesn't exist, the other is a symbolic link.
> >
> >   - Both sides are a symbolic link.
> 
> Hmm.  That is indeed a thoguht.  But we do not want to complain in
> text-to-symlink transition that postimage lacks the terminating LF,
> so the above rules may be a good start but will need further
> tweaking, I am afraid.

Ah, right. Only the other way around, when converting from LF to text.

> > Another question is whether we support symref targets that end in a
> > newline. I guess the answer is going to be some form of "yes", and in
> > that case we could of course loose some information. But honestly, this
> > is so much of an edge case that I don't really worry about it too much.
> 
> Do we track, apply and diff any symrefs?  I thought that we do not
> touch anything inside .git/ and symrefs live inside .git/refs/
> (except for .git/HEAD)?

Eh, I didn't mean symrefs here, but symbolic links :) Tools like ln(1)
seem to strip trailing newlines, but if you try hard enough you'll
probably be able to create symlinks that have a target with trailing
newline.

Patrick
