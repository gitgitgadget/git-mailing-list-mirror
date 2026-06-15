Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC423F482D
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529445; cv=none; b=ItQiqnIE24sRXj64GYn5oy45QdDf3cGaMG2ISf6wXLnzYiK6tFQEpfP+yC+DmSYnj5DFPqABumlibuZxVUPKce83EUO+TfEIbnWh+0gNoL5/vKLRbYSv4XCL/Gp1o+DqOCQxQbw0WOzJuQaSwArCk+0gKLE4fshVmpbtMDmf8Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529445; c=relaxed/simple;
	bh=lwvc+nbIGTcKwe4tvk2x2f4u8cUH3/cepJ8htEJyseQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiUYbOgtU7UVX/Tclhxk+htQf7L6EyJInvA1UtsJ7QdvtHycaxJ8s9A9qn9s2uxeCs/lU0Tt5awfqtig4haUXU3VgBnMauRdFO/Cix8dYKj49nMeMWLYuCQPph+J5G5XCsYNM71M8US7Cs80NwAu1Zz+bk+2y39cpZLnHxWRy9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c8P1ADZC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MBP6mN9d; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c8P1ADZC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MBP6mN9d"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EB9461400060;
	Mon, 15 Jun 2026 09:17:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 15 Jun 2026 09:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781529443;
	 x=1781615843; bh=HFyiU4gWo3ls0DDhllrDJWUbjE+dEQkmkbcNgCx/jP4=; b=
	c8P1ADZCYEp1H2vYgtAPRwZayWOfZfMOvWVn/GZEVzj3bfrWe/GfKu6NrrIgiHNp
	KTRBkNe3ZBgIw+Td1q8eSiPa77NyQ6BlElJAxO2RErKfCM8HCBRPKjpJbVDuMg/h
	xtPjShjCEl3mWHIPIFhrMPenpZhVPIPmROzABrD63IJtFgYWqgkiIhwoiOhmIb4e
	9FZyP2nm1yszonhaauAoiN3NtmD6eb6RByVgAvQNC1fSUpv6fwZA1MTYuN1JY4XG
	qlPpZbrPOOeoWUgo2fAc6BrCFy1qSvnPrVRyzJiMzgpIyzyCxkpGxnGE8QrlJUar
	YEyazKCIZqgS94DmIQH+Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781529443; x=
	1781615843; bh=HFyiU4gWo3ls0DDhllrDJWUbjE+dEQkmkbcNgCx/jP4=; b=M
	BP6mN9dcgi5Xc3Co9JMpH62ovN5qr6yMzuWw6xnQTGvTDM7vEcqWFRyeeA4mXyPB
	XxbWmBjk9D7/GcRgnWEePiheBTJdiR2IzG8T3+nRVIDfc2SCCtLXhDQnGKR0c3Uu
	1EbWcALdnelZ0nUiXFdkOt8IylN75k3W8Te9d2n1MWgbUQ4YUHpYiL1A9xKIrX7L
	9EF8Nff+BVYrTnGZ+X+5AQnN3/YIRZjHSUVflAk+PKAuBqymKdbzDxDn4LHXZWSP
	okQK4KLpnIY8R3MHS+8punHcQwV4XkhKuJH/TqNFxO2OOEAb7z9MCNoNbfF6irll
	2A3dHQOe7Ve4+M9HuHUpA==
X-ME-Sender: <xms:Y_svas0mw5W52avDxgjAtK6ZEfbVlHUd3OHxAeJJYO7ZusMusruY-w>
    <xme:Y_svauiqwVXGFSSzTFQVfZ5az4ZIOVHaAGYk-yH007-iey3FzRZpex30FSbH5JmdN
    Mjf-d_bx6DQEIRlMD1UPJYYYapjrq_IV2kdM6qZIqKUKfPyevoyFA>
X-ME-Received: <xmr:Y_svaiQ9YHWcMOFgAjr35ElJ3rd-cW-WvmYs7wDvycSWFlm9JHO0OuRxKMlcW1KdnF0j4YEdaSEblA3CK8fiwvgIr3kdUl00sJPBmG2dPg>
X-ME-Proxy-Cause: dmFkZTEV4z0I7xpuo/meoQ+AH6hqSVPXRPSD8RophYBKyKQ7LTrj6Rz7Oxtnhx7OMThmDa
    QJNJoDhoSwqFlYaN3GFZBIe7MCGYCrPLBUofHIZwhY7CxAs3CG/gpPLvktLd8QfP3WAP87
    MK01oJyFiwrKVrxyuL9/B7y8ImvpAVBRa1Qsm46wBOTfF+LK9B6uv0oeaDzKatIc5T+80P
    qvVu7u88WMMISF/87BuBtkPXeZ1h5CqqYhLzTQpHGiE9Zdl24qptGlf0vpMz/7OygS9LaK
    AhMZvYnDkXKOrXdNBL+sPHcDiIPGj/DyoRrwYV8UFOvEMUw1vGEQGv1Gx0TXqVfcls5LS1
    Tk2mMbJ+v2KA07oNsruUz5x9oegkZU/ZErkV0x8umw0NOxQl/Wxvyja4hwT+jB1A0JnLG+
    mapI0Z/xGcFuCtWwJxR2yozsTJY5E1DMeOIGgGqwHfB0bXtVwzajFYMiyQrCE0Ij2taenG
    lQr543GF5DQO+8xRyiPei3nkcGFoodzKOjAk9V95q/O+PfLQ55gMc6TjbHbF2XIoeyYu5j
    kIVTAXgA0MSxS/m4cForZZL1IoywXb9+gvaRKshLgfdE52SMCkrfGKLiQucpNSkdQmJJ2n
    Z+vos4WPPV3XUsGGDt+YQ4T9imDFhmdawYUJVxxF9og4tPHmONMv9ZXM5A9A
X-ME-Proxy: <xmx:Y_svavjj4u6Si1v6nxZOXNVC1QJSLi6uzLPiqcCjrvFVI_WiyuI2aQ>
    <xmx:Y_svai5cbTJUoMQ_ft5HHDwsMiTR03OCQfJJRcCrt2h_MX6Xj-dnog>
    <xmx:Y_svasAUW6Ljk6zenDRYvCFBiChDtlLBjzQmwnjb5ZXt_zpIe_mopw>
    <xmx:Y_svapZfPwTPapxqfYmu1Pbd1TXJmVooZh4w0NoXS4if7AetF3qTow>
    <xmx:Y_svakLwXqbbLfuSCa25O61d_zTAiUT50mllazhg70fmcarPdWx_uBH4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 09:17:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6384a924 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 13:17:22 +0000 (UTC)
Date: Mon, 15 Jun 2026 15:17:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Weijie Yuan <wy@wyuan.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] doc: advise batching patch rerolls
Message-ID: <ai_7X_QY0u1CWJ7s@pks.im>
References: <cover.1781358364.git.wy@wyuan.org>
 <8166623d1599fca2cd4614889e4a69b2006c12c1.1781358364.git.wy@wyuan.org>
 <xmqqwlw2e8dc.fsf@gitster.g>
 <ai2NwMS-i_UTWR5T@wyuan.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ai2NwMS-i_UTWR5T@wyuan.org>

On Sun, Jun 14, 2026 at 01:05:04AM +0800, Weijie Yuan wrote:
> On Sat, Jun 13, 2026 at 09:02:39AM -0700, Junio C Hamano wrote:
> > Weijie Yuan <wy@wyuan.org> writes:
> > 
> > > Contributors often need guidance on how quickly to send later iterations
> > > of a patch series. Add a rough default of no more than one new version
> > > of the same series per day so feedback can be batched and reviewers have
> > > time to comment.
> > >
> > > Mention factors that can affect the timing, such as series size, review
> > > depth, substantial rework, and how close the topic is to being accepted.
> > 
> > Another good thing to discourage yourself from rerolling too quickly
> > is that such a practice forces you to think twice and be very
> > careful before sending patches out.  As you have only one chance to
> > get it right before, say, 24 hours, you'd want to make sure that you
> > would not distract your reviewers with stupid typoes, off-by-one
> > errors, and such, and concentrate their reviews more on what matters
> > more, i.e., the higher level design, choice of algorithms, etc.
> > 
> > > +This consideration applies not only when going from the initial patch to v2, but
> > > +also to later iterations of the same series. There is no fixed rule for how long
> > > +to wait before sending a new version. A useful default is to send at most one
> > > +new version of the same patch series per day. This gives multiple reviewers time
> > > +to comment, lets you batch feedback together, and gives you time to think
> > > +through the comments you received.
> > 
> > And the 24-hour gives equal chance to comment on your patches to
> > anybody no matter where they live ;-)
> 
> Thanks for your comments above! Let me think about how to integrate
> these contents with the patch.
> 
> > I see you CC'ed Patrick, and I am sure he'll give us more useful
> > suggestions than I do here ;-)
> 
> This is his practical advice, and I just stole Patrick´s wording, to be
> fair ;-) so of course I should CC him and let him know I am a wording
> thief :-P, hope it wouldn't disturb him ;-) 

Indeed, so I don't really have anything else to add here.

By the way, talking about mailing list etiquette: in scenarios like this
it makes sense to add a Helped-by trailer. That would've serviced as
hint to Junio that I was already involved, and it gives credit to that
other contributor. I myself don't care much about the latter part
anymore, but newer contributors might.

And no, I don't mind at all that you "stole" my wording. Quite on the
contrary, I'm happy you picked up my thoughts and cared enough to put
them into a nice patch series :)

Thanks!

Patrick
