Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDA122AE65
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 01:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785289299; cv=none; b=bOBMEuppojjJotRMIgNL7PPJjl05A+6eIQ21T4aWmfJ44cWZNbJXjKQxhd5flpg0lFAwHkdspAF4dqvpqJLJ/FizdmIC9Vb+soLu73K+8XOsSBLa61GdBCyiTlEUB1+sYAkY6N1PMnHi3iQ2rjOEhm2Jt6GG1KoXMdM0Fo1zPy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785289299; c=relaxed/simple;
	bh=TpTvtzATG1h+Vs9byh6WIW+nV3sEO76qjV8esxsV5IY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B+0x/WMzhuwo6tVBa9iSSb91N3OlamLOyLlTc30k4U4JquoP/8hKGcDMf6nDB9ScJTinfTXjLfRRLQoedFOUeG3mcfbX/j79qj9X5QHXOcmuKKlA0NYhN0m0iydc0jOeU/VG/dfwhDAMTdweQ8lCAil7bNxi6Wuw6YS7opVU6A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vjmt1H0h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q3GrIOE5; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vjmt1H0h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q3GrIOE5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B116214000A7;
	Tue, 28 Jul 2026 21:41:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 28 Jul 2026 21:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785289296; x=1785375696; bh=872BofTdED
	tCK9Y+I/RIQlh9jGcfnJE1fhKniWP47vc=; b=Vjmt1H0hS1kqTdD/RpMyPKRN6O
	yLYrzlw5oU8sp+I+w21iD/yEW5j/8UI5ysC23FwvwiMINMoyH6UgG699AiqWl7wn
	bN9CT+LRLHrbpLTuunRmmByJHtp9D4Qmpra9jhhC9iHbQ9oOQ/CJZE4y2DwWl8UW
	MR8EQD6a+ThjUhPwUXNoHMv3UYE2xJuQnSYpXKFOw9Jbmc3c8C88Rs+ulqh2PtiN
	VfPKIEeQSykSzBsNaNVnZDiZ7PSOLfnm1l8R5VAvLofiL/0t2WE8xty8Hh78K/zf
	mBLhvg1LGqOdwNN2G18ZmK8mfI17Kerbs8JZhVU4VQpVR5lax1n/02XxvZaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785289296; x=1785375696; bh=872BofTdEDtCK9Y+I/RIQlh9jGcfnJE1fhK
	niWP47vc=; b=q3GrIOE5ww0Re8aBbSSZzN2IrxP1Pc/htg53kPCJV6xsCSTW7JG
	r39TmthooZQOq49rk+XM6EvrAzuxyeSIH/T85Pzf05adsEoSrMZM2LuIO9Fks4co
	sQlvJLx+R8H7wwsxbbibG2XNC5Wfg51wojg2E8EtAdwNSZTVKOwuOfPS3genPsm0
	Dg4XaFgX18716KVfSTEo7RzQ8nJFirDRlYeOXjv23tTYfrQ7uO2BO5IT1wBVD/go
	jUHzau5jAeAvjVJBiSnedmeFJ5RThxfgiOoC+2frlQud3e1XQZEaKMMbMxyyL9fp
	6qFbBo7u0eptt2CN93Q5eIEhklLJmz/g4Yw==
X-ME-Sender: <xms:UFppal_bZ8VnJ2u9lHPgTHHsY_qwWV503moqyC56h6VwNEf1q-cNhQ>
    <xme:UFppaoy8TIjFn70B-ULws5YaMGy3mgK6U6vh6g_nrVMuFDgDmIxMwWWtSydTwGOsD
    I1BgSV5ZJnFGwq74J49Nzb2Z0_KeYsg5Z3E9hBgLRzk5i5tDF0Bmg>
X-ME-Received: <xmr:UFppapPNrsZUQ3qKxf_EzG4ljWwfQhSrvN5Z-yw9uM3uum6E_gETjxzNqcCBMSN93iGc0MmySuGOrbbOcPbyd1kGDxCh9Cf-DA>
X-ME-Proxy-Cause: dmFkZTEDeA2OnSJwRsK32+uwIO7yjz8nzd7b8hASY3qUAWP2MoZRnz2zuSYl8ondOHPoLC
    jkdQJ2B8ZH8INooNwiNCfa4e75CsPfoNx4qKayz4qG69/I1ZBBGNPbB2+/zTW19Pe1ZgxC
    Y5VOvi0MQ3uiSpYfo1qJb2Rl9UQ2hZ8xwWOVeuOz9qn0GEXg5W28h0pIrtMSngh+F8FOdB
    PCZlx78ysp+JKBNqM60n+uXIVrwpGMK2KFiOu+kmAEmIh+W5GQ4/Du1oryowJAESoSgS8U
    7pJekayhqbsLP3BfqOiD9p+4YUs6VjCRCkQb8q3bEFr+b1RpdqaOu4aidCq1Zm6VHo1mCQ
    thB9zGleAYznhQGwQDAOyHd/iVat6ywRelFzLuKZVZopyOMm3Y1I45Cg799+CVgEUc/7Jy
    R2YpyyyKHMnFM+EMcIxcXhd0g/AAZnSRCMCvY3oYk34wtM0JVUgpLSznY/dtzgVnDXhK8q
    0qCFoLIQyowcANThWW5Jvj1kpxp4yf3KOcDiChcU6SDI2RFdX9I2iL3XPsAF2VfHZTQVYv
    Nj6o9TVoe6eXWusyi1tqICmXU4+wO8ceuyYL4YczPYGkdg1onYx40o8eep8mLPzaR4Odss
    v00g86ldvk0PhQ5dX1hEXxDp02jWE1urC4tZ3BEeRvdtaF2Zhq7oq2320OWA
X-ME-Proxy: <xmx:UFppal-3jBdV9JthF2tIEoD45_wKOjawUs3WxeU_RlcoJbPSKo9oRg>
    <xmx:UFppau77ewm8g5nLqMx9Ipe2Sd2r3dLbjl1Ea9KcpXjC4bKa3SXtLg>
    <xmx:UFppaj4WQvIaIl3SR_DSwpqTj5jVEttHucs4q59DiYYWWep58DUs-A>
    <xmx:UFppavp8Ck6eFVNG9z3alQr16Ml0eIreWwUdm8v3Mr1CnZDdrqXPQA>
    <xmx:UFppakOTAdjpD5be4TDjMRaqt0FdH_rf1GM7T5nIfEUGYMm964bshDVv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 21:41:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: friel@openai.com
Cc: git@vger.kernel.org,  peff@peff.net,  stolee@gmail.com,
  me@ttaylorr.com,  ps@pks.im,  jonathantanmy@fastmail.com
Subject: Re: [RFC PATCH] index-pack: optionally allow duplicate objects
In-Reply-To: <20260728042550.91133-2-friel@openai.com> (friel@openai.com's
	message of "Mon, 27 Jul 2026 21:25:32 -0700")
References: <20260728042550.91133-2-friel@openai.com>
Date: Tue, 28 Jul 2026 18:41:34 -0700
Message-ID: <xmqqik5ybmi9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

friel@openai.com writes:

> Signed-off-by: Friel <friel@openai.com>
> ---
> Applies on top of tb/pack-with-duplicates.

I am really reluctant to take us in this direction.  The last time I
had a deep discussion on this was with Shawn Pearce (so those who
knew him can tell how long ago that was), and the essence of his
suggestion was that allowing malformed or invalid packfiles is a
slippery slope.  They complicate everything, from delta cycle
detection to ensuring that repository data stays healthy.

Changes that help us detect such a broken pack as early as possible
and prevent it from entering your repository are very much welcome.
Changes that accept such a broken pack as if nothing were wrong, not
so much.

Thanks.
