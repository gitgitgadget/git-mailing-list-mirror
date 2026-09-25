Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468BE33D6E6
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 21:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790373000; cv=none; b=AViMhJKzRtzpeM2silgulvMFaA8rZ3rAT2df5OirzekwnBi63qq9oBMfuLwmuHpMLNGgN6a5ymEKOwzP79R7pwdR2T8cxV/46WTDFtGycHKemagnpnSHQtl/z2mjsKdJeXcxmBsi3vV9XBHfKQTd/VeaS5sb94mpVZiQlI0cRnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790373000; c=relaxed/simple;
	bh=6uLQthog7PnmL5NyKLwP7UDtoL7idAPNPK2kXJfaekk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GFpWcwpOSTOAskfn2Ewu6eHjv2wJllTQR9MCJ6RyXliTv9mmmqkdgZ49FA1OueEf8McKlrMAR2im+e37u1ZP/vbvtV4qeBCq0FbRVORkxuo8Yl9ElzU39hmYyWHoNt9pW2p1wkruJ3ulhpLNAa5zem0vT/wS0DQJiRDVoUmrCcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FvcSAP0f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bWe2Fi9i; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FvcSAP0f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bWe2Fi9i"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 25D38EC020D;
	Fri, 25 Sep 2026 17:49:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 25 Sep 2026 17:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790372998;
	 x=1790459398; bh=K7PZfUHWjOqZRON6Lcm+BYxavMc4p6b/vxy/FtE5L70=; b=
	FvcSAP0fkOx/l/2n22T+MJYX6XHpoAuN9aSG4VxrpmBPUStyaY5FR6t/jAb2lPge
	TSMRRSgE0jhIx2pcD4OfNnmu0N7Jk8saUt2BOmhQjKegIzKBivfwFQhVuV4DqxsW
	cMhnMhDgjT3lGlZbUGYmxncgTcKGGSQFH0xjL3DuiYRxBd8oUkEgYTrtT35vRaAN
	l3cjnTWxrahFCXRd4ODDk6l8uzG8L4f/Go/CFyG132SpIeaSpZbrw9S+kS011d/n
	fM72AZKThTvmqsBpcgSaYP+WNezpcNYv1L8r8PIZGRTsSqX42pXXhHNK37FRtsFd
	JAuZ7rE5UqZ637gHZlySJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790372998; x=
	1790459398; bh=K7PZfUHWjOqZRON6Lcm+BYxavMc4p6b/vxy/FtE5L70=; b=b
	We2Fi9iOpUS9T/qdaz1BuuUY0szjqH+83WVl4U9kAWUILk8ScyIRVu4DtJxAQ4lZ
	1FEfWG+FoMWiLE9yE5zkPtWAxC4/fNopJZ9lfePANajmoAuCyKgxeESY1HrmXXow
	ElylWgBy6v5KbXXkJu/cVSIZFzVz392NwvJZO3qONloaRkv+YiabmY4BMosHL8gm
	swzzus837tz3/fD1HlIxSYGU++rk70lno+pA+1ZUlAgl73/uBBlQvndnSEZo/ton
	g3AFtGs+TJh23zevXVMK2S7VfuENaVUUM70w3zTZ22RgRwXp05WAc8r8gm0vO2fB
	+ibFUcWDN+Ulquyyy8zDw==
X-ME-Sender: <xms:hey2aqoaNtDihZj20r7jr6BLKSM_lsah8bj8-sSvq-E9ME2cuDck1Q>
    <xme:hey2ahFxeYwoutqvtShdHxr3A5N0W2TB-Zz1lRfsFMdCpRANJuJvXYYxbrHooUDv3
    cH-RtOupuIHu2zp8XDUwheIC1xkzgBXst9Qm2SsETnhIDNGJJh_oVk>
X-ME-Received: <xmr:hey2avrZ48hn4WYF-1LnCzY2oskXOSBKLWiL1X7sn2vfRcRRPsjN3ioOPx213Sjln-u0L0G5O4iYsY0K5lj0Xy-CBMzt180xkcCW>
X-ME-Proxy-Cause: dmFkZTEvX7xUM/pSFJ5UMdZuVKwm5FwfBPJ1lAfplW/A8/T0xkBbyDZ/F8nsLs7D2lBAqe
    USg/hcf5wLHiFWoRbPoE3YPnrabSDQncZlcnP9/3bLV7cYA1ZCpZhL6ytHdy/dVLPEPbav
    EFtAR5Ttz54lERNM94cSKhq5BjmIxpCe3X/EPL0tsXOCA+Ou0tRnCQpYRNog2AwYbZGhek
    CCx/pU1Pz2FifbgANtz5ZlDhqadXjVV15duw7siSnj6YjYoE5phnMCUwDOOrPNckos37wi
    IFVRDkU8/Tq3eiwGg62gv/RqGNfq7t8iFumAt/tGM2Sz+auYj6o7g6BeaAzBpkByYUWZZU
    kH31a8RVu7WOjnFtFrbXlOVNWHppDaGpkLD23mGt5A9F6cjGrWxnb9ah0Jn1ja1dpye5Qn
    OV2dSSZ8qwC6fzrB/0ylebwLq0Xsvw5F/g5HAvgdlSDwYzfV0k8QCmv72gINoXN2bWr6SV
    LWr7yl5bv2hnC9lK2QkiGUAKLs/f6j07BtLXPj1efqV5J7X+qnjFFmj/aZiZJmT/g3B/gH
    2IP0ql3RyEAm6oc1PxgPc+f30nP9RkOmUK8S1FfiPfqI0Syp0QV6l5QQi9VVaNrKLjvPeB
    D+ZpJWJ7prrW3A3VoUZbFJ0VZDxLInrJ3Jf8pd8BvbH5v6Ax/QDGvHo6Kuaw
X-ME-Proxy: <xmx:hey2aqY6yGM1JTaiRMaxRM0iBczL5K5TVl5iP7OI8mME2KgBiDAvcw>
    <xmx:hey2aoU7KvUsnXVOvkX_cvi19nA58hEAzDIUMXByK4XT69NPOVZfQA>
    <xmx:hey2aj9MGZf-TtXwz1ecE8J-AkMs9P7g0eBmn_oSbST2tp7dV-bhgg>
    <xmx:hey2ah8VKPujirE9gKWJcL-RPdavQI51XKvflHQJT7zf6X6XMB4ULA>
    <xmx:huy2avPnzbK0Ei4PhheYm7VzbrCE-7PbLkNqVx4T2QYUQeoaq0yoXl4K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 17:49:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Julia Evans <julia@jvns.ca>,  Julia Evans <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/7] [doc] git-merge: link to new merge conflicts guide
In-Reply-To: <7EF35E41-8DB6-49B4-BFC6-6BE335047E60@gmail.com> (Ben Knoble's
	message of "Fri, 25 Sep 2026 15:32:34 -0400")
References: <xmqqld8purb8.fsf@gitster.g>
	<7EF35E41-8DB6-49B4-BFC6-6BE335047E60@gmail.com>
Date: Fri, 25 Sep 2026 14:49:55 -0700
Message-ID: <xmqqjyo9t30c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> Le 25 sept. 2026 à 14:19, Junio C Hamano <gitster@pobox.com> a écrit :
>> 
>> ﻿"Julia Evans" <julia@jvns.ca> writes:
>> 
>>> Thanks, I meant to flag this: the reason I deleted it was really
>>> just that I couldn't understand what `git log --merge -p <path>`  did
>>> from the documentation and so I removed it until I could figure it out.
>> 
>> It looks at the index to figure out which paths we got conflicts on,
>> and then does "git log -p <those> <conflicted> <paths>".  You can
>> give a pathspec from the command line to further limit the output.
>
> This explanation omits the manual’s “HEAD…<other>” argument
> that the merge option implies, which is important for
> understanding the option and my alias ;)

Ahh, yes, you're right.  HEAD...MERGE_HEAD is the more important
half of what --merge gives us that I failed to mention.

And without the symmetric difference traversal it gives,
--left-right would of course not work, either.
