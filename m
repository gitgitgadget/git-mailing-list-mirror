Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5362E8B64
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755704515; cv=none; b=GO+D6p2rK8OPFjLEuioSKGZI9uajabtYS/pWUumMqzxFDOm8sD+nhcAySw+9SVhf85uepUnpKUo0My1L0q3NU4jHHuxpnrCvfwMpFshErM5RRqnU44v5i1rFnH7tRFCDp8ha858mq51Loo02kHIfIDueM3kBXAKskbwXOMZM+G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755704515; c=relaxed/simple;
	bh=kIyb/Zged6EQ5aYy6T7lnIhrmmyS/lUWjLwmw5kj4uo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WhVBGb270N5oVvZblQ3mVQE2ZjJKGXCzufZQmg0ULlWARYVu6VlVuxQ+QuHdfYbBMXwm1j+wUsDxMH6Ut/nKtx1uFJIVpMC7SXanSIYl4GmQfSgluPaGKEe4dSd3Tk6YYWudJzL1EopgJM4rB6kkeOfGbs7olCatzZIgq2LUrZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=upbPKfd3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e4VXmhdG; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="upbPKfd3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e4VXmhdG"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 5F023EC05A2;
	Wed, 20 Aug 2025 11:41:52 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 20 Aug 2025 11:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755704512;
	 x=1755790912; bh=ytFBpQYvnYkJQfEKUYdkjf2jtBA7Oe8nbygnYdU2hKQ=; b=
	upbPKfd3eDlec3XbhFW4KcBJovZvfmDEQXadpnn3HK2aiyXqjnNoRUYhkKB8OxJK
	8HstTREesHsni3kiQzeIDv8NCGLct3WrC07AJS7q3QWWcRndrTFqO7q0NHNKJ2+M
	0OjfEBZxHBoE22C5oVwMnNpe4orLQTyPf42kYmlvG5cEKNngKveeCIEy3h3sHo0c
	UEvwvHzIy/NXC8Er4QEZvwENhJpt+/o3T4TN72EDJ2mQlv8Z2M4pvZx7gI6TWc/M
	8tDUEPXwyLtzroBSBC8FPZZtIc2X8ZckpkqeFI2YJ90Mcek+C7/PqxU7mP0ZsjmM
	iDj8CVqWrBwOpyi4D0bBnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755704512; x=
	1755790912; bh=ytFBpQYvnYkJQfEKUYdkjf2jtBA7Oe8nbygnYdU2hKQ=; b=e
	4VXmhdGoTCqYjCiG4DM1PmyVf8OpqT96LZXRQ2PZs5g0zake9NYGk/HlkUQpABYF
	c95qYCcL3F4sycMKgWLAhr0dP1KqC7cK0EWY4GoK1OMUAJ+kB7KScV+zEME+nzKt
	gb/r8wzemK/ROXVtS5VXKVFD65rLCSeYN3lfxHdaHkCNE26wsVDqtiuC2V34T7LU
	7wtl3T0G1XWZwMe2sLDI6ErlqZq21jnXBTG83W1UrTwPbISxAFi0wWaJDvNhVyI9
	LN07wnWz5Yx7fd1N0ztoOa8DiuppxEqcPdRrNtzTaa6jhSmblRXLLEXYVLYTI+Mg
	DjDUggMgwZljMbUMeTZCQ==
X-ME-Sender: <xms:wOylaK69MZpFZbnvDH58d31s3NInnxTJ7xUGJ-GUM2utKoun7LqEVNU>
    <xme:wOylaD4z9l_iBbeyRl4JtcJRL2yfgijr0ycphnzgIHMUAswYjR-xEVsg-YUPqHk5F
    GmaZPx8LB4Utmd-OQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheekjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehmlhgvvhgvuggrhhhlsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wOylaAAlWyTFNGwnIHMdDS9pj-NCETgir-6At4O5MU3FRTCjUJlELQ>
    <xmx:wOylaJY8buTc6rwPXhPrflrXG2h2fD1934WInyFH79n2i8f2gAPIAw>
    <xmx:wOylaAgROEbIHUu4XnkcJGjLKw8JfWvHMYiXJdi1er_yOLjffD0fRQ>
    <xmx:wOylaD56X1YVDUmjWyHY7Wmp8sUXfA86RsjAFk8Ygzo8Jppb25_brQ>
    <xmx:wOylaHPhRoZXzbBfSE7P72UOVoFNLf6GB2f8F85oRNhpgUBKO7VVBEAM>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1FA251EA0066; Wed, 20 Aug 2025 11:41:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ARGNH4DJB7Yw
Date: Wed, 20 Aug 2025 17:41:31 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Mark Levedahl" <mlevedahl@gmail.com>, git@vger.kernel.org
Cc: "Johannes Sixt" <j6t@kdbg.org>
Message-Id: <61c4ba41-9ef1-41a8-ac5f-a334dd951add@app.fastmail.com>
In-Reply-To: <20250820152451.20872-1-mlevedahl@gmail.com>
References: <20250820152451.20872-1-mlevedahl@gmail.com>
Subject: Re: [PATCH] git-gui: simplify using nice
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Re: [PATCH] git-gui: simplify using nice

s/using nice/using nice(1)/ ?

On Wed, Aug 20, 2025, at 17:24, Mark Levedahl wrote:
> git-gui invokes some long running commands using "nice git $cmd" if nice
> is found and works, otherwise just "git $cmd".  The current code is more
> complex than needed, lets simplify it.

s/, lets simplify it/; let's simplify it/

>
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>

-- 
Kristoffer Haugsbakk
