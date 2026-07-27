Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EE918A6CF
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 04:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785124947; cv=none; b=sZ4S+zE5jcJCVCc/987M+IQdUQi9ebGKXBivmO0KSHio1poV5GR8JcCmiZ4knhw/kyUG0YG6/o4k3PXuKYAfMp6TA9hqLis6+uwlpiGSmppoyRKlUo45Gl2NV6KFT/H6VYNAY+Mh08/PZpw2SZnuY+gVNI8h1rkhYxGXU2r9tRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785124947; c=relaxed/simple;
	bh=QSaEBqlfcgM3LOckcYqfU45Fvv4rqJdOzf+A5KGlKhU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TfzccelC+vSufLCi16U9su3QbYhBcoJ6eybp6Fyxolm8t76GVI5oghvaqmxNdaIXJiZBc+FYeBikPj8MbvGvLhE+nwez7dH4p8YgvLDXfVZeUqc1XOUKgOfD4vZg6k7lchPrT9zNfI1imgwZI0O6v0WI4O+muLyQ2dS95OLVge4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L20+xJ89; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IjkGb6IG; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L20+xJ89";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IjkGb6IG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 951D07A0256;
	Mon, 27 Jul 2026 00:02:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 27 Jul 2026 00:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785124945; x=1785211345; bh=wSADh9LAxS
	Rg3mS5lsWkV3f/v/QlFQYnRaOdXWiRDfI=; b=L20+xJ894TJgiT1M5nZRsV9eGs
	Ub0syp5V+AApzxns+t4+ThOJYiw0jbBJbO/d05FDcwM45XmXALej5Iw0aiKhckBP
	z3YhQDtv2y9PUs1t2pwRShWA412MYC/O7xze6lViuBqE+ECbfy0QBMEzPxMw+8rA
	u0PeJwUd3PN4jzkMsal4zGsq2/ufPeLAcZrLHQ+XnmnJRhpXNS16YXuWZ1NqCFw1
	NcK7hkenaG2RKuHBhC6UxzLkddoVk+nerKRKLUqWTgiDa73RK2YHiOZoO9cZG/qg
	MZBcVDhH+kpQB2Defe3MqgeWrCCXZQ6vJkZdQQAFIa1sEg4VAWchexKEPQ9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785124945; x=1785211345; bh=wSADh9LAxSRg3mS5lsWkV3f/v/QlFQYnRaO
	dXWiRDfI=; b=IjkGb6IGFyN1NBIG6czbSs7HqkzNbyZij8J16RU1HO6jXT3JZg2
	FlLKO7HbicQbIhuFi0gkM8w1XYdoumfjNBjruWMOw9y76izXIxDlcXoDrpPiAO7p
	7Rn5H4Le58XUZAOmKm2hHo41Lxn+qKS8ZJqVHwE+kl27XeDLjcbTvgRKngL4AJqe
	0va+a1fetwjuY6HY+h3r2mT9lZJ0HimOmV8AqQSsF06CmSo5Dl/2tFJPkIugSrGz
	TtsdH6mOEtDJMG1DxiCGZuL9mpwhrKFI9NLqzMqY4BsHfbXJdd7WPGnESJ+CMc0x
	k9GDT6R9ygB7HlxgTV+nx6zVIWHoH4crF6A==
X-ME-Sender: <xms:UdhmauSr20KzlAq0nqzDLmNnj-YCCcL2qfYj61O5NebEEFqS1QLFlg>
    <xme:UdhmaqruUx1B_fOqvdvHS_P57fQsbZ-sF7Fpchn98fTNZF2Ns2ZvQn_BrKONINJes
    Sek__rpJzJM9BXoKTttezeZh-UipFiIihihpEP32N6h89fnE5EnIg>
X-ME-Received: <xmr:UdhmakLt8_gH_CgYLe-s3vBfFF5am3YD5S-7bB6V8-TZnHP_U83mYKUMXpO3ZpDbTwksiY6QVuA3gvzQH5BxN8CMvPK86Qlqtg>
X-ME-Proxy-Cause: dmFkZTELC9PZFQwf3Ft0sc6GSHlLmRfzAIlouNmD6RFnfXygqfL0ilWdd6Vq9myN48tw/0
    +0TWbJlJZ6/xdkNlrtIQFM1m89r98j4JOFteQOuQn7auUOyC6iRXChknVPr1M6Sd2ei4s2
    xq+WNxZyTLsPD5NmnHnAskB6VNOqX942Bua0LuBf+/ep65MR0OmWyU0DZEMaElOr3YOsoI
    BupTrOj5JxMOce+03tDTJa+erj+kbTuaWaEWOaSngWIi80E5vg22JF0Fd0/2TaGx6/KrB8
    Gs9lyyEZjVlEcqrabsAyiot4ytmDgoxNerPOWeLfxI1fZLbxXd2FuKNBIRy2hr6B6ufhZD
    z848y7UxPaA0/SYhpA/UVSFy7qQahWSwVnjHQAoA4njWyt0vpur8u541FieHE0f0Ps/4ZZ
    8r1HijlPOugJiBRr6t3FMtHCdoCOYec9LRJTQD45d+0BuKvVyrhq5mAbAkkZxA5OI5Mumq
    MvnnfUiMkb+AR7svlRkgHCMAUbxrcwF+peceyXxKCoke1KrTJHoxUAK5CcOLHLoFqv5kMh
    VI/o30SfyGnL3aqZ0keve00Ef8yLOglvfdNofRmRJaLJQq9yOfQ3jHyLQK2CVe3WVUG4iI
    etejCYRmxeGhqH1JISB5kaU/40L0jJ0QfUbWUDgpQ199SZgHrx0axvTpL20w
X-ME-Proxy: <xmx:Udhmalp7fqEmHH-Lp56IeujZeOl8K5u_MohHTFo8NZUQV16p9r4N5w>
    <xmx:Udhmakweu10EZZg7GmqE0AQ38GwAnD3GdF3nsfXuiuhD92ssWTxrsA>
    <xmx:UdhmahOI8N9C261Mi_PgYRVG9CtfMI33CawOCDlZEJ-PYFKS13jwuw>
    <xmx:Udhmah5KaLViXiYKQiLYolW5mFWUcm6dKQ1PjIWMOSRdixD2GS3hYA>
    <xmx:UdhmarFk-CXpPrs6nAq2oTNBnsrxbjld4dwId9MfBhsvi6Uu0UP_Q2Gu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 00:02:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Hardik Kumar <hardikxk@gmail.com>
Cc: git@vger.kernel.org,  l.s.r@web.de,  pabloosabaterr@gmail.com
Subject: Re: [PATCH v2] utf8: use size_t for string width methods and callee
 sites.
In-Reply-To: <xmqqpl09s3cc.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	26 Jul 2026 17:06:43 -0700")
References: <DK8L6JM14UNS.16B15DIOFW1K5@gmail.com>
	<20260726195718.1914131-1-hardikxk@gmail.com>
	<xmqqpl09s3cc.fsf@gitster.g>
Date: Sun, 26 Jul 2026 21:02:23 -0700
Message-ID: <xmqqbjbtqdv4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> The goal looks attractive on the surface, and the change to make
> utf8_strwidth() and utf8_strnwidth() return 'size_t' clears an
> existing TODO.  However, the updates to the call sites to support
> this change introduce several bugs due to unsigned integer underflow
> and incorrect mixed-sign comparisons.

Having said that, we need to remember that these two functions are
not designed for anything more than what fits on a single line.  The
only reason they exist in our codebase is because their callers want
to measure the display width of a string, so that they can align
elements on a line vertically with the corresponding elements on the
previous and next lines.

This does not mean we do not need to support more than 80 columns
;-), but they surely do not have to support a 2-billion-column-wide
display.

Quite honestly, I have to say that this topic has a very low
expected benefit in practice, while it costs us quite a lot by
having to carefully code and even more carefully review.  If we have
to endure so many new bugs in the callers just to clear an existing
TODO, we might be better off not doing so and relying on the "safe
cast from size_t down to int that barfs if the quantity does not fit
in an int" protection.
