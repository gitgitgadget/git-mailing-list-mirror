Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B1E217736
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928481; cv=none; b=Lf8ZvvU7+L5oLJf9R0aq24JevquWEZa91Tt6sVYaQ/7PW+aTcr00SFwk7FKEsmFf2txh8f1fIadTN28Ast1SA4ko87m7xA+/wzgi4FLaLZtSuoJSwKb398oAZNXtj3WdXlTE6RQfE8zDqieisrgZ704pJECq1jilEUV295+Y4bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928481; c=relaxed/simple;
	bh=oA2ZRBzfKcv1ZC0/9mlvIP90XIZiznXijxxp1G9oO/E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fj+wGTz1XaU5wKgoP8EZqQXWbvGD0dyv+s76llD+qdO+I8yx6Bp3y2Z1UGvSKVJ9speD0v1EAYS6/E7cCIbkxcclNuhJee0fgdJBz5J5WoX76IDsUP2iCrWJppFtrOKSRdBZgzXJs6K3D3tqXkXLZyavQ4wxaTHcalB00nLQ18o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k6/ybtch; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kKDPmZaO; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k6/ybtch";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kKDPmZaO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C3A6F1D00081;
	Mon, 11 Aug 2025 12:07:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 11 Aug 2025 12:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754928478; x=1755014878; bh=XCPsACJh1A
	4uQ+X1dHKrniov3pgYGu4ja/TO0QUFqCk=; b=k6/ybtchZZVT0PvEIFhsdpRAyz
	m+09erSqU4VHV+0oAL7T5bzkenxTMMd+2PElEL1p61BFh/45j2NjYL/RF8iCHqou
	Sx3OmJap5EHoQUvSth0bGULtTINSlydTFT8ph6YOSnUcS/bLQKQ4a4WnuUNwoCB8
	qDdqrQ3owuGgx3UsHFrZRzEla/PoxqJuIV2Xb/BiwW9f/JchWggeXBobpFH1CdPH
	H/4W9kJj00DF3jRaMIQIK3C1ts2oOxq7R941rCaIbqe+djnfNvBxRv25oCG/csJq
	r2Hd5eDzwZT03NYidBwsnaeefAzjtCiGECdwu72/D+sfQuqmwx/RGtupuRHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754928478; x=1755014878; bh=XCPsACJh1A4uQ+X1dHKrniov3pgYGu4ja/T
	O0QUFqCk=; b=kKDPmZaO4D7EsIej0CShyDjl00IFWVupnVyLopLgVibj1aP3XDz
	6Ui1kxs8tyzWKw63wFxtCQjlasVoX2cTh3+wcKqf4aChPi8ffJEUbVbxZxxRdTVS
	80LYVoqnLphjCOPXns0vy+nfg9NQZTHzYxYSKjv2Ayikb2/69UwN43ZTa3IygQm0
	pv1eqEWAa2y7yQ2tc5DRxSkGs2P5CpqSzjjjQ704MN/NAiTrDBlO8KyVUJ8TrYcu
	OnGlF56QZB0Rvza+0NFGioOAhBhsfMcgd2VQ2rxjJ2X/XIIjQ7U1RbU6dr94p2Kc
	tg+limEGNYRbFFIFGu5nGvNtg1lNDdoXqCw==
X-ME-Sender: <xms:XhWaaKt8j1lU7s5OAzYmorP-BjSjvTYEU7vI8CuGw5jZL3-euU7GpA>
    <xme:XhWaaK9J0OZvldYoV2GRFiqNmSRqGcYt9qLvluaV4yDlzzPM8tfMiOFekU2fe84S_
    y-XSIRSN3XCSarybg>
X-ME-Received: <xmr:XhWaaMPD152djbV2qhD7N_jprc-qVrbMj12R0_4W4fqhWFl3xAeTABEAh6SJ-77bVeWiP0Zm3iGV8zQMeG3wFzjiINrqx4BvcM-612I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtohguvges
    khhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtghhithhgrggughgvth
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepvgdqkhdqnhhutheshhhothhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XhWaaAFJmdX8LkVpIteZ5QilmTf9zG7e5UaH1ggLOC0bueTqSaXPOg>
    <xmx:XhWaaCRVw9gjUnQcwaa8W1ZgyNE3NSuXM_wBRlXeDIXlw4f8YScFdA>
    <xmx:XhWaaFvgEtVDLJViXwRFnqCzRVpnhj1CW2XH4vq-QP5Y7a4yeSYnFQ>
    <xmx:XhWaaCKK8GOt6U9TIVXYmHw8P7mFyMQTKRPXEQrSOfRhcRjxIS--yQ>
    <xmx:XhWaaGQwokhBRHWh_jjUwYkGjJE5FW5nVgi8n9WJsYnURMj7r-Zu9Q-D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 12:07:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Josh Soref" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Knut
 Harald Ryager" <e-k-nut@hotmail.com>
Subject: Re: [PATCH v2] Remove the extra and incorrect closing bracket, so
 that the line reads:
In-Reply-To: <a065e0cb-75e6-4836-9897-05089089367c@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Mon, 11 Aug 2025 08:14:06 +0200")
References: <pull.2023.git.git.1753973177262.gitgitgadget@gmail.com>
	<pull.2023.v2.git.git.1754861423787.gitgitgadget@gmail.com>
	<a065e0cb-75e6-4836-9897-05089089367c@app.fastmail.com>
Date: Mon, 11 Aug 2025 09:07:57 -0700
Message-ID: <xmqqms853kpu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> I think you want this:
>
>     docs: remove stray bracket from git-clone synopsis
>
>     Remove the extra and incorrect closing bracket, so that the line
>     reads:
>
>         [--filter=<filter> [--also-filter-submodules]]
>
>     instead of
>
>         [--filter=<filter>] [--also-filter-submodules]]

As even the author of this patch was once confused, I think 
the reason why this plausible change

          [--filter=<filter>] [--also-filter-submodules]

is not a correct fix should also be in the proposed log message to
help readers.

