Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6061EA7FF
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 20:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753906035; cv=none; b=E7ipWp4jYJNhAeItPVlUMIA6VDY7JQWWn7koZMKrpb7DIyPruAN9Kjk3eo3V/5m3YPlmCcm9KLEC/hJ4yl1XEim8pKFW8Km3GEDE0MYdGZ9J3bKx1lPYzlXIkBENCLfqZDJXXtoORIMJR2m1bdmsTqKulZuuF3XkFKIT+N2kJyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753906035; c=relaxed/simple;
	bh=PczEXYSaSXybMvIIMMEN8iarYrqqu8PckSHSGpB07rA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KmbVU7IY15DbvWEnRWE2KUGSHlr2OtuBishGeoyONq8P9tBiM9OWtFYFuc0gpY6bq6j6Cd8ooWhnCMVQIPS1WNejslpaeaZGqb1hlSQxStdInS2+0HbczAxyvfUHUpI8vuhByNkSm3/281Zm+9MxpV8fgvcT3rkqcn4bj07qlJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QVfO86Pn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TEwbeTFt; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QVfO86Pn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TEwbeTFt"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 95354EC2219;
	Wed, 30 Jul 2025 16:07:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 30 Jul 2025 16:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753906032;
	 x=1753992432; bh=lFsytEslBED/LvegR6963ZKpn9M5M1+RcH5166eipEM=; b=
	QVfO86PnN4Ab0Pq/DLj/cDn/I5APnk1Ybhi/9/Goeebl3CWWnh7A9MpEwvCAjJWE
	MJKbxZO8+ezXdeiBZPFfBQuYnwNZIMxZzgm+zyqa4rF+Lx1YLIdhaixFKbdINWaA
	+43z3IpNTnMXm5qQZ43KyGr6UWJ8nF5rofCcUKti80t1Yxl6uzTJVpPXrcowX2uS
	fWk7u7ZLyZGI7waeHkI9c+Op3FrQ+T6W11iIBhha2W6rMFZwrd7wtG2Fr6zkdgJR
	+sbxR4u7nLoJGjLFIdjY0AbTU7+24JIqa5LaF5bMFCyyjK8gdWvSdva1TPFaLEmo
	WpFxGBumZGJnb5HwBrIzLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753906032; x=
	1753992432; bh=lFsytEslBED/LvegR6963ZKpn9M5M1+RcH5166eipEM=; b=T
	EwbeTFtcBt2ZcVMrnuVcFdJkQ1jvGudp9NgXBpmvFY8qQFxhI2j3ItUUVrtsEPQn
	Og8RNB/WUkG3oKHKau1SbKEPTNs0SxNR81M8TWDnTAkXvQ87FZ8Iz6Rg5CXf4E2F
	W+TO6F3uPHAG4a8rp339wKs15ncS3VMpTOtpyj7Bts2q6wP3l+SJjuF6GelcJa3p
	SMqHhqHyNveP+Y7TzwC4R0Pq3PbTYCpHpr4s1ou1LozkM6wuiWQ8+ssHLoGZTYzH
	qiry74tqe2RfX1UIndT50C2T/kADN+I4tzbZBB8DZELWOZnD5IYEXB/QQwFEyAvb
	s/xk7zGlgpvyNAaVePbNg==
X-ME-Sender: <xms:cHuKaD9iTJAKXJyoefeWgxWRhC8oq0YUV17vhLT2sZ-0lePWSoz6dg>
    <xme:cHuKaNRKIjBQg4xjC3S-CrVN7BYqYTHI8fRKUNFSlH4Dj-jItmbOOx7Go9v-AkKY9
    fiZOhcaIsqpkU809A>
X-ME-Received: <xmr:cHuKaHfC86-5geUxx-VJ2mLpFCCL18GWGGxYo-xCyLAU4UPbfPUFDJ2DWeW1iWp89GeO04KvFIdkwJemxI3yfeDx9GA7DRhDpJJV8-E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheithes
    khgusghgrdhorhhgpdhrtghpthhtohepmhhlvghvvggurghhlhesghhmrghilhdrtghomh
    dprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:cHuKaBCL6ap7Qc3w2RM_AOvs9tj3vRmZnMYnLyJu0CQsYETfPk-SZA>
    <xmx:cHuKaJn1bf15RxBPKzNWqZaD-FtrYHRbsolZj-3tt84TB_RzTTMK-w>
    <xmx:cHuKaMdjXz0sn24_MIS5WJOf0nS76_cDCEeljDX4NQQuqOt1f7evNw>
    <xmx:cHuKaNRAH_GiUnjOPWbbNmjCQ4DX_Lrdj5b8XuXRoljCJESqXxCR1Q>
    <xmx:cHuKaJzakpXdD0ApX9BqISyF5gX_ksQCYnVcaXK1UUCeA-66DTchsMj->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 16:07:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Mark Levedahl
 <mlevedahl@gmail.com>,  Johannes Schindelin <johannes.schindelin@gmx.de>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/5] git-gui: remove uname_O in Makefile
In-Reply-To: <20250730164052.15371-2-carenas@gmail.com> ("Carlo Marcelo
 Arenas
	=?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 30 Jul 2025 09:40:48 -0700")
References: <20250730164052.15371-1-carenas@gmail.com>
	<20250730164052.15371-2-carenas@gmail.com>
Date: Wed, 30 Jul 2025 13:07:10 -0700
Message-ID: <xmqqpldhl9xt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

> Last used in ae49066 (git gui Makefile - remove Cygwin modifications,
> 2023-06-26), and unused since.
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  Makefile | 1 -
>  1 file changed, 1 deletion(-)

An obvious improvement ;-).

> diff --git a/Makefile b/Makefile
> index 315888f..a87dc06 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -11,7 +11,6 @@ GIT-VERSION-FILE: FORCE
>  	@$(SHELL_PATH) ./GIT-VERSION-GEN . $@
>  
>  uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
> -uname_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
>  uname_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')
>  
>  SCRIPT_SH = git-gui.sh
