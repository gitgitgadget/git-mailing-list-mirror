Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8A736656C
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875623; cv=none; b=muAhW79meyWec8BTQ41htvk0aEj5EENuxre0xJ2XHbR10tRroIgw3bwH3S88gWbxIH3JSNPBBI5o5pThYoJfnAbXTU9vPdnOzeUf4UUqNLlOmqtRDw/dFVIbc9tPrjartqF1JGU1zezfJOd0qYz8rnwivsdyMS7fN/XI/i/DoVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875623; c=relaxed/simple;
	bh=WCR9c3r6yG/wVDhj6iVmC60A8YHtnQH1/o+ECkPsVt4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ScSGPp/ioKskW/46qfEpuChINNJxkaPm+GLKKYpJ1KJqiZM3bkthsPA0WKvhhw7vBLimAZkn38lEehoCPfaSlRQDoKl2dV0csB8FUiXGS/KgVgS6tNFbB2Tjy8q4KeBTar9oBLNZbS4BrEwc9WR0fM1KsGbxCyxdVGVxtlaOcaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sqj0dss6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rkwr1C6d; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sqj0dss6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rkwr1C6d"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 43B411D0014D;
	Tue, 11 Nov 2025 10:40:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 11 Nov 2025 10:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762875619;
	 x=1762962019; bh=E5ardnxhb0eUmJ0HVIDK3L0xWK56hYq5rGKB/LidFbs=; b=
	Sqj0dss6/as+xLPSha7SA4V0iHFeibpNdZTC1Y5Kf2uZtOkaazpNRxVyBuBULzkq
	slrY32ns7IHb7QMjJquMLDqYGaVA+/hNq7fnoAuB9KJ2Cp6pK5PoTg0J4a8I3pUc
	uhc7ZnVkLnigfKs1LnvgjmYVm+6OLg5UDo1scKlyCtVfP1En6KiavScUrgJaTwSB
	UWWRwsoiYXw3ubFUk6vw0QK0+OaQ8+NwKkcnJhuvTfU1dfyJTKItcvmUChXF+dBF
	y4hyvpLXIodtQZqmnXNpgsRhVh34etJrzaZw/78NZE0GivlyaN8i+zYjex0oFk2j
	pi26LQUn0Hsm4Fe+LyCoyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762875619; x=
	1762962019; bh=E5ardnxhb0eUmJ0HVIDK3L0xWK56hYq5rGKB/LidFbs=; b=R
	kwr1C6dI0qgMEwuJEneV6Ywir0TJAKBFZcJJ4C+2ovJ6P0Iqw+THpMiBqg+grYte
	asThGEDXoUk1OeAky4iXFi2YNSxJADkihHdXMKJ1bWi/MB7VNoQIk8i/UprCj5th
	V8vgRki2Fk5ev3EsI0KIclB08BughS8MlcxLrRIVYmvg0kzzsFjRD34KtckrmBkI
	iiV2qbXlRAv2zuocMwJwXnErPeZN2GIC3JOaTZuFosdIEaDwn2rNYV0X0fb/x2pk
	KqJS+CDtQvZhunWkSaEAdst75whJAcP4tG+nJSYoriZrcur/dhV6XN4yt0ioE8yl
	kWFpQi1HUcRwciSr+/AUQ==
X-ME-Sender: <xms:4lgTaSTj_mQii3FTV_fk38o_I8KtpU9aZDHh1_L5tklLulpL7rpcQQ>
    <xme:4lgTaaASl5wlfFWNIgRn6-EZfVWbJicOvPvtoDgDvs5WxIlx1vE-eKs10HZXCK2Ni
    UBYdPjtNgRA5K_N1fRIBgSHqX97CeBs4RrCYsOT3ChWC2i9vUw64A>
X-ME-Received: <xmr:4lgTaSGK0j3P2omb26jaNw6LkBlFyxDNFgvAauqVQDSxyi4OKY6-61IfUz2W7ZQ_5yKuu94ap6z0xQ5qVopXWEsP14szmLG1Pupm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdduheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrughlthgvrhhnrghtihhvvgesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:4lgTaUDk2f1OB5wm7mABkFobjCv11zINlY1Mz38tR8MnjMAyRkjKvQ>
    <xmx:4lgTaaWDjAst7tQzgnDJZ9cabYnD147ymPwa9LgN3fwLjYkdV0AZBA>
    <xmx:4lgTaQqrg-1adolJuTv1CxjGW79cTlWxQnG45n4hnXQzxgTmt1hvsg>
    <xmx:4lgTaeQqzTlqCM040KxCS04CNDQ3i2SVd-voEryh7h3-twHY-nrVMQ>
    <xmx:41gTaUFFz3p0_B8EByjmhCPSCN_EGzZNpH2B64Fp2zAM6c0dRqcuxr9y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 10:40:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: ZheNing Hu <adlternative@gmail.com>
Cc: ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2] commit: add --committer option
In-Reply-To: <CAOLTT8SDpVfk8XqOJDL1=ASJwLf8EYtCo05NS3M2zZUx9JV6fA@mail.gmail.com>
	(ZheNing Hu's message of "Tue, 11 Nov 2025 21:36:31 +0800")
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
	<pull.1997.v2.git.1762793782815.gitgitgadget@gmail.com>
	<xmqqo6p9zo8f.fsf@gitster.g>
	<CAOLTT8SDpVfk8XqOJDL1=ASJwLf8EYtCo05NS3M2zZUx9JV6fA@mail.gmail.com>
Date: Tue, 11 Nov 2025 07:40:17 -0800
Message-ID: <xmqq7bvwy3vi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

ZheNing Hu <adlternative@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> 于2025年11月11日周二 03:22写道：
>>
>> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
>> > Co-authored-by: Aone-Agent <aone-agent@alibaba-inc.com>
>>
>> What is this second author and how would its presence in the author
>> list interact with your DCO obligation?
>>
>> How did you make sure that whatever is in this patch were not copied
>> by the "agent" from somewhere that we cannot copy the code from
>> before deciding to send this patch?  The "cannot copy from" may come
>> in different shapes, from "their code is proprietary" to "their
>> licensing terms are not compatible with GPLv2" to "they welcome us
>> borrowing but we must give credit to them", any of which we should
>> be careful to avoid.
>>
>>
>
> This was automatically added by some code assistance tools.
> I indeed forgot to consider its impact on the open source license.
> I'll remove it right away.

Please don't silently remove it without answering the question you
were asked.  "The tool adds it but I disabled the agentic features
of the tool and everything readers see in the submitted patch was
what I typed, with no agent input" would be a perfect answer.  "I
did not consider the ramifications of use of the agentic tool, and I
do not know where the code the tool added for me came from, so I
cannot be sure I can contribute this patch to the project" would be
a sad but may be an honest answer.  "I cannot tell the origin but I
can remove the line and claim I wrote everything myself" is not an
answer that we want to see.  I am sure that your answer would fall
within the spectrum, and am hoping it would be the earlier, perfect
one, or one close to it, but we need to hear it.

Thanks.
