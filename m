Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8405E363096
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037764; cv=none; b=ONJ/a61abiHzU7Av61YB7uNnnnqHqv5D6GL2fbmiT2ryOLcFhaLx14pqF2ZuPS3ywXjSCxyQiFQQWZwGbc3JpD5cMq889oshTLcjTV7Q7VPkbLaZk+0K0ngUBitubNW+8yb/bfEs3oywvm7CkwkWpJtSOWy2eQoQ9vTV67/g4CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037764; c=relaxed/simple;
	bh=kkcRDEP04HD74k3X3GGekMsRTdbebh0Mp95wOZttv1c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M7Axqn9JGyIVI53Mn9lpaEq7Ed4e9QUGIpTwsqmrygsCd2JZU6Fv9ZqodMsahuHQMTKNQVKkHrd1xccBy6OeJpSgRj45Owg/5IHd+dzyVUDwWErhYhpesGgjsL4rOz3WwNByr8pwE6njImELI364glS4jis5Q04sp4M1Dkdq5AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=av2LTQwy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XiByylSH; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="av2LTQwy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XiByylSH"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 668E27A00C2;
	Thu,  6 Aug 2026 13:36:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 06 Aug 2026 13:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786037762; x=1786124162; bh=kkcRDEP04H
	D74k3X3GGekMsRTdbebh0Mp95wOZttv1c=; b=av2LTQwyE0JhYkDsX7Ne++rOsU
	ec5JPD3NWjq7h5r9bcVTS3JW7iJ8Ph57Yh+/XnAeUiijLp6FE7TWaKIQsvMqFA0a
	Vh1GnKP0a9cNZV1hHI4Tx+G5l0qbW5fCUtwsDE2TAvqo/eyh6YsysBcRzjETgot3
	GBh4p4Gtpg4+OwCZjB0uGtxfYKcOgKlhRtwniMVlWGCtQD8LkXDUFTHctBZqRERG
	eIV2GAfsxdB959T4QLMumrarRy4JY2C1QS3IXSY1G6zl7oKowBYU7eNbG6Rfs+dK
	tNQi23ikVI1iGBfSDRwPXftlhIjThAo7TVzcyQU0UgeyKNOanhlObiDeS2pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786037762; x=1786124162; bh=kkcRDEP04HD74k3X3GGekMsRTdbebh0Mp95
	wOZttv1c=; b=XiByylSH+m7jy+oBc8P1HULPHAVs+pmulFGtyNi1iCs/c1m/b0T
	PGVXi1+bSvQL0FWkC5mmZC9QGMEt/F7PSQSLNn7B5MlwPhPNq1NT2IphJUHdY8LP
	zlbgyB2o14KFO2BNS/x2ewmLhWLKbfS1Wnw1oOl+0j72bQ9ZwlEhPhcNX2fXkdbL
	2vRLShMQy/6k0AHomcbKRxl9f2XhYyzzAM14rw7fKt7oqBcWkLG4KOm/SFup0nZl
	ux+G9h/ILE82tX5XLK0TW3EEaHoHAKqwsxvKhd98v4fbQe/ohXpRtcznBj71NgtN
	0FiF8sQiTjJMEatgI0ft2RN4+3VMXisEsmg==
X-ME-Sender: <xms:AsZ0avkbNWuxHy0SyNNJDpw5NjU4Au_w5AP-HburtTYIs959DFgxcg>
    <xme:AsZ0apuFdy_j8NjdLXlbN6Ufazc7izzZkqOUaRnWU_AVxRuz53ow-dt4hXB4r8egc
    I69N9ORLfjfWfcuiNCWXQvmijEIrNXxaFrmn6Eeb3DLAwyBUQQN7Ws>
X-ME-Received: <xmr:AsZ0at-348_pc37Xz5kRDoj__UIrxVLwBasjApidhX7sBIAHvNns0hXEnCRZ6yYEJDirAa0xxuKJbAocuvqCtCZwWUNAtUWsTA>
X-ME-Proxy-Cause: dmFkZTEeJmjsz8KrGE5S83hfWOuPwxtbXNaNyZ/+ibpbJczfMqiWc4OdC5PAUkIZfuWBgP
    3N6hCtB2ovDdHVSszRG4X/1BbUMFGcg+cGBJJsZO+Z16PaY89Y1NaZnZT7sjcDjA98lQDQ
    RjIgMbzYQkg0ZqGX2wFplD3uQ3dt2Fu6a/oTacTLVDMH/Y5uDbTlglWqdXg1fQK4XRfYU/
    txRAFUTDaIka7hl7R4f2jEuCFm4ZGdCs6+Gi5vyspWTfR5sQzhlYidlmOs+WiohCB/1TT+
    bx2734gO3ZP562E5E69ZQDL0bhMxOpoySs4dhI7vrPinioJSvGJQu6kkd4I5PjoARPQCfz
    OlDrtyy+OIcczGmluMY3AXakgeiZ8cSVZBVAy0hhbWOKbb0Xwl3oDuMBkiTXrNP09E6zWf
    Mg6xzdnW3hxU4mbfKIcbNxTkbzabXzHhmg6ecInliGADAQPZFVxp9QyllrzaifxvqeVW7F
    I5eJcl79LAftIdZy/j/uYd5VZ9g0yldjaLynouR0xYvJxFrPg4wLJwhLwf4dgat2QAspE5
    1ZXlYkAQDrph/L+r3ntPpTHljbzahCCBSmosAeeaY6V6m78gBDryvvbAlTU9f0IR6YTsaL
    wazsDsYwRljb42IK5A9igx6JCc+maAioY8o3WnEHEHIWAU7XPZpqDt9W/zHA
X-ME-Proxy: <xmx:AsZ0ajPOXIToAhgFS5cwb8q5wzPLfQYvbXbRclz1kWK1Ok4wwkwYOQ>
    <xmx:AsZ0arFa30JPeLtT3Xa39xVEwaTm5kVvJbjjEK84BG9uGJv1jcmjcQ>
    <xmx:AsZ0ahT9vEEpQ8PlN5iVJz5WMskk_-tpU6sqyTvkxGfYcndUOmEwQw>
    <xmx:AsZ0aosBgcUMX2l0VViPiMy8ajm8oGNdtAj9B-mT-gdZ2OnKtm5mFw>
    <xmx:AsZ0au8rZLgzTUVXQ5yyAc6t1pW6jsYWRXAO4nUGTsFWgGm7TE7b_IL_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 13:36:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 2/2] bisect: add --reset-when-found to leave when done
In-Reply-To: <CAHwyqnX2wUsccqwmp-3WTsZQOcq0VV2TGHMPEpgKsGxOcH3sTQ@mail.gmail.com>
	(Harald Nordgren's message of "Thu, 6 Aug 2026 17:59:17 +0200")
References: <pull.2335.v5.git.git.1785663075.gitgitgadget@gmail.com>
	<pull.2335.v6.git.git.1785705860.gitgitgadget@gmail.com>
	<97a4da55374c6dc52e6e990b3cadfaaa86a57640.1785705860.git.gitgitgadget@gmail.com>
	<xmqqjyq812wr.fsf@gitster.g>
	<CAHwyqnXOno2De_eOvH=LizyfWSpyVWpzGBwV4ZGW4bxOEtETOg@mail.gmail.com>
	<xmqqik5nmk7s.fsf@gitster.g>
	<CAHwyqnX2wUsccqwmp-3WTsZQOcq0VV2TGHMPEpgKsGxOcH3sTQ@mail.gmail.com>
Date: Thu, 06 Aug 2026 10:36:00 -0700
Message-ID: <xmqqldajjgn3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> I personally think the new "do your thing just as usual, but then
>> the new code cleans up afterwards" structure better supports
>> anything new we will throw at in the future.
>
> I'll take this as not needing any change now. Overall, I am a big
> believer in the power of iterative development.

Yeah, I am pretty happy with where we are with this series.

Thanks.



