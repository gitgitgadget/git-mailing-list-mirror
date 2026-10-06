Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19C641441E
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791290668; cv=none; b=gDPD0pdEUe/AJWLhh+DOJMpMgvzqF3FzVT3JIiZCxcCU9F6iOKAzggqg8+LVkTt4vlc5aIQvBVFx6IHQDTInT3vbScDWEMEDGm9hxiih0Uw9soyvTYqpxYt7Z588I61I74PIYkyqudXLaYTH0WubUp0Z/5w3ZsHKvJ8d7I+gg44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791290668; c=relaxed/simple;
	bh=l16I6uT9898TJ7k+18NxKpnygwgFolwBEvDqM3OfLMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RoBl2Q6V0fRACkpxKWVoT3P3LdDmH7FfS1HPwI5sa5lrcBuDY0A0NhvCgpqhUHBTJuLqQ38EFCenEKE37EhEe1dTAxpv9ktWBgkgs+uCSOht9j2cQy8+nEAT+D8/31qZsRh6vZgHfgkfa62j+cXjp3dQ3QCXTOrj8SOemH8pCy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BolxGMZS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g2KWC+F0; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BolxGMZS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g2KWC+F0"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E07A814000DA
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 08:44:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 06 Oct 2026 08:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791290660; x=1791377060; bh=jSb+TjlM2I
	cxsW7LjI8ql5N5FzculPuAdBMQNM1Rym0=; b=BolxGMZSpcVqlKii5FzyDN2Xpe
	N4tzKCP9k44zJaPc0l+x3HpEWxaoObmvCDG2ET0PAI76ZcatRdzEjqV2f22GpgBk
	gL2q8sjcX2AUVKf5wU8yaZ8QYAfKaE5rFCyWa1DlpPMHveXAyb9MQ6/sUDkcZgxm
	a2MYHdxOq8rC9AD9G8SV9cc4JcTHF76WOkL3tD+/Crf5xk+OSjmzZikntVMpGV8u
	8de+Or1022iJvlj5wdvQcsLeLHPZvceVMViDbZMnhFa3DfvMWmhjSxPGfTwjezoj
	u0tHk9ZyBfSsWhF+rMoJbvRHcsLuUmpbuDEWChiuxo/6trX5tF2Z2gV5oOSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791290660; x=1791377060; bh=jSb+TjlM2IcxsW7LjI8ql5N5FzculPuAdBM
	QNM1Rym0=; b=g2KWC+F0RdZ1t4XyE2BLQdXvzW59uXcqAJAyUMCGPW5NbOv2bRD
	zYjO2rS6fbi95ob0rVtxY6AWYxy0dDV6x12y0N94hxCQraKmecjqHKPMBfjHwCu9
	ZG5w9FG3ZS2HDqXksspIyONuRbtY0g90fTX/bAWio8VcJCY/IlCwtWS2G16tvVjl
	KTOzHQeFKRZRvYSR+0HRWo9YlmTuZxaYjyuLg0cEFzKZCfj8+o4Gg8bwIPglWZjz
	0gJiwJrcQTj3Y+E0D9PnGmn0p92gg9Ra4cqWVrBHykU2ZpkF6Tv2grureaQLoDC4
	UD8eBD15SAz7gcgSie7a614XjKkjnQpCDNQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791290660; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:CEFJI6r+MCCGZLe4WuVI3l8qZjpaVc/zSOTm+Fo1i32+YMX
	StNY1EN6PEmsEHDccXvWHmColrA15XAdY1AXTStEMp/S5dkVs8fotKpUKwH4Nkbj
	eWmYzRCWhGvkTqh05r8mwBstmSKrQpR2FMC08oHhLjkRIOxVZrQPdhzaCMj9aMLP
	j4pN1azbAqwdvqZ+BjbdGDG4WzXfwQCN0xQJivEwo6tVifd6Dj0i6Nsqh/Y0yyT0
	sUZVrxNUsubWA4riVP04o+8kg7VUuJWq2SEY+Vp4BGSYV20kJM5EkjvaBBSW8tKx
	JZKxVB3ECwjJmL5l2al4/WIt/CHVMnmPSJ5+DPA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:nzXdpDTJRsWxD0GIAN78cKY11B+tv7MPg0mtq2Y+yoM=:l16I6uT9898TJ7k+18NxKpnygwgFolwBEvDqM3OfLMs=;
X-ME-Sender: <xms:JO3EanwCiKcSz4zzyzqFB1Vwhw1h9jCKdFHFuNzKkMAS4qDFvabq7A>
    <xme:JO3EatGElDIQRcmU-YceM39dN9f55JALeJr8mZvuZLfb6k8AdKVAvMTcB396_JStL
    WGIUKkjUe6iElVPt1YYCzSYOqGeNFTzkeCHWKYO8mZl0AvCum9_0yXM>
X-ME-Received: <xmr:JO3EaryIfVQeI0jMKUeLrlnL30cssQn5NP7fNpjAQgv_Oo2I_hJ73URO_KghugUeLRB-vaWWhSdyPjJYH396tY_oR7mLXgTUAcWJ>
X-ME-Proxy-Cause: dmFkZTEBzjtyKenRzP4ML3oMWP/EEDv3JSKlGCRQhDCr+1lxIXBc9BXlDI6LGl8UhSDEQp
    g9eV7tbW1vA+UupX3oO93EpKNQkWpBZ8mblPXnCIfSb8dVw2sRHhWUPyzkldP/CM2uxrCG
    77WNmBd+kpbz9DCFkkwt4XhMRdzRTAstmLlUokXec4UbkkVgce00lHlTYWn4ZoD2sL3wm7
    oYbwdfPCQP9UsmBYy/1K+72e1uVUHf0d3HuF0GEqa7Y+XGqfVq0WXo0NuRuJwtF0uVH29Q
    IFOSW8lD/3UXb8ix0sK7eaNHH7JcZzBvaADhGqeP4ErbGMObi4RJ17AUL2A3mRGB3SdpRO
    Se0BivANYjjkre/b4rAhlYmttrA9jkRgxUKpNZ7vlzyGJ2N7xXs+tNx8ej3TKuJg8nX0K0
    PZSqwuYj+L2gl+nWqlqirQl5FpW0SHjyFxKkpJ8S7UQahzgQ4QqLr3ddhNG36QjSrZsiUr
    vTKkuQ0DUcQ05qv04OXqNWn4Md6UsrSr9+ce321AXdqjkqEmlxKXOoDnr63GMB0SfiSTdh
    eU2rHYam6waH6wherwd3GpVSAjQIkM+AJ9tKJxnSBki1tmhn2P/xCtn31j/NjfP6ZaVx7+
    ALKwn53y2jWfkcSJK2VHYCcuu9GTzSMdqr9hhTXMHg15P5u6qgR1cLKvWhfQ
X-ME-Proxy: <xmx:JO3EauttMiaX55lEFFQNd9QSA6KvBvJPiHI82lhD_OZU76T00RWuKA>
    <xmx:JO3Eao0CyTjwNjkst4e6ht0NGpBxpXOfT-7SAPokAYTK3gKgGkonMw>
    <xmx:JO3Eap-qCYHwNT5l9dG8ru1cldL1e23KYBeLAT1Lxt3xFzF-GxzVgQ>
    <xmx:JO3EapMSD3BpHf9B8nMLUBxCIVVeIA7qdV1UkNtugK60N-nig3Q10g>
    <xmx:JO3EaugXMHV4uySnajymfRA3wAuZiDTT3hlGkso3w48o2kP1r4eju6PG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 08:44:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?6YeN55Sw5LiA6IGW?=
 <kazumasa.shigeta@kanamei.com>
Subject: Re: [PATCH 1/2] stash create: remove duplicate changes detection
In-Reply-To: <1617d92942d283017272ca6f27f1254f8f9389b0.1791218125.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Mon, 5 Oct 2026 17:35:30 +0100")
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
	<1617d92942d283017272ca6f27f1254f8f9389b0.1791218125.git.phillip.wood@dunelm.org.uk>
Date: Tue, 06 Oct 2026 05:44:19 -0700
Message-ID: <xmqqpkxngfrw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Before it creates a stash, git checks if there are any unstaged,
> or uncommitted changes. If there isn't anything to stash it bails
> out. Since ef0f0b4509 (stash: optimize `get_untracked_files()`
> and `check_changes()`, 2019-02-25) "git stash store" has checked

"store"?  Aren't we talking about "create"?

> unreliable (the scripted version of "git stash store", called "git
> update-index -q --refresh" before looking for any changes).

Ditto.

> Avoid checking for changes twice by removing the call to
> check_changes_tracked_files() from store_stash() and restore the return
> code handling in store_stash() that was removed by ef0f0b4509 so that
> we continue to exit 0 when there are no changes to stash. In principle
> we could remove the call to check_changes() from do_store_stash()
> instead, but then we'd need to pass in the list of untracked files.

Again "(do_)?store" -> "\1create"?

