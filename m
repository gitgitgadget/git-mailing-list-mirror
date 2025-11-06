Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF851EDA2C
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442900; cv=none; b=cMnE6GsWH5CvlvSOVMDlrD+YN7fLdn0rLBTOACjd96Gqg9FWzn2T1Nfaxqs+hTfm5a0Ab5PQii0+qZ/mYje35Iwjtip64VeiLUNcWoXhTn8NV7rd0PKPmcSQO7Tey0te3ckZiNxyufy33NFPOJZ/9sTzppY9/3F+Zby7kX1hHnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442900; c=relaxed/simple;
	bh=12pSkvO8n0oF73S+MhBmiH8rjC8YaR7v5adj5otiCDA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bPwpHzMPoCjGL7f1GD5VcNG6Xb/BvTWd9HL8wdGUh4VogDzNg4iV/pdnCXSNhhxeseVCfjIgRu38jSt+//Xz8BDRwONPY6zGdCmSmjZUemluG1PVfuXxAmKBYQ6bg5vfbBgAVRoktwzicQRodTV9zo+9GRv07vk2qaZxZ2GCs2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QWqy0Oil; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hpy9c70M; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QWqy0Oil";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hpy9c70M"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AA84D14001D3;
	Thu,  6 Nov 2025 10:28:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 06 Nov 2025 10:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762442897;
	 x=1762529297; bh=6ZreIC1Vp7IiyuZAEVTgtGVy2ZVxlNiX9fVKcYxuMOQ=; b=
	QWqy0OilXLZT8y9DiPBt+vmwmyD5Rgk+ylmKxzz6DZNAJ0jI1obqQkuqfuLLhs5B
	5Y7r5B5ORV1mjdnjWuCdItVwjYWGmpntPo0BSH6GkSAlCEqywc4KKGej6o4Nh0gG
	pgGo9aG3R4XA9mAlSxHVjWONmNqEViM/cACChMXd5qvOD9ftliVphUCeFXIu7PmV
	pD5ie7SX7BKlxbc287HP1iWjz1w5PmxxiPNSPVQnle8U5RPM6X325VznKOJq2Vjg
	Kgh/bN+bBE0jGAF3yu2x8B/lNJkwg4t+oe6eGtgLuWdSDT9Rju+WClwuIgpiHlCO
	DQppM2nAE4NjNkdR46eHzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762442897; x=
	1762529297; bh=6ZreIC1Vp7IiyuZAEVTgtGVy2ZVxlNiX9fVKcYxuMOQ=; b=H
	py9c70MVRXJGiXB3bSTG72wsmXL8Do0bNtWT1cU+XYWzfEeig3IVuhodAE444rc4
	cfL9TmYq+5TK+8THuGRNJ3GmCkeYafiEmZjOqNdMGpHOxDHuqSluwZF542siJhYv
	XO5WjZWid/i7eg1ZY0daKRxX6o8RBYPGstAbWVzBal9GUKGeFxe1uqDHDUt/YemW
	L4ZSRv1X/zaefz9E62jL2MqWPfAiaZev9uis9YBE7i/i57ulxFgF+25ViPXAt0YO
	3LJdjDMyTxkMfPY2+VIfVk3FhQnCxkbaOnRpUXZZJ4IId2PFZlwsJCJLE4cZwdoG
	8SQj1qIjHbWVZT5nvv1wA==
X-ME-Sender: <xms:kb4MaZ-oPHkZXG7eb91MYPCOejT7uWiHQ7oobVMCIjL5uygzz6W-NQ>
    <xme:kb4MaUmME46ofZaQ_cbMfWqN8t_sxH8uddm--OsJdn_viFdnXRmUWtaTNWNi5qBY2
    XHTrAuLl3CXNuSsMGJ15nXJ0DonocOV9JGusNpmj7CCPznpBNc846c>
X-ME-Received: <xmr:kb4MafXjulI0voeNIg4iK-bVNjiNbET221XO5IvFlrMWNi1Ac2U1t6uBOaTwPNkfLIfSNQ1ACw_MAG0sadRCCBMY7e4TC_bqhNZ2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeejudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefghedugfffvdelveejgfeggeehfeelgeeiudevvddtfeekffeuhfevvdeh
    ieegtdenucffohhmrghinhepphgvrhhlrdhinhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrd
    hknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhr
    tghpthhtohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:kb4MaZFX3kMlie61awPiWKI0iQYahDiNtl9KqIhdwJUc0RLYoKnFGw>
    <xmx:kb4MabdLGVUenwUmUmG03xw_MS4Da-sHXucCqv8sscgp_0KtMqmSEg>
    <xmx:kb4MaaIAfHiCAXMP3WAhwi6ZnqeQeTeIE2JWRZcxQXiXtbgWNTFvVA>
    <xmx:kb4MaQEZ7xxJSKpTlWEa6Iu2F7atyOFPvE5DiYsPqVgppJCYyUVXBA>
    <xmx:kb4MaQV5To8Lo1eng6U5gOgWatM0mwdUyzTXlEttUJEM1B5yxFwQi_ps>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 10:28:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  "D. Ben Knoble"
 <ben.knoble+github@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] perl: also mark git-contacts executable
In-Reply-To: <87BB8F6A-7176-4C51-9F36-BA613E7D8B08@gmail.com> (Ben Knoble's
	message of "Thu, 6 Nov 2025 09:07:06 -0500")
References: <aQxMmnzPR6swvG-d@pks.im>
	<87BB8F6A-7176-4C51-9F36-BA613E7D8B08@gmail.com>
Date: Thu, 06 Nov 2025 07:28:15 -0800
Message-ID: <xmqqikfnji40.fsf@gitster.g>
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

>> Le 6 nov. 2025 à 02:22, Patrick Steinhardt <ps@pks.im> a écrit :
>> 
>> ﻿On Tue, Nov 04, 2025 at 01:14:57PM -0500, D. Ben Knoble wrote:
>>> When install git-contacts with Meson via -Dcontrib=contacts, the default
>> 
>> s/install/installing/
>
> Thanks. If Junio doesn’t mind the trivial fix, I’ll avoid sending v2 for now :)

We'd be in pre-release freeze starting with -rc1, so no need to hurry.

>> And the change looks as expected. An alternative could of course be to
>> rename the file in-tree to "git-contacts.perl". In that case we wouldn't
>> require this special case at all. But I guess that this here is good
>> enough, and there might be other consequences if we renamed the script.

Heh, I tend to thnik that consistently naming any Perl source to end
in .perl (and Shell .sh) is the right fix, but anything in contrib/
is allowed to be sloppy ;-)

