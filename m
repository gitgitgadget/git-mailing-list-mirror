Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA90B47F2F8
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 21:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384372; cv=none; b=M/kE/CIKxAPsQHTmDZhiSCtOpy58Ki8CjcNmI2hRnC/ysqJD5iFPi/df+n1mG2HSkpwjihjdBRTK8xRu/a5LQlvv1Z337ze0w5D1mbtb1y0DSvllfPohPDpaApMocOqFzBuB3Fn++oJoqzOlGpDln0jmIOGm3eLYN//0Zai/8Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384372; c=relaxed/simple;
	bh=2YRsvoYAXO9bzEhYDXw/myTmZ+z6TLzWrjdLZHZsxlo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ekgMDuqD9dFLPQzE4fOnfiqU6QxtSdDOJFaFbBph2/MAGXFRYzm+1Kyvc9A75zZiAtdIW+SBIrJskh8xFDKBq1oasbo7cvlPwYcO7/011SKwBmXS8wYmHiaPG5gSnsUNd0tTwYXXfs/ukablf48a8+POyVLsDz+6a9W2bhE8afU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=t/SUMrzq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TWF4i16t; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="t/SUMrzq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TWF4i16t"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 18AD41D0004D;
	Wed,  2 Sep 2026 17:26:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 02 Sep 2026 17:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788384365; x=1788470765; bh=URAc4tYG3Q
	M6qbx81EBCCNocdvONduqPUS+ICyaoZIE=; b=t/SUMrzqFZqBmX3b/xLc7Nirfe
	4EK43hH2EcaLaiCP5Drbfk09hum6oO0vMGHbXfZ+4TlWxkY26eAT9LVcL2HD/PLp
	e/qvPP1iVKpSFoUcZNBhCYJaFP7rjui9ABBygyrG4n3O8yhdM8TzvmpW62vKz5xr
	eOxv0KLamdHKBObasXjkCezId61H9bUW7ktCPhH+5/A0mSre/moh4ZsERpI+OtTv
	L1upGT72B1Cm6cOJq49YNH0CfPfrZyy7hM41zz1oHSPBqAnA0Vt0DmZGvUqUDSwe
	usXj4dMNKATUlV1mpeTf6F2a6mIFDYxxtR7B0OU9h9Hn3qVNvULJhimLvYvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788384365; x=1788470765; bh=URAc4tYG3QM6qbx81EBCCNocdvONduqPUS+
	ICyaoZIE=; b=TWF4i16tI3o10iJDDkxEyzNHz11wdAD2yeyNSk2OFrRwnz4+KMC
	xfHgMdf1qL7kt3zEQJJJcnL1cE9vkBbGIyGmKbZXK9sVqgZJ/W/BEgddAfqeRptm
	7Rr+Vb0yFP0aPxvtdnkM9h1ToALr6zvq4CX9paqtnTBsoCZEoESAfdSxe3StttMI
	2f318W4RvFc6gXEr8jSwI54K2D+6EYdhaKEmvYZx1achByOycKUeChL2iNIPflCW
	iiJEuU0KQrow0KxBPlUx1wE2VNlhPEpusUKgNBbqMX5I2IB8IqaY1gKtanJIcc0x
	ke4+b30X5pQNxnA9cd/+PzQkh9pQLvwPPTA==
X-ME-Sender: <xms:bJSYakyazCkkT4sVMp0VEj8D5mgWRAlTqelyu4_KAGsjutAa_hGIQg>
    <xme:bJSYak3hmTxGXKoHt9f-DXb9nwQLOq6SQkd1mo70lThmU9n_eJweLgRfsC1PqrTss
    H88hJAB0LgSRTt0H8DVXf_HiHQTKNNmCTiFywmgECyoLPE_N8NM_aM>
X-ME-Received: <xmr:bJSYaqxUkvpZkWhKI4FjUJ5JusyyyC68opLstwBasEwJt3RB0cfQR7EVKEsGX17U-8IsmCEB4PSMnILvbwPOeXL5MZYdwJROww>
X-ME-Proxy-Cause: dmFkZTEWWZo5IHO8I1jXSPYbkbaJtDgDCOtjL/2t2cCh6FAzPQQG2dfo4fYy0v1w2WwcGd
    21i7QdT+z9T2X4P6BeJkgCcBPWELNeMktGg368Hk1P18T4qgDLlXPhjSbPDhprkZlMNcGl
    VQVieky/G4S57eFCiDDJHKtLIs3Ood9UDytJnvHw8CY0hgL67KCF2iBQkQSINED/clE1dn
    fE0uq5ZqR45gP/VnSUrNSs2hLTuAvBjE2oIbIzRAUXazV09iDHz/zG3/egFPdUOl5VDvkw
    KPvfYshEiImLqEPuddNZnVwWYSq6TWkA3jBnHMGpvWDTdCX5nBAFedZcl5G05GfbGojuIQ
    5pa7qgBXxV2KJYat1Rp/WJFPYLJShS1HbtqzBVlzCzqrnSucVq7UdItLFD1X3FPNDzM0bV
    XsWin9iRz1kq+yRJ8LueFSfj+cDSZ6rdYGzY8gjQRVzPAuQ9D8Q+dfX9gzBwsntPe8DYDq
    +AAMick08GkU98AQZK1i7vZtii7VTSu2a9r7F6L/WfMWI+2ceQD57erPETQF0YcezQsSSL
    vdc8suprwRm7qtwZi1fv6DbJPLTbt+SO4AoTTiqX+lxaCL+RJMR2ogNIpaxxuLO31GLjZg
    R+06SVRUJH6QIl3y/HP202XGjKtQgB5lKh2YDkoIZls4G7xaIN/zcjhma7xg
X-ME-Proxy: <xmx:bJSYapWWZY_pceeH0FdwV-Ondp1y_bIDxrD8f-zqTUQH3SImagtA4A>
    <xmx:bJSYam_TBLeH6Z9c61-Wqu8YppuqWTEsE4QXldvLefXiXXI0-S-yow>
    <xmx:bJSYass3Wkj2KEjqT5BToD6LauK2okIzDDNHwkqgqA4cE_3vPVkzIA>
    <xmx:bJSYam2MbukLGQl8gwH_jZHM3XsDZY4WcvR25DpKgr5ltCXq3MFiDA>
    <xmx:bZSYanPJFR3WVNVTjeQvaCfkvoWcQTl9r00AsLPXQEA0DSAjqbvSs5KC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 17:26:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  chriscool@tuxfamily.org,  toon@iotcl.com,
  ps@pks.im,  karthik.188@gmail.com,  justin@parity.io,  peff@peff.net,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v2 0/1] rev-list: add --missing-only option to filter
 output
In-Reply-To: <29b5003e-48b3-490b-a4ec-c57088acc441@gmail.com> (Siddharth
	Asthana's message of "Wed, 2 Sep 2026 01:57:51 +0530")
References: <20260419084840.33986-1-siddharthasthana31@gmail.com>
	<20260901185100.33948-1-siddharthasthana31@gmail.com>
	<xmqq1pbcsq1h.fsf@gitster.g>
	<29b5003e-48b3-490b-a4ec-c57088acc441@gmail.com>
Date: Wed, 02 Sep 2026 14:26:03 -0700
Message-ID: <xmqq5x0ngxas.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

>> ...  So I wonder how this fits into the larger picture.
>
> Happy to clarify this in the commit message / docs in a v3 if useful.

Yeah, strengthing the description of the motivation in the proposed
log message is always a good way to sell your ware ;-).

