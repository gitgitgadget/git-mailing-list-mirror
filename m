Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2705A285C91
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956336; cv=none; b=IypnJJpBdAwz8WhPpOiU1TFvX1RK9v0HoRzqAZ99pN3WCtUdqS3tFk7HOrI8qq77yjjpdWijqUMJa4yHZ+bjw5WBPOFtACeTQSiVNaf3B/QPGjX5YQMr/Wc45MCSmROnFm7IFBagUD2VY1loKmW8I2FfgM6QkvBipaD4mrptDmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956336; c=relaxed/simple;
	bh=mvr0PvP6+YKXMwDwKZgksVjjCLhCYCXvnbqyDtzHN2I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o0Vv2NvJHuUuhhGElp/TDtMeqHjgAzgvZ7Va/6JCLNXng1Blc4sFZeEFVyBLtf7eUAlcZD+iCjsRvyKrQD58YgSFioQqk35ZI4LYiOZKKC/yeZr6po7aRf7EwkCfKQ8quaD+RfAj/Ko/JNajDy+91yv7fov76gHbaofgDc5A+SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=plGcKly7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IG4URjFG; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="plGcKly7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IG4URjFG"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 26B41EC0288;
	Mon, 15 Sep 2025 13:12:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 15 Sep 2025 13:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757956333; x=1758042733; bh=IsFomLG6q+
	QtnmtxivCaslhx0qKvctP7X5c4YuI58Bo=; b=plGcKly76WLPbzdQ8fomKbbd88
	7PseFYpszwDpdg7kX2g/aa1Hd+Oapnims16AwD5D+4a9O6n6D2nMiesdYX6BP/U7
	pfPMc55XVKcowGOe0djlkwmHvXMhj/NVqtYiw4oWbWDrb2f1mUIVUFGBt/ZA00k4
	ocxWZtt3+yulpm6MH/qNDbN5jd0Ja6M4+YdeY2am5q6SR9NB1XoNe2yU6hLMKQnL
	q4l0DfK0a2HDF3mNA721E5YzvvTsLKQLXVAREvPkiB3fNWB0C8ldOzBFROPVTZS7
	zE1GRzkjNlNMIcZt6srmobYmIuDOziSYsAbMKMgQ5d1DCTXgUEdU3ze5kObQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757956333; x=1758042733; bh=IsFomLG6q+QtnmtxivCaslhx0qKvctP7X5c
	4YuI58Bo=; b=IG4URjFGS6UGfSbmFkj13097ALDT7ZXa8QSlJ382ZUecU2vvCaB
	3rhutPVtRrEXOyMsRqPWTyeLaSjZZE60VC5mmch6AEkcWSeavO62TY4v4BE1FVoU
	0B2gut3feSRy0NjIiwaFRJnnSZhC5+sj96ovtP+/IY91Aw2RW1IVuxOEEOAkeXV/
	qHXGAM+N3u9PFMw1yd0ZOcXx5cCqkjQigBoQdd4BZ0DR80aHIQw7XWG6YrF8X5oU
	/U1pNDRP2PxL3fjuDviFyqvWmO/P2l7k1u8MvkiKS8Oo67c6rl18A4wM5zz5sc0J
	4GFLNk+zRxdNSdoqh9K9JC1axr0SQdfP61g==
X-ME-Sender: <xms:7EjIaOymO3E91pVVTgfENlpGjNoDnHCddYBZdsJ9WhKbjorcs1UpIA>
    <xme:7EjIaFI26s27sL-gR6ol5mQ3YqX8m_D3W8hxCbBQIrAcHH9RichCdxYCW6sGKGOPb
    gEmfj3tUpzTx1bIuQ>
X-ME-Received: <xmr:7EjIaKgYhRq3Hpnhh0k3EcA8ERMbvuVLPFPhZgWiygniGllx5V3O6SnWkIaeDOFOM2-NF4ZpfH-PZ_ZmN6vJOyRCX0H-a3tiNzAKv7M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegtohhnthgrtghtsehhrggtkhhtihhvihhsrdhmvgdprhgtphhtthhope
    hsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopegtsgesvdehie
    gsihhtrdhorhhgpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpth
    htohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:7EjIaGOtsRkGz4tW4IsCHFy3DL6WsmwFaE3DsZxroN3SPvxWQw4NYQ>
    <xmx:7EjIaF5D6n-Rn6VPl9uu2ZRQZgmFU5vekMNk0kXhe9PtOoWbTtU5LA>
    <xmx:7EjIaNkommz9f2YdlCypBWP6e-mglFV6PlMqZKqag7dAIhPOH7g1hg>
    <xmx:7EjIaFIk5EHLdCmCJAYSJRSPB2921NZPuBahTkMqBKnMihswgBmAUw>
    <xmx:7UjIaHCKSUyYG0f6iebutQKh1FvEsRTzqTpizNDfiKqYKXcFV6wV4b0Q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 13:12:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Haelwenn (lanodan) Monnier"
 <contact@hacktivis.me>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ben Knoble <ben.knoble@gmail.com>,
  Christian Brabandt <cb@256bit.org>,  Collin Funk
 <collin.funk1@gmail.com>,  Eli Schwartz <eschwartz@gentoo.org>,  Elijah
 Newren <newren@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Pierre-Emmanuel Patry
 <pierre-emmanuel.patry@embecosm.com>,  Sam James <sam@gentoo.org>,  Taylor
 Blau <me@ttaylorr.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v5 0/9] Introduce Rust and announce that it will become
 mandatory
In-Reply-To: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
	(Patrick Steinhardt's message of "Mon, 15 Sep 2025 13:22:47 +0200")
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
	<20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
Date: Mon, 15 Sep 2025 10:12:10 -0700
Message-ID: <xmqqsegnhc7p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v5:
>   - Fix indentation in the BreakingChanges document.
>   - Fix a commit message typo.
>   - Include "Cargo.lock" in the `make clean` target again.
>   - Link to v4: https://lore.kernel.org/r/20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im

It seems that we are converging with smaller and smaller changes
between iterations?  Will queue.

Thanks.
