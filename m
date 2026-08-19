Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4CC339398
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150896; cv=none; b=ed4Tv79WeBEgiYLoVCMpuQS7XZQizfUB4dZpGrAAX+5fT3MbGuhJOjw7k6Ttru+bFKPomesyNCaiTIBdxwCU5iOREYJiWoIzsI5CDPlDU3dhFPi47nGWNeWVlH0WHE9/dQ0LPPPuKSI7QAuWz/46cSoM3wrLAO+xGZW9cWN4A9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150896; c=relaxed/simple;
	bh=Y31rHdXRsEDOe9irPBRJ92PAfqpdYJq+DBmuIz8du7k=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YQ4X3syO6dY350W31BVU8dYHSYGmJtgn9NboaK6PzAFuGJSWI9nYfQ/JfLZ4bSQabEsyba2aizDYGBnsPGpEJN4Mlhkqa32+4DSwYcykRMkRHkXkHYjLzFP8hdJS/eXU8S/TUNIhcqjFzcjyiAvmGe+lzvSktV5/uAdcv463Th0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HaYPJcHa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kJI0C7Xw; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HaYPJcHa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kJI0C7Xw"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id B6CF11D00150;
	Wed, 19 Aug 2026 10:48:11 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Wed, 19 Aug 2026 10:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787150890;
	 x=1787237290; bh=Y31rHdXRsEDOe9irPBRJ92PAfqpdYJq+DBmuIz8du7k=; b=
	HaYPJcHan1YFTVXgzpK14iOXAf7uAGGA7xc5M1rbOg6nYyAzSpSte5gNkn1AiDJW
	ZmapYFVLPJ8m3xM+XAvEDevxUffgzZyWEC3jeRPb6JVdFm/jqS5vaiKET4Md3AIZ
	HTyCYOsKm/venz3K145zKmsmqeV/CUvZnthcVZR4pe/JYSaVW//v5V06jIWH4cvz
	QvVama5kDXxt4dpC4FYpX1So8bLdflbTmS9X+0uMBlbeXEbA5RB9DfUAIaptQ3V+
	3KDTKyi+GDP/GPgHnuumsg4t4yZfuV+d3dKw7pFBY+aGWfDuKee6RO5SIiXLY1dQ
	WbDORkue+WiAV26UcZ5B+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787150890; x=1787237290; bh=Y
	31rHdXRsEDOe9irPBRJ92PAfqpdYJq+DBmuIz8du7k=; b=kJI0C7XwEdbyRDId3
	gCBpSIIL2Sko05+kWUB3j51R6grtrD/HHu3BwGSBkHkfTDeRBqKsgInkkf2aN8Yn
	s0Dz3g4y6J50QdeWUtg6aQ6rsSCYSIAqmNDoPZWccDDQulFQ0izeF9iDO2BB2ChN
	DV8xKytw6OXJIszrHFnNvujD1yW80J6i5svCQqITiiOCBF1ZMFlSCrsw/M//9kDh
	2vgnSj8UAAR4GJSpyR3JTtbYlO0+0dUUdy8YkHwgCysWehx2Cf73SqwydMiFwBTH
	RrPEhc413zfbJYO8ZgJZy1MYTRfvwB5IyurE/1qs+pJRKpl+UoKzKdZ5ERGV9u2U
	2oXqw==
X-ME-Sender: <xms:KMKFagirb-w3ZpNSrbsElb0XHYrCfHigQz93VsHX3HigpCu9rtAjuzY>
    <xme:KMKFaj3WI3axFC5JpddtuCsC0mZpX2XJCMFOFDX1XnLsjcRt0rcbHH_nB5Dgusopw
    hF0dD6ztXcjsGIR6eugcbFykv6uicij1ofY9XLZ3XTI3P1eJV9KdA>
X-ME-Proxy-Cause: dmFkZTGC0MfSYlbBI0KYixgpKiyOID6Xsf8sLXP/wK9Pjkj/FZ08FWdqTP2+O5dyDkZER8
    F4sB/QVfIyC9hXjFoV30Uy6atlDHOTSmTPWJ68yDizGCyarfNk3Bb+nVmZUMcZvqMW81HK
    5a4q4Asi+VdDroai2Re0oEbv5alURkRd97lMCHSgKLU0vxbcBehdCkMEieJpsVwqFQWWGb
    NcrdMFH0W3c2JXa9r32ABgwUZIMKwAEH36q2/2w/abI78y5Cm+AoN/qU7b9xyPf96j1Nkx
    lhPKvnBK3Ppwpr1iyN9dJwtn3dJAcJmzeyBf22NPfFfpo7U4whs73law+RdK2Q/VGnnkds
    rFDChLj7q+fzxfZ0CSSXpfUEtdXea+vSpmiAMPgfp/H7OmNajh7WKHhPqwEV4tJlE1Jd51
    hFr61MUfAlScVeE3f/EWrqFy7u2g+ImOf9ggLRHitRRfiCOsurHJbHIz/nyrp952AhGYLw
    27VIE0dvUMbZZB5+fwu6ad76SveIr0PPBAB/0fbPjoxYHvPQyvJMbz3oqGWuLFYTBzlwB0
    0tfkGokg4L/KoDSqMNsXUbPz2zQXwA4PM/p8H/m/1ZH0DIG6kXhofGFBkkrfHCvZ165f+e
    W/0iOP+Vx8Q1UcS2HoR38RnA+LixQN7b9B369hfBFkuwKHhobDMPrsf9Z5og
X-ME-Proxy: <xmx:KcKFajPkmmI7EV9sSmcFV1cCQEJtKPt9fO9kTP1EPVtOdU4vyDp0Rg>
    <xmx:KcKFar5E1-Vkq8xtmt2BaGOIdQM6pU_Sz-DsWhX_e0pRso4D1JLdgg>
    <xmx:KcKFap12WVEwLJgTBAPm_DH8w0afiym_wjvr7_Wq7jyuXYzBXqsCNw>
    <xmx:KcKFakZ6_B9RPUtHNcvrAxkZCsekSUC2562PkRfLPnpNQeDFMhkmNg>
    <xmx:KsKFasnkbxHQRJFGUS_or-bdGXFrQtlhI8yN6ALpjZmWl7AJ1ls9DoiG>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 36D9522C0078; Wed, 19 Aug 2026 10:48:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Aug 2026 16:47:46 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Karthik Nayak" <karthik.188@gmail.com>, git@vger.kernel.org
Message-Id: <b81a56f8-4bd7-4b48-bac0-f60bb863e5bf@app.fastmail.com>
In-Reply-To: 
 <CAOLa=ZSN+h4TkZrqPPRNZ58Pyfamv9_tM=m7W8_RYhUU0p0q0w@mail.gmail.com>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
 <7dc975d2-324b-46a4-a389-9af96f4d5d57@app.fastmail.com>
 <CAOLa=ZSN+h4TkZrqPPRNZ58Pyfamv9_tM=m7W8_RYhUU0p0q0w@mail.gmail.com>
Subject: Re: [PATCH] hook: introduce the report hook for git-receive-pack(1)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026, at 14:11, Karthik Nayak wrote:
>[snip]
> I will add both of them with links to githooks(5), but perhaps a clean=
up
> there is in order. I would say making githooks(5) the canonical locati=
on
> with git-receive-pack(1) referencing it makes sense.

Sounds excellent=E2=80=94thanks.

>>>[snip]
