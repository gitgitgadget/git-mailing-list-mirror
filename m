Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED6D2F6181
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 11:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767697748; cv=none; b=EdI1zbxJ8oj1jz5NV/hKhoHTDEuvw+V0OemhOyheDBKQA+P2YUrNH7t/JMrci9skk8SOhSgRdlL/rcXoNazO4LNMCKYSLmWXtUa5LqhWE8ni44U6/EN69ERXT5TvwThnvhnI7NIAE0S+svmqkUn+KLbJoROO/ivtFCqJY1umZoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767697748; c=relaxed/simple;
	bh=INxilkxLeFyumTyZbTtQsf7ObL1MrSr4u0KONxibaLY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=l4g4GWEw9ZoFRa3phsgNN+FZKv1xyee9qmtXt+/+uYmEf99mmFp9UTE2CyLqqYoWHccJ27n6U9GAxfYoErBcvqWB296GjRscPkL6+OAdZDwS2z6POik5DSYnb1QMH0N7uHu5yhm+pp7B9CrR2FHuHZhVlMbox+Yw31+N1NA82Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=U8JG9Ape; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S3w0WN2P; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="U8JG9Ape";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S3w0WN2P"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C0C0A7A00B0;
	Tue,  6 Jan 2026 06:09:03 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 06 Jan 2026 06:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767697743;
	 x=1767784143; bh=INxilkxLeFyumTyZbTtQsf7ObL1MrSr4u0KONxibaLY=; b=
	U8JG9ApeExB5SHvgrNE0ZnYvRsBqS57h7wHujTRsyG3znVfcbxlD2LPmJ8aD35ap
	OhGspHMSXw56HzDVvgjILzDmyG1Eq+D3dY2gH0H9lDMgdjop1bjIeJMTaP5P0I+L
	CtTH3OfQvY3lJd2uChTr9PKeN3i05zz4dP+42tS5qQQIUaZWWRiPXThl3yDyiqVD
	eRLVr8gexodnvphHp2qPu63tXs82tUDyLlN9AI0O/sWoaL31QnM+rdLMfxj7xoxc
	YwwbVdM/ZCSE8ks90Bowm9e1emE6Sg60L7pCQQ2ZuKkwn8Q9uni75a5++JPUagdR
	BQWyRAHRIpSIFWjBRy02PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767697743; x=
	1767784143; bh=INxilkxLeFyumTyZbTtQsf7ObL1MrSr4u0KONxibaLY=; b=S
	3w0WN2PD/JV2Arl4cjPc7pZ6u3LvlHJeEsY9Vd38hUn6Sm308yKjMHYYjOEhPCv1
	FBC3EQkE/0A5UCgbag1JkU5pXp+ru1TynHeba8QtfhEw2h5GXRuFlpZHWaRPBHGa
	SsF+Z5Jn5FVvjyLAgR1C0wIkugu9ijvevrtts7qioJICzqKE42CyW1Vn7V39O8D/
	u/ylLQ6fr7kRM9xFXanIKd3rI25m82PH8B02WRedkKSLI6Aeshl9PVRsNynP5K0l
	YYsOhgQwXdqSV+Mhk9FUTP/HGi39z+anFO2YqNlgrJy+hhoBEw+YgWR3Bch5x77k
	YAYxEJrARaU3VGsQFJlsA==
X-ME-Sender: <xms:T-1caUiZmT0RYd5ekfcKSdbxF-9AOCb78Bo8Oq3NJGNu0nBq4P_4PTE>
    <xme:T-1caX3HC9SaMuOCoanrwF8MAlx2vrV28qjb5wvSYf_DMoEe6ALI45tmZ-n_aZv9x
    qMoVoLx6bI0l-BJYeQ9DwCp8jbXwLjx47Pdc8FgvjWW8ZJsJJwz7NE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddttdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeejpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegrsghrrghhrghmrgguvghkuhhnlhgvhedt
    sehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhm
    rghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:T-1caZZmPWBfu4AxnMcEa52Lk4DVrflv4Y551P8Bk8O40d7YiYd3qg>
    <xmx:T-1caRHgRlkkN6C1G8yoVpytoUsLTfO6QBQDui-x0dFd5N_8CF7_eA>
    <xmx:T-1caaKB3UV9WbKhAfkDL84-r1RFNVw2gSoRUgCm9rEfbs0ZiRvypA>
    <xmx:T-1cacMdbRE30BLxalzOmVROlZzvSnE35-fJEzHmFU6qqiypIDZLnw>
    <xmx:T-1caWB8lHnnN3mHDXjILNXzlvJ2K6NeUalBpS0qpGdVBIDSkNSo8An7>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 71A771EA0066; Tue,  6 Jan 2026 06:09:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Acg0X01AOJVc
Date: Tue, 06 Jan 2026 12:08:43 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Samuel Adekunle Abraham" <abrahamadekunle50@gmail.com>,
 git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>,
 "Phillip Wood" <phillip.wood123@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>,
 =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 "Christian Couder" <christian.couder@gmail.com>
Message-Id: <dae478ce-d5ba-4649-a6ab-61be29321131@app.fastmail.com>
In-Reply-To: <aVzsltM5imOSvW2G@Adekunles-MacBook-Air.local>
References: <aVzsltM5imOSvW2G@Adekunles-MacBook-Air.local>
Subject: Re: [GSoC PATCH v5] add -p: show user's hunk decision when selecting hunks
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jan 6, 2026, at 12:05, Abraham Samuel Adekunle wrote:
> When a user is interactively deciding which hunks to use or skip for
> staging, unstaging, stashing etc, there is no way to know the
> decision previously chosen for a hunk when navigating through the
> previous and next hunks using K/J respectively.
>
> Improve the UI to explicitly show if a user has previously decided to
> use a hunk (by pressing 'y') or skip the hunk (by pressing 'n').
> This will improve clarity when and aid the navigation process for the
> user.
>
> Reported-by: Reported-by: Junio C Hamano <gitster@pobox.com>

This is doubled again like it was in the first version.

> Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
>[snip]
