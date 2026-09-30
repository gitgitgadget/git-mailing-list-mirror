Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8068518154
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790788057; cv=none; b=cmNMz4dy+yGQRWFjBozRUcbYaZ4g2IHYOYXyEVwz8H149YkAfCfR5CZGFIoDQsmzDcwLCHaayyalOHmkbDFxCM2sR1eirTWgbpknFhAKlhypQnbQj04e6/ALhPylD8fvg35XbSsdW0s2pxmSiVkPGfgVi9qPaYPO8nKSs2JJzs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790788057; c=relaxed/simple;
	bh=8lPlvDojainHL1XZPvO22nxVp00AGFYo/sOsrYYDAxc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WLbsHNP7g/jgid43hkJFy6yfrPVCjGG8XXsVQ8ZVrfqs/lgJ+YnNE1gj9BOABId+on1nV775X8WcASOICvaj6oitZn0E8uW5+hdzBA3f/wavO72hM0Vg2UkUekqbrneRU+2ULYmr64PZx4U3rOX8vGtjyfZwIvpozkMB0oBkoH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mxc2MxyT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ALryRJ/T; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mxc2MxyT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ALryRJ/T"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EABAF14001DE;
	Wed, 30 Sep 2026 13:07:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 30 Sep 2026 13:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790788054; x=1790874454; bh=JfI/7iV203
	qO7wehKWn3iyHP8Y/3pXHEYVBYA/xqEMA=; b=Mxc2MxyTzNv56uif2YAaO1aH0P
	jbo/06gCLO6Dy6bDUGtY2pjZiDy8gcXbDx6/HKr4CaDyubXGic7qYDmOfABRxmVv
	Z+9hJ7NapnA9hNzjDRNVNt0hU5fZK/JKNLKAddg+xjKHawPAXNxAuMz54j0KdCaP
	lcoR/BAWnPKF4rwVUJfLf8/lOEJRLqTrYS5txcmKEJhgpVCeh72D0UCkcQrl+Q75
	/qcE0+7E4oYh3v5QncBoux410bgWaGcZD8qcXILLJoSbncAO69eOI8UVkqeaIRKL
	g5N7itwa9BW9Pg3E301KZfQW4aBGZuZyZodwyCAxrWstE6KTRR2V3oUW5FNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790788054; x=1790874454; bh=JfI/7iV203qO7wehKWn3iyHP8Y/3pXHEYVB
	YA/xqEMA=; b=ALryRJ/TKORpD72fBDiSuuD1A61a9/kxLtrS10yjq1+lNvUgXIk
	4sZWt47uxNls56xqg452tVNPoJulCcJ0k/NQvBxZyX9OySa1ymYdq76lNnebMq9U
	QjjIcKT7dNPDIJQ1cssgetAoBaAdfGpa/ijxeoVaS7+ZaN5m4ROMRYG68gRf5MbW
	vPywTJguzNb1wB6pevSpVBeG4y32VsQcwVM4Z2cSFcKrRU2oDSyR27q4S0yI0BTk
	9oTezENhMxqVU+huExNSCZ2H68vkQoQ13T4jF5Jd9+nHPTZhg/BkDQyBJxUyf6mj
	SAAEttzwOD67J0GtZWny6xSixteNh4GHITQ==
X-ME-Sender: <xms:1kG9avj8qS7MfrjJSzn5kFxF7y5zrDXoxxMvoYcOHSqicozdiG1Evw>
    <xme:1kG9ajBGdj-kRqBz18dG0vjNAfAA96cMHEXvuyJ3EPwbkhmduRnmReilTylcCZ0C2
    RUNhMh5_rXjbvN95Il_uCL3aNH_f-rMI1jxjILopBymac_IclBQdQ>
X-ME-Received: <xmr:1kG9akEQlQp8ooo-HFip6OordlAA-CmxUPUxkw4BXjoBDOQ7BkSLis9D6PxgkVHzJR3zy-D9HHiHjRAgJlSvrCivHfd8x47ZLNcT>
X-ME-Proxy-Cause: dmFkZTF9xpUTZJcz7wG2/6EEvJ9yRKFicWYw5qEfuxkboIlKKQ+Y/DDLxt1zGCGKy8NoaO
    +H2CgbzGuDq1t8GXCdem4BfWxf0xDaoYIAwFCIm8kUsT8uOCRegkfZjdxOkm7ERafnDzZS
    /xw/ECpTcXvf+iCg2ePYX4fD7Y78rRj9wl9mMVEjXrTmEctKrdcZn/YCOaFccSAXP9HdlM
    lY7NTUjJzletSry1jHlaq5emGpiD7Kk1z3QwGtSC1+QqIJnu5V6TudnTBNh5iXe7lHqdI1
    cAeSlSuk+U57weG22z8SpPbyA4N9ImOf4K9pO3GNH9Tu/jWO+A39YIHAOxcLog73T3esLQ
    JM/sYU0NZHu6k3UrH+1saxayXYc9r0+9DpFC+/9IlIYYwh0NMZJ9QZBaT/c7LgHrxuuyL9
    GDBXrwFJSxVvSgwN7naCXpO5TA5/OJrMTaMne/ZkI8I/4TMg0/hXmYaxlVDf013OmMgErM
    pypbeNM5ajJPFM6sh1vgz4Lau6+GJll4YYvxToJB2ME1pzKrp5xXdgQ5wqVrPdmfvv6uCm
    4XwCjkDgW8Ls14gbrKbChpwOQWukQdrv4bZWsT4Nx4E/ftgYK/obHfCQrZs2FQBhjz0aPl
    9w1kFp3FZLKmcHrq8afwc2QgtMxpaxEXlvLT9p94FPN5lg3sTzAVg+2j9l1w
X-ME-Proxy: <xmx:1kG9arJfHqHladHzb8E1BXmixbv0-7LJ1NSQhYVKjZKVi8Yg0tUzAw>
    <xmx:1kG9aongQSU4YpjSlq0he3a9qfvsnGQWJJ6gWTLyqenOKfjAl8syow>
    <xmx:1kG9ajT-qSfOmgG1UP049TLXGsFLaoc9xaXRMOGjbyzwkiGXJGP2AA>
    <xmx:1kG9aqIHn5X0vI7p7vNmLygVYo5PDCJSUZioww5x9pIL1qYPVzlz9g>
    <xmx:1kG9armxNXHyItpQhODdyZgZTzTMvGLeBmSZjNnvnvLKLz8kENdeonSv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 13:07:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH RFC 3/5] fetch-object-info: return a status instead of
 dying
In-Reply-To: <20260930-backfill-dryrun-v1-3-1128f247ee01@gmail.com> (Pablo
	Sabater's message of "Wed, 30 Sep 2026 01:21:48 +0100")
References: <20260930-backfill-dryrun-v1-0-1128f247ee01@gmail.com>
	<20260930-backfill-dryrun-v1-3-1128f247ee01@gmail.com>
Date: Wed, 30 Sep 2026 10:07:33 -0700
Message-ID: <xmqqwls2brca.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> A subsequent commit needs fetch_object_info() not to die() when the
> object-info capability is not enabled on the server, so that it can
> fall back.
>
> Make fetch_object_info() return FETCH_OBJECT_INFO_NOT_ENABLED instead
> of die()'ing when the server does not advertise the object-info
> capability, and propagate the status through the transport layer so
> that callers of transport_fetch_object_info() can act on it. It is now
> up to them whether to die() or fall back.

It may be just me but unless the client can tell between the server
not supporting (i.e., they are unable to enable it even if they
wanted to) and not enabling (i.e., they are capable, but are not
willing to give it to you), it may make sense to report it as "not
available".  "not enabled" sounds as if we know that it is the
latter and not the former.

The code change looks very cleanly done.
