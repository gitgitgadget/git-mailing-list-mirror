Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DDC305691
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 23:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785711678; cv=none; b=q4MJCDLS2gRqU25qtxcN38B9jP3l2p+cDG03ZHavaI+SMiNnLP8Cc+t2Q+tk5pgzWl1GmKQu95/FxNu/GjeM0SnnQ7+ht+OhWwIrUxYED5776gwiH5oYXiboHG/wy3pZMflhrBjYr62PahcVOldOlz7AqJ3/0o7gWQML8Qy77Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785711678; c=relaxed/simple;
	bh=GQGQX6tkU4frAXIIfJTTtUljDpWKcvgBpsgcidAjoOw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZH4tZcnHNoSyHOIgSJH3O6Hhn56KFS25eK3ifaxDndggFCgLchLiXaSfu13kBiGxUK32mJ3LXCZwYR1/g/3dTFzwf2Ck22UbIkZJldWE1Z4n6Buj7Zxs2m6OGm9JuDfPob/RM/BCbNT+F4E+TUMnNv90Ilof1srNEqNd5ksNcfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xx7XNaxq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W4LpnH0t; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xx7XNaxq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W4LpnH0t"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C147D7A00C1;
	Sun,  2 Aug 2026 18:52:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sun, 02 Aug 2026 18:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785711148; x=1785797548; bh=yD7dT0qoRZ
	fTSmxfi+qTsptsgBTHU/Us7eZcSDTDni8=; b=xx7XNaxqoKCuRDpMSdqiMA7zYc
	6OcSNf0NaP7xsYZV0nZrdoZ1J9hIkAuzxjHB9IEFkoAKXGJ+q47HSXLr4lj70Fe2
	IO0wSwXcCoywDnilwkKKh3VM+p0vM0I8S3qjLK3PzDzzh3uZMBghms+hLOwLTpZE
	p0yDksxeI6k8iJ919Qjx+DK3MMctw9s2unXrLGv3fJ80cSoPKw31s9D7Kd26J/al
	SxST9IIeFjMsykdliR6nS3ZynBZFOxPkLzC6f91qU0eDfq8jInj7iCfVcvp//PtE
	BP2CzP+rR1zvVwWlkMyIfPsmaf2+VND3u/pKctbgfm1qRWS0J3NgEjFNdEiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785711148; x=1785797548; bh=yD7dT0qoRZfTSmxfi+qTsptsgBTHU/Us7eZ
	cSDTDni8=; b=W4LpnH0tCT08bQyW2wDUOhS6TPGWtLg+g2k74GdCEtGHjKiFvj5
	nQhORsDMjghYZEnD88kYwB2abHCDCTCltOuT6dwnu9AlVGA1YZGnX0KrCYzJO221
	UbhlXknwACCGiLiIyP44VIoNH0oj+bGng5X11GTpJhMf4SVM1FVvE7q/W6DQiMLS
	ZZXJOWT06/MZbBH4i7vALkLEZ3/4z3C+Re+Ke0vp7L9jSLJ0AEP5PrjKVO1kr3LX
	7mj2lKz9VsvVFPQYAVdM2ZA0GFi2fdPBnTp6onNdzEGhTe+rc3ZuXWrvS8Q9b+jE
	i03/puro1nSR8I+LKD0s1XReSKve3S0szEA==
X-ME-Sender: <xms:LMpvauWm_1AhiM7bkzT2gtGu8oH9YD7JQRypzn10MzSV8oTkQmUofA>
    <xme:LMpvatKtm9DPeAoQd3OGCy9zX5rgllTO5H4m7F60yC1v58u_1WnfqICqZKPnIzyib
    ZeuwkRLxC8huEukmN-4cEKZwLvA09cuJC3dVpfGQwdWMnZKIpgkWg>
X-ME-Received: <xmr:LMpvamCDKZGyu0hJTpTh3s7IbP-IHM5e9uIL9kDPTD3o-fZ4Y6QxWLvBdBPVjsW0_7V4NGk1uiDGvxpDo8UYcfpRz_gWWxQ9fA>
X-ME-Proxy-Cause: dmFkZTEjsVnQBHV7A6z28g//mfFKYpcFIaWKA4bQgr8IPqRK86+bFV76LT1SmsbLHNfJbG
    rUsY5GW7e6M2UVqK48dCWmRhVjJVmun22TB3fqFepKg5Xs4nUrbX1c15FOIUoo07L5Y5Q/
    Eu496Dv6QYrEn8XMVK9T34ZJTQjNZBVedYw6bNRMbfWhD9bQSreTWe5MPNmKoYX4QS1p+W
    bBTUl41zRf9+7fskF1Ztp82WLgmjI+NAiP4zjZ6/hw4U8lNbEwyVRbA4SQQF1LGwSzvf08
    KHpCDupMvWPaM6aUvFOkRa0+CkUpiSh6l8Mt6QAABrBZVyWkRaU6ZMJ0305kCq9Wv3nUXt
    5wGEVmhxrQ6eFHbUjXs/n6PbZzRrcHZWi+FGw4lCadpXSm5al4uAY7DLwh6TvEQXLQ7pOP
    Y0FW08ufFRFNWJeEiZpGE7YOnNWzh2Yb241WTaOI4FLHToHrAVaEmDpzzA1549FcLifS2o
    t1NHTyDtUssqn+JXxRIUh6s+hs/Z/erHgoNAb6aXKThYN2Awu56e4AL+a6SiD5edkOZ7uI
    7IZsJ/Z5LyJu+OqxkYOfkSTNsEIoxlngJBf0g1gbo7e2ate76eIkiCGRwNTMWEwGHkICpB
    CvNTl2+u1TcEdwj0ORC2fk4mzQbULkMkpnzFaw+sfuLhCRWWu2D0waDJbmUQ
X-ME-Proxy: <xmx:LMpvalflwYS6dvYaLGHJbUiPFvr4yXGR846z609W3Zoh10_eIAY1PA>
    <xmx:LMpvat3_ThpL92UmUiln1k6bJHA1oRzlJ-FYD1ftkjy5fItbmNu2LQ>
    <xmx:LMpvakg14cS5xE5j0IH50oJ3wZ9n4L7YUJP9MPdiqgLK-X2kSmo8Nw>
    <xmx:LMpvaulbKYHsE4nwpBdAssS_JrKoIx7HC4QSAS7tXUjdladXrNIFCg>
    <xmx:LMpvaoGqLwPLOTHHLUDah1_G2Zp3rjpuhJLBwqdsEHJGXBA4n5kvI5Fr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Aug 2026 18:52:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Arijit Banerjee <arijit@effectiveailabs.com>,  Arijit Banerjee via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Jonathan Tan
 <jonathantanmy@fastmail.com>,  Patrick Steinhardt <ps@pks.im>,  Arijit
 Banerjee <arijit91@gmail.com>,  ttaylorr@openai.com
Subject: Re: [PATCH] index-pack: speed up promisor link recording
In-Reply-To: <am_Fb79hCnwmRzjL@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Sun, 2 Aug 2026 22:32:16 +0000")
References: <pull.2191.git.1785706396130.gitgitgadget@gmail.com>
	<am-7_wSb-GNefKlB@fruit.crustytoothpaste.net>
	<CAFwoC-7wUzce_XvuviXZe=5eTxJ5yyCpz=vsOheWKPCnz9Kr4A@mail.gmail.com>
	<am_Fb79hCnwmRzjL@fruit.crustytoothpaste.net>
Date: Sun, 02 Aug 2026 15:52:26 -0700
Message-ID: <xmqq7bm82l05.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I understand that the SubmittingPatches documentation is a bit long, but
> I do suggest giving it at least a glance so you know what to expect.  I
> think reading this sort of contributing documentation is more important
> than ever since, in the era of LLMs, projects tend to have strong
> opinions on what is and is not acceptable, not only just in terms of LLM
> usage, but in how code and documentation are to be written and
> formatted.

Amen.

Since we seem to be drawn into the AI policy discussion, are there
things that we should consider borrowing from policies battle-tested
by other projects?  I kind of like what LLVM has as "extractive
contributions are rejected (whether it is AI or not AI)", as we are
severely review-bandwidth limited these days.

