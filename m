Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB9C357D0F
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 05:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789708856; cv=none; b=WBkJ30VFKMvGfbwgsqCbHrsmp/7zN5ldtWXSGgRM7KilNwCKPJU/NJJ24sl/ewTm9al6O1lYf3S+MffDyvk5NVDg/3kITBjG98OxTIAwz/mnna+Ocqsx7wwg6mZGNhD5KwnMb/zkVAabqK1I9KOPG/yTOWORraR/nHfB/iJYfh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789708856; c=relaxed/simple;
	bh=Xof3qG25TIaw0/jQZj4fic8zlG7p/L1Y0fWTeDo1p/w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GhoV+XQAwdHbte6qD0CLTJ+Y14+GZlIjFPl44p/Chtg9ruhF25a3NiwMHtDvlBGoAsPnUUosb07ldl6l22wVnXsBGNTr2HzdTVTnma5Np7o+SDMeubT89dOO3IDhVmtc4CM/RBRjWq1K7OlPv6TdfwVLuecFW2rfK4zrFa6HgLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=T5ZtQyKf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fbYKj5ZR; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="T5ZtQyKf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fbYKj5ZR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B638B7A010F;
	Fri, 18 Sep 2026 01:20:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 18 Sep 2026 01:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1789708853; x=1789795253; bh=dvqecfTw+PZhcG08HPDL+MFiBI5c5hKy
	KFTaZ8Z6aj0=; b=T5ZtQyKf0OJUBJ1OHaK0LWjw6dNxOPvDKjgMvjQvm4pqzUyG
	E4RoVyL/wkxQWvhuv5hxnrnPCzjE8UQcPj/TPDKI46yoXtNtyMRfBFDx4D9Q50TA
	EHt5+zQ/D3CkMoBhQh/V4qta4LCLuD3/V42pRuzJcpODY8LhhI5AVLyTPHrEVTsG
	Mv3Amie8YJ9x5GAOMQyCdaBEdvDYmTeoRnQCB7Uaemc4YB/n8uWfG8JgQwv8DCDk
	XFl75jy0nbt4SpW320F2vDleSdaIFUtZOCZABcFH4wGum4T7Wo31JaRTD0tziOEb
	O7fu/5hXqxEcuVjSw/Q3aj5MEw6Fn1SUmRLC5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789708853; x=
	1789795253; bh=dvqecfTw+PZhcG08HPDL+MFiBI5c5hKyKFTaZ8Z6aj0=; b=f
	bYKj5ZRdMsqyE/tFi3+SgZHsJXGJz4Cfe15lDPIzx4VLNmDaAv+/rpxVso2m0SdY
	9a0QPT99+QpZYpp09puK30HTkgUxMY/eZ7rpaJ8Yu8IvKSN8zJMYhYb/PY8YWzvv
	70rpZB4vmAK22REZ2Ch3MIdtapjuuxBXk7hE1o/IX3GBQkNvnA+ZhM9VsvD954RW
	IueMKLUX/1uJYo3KctRB/tT0Y5QDnwWMQC6fg+XOu1Z/eJmBUWTAoHbQFyCuTLtb
	kLCM8eDL2UJuhxjxgNQUFdZdtcp7jtvhXwbnzkmvbw2LvaQPNt9JS0+fdTQOs108
	kzguBf8q0fGfW/pM6+pDg==
X-ME-Sender: <xms:NcqsahYg6gLAVYMk1bXsxwXjnDa2_0eZQBMG09jt0j29sb37pEyc4w>
    <xme:NcqsauYMXxcC3PyqAPV3-Tw3WoLzTL9kCTDd5j1A9WDRvMONyRdBF-XlcqjYYk-8F
    ql7isZDTgfqfRR6c0CN2NPROOQe8X3asykRiJErw3yaCGGhMMooOJ8>
X-ME-Received: <xmr:NcqsahkYYOVV_7hhyLIjOsoOmPBt2iV-Jv_fjOgt41SNb0RB9YqpxTGX1jcLmoWKzJjemfpA7OyuWxpChbrJr7Hp_xYShnG6U1PC>
X-ME-Proxy-Cause: dmFkZTGuHk7KIqEk1gaXnbUCBVz9Em7o+St7ol9pc1LBYHnax00+7cKdMjiXMjasbqXYBS
    pGvbNSQjPDWRGbCT9jDxBaxMGQgXR4UVDgC+J/lNYg74C0Uq7a0TFr8NLv3nCoGcLgAbqb
    l8yhu4h6YzKoDlbHo6oc+LeejM2QTeFBS2p4PlilZgbVQKldxM1RDbEAtshR03fOT9wocJ
    sAw3hhfOFU0AdG1xdpyPdPyprop5FbOjluA0htG1to0X9buuCw8JiTCCXRriSrAcNKZneh
    Lkp5wu2ssRnmciDYD8+q1wYSHkYS5KLifIDR/1KkWapm0X8onkbITtrFOseBDGyGZVdCiS
    tr0rqMY/I5EIuigffFyR3xAn9Pkhv8xXYIOvPuejqw+3ejS4iNmnFyTmc9ozFtLKZJMvxh
    8uq39Ze1BC80RL6qnnt2mN2ELHLOiUst3hVeKHBSd4G2J97SVhxpuUIh/RFyIMfoAYnwJ0
    VhthlYny24A4035f3JCDgT6ksJDDq9bDNU4J8OOorOQuNKq6k4A0SLH58mHHPSz8FyYapB
    77UMIBnumunpAAzg5xr4gPrvZMsoJDGoIi0D//Bz8g8I2ATILHDE37S5onq9rU03TprkAb
    fX592rmO8483o+Y/cMNnWWTlxq4NIbA0/EcjMfvRzPVe0DIsi16XUmwst7kQ
X-ME-Proxy: <xmx:NcqsaqwBdwxTjd9xS5nW71uCKthvZmuobWOy6uqWgumMHoV4CKPAMQ>
    <xmx:NcqsavO7gtbljtuUbnUscLc2BNbOZUV2pCaFRVQ6EByJX8K46tCxTw>
    <xmx:NcqsauRDImZ44fDFTT3sRames-iZLPEzdVPG3fKQ80FK3Gf-wxtXZQ>
    <xmx:NcqsatZyWm8KWMwJFtNRPQp85tFicrLzeqC2eizpjRhi83owyHNofA>
    <xmx:NcqsakzxLnns7Lmog5nCEOmeqQNebeG_9eQD2wp_7p7GVDLtJPN9lPpg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Sep 2026 01:20:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [offtopic] GitHub CI webpage caching is horrible...
Date: Thu, 17 Sep 2026 22:20:51 -0700
Message-ID: <xmqqo6dvp230.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I usually keep the URL

  https://github.com/git/git/actions/workflows/main.yml?query=event%3Apush+actor%3Agitster

open in one of my browser tabs, but this request interacts badly
with the web cache they use.  Depending on the phase of the moon, I
get a stale cached page whose latest entry is from early August!

As a workaround, I could append '&nonce=$random_number' to the end
of the URL, but I should not have to do that.

Grumble...
