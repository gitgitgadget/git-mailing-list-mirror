Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164D44DF4AC
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164344; cv=none; b=qAZdBjtojIcbZQMX+H/Hfcbtk/5dxVTXUfvjPk6dmN0D6j/zcxH5R35NdsvsbYkmYFB+CWvQX/whFZ7+GR5qCDvBJaYC0XtQspx5xrqO6dgcKrx912rwXMmaGwZQlUjc25x9gGvjS0I3o+sYUqIGPFjE5RN6T/qPEcqiLXBpwLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164344; c=relaxed/simple;
	bh=wG/sxuuYsUGqx93gjSVGjpJJ2a0KL/KhcsgRbliMmng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i1ZdQt5FwWKplxQ9aJBxzhsoK1x+AfPft7NfSTLaQr4W5r07G2+/AZBx4nx1itIFxdxMZZes+gM0lJUu+fjI4f2CnXDWzel+3rX7IcOb1YtpURxe3gZad34dEyGwDXSN9JSdFpda2MF42FeV2kr7Y+FHIrZ+fOu8mcL8pD/t550=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gi3GzvJa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rbhFqdYA; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gi3GzvJa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rbhFqdYA"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 436BFEC012A
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 11:25:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 16 Oct 2026 11:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792164341; x=1792250741; bh=t/yhs4LNrg
	4z3PYIAdQep6LV2sZ4gsfEmLbTZH/OmSQ=; b=gi3GzvJaK4ClvgbuOOmEzmQEF4
	CC5O5p+/ohb74prUJJSlobZd4JdrKktqfmYES/f1STpya2edKh9EwIITjZJCs4yD
	pL4OTlsNl/dYQ3C8YIdjMy6JxqcFd03RRI7GzZto48WaQ5kgZlLQEf+GrTVFVFQU
	cBwmGudvrEzNrBHwwky23KTOV46tfvUPuXS328ytc5LxwzCrPxwq1k0lfgVWILgP
	19SZrZqLshPccQ78+oHoG9gQVYsShsYjwNDQ4hjVXuDbHpnWXqQpgyocJWYd6Mwk
	pAMiOD3D13N31tNUjdAOu29bzgtn/JeNrv3EUr344jc9/zs15oeMrozU7Jrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792164341; x=1792250741; bh=t/yhs4LNrg4z3PYIAdQep6LV2sZ4gsfEmLb
	TZH/OmSQ=; b=rbhFqdYAIDMSMI+RNg+a35Mkqo2+CwkUJkSJywNb9EhUaTJ3rYc
	vjOEsxET9SAgSqF9g0YtLJLTLwYtDA+6eK0saV1Gbwg250rWVeO0Ce3QSUL591c5
	pucHPpQBTOTdD+p0mbH0PYppvHwKsXvDEyeS9ZPXDKzTUay/F3Luy+VMRLvvnDEH
	+Qno5Wbz/HHdFZXWGmUDK94EAGxbnMK7Ud1dzw0HaHjN5lQQNtW3Lq6TBrL7TNLc
	UorwYr+bLrMfYJ0C9VH+HxLUMhKfBIcVVDUqtdma1fti8R8TZS1shAEjypGO1FoL
	RoO3tX1fwHtyAKuCbFcEBBfbKXB+JMmwaBw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792164341; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:DLdFN7aMHD9BdxLQFMSuGmPqYfjqYhGrVtZYd/f/QbJsJeA
	o01AfBPmtP2EWs9wSsgNW0g4qxcTQCIc1pOb4guPb7M6e9AM8rOeBsQH9XkgsOyr
	btA6o0uW3DWNiSQ56g1Vg6KmVQ/9cFMf8gNwUYJTrou4SPQ9VMVJsSUCNcaOA3SQ
	E1fnIFip3Gbxupyc1IfrgnDQB6txZbe/0Q6WXbGAMJqW2PH0Mw5vyjwXna92sTTy
	LuVDuodgwFFhtYxaHYkv1LV381bdLlMsY7AglOjnerZT1eBUK3RgJ0lxTg9/ngI0
	ZK66pVnTzOKrdKfwk6wkSTTGG2oMs1HISDfHFnQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:toYBV6lkQm7wr0y5peA72gqqs7ITqJDwPev+vWJlo14=:wG/sxuuYsUGqx93gjSVGjpJJ2a0KL/KhcsgRbliMmng=;
X-ME-Sender: <xms:9UHSarl7dXFBOW7DYGApk5leseFGR4mDjLWEAupvnt0L9j40t-uxAw>
    <xme:9UHSahHoh1d07cqrbDETlkSq8UUxcH_rvRf7OOGs6_4hHWko5EKcJTE_-t-pXbXzk
    MWvavRqKwbo8ZGldfl68vg0CipW_CZShcZ9CUmc6bxZARZDtqdAZQ>
X-ME-Received: <xmr:9UHSaj7xTPiojI1dTTP_QwW5hO0kumNFnOnR75i6CslFE9_uBgxQHtAAKMblO7eHPQBpBq_WRPLN2zMUMv64mmmZSj8P5HJnhjsr>
X-ME-Proxy-Cause: dmFkZTEHXNluB+PDPB6SKjGB7250cUJohxncMsaFaug2vEzQlx8R6DaSlZTxdwLbeZkmir
    642O53f/KCUrlHM4tmxIebHVIwTmmN9nvWhzN7luQruD+8+LnYLfY1BwXYuSkir+bX7Mu5
    NYcbpF15cXB2U8z1JUrQvy9XNMOWaLSpV2KhzGrqGZDu3QTo1bztHnGWyCYHjSYyFe+6iV
    HZC03RoHyHwmEpHmLCkWJ+BpPuTYdUXDvOHyNaKyYVltviQWglQLEM0w8e0tcpAwqluhBh
    5Sqq22oQYLBMN4F3AsqZJP/e+CR0mNDzQHQmp+J+YQR1o0d2F3m8gH2mpozjGdXG4mn7h5
    DoDzSUSO+qmmiTJ82HsTqKSlXvqENRrby+MeU9J2UT5aFyIfrAUahtISDhUJdbUg2QYe4d
    dkmOHCQ7GdBaEhNyUonPRb2bE8F4IfyNrqGhpyfZPfXjB2Gb4WRaCBKHEPUGbJZEdNqTRI
    Qr6OeXtQ5Mjt4YS2CJi/k1/ygav+k2wZ1ytOn9DEeWi9ApcUAcUoL9Anu4BcbwrbNsW4QI
    EFJF9fF+rn9kHfNZ+eZOefKaZpBSgzUlMNxRVZaPYTZ2x+Q607slVK/dF8tZhRQJqa+4t3
    X2Y4ofihazSNvkY1Vnur+b9ksM/C7nuN10HL80WEk6SsZQRBCuS56aOhR/zg
X-ME-Proxy: <xmx:9UHSapnZV5Et1v84uOPrhg74NTEjDD-lfyIIxNOhX3NlCjNx1qVYGg>
    <xmx:9UHSaorwp15Hvs4ggvdB2d5qZlXkzNoNZ5b2vVRBGA9TTkgb7iwyUQ>
    <xmx:9UHSaovGIu0XEkMS58UBdi_T9JzC1iYyjSuhnMi2ZOS9pm2CmFbUvQ>
    <xmx:9UHSatHGLTz66MBneWDr7gODNsLf6Zz9BLX1JEI-fl8e67f1sFU7zg>
    <xmx:9UHSam9IFfcv2ChPgx_jG85cyOizDXZiuYeiwHhD5y7dBX5NWuLlY9On>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 11:25:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Wolfgang Kritzinger
 <wkritzinger@atlassian.com>,  Tyrie Vella <tyrielv@gmail.com>
Subject: Re: [PATCH v3 0/6] odb/files: cleanups and improvements for alternates
In-Reply-To: <atEMt5wgfblCiv5a@denethor> (Justin Tobler's message of "Thu, 15
	Oct 2026 12:27:00 -0500")
References: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
	<20261015-pks-odb-files-alternates-cleanups-v3-0-bfc62fd780eb@pks.im>
	<atEMt5wgfblCiv5a@denethor>
Date: Fri, 16 Oct 2026 08:25:39 -0700
Message-ID: <xmqqfqy5is5o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> On 26/10/15 07:27AM, Patrick Steinhardt wrote:
>> Changes in v3:
>>   - Add a regression test, supplied by Tyrie.
>>   - Link to v2: https://patch.msgid.link/20261014-pks-odb-files-alternates-cleanups-v2-0-fed9b2caa3be@pks.im
>
> Thanks. This version of the series looks ready to me.
>
> -Justin

Thanks, all, for writing and reading.  Let me mark the topic as
ready for 'next'.

