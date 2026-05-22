Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E818811CAF
	for <git@vger.kernel.org>; Fri, 22 May 2026 01:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779412647; cv=none; b=aBrtCd2bJMvDXvmpUr4iFhxdb0Owo2t+9PPiOuCRnwpm7a9xKCH/DyjpVTj4Vz1qC2syt/7wUnnpJdeVtNjWcWUp/KBWX3DaKV8Ka4YHh+u+INBN+SjIp3ELt0r31ijxl6/ijSvx7o9gBj9kdU2cq7Hpa9/qjHeWr5jBc7pt1qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779412647; c=relaxed/simple;
	bh=w+AunF3y4rislSiwHCw1ZVoA9okLsV/qMYBkhHuIQWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GL0PCYWp9BkVZmy76Cr5RxgtSIi8HSb2iOgiRSrkglQeuTS9A6MMCVsl031lf/4D8CzkO8lKnb416cuqibGQtBPir/BRT+DFykoCfyvkeoyVSIVTleZO/MrWxjSKcKR2XPnBo1vebXM5/zxuDUFY2pcjphVnEb+Jxmxxt2cs+C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WB+1pywa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KDfMKkDU; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WB+1pywa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KDfMKkDU"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C2D657A0055;
	Thu, 21 May 2026 21:17:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 21 May 2026 21:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779412644; x=1779499044; bh=X9kCyMqcZ3
	DF+ESC2TjECS1qkmwbcIVpcMZH6VKtcjc=; b=WB+1pywaT+FJqAouJ/rGPdPrUU
	33fRuFxyRBAOVj1ZoXm7dykWa/3uYFxYQnhrsxu+Dbcb0IoTThFHuYvWnHF1UZp6
	6snaQqZtb0nqeiFmMJhUr4azNEznI4A47pB+1CKOQu7e9/jsYFRoUYsCoPxHGWdd
	jdAO88eMZv7dba3XKCLyrOJxWtlbJ+OSap6ycJtd6yBF//ufg+KGlRA7NLANurX3
	AdjM5s5WwlBHabPQi/2RFtwrc3/77pEUyyFU+sKWiD/rqDapY6KKUZkHx6WMZ/SS
	hOHoZwWLLki8oM2h68SGjaV2j+bMxL41/hK5CCvPlAgfjgkNROwAEADMYPHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779412644; x=1779499044; bh=X9kCyMqcZ3DF+ESC2TjECS1qkmwbcIVpcMZ
	H6VKtcjc=; b=KDfMKkDUSIRVAPj96MSE2tnl8Lfo/QcMhL5QVpxR8zVjuN6Gy0M
	y6InPKlar05y2cK2bQPB+fGIPUTTsmhfrSivSd/FXyfhRYBaydXSmyQ/GXIZfTvc
	DNeMMIn3PgiKSVs78CYJa3LhfK/dJyHn2/2kkI2HRaiKljcXqHwvLwzWRnFgLdW7
	i0I7l0ypOqtIb14U1OLsMc2S2DNKvdYLPmnMBIlkRBUv0kXsxHp6D2BZS5ckUdfZ
	DdYPBGmp2EUw/ALSX8shX9h3aqfh3HleC1I1ijsfIWy7TpyjfpfpACTk+463GkPw
	d3gTuQwkLU5phuQTF+rdX2AXnQVvMy8s1CA==
X-ME-Sender: <xms:pK4PaqXLcLDpstEO88L0nRrTgds5NH3vqSO2ueTwUriDrQDy9BQ23g>
    <xme:pK4Pao335kcHivvuUUF2EpCcsEox817R8YymMe8yGpmsSukk5Ml2kirXpKcpTOc72
    arMb7LSkEPztKD8wtauAVby7--EWeLk1pxIPD09-PVjBW3NfHon>
X-ME-Received: <xmr:pK4Pagrx_4ZaKvAU8kuXxmTkK6at6i4Rrw19KjPtaLzkLdresI5YKohbgE2qr7gf4xS2A2xrXn7siz_fAuZm0NiLzbC7kof5RA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeltdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrrhgrlhgunhhorhgugh
    hrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:pK4PanULcN3jikFaH5CekbZKJ-nZfoUZZB4xv0-EOqNSFBlH1qwGcA>
    <xmx:pK4PajbTkEDAqU-f6tXrq2Da_9p2znN38KuPtnqM_prWVA0nedLT0Q>
    <xmx:pK4PasfRgXf0Iw-jzkWH1UcTQyWyFgs2HeSLQsGAOVk3F_QOKrLXuA>
    <xmx:pK4Pal13De6C0VSBfVGgcrsHvi1OjFekS_H9a1ruIqiGUyK1yJa9GQ>
    <xmx:pK4Pat4c-o7U574-Y5ACudWSElYy0wX6BmWpJV1_k_cta1VrxxPIqoJM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 21:17:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Sixt <j6t@kdbg.org>,
  Phillip Wood <phillip.wood123@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v10 2/4] branch: add --prune-merged <branch>
In-Reply-To: <718e28c7e0120a826385189213cccec1f0fce1af.1779403204.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Thu, 21 May 2026
	22:40:02 +0000")
References: <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
	<pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
	<718e28c7e0120a826385189213cccec1f0fce1af.1779403204.git.gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 10:17:22 +0900
Message-ID: <xmqqmrxsxmxp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +`--prune-merged`::
> +	Delete the local branches that `--forked` would list for
> +	the same _<branch>_ arguments, but only those whose tip is
> +	reachable from their configured upstream.
> ++
> +For arguments that refer to remote-tracking branches, run
> +`git fetch` first ...

Please don't.  

"git branch -d <derived>" checks if <derived> has already been
merged to its <upstream> as your repository currently sees it, and
this makes "--prune-merged" inconsistent.  Before deciding to use
"--prune-merged", the user may have sanity checked if it is safe to
remove by running "git branch -no-merged", whose answer hence user's
sanity checking will be invalidated by your auto-update from the
upstream.

It also means that you cannot prune already merged ones while you
are not online.

