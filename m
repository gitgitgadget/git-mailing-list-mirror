Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAD8359A6B
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 19:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774293500; cv=none; b=V/bfqMkPKl9uRYITk7siBf04a8W9RTxA+wmK6MaFCjlI83KmBaLJmRjFQcdHqNUI0awnjyh6n+Jpzc4sS6ycUjz+xnPPFM5bAgCjinzsxVa7cRiyOGc/usNI96ey2eVf6mEheRBZ7AWk6LSOGmgISWv/lDN+Dgh7TQ+sDXEnMyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774293500; c=relaxed/simple;
	bh=utgucMdZhKPLHhNs3lhih0dheLjpmV0RCiqozJ3xyO0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mdJYvdvmtSY2govjAWNVri1N2dT8A0BcKIrvZ1zS6dSN7ZWG5w5obECuhEpvqCyKR79TAHxpmtBLUy7aLsXTNdvIGVFugwtSOGpl8uX6kew7yTThaP1w8WU94S12/fsghBwyYcF4WrLlamlQ/d8U9FPrbgPc6Cy/TAVyIfb8he4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cwQPeoQe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XUYaHfN1; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cwQPeoQe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XUYaHfN1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9CF777A0196;
	Mon, 23 Mar 2026 15:18:17 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 23 Mar 2026 15:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774293497;
	 x=1774379897; bh=rrSLY1i31JbckCoomruP1YP4vOzVU0SZRcuaZb8uqYY=; b=
	cwQPeoQew5fBCvTEzZKrcXg8biNDCdn24i2ok1RUEH1/6G8fzU6Ourc9RZFJjY+Q
	AvJ+S4YzZZ8uK3GG/mqMmLnTnfM57MIebeDH7bypH3GThKyX+JoqJhtIFBbhqCoe
	HumiCsuTKH/eiG29IQNV/gXhAe1S1rZCzOH5bNPg/ACVA3uIObtLMjDuv4BVHfpk
	o0KkrO0CFGKx10Mt3a0JxEVWtrtewN47HmZBHnth2gjhjxZY3229kKyFBmn37UU/
	jruocPEv2U5TSniCrZpn3lHv9eqCKLDapU+9RRrgMOUxjIBMPHqIYTpHrJ3PBKHt
	YTuJeASbP2UWKdzGAQK8BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774293497; x=
	1774379897; bh=rrSLY1i31JbckCoomruP1YP4vOzVU0SZRcuaZb8uqYY=; b=X
	UYaHfN1zT5tiQBRHR8+oFV16eU8xkDbP3eRn7A+S1ejqQhd64VtENgpjCT+seVbr
	LpqXkPAhExxSc1T2wdH/lwzQJzJlsjjK2cIzT4s1nw7frcVkYaw4xgW/nxjTdCKv
	mnpL1NW6OxQq4jSvj3K8EB9geYj0ncBn3kMaY70GZMJXZQenM9/zhgcxziABgVTq
	8uRlfRqP0v8WHYDGCemiaUyMRcNtLsz7w88CEgVme0H0spMccxx7CHTtWKKXWUrB
	2+TZ7xIkdkGUfyOEstbF+tcxc6nZlM9RvVvkN+437qjfPCEKoM/QYn8DUKBdL1w0
	6U0PEr2G6+7gETrM2Uogw==
X-ME-Sender: <xms:-ZHBaUD9kOxoEbqspd7cVCdD8RPrRXRahzxBjQlhtZZJP1l4RIwboNg>
    <xme:-ZHBaRUo0s-7o6wQxmjEaciYSv13RULA0t4Mxjszrt9d8qFpsDDvFOkOKr5M1D_FR
    JHbdr7CXgXimV_fjrhUVluvdrkpKMPKxV6tuzpi6uuHH12-9XYQI_c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudelheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtg
    homhdprhgtphhtthhopeihvggvtghhvghnghdrtghhihhnsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:-ZHBaZF7netm4NRMGFO7lRGI8e8sv4mkg2f6CWJjkWeVLXsR-eWsyg>
    <xmx:-ZHBaf0MX_y8HJXUGW9fp99d2sBSA9Tulk2vMprZ5BE8DuI0Rx0glg>
    <xmx:-ZHBabOSdW4DUzAp87SoMytpSIoMQL0rQL0Fa9_wn8f_4NfQME1XQQ>
    <xmx:-ZHBae6h3CTJFB5bCwt0KqYzsFyxz6ZJr9NFqBuPXh1-x_NpJbJaiw>
    <xmx:-ZHBaVacJrTNsxiyaznZl8CfUNyeMbfS-QcM2Mlunk_LNcpOrLgV-MJl>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 548A11EA006B; Mon, 23 Mar 2026 15:18:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AYtcxx2tdBSw
Date: Mon, 23 Mar 2026 20:17:56 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Toon Claes" <toon@iotcl.com>, git@vger.kernel.org
Cc: "Justin Tobler" <jltobler@gmail.com>,
 "Siddharth Asthana" <siddharthasthana31@gmail.com>,
 "Yee Cheng Chin" <yeecheng.chin@gmail.com>
Message-Id: <ccc995f1-4da2-468a-97d6-f20993ca4b4c@app.fastmail.com>
In-Reply-To: <20260323-toon-replay-arbitrary-ref-v1-1-5c7172f675ec@iotcl.com>
References: <20260323-toon-replay-arbitrary-ref-v1-0-5c7172f675ec@iotcl.com>
 <20260323-toon-replay-arbitrary-ref-v1-1-5c7172f675ec@iotcl.com>
Subject: Re: [PATCH 1/3] t3650: use option with value consistenly with equal sign
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026, at 17:09, Toon Claes wrote:
> The tests in t3650-replay-basics have mixed use of option arguments
> with value with and without equal sign. Bring in consistency and use
> equal sign for all options that expect a value.

If it is about consistency, could you pick one or the other either way
or go with whatever happened to be most used right now?

Consistency by itself is a weaker argument than arguing that stuck form
is better for invoking git(1) commands, which is what gitcli(7) argues.

Which is to say: arguing for stuck form in the commit message based on
it being better is a stronger argument than wanting consistency. :)

Then once one form has been argued for or referenced it follows that you
should be consistent and use the best approach throughout.

> This makes it easier to distinguish them from positional arguments.

Maybe it=E2=80=99s just me, but sticking with the stuck form makes it ha=
rder to
mess up writing unintended options and positional arguments. Once
written it might be slightly more readable, but the main benefit is
using a style that makes messing up harder to pull off.

>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  t/t3650-replay-basics.sh | 70 ++++++++++++++++++++++++---------------=
---------
>  1 file changed, 35 insertions(+), 35 deletions(-)
>[snip]
