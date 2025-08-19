Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A77A3451A0
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755639461; cv=none; b=RpdbJQGcfHoy1xXF49sU6jv0rvQH9xvtgWHqygtKtElEjuVik95h6LASZ4jmCl8XDmis0/bjkK5j3efGmtZ+6LMnbOE3s9bUaSzK2SBXKkgxAotv726RO+oBDII7iQiZnj6hUou51RqsDzUUrV9+s2FxXDiYo/9XlUCSVX2aoNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755639461; c=relaxed/simple;
	bh=6VLNe0+n1T6TMgukO8SslWOzAHFyPPYPYae0Y8lnzIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lB0VA+5WgT57hje9djnPBLttoWwgeXPbRr1QnoULVQs40Q7103qcDNORGOkbRVtjSzU4ucj1QnEHJ05gxIy9QYUWAC4XV2oeZE3AhCw/yd8k2evg29QBMtJmQ6zrfyONTngVwJCgljtJf6b6qHpCJMpI/xBoBoFTyMk894Gtdec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i3Et8Sd0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MB/+lGdh; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i3Et8Sd0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MB/+lGdh"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 05EE514000F3;
	Tue, 19 Aug 2025 17:37:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 19 Aug 2025 17:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755639455; x=1755725855; bh=q50kZttQte
	SIwNFee1UKDHwIweM2mLuTcu2hWOO4L+g=; b=i3Et8Sd0VaUOs99g+7ciOlk0i7
	Mza1elNBFtspA8PSYcJoW8MqIq+xrgp0svl/mxVzFXitfRFEESGLo3WNLh44LjLE
	eL01G8UNR1YaG51kHyRtVGvXsTU1g481xVHdEpCx6EiVUAGZP7NSw/8FxqCqphb9
	WMo9VPRDIXZ2E05u0LrS00HRXcRPbAC+GnabHbOFp0adkmP4fCxOnqGAU1ktI3cT
	jwrHCwbZQCFx6Ak8M3ufXZeBJmQW35wElJEo7er59bXz2eUfjIzk1zR524rLiHsk
	gREIL6uPzo4pbAh9la9FL/ZmDttqKGmOwUraqJoP1S+Gd4F5TS2zBeyA9Z9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755639455; x=1755725855; bh=q50kZttQteSIwNFee1UKDHwIweM2mLuTcu2
	hWOO4L+g=; b=MB/+lGdhuFYOIUcfKm9Vby5kBnaAnc4g0ir2NIEcsSd+S6H9UxG
	APS1YFz36S9Dy8p8MJhQKXKDhfgQR2Nr17slTU/kspN5ALgmytpvO0Dt9IbM6d0C
	tf1Jd+SP36EgbCxVvaLAcaI6T6G9l2Y3v1jTsfoPh9tsyVx4BY9xxQr6gTO0sZD9
	JmMzxle2GuZWAFpU7JGXtNzx94zN9ORYeTjMJpMKoGWISdJyp+3AnparNYLNsAo/
	01MxjAyjNwiSi2ommuA97Ir4BPbnFx3eeRHufXuRWtI8Aqbj+mAIGdXmO68WpHTd
	pRpgVAlVDaG+jtDITeo/0YCS3GnjRvlgu5g==
X-ME-Sender: <xms:nu6kaK7bkJXDBjTBfGaQ4cHZSE3d1U5prfll8poPF63GLVe66ijH_g>
    <xme:nu6kaA2bANBtDrWihq6BcR4ezpmZJv1p0y3ddMxJs8wWHfaST7kSRfXOmt6VsW1u9
    _JXs-Vf-PwAX-RtZg>
X-ME-Received: <xmr:nu6kaFHQdMYVmRaFQOl5zqOXRgvdl_e1IhdE6vy6nstsPJ1mN_oJ_0ALPbo_-I6SaS6A-B7MPNiFwpT9dbAYOBf7OrecUdVvv4G6ksE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeiheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtoh
    hmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrih
    hsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpd
    hrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:nu6kaPgG0OPIFuXp984gOpKS36elEQSq73TUPKDQMKYX4VPp77ycXg>
    <xmx:nu6kaIDFLUP7WI1vGJDRDac20SUBjS13S5WH7vuY4SWQwO5v7-88Ew>
    <xmx:nu6kaBRosU4AjoPrB0SRAAfnJT_Byh129Dz4IY8jlTVtfZ4b0Qfb7Q>
    <xmx:nu6kaNUoL2K2UfceDfQ9EbAljxtG8dGQnEq2prbvVLnq1pPJ5ctVFg>
    <xmx:nu6kaGtU5Paks1ZK3DBPBSa17tv6x3teRqCKLJcC1ognlyL38Cro38Ff>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 17:37:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Junio C Hamano via GitGitGadget'" <gitgitgadget@gmail.com>,
  <git@vger.kernel.org>,  "'Chris Torek'" <chris.torek@gmail.com>,  "'D.
 Ben Knoble'" <ben.knoble@gmail.com>,  =?utf-8?Q?'Jean-No=C3=ABl_AVILA'?=
 <jn.avila@free.fr>,  "'Julia Evans'" <julia@jvns.ca>
Subject: Re: [PATCH v3 1/3] Git 2.51
In-Reply-To: <011b01dc114d$201c45b0$6054d110$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Tue, 19 Aug 2025 17:06:20
	-0400")
References: <pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
	<pull.1952.v3.git.1755636370.gitgitgadget@gmail.com>
	<c44beea485f0f2feaf460e2ac87fdd5608d63cf0.1755636370.git.gitgitgadget@gmail.com>
	<011b01dc114d$201c45b0$6054d110$@nexbridge.com>
Date: Tue, 19 Aug 2025 14:37:33 -0700
Message-ID: <xmqqfrdnc7s2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

> On August 19, 2025 4:46 PM, Junio C Hamano wrote:
>>Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>---
>> GIT-VERSION-GEN | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN index
>>be801415bddc..64cbc5833536 100755
>>--- a/GIT-VERSION-GEN
>>+++ b/GIT-VERSION-GEN
>>@@ -1,6 +1,6 @@
>> #!/bin/sh
>>
>>-DEF_VER=v2.51.0-rc2
>>+DEF_VER=v2.51.0
>>
>> LF='
>> '
>
> Will this cause a re-roll of the git 2.51.0 release?

I don't know.  This is not something I did.
