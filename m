Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D852E62A9
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784488311; cv=none; b=j66rbPfW2iwo0TX9Wc4aPYorsu+4BChLQte9FFrXaYKcA82xrBltD/oDCS1D/UqHcbtqrmqvoYztDWecOHGbq+2Q45q9w/llgOy2MfGqiMzotFDnflXF8PwapQqDRwqa9QN6nKqdvl58aAIpkURAJ5kotcco4BVPnBvrWKnXdCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784488311; c=relaxed/simple;
	bh=szherZ+2LkcRLS1dRSFPQqUhpV6XfVdkCEqwnNdcPyw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ec9TDmHJD4PMHbCKgz7bnIDDvUx7I2vlnLfxtNnUk1G/f+zXHempB8xKeP4TFYW7FstX44PtjGsFJLygYxsaM0+/Dc7d1KGCVubCUrZqxOu42vAXjp4Fd/U9RCf8GZK6ZoPZJEodrQ4RpDOv4EQftKntuUfOEtQKdmVGRwkoCRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iNeGMU5D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n2tLiffp; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iNeGMU5D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n2tLiffp"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F009EC003C;
	Sun, 19 Jul 2026 15:11:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 19 Jul 2026 15:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784488309;
	 x=1784574709; bh=LdMerzLej/e0LZg5NBR8M/vHVcuHsc0W2e0yu/23in8=; b=
	iNeGMU5DoE/kTNAt5WHoLFMkMXBXppgbafa5uonwef2lwzresSLEylYl049uZr79
	1QNq2To5wdaDXi2myQ8EUrtbOBOFxNmB4LqbXOL09z60AZCoIvaf6M4BMbH3t2Jf
	QVXSgPUq7SW1wAcjVjimlxqe9n8wtF1vhLiLhk6hg9cTeR1YdFSZ06ogmep/FtYX
	gnMD3+SaqM5MpCHtk9DsXnWFNArzPQYo74g1e96uHT4yqI9umLNw8OEx6DsIYu2U
	JpRXmsGZvRSwDcl9MGYgKjsTAN3ujE2hUrmgKjCPGTesW645nl1EzZXU2Ir0Fci8
	Op8DVyym92RfVO9Wsc74XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784488309; x=
	1784574709; bh=LdMerzLej/e0LZg5NBR8M/vHVcuHsc0W2e0yu/23in8=; b=n
	2tLiffpK93XSQ+m2Iwjlpvn5rg/4Mjdm6izlLhIZzwbuGtQzY6HusKG4/iG2OE09
	BN2zVfubF/dB6xegVHCNrFP+RmbyJilzzGToGIMlQ6YPNTl/gtPCeIkZnPg6y0WE
	uoGML4Dm5F5pRXwrCSdnn9Xdi5wAL0HjAxrZCpZJN9/RFfvvP/87xB8GRyVB9R9S
	bzoxEQVZaf6Ft+mVMp8j9uPcJdMrPUqw1XkfNHXKDuwppPpa5hyGgZbpM/3dv+Ai
	x59EWN/KBuzTElC3wvCGzhRZTnY6nBgKIp2y0QTr0HKVFhnsbvzrmd/tOhR3br7T
	nMQAz/1AHKHs6DsUCVuPQ==
X-ME-Sender: <xms:dCFdaihrBZ40nsvGjCoE5-Jhd4Dr0L911dM4HO0LYVKApDJK0WSotg>
    <xme:dCFdaqBQowKbJZQbSZNwX8Zvfh0_frD6UaWYi2slAVXk6uY-gCLi-Tp0kc0NmyHLH
    sycYWvmxgDnCUtekLhIBInP508CnkzPSxS5QCrzzSphk7FrIwkMV2Y>
X-ME-Received: <xmr:dCFdavEhY1uWKq3sANYTjlS0g_U4Z20ruAEppTebKth3WsqL7ZDj7NUtKAjrCSdjxTeeHZoSxlUkLURiZgw-A2KINIPvuSrbZg>
X-ME-Proxy-Cause: dmFkZTGqHjqEabM4/Nz+eeBKAbXPW7QktGsfH2yXIxkcE6shXkRndfG62DCVYrS4/6dPDT
    HQ3ujZtLPkx8+swnqg18GI8xRlZALVEQMhjs5UaaP83yWdp8NKm3EclA4iAFI4YD+1l8aK
    NSoEl6JevIEJTMYhzEz95GYwNltPiIxRdK4/61wP504KpTZBCtRkPWB7M3wsLQUB/hdeLP
    nQoqh8B3hPFeIOOsbNXLcBPToOrm3dc64gQqBu/OaIE5Ev1UH4BnrBziX2WD5PslWP/lT6
    bTV0r3hvW9mU7ViNyQZy8txdKgzLkNQZPsu6eraiybzEXWHcAFpqGF7f3sDGggFtIlY5a9
    BX09p1yS+FzkcVPzCIU2prPuiDP2KVWWg5y+uGyu3b778F46t2ErKcCW4n4Hi/Spp2n/Dp
    yxazAN0nnN+F4e0O7LFmQ56xtMa7YVlxMOLV0zhFV4+4leMDsYg5xnNnWs2MXgU+No60+O
    77q2YOqVl4onk+gE2TyYDVCaZ54MysFso+NPYowILJhg0YxfE516mPI8xkuOoJS6JrRqwm
    9OwfgH0s8lOH8L8hhFn1Ux+MYbaCY1LIEPYYQkcankb6JIXY466EBjDMvE/X/4sRzh9RCU
    hyjnALPMEey4EgcyU5T23Q+whIvtS2AYiw31eNlg9dUxGDAMxweQfJx+JKhQ
X-ME-Proxy: <xmx:dCFdaqIHABvX2C6rShCoKkrrTJHszMK9RYbFWi23zjVE-EOVM3TUOQ>
    <xmx:dCFdarkBeLiHxybGyeBlqKUGtLCFzUFHDX7GVO9EGiCubZldmuayXQ>
    <xmx:dCFdaqQ_x6-berSrsKHmTJP-jgwG1yS4MQhLmIQRD75MFbKxuHIxmw>
    <xmx:dCFdalKEHkZJUQra3N8JcKKpnQ4zoNYQcaKcJbN4hiamHL9pwNHhFQ>
    <xmx:dSFdavCdBJPCzN4teb4TKKUuN20-PBjYAV9ap278KgItgzYXbvlpkIUu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jul 2026 15:11:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 5/5] use
 repo_hold_lock_file_for_update{,_mode,_timeout}() with custom repos
In-Reply-To: <3c0a8031-7082-422a-b474-938418682b60@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sat, 18 Jul 2026 08:35:37 +0200")
References: <20260714175956.54601-1-l.s.r@web.de>
	<20260714175956.54601-6-l.s.r@web.de> <aldYW4TPUqgDMRcf@pks.im>
	<3c0a8031-7082-422a-b474-938418682b60@web.de>
Date: Sun, 19 Jul 2026 12:11:46 -0700
Message-ID: <xmqqmrvmn6a5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> On 7/15/26 11:52 AM, Patrick Steinhardt wrote:
>> On Tue, Jul 14, 2026 at 07:59:56PM +0200, René Scharfe wrote:
>>> Apply the config setting core.sharedRepository from the repository at
>>> hand instead of from the_repository.
>> 
>> We only do this for a subset of callsites, apparently. How did you
>> select which subsystems to convert and which not to? To make this
>> explicit: I don't mind a partial migration, but I think the commit
>> message should briefly explain the reasoning behind it.
>
> All those that have a repository reference other than the_repository.
>
>> Also, as you don't get rid of the old functions that still implicitly
>> depend on `the_repository`, I think we should have an additional commit
>> on top that guards all functions that have this implicit dependency with
>> `USE_THE_REPOSITORY_VARIABLE`. This ensures that we cannot accidentally
>> call such functions from other subsystems that already got rid of the
>> global dependency.
>
> Probably, but the lockfile conversions deserve their own patch series.
> Patch 5 is only included here because it was easy to write.  We can drop
> it and leave the low-hanging fruit on the tree if that's preferable.

I am personally indifferent as to what we do immediately in this
series, as long as we all agree on the longer-term direction.  It
seems we are in agreement on providing additional safety in the
medium term?

Thanks.
