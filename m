Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE5F2DE6F4
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 21:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651534; cv=none; b=thQ741mSlQN+1Wq44eoBSwp3/qYXQcTXCEQe8K7ULbfRZb1iKObLv8ZWQy8hR3e31JtGiMX3zPLlk0ZSdjQKjvdrxTJqRStPKsNFROBiqyG+7nGy3NAWfchFmOJu7stVneb07dmODn3t8Qxdfv3DZUecRyPJ4TTgYkZIt3Nd0NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651534; c=relaxed/simple;
	bh=FxOVReYZYEy5sDXFsSOv6fDFnplzpUBp12ev0N7o1pc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=K8I51IjCBP4/s++i5BRc8YGLNeztpni4oSYK8j1NVhbNUoagtZj63Gakc0DJt+thCp0JfUWZa7QBG83CBCEeOKtFljfHA8PPYrolXwWlyz+phWC8FUBmId7W2uqBT3qA7UmclD+gLGZpaTGqEYP61WJeDeb+jvM9gdurlD59cs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PWitFehy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XAq30+Gt; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PWitFehy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XAq30+Gt"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 262EE7A006C;
	Thu, 16 Oct 2025 17:52:12 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 16 Oct 2025 17:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760651532;
	 x=1760737932; bh=FxOVReYZYEy5sDXFsSOv6fDFnplzpUBp12ev0N7o1pc=; b=
	PWitFehytE5KFcm5XlKmcEwQ3tDrWIzlmyjo+OhCH0cryw26m4MmPCZ6Q/I4+wVz
	+AbwK8dUm4AJQUjM3vFzx991YFKtTSuVZkBTMRBaUEhdEeIlDxbMGGZjc3CQ+6qB
	krxq411DnJCY63BE62KvE2iAVsGMkPacdHMk/EAHYaG91rlSspr5EzSdYJR3vq7O
	B+gulTVu6I2Po1nSVNo/XJ4RJxqxfzDdOAqmIJ1UEnY0pciVxNYlwOY69QWjkc37
	HNCgbZ4UtdzTWSzrsVZ+L4eVoB7v56w3+8+MmDDUwM+J3Z6XSxMehYRx/m98nTpG
	UGEVpxdk+aiqOHbd8qIu7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760651532; x=
	1760737932; bh=FxOVReYZYEy5sDXFsSOv6fDFnplzpUBp12ev0N7o1pc=; b=X
	Aq30+GtT98h9QavZ5ITYXT3wTmkJJxWBeNkbagIXaIEB59W5SJZZAB4kMOPEi2eQ
	jAl1zphX0VvdE0CrrJo/7avRnjKDiVaWxB6O/MK7BqqGviEAZM77Iim8ws9kj0zb
	MtL62qm6DQx8exBXVvhGNJZuRDvbpHw0Op4uKE2VQw7Ru5oFD26upWxhrDYVUJTH
	IG+hShwruOmbghj9bKSiQKyWfEfocH3uA2IMqqg7WCEKqF44pMNUT2YZWNEYc6Se
	mgaW3F9N45FnL1BTiIstEGB4TcajsUcZv5nwaHLF7J27CCarDDPgtqtDmP+uuilv
	be/Doo/uMw3vbppuzDMAQ==
X-ME-Sender: <xms:C2nxaFQs-lYSaXOJGgAz2qqCeOURDdWiSW003qP9NSFmGFEGvdCcxzc>
    <xme:C2nxaJkrV11SZGqaWPogqgq0LoM4XDEzpRK7P7gMQgJNBBnJjm3YCaRtlNIGd6sYy
    3svzzb8Rv3QWOyQKTngQy-OS1xOq4wsB0uyn3NpJxBOB1NhrWgDrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:C2nxaAss9l_Lnlx6cynDbfqsYUHAQspHBajBbt8ZFEST0UWtWIgJpg>
    <xmx:C2nxaFMmURTfw-VaRfFz-BvttCUpqyH-_Tu4XoFxMUVDS7XIji3iUA>
    <xmx:C2nxaO1e4UcfZwDKnFxGxEs9g7l4A6rm26Joovzi21Zchtgqv248Xg>
    <xmx:C2nxaBPaSyncNsQy1D7LNxOTJMfufav4a5I1WNAbQ8uHbpUq-YhCuw>
    <xmx:C2nxaENc7rGhFG27XkLY1sdOa6Fa9dTAvCH5jknB--G-2V2Rlk07DbZQ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B12531EA0062; Thu, 16 Oct 2025 17:52:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ae_r0FbH7y2B
Date: Thu, 16 Oct 2025 23:51:51 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Ezekiel Newren" <ezekielnewren@gmail.com>
Message-Id: <5af53ed1-2f84-46e4-9da3-b44871c3cbce@app.fastmail.com>
In-Reply-To: 
 <7b9e8961d42e0f367ba0782e7d932607aa7e0b0a.1760563101.git.gitgitgadget@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <7b9e8961d42e0f367ba0782e7d932607aa7e0b0a.1760563101.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 2/9] xdiff: make xrecord_t.ptr a uint8_t instead of char
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 15, 2025, at 23:18, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> Rust uses u8 to refer to bytes in memory. Since xrecord_t.ptr is also
> referring to bytes in memory, rather than unicode code points, use

s/unicode/Unicode/

> uint8_t instead of char.
>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>[snip]
