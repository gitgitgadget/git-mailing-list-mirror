Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC0B3D69
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735317779; cv=none; b=LIGwTi8qz4hWdx4mOrLi1ZkDt0FBBmS7IQeb/s8C7tPVatbyp4NTX0m3pQcj1NhGNUD/gyhVym+sfxBxyzAUoz+hKz2XVriAdwFqPjHZevYJ5VRFy29ZCKayVVuZJ/gy6MVydFbO/7ZnzHT+cb3xxi+zQIj+SmaySekrMBZq4Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735317779; c=relaxed/simple;
	bh=dUlWqBbO5+WuYWk3IRmg6cS3WmM2IAzAA8eu+99bTcQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FN2C3xNE9r7JZ9rlrLHCsMK4jcSIYL5A0+yMa4j/vVbHzGC6WNBN90luSjjjz1zxdgqpr2/FryMdVtCySfjjSJpcGq9uGe5wHcHOT4L5wdm3QZKvwtaEF6RJddV4lK9PkM7vfHwqxhU+v47n2I4qbUCphSi7ihEBAqaIA2aKM2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Es1nTSyZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LaC3xKhj; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Es1nTSyZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LaC3xKhj"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3E26A114010B;
	Fri, 27 Dec 2024 11:42:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 27 Dec 2024 11:42:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1735317776;
	 x=1735404176; bh=Bmk5BIZsr0nD3myXzTPgxqgxyyeUgMK3bkkEhqcqO1Y=; b=
	Es1nTSyZGe7LmmW9Um6sKQNjZP+6RsEhmjeMIriEc8riz8TvVY5O+5afQ1mtg3SB
	3i97Cm4on+ivplM2bHTPTNRtsYosibkdtROjUHsiMUZvvwtWiRTVczJPY70mHGe0
	cPuje/sZSJdOJcSThK0ToLvILLoRaJ3whRrr7Jdb5owIYtK+xDfKGKfdvmgHoRFW
	mrQT/j0Bf4FG7Zu3BRAcA930GfoAzkR+Z1UlnLyQirMc5PPBmwyb4a5Ars1dWKs3
	OZsDWeW3TXzI0OwHaObpgwf41iLffM/akkX3qorHs/r27oZGYoKzbSDYti2i+DNW
	PFBPHC4MvEgpoVh2xQQ7xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735317776; x=
	1735404176; bh=Bmk5BIZsr0nD3myXzTPgxqgxyyeUgMK3bkkEhqcqO1Y=; b=L
	aC3xKhj8jR0L96R9I/DzMRzld7brFuit/K+RRPR8B00lczpqlg118n52fq0lIX5D
	XfhrF44Lk+ux7tPj9jdq2rNWs2xWEmNFXroRnDTwgHVyryCgsTW8pN8pis9RsnQz
	7f6nb2BBXYpZvm+EI3U7S+zeza2h8IdpOHEPGgewxiHCUpPVjGdwLb9BVvyUUT3z
	ga3EEp7rCwFp0qqo7BC+HRSy0XtoP+Ezvx/2IDnnG44KcvRWqjyi9RLiqwv5e96X
	tFrzW0lWBb5V9fEm20bU+2HASiRIid2nqAdnhcttGI1oiEydYB8iCsHxuU3G4/S9
	zRVRimb6zcfU5dNludUQA==
X-ME-Sender: <xms:ENluZyhBatjLzucwsW8IWpjBRc4pYUyfFwtWhSr4H26NmzLRiVqYOw>
    <xme:ENluZzDKnaSywlUgR2pXJ-Ak_rQng9gV3cSnIEYx6nPJCL6cqD8_er1sk4sWHGgfc
    ivpe3FgzRY61o8LJw>
X-ME-Received: <xmr:ENluZ6GOdtasAjRjE-JyYNwrP00vc4hevVLMNeWTZ3P0jPUONxsZTYHk_ywY9zc74mWsNVGB-JGhXIqFh5ACXwOh4q7dKaVpHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsohgvkhhklhgvse
    hfrhgvvghnvghtrdguvgdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:ENluZ7TM7jPeVRAtjDIlJDogW5iamQB_hWc34j9QQaDLBrtIakTnxA>
    <xmx:ENluZ_ykyrKaX3TXCdknLfed-pgyYcq6l5U99KmlBP7b3v3VyU-zIg>
    <xmx:ENluZ55DuVHi5vRNQw3OBm439f9ne_C0Sqm8Gtzx9DUsP_wHT3s1zQ>
    <xmx:ENluZ8xP5woQ1Gy-bM27xAK1ydpx21ynJFheRVpaetpw-ZxS5Z7FSg>
    <xmx:ENluZ6rf_heG0yoYhX1rzZg9V_7mkyjmevdQIHvNg1Dv76ofnDf52EAE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 11:42:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?S=C3=B6ren?= Krecker <soekkle@freenet.de>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/4] add-patch: Fix type missmatch rom msvc
In-Reply-To: <965ac9bd-7340-4dbd-88da-2daa88c126c4@freenet.de>
 (=?utf-8?Q?=22S=C3=B6ren?=
	Krecker"'s message of "Fri, 27 Dec 2024 17:35:56 +0100")
References: <20241223110407.3308-1-soekkle@freenet.de>
	<20241223110407.3308-2-soekkle@freenet.de>
	<xmqq34iaxh7r.fsf@gitster.g>
	<e396131c-1bd3-46d0-bae6-cd97ca9710d8@gmail.com>
	<xmqq5xn5urhv.fsf@gitster.g>
	<965ac9bd-7340-4dbd-88da-2daa88c126c4@freenet.de>
Date: Fri, 27 Dec 2024 08:42:54 -0800
Message-ID: <xmqqfrm9t6up.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Sören Krecker <soekkle@freenet.de> writes:

> If I understand your comments correctly, it would be preferably to
> switch to a data type like uint32_t or uint64_t so that the behavior
> is consisted on all platforms?

I personally wouldn't prefer that.

I'd rather stick to some "natural" platform type like ulong.  I see
no strong need to say "we must behave identically on all platforms"
in this area.  It is preferrable to have every platform use the most
natural type on it, and make sure that we validate input that is too
large to fit on each platform correctly (i.e. it is OK to diagnose
"too big a line number" and die on 32-bit platform with much smaller
line number than on 64-bit platform).

Thanks.

