Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B78637D128
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 21:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770155190; cv=none; b=cudNA7X1XWEq/Sg1NJF+GVAqmOVpwSAFrHKbbZIsGO+xWQbhxhwT3b5qZ3ru/n1sud5/1jW1NxdLAFQNY89FDeJ6iw/C6K5ACr6K9D4K2jRuimpphsoqV7dkxZCKq/Au3SNAgyP4qvEpGOIn7CUtzBG4QlYvI0W2xbWN3MglayY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770155190; c=relaxed/simple;
	bh=soiZSymNvgRtLfe0DHH22OIp0PW+zHRVtq+5hpEZ4uM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YPsUs5UxER72Q41VHEWJ3mhnkvO1NPukxTUUpYgz72Zfj3UzjbPLAZ5xewGa2sIUzKMJWxnx4MnXLvQ1oQXrSbspSlIel+w5422AMZKauCfOBQW2GCOctsBvXJjiC9EVO9SSzmacyy1W4vr0b37Vp9el5e66u1jYLHWchKWFyH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=B7dmW55F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pYpl0gAo; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="B7dmW55F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pYpl0gAo"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C8B7D7A0126;
	Tue,  3 Feb 2026 16:46:28 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 03 Feb 2026 16:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770155188;
	 x=1770241588; bh=2C3sPXxzaAoAfV81gS7hY7e3iIgosykFi0J+qGW/BfA=; b=
	B7dmW55Fr3L3DyhCvhdYYfyOd3qVbThTEhFsVitSu/cehVMdkWBs3hUhLGAq8ern
	eYspMI4hhlu5wfBsKc1R7ew9F7AbPFL5sg262cQr/aWc/hENGHgO22G5BKJEqDGc
	a07TkmH9gKx4oTEPNy12rPYc+EkLlzp9uAtb6WQ8MRFRS/OsTikX/uz0BxE3q6JZ
	prCvaxHiLxE5WVh5m1a9YtjMUCBe4EH3tFcSQ73KuqHcyoeFCx/ImTDtUDgIg6YO
	oqP6uN5FyZdtHWYwq2N7sb1TZ/VS4CysvJpb0VYjQ4qXeSDNhE10VxLekpLBhhYg
	DucfisO9/3zLY504w/vlJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770155188; x=
	1770241588; bh=2C3sPXxzaAoAfV81gS7hY7e3iIgosykFi0J+qGW/BfA=; b=p
	Ypl0gAoiWz/wuTnVIrnsKaVR9l0QZdPianKjnuRmrsk1x5DWX9C3JAeQgbUoQqld
	k8dUdTs0cIGHj/X5HRjRrBba3hRkfYyEUbGsbPwLq/GOWsQbeY+gs9QRtz7pol3e
	GQENmRwAQmDaNVQt52mjC9nDJvvPnPVXRVy7RP+SQ4qeeMu3Cb9KO/Re1pXDNYak
	SwUMqW9FJeU27wsgPhI+pEC6nXAlUBaUoKeHmCdB8ngGiJudBQ/d7ipNzXlM7Tuf
	sw9h2HsVVVR1fT+lGM11nv3LBoh0uvcgtVVNeG5/xPs/YgV5zXVyLTSPIUQpGqUQ
	ZndEvzLg/IJYz7Qo4y33w==
X-ME-Sender: <xms:tGyCafQ1p7s3xDRj5zFwBvBXXThjGPHqvpPQGyVpvmAaHct_RHwvCt8>
    <xme:tGyCabkEKlGCds9CsaCq_n7THutf55-gMCZxAC9XPClJkdQYvXRmW3V6N5uDSXzjQ
    VZnbITRNoQoTowq0-kLO_F2Tc8O90UH092CVdEjssO3aImYCkRJlgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeduudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdp
    rhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:tGyCaatQlD0zENG950BlSJYhnpfVmGm9SXdV5Mx7nt8k7_AzrKpJDA>
    <xmx:tGyCaXN-Dgn1T2ZBI4_qiKzrPMEmqwSuPwNkyd5o52O2vpFW12uqbA>
    <xmx:tGyCaY2kLJdKsaXdtT6RTJPAgrvDRP3bUU9h_uQ_dmgENrBSVgWG-w>
    <xmx:tGyCaTM_Znw9EofAcmukOQiFD51bbcez_0zT7UrDdicbmf0uhrMUaw>
    <xmx:tGyCaXI-yF50xfZ79gTh7XyPeQw3mGvWafAhZVo7Bp2VezUfgfSWzQca>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7B8091EA006B; Tue,  3 Feb 2026 16:46:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aw2akiR53KZg
Date: Tue, 03 Feb 2026 22:46:08 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <82f3f124-9406-418e-82e0-1122c7f3c69a@app.fastmail.com>
In-Reply-To: 
 <d0970653031fa82b6096506520fcfdd80c8b22d1.1770138215.git.gitgitgadget@gmail.com>
References: <pull.2036.v2.git.1769462744.gitgitgadget@gmail.com>
 <pull.2036.v3.git.1770138215.gitgitgadget@gmail.com>
 <d0970653031fa82b6096506520fcfdd80c8b22d1.1770138215.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v3 3/4] doc: fix some style issues in git-clone and
 for-each-ref-options
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026, at 18:03, Jean-No=C3=ABl Avila via GitGitGadget wro=
te:
> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
>  * spell out all forms of --[no-]reject-shallow in git-clone
>  * use imperative mood for the first line of options
>  * Use asciidoc NOTE macro
>  * fix markups

This patch is looking good this round as well. Great.

>[snip]
