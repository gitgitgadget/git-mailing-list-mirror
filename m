Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D396B3BC4E1
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768494957; cv=none; b=ZJRAgL28i1Ip0TnM8aIYD+RZTteLxKy3eoMBYsipas30Qi8MFSTXueCfyx0EeVFFvLp2o+DGOI3Ej9pyDkWbT6qmomdxLg1NiQ1IpQXKrbIbbihMLO2mUH7yDs1UCzf9h41pjPvl/usCJEn/FHauouby6XfhnfKI3anhIXf3c7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768494957; c=relaxed/simple;
	bh=e+3D0fa1aRlFuVdjsYBRz/xI26b8W3vV4AWEVBlp0oI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KJtw93Trl6htIODeKx8y5MLjiWvmxfiAc5MhjN3UNdoWlDoEbJjJx79Rvx0L+l1KoMUb1JC6fx3Mz9UOW2JW1UQWVlh2aFmCYwu0tWQhb6mT+gSeQ7cwUr3AtOYLvBz4R1Br3rzGQlkZUdhUaKaouYeFmQTv062ldu23jxIBm/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hk6rwrY7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X+DbBNtY; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hk6rwrY7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X+DbBNtY"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0B81F7A013A;
	Thu, 15 Jan 2026 11:35:55 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 15 Jan 2026 11:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768494954;
	 x=1768581354; bh=R4NcDUsSyvshRitOubogbBo0sT1Eo7w3K8tYwRdVTT8=; b=
	hk6rwrY7siNZa5eZT8vYxQOja+WprbOz3eApd3ymAyfEVIlzyogctWmvL1bXCT5b
	EmxZlhu7nFGs50GNxvFtgEKawkYgFla1EUCUCIW674i/X+segtN25JhA8CEsTcQJ
	lNYKPrbLJPLUwi0urojWF8X42aHZs3n25oiDRc4TOqtcbFM1ddc/s3E4Z3YOFwv6
	3eB+LqxbSwzqgFxRp8RJCd/jRJUYXCmKp53nnooK56dFy8uzoKSnuG2LHYiC/EmC
	eXGKf6LGjHbz23WWKLQnxdRPmH0Y9E9S8PeLCwoBjFJIWnygUkAzxaQFOKWipdKM
	JVBmjkm69fdQvKw3lA+tuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768494954; x=
	1768581354; bh=R4NcDUsSyvshRitOubogbBo0sT1Eo7w3K8tYwRdVTT8=; b=X
	+DbBNtYMKWPRatmvNp9q7ucUEjnoitfHuGaRdrbydOWTnz5bUXvOho+3Pkht5CrE
	wCO/6Asz1p70tvCpRBdgVL1MIGwq4cB8+oa+piak0AEjnxBRn1kAw4aZPs0+IfHg
	KbVaaXWe6IB1avl/fSyqN2G67TJae9fjPgPWMg7VZXZ79uOfbVGn7280iVDp3O7C
	7cQnQj7E7W8MNl5/2xLziTkXw3E5hmvHCUY05servHGmKLox7WgWeME5K0no+G0M
	F8Oi5B+ErTobxzlW9beNj2p63x3mkln6I7fshrOblWmXssxqPH67GEDOGzOg7oMt
	O9cN9nkjbonEWSLJo6YZQ==
X-ME-Sender: <xms:ahdpaTxON8Djvt9aAMsvslglN8L_kP7sA46EMiOVYEOIsL7adiAVgw>
    <xme:ahdpae94l6bkD2qxUgYRiEWku1xvqu0QuVNrxoyLF8tW2peGPpmCk_iBZg-RBusqO
    vnZcF_GXLUgCmXnp05GjeHhzjVTK_6kshIG51uOm-Qmnquv4Vhejg>
X-ME-Received: <xmr:ahdpaXKSPAzaptV06rj8T8GJVNABsz3J5RMMlOl3PTpgM9hE-nNlkZ7Eam7Rh9Jw04J_GRjVFCBBQpExH5s2uBtT0bflNMqJTIm0h_s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeiheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehguhhsthgvugestghouggvsggvrhhgrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ahdpaUc2YmImgLccDggJHyFqQrJ3RZMQZo0KOJPEHH72w_ACuBYTeQ>
    <xmx:ahdpaW-1fiLU39M4Wsx-6hUyZ3dLreJxNlCFrnh7oYhwCj7OKmpXyA>
    <xmx:ahdpaRoZeZq6GC9V9zQdpk0d45lCD8TSP8CJk5NPE9RlCeSZcZDIig>
    <xmx:ahdpabCCHVCHiSXzANmNUk0bovGqU1i_30m48nTtTLeBvzo9QMd1EA>
    <xmx:ahdpacuoYOBLfDtqqHYeGFpa_XNHp_1-U2-dHRihp5kQv9V56OO6ZXjR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 11:35:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Toon Claes" <toon@iotcl.com>,  git@vger.kernel.org,  "Patrick
 Steinhardt" <ps@pks.im>,  Gusted <gusted@codeberg.org>
Subject: Re: [PATCH v2 3/3] last-modified: verify revision argument is a
 commit-ish
In-Reply-To: <bc0db8d5-3c5f-4dd4-9c35-ccb02a6bf5c9@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 15 Jan 2026 17:02:09 +0100")
References: <20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com>
	<20260114-toon-last-modified-tree-v2-3-ba3b1860898f@iotcl.com>
	<bc0db8d5-3c5f-4dd4-9c35-ccb02a6bf5c9@app.fastmail.com>
Date: Thu, 15 Jan 2026 08:35:53 -0800
Message-ID: <xmqqcy3adeae.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Wed, Jan 14, 2026, at 11:24, Toon Claes wrote:
>> Passing a tree OID to git-last-modified(1) would trigger BUG behavior.
>>
>>     git last-modified HEAD^{tree}
>>     BUG: builtin/last-modified.c:456: paths remaining beyond boundary
>> in last-modified
>>
>> Fix this error by verifying the parsed revision peels to a commit-ish.
>
> Nitpick: “peels to commit-ish” = commit-ish so this is a bit
> redundant. Either just “commit-ish” or “peels to commit” would be
> enough.

Great eyes ;-)

>
> s/verifying the parsed revision peels to a commit-ish./verifying that the parsed revision is a commit-ish./
>
>>
>> While at it, also fix a memory leak in populate_paths_from_revs().
>
> (Whether or not this is a stale sentence (see Patricks’)) Why not a
> separate commit for fixing a memory leak?
>
>>
>> Reported-by: Gusted <gusted@codeberg.org>
>> Signed-off-by: Toon Claes <toon@iotcl.com>
>> ---
>>[snip]
