Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884504A4EE2
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791558703; cv=none; b=q7mZeeAEbJhkrJ8Yoxv+JTmotbgeHDIdGNFegW0t1F/y+uO7MBBw0EcNx7T3ca3cknc49WqvCMBpJSxewoZRHZcx0fVVX/QiVFNbcUZX8EcxjMsb6dcnUrxcTXZ8wNcift5ttnBEqjCdrEHzlnqPOpbLLTn+w0QkZ8ECGCvjsrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791558703; c=relaxed/simple;
	bh=RGvadsL8HA25uYpy6PfyPLJApSjEEAdohuCULnvfcfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hi6SEVyoIzd7DXpPvnMDFRHHeVtJfg3p7EQlDLAGFSnXO5ac6byH7oBvDeAxN/4imN6LlX9LEFG/I5uwsnVIGQoJqWI5OC4qESQSoC8joeHJb3vqd1B7ukVEccFZwNpAGAePTW0Yalv7ya5hG6fkJYxVHfU9XBX3Wo2oNd6sWeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mIiHK+tr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sUxAbZvQ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mIiHK+tr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sUxAbZvQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A012CEC0072
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 11:11:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 09 Oct 2026 11:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791558700; x=1791645100; bh=iJCgmTrPSe
	xwvbQLmVIy3LgdD/Tcga5wR+WHERsRedI=; b=mIiHK+tr05eONvPmpFcVHX9Zny
	GWBO7SjJ4GDzk4tWUj0ksqjizPAMcquK5KTF2OwmiwKE0jgPx5vozfX6JeKHcti1
	UqUDfjR/pHj+mBkebDRum4+UyqhjTXuZ1cbYQw4gG9MNYk1nP45xB4KHZOv6H2LB
	pZjZOp62c8CgsjGEXK8z4eV4D4PX84TwtaSAMzzq93Sg1ZD5GTHTvELpGJaUd41o
	MeJHN9Q/swj2u54IowaWxNCSAYQNmh9f4kY39iGKRJcg3G2RhpmNYmlhQD/otZI7
	ohU5P5U+MBE6IyImKUhyQpgsI+YgK8TPN2jGMCzEV6IGLZsPAEFQAlixBryw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791558700; x=1791645100; bh=iJCgmTrPSexwvbQLmVIy3LgdD/Tcga5wR+W
	HERsRedI=; b=sUxAbZvQ88VLs2XQ/1GLwqT7NnCQWQ6qWXjn+1O5N1tAawrVgEb
	HFMLnILfPB48Xb501dVCjgX03ps/iMN4A0/RwZgBNsFF7qedk++OM1eZKSgwcH7E
	UdJLTfSAWZ+MSkP2XJJNJxy+kpDbjZB8pYQPAtAVm6lsBqYBUxfAYpMc9ANgGwv9
	QE4cp1FV1IMkYX/dp3pfd2FjSJxximR90PDb+T46VVl/tn3FG7uoYiAZCZDYudJw
	ecH2cDCRJRVP6AdfBb92LXDl3b7zgOvzTtgTTpiJgozY2/Jjgvq2cp9US4QPTh4M
	FTx+I30TsBdZXk8egJSwk9JOxSde1qV/l1g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791558700; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:QJfxgWzDyDhyQcC2w/9MR62CONF528NuNYSKR60cZX0NDOR
	uZAVu0jLOnvteK6jR+ZkEUQ4/RBMulRRkHBqB9ajnK+B/wQmODklRp3kLx3+fXqi
	rF6NVwYmHwEln8D86eb2ua2RrwbTWEyzkuP+8EvknibevdcIugC0uR3c5ajyXZck
	3Ci2eo+AHCImBkIOsjaetSeeSoz46glXJB1g/PPt8IrPKA+GIHpfwKJVLbs7EDDs
	a/ZEJsLLKk0MBh3Wk/Yvh2BZuQvRM6RlLHcAfcbEVjb/klqmpADIu2wkJI1FoPKU
	xBY/HnusuvX/QqRbwYXm+DD6Qj7zkrs0jyEPkhQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:MeSNfyAm5LrEgvnr/Ns3u6gOgyb/21APe/gal7qFeXU=:RGvadsL8HA25uYpy6PfyPLJApSjEEAdohuCULnvfcfQ=;
X-ME-Sender: <xms:LATJaumw_xYaj91HEe0fWnZ3S3k8nsp4KSbO6woH5lc2LD6Dcq1TdA>
    <xme:LATJapjqDKBqHhbiHr9aDck9lCD2-q0voqI9Repk9z55negzXcM6XVUb1jIuD8yWt
    U552RFYyoHrUZkq0JouzgO_fHH6-a2Lr_arZz3-hI5mb7F1qi_sdgs>
X-ME-Received: <xmr:LATJamfNJx2Wp8b7eJAKHc-fn6u2iehz4A37W_eVHb2J_TG_1XMPMHYanHLjKHwBjNVNk7fz-US20zxobLMU4UHHxEYMhJm933Ii>
X-ME-Proxy-Cause: dmFkZTFjPzB/lADbmrFEQrn86mapCAuPdinJ8WO5NVZCicVhMm1PVZifjZnz8GERk/JtBt
    pK6bKVXH7kWlFOJ+ZOwDf9fgTvUQu1DG0HWDx4FRwbW65KO74cBVSV+IAqw4BzZBhy6pQv
    BHZWOyzKe/WaLRyLz+YEeuv1idS7LlfL+TouAlSp54rXEQRj9q2e3ltScMsockTm5E0Bd2
    nTZGq7sGFa70/lIL7ETuRD/65KuIzZ9NL6eY6GmUZK4LuPAfXK7OCp4m/p87T2KgHCFAuv
    F9wHA+sSIB4xjb9jFr5UvDb6mRxh36gERNJQ4GbutsbbT/ZfozqF6QJKQwqcQRyNCQnEUn
    gbhg8Rlnoa1FzkL0IAYFx6gjFugcppSosLVSV9j90aNDIWyi0vdyais2Icn4OQqUgsWicY
    iuYECkwOLpPLCryQUlTguwRTAOlnfmJfNt9UHKCSsGWThb2+CKwdwZ40IMUupc1K9vjxHl
    VJOzVtQm1ASorYrSAgtact/CHId/UahHTS5VN690dzx/Z8OIHJ7MoPzn+ED/k0dRWramiw
    xnl1SPByWKONxA46c7Hf8wwx/Kc8tK+BbGRnT/igsMyslcvkrwTgaUrYurYrGqkPPGT/lm
    pKdQ/sHoVJXqNhjDNDKoFishH5SPz5eGX6Sq02GptXO2hJPqXDoarjYkbVLQ
X-ME-Proxy: <xmx:LATJaphuXr2DGTjfzuDuSXXSvR4EaIaKoYYMfl1UbReTu69yJPgMyg>
    <xmx:LATJaux1J6OttlfA-k2pNlg_l78PQgX_IaN72svZNREskBb49JVR9g>
    <xmx:LATJalNcf9i6HpJgZNGxw0_ktNhJW24vHXiX4OYfRzRda8nUClwp1w>
    <xmx:LATJavVXub8xBN8gvoLpgRwk887EK6SW4V_Lc5qkPiYsZ2kS7kLsQQ>
    <xmx:LATJaobOO23Wkv-hF9A8OsnLt6__5Qh_aK39GHwoJ3JJCnABnPABffc7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 11:11:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Qin ShiCheng <qeesung@live.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <ttaylorr@openai.com>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 0/5] repack: don't lose objects to a ".keep" that
 appears mid-run
In-Reply-To: <SJ0PR84MB29933F55E298B09B37F2778EDD922@SJ0PR84MB2993.NAMPRD84.PROD.OUTLOOK.COM>
	(Qin ShiCheng's message of "Fri, 9 Oct 2026 11:07:27 +0800")
References: <pull.2219.v3.git.1791453141.gitgitgadget@gmail.com>
	<xmqqv77cyp8u.fsf@gitster.g>
	<SJ0PR84MB29933F55E298B09B37F2778EDD922@SJ0PR84MB2993.NAMPRD84.PROD.OUTLOOK.COM>
Date: Fri, 09 Oct 2026 08:11:38 -0700
Message-ID: <xmqq5wzax61h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Qin ShiCheng <qeesung@live.com> writes:

> Makes sense. I will hold off until ps/odb-files-alternates settles,
> then send v4 on top of master with that topic merged in, and say so
> in the cover letter.

Thanks.  In the meantime you can participate in reviewing Patrick's
topic, of course, and that may help it move forward a bit faster ;-)
