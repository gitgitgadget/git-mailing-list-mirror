Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6D2355F43
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 20:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679701; cv=none; b=BxLWQ2zPoV8ENAsY4lldP/DTMbX7KUxPjBqPFwwvWuag9WqH6teFZ4LCdkGuihxNp00uNZ8Mqb23TiwEwO57/O2QI8Y3cFDbaVQ2Uon5mmve2jSrxVXC+FgxwZ1HY7/AA3+fa3Nl137PowIbwxR3xrd0QFj4nWsQ84MGBSTbhFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679701; c=relaxed/simple;
	bh=9zgRrozmbEsUr85ksy7lBJPM2IHJVFZybLciapKQkAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SeRdW2yH3iODUQxc7pM0yLZ+S9/n51ezrly4PvY7ZpF46dbgP+FYCRKnpi5L83bavw70WA+5SP1vLyL2SqZB+RzFFaVx2IzkJIAgCaW7IksG5qsVEBEMW980olKlCNlu7UmNFnVCP4KQfAGRbfbfD0yOcbFyNsHLpV2DKEUIHkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aOso4gj0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e79dqKye; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aOso4gj0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e79dqKye"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A6BA9EC03F1;
	Wed,  8 Apr 2026 16:21:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 08 Apr 2026 16:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775679699; x=1775766099; bh=XY46xxubPr
	07uGdHZYOqCRr5SJU0SXEjl/qh2YD3qTA=; b=aOso4gj0AeZmXrr973boK0/FLQ
	0SPKbI1FmT6dqY/0hDbUzCpCE6E50wiLkGPdYRGRXTQpTn9y9NQPlLaDA+qV7edi
	oQt+J1V74ZT3jIH4ejONNm+kUPXbaozMSOH+i0P4p9oTcqX8cYkV8JzVTCHzxGgT
	wMOQRhQ3OYmHTU4sC7d/dzwhvM/RPDm3KfVz/PhBX4ybe529Q/CX2/5V644uUMaW
	blJPCb8sTCoiliMqg/c2QwwW3BHBnVF8pQp2B/EQzw8/51PQK8Ah3O2+fcHGeK1s
	j8OW5VrTPBncqJLo8gK0fak0GkkPwrNNeU1L5j1Ly6ulEoiwZPbI/wWCEtTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775679699; x=1775766099; bh=XY46xxubPr07uGdHZYOqCRr5SJU0SXEjl/q
	h2YD3qTA=; b=e79dqKyePXBiIZVgH2/wqhhOl1vgGi4N4Z+Mn3lLrS+2JF4KnSH
	6MyD/tozK35HXUCeQeopaLvbt2hbnobtDyqjZeQWsZZRoI5e/pqS/HhUkfrEvY5d
	nvnyRPQ6qp3JPiXgyGQSSpxLeCkm56TUabSdkIUM9eH7dpRdnd5ydhom1/H2Hds9
	T9HgBuKlXEVQawzWj6RtkCEXmLfVLTtKb3YsyZcI82rtCGLtet4ykSYOK9DalgyM
	2Agmuj+HoR/hrr+3WXWnZss+zij8KHFyH8bJ+4+v5sGumLqdALwF/hrfpO6HdDMl
	F11N2NfphuDhHHUcvXrWqFyjWmgEJJbsr7w==
X-ME-Sender: <xms:07jWaVEEwIq_X6j-1yxGLrA-FCkcDeATsnuR7NZGcFbSpbTya_wO0A>
    <xme:07jWaRVdfTN7Xzc2iEurr05hK4YllN6GLwZBuyPa4LOeerzZDBxH2oZ-wHk4n1u1L
    2ET7m2vEalj3zgW7TY5DZmgkF_bphcMZNoBDVpKK-d4S8jxe9fP6g>
X-ME-Received: <xmr:07jWacKNRwFQFebhaeH2c_seZtEZiBZRIH-HOI4L5Ld71RdCNYlLQf30M2HZNxzmhWb22quAFaMsVM5hiMiwXesIX_tDsIXf4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtofdttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffge
    fgfeeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhssggvtghk
    vghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:07jWaZ-1y5gGo2NKd5h5X0_gI4C8bX8b9uDlG7-lYnQf3BVuL_Bghw>
    <xmx:07jWaXJkvhHtSBlDqZvd_Xdv1OIFtgIM0-sA9_cXko0Mnh24pR45Wg>
    <xmx:07jWaWl-_V9lWO8oyKBGuglzui3B-sf-_LTFVF_LGtZsdJlHSKfuMw>
    <xmx:07jWaTM8OL1cilLiEU1i7NmUTzhRczk4S6tUHBk3BLeOmEPhQ6RnpQ>
    <xmx:07jWaWLQ7iCXEW5RPjyWyg_yBi8OEIFIDpC6SJVVYu4PeUmfHITF7KVI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 16:21:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Jeff King'" <peff@peff.net>,  <git@vger.kernel.org>
Subject: Re: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
In-Reply-To: <014e01dcc793$8a9bab90$9fd302b0$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Wed, 8 Apr 2026 16:08:55 -0400")
References: <00f401dcc6e6$7183c0f0$548b42d0$@nexbridge.com>
	<20260408041716.GA1324339@coredump.intra.peff.net>
	<011701dcc767$8c2ab400$a4801c00$@nexbridge.com>
	<013301dcc774$5e9fffb0$1bdfff10$@nexbridge.com>
	<20260408173949.GB2850002@coredump.intra.peff.net>
	<xmqq4illz5g9.fsf@gitster.g>
	<014e01dcc793$8a9bab90$9fd302b0$@nexbridge.com>
Date: Wed, 08 Apr 2026 13:21:37 -0700
Message-ID: <xmqqqzopxkxa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

> On my box, I have the following note:
>
> Specifying  the sum of the iov_len values in the iov array greater than
> the OSS I/O size limit for that open causes the  writev()  function  to
> return  -1  and  set errno to [EINVAL].

That is unexpected.

writev() may fail if the sum of iov_len would not fit within ssize_t
with EINVAL, but unless your "the OSS I/O size limit" is the same as
SSIZE_MAX, what you have above is not quite the same.

Does your build work with NO_WRITEV=Nope?  I think I saw it asked a
few times but I do not recall seeing it answered.  At least we know
xwrite() seems to work well enough on your system, which is what the
writev() emulation is written in terms of, so I suspect it would.


