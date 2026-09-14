Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0A7489FA3
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398766; cv=none; b=njA+iyVCSosS6qWar4ZQ0SiZcWa/D/0gLhZyo+QfyJmY1ebGtGpUjx1Ipfab/iwdsbWWPDcqXXfcdZMH4vbxptmrOjztVMahm4AvjJHKLb8CqNnksS4S70mlxwc1Ol7ba93m0CrLzSlwVupZpYLxlcRSsNzq6Bf2uWa4p5mrS1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398766; c=relaxed/simple;
	bh=I7noagZLEm2PXioYCLJF6l6i8sPhi9sAuQnmx9oQxXI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D4+FoBWJnWlGpCFcY8SE0kQtUwLtp24zfek5aVZD0n8r2mGNuv5qdzSuJqeEpO2Irkk1pFi+MKQgseGwVQIbA3lZJdzWeuVls3G+HrTlDxjYGm38NsXFAKuVcJkxwnaWMCwMfZ5fYsAjzxa2urm22ePqWQBthkOvVAJtz3e/Lq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JpWn3Ns6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RXq/dkLl; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JpWn3Ns6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RXq/dkLl"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 669557A011F;
	Mon, 14 Sep 2026 11:12:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 14 Sep 2026 11:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789398763; x=1789485163; bh=I7noagZLEm
	2PXioYCLJF6l6i8sPhi9sAuQnmx9oQxXI=; b=JpWn3Ns6ywQs/oyN2URxfTPV25
	XANZ4DwUBayTcYvuwnQwM/0n3JtI1XpMfmyOueWY18vjwEa4X/+OZFLoGfttW5FE
	5bL0QprXb4SyDL33NItu2N/8lTunrYNWdIk4RMiWscoy3KNtNMcIm9X6cIK7DQJA
	YoT2uyc+ejZiXvHv+kuxnkOsJjWpagxLSJ1U7zeZF4vyEJPFj84DypusYAqiv3aE
	pMZeH4HZpnjW7FWSkhFaa5ViXoQmV1OVYiTDMK2A3QlMAI1pJ9gURycSZlWFoVz2
	RtFA8nAkmtPvTVyYOr4i2NSCcQfkarCWJPCmQ7QY/diiZAoWvYRQxXqjborg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789398763; x=1789485163; bh=I7noagZLEm2PXioYCLJF6l6i8sPhi9sAuQn
	mx9oQxXI=; b=RXq/dkLlN6oG2zymREEq23wlApTskZxfWT293WpvLdvUvCwFCwA
	E50WHAWO9zNDeng6qYjsc66TxpIbx29V/Nzpm68Q+XqZHWhKUhOdh1ktI4sFy1gL
	rU4TS6PmvkpX19/vOEEg2nTHCFRJiZNSgMHpPABvTE4T4EdHV97KwjDnuNr/e0+f
	D14ZEE8/CWnCuOBF3PVfAbaDHiZ/41StnvhoQ4z5vUaB1hAj2YSEW0Vj48LGvT2n
	R7OV0/7/fyU6enq1fZDtH4eOPWBcJbXleOp6+deOr5NGSO3W3P8wmUUtDsFAGZyO
	GEiMq7fMDM+Qy6PflK3WUEsvg3a1A+1Mt8A==
X-ME-Sender: <xms:6w6oavWnsZ7FXHt5kx78yBeP_WnELa5Vul47Icr2dq8YzMfCK4H_5g>
    <xme:6w6oaulhld1RqOhlOj4Lj9lByRjaxRxNgZ9wKqCDXQT_dtA9VvJ_-bIPaKUlSXq7n
    sY5fKF28tLhWMXONxV20KT8wrY0YF-kk19kTIKCR4dsDFklxwo9ZO4>
X-ME-Received: <xmr:6w6oagYUSE2P3SRH3VMRA9lVr9r0Q_j4yn3WAyotDfKrhgnoqaTelcMgbaZOtOyp9JTYABCN5KRyGLE7vjHYJ3p3V5ruAt7n9vuu>
X-ME-Proxy-Cause: dmFkZTFDp9RcDpVzrC4sY1CCKmFHlGl9a4AkJ9AYCsRYqeSdsxVSvQRwRuk7Oy1pQ5lV3C
    KXahzlV5qMBS1/wuM+BUh25ZdivczJfdTZilRdKcYxiM39Udi+tmtNqy6rv/UIHcwB0JqC
    2OnhlG6jmnE/jjal0JN8fjPw9qDgeWotXum3zISseJ1ApDFyHYadFIobzLPcg0BVVlxZlM
    7L5QZA/NL+1+L4JSFcJW0IAQO+32P2DB0ah3lWhS6EgcINHzsmMNjYWYH0DFeXrARXKPsj
    Dj7AMqvfPypDsBhkrb12rywcUAyVGPbxUiNeKNXcc16CHUNHQ2ABnq31v4poJvIm0D9FIe
    PJRPeNMErdAC8Ht2MyUSqxcR7YyOtOVH+DAmGM69dVqUDwWrQ74OELD55YhemcCy6O7Hh0
    Cw8CXWz5KMTarNLyq1GY5QijWpI4UH7oGl4d7+3HKVPgqChdiR2H3Wk5/yDqeJECoQdCgC
    rV35CEmRq0rhxOjjeeS0ogs13T4BDaeCChXQMh+k9MFtKe8SjdF9gmGP0+C7AX18VNe81p
    U1lTS8Myuh2EIQLNz+/BilqD1BcpQL94CDNAug2BEXn4lliHZ027fn1rN+dadF1GswJYN/
    XO6/EsoYoZuxhtsCdkAm6eHdcb/m+KZAGhjKXYQINrwhvSTGirxaFkbtvQhQ
X-ME-Proxy: <xmx:6w6oapP4VSxAwcnBdw6jBrrZXlaive4Gn5wEte6GtHGgQJasHZM8-A>
    <xmx:6w6oalYetGySe7jkRZL4G75sYk29UZBkiUkq8WDhwQr-ZutLbpXMsg>
    <xmx:6w6oan180PXhOpmYIAhhcTofooeu9FycE5VhvcZb9R1ZSNQ7T5SYTg>
    <xmx:6w6oardixKoFnMQwGTlIdaat5v3_qo7Qvnb0Kwz8XaOmMOopBNnK0w>
    <xmx:6w6oakg035ipHTZDPhABPRztatdizokwvFvWexbwsOAFI6K3bl96el-D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 11:12:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH 0/2] connected: add incremental connectivity check
In-Reply-To: <pull.2211.git.1789379276.gitgitgadget@gmail.com> (Kristofer
	Karlsson via GitGitGadget's message of "Mon, 14 Sep 2026 09:47:54
	+0000")
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
Date: Mon, 14 Sep 2026 08:12:41 -0700
Message-ID: <xmqqmrtj7tp2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This series adds an incremental mode for the connectivity check, gated
> behind transfer.connectivityCheck=incremental (no expected changes unless
> you opt in).
>
> The intent is to solve the problem of the connectivity check slowing down as
> the number of reachable objects from the boundary grows.

Exciting benchmarks.
