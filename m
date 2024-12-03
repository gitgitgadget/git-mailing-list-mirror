Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB07F1304BA
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244425; cv=none; b=Fyt1gP1W+GHBV/+D365eLVul77zEWmRZnjbWbkqQiNFF21E8qgoJzt+UjTn8+Gv94RdYtIbqF964Qdw675zxtoJB0wiKiOlH+NcLVk5SftWuq5V0lNalNXvdzVJyk4cxX/cxvBleQtNlulxI2BQ+xK3/YXGlSvb2SxiZnaJ/BG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244425; c=relaxed/simple;
	bh=8lEJP3fUvizipMeOVH9+pcTudev/nJuT7p/nQjeisq4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CwtH3Cg9bEOMJGqrJ5PbOnOgdBngJyXaPEmt5i8uJ1/GROY/ATUrI+cKkqxvk+zHWBEy8+48UbwzCf/4n+wd2AaXY0xqX2hdQNA7POB9N4HkCWy44tasBLa+RzNgqBDN2lzPbdAEYIF4bygAytguk505QU+eDExLuJu40Ne4ZRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jOuoWR5x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rxVOGELc; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jOuoWR5x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rxVOGELc"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C5882114017D;
	Tue,  3 Dec 2024 11:47:01 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 03 Dec 2024 11:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733244421;
	 x=1733330821; bh=EkkaQHdmXGUp18Z5z9RCVPiJu/AunXGD28/sXBgntH4=; b=
	jOuoWR5xtDOGSBiyJWHJ5IFl6gDf0EXgW1TZUb7yptpGQcvxr1pbgRZn2i3QnZls
	DclSIR6+xgLazbR/DmB0KzqiYRZwVkzbiJ5J3KR1mxzaTGO/1xpLFAn4PFQBe17d
	Z+TcNFNw/xieiYrII28DJ5D+g1nFceMedoxxt8oJO91s6YN/cZE2NcpMbLArDxR2
	VWjBOoEazU2LVrcvjybUfhwcRH8OahcaiKce37AStou7W7IhsLn7GrJt31bwhY8b
	i0tQ3b0tGEFldGQRl6uiK3bvlypi3C0sC6njyaVEgO6GhKKj1162bOgODX0n2jfO
	xoanVPF60zhXyvmc6ESWsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733244421; x=
	1733330821; bh=EkkaQHdmXGUp18Z5z9RCVPiJu/AunXGD28/sXBgntH4=; b=r
	xVOGELcL9KuVZwbItXEF7EzR134APgfujvRJTK7aOAajRfNHb4S+MYxYqbgV7HQA
	W0UIOyHUedY1ghVuCYAfeQSoeigl4LxTr/Ug1DUZgCZjgpHXrVJpTerUx5xQPoG1
	wZZzEKGPIkCJSu04Vt0nXIZ5/fHAQOisPNiE4ZP1vm09hkjOVY9oKl+DT9NiGv7i
	zU7qKvuuXQJ+cDk9OM88uAFbfcLAGS6lbacS8faU9w0YMACjuuqRHWVItQzijAhf
	6o6cJVXjWdZI9vEqsiquisAAlsJUrXijG+a4/NS2Z39FBIk616XDw1ztnNujVvxO
	pWw8sDjhHqxGeiAwKMvtA==
X-ME-Sender: <xms:BTZPZ2xoctYYROCozA9mvpXe-MFGq2DGObY6DypWPMLkVMjCKmNcp1A>
    <xme:BTZPZySaDUxYA8RcVDYZD7bcpk__Xr0k4CTxBS2p9LGqWArWodB5VdxMD6YeBu3Ts
    _ioXKZfJZdlemNQBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieefgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpeegtdejieetgefhuedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetff
    ejffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BTZPZ4VR1-KueblkVjr-5OACHShnV_rawP1UNc8C1XH9b9QEaIlRmw>
    <xmx:BTZPZ8ifasqcxj4MqmFcjt4mpdNl-tAn1ViSAzhkRwFZOI_MZNf6jA>
    <xmx:BTZPZ4B8l_Oi5Iof0NbcrWpZeDb6yEohiXdQ-Q2hE8QC9v_h7L2_jA>
    <xmx:BTZPZ9KeQRiTUUClVWJEcbFFG4NCEANlh9Y8yfq3j6dai3V9GQp5ig>
    <xmx:BTZPZ7OZJbh4tyVPHUtCcQI5YFIqIu7W-TudM7sAgA8qdInmxTtclLap>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 850DA780069; Tue,  3 Dec 2024 11:47:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 03 Dec 2024 17:46:41 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Karthik Nayak" <karthik.188@gmail.com>
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <14f1ff64-bdd6-4233-9358-d56eb64a2d57@app.fastmail.com>
In-Reply-To: <cover.1733236936.git.karthik.188@gmail.com>
References: <cover.1729504640.git.karthik.188@gmail.com>
 <cover.1733236936.git.karthik.188@gmail.com>
Subject: Re: [PATCH v10 00/10] packfile: avoid using the 'the_repository' global
 variable
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Dec 3, 2024, at 15:43, Karthik Nayak wrote:
> Range-diff against v9:
>  1:  d1fdd6996a !  1:  d6d571c58e packfile: add repository to struct 
> `packed_git`
>     @@ Commit message
>          on the global `the_repository` object in `packfile.c` by 
> simply using
>          repository information now readily available in the struct.
>     
>     -    We do need to consider that a pack file could be part of the 
> alternates
>     +    We do need to consider that a packfile could be part of the 
> alternates
>          of a repository, but considering that we only have one 
> repository struct
>     -    and also that we currently anyways use 'the_repository'. We 
> should be
>     +    and also that we currently anyways use 'the_repository', we 
> should be
>          OK with this change.
>     
>          We also modify `alloc_packed_git` to ensure that the 
> repository is added
>  2:  65c09858ce =  2:  fa69763468 packfile: use `repository` from 
> `packed_git` directly
>  3:  80632934d1 !  3:  c6acbece46 packfile: pass `repository` to static 
> function in the file
>     @@ Commit message
>          packfile: pass `repository` to static function in the file
>     
>          Some of the static functions in the `packfile.c` access global
>     -    variables, which can simply be avoiding by passing the `repository`
>     +    variables, which can simply be avoided by passing the `repository`
>          struct down to them. Let's do that.

Nice, thank you.
