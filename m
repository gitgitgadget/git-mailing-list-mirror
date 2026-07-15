Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507FC387361
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109146; cv=none; b=KLefNpVZ58rpfP7w43wqeeWNxZdhEWJeFWR8zEwhV6FRSMpgviGNCOqa/ByomID9AVJy6YajpO66cAZeMrzvY2PuAbrkgMDW50hJX7gNau1tSHz+YOlEL6lFRMi5ZfiwkZYPVg8k/597rFu8kafV7jLmKVxqOFqLKPmhDGmHyyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109146; c=relaxed/simple;
	bh=kEmhABYLptnJTNqiKC9Hor6oR5vxdbOFJsSB6w4npHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXo2zEJW+Ihm75ZHR21t5mM5NJLvxMK2FetKnEVmjxD5K8M8tWb9VFYC/71HC5sVcwg6N7a3zobV4JZchbHhk/IunAIH5wAJBN+A4xi4rLbz45RpM1mjK8zUcOyLKsE1cQL0pj6V9cSppgZFzPMoS4Rg5hURn54oVvghnn7cV44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CBWeCuGn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=phxM4x/2; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CBWeCuGn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="phxM4x/2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8E7CD7A013B;
	Wed, 15 Jul 2026 05:52:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 15 Jul 2026 05:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784109144;
	 x=1784195544; bh=kEmhABYLptnJTNqiKC9Hor6oR5vxdbOFJsSB6w4npHs=; b=
	CBWeCuGn4LZL/vM0M6eNDv0w37qsnATBtre3HUgERwxjTmdrRn3gNSRAEuED7iS5
	jD/dl7m47hcYD1yVbLYk4bo6Tn1ED38t1d0R16U4fLR/XZW5qDFb7zvjRPb2SERz
	tUqCZpa4oQEM713eY3WeQ11u/U71Takzjks1+jTqkpF/SmOBwe+JV1opTlawNIgL
	/q5n3mJpohtaaECTqhhgblZrSoSARbjI7JUKSz3GcybEgtIHnu1QQGc6ESTZVp+Y
	ByXyp2gcUQwEYnMDlmuq8PVf2Z1GNVGJhGBf+2jjZsFmHekZEPRRkQR6JMxLzHa4
	jwYJDgj5rrVRvofHMQ8qPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784109144; x=
	1784195544; bh=kEmhABYLptnJTNqiKC9Hor6oR5vxdbOFJsSB6w4npHs=; b=p
	hxM4x/2GX7Rc6/lNRJf6o/b4qhKaaysptn22+kfQadSj8ge+mnX8RBLJgZGbC6gb
	iZzKA+FdOtWGFbl+KrK1yjcOR2zuOeevNYeg+hTwbsNcV/mSpT8QhuxPuwpsgvcV
	8dIB+1SooHotO/88L7Ly9H9G9Ltm00yShdLw+NbL1n1tYW2oTtEeDZXl7hCgptEI
	SWgm7AZTMWOebOHE2/a/hj97+W7UG+bglTnSW53+HnzW0XJPCbiuJcUB2CAq3h6F
	TzHzdursEtBc8eB+DQng1VRXib/Lp1CSh9Cikv43c5+R9jLUn5WSieoVTo5eqsyd
	XQng4ue5gsDGTTWehxrhw==
X-ME-Sender: <xms:WFhXakwiMs3Fc1ksiEmaRUeGedMqnKzw75ND6rxs90dUnLIQzSsI5A>
    <xme:WFhXauSBzMdZNXgLQS1DGLVXBZHcc3gyDa99BHSZhz7kczKEIMPeGzeNsu1HzeiQP
    wYow1lcmPgyLtzWUaq79WJNzKgLnua83YoBEddxxhc0UoSzKjQV>
X-ME-Received: <xmr:WFhXaj8cP3kKS784LiZO0wfXR3GT3UmzwZ8bqU1N0xaoDs4GcIhT2-tqOMGNhkB-MGPDY6_7Vq24YrQj19ALctcCSE2AttDXpbL8fw_lYQI>
X-ME-Proxy-Cause: dmFkZTEoVe5xU2vXSaVceyM1x2urqYo29JXeiCsvKgxPeAdRonQC6Ilv+UXOzYKmFgLweL
    +YH+wwUeZOECvL4MDtyuZRtVAiZN+btTM6nG3OAlf3Pxo5RGPtilsWVqJKAcETr5w/JP1L
    kU0CFD+5wyCgtosKDccFRpM6n6K4tEFF0ov6K+79PEgheLalgyPskSuz44mDcdkfVB8ZtL
    61nvhZ1b+MbUe8yKW9hktxrVmrMxhAjoxpBbUHgvxm7Ygnu0bGwtgdcqGmOAi9yF7c2P+e
    EzIw3ITFoMfG2D0TBx4Ee34/cc6Wpon/9SFC6eOPP72H53ENe23rg5cHwZ4fDpJANyGImj
    3AZ1rAiZuw7OG3pzogDwTelgzIiiHth43eSEh2Ezj5OPM1HTnnlIT5NvO2w7ZOhF5taG8l
    tWrsG9z1g5hH+RPPVbWV/TiUkEkMtjxwsmFDu0k9WVbWY04NFt8vefK9O8/4xRY4fPm6XD
    yESCy+gKh27pyZyRPeGYIZqdcdAEcC6tRPLcRRTWFXIHgWx+35JLq4Cf4MCirO9OliQWEF
    vQjo1YYbrz5/tAXXw/477S6kekdSUsAE2GLBE11Je/vRkIPRAmCwT55WXFlN7sXeRgCJZw
    Tyf8YYtnY5DkZOc6Jdde13YvD52MBAAF4SEwHKVZB7YGIgTmHGy4J/NbtIQA
X-ME-Proxy: <xmx:WFhXatrpLSdjW7y_sTxWKU2Q4nih7cC5f6mIh-D-qTG2ZRjAzc1SIQ>
    <xmx:WFhXaonrZHlvMMizpVdHiDpQcxVapF17nxSSAS38Z9JzH9ZLLs67EA>
    <xmx:WFhXasJKeenBLdilfyzSUk5lk3bjYaxk_2Gl7Hq5dFcZjy8nON_ijA>
    <xmx:WFhXalzTO2S81BRNQhol3PMBCu-241nR5EVQHgmvMcZUPjInZOJxQQ>
    <xmx:WFhXaoJGoq_Zzb4n2C7rsyM95E1MhL4Hl8ScQBPNvBkN_l4Ls6u-2V3R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 05:52:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7378501d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 09:52:23 +0000 (UTC)
Date: Wed, 15 Jul 2026 11:52:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] tempfile: stop using the_repository
Message-ID: <aldYVPyMl40-Myp0@pks.im>
References: <20260714175956.54601-1-l.s.r@web.de>
 <20260714175956.54601-5-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714175956.54601-5-l.s.r@web.de>

On Tue, Jul 14, 2026 at 07:59:55PM +0200, René Scharfe wrote:
> Remove the compatibility wrappers create_tempfile_mode() and
> create_tempfile() that have become unused.

Ah, so we do get rid of it. Nice. We might tease in the preceding commit
message that we'll get rid of it in a subsequent patch.

Patrick
