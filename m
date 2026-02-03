Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68B137BE6D
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 21:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770155161; cv=none; b=Sps7/i+kxzzk+qQnWRT34ftOaBSJYIU9U/W+PWeK5w2xqNp05valispQnaMhXXorXRGew2hocNDd/cf/yO3r5O0nkiV4M36SZGAZ8NRy2wmrKtJD8SpuEz/NLpiJMOmMfZLfAvQ6MIhJWUpgrb+sNemHjVmPK4padCRtP9f6kY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770155161; c=relaxed/simple;
	bh=yQX8QSoHIXEAmaMwRsAhCpukBhjfRzzN4qtxJj1HEHE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cun6rrWuTYEykbWFrFfMhUtd+ElgJsOkVp1glsoWE3o7c4GYhm3NWwyk1yz5jSFSN1lPe3MYflPp4lCp+BomgBfxBu7cSA+sR5jt6Tt+Dm0qKbcLaCIVVu3LMGEDB72R4WflSpPJmgRTz+sw8IZYU592H8yHOFIPLfSH+UmYRtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jhYsHBJ9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VVwE6UHc; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jhYsHBJ9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VVwE6UHc"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 40CBA7A0113;
	Tue,  3 Feb 2026 16:45:59 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 03 Feb 2026 16:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770155159;
	 x=1770241559; bh=yQX8QSoHIXEAmaMwRsAhCpukBhjfRzzN4qtxJj1HEHE=; b=
	jhYsHBJ9TFhxx7U2SLZWAjWDZU1nGVnuxT62WhOpbVraDWRy3JcrKZA7lrpuNrJf
	S2IbkwSVq+FVg1DY0Y41vSV/wwS4gLLOaXK0vfwsuhlh9T8ncy22jZOo1g0qq5y2
	ocX53VXBst9YRIlJ9MowjphXEeJtk2+HuQ3+ueS4nSeKlzlaKchfm4m9xWDkT32H
	MOcaRuY9sCGIeOLgc2kt01q3xxsZYQutiKm7jKnk324DhuMIZB5KDbnwCQSqWFCH
	uW2O/+UCYJYZUxg/Ur52ieU8ry7ydK9nrOkH1YN8IqmRAgeEaHYgnFJmDeiwtIfM
	SwBDiOJcnzqLmtYDD/xj+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770155159; x=
	1770241559; bh=yQX8QSoHIXEAmaMwRsAhCpukBhjfRzzN4qtxJj1HEHE=; b=V
	VwE6UHc/LzSsUb90eCx8UBggzjJ0CtPsJjybHf0AYi1pmOyCseGkrJAUgZQCEA0w
	ACuxTDkSDNKVwyC396HupK51t7X0J8cbQgoYSRAOqpHaj6rvPd64ftRuRdVBApJQ
	2I6kjSt4bV8rUD5EQihxLmYYWAw4TMfbGY9TbE3cKTN0MWJdbsSSTc1vxaJbwVDW
	7h0JT0vTa8/x2aRabtyXvIvWo/1Mx3+EEg6tCifG7vMBRIi94GAuwRLxA9IU6Dvf
	56WmUlx4Kdov3GNypOqdh1RX/wnRVhIVNA/VNA42qrJ02JrySMzxja2Yj8RKr1+U
	z02KxFQG99r3KKz8E8Hhw==
X-ME-Sender: <xms:lmyCaaWpxibXhiTQmMdzT3z2PQpV6yzntVhdNnzFHR3LlefaCY-bMn8>
    <xme:lmyCaRZNq1RPfBgdtW1zbf60Kr1iHi_IOMl1QLxMijpuKS_TlrX5859k8m7ILt8FQ
    WwL2kLKqXzSO0qLnVjOlli2VappDNHxNpcOOxlTq-6DDXztYjsNog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeduudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdp
    rhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:l2yCaRQr7TYe6Ez8hv624H7aD9vNZmjWPOAnuF7LODKBMBACkfo0pA>
    <xmx:l2yCaSjT6W4rSU9MLYbNwat-eysRkfANi-JB-5gwhLlcG9BOIgLNQw>
    <xmx:l2yCaZ5ThhCqKQaXdmR4oRGrG_dcHO9lNQP8JhCzLAfVT5a4t3mP4A>
    <xmx:l2yCaXAPi9wtMBGtZ6BwaZAT9SCbPjaaZbzRTtFKYMbvyqNxz2aM7w>
    <xmx:l2yCabM5o8TYAXY1WbkGbBElT7-pwW4aPllGZ3evGOvHtuNvGstwncoz>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E0E5B1EA006B; Tue,  3 Feb 2026 16:45:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-_DlS5lSLTB
Date: Tue, 03 Feb 2026 22:45:38 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <dc5e1904-0be8-4f89-b56e-319b685e27a6@app.fastmail.com>
In-Reply-To: 
 <5fd9f6d41a67b36d1898b451f283d468f2f060d5.1770138215.git.gitgitgadget@gmail.com>
References: <pull.2036.v2.git.1769462744.gitgitgadget@gmail.com>
 <pull.2036.v3.git.1770138215.gitgitgadget@gmail.com>
 <5fd9f6d41a67b36d1898b451f283d468f2f060d5.1770138215.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v3 2/4] doc: finalize git-clone documentation conversion to
 synopsis style
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026, at 18:03, Jean-No=C3=ABl Avila via GitGitGadget wro=
te:
> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
> Use backticks where appropriate for command-line options

This version looks spotless to me. Thanks!

>[snip]
