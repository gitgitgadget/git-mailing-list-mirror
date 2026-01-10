Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6D5285056
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768066367; cv=none; b=EkmtnsnCfYAh0+efS4ECNixM6/YvFGJrNKPF34hJ3yc7WuLMT8Yk0p1p3FpVKvIlFcuAtzxoaxyB1cc4mly0tEsDUK7bp8anrFkf8NCU/9zv4F32p/42/H9YTjQkw+qX/4NNmf8AlY1fPJQ9KUSxm4X9Id+sY0/fxK2CN9P7mmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768066367; c=relaxed/simple;
	bh=KDSSiyTr9kkgJkf/2WIey9a1V0ZoGi0WNFzt9eXYoQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cev6OwYhbLQgd+iRNXaSL2f213HA3F0Z5MJpwZG5jm+JJlDEGwlDdiMLCGgSL3RLiKoYbCn7t9jTSVm7yxHS/+TUhueTzAZExVn+K1IKuMACwiw3H+Lh5zrBIztG209Y4aUym4CZkR19C6qdUdj7Lby1ODt9UFv+0MkcbHTQb6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nJKPuZVm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b7EzXmX5; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nJKPuZVm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b7EzXmX5"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8C3251400057;
	Sat, 10 Jan 2026 12:32:41 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 10 Jan 2026 12:32:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768066361;
	 x=1768152761; bh=1IG6fy1yebyIzJRKn6LvT3UdOiwTeOgQZpkwFy+0En4=; b=
	nJKPuZVmwpGCzIuLVnPg3PaN1abVc1LevAsEmLk/xwrJKQrsrp2mN3Xukv4R57rX
	SS1ReZN9lCgoiHE1ZG83diQ/qHyq6wmNEqEwlE+aYudfy/D8gXnpCnIwmQ19/x8b
	J1rZKm0x8b1vfd/bs3D/OQTgWWAN9b5rLRyZ1YrRTbgPFiRed3vMVMwTUE0Wx9tK
	azQfQbMG77LLb1Sidmz0mGfWuBJHcL2L8Gz/FGoRfzsju9W6CffHJviiI9P0Y6A/
	Rn/VmPOZd6P5mHsCB0uMEA9WwuiH9ZVOIIPYxg2XrQk0aF4CMeJ1KItoIu6fv7vd
	Ltd1RqDkOhcWpw/yIYY8vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768066361; x=
	1768152761; bh=1IG6fy1yebyIzJRKn6LvT3UdOiwTeOgQZpkwFy+0En4=; b=b
	7EzXmX5XDop71ol0XVnN6ekMnbG8D6tpyEV9/jIM4tZ51j/GXpnO9jhRekdboK9I
	w0qePTmwb5Bpk2RIkze/tHHCR3W8VDO54dX+N6rssVmdO4WJlEGXnx01do8k4JOL
	u2O04u+suf7xA9Ffbb4LkWkft6lMejHriGiDIZPBGTqycUM4gjpfhG+/abBAfHwt
	haN4OsA3sNTcKchJFjVwi7fNPduU9yNIo4HVF4/qYX8FF3w/+Ix67nHMKvujIGo2
	FTssexDfsoKUOVx4t4RRx7fi/hn4ZYcb15CewVx/FsyaQLkCpgNP17r1a1NxKoem
	am/CWq0gNRRb0fqrnCxpw==
X-ME-Sender: <xms:OY1iaXBNX93bWii4mXyQCIvgbDLdAIfdKnZl4cHRa6PjstQ6LDgvmQ>
    <xme:OY1iaUZ_k38Q2DQ9682PJgsj_u_J2hzj29nq1gyZ61E-T4pucPWcxI9a9WgEg_6DL
    7YSZ53faI0pfyWKcUYKMmQLP0Gv57kDVqhwMVyXQs5FQTBxjVgq6g>
X-ME-Received: <xmr:OY1iaa6nwIGg7Ms0vEsCYSVaa_igHIPPWxrhYsbaGkgxeB8Q4Cc5QU3vYjR23jFSa--73xaxJP2NaTW8yT2XggY-4qGDnM5-hZkV5F8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduuddvfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehleefteffledttedtudffvdejheevieejffejvedvgfeiudettdffjeet
    gfduieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrh
    hsthgvnhdrsghlvggvshesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgv
    shdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OY1iaVbjtlMQerGEv_jGQo2xu2vPQ-VBz24gngJ-cwJjcQura8FnZQ>
    <xmx:OY1iaZjMe1F2OnUey6iiyZf37NUz71ISqU8iHH8S57_mteFsrN-D7w>
    <xmx:OY1iaW8Go1uKAkHaWo2M4xUewB8DkKxBSRp5QRb2WJUMenXf-2qH2w>
    <xmx:OY1iaUq_vgJklnKsJWfSmJ-sCMgq79JC--wE2E9XWv2wxSghuynxag>
    <xmx:OY1iabx2tiNpHCj8re3LkeOxc2iMEA8MZeAyVI4jITYg0OFXtejkf_iH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jan 2026 12:32:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Karsten Blees <karsten.blees@gmail.com>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] .mailmap: replace Karsten Blees' default address
In-Reply-To: <pull.2029.git.1768043204134.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Sat, 10 Jan 2026 11:06:44
	+0000")
References: <pull.2029.git.1768043204134.gitgitgadget@gmail.com>
Date: Sat, 10 Jan 2026 09:32:40 -0800
Message-ID: <xmqqbjj1s79j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> As per a recent email by Karsten, the @dcon.de address no longer works:
> https://lore.kernel.org/git/77e768b2-6693-454f-9e11-fb0acdec703c@gmail.com
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     .mailmap: replace Karsten Blees' default address

I noticed the address change in the latest iteration of one of your
series, but did not check if the new address is already in the
mailmap.

Thanks for tying the loose ends.  


>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2029%2Fdscho%2Fadjust-mailmap-for-karsten-blees-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2029/dscho/adjust-mailmap-for-karsten-blees-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2029
>
>  .mailmap | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/.mailmap b/.mailmap
> index 7b3198171f..3cf26b1add 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -140,8 +140,8 @@ Junio C Hamano <gitster@pobox.com> <junkio@twinsun.com>
>  Kaartic Sivaraam <kaartic.sivaraam@gmail.com> <kaarticsivaraam91196@gmail.com>
>  Karl Wiberg <kha@treskal.com> Karl  Hasselström
>  Karl Wiberg <kha@treskal.com> <kha@yoghurt.hemma.treskal.com>
> -Karsten Blees <blees@dcon.de> <karsten.blees@dcon.de>
> -Karsten Blees <blees@dcon.de> <karsten.blees@gmail.com>
> +Karsten Blees <karsten.blees@gmail.com> <karsten.blees@dcon.de>
> +Karsten Blees <karsten.blees@gmail.com> <blees@dcon.de>
>  Kay Sievers <kay.sievers@vrfy.org> <kay.sievers@suse.de>
>  Kay Sievers <kay.sievers@vrfy.org> <kay@mam.(none)>
>  Kazuki Saitoh <ksaitoh560@gmail.com> kazuki saitoh <ksaitoh560@gmail.com>
>
> base-commit: d529f3a197364881746f558e5652f0236131eb86
