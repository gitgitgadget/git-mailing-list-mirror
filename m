Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C785304AD
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 19:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791919294; cv=none; b=u8VJRzD7HH5Q9Z+4eDoDUs9AECc7RFj58eB++Kx8D3WWSzZHPFxNjL69QfWV3GCe64p0cMiMkpPPZg/cfFCdFqtJn9aFVjSiviOFrGT+5Pl/4uYt6NMBLeKH2E0vUF3iGMHmtNjbajEI2tUyq8vVanRNmmZGJ/pURPX+FbeBo6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791919294; c=relaxed/simple;
	bh=uZEGmklLGF0PWNISqo99AQDyetBhtwrtpc4IduhRys4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IuV0tKpvhcB8z8QbacvI+rP5mF7aY93mjLjA4zQKufV24IC/H3zyUtG3mBQkYr0GmTkJTitHXhjgii1OLbf7+UzaahWFWdY4pYWlpb8azJfvuBXkYsCx816cJfIeC1uoBDdexMH0zymsCiZTQ0V/rxZAVhpzOdbbZVteqpIDU7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TbgFDRfB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A5Y5D4pq; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TbgFDRfB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A5Y5D4pq"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E73ED7A0139
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 15:21:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 13 Oct 2026 15:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791919290; x=1792005690; bh=sBIx++ixF2
	l67GsuYUd7gThgRcP6l8rCb6Z5woDTJXQ=; b=TbgFDRfB5dQ47k0dWiNwzdgcXo
	x37R/6LAWMsFV+irJs/sfTLIE/rlX0b6VRZH+AQMVB98WLd8AmUpSoPDZdmxA0Gs
	w6cofV2H8TDLSVw/bQmoXW4BhbI0m13J3CH/jeiSyEKgoodyjlMNoSdXg2ObUb6K
	ky8XAYvRhLii1+wRfFuD+kcOdOJcXDZ6sTbCdaESHRhAkwvYlEk04S7DXhxGXdoP
	U3U5qhlSeYIHGJxFcmUNtDKjTEob3q8sX44Yq5fH/pXRVDVH8fKso/yJu5z+CFm/
	cBx8qRzDosA4Tynlpg/AzKFDMsgW5g6B16yViBKYYeDEg8bf/w7dqz2Syofg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791919290; x=1792005690; bh=sBIx++ixF2l67GsuYUd7gThgRcP6l8rCb6Z
	5woDTJXQ=; b=A5Y5D4pqXVMLkA94X971ilTxvIghLFM4mLt6Dvl8uv2iZuojm/J
	RmWUwHTeC+nGi3ZNZ22Vdkgr0jF7PTBEZMoT5utNE+bAq15uicOJ0Eafk6LGSyeR
	EnZ38urylwpXAiSB55dwEwZnX/l8HKvCN0C31cSPwUpXt3ToOaUwPI5aduWAIDRF
	kxIl/3UXRhJmeIJ/Go1KDXtVjjof3W8upNKnQsB9o/Y/0+Va8DWH14qY8a7FxsMQ
	W1JuTD2TLby3qnTVyb9QGsSQcoLzlSwOwJLpp/dO5DRPXJm5XKg1F/By2fDwP4UZ
	VYzovv+s8qeKkMBySkLF4SJxasB2PnOjBQw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791919290; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:SM1nkVMhfjdN3kAay3VRaTh/lFwYVBTP04E+rdAFtX4UE35
	z8ubt2RdZPWJYUPfD5azwTRewM3EpaIEbr/hUBVL35FlVKdYy+pEqCuqG26xqkjQ
	qA3nnSjpw5iTVAs3q5UdJC6CCwuk4L63VcOxhboOTUuL7o0QrlkipLUCBnjHABnk
	LD20yt2uZuV4nG+4uafdEMC+SfgvqEWIzu61r2zyGO5WqfSYApQyeXpKPgP72sJu
	UE2U4mkd9/2vu8hDMfS22sgv1L5mFlDLQ/2/GsSYv8pM80AuJ3ZCWXLYZdnhWEPM
	QFK5w2LjH3DSrGuK1FiS2YJ8nvmKNvk9/V0SHgQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:AydEDp+G8A0yGD/RdYDuS9DhwHqRuykfJTcU2PUvIL8=:uZEGmklLGF0PWNISqo99AQDyetBhtwrtpc4IduhRys4=;
X-ME-Sender: <xms:uoTOaoplRv-oAb17Xp01To1S2tNxqn9EsbFZH_hm78MiR8PAXH5qBw>
    <xme:uoTOatsy1MUF3zim9hi9yI9F7uCbIWqfYOj8TmEMaTRSfMDdcRV2oarCVN16ps34o
    Eo6R5rXT6W-Noiiw7K9lU9QPx6AkYmVPmq-MQakcpBiSTxCtfbB3hE>
X-ME-Received: <xmr:uoTOajYne0BmLzuw6Nzp22P8v91LEd2cgP_HgZSXTLQlOxU0B8AfWnCYuDF3A0sg6EJaLMebguL6ia_KBUgNrZTr8G4KOxZe7YMi>
X-ME-Proxy-Cause: dmFkZTEKas5mxKOmiHk8QvthLE+0qwFI5q43ioKGdwNGaKYTEZNTbSHeGT4DlLJ9EE5vao
    MPI4+DxmqDXc68lsko4NiplMWgYJSCLldnLPHpfOIbdirdgpuLuM6DwBCogpMtdSEjG5rw
    v+ZfMZ8FDFKGV5s8Oo4QLCuC0GC6UHlq/qDXkf5z8e7MSwlFSSJYS+YJfU7n3nUf1n+HBC
    y24y6n8avV4IREnFc6lSpsq1jI7X6k57CTH1UCZwGzgju4TEoCGItBfHikfvdT+t+pgmub
    AnchAYanBFXMxqAOQaFpGAdIWM2k1U8zFtHVr6uFp8UBAS9iZOEW0CDQjST9VDFQFfPTtf
    9hlOzKrtGVFISHhu3w4GkaW543KnMFMgxHU3yGOplfTDJ4mJlBinQsMI+/9vs2tIG2oRbI
    IICk0SzlipMF74Zk/n6TU+FFfcM8puO2az4Oqg9yZnQbR5iPDJloAeAIb6H8ScKbuQUfAY
    epE+PLT2isa5LhGbuEn6Mk9Y2+aedO7JHZ/3xOWcIy3LctZXMT3OHDzXI2QAN1FaLBQJjj
    Nk4nf9MfGRYmLc412azcCU8tgmHQwRd84BZEprqnFbG4tdaYl/64aeXTPVmWZZdvIqa1/0
    Jn8BD2XVEu5QFfoDI/WVuvXOMPExjn0aInXnWV/BHkMwk8XVEArdaPOvd28w
X-ME-Proxy: <xmx:uoTOasZTW4hYXDeI7ItFdiPbdXW-OZ5bkWvptC42VTaX2HISx8pXoA>
    <xmx:uoTOaskd7TJigpCVUyyo1Cd491L6FlSW6ymO-CmMzwHzfsXH2ZAFEQ>
    <xmx:uoTOan1CvFtxSPb6Fe0lveRxQzNGMc_lERyYi_ix1g-IP1_LMMzq8w>
    <xmx:uoTOas3t42bnTYVkl9BoaekgUsxvcpxH56vf_kbwANquYBdF3u0Kww>
    <xmx:uoTOamuiVJT_3AubpfG2dFIkxakBmvnptnCaOVY9kijbGZPmxsHYCSxs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 15:21:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Karthik
 Nayak <karthik.188@gmail.com>,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v5 0/5] Introduce 'uploadpack.lazyFetchTrusted'
In-Reply-To: <CAP8UFD08XuP-rKmcuLSxhX2xeM0k5G35sgX1TvuNmpe5Bpy7mw@mail.gmail.com>
	(Christian Couder's message of "Tue, 6 Oct 2026 16:54:25 +0200")
References: <20260928133846.2094261-1-christian.couder@gmail.com>
	<20261002082322.2682869-1-christian.couder@gmail.com>
	<xmqqo6d8ma4l.fsf@gitster.g>
	<CAP8UFD08XuP-rKmcuLSxhX2xeM0k5G35sgX1TvuNmpe5Bpy7mw@mail.gmail.com>
Date: Tue, 13 Oct 2026 12:21:29 -0700
Message-ID: <xmqqfqy9wgna.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>> I was hoping to see more substantial reviews from others (compared
>> to my rather nitpicky review on v4), but nobody has bitten yet.  Shall
>> we declare that we have reached the point of diminishing returns and
>> mark the topic for 'next'?
>
> Yes, I think this series doesn't introduce a lot of new code or
> features. It's mostly refactorings and a new protected configuration
> variable (along with documentation and tests). So I don't think it's
> worth waiting for more reviews.

Sorry, but I somehow missed this topic.  Thanks for writing and
reviewing, everybody.  Marked as ready for 'next'.

