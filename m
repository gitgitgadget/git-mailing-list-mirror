Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9E6DDC5
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 01:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760059674; cv=none; b=pFuQ71eVyYLju6tgnKS7K8QixCq8z3e96aWDSCJ3dZjc7yfnCTyBuJJZtKMPgK3TWq9IPQKKWn+JRmNev5xODnseRuhPQDh1GdbXxZH9W8ZlhWmrk4sEKoclp0jW7tsl6WzVD71gIURaD0ZRN9/GK/ydm694xqTUSl/g9YC+yMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760059674; c=relaxed/simple;
	bh=Fu2QXCgQ3qqvUQmDeX4oYOwbSp3lejR0m8qfZWKXT+8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Z1DYUWZqaLguSJ+p1zUjbwMY3RFByjSjItQ1fcWa0YVupckgCvdQfssyal0PGepYuc0K+xyeFbohOkhdbEoXCWKZk+AUWgorolGmd8WGTEqZtSD5b82GlXutuBDg5fI3IKbLz2fP/K80UttmF8Re2VimghsEs9n0zaxJTXH20SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=VSuKdU/4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s3kePVaM; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="VSuKdU/4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s3kePVaM"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 34F147A00FE;
	Thu,  9 Oct 2025 21:27:51 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 09 Oct 2025 21:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760059671;
	 x=1760146071; bh=mIFzNdg9IuUQ7hun0p+u2Top/TCi0rPtt0V1nahtQbs=; b=
	VSuKdU/4yHTuBeAMzIp1Ll4M8GPLn9CEl/2VnoASGq1CsL3UotiOV8ZZzRslkCvj
	ggKEGrJgAcmN8wHQ3NO71a2Mj6PGYii4WujXDI03YLv2XMYmvC+L3nqPk1/m/SWx
	fOY5y2Psu1EBmzkmMRaZPxKjHJ+hkoq9ykaURQgpZ7ZSbTqOKyKwmaUV4m2V+DZP
	c0pn3NO5L6bqr+EVUNw9o6H7I9ql1bf/eM++CB43LqVUQ377RKIQvx1aqAFHchyp
	4dzaO8tu14LORjDfXjvtcZft0hUOwmNjr2nKEKFq1qxyX5jVRLKpPz9p1KGZZ+ks
	PH+EDaYVbtht+SriWNVDeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760059671; x=
	1760146071; bh=mIFzNdg9IuUQ7hun0p+u2Top/TCi0rPtt0V1nahtQbs=; b=s
	3kePVaMYkGVCPb0Wc9Lye8H0ngGdM7yy154M9TZl31Ma1cJkqY/OGI/9xqdXNnK+
	YSelaSUeyp4fG3oVrTO95SmjbcAMSTAkQIs0xiMQUQMkkzH5t8wBJiLD5KZTAnrE
	5DCdiVUeMww+aIOPNdWaG3/y0sTxVYoZc3XTOfnon0XROhtOfRlXFdX4Uipq0MUC
	aAxESE82NLyxwtTuPbBIRIwczU5N5ZsaoNyuZJlUBPkHNBJ1gexhMJA1SMjA1fNM
	PnADlcCNFHak/Ivu6eKjQwkuZFAgdJw4zxhC8s2bt4kAR9Q3kW59opseIVp3h2ug
	nJebScEAieprVVaJzeWoA==
X-ME-Sender: <xms:FmHoaB5kDTvhA0Lk0RQtAbE3OWfVvkN3vliHvuWU7F9J8ClDAki3LFs>
    <xme:FmHoaJto3VergywER-LjcTb_CSKthh-jIYNmH5O_Rx7tNuB5E21VF0QgM4QjKwrQ6
    mDZQvAIx79232XP6RA4YDC7zJLuFlgbmOrJTqgE1ZPP8Rugouvg-A8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeejpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthho
    peguvghlihhlrghhfihusehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpth
    htohepuggvlhhilhgrhhifuhesmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FmHoaPiQ_CWvaBgN56dnXW9bgBcD2cin-Pjim4OduWhXAMtNt2ICfA>
    <xmx:FmHoaGHptR1D-AUE8LH9cIN5AHkVdnhQ6sKDWbYsG2ENLMTeB5QVdw>
    <xmx:FmHoaO_fZ82iOJOAzQk0CZZQw533VI_GxMh52b57qHVEyXAiLdHtOA>
    <xmx:FmHoaNwNKAnsqClTtavXWdDgjp_46BQOzTkGVvc-yjutGk2hDd9DXA>
    <xmx:F2HoaMpTUbDKuJPQ71geiA1k3Yb1cfPXxzOeEUc1ExwUs8Rw9rLUGxpf>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7E9A81EA0066; Thu,  9 Oct 2025 21:27:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AN-w9kmakIIR
Date: Fri, 10 Oct 2025 03:27:24 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Delilah Ashley Wu" <delilahwu@microsoft.com>,
 "Derrick Stolee" <stolee@gmail.com>,
 "Johannes Schindelin" <johannes.schindelin@gmx.de>,
 "Patrick Steinhardt" <ps@pks.im>,
 "Delilah Ashley Wu" <delilahwu@linux.microsoft.com>
Message-Id: <46aa7034-b186-4adc-ad0f-8c7a4d799687@app.fastmail.com>
In-Reply-To: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
References: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
Subject: Re: [PATCH/RFC 0/4] config: read both home and xdg files for --global
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 10, 2025, at 03:14, Delilah Ashley Wu via GitGitGadget wrote:
> As reported in [1]: `$HOME/.gitconfig` and `$XDG_CONFIG_HOME/git/config` are
> both valid global config locations, but `git config list --global` only
> includes the former in its output.

Note only if both files exist.

-- 
Kristoffer Haugsbakk


