Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE001A7264
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620524; cv=none; b=s3EUdp+NYgJspZH0lbGl5BJ1Aa/zyeVKfQZtfbKKQ9YDX9uL92f85962VsYlI/UuBiJXg0Pk9I4aGCmyUXPMHlh1HFWO+lCdLCrJ6R8Vtk7rLQJzGJnBiI3jugToUhx600Y8hvE77DmprYfZ9pYChWBWfWUS3h5wu+XXI9kXQ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620524; c=relaxed/simple;
	bh=Ot/9zRiUL0EkouG4hQobFjtT0QFU3q6T48cWCcpQRw0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G4yDkOGzMfCC8qSnq+zy8CJr0UVHjgU9KJmIwQWV75iSXwTUuejNM+IGBiqwmqWMSIIJdCuxqNWyylCesX80LZJzbV7RrOCY4OnehF43+DyXFruTUvlq2Uw4OusCmaeqKgPtlkjcmTHzNOaN6suGmuvZCC+A6olybIQzKM7fNeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E1MoEWil; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GJROdW0s; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E1MoEWil";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GJROdW0s"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 207C7114009B;
	Mon, 10 Mar 2025 11:28:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 10 Mar 2025 11:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741620521;
	 x=1741706921; bh=s+Y7hapbl28XM20bcmDp5ZM5Q8I+ru6Q+HYUhoEGGMA=; b=
	E1MoEWilvDS2vgShGIeSETXKHFN38+WtkG7KLBFRwJDdIBKWe+Q+YMNFyNyaqcBy
	0JXSeNg5zVL1JeUZIiaQY74392OZG1Is+Rs1uqEpGIZKmILXz76nF/5HVs8qjRlz
	IyjZJAo1YMO3Swiv+rQuvfSfKuE67oLCdMGusAh6rqqCKUsa1f/sNTO0INeNmjRJ
	1/wk6tuIVfVU9CjY0VQs50iEGzhhtbuXHtdN9sdJ1aYNHoCjXHzXYqNw4GysjhAV
	4z3Zx4zx7W9Y9q5ScazPKukMS+NpMd++LTTArXOxAZu1fJ+1dUHocmXn4Ao3ybcz
	D/96IrRLIpCKw91jDAvstQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741620521; x=
	1741706921; bh=s+Y7hapbl28XM20bcmDp5ZM5Q8I+ru6Q+HYUhoEGGMA=; b=G
	JROdW0s1RvuFZd9aj2s0yvnbUvBbyUwL4ukPAisK9yUyuNfHXQhYvLBYPY5Actnr
	FeTaXrCYSm3uxk8cKpPiidA6SMRep9xzMIphVdDGzImtWDlZtZKodx1F9mzUzJvk
	RF8NQ5YqBPYxRgJWTl4ZweYRU7L4Jq9jKcqMK5ffWXS6JkRRpB4nVoSvcyS8EHig
	B5Hyf7s6hz5tPyAjdo4LQ1OHeoCMXzrqw74zK0MrAZ0pu4w16VC74bPVhCMGeO7I
	+WOD5+bgnGOBMb8MX4WqX3/V4JY1vHl5K1XvEvFdplW+BBqM6IGKHQK0GFQX5V02
	2sNRyFgSSqnmTJ/FzP2Hg==
X-ME-Sender: <xms:KQXPZ4ogb4jTdBRTo7SHIuwzZi5qGw62K39fxVLA8STik7rlrZUljg>
    <xme:KQXPZ-ryuuHgQelbPvusjG6e3cgqZSEfYtJEbd08PM65qFumaSQcTL4qy3en_Nah1
    LBNjWZQIqTnla8YiA>
X-ME-Received: <xmr:KQXPZ9MB8OUOMNJ958x5jJmvOYp16DoN2O2jU60st1ywZ1JxWRzi4omUGxeqI4oG3qkqCSF6rT9A7dS8aLQw4FsJFVtJJThp0ozl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudeljeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:KQXPZ_7EO3ZLvMEF_niPf3moAcvoMUwYPM1-dkeGyKY1c8qgH874xw>
    <xmx:KQXPZ37Y2iRa-KNxK6CmZAxPexlLrJW05osfENTXUOCAZ1Lch3ZqEA>
    <xmx:KQXPZ_j9vahlITh2DQR1Wpz9oNn9w-bpQY774I_y6zxowGni3BTNxA>
    <xmx:KQXPZx6ETy6mWaGACEsKSCFE4N77Kz_w5bQ4XCiu0XepyyW4Fg07uw>
    <xmx:KQXPZ604lmr-yNsrGCtUJVjIhBlwJzBmj7q8pTHx1MOTYSpskhMZfDd_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 11:28:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Karthik Nayak" <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 0/2] EDITME: cover title for
 493-add-command-to-purge-reflog-entries
In-Reply-To: <ba1fbb96-ae87-40b5-814c-4fcea106f956@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Mon, 10 Mar 2025 08:39:31 +0100")
References: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
	<ba1fbb96-ae87-40b5-814c-4fcea106f956@app.fastmail.com>
Date: Mon, 10 Mar 2025 08:28:40 -0700
Message-ID: <xmqqo6y8aorb.fsf@gitster.g>
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

> I’ve been wanting a command to drop reflogs.  I use `always` and get a
> lot of entries that I don’t care about.  But I don’t want to set it to
> `true` because I care about some of them.

I am not sure what these references to always and true are about,
but nevertheless, instead of having to release entries one by one
with "git reflog delete", a command that lets you discard all the
reflog entries for a given ref would be a great addition to the
toolset.

Thanks for commenting.
