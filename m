Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADD5310644
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770069214; cv=none; b=cYJTidP5AI0QI2Mid25tJT//V7nfvBYSfYrRi5JBFHqPVkvpYMduSuxYh8rvUXKh1Vo+KbYL+bnDcov8f2MtY7OU9aBz1jgftnaPdHScpp094SQtvML6FGlDYOXVT35XJY+O7C6FB/hYzvgoPFCsK9Noy1X5mP8ny2mk9ihNhiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770069214; c=relaxed/simple;
	bh=tM5zRt1KqAxPEp3kBIUgCVwv7LcSkHlasjgsesS0oxM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oHLt7oQeLY0x6WaXHmlzs6NzdlpfKxdGw2xqW35ZZqUG0rUSP463vOwdEALLQJhPnqxibyfIH1p1FcQl2dKDXuevigMUV6v/mIPnRKqwKmayIg96InJT7w8O0n1y8nCtQePeW+36r0gAGo0jumGRz2sAAHcDLb/bB3pdtnRUa68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=G2TFISOV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sBMseCxz; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="G2TFISOV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sBMseCxz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5378F7A0085;
	Mon,  2 Feb 2026 16:53:32 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 02 Feb 2026 16:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770069212;
	 x=1770155612; bh=tM5zRt1KqAxPEp3kBIUgCVwv7LcSkHlasjgsesS0oxM=; b=
	G2TFISOVY+sEX0gty5UGmAmvbTCaWy8lGFC+0makFb1HNLk/H/0WhXCz+lXEaOTJ
	EsLpk7GeM76y75ttoeIt1ViUBF9BJk7DdcewbQgHwLdoUFJvfldGn4njeBvKYaqd
	FR3CnNYN0yQYjt/pxC++uy4EgDI+bnONY7KD5DzsZyEO2AElWat8u1hagiAYrweo
	crdXaTHjWFxbo8eMn01RcqVpMAD0eugbdua6Igb1KOfuo5+xGns+OSPo0ZRKGk0F
	BZU5/Cs1/a0y+xJpBFhKhOwcP8vYPROOGP1hfbJF06DzOEsnLkwB3uV04HF/KQTz
	5gq4SPbF3IFTcbGP8EEsrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770069212; x=
	1770155612; bh=tM5zRt1KqAxPEp3kBIUgCVwv7LcSkHlasjgsesS0oxM=; b=s
	BMseCxzXFV/i5jR+Q8FtrYAbpn2P9SP0ecBTHJPR1PgYb9XHdmuYZ3cvwrdslGMm
	CPcWMilL0cvjIm5oMXksEr5dOLesDUzN0RCIgspmjaAtcRGIuzRRq6Ua7KnCXMUz
	qXPX0Rdr022fH9/XOJnGK/j9zgtfLaFTfMRyTeuo3u3ry3MXeoKjNjO0yC6HGrHH
	OH9icg82dkESDaU+xke7lHRozaKpfQk6CAQzcl5HZded9vRneJ8Rf7REkb5hBnlx
	jcX5O6g9cQ1Rvoghcm0xrCazdUNRPNDqy/JfJw7MoBiXZOTKSeBvoMVCyOfXrDxP
	4EXlkUM5m0rjWsZ7gNPPg==
X-ME-Sender: <xms:2xyBadjG6cxVyKXB5qOXhsajgIdoh3mePAvE9YeOAciSMgf46e4atQ4>
    <xme:2xyBac2N3sLvlTKV13Py6SFiZfrP4XsZRdwYlV_bZzaxX5_xhKWilkJ2dAt5Bs3f6
    v2lFbXzH68fUgs1RDdugb99vrT3a-IYhOlJOawrXgR86BlOKmnInA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeejpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtth
    hopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2xyBaTI7XLKtjHv9g6Mx7JeUVdPkU2F00vPVFMEoPm_TcNwHebueZA>
    <xmx:2xyBaROA2Q40BKGoibp23CZ6R6zzlpXsTQT5DGQtFTTEfeqeBUtn5A>
    <xmx:2xyBabn1CrtldpRvPqzwWHwwJZAj3SkKy1_oc55vNLy7Dswza1fwMQ>
    <xmx:2xyBad7QY_9oI159te1tnqUtGZX00wNj8qPmwKm_9n350u4_Qq1FcQ>
    <xmx:3ByBaQpZGSbgD5FczOyikmlc-mOQRdGs74_v5agSIfezFOW195JHPyDV>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A4B521EA006B; Mon,  2 Feb 2026 16:53:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5dQvCCpYqNV
Date: Mon, 02 Feb 2026 22:53:08 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Harald Nordgren" <haraldnordgren@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Message-Id: <6e2e8e79-7fe9-4b3c-9257-bedba0be3308@app.fastmail.com>
In-Reply-To: <20260202211919.4968-1-haraldnordgren@gmail.com>
References: 
 <CALnO6CDrdfSFuY8xjvno3+2MVB2JHUYdNsYTYqqRsfcDiWa1uQ@mail.gmail.com>
 <20260202211919.4968-1-haraldnordgren@gmail.com>
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026, at 22:19, Harald Nordgren wrote:
>> If you don't need to be on a branch, then "git switch -d origin" (or
>> upstream, or whatever your remote is) should work just fine.
>
> Thanks, but it needs to be a branch, do you use detached heads for
> anything? =F0=9F=A4=97 For me, the only ever happen by accident.

The remote-tracking branch itself is enough for me to do things like:

> > Also, I switch to it when I discover a bug on my branch, to try to
> > understand if the bug is already on main or not. It's the baseline a=
ll work
> > is compared against.

And to compare against with git-diff(1), use in a range to git-log(1),
and use in `git branch --set-upstream-to=3Dorigin`.
