Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B6E5695
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 07:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767856623; cv=none; b=R+vzKo0XvxjbMqldscsTZH5RcY/zzp8IXXJiuHQwMhUNkCy3eAGciXrXwzNDjQp55rz0yUbOig8rTC7tCHCq4uXmZYcdY1xUGH6ojG03bfa5mOWJZO/Bk/qqlUIzLN5FUZHeF5AKKZdJZHcmNWwwQYy4WAmFD908LSTk4YGEgm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767856623; c=relaxed/simple;
	bh=zzpEr2CqISUk6xZqQunoUKwFfmI2VV+SiZLT/FHEGmQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=J6Rt1dEdA+nyuB3oxu4zHq2xpg10xDApNOUP0A+vf9yh7HzhDvmBsQuJgWCnQ7Z4sDUBHku3x1Okq3bleFbxl7bwLyC0INajGSHRMv4FXHaIQ8kAgIXWDcAwi+502oAWpKlfHDjUg0u4CWvT+qNtURKmsqlORiP4f3BHSNTmdnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Frj6MdO/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oJ189NeL; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Frj6MdO/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oJ189NeL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1BFE11D000B0;
	Thu,  8 Jan 2026 02:16:59 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 08 Jan 2026 02:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767856618;
	 x=1767943018; bh=zzpEr2CqISUk6xZqQunoUKwFfmI2VV+SiZLT/FHEGmQ=; b=
	Frj6MdO/EySFo52ZhjbMYTlYBLjrOpxFs4bpGrydXD5zqjrF9t8XmsaMxYxoNebA
	GvM+Epau4yZ5NqY7lpSxtE3Q1iNjXNAljKEzvmmZhBfQoxnyW8n0ZIydlSIUy8UI
	RLYyDwTnfPYUzVZM5Wue5Yp9tQZkjIDpN0uoTlQXqBMaSDsxdV813xqLkwoQ6lo6
	7xtfyNMqUope97NWg9pDSccQEqxNztqLCHPFWVthY8ITjDT0d/U/H6M0JEmp1/2R
	V7rnjuTHJlsNnjw8O2JXZOtBhMagTb9kc+MytnJUpwTmbBle4viBar35Ivc76DY5
	JFfvAVgTPw/ty8LCykLA1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767856618; x=
	1767943018; bh=zzpEr2CqISUk6xZqQunoUKwFfmI2VV+SiZLT/FHEGmQ=; b=o
	J189NeL53ppN1WCm9GAZ2VJ9RfCRftGWMQDlXhQMX32JoMiwFz19MeyzF0bxK+vx
	xgZDSwaxJZ/amFsIfc4iCgqV/Baz7f7wOv+fDOnaccPKDOY5mymPvhrCk8CFwUzp
	H5/khTVxesG8DgQu7siZpHPa2R4lZWUP4eT5NTXhV5fAZdr9Og8+dzT1aFh0WN/f
	5fSTInDbZCUaShZLnohNYSVJzmi3kT0T/LgKf7PVhO/7TYo7E59c0eX0HmJjWBg+
	e6GFPuuOSepszEA4hTW4MaenaHxxHLRCOpRzDHccZ8p/ct6ADkK+OR92UoPjkcPZ
	8H5Ov0Wqrnm5RM6X3vTNw==
X-ME-Sender: <xms:6llfabD2CJjUDBh9Rmho4QpEhopkHcq5Gb-0UMp5zDRzfEj8zsjYq5k>
    <xme:6llfacX8Qa_Ni5i-eB_1ndD5RQdOpG4o7k3i_xx5lSD7wGDi2HLrPehRsgJvXTBp8
    vAcLS1ONdqsaMEHCWxKnkfQSd25HHDpAvbY5ez0pCmr9chL5i2xxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdehfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6llfaYfaq5Nx4t0Vl8NaASCSoq-ecUz4LlJdm5GIElu-P1bDxAqYXg>
    <xmx:6llfaR_Zv7WoBV8JOBu5vyzAWP7qTosb4kttsioJdX1E6shWBw83Eg>
    <xmx:6llfacnHtjSyDa1n_tyvk4QUQIhw9qXnf4SWrySp1W0FqxMgF-Gqzw>
    <xmx:6llfab8nLy-ZSxVF-JxiX1dyqccnQwPywBaLyJGvuSd9oSTR1VSmLg>
    <xmx:6llfae6Y4vWOGyaaVo3aRwFJGtImRXWkA-3zcas6QdYc3TuUCpFapoyt>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C913B1EA0066; Thu,  8 Jan 2026 02:16:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AADRixXaSuPs
Date: Thu, 08 Jan 2026 08:16:37 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Justin Tobler" <jltobler@gmail.com>
Message-Id: <76bd89da-462a-4eb4-86b0-915f649629c8@app.fastmail.com>
In-Reply-To: <20251218-b4-pks-pack-store-via-source-v2-8-62849007ce21@pks.im>
References: <20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im>
 <20251218-b4-pks-pack-store-via-source-v2-8-62849007ce21@pks.im>
Subject: Re: [PATCH v2 08/10] packfile: inline `find_kept_pack_entry()`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Dec 18, 2025, at 07:55, Patrick Steinhardt wrote:
> The `find_kept_pack_entry()` function is only used in
> `has_oject_kept_pack()`, which is only a trivial wrapper itself. Inline

s/has_oject_kept_pack/has_object_kept_pack/

> the latter into the former.
>
> Furthermore, reorder the code so that we can drop the declaration of the
> function in "packfile.h". This allows us to make the function file-local.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>[snip]
