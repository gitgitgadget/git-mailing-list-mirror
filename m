Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E55B1F462D
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944118; cv=none; b=C8dxyxTca70ciisH7w2k/hYiZTwrrF6jn3i68eSoRpdsOqQ4v04+U60jE+vFJ2Krs2hnKo7VOg9yD278JRwJTm/wuH6o6xBzb+0M58e9iQPDx/5GQdMROEUNUALfIK3P7KyAyvkqxrmqADO7sGs468I1jZ1H7Gn71h+3aPaGYXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944118; c=relaxed/simple;
	bh=EngqRgHdaV70fXzQScwqKcym/LxMUzFh54rTvv8HR9Q=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OkXK0mVd0u0K6IBedbobONmbNXrEIcKHV/kyiUMvSMK0oUJXBlQNOMAL6E9BBAmQKiHW6bXsEtc74F1eHdT0AZh6FZYUHDUDtI2OaDT+BhGDe0+/mfEVHS1SnxR7epn+73k6YbA7LehGSyVrsIj1F737bY7cnDPPEnPao6A9PHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lQdu3Fjb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y/IYr7IB; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lQdu3Fjb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y/IYr7IB"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 57FD6EC02A0;
	Wed,  8 Oct 2025 13:21:55 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 08 Oct 2025 13:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759944115;
	 x=1760030515; bh=A3dKhbEm/71P/qB65yH/z+V5Fh2kds3DafWc27ifnnY=; b=
	lQdu3FjbUN2jY/Rs+4uLIWHgn/NLK9M7swPuCscDjixPoAbh+dF1mLSz1oBBg++C
	9MDQWXR07h9Z5iyaiPYeYMDs6HF6/zBN8rYUJft9576WKi3wyTCj+J7ea4j2J/yH
	+DhQIsW43c93jiNq+hlayyMBHs1458NJ3J0ZqpAgPm/s4hd+eWMARNpMD/9Xyr0k
	PIdukYOdwOcCKl3o7T/eLcnyYzrpL3Kw19jRKM2Gw6YupWpKhnHBAcP0ArmptxXC
	mXvceJ9VfHccj4iTI6GVV/rE1fcCobqAN8gQ+f16tAe2YxOmS67ZBJt3zkepmmYa
	/n+osdiX5ZpGSuAL972Vsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1759944115; x=1760030515; bh=A
	3dKhbEm/71P/qB65yH/z+V5Fh2kds3DafWc27ifnnY=; b=y/IYr7IBsqj/+M0X1
	Y87WJbh3JrR6yo2LE6J4p0Xcb7CZKZDi5zd0WhmKsH4orx6YR8bCk0qpcqenhrwS
	arK2cHligIvFoEqKI4D1VNVklrdXox0EL5L1K0YJhbuUNA1tbnTEwesjEHXCaCNZ
	bjgNuPtGtOtJtiG+RT064skHx9q8YMq6McrlHUM4GKLqL4Ug4kzLUF/+7dsCyfdU
	uLKTpjHIVJwyKnd5oI7X/YlffOg6l2IPJRH2UvT2LPhD1wDieUTIpTiHVZ9h8Fbx
	UmtqvWutljJQXtPMKlx+bAuvqEpa4oAwsg7zyVi+JtPr87dZtiRKE21uMvif+Tuu
	35yVw==
X-ME-Sender: <xms:sp3maHcyHoq-p-8LYNJfxeIwFh9BPUxXlhZSlHztWiyA38qfnM29Pkg>
    <xme:sp3maIA6dYP0FmHafn4FSIKKOiBPdRtuB_ApLsxN-lMvSqfgJI6ombWyTFoMYcc22
    lujYZUMtaI4bd_UgIMhUDj7qTwCgnmwjbDgRrYgBXKjOpTheO_25g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeffgffhheetveej
    leehheelueffjeevgfdujeeuuddtffehtdettedvfedvudevudenucffohhmrghinhepjh
    gvnhhkihhnshdrihhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehtphgrthhtohhnsegtrhgrthgvrghnuggsrghrrhgvlhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:s53maGIlRsf0aJcLRLOSn3bBqngDEUHeHeGpYPHKYE_T0tJeIBU1dA>
    <xmx:s53maME_pni1Q2BVA6NUQBcpEh2TIRmqhIikVd3tJhjqpSakQjStXQ>
    <xmx:s53maOQIw8n9K0YwXf2S1LLSceryy6GC6cC4BlpIi_8rBNZeu7eskw>
    <xmx:s53maIGMz6lYnCZpBAPAZ3y9MEMD8-iI8qoAq6D4BBe_9kRprFzCzQ>
    <xmx:s53maFYl00SAts14JIH7czNmvZ12LYDWw9OpuKN0pi8Xe1ogvAIjfKxE>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E61FA1EA0066; Wed,  8 Oct 2025 13:21:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AksBUo9997Gg
Date: Wed, 08 Oct 2025 19:21:11 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patton, Timothy" <tpatton@crateandbarrel.com>, git@vger.kernel.org
Message-Id: <cf26c684-b5e5-4f54-a93f-85913e582a94@app.fastmail.com>
In-Reply-To: 
 <CAMnRnOWm8iV+JNcVReczh79pNX2zwsPcJm2z4a+8Uj3E1xcq5Q@mail.gmail.com>
References: 
 <CAMnRnOWm8iV+JNcVReczh79pNX2zwsPcJm2z4a+8Uj3E1xcq5Q@mail.gmail.com>
Subject: Re: Jenkins Git Plugin
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 8, 2025, at 19:10, Patton, Timothy wrote:
> I recently started seeing the following in build console output when
> pulling global shared libraries from Git.  I need to see the change
> history part of the build being performed.  How can I restore the
> previous behavior of retrieving the changelog when the shared
> libraries are pulled from Git?
>
>[snip command output]

This is fixed in https://issues.jenkins.io/browse/JENKINS-76017
