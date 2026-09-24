Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F032A349CD6
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236765; cv=none; b=SDnWJyAQlN/nvwS1OK9fg7EsvPFf0rahFJdafl/h8CLPR5A+taLeciUPe1GmJqlPiNtw9uXearX+ooAVLzfbS0MGJNVgyyKmEa/jRmoaz24hqP8rfvyZNeNh14XBlhEF6CMIZ9NswxYOeCGn03loKMfe4WTMpuS/Ay+Tph3CpQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236765; c=relaxed/simple;
	bh=0rjCfCOuPEhaqy19Nd6pkVzazcB+gkpHVPxyT3ewNdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwnIsukKerDa4yO3CWPviueW2k++0REuWQlFU64+Jd3ISoAXnPKrVzT4Lgl1SEtLrUl8cQRjAmmPLcrhtkS3JryOGFcKT86zJOelPBeB8BD/ajQdajeFWnMbEL5EqWpAXN2FrDBGAwqsFWsQsHsIIErEr3e3iNhxWsl1tjcYV1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=etcsJP5r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YsIE6ICG; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="etcsJP5r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YsIE6ICG"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 04A26EC008B;
	Thu, 24 Sep 2026 03:59:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 24 Sep 2026 03:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790236762;
	 x=1790323162; bh=IlxFHDnPbOYG53E7WQKXYVQu3MwprfQWA+8NZUQc+T4=; b=
	etcsJP5rmOOv1dibggvNi6J4bwoaHCBK6HXHD29iRrm5sY5GS3uK90YtZ/qwxYgb
	VL7pacSAFDMb0+/DEFGZGMirGIBWMfwEeN8CsvbYrYbqr+De2HHo8QDOdAm1fC/i
	VHvQMJVfX/KhKUVOnMgdR+hswZv0fOUaz9sH9ysbZZdd4jn7i+2U4gwH7PuPp2Dq
	G6mTOzBXe6qUFl98T2CvFHqxAZ8DIOawYoXEf0PzWCFFhP/+ofSsWKQqWZgPw5bs
	0bHavp1WJl0Dy/KjVBy4EYQk7Vn1fA+ypWXswDLOh806hRolYAQaF5bxHjpj5YZK
	NHhlhpZjzY6xL5Uwe1yKuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790236762; x=
	1790323162; bh=IlxFHDnPbOYG53E7WQKXYVQu3MwprfQWA+8NZUQc+T4=; b=Y
	sIE6ICGlQkJNj9ZbF81Qnqt2qonpH0yUN1R8K13VJiAJzZQi9vjeIVlEpyOwdp54
	S3K2lrLdOasjIz+oueORt5RpTXkuvPxirafEm8p/LKAU8ccm/ksDGtp4LfaqT5/b
	wc/3amW0iw0/ZuyxqineBWiIKPDFUiZYrA5+6hqxobVmpGdVkBss9I6JyTlAO06k
	RH+wioyz111v/i6xxxAld7TV9NxljZ/JQ0ow9HUayVrEis0RK7XKx4k384P2XAkh
	2uroC9mVEjcXKn8iYijbm+NRHRjkFVbYMGQvbKDaP5Q0WtPXK/3ISBttLB9vNzSe
	CmpOR49RhKZ/JmFr1EBxQ==
X-ME-Sender: <xms:Wti0avTqnRuo9iw9dlZtD2fPSMbESTVcRQyqITzeHCDi40mTGujyYA>
    <xme:Wti0akeDtcureHTv3xQhj0jmBxFVzXQ-trTKjMq_fQZIxBA60EHJR0Aa_JEmlftDN
    RX2zZ3W8frNPNyNZEwgg2JI5whJW8fa9LJoFBm6pRtASoGW9SHNQJU>
X-ME-Received: <xmr:Wti0auoJcrBlRYo4pR3DQjdSIAMnOEWSfsr7sual6xa87tu-bVZXSckEqZsSWOfByPfu73w>
X-ME-Proxy-Cause: dmFkZTEpxfVdbZS47uHbOTodQ2F5naJdt12efIlvG55vkmC836AQdOUqXGK/Pu/e0EmBls
    pv2VGu5mMMx92ORCnXE0mm3VTN6hC85Tx6SpP6ypfbe4z+Q7fc4f5GfYa7k7aFgRu4whNK
    oxROZZMHIygKWrSAtOYH1jqjxQsIm0IjDM0sXpAXxQVZHZ0053pc+WeWna7VSfj+1XWqEt
    xfbfUOSbxzfQT63qNwHjBRLqahci9eZBqZOlyywvQi9OL3rTqPkVgTT/ROrgLVgd9QRIHy
    iAQKx8ZVnc/P+tvfLUTzZT3NeFEJcybdQnxCrJkBXD0BTX3wXFQRhDPxPz736uhzxmC8nY
    QNGSdDhz7URFuW+iby/8AlxLRTCJSa5cZ3VCCLZrBnE2oT2e6yYzyW+psSADLPtv6OqjPX
    Tbz6aT49PLCB0bDH7riPxjBT6t6WT9tF9JSArT6xcJ4xPq/y5AdTMozSqKSIPp5cUssO/+
    xyzxvwC5a2yMLEDUXqBuhQ9B+a+BV/4ICe27TiFqs/nxK0BULj+uLPQ2VURgUyDED0jFsW
    qC/1W/jDU+F0L/XivXnCceu24yzbWxxSgzM9jsboKJVBWkF0sMV5t+ruoo+nPrl6YsADtm
    n0/mlUZW2NWLBgq63PET1dM4hMdMGYNIMaoi8QxicKHUiIb6m2Tyi6q3fgqQ
X-ME-Proxy: <xmx:Wti0al_kG4kWL8p_4IxwbXs4u4-X7fRj6k5z9Tn5diqqyQpy-KxwIw>
    <xmx:Wti0aqdlF8DQg2fOKlDTJAPKUcqUEI60ehYH1s9swBkpGjliQJ7rtw>
    <xmx:Wti0avJwbuaHuQzaPN5toQYnxRT1jrZRn_4HHcvQDBBlxMEf0Jb2Zw>
    <xmx:Wti0aqj5n18x7WgiJBn3mC38TkjDl2uvsJRQ0inUfrRsnApSTeQqsQ>
    <xmx:Wti0arD2Al6gwwA8WfrPljiMNp_fIDpjLeX7Mbl2sDSczBiaTUIrLcLt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 03:59:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 97a20ec5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Sep 2026 07:59:19 +0000 (UTC)
Date: Thu, 24 Sep 2026 09:59:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	graysongordon-gl <graysongordon1@gmail.com>, git@vger.kernel.org,
	peff@peff.net, avarab@gmail.com
Subject: Re: [PATCH v7] http: add http.sslVerifyStatus to check stapled OCSP
 responses
Message-ID: <arTYVLnW-2GHpGGm@pks.im>
References: <xmqqecfez7ie.fsf@gitster.g>
 <20260915162348.97792-1-ggordon@gitlab.com>
 <arQ/nOH+o3XwQFD/@szeder.dev>
 <xmqqwlsb63o9.fsf@gitster.g>
 <arTUNYVvCNwX1pDp@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arTUNYVvCNwX1pDp@szeder.dev>

On Thu, Sep 24, 2026 at 09:41:41AM +0200, SZEDER Gábor wrote:
> On Wed, Sep 23, 2026 at 02:47:18PM -0700, Junio C Hamano wrote:
> > SZEDER Gábor <szeder.dev@gmail.com> writes:
> > 
> > > On Tue, Sep 15, 2026 at 12:23:48PM -0400, graysongordon-gl wrote:
> > >> From: Grayson Gordon <graysongordon1@gmail.com>
> > >> 
> > >> git never sets CURLOPT_SSL_VERIFYSTATUS, so libcurl never requests the
> > >> OCSP "Certificate Status Request" extension and any stapled response a
> > >> server sends is ignored, including responses that explicitly state the
> > >> certificate has been revoked.
> > > ...
> > > This patch was merged to 'next' the other day, and the last test in
> > > the new t5585 fails on my system.
> > 
> > Sorry about a premature merge.  Since we are not in a hurry to take
> > this topic in (or no new feature topic in general), let me revert it
> > out of 'next' and give it a clean slate to try again.
> 
> Well, if you hadn't merged it, we would perhaps still be none the
> wiser, because, alas, I don't have the bandwidth to run tests on the
> seen branch regularly...
> 
> However, CI does, but I can't seem to find any CI runs that failed
> because of this, which makes me worried that something is wrong on my
> end.

Do you maybe run with a curl backend that doesn't properly support OCSP?
But even if so, our test suite should notice and skip the tests.

Patrick
