Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35053F9268
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219852; cv=none; b=O1i37woY5bNAnFWpoaRqp7FKnIsNE84Rh0XXBpgKrRFQ/t+N9NPGqE6ygmZTRLFb1AMda4cdZnXEiqZ75+y9EuEP/Yflozg/N1v0JzuUeh0b3q0txHdh3PkN7VtR2Yv6ebsR5DalQhe4fmmQUbWI5te+Mamt3AI6vUx6Ex6sb1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219852; c=relaxed/simple;
	bh=2nApv3qkP//HKMefbyr4t8GjvHxeoRd6+VscU4XSbP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DncdaUNi200QdjmkaIE4PvvPbkPiWn3awipdqrsZESeqtRe8UsySCI9b7TLZN1roFvj1xxHQ7Q/maImggTqSIo5jbQFuYMH8+taKmGABOHf0rAe0wJ5DaBK+MM8hR3cQHrXU9xPWxRW96DHr1cxd5eTeCfgZh8HjFwBLwfR/1fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gnIGND3H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dfEu54DQ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gnIGND3H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dfEu54DQ"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id A1428EC01C3;
	Thu, 16 Jul 2026 12:37:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 16 Jul 2026 12:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784219836; x=1784306236; bh=PXgwQ30IEE
	kLFTui0eN5NU4+vfegaYXHl3icLGABcqo=; b=gnIGND3HYSLAeyw7T4etuDZ+xk
	khyBEGa0y1n7X85kLL44knJhe8GRogFo/3Jlk4jzkn5pXChtwFJoq0Hd7oHlInNl
	EY8bLkv+Ow0UVH2rliTn7N+P6/tRlBwdSZ9Ax/xyuDfqtkWPwECUjQ/3ExbOUBOb
	1IBJNlB5PhPQyDpwoq+qqIwMPTzXwddlEgrQYU1Wcas6M1Y/cjNgbmqfkwmTZ3Nc
	3GuX9DQQ24BtVJBXnuYJgVOilQPj5bs4wFzdegpynqYYbHQD3Hut/lcGQwbIQiXR
	GCma8a5MnRj2zrKqVilj+GZ7NSQlvC2hcoNaPQBzVmVAYV+Ovbh18aZCIBaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784219836; x=1784306236; bh=PXgwQ30IEEkLFTui0eN5NU4+vfegaYXHl3i
	cLGABcqo=; b=dfEu54DQEoTUrjCygwtsJUg8U/NLz3chOZT1b4Pv4QorBK64RYJ
	CKyB3o1aOEV4KX+mH47sFCrNS7xn7sS7e226w4uRL43yMDMC4IMM7GeH2ajqb2dH
	tVsdc3V3nvlAshNpPVAbBs7iycnseCr/B8b/dsgLDf4oJXuwLk9kREJRuCXi4cQh
	Y3rDaCD2QFkK9G4/WKBcflhbQPBeCzx4XePB/3h7LVkCEmY0RRXMjoBNTSOm5C1d
	kQBnBZ5znnvCWecFgYyl7SQdCobsoEIhY3xxJRlTR33AwUdVu2pxl5i1lfsWrT9B
	1yh1ZOq2iGl54g770iBc8OLPVg94xtuMNfA==
X-ME-Sender: <xms:vAhZakcGEnJvRxXW6nxO3QZHElgzSE25tgjniraNVM9zxmr-tgC6FQ>
    <xme:vAhZaiDh9dut6LeHd21JpvpLSOaRGXowVyDQRwd9qzjpiRR74cWsaGvXgM1qx-yIu
    91ubqaNHRoM5WZrfE-go9m8Wgv7JXb-QUrYn8WhOJ3TrKLVGQZscw>
X-ME-Received: <xmr:vAhZag7UxKFg9BhUSefkQyUbGJkKSDJoUFRVPPjFy78qh6frKEKNAzeCsL_HaqukfnTgNnEgAjrwTfmVZE4P6wN5HB8YhuZXGLm5WJI>
X-ME-Proxy-Cause: dmFkZTGURyTaiMRPxP02MfzXHx5X1K/NljySjym500iwhisJEtLyQxYJ4teY/CeSXBuPAH
    2J9C2dEssXl9862vuUl55HS9Qfp6RqG5R8epzPYb0jZOSlkIfJu03NCb4ily+vS9ADxmJp
    WG5M5yrxmdVrKACeghcoOoF6m8l/nffXUBbeNZJI7m0+cAXxeTqTGAxGdk/hF4he5MeS51
    058a20qH8ZDGqJVfzYZOQT6lIuyUAqLiKRYIg9UpZGNntZeAtvMH4nsRYQYVmoL1BnpmGW
    UZg5REgOr2xgVc/RY/+a1fEitH111gkf24gwm2RpGRhcaobmyYA+/rBdvWGPP9Ngedd8FV
    MMCQUGP7n83ofZIve+Sx+YiUPSKhuQmjpdE8rs8Jr3jUML7awO90tH1e/5ab67c/sFIqYA
    m/2ERAIDKeEVPFNEKlfkaWy6tB0UxVpbT1Xio1cLmX980h204mH6Fw7lw7bbUPNpHEyev5
    rYwVtrMcNFYAv1SCYpJZtd6CLwbvhzCAPKpBOq/xDC3LY0wFbUAQHM8nEtEUxGUqz48DZo
    qJRrPv0AbJ81CW7ndfSlDOMSDpysxq0vrPnhgpvTlZVdxlyAo3TXHqMhFocsTONhvIKX4G
    R9vBotGhhDxChNIF8QMTfl3pHTzoUnNHi1upc6RK9lTm5m29jsDeQ/FaOXaA
X-ME-Proxy: <xmx:vAhZajcb6YopWxzbXsOfAsfz6o69Gv8L2PTUd2wo3uWakAJntAmUuA>
    <xmx:vAhZauuW8qLUQVUcYYe52bfWECznGijJG5hJJ8BW-YVxxCC7iIoSSg>
    <xmx:vAhZark1hGpg1fsFLD-ejbURqBd6tGPXAMMvxx8nWi9pQ-VqkD5oVQ>
    <xmx:vAhZapQjtOCUuOyzTFqA1H-v3x-86mIym5ZcOe0aC37ys0MIVMZo4Q>
    <xmx:vAhZai7Fk119J1l7Kjr9Om5kUPoVKNZU_teOXT5l5wCP8TT10C1_mpUW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 12:37:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  chandrapratap3519@gmail.com,
  chriscool@tuxfamily.org,  eric.peijian@gmail.com,  jltobler@gmail.com,
  karthik.188@gmail.com,  peff@peff.net,  toon@iotcl.com,  Calvin Wan
 <calvinwan@google.com>,  Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH GSoC v18 10/13] transport: add client support for
 object-info
In-Reply-To: <20260715-ps-eric-work-rebase-v18-10-34d7adb051bb@gmail.com>
	(Pablo Sabater's message of "Wed, 15 Jul 2026 11:52:18 +0200")
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
	<20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
	<20260715-ps-eric-work-rebase-v18-10-34d7adb051bb@gmail.com>
Date: Thu, 16 Jul 2026 09:37:14 -0700
Message-ID: <xmqqcxwmj3gl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> @@ -1159,6 +1159,7 @@ LIB_OBJS += ewah/ewah_rlw.o
>  LIB_OBJS += exec-cmd.o
>  LIB_OBJS += fetch-negotiator.o
>  LIB_OBJS += fetch-pack.o
> +LIB_OBJS += fetch-object-info.o
>  LIB_OBJS += fmt-merge-msg.o
>  LIB_OBJS += fsck.o
>  LIB_OBJS += fsmonitor.o

Noticed while preparing evil merge for Patrick's patch to move
everything under a new lib/ directory, but you inserted the new
entry in a wrong place, i.e. 'o' < 'p'.  Keep the list sorted.
