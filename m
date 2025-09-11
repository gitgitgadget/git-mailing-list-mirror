Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45927362095
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610147; cv=none; b=MDxpZRb+r4sn1ZyCLBXbTWCTvdoyQ67kHDBswnZlV5jNpYPi2bt1FjuwTGgF1fV7P4fzw331sEruRXbdkFnpVg4hCgMkjYgjDXdcMJQgQZX0Sz/0G4ncNrmW4t1LN4NH8gaZYM46UGXL1T600EaZJwBJPVR282tMEiG9z+MStgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610147; c=relaxed/simple;
	bh=JTILwjAS9w3RnkjhcTq7CdmeuNcaI67pSki3fTY9o60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PeVJT8hMboqY7CwmSKup0z4gY7sbAmm+rbNWbLX5yYRSTsKiPF5L7CXawohWWoFWyIqDLG9tYC7ZtYu/5CXUoN/9yVGtVoo8w9U+fETJtP8JK4q/OZH+GOA3W2wDByapPFSZd3RoT61ha3Fpd+J4NKCI2imLCGwmr4gHTDcCpsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0ajkbjav; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KfBEQqtv; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0ajkbjav";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KfBEQqtv"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4C8DC7A03E1;
	Thu, 11 Sep 2025 13:02:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 11 Sep 2025 13:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757610144;
	 x=1757696544; bh=sxdJ8/bWUaeme4784Ek4dIeKIwzkYhdqtWfBOmYoM2I=; b=
	0ajkbjavmvhl3di+b5ndCP8Db8TmkWPQBWUjeelomdoTAQfcdAuBj4IZHjjc+qWL
	zPbYn0EMKOnWKTtOhjyFiSPHPjAhyQBPrFcZmfpzc631DRsv1zSmW6zJuFqh3BDP
	4TbelcfyPAqNJA6SGYdaKtOORUNmnXUREHXkbwhGkRbM+WoImhFsXQ3VQU75iy/B
	+wSHrvuz4m4fQkStvTPtCUaAUoQcWRR7YG0/oHKgPO5yiJpManhz5iq+VeS8lxoZ
	7215WQMJwgaUaGHji96Uq/yfNcpu2PRd66/xvxXmNUE+CC5HlrUeavCxVFch4sfW
	SUtZJvLnAMrorNUw3xktvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757610144; x=
	1757696544; bh=sxdJ8/bWUaeme4784Ek4dIeKIwzkYhdqtWfBOmYoM2I=; b=K
	fBEQqtvI581qf5Z8xjw3UcMvJxnXbno+THcTWhUWr2O1LOdDHFCmxRGT6FRAl+Z+
	7QowrTgt9vxQeBZX/D/skCV3ojkOnhp2RpK3M/KTFImbZFloBt4pEjgAlZkpC8hJ
	UAdj6PKeDIuBTzYUJZiXIgefkWvBvUrj8kkFugyhQBrtT5Mhy+Cghpg+HgQZ447v
	dvjjUN1PewZPF7L2XZcfUmwgmKptocACH2RiH5mYJQoUGQ/AKN/1EpDLSNFJ6pxi
	rdLm2XK2KYWFcnXbLeA/acSs1uBUR5cuXBlvfixdv7JjjW/xXm+J6csN0bDjRA9t
	h2HBRluaVIMuu9P/ICUlg==
X-ME-Sender: <xms:nwDDaGmdR5SCHjnyv3vfQOKwvxfsQTv-BWmh8PRjW-QCviaswozWPQ>
    <xme:nwDDaIZpoBKcWoyl1qbb2Nxk7zq9xbWpwW4VRNUS48ZZRQvHGEZELPY_IGuJ7oleM
    tLE0pJdtyZsoCyFVQ>
X-ME-Received: <xmr:nwDDaBNgw2EhrgWDGY20cDXuWbZMXMxxjJYWpf_c54ofg9Bwrf8Csu6GIEYx2IzNSkv1e0b3jaxhmSWsdJ9Qr6m8RcCpgBpVpozq9vU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvieejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshiivgguvghrrdguvghvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nwDDaNYvRuFBM8vimgQL_3jbbYQVhSvcQQyb8IjTpVhC1ZggTj96Zg>
    <xmx:oADDaP3vuvUogKnpb_wrwXy3-gc3t51qfAfJ4SKPrvdWKU6uBsVETw>
    <xmx:oADDaDeQXL9ZAHJHGv5h9oBHZ5VZpXo1z82EqimPIs5ArjNAQbu--Q>
    <xmx:oADDaAG422PNT8pxHuMbicaKp4dzLOooGm6lSxLJszoTZ8_AF9_nkg>
    <xmx:oADDaJ1DEbT321uCzFKPTQkdnsPyYIlQr0xKCDgAOFUv1VR8RlT9AQ8N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 13:02:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>
Subject: Re: [PATCH 0/3] ci: don't compile whole project when testing docs
 with Meson
In-Reply-To: <20250911-b4-pks-meson-docs-target-v1-0-a92c666ecef9@pks.im>
	(Patrick Steinhardt's message of "Thu, 11 Sep 2025 11:16:05 +0200")
References: <20250911-b4-pks-meson-docs-target-v1-0-a92c666ecef9@pks.im>
Date: Thu, 11 Sep 2025 10:02:22 -0700
Message-ID: <xmqqwm64orc1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> these two patches introduce a new "docs" alias into Meson and use it in
> our "documentation" CI jobs so that we stop compiling all of Git only to
> verify the generated manpages. This fixes the issue reported by Gábor in
> [1].

There are three patches ;-).

The end-user facing get_option() is called "docs", unlike what the
"make" side understands, which is "make doc", even though internally
we call the target internally as "doc_targets" (not "docs_target").

I wonder if we want to let people say "meson compile doc" to match
the other world?

Will queue.  Thanks.

>
> Thanks!
>
> Patrick
>
> [1]: <aLCf0UaTxy5Nxpv/@szeder.dev>
>
> ---
> Patrick Steinhardt (3):
>       meson: introduce a "docs" alias to compile documentation only
>       meson: print docs backend as part of the summary
>       ci: don't compile whole project when testing docs with Meson
>
>  Documentation/howto/meson.build     |  4 ++--
>  Documentation/meson.build           |  8 ++++----
>  Documentation/technical/meson.build |  4 ++--
>  ci/test-documentation.sh            |  4 ++--
>  contrib/contacts/meson.build        |  4 ++--
>  contrib/subtree/meson.build         |  4 ++--
>  meson.build                         | 10 ++++++++++
>  7 files changed, 24 insertions(+), 14 deletions(-)
>
>
> ---
> base-commit: ab427cd991100e94792fce124b0934135abdea4b
> change-id: 20250911-b4-pks-meson-docs-target-56d8a21e84bf
