Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F022199231
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 20:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728680229; cv=none; b=hRZnjkonGU+nkiGZm4NvtFtcectLFHeeMsLl9lNtqVJCsoY57BHxs2RQnz7tHGftA9knw23ABJv8PH12f+QJ3GEkXxDya7HUm9ntW1LSwmmTAypQ5imCnYQQxK9nF9Qa6a5FGsT3qJmQgRml6hHvcGIddqcZbQ3Q9saRMDAbg1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728680229; c=relaxed/simple;
	bh=5lekA7Cmi/yMPb4p/eZbgeodeF8J8Geu9NdmoViIEDs=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LP2i6ZMqVg5fJejZFLOZff7b094yd+xrqSM0l8f9P4KYrNsvtJfIruQIPsE39156vvgRU3w+LvnPrgiNwqx7wOgS9QIygCFP8xV0fi/nTecD5QTD/l0OmCg+4HMQTDqOk0Y8RKLdlfKi4vPQDngQNcSTpARCdn4pEjF14olmJnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=d3q8Uajz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iy49cTl1; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="d3q8Uajz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iy49cTl1"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 656CC1380246;
	Fri, 11 Oct 2024 16:57:05 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Fri, 11 Oct 2024 16:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728680225;
	 x=1728766625; bh=hNY+FfMhjZ12Dw9PAMnrhszwv0+PX6oNAfJly4wqVeU=; b=
	d3q8UajzlLlrdkQWB5r8JUpSoyYeWUSQmqjenY1bk+93LTRR9M5x+PSK3l6h3IYO
	urNIhosVX+his3SIK6f99FarvXn8YxqIxXi8xLqoAfn6rYnYWDxNdsj9Y6fAVIjj
	WnuU+J1/CCTfxYBibADe7+fFoi0xWZ/SBIHKP4trkgheV30/F0zGynQ965Ekgfln
	1uvpS1ElS5vr3iEqzG5gosZ4eYcr0zliuyV0wE4z7X4TpLkLs4+9X0vfTyGdsac9
	N4GFzhjf6AEVGqiPDK45wHzH1++Y7/ZyePFVOgqicZAOqyQUu3p1Qsfu/yi/TxeT
	yp4axiDvq5/0T49U8mhZWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728680225; x=
	1728766625; bh=hNY+FfMhjZ12Dw9PAMnrhszwv0+PX6oNAfJly4wqVeU=; b=I
	y49cTl1vY3npOVdRY8zF2uErqkwnS6s7pvUa3FGZEtFYmhd0+CwxD1AGheEbxFPL
	kmrTJFZsNS/R/QBZrRrtVJfIzfCpnvChfYNwwmm6wOoezzx85lv1AsZe/u3kXWYd
	XJtSm0Rt3dDH2i20PDHS3zmJ4kUIr85DIe6bNBYgXnKRVnh1sZhovyX6V+uhP4SU
	ZkOlnbjOPzv55eh/ujnZD1ET4TUCT4FYAV/b2K6V5CuTGIHEt5pz3CexHD6La7PM
	Kkk0HsKs5uDFiMdBl0PJ9ZShp6S4br3QebxjmjWGs4WB0gzkSD62m4F2jP8rWBrM
	I7qs3WMosQ9W1gZNsTP5A==
X-ME-Sender: <xms:IZEJZ8CLx7nhYC4iaiWrBRPV8Fh1FttTn6HQ3HM2OwjTE3PHOPdXQUg>
    <xme:IZEJZ-gce_7XyunQ6fPVjWcL9KAlfhIKn4dmMW2_d2e0LLTmtYgcD8R34j0npsfeN
    qHt6HYimcH8HZGx6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhepvdeigedtgfetgefhffetteeludevheetfeekffehheefieehudekveelve
    ffhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggv
    sehfvghrughinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:IZEJZ_kWpMMri6-iqWI2SwEEJvHu-Bqm9fN158RPdTHlgwuS1PoMgg>
    <xmx:IZEJZyzq8BlKe1AUdlSjGfdz_w_hBvTumekLzY21vX__7AE4L2EJBQ>
    <xmx:IZEJZxQBy8LBjVH2dD3CgisbiYrFLqSHYaPi_b3_1NqYnZC0vYAvwQ>
    <xmx:IZEJZ9YJviqIx6LSWS_z4cpawverXk_5chYuFBBUOizb3mqIPXrDGw>
    <xmx:IZEJZwKPMkFv5MvOOesnC-W3eC0UIdjHdEbi7lMiASZzkri1hGRKDXXc>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2785A780068; Fri, 11 Oct 2024 16:57:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Oct 2024 22:56:44 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>, git@vger.kernel.org
Message-Id: <cb60b7ad-7902-4293-81e9-06d1b1526842@app.fastmail.com>
In-Reply-To: <D4T9VCF8OS6U.1FMB8P6YU7I3S@ferdinandy.com>
References: <D4T9VCF8OS6U.1FMB8P6YU7I3S@ferdinandy.com>
Subject: Re: with git update-ref?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 11, 2024, at 22:51, Bence Ferdinandy wrote:
> Hi,
>
> the documentation for `git update-ref` has this sentence:
>
>> It also allows a "ref" file to be a symbolic pointer to another
>> ref file by starting with the four-byte header sequence of
>> "ref:".
>
> After fumbling around a bit and getting errors like 
>
> fatal: ref:refs/remotes/origin/test: not a valid SHA1

`ref: refs/remotes/origin/test`? (space after colon)
