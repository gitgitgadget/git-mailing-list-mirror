Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B4243E079
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 17:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224153; cv=none; b=L4tOwZC6Xn1o8X0C02v3EOwTazc6wptvQRcezHYPdmajBFuVHOiL+zCmYaCJZ1JjoMDpCpemD8/OK6X3GUWW1y2ZN37Aq4s+Uqoe7y2bgGMJXrlY/+ht2C7EWsCf53eSF733qtkalWmy1OeW4SNERmQmBRna2MsQIQBO6azr3iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224153; c=relaxed/simple;
	bh=XvJk3Di9QZi8yiwlTtojexk8OSt6wPEba+9/sD8LpoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JBaCde2B9kFwSuFN6XzBUKIBuBizVyRWLtqH08CrZLwDDubKeZ7oazd0WuhpjitaMn9vKlgfutTbbJJOWL84k/N9B55XZrnFNvlT6nJayWV74e20/XYVRmL36DlERXxG/r6J2KH+2OH8uZ5TcjtlIiUz/jJw/bs5xowQayk/1XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=APHIOryo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AW/HBlVC; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="APHIOryo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AW/HBlVC"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 36869140005D;
	Thu, 16 Jul 2026 13:49:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jul 2026 13:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784224150; x=1784310550; bh=GkjZiGv/JL
	Oi/j2Sne0ihaYSERoIxGfFINVDnBmm8W8=; b=APHIOryohp6YQlcW236rcs5iUY
	R18xWVuBIxd2TSSwyHgo3CA8LHcPhNeKKJ9c46TnJz3s7YjrF2vFA1wxmdqt59zM
	fXED3kRpR0iEqgIPG+hI5seikuPMPFRICog/moS2DyUdUZcGALjPWOav/AjHInxW
	OK3/Mu7Dl5+csJfni3EFM6ETMvM4m0KBKQiz/etr37zzfZf6TZSsJ4WQOPr9xsQ0
	qX4VoXA/Q0xxrYeBkWzMEssXCO2lUeSA3dfsOn4UlrJSL7kPXwwnQaFo6MQMw2Gg
	emCYhAjIKiv+YJM5JjxweCd2bRVOhtWtglstJVLnJQ+26leUzQb6cAU8cdtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784224150; x=1784310550; bh=GkjZiGv/JLOi/j2Sne0ihaYSERoIxGfFINV
	DnBmm8W8=; b=AW/HBlVClpslidxPRgE2gewTvR5guz3RVq/zAuL+uQ5SbO93TjU
	hUFlTkrUd6rgTv5jaKCwxVBTjhsaeiZ39WH08kwhCLCzu6x05vi2s3oqKCAeP+qI
	ggNqfmQ+/oHUCReezXU8GsoRKKYJFxGhxJPUJcQen/CDZdwl9IVf8ZvLgnmynODW
	jO/n+dI6GkGK242MmzugDclmxht+2J07E6mKDyYebuZQrPjmvHFEa8+EcojSP5mj
	TXmd5pQy2ELQL0Xa82A+YgBfiUvcdpjoDK2Y/Fbp1giw7AmF0KNqquQ3g/k6nyHk
	GRJ2wKTW0OmLXbCPN0BaUCqTAM6Xwhp1Qkg==
X-ME-Sender: <xms:lhlZamITZQdyqz6bVZcmHlDWX-6g37CZvdNRQB0VJqxm6aIkE-KAIA>
    <xme:lhlZallEnYHMqGiQ-4cE1PzPNpuvOOhxCY4LxnJ1YmN9YUFMqp9M9Atx3I4WsO6EV
    kP2xAJR8q_GUjwMHl-HVO8hfcc56pnzvAk8D0hMo4HCg1EuPWPHZw>
X-ME-Received: <xmr:lhlZakEY6N-Cg6AjHloa3IKWXRs5S7q_p7oaeShIdccD1WHqbceF9JLzeeSMq87NsC6rE7GQ-x7MFi7Mj8ja2NRIwddAn7LGdji3do8>
X-ME-Proxy-Cause: dmFkZTElUK4Dv3ifhBYzZt6fRtZ5nsH3u7AhdPQW+8SqQst0crYr7o2jvHxzFQk6lY/OHD
    UwcZmUYj0Wu50Vz3bLmVPBIyUBVGNunK1Sn+tNVUMPy8eRwuxLqh0UX3ite26a6F/eItsm
    MlGGfen/761wiXGEinTKZaDdYobarTsrUt8J1ZhAobZbQ+MF+oKGC1tw8FCNPRKDOefk6T
    YevXwmp3gfCDu+jDVzCcea1Q/FO+oqYbpe5vu6didLkdZASoPpax0WfOqFt8TYfMcOG8zg
    aezJB7ltnAuMepd13qDImRIBvFQvD8eEPMZVewpc+X0loaNKFVzWHJfcB2R56zZOayqHeb
    u0+FjAfJ7jxYXFIBk8qfiWKIkBTU79TKaNg2WhpREBmyqobSC2d40YhEl9o/FWi/iUxL0g
    MEd4ZlAHB/lUwlL1tekw0rUU+niSMeuGapunBdPMARswDx6csaXy38ys+CuoT3CaXRrCWj
    bEtDIeTFX5rlsHCQh1H9Mith++5KJMHJysBmWfF1W7TOUciocgYucoajaQDpqO/WKlGpH5
    wAqnPUtqsroMHfCQLtPOhe8l6/S2qi+1Axh65391FZg0gBWeYfnPxxmk+GGnc/Q6yfEv4F
    ZhqECx0+/K3i3+Y08u8VwRE2aUCgcpxVD88xGPMYsL3Qdpnv5Q2nKKcHrOgQ
X-ME-Proxy: <xmx:lhlZalE9U35sXmPmyiNJZZ_BmlY7dfhaQ0ktsmDcalxM1FCkUTrFZA>
    <xmx:lhlZahNdlcFyFDhym-vrRlbXI4PVfwsJoMVCxnMK-DKT4sytE3FiDw>
    <xmx:lhlZakE0TfBl2HXvdRLdveKf1ZeRgbfaF0r39OOqTPrermTvo9D8lQ>
    <xmx:lhlZaoOvkKVXTCqH5fXPWrIPHmIk1t5YxGHxMLaAv8b6mH6_WhoCSQ>
    <xmx:lhlZasz14ySDT1urzC4vc7-Y1ncqScLCHehCwXae32YjVhnBEm1hQ00X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 13:49:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: [GIT PULL] git-gui: larger commit msg field, Bulgarian
 translation, silent make -s
In-Reply-To: <c177a717-28c3-41f7-95d7-45fec5b304bb@kdbg.org> (Johannes Sixt's
	message of "Thu, 16 Jul 2026 11:13:30 +0200")
References: <c177a717-28c3-41f7-95d7-45fec5b304bb@kdbg.org>
Date: Thu, 16 Jul 2026 10:49:08 -0700
Message-ID: <xmqq8q7ahlkb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> The following changes since commit 1b2c2a2edbaa1638becef4c3755b3e0633b9c304:
>
>   Merge branch 'ml/repo-discovery' (2026-06-12 11:05:28 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/j6t/git-gui.git master
>
> for you to fetch changes up to 5dcb97869546d600a114ef422a135e2e909c923c:
>
>   Merge branch 'master' of github.com:alshopov/git-gui (2026-07-16 11:05:03 +0200)

Thanks, pulled.

>
> ----------------------------------------------------------------
> Alexander Shopov (2):
>       git-gui i18n: Update Bulgarian translation (562t)
>       git-gui: allow larger width for the commit message field
>
> Harald Nordgren (1):
>       git-gui: drop msgfmt --statistics output
>
> Johannes Sixt (4):
>       Merge branch 'master' of github.com:alshopov/git-gui
>       git-gui: reduce complexity of the quiet msgfmt rule
>       Merge branch 'hn/silence-make-s'
>       Merge branch 'master' of github.com:alshopov/git-gui
>
>  Makefile       |  5 ++---
>  lib/option.tcl |  2 +-
>  po/bg.po       | 37 ++++++++++++++++++++++++++-----------
>  3 files changed, 29 insertions(+), 15 deletions(-)
