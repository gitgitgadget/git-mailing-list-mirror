Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A961DF736
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782300430; cv=none; b=OZOptCaOCLqZWB67QfBhxGc5lQ1qyMfdsjkRX5VNOHbzJWCF3JayrlrWKdY8adxzurOhWhuzoCQI9VwQd/co9+t8yDhff+2j9uf+WJM3qo0G83aEVObU/kJwcExBymmrtnA7tvVaYsbPIEie9WUfqd59dHslPgh8KYyMoDDB0Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782300430; c=relaxed/simple;
	bh=8S7cU83lmkITbKT2IZXm4qXAWwlF2xLsP6Iih3v/n/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDMLev6BLNNuuVo+lmQX/1aDXKzNrkQC/1GfYWk7CTRsUogB13TzGY9Q3pVbUj86pnlhj1xN1SJ+ZHAx6+NoSHcLQ41JcWEY/sEiC3OJMg0DEkKNpevTnQZxdeuE9yuFH0pN4vZ9aP4iNRhXfHOkqKqTvO0fBQ06MZFvh2+XFBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NjGwKpvP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fVvNzVUU; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NjGwKpvP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fVvNzVUU"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CA2937A0124;
	Wed, 24 Jun 2026 07:27:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 24 Jun 2026 07:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782300428; x=1782386828; bh=qLimLV6L52
	I95bG0wCgMFTRnxcHFjCDOAY++VFhAHro=; b=NjGwKpvP0TCadFtmjbLel1u5qZ
	t+CbyS4wEXPLNHbK5cOgJShlplPz1PL7aMSMja5YYY91+mTJCZLZUpt6SbIhvhv+
	mt4aASw1k5f+kzu/PYyUAhqx7bAwIMs/occHLJgMeEZ1Jd8kF6jmfJEMXnjedAPX
	O4hih8pvefK//mIwz8xCpKBThFUW4YtFZ76OU7mIb2cdpNxIViya2uUDPSa8E69d
	r1DAU73YeDLjAlNZhSk9cH5PZUE7Q7NG/xDcodfDiFB3tytNoKgDBGtiI0NWEGWp
	4uJGRx4E5gNOpeaxBI1s7h7OIttcO97pg9N1PZ0Paikobdvv/wsWPR9e6sgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782300428; x=1782386828; bh=qLimLV6L52I95bG0wCgMFTRnxcHFjCDOAY+
	+VFhAHro=; b=fVvNzVUU6GlGjp8niVMWTQEmtZ6IfGKjzEeCgsDdTX/Wm2waPQc
	BS8zp+tNMuNmo6ugNlaL/QxoKVYp61W4JHmrOo/91obEdWR/vgMl88p7d0lj9wAA
	2rDUaK/uf3E2mcLuXbIPv3QhZey4FEzykDMt3qIEikfrhfIIcvriZDILAdMFHQ+p
	bEPBL1Z5bKpvt6K9c9uofREKjv5c7h1Y5KckHRWH44JYRIYPOEnVFT0y/v9/wW4I
	EAdUIv1cw1LvVQ1C+pNpSNyuLqP+7x6zLsIMo6EaoFUY+DPRItzOMjWGUSWryiIF
	Pb+qzLumtdJ8wAkDTjqaH+o/OLb1sD/fUqA==
X-ME-Sender: <xms:DL87ao_g4Y9UFfMVZgXS9PaZIUzFO1UQqA8nn6xEx4B5Wq_ELTXhug>
    <xme:DL87amu2VBGKCH_xk1ym4FT-Om6ldJDxaSBBGCBriq7xZ8x5_xi7sfPgPh78MyQ6i
    HjnKB2fv2sowQ5gx3EayCow2ELCRXY9NyxHVFlFMjD895lt6-vaMw>
X-ME-Received: <xmr:DL87arrD4qWJdtEwVfUloM8pZH3ksBDtrEy24I-cPraNVZ9uuvW-ysYtsnvzbNtys71xQoSf0SkMgLO6SYEJnt7Z0lop_26PgN5F1nzn>
X-ME-Proxy-Cause: dmFkZTFa8DPUlgGsPzyj8yTTigxM6TrXEqQ5YXVnGLnYfF4lBpFGhZCDnZfhMYorthUS3h
    ltY27/J8cSsExGkSFIQLs+bcCNfoHpi+eqcVx31FDrhI2AQSvrhjPHlbtEju38Ox+ZGdTf
    WrOgb0bmpG6dhzZjS5qa7Qy0UCA+K0KL6Qbi/Pjvissgq4BOt0mOmSEaM86KsqGt+m6yfc
    3pjwlAclIY3/oFPfDG13eocPsAtOoNny/H/YWCGZszSD0exGCwdyet1ojyHuFgX2++jhbO
    8pP6Xv2IpoCg4Kwy/IhRQUGSgFR+M/8Pdvi8ak927LaKykydvwwCGSJkPa5vtBJ/nkxlIu
    XCwckWsMlG6RSZMI8WxniR6cLAoQIxSujAQ5cgIhNNzBn0Q2/VH3Gt4kY0Go8YSmNk7Qv/
    F26iau0N9AHMfRZjRgnxZcGhff33wdRGbzE5G7tUGzXWGje89cWXWeHjBDdyy/Jc6WIfWn
    R/cGZomh/MFu+gKgbcVM35TaXFX223HP7v9ajd3oJMd38iVjkPS/qyTZIXZMVRt1l9uaKb
    U+VhbpyxZWSnOnJtBhTTGXW/ua1bcn2GoXRGFuRXP88Jz+obb867MlF7dHkOkM6Xm8bynK
    X94NCZDULTuQy05n+O8RoHMxKGidqPc4v/3I1znmC4TRyiHsi2Iq103qu5jw
X-ME-Proxy: <xmx:DL87ajm7uEBTwEcKOqMiKncygbc51Yo88XchP0rXrkI9TzFemiZItQ>
    <xmx:DL87avxqL3cETGwDFMiwZp3hnnkMnooUoW8IUVI02kSDcDhqyg4ofw>
    <xmx:DL87arngNh8qmAdQD-MkpFsoTJZuG8SsH2HFhlRhYeGtKcqVO4EWwQ>
    <xmx:DL87aoeXZAw_Pv4-jLSpPESO8-PdeSqygkjwdQ2Icf_XV9ZmcF24kQ>
    <xmx:DL87ansMQMpiMhL_ep3bYTR1Rvr0txS9XSGLMT94704uVttXR7UsNtgM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 07:27:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 002692b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 11:27:07 +0000 (UTC)
Date: Wed, 24 Jun 2026 13:27:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/6] receive-pack: use ODB transactions to stage object
 writes
Message-ID: <aju_CWdiXnRsu688@pks.im>
References: <20260624041920.2601961-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624041920.2601961-1-jltobler@gmail.com>

On Tue, Jun 23, 2026 at 11:19:14PM -0500, Justin Tobler wrote:
> Greetings,
> 
> This patch series replaces direct usage of the `tmp_objdir` interfaces
> in git-receive-pack(1) to instead use the `odb_transaction` interfaces
> to create/manage a staging area to write objects to. The purpose of this
> change is to get git-receive-pack(1) one step closer to being ODB
> backend agnostic. For now, the object writes themselves are still
> "files" backend specific due to being handled by the git-index-pack(1)
> and git-unpack-objects(1) child processes. This will be tackled in a
> separate series though.

Thanks, this was a pleasant read. I've got a bunch of comments, but
overall I really like the direction of this patch series.

Patrick
