Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DC2223DD5
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765212228; cv=none; b=JniL/WSwzxMb7H5pO+q2vG/r3G5M3J2STr74I3mZ6jrZxXtcdQj/tv6prE05UIL1GSiLZ65CB29NZjdIn1J1OCKFB5CIT4iPLqDe8UbF7WSpaefwIase1GLldkVOrWl3otBDpN2oLomyHnDKdHDDECj4XvpbXx+8GgVj5bgqb/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765212228; c=relaxed/simple;
	bh=aOwwEU6DN20ol1nAUFZwerj2oW1WaWp+YTYlTJd9ghU=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OxCQ4B8SLwsRN/kqNBUGftXdyAhh3K3hhU/ry5a10jPg/3ncaGB923e0/BQTTm0O1PTOET3RXgUMFEu2TpMqvc7phqh2f5VMPwWjYTyNNNcZUoVblB/tuQeye9xxhbP11w0OvFV4QGGbtgJ1Tfa9HQHFqN3KVJqkOBvuSNRL5fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=akkartik.com; spf=pass smtp.mailfrom=akkartik.com; dkim=pass (2048-bit key) header.d=akkartik.com header.i=@akkartik.com header.b=HlseOKk6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=APCY0rCw; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=akkartik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akkartik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akkartik.com header.i=@akkartik.com header.b="HlseOKk6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="APCY0rCw"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 841E61D0022E;
	Mon,  8 Dec 2025 11:43:45 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Mon, 08 Dec 2025 11:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkartik.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1765212225;
	 x=1765298625; bh=aOwwEU6DN20ol1nAUFZwerj2oW1WaWp+YTYlTJd9ghU=; b=
	HlseOKk6FiTrfbAWOFg/13lPu2w62AYyyjNDN2Ikn/lLotJYycSbHPqQdBu+pMz8
	n/9rOsYsMsFh2xZ+9a7m/CHqaWgZE0H0k+FNTJBPHMjAzKfh6lM3HDAMj76s45On
	Zcw33Aq48VUl5BXPMkvmOq5MjZ8lkaAQ/N5RJgg8L3bQ2XQHeU7eemU/jCofdu/p
	rb5rZqhCt1mlpBMOoccHBVYqnNa9G9wDScAbq/q3x80Rp7G6RcwQ3eaohVTb6EgQ
	iZ2fq4JWHAK58eCwGLvfnVw/wRkIqH6K6WHbCtXCOEr5HPAXKspSwAy01npSyFOr
	nQpLm7+/BAQxHCBoDXazqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765212225; x=1765298625; bh=a
	OwwEU6DN20ol1nAUFZwerj2oW1WaWp+YTYlTJd9ghU=; b=APCY0rCwQ6QXa6V0W
	wECIFWl5agj2N88oUQmnqN/dqrf7ii6ydHtCsZ1jU/sH64W7nMxJnr6HqcbQVWIk
	hhhv0sIDpFszy6jLh6pKtq+Gh/rM1ms0aKFnTrRdxn17LjFb7TAWbiet/MeLXSQR
	JILxc46F2sRoOiZudoMhdUyef1de97taXGsaQ5vntjyaZW1CqRwqLD2zx3w6TtLl
	Hn11TJjHyJAGtlUzhgPapMFrV+v88GZYMFNuSZIwML5fiMQ3BKP9+0nWlmK/25A1
	LEatQLNiv4BlWIaSXgRbUNWD3hTYeDkgd7cKdGReFZIVNSBYR9Jg5yhvOFp/T5Yo
	rH7OQ==
X-ME-Sender: <xms:QAA3aZp9BTU-YOAW6351QTekbNwwAg1-nInEWkqAigssnw-6ATVHZQ>
    <xme:QAA3aWeqtbNpNx9GQIyzhcE_rAqvnfyqKim7gte6HA0tzdHJcAW7bEwd4nypPcwMO
    4vw3wTA-rtIJg3novOfF0pSJTay9HTX_BE6WHpmmbZPrwmum968jPY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthejredtre
    dttdenucfhrhhomhepfdfmrghrthhikhcutehgrghrrghmfdcuoegrkhesrghkkhgrrhht
    ihhkrdgtohhmqeenucggtffrrghtthgvrhhnpefgtedutdejieegkeeljeelleehueekie
    ekgfdugfdtuddttddvteeutdetgeeffeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegrkhesrghkkhgrrhhtihhkrdgtohhmpdhnsggprhgtph
    htthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QAA3af_Elt8TY7z8pbAA4ee7SQ8lodizBmsIUJp5uS9X2SBoiS4aVw>
    <xmx:QAA3aQDm2gKD59uRCr4Gn25F_GIob0lmctlMn5LQriPR5MoCH5fHMQ>
    <xmx:QAA3acKgbMW0OxtxIriL0q6JsjrTNbSIuSHdUKS_XF5YU_1n2GyI_Q>
    <xmx:QAA3aTm2WMg5BL8D9UQNI7-dz97K6Hwc_e5neQUVqMlSOG9HhKp6gA>
    <xmx:QQA3afqYqjF0tFUPNE4jIhO8M1C9j1Fb7X2U16mIBJdu2Hu8VqHriapC>
Feedback-ID: id12946ff:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9C1952CE0072; Mon,  8 Dec 2025 11:43:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApOoA5dE3evk
Date: Mon, 08 Dec 2025 08:43:24 -0800
From: "Kartik Agaram" <ak@akkartik.com>
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Message-Id: <b13b59e2-8119-4015-bfce-26a07cddfdbe@app.fastmail.com>
In-Reply-To: <04cc0cc0-155e-422e-b723-b1115c918087@gmail.com>
References: <896e4e13-5d2f-4c5c-ac32-2927dbff91a0@app.fastmail.com>
 <04cc0cc0-155e-422e-b723-b1115c918087@gmail.com>
Subject: Re: bug: `git pull --rebase` breaks in the presence of pushurls
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> [for the successful pushurl] "git push" updated origin/master to point to the same commit as master.

Thank you, this is very helpful to help me understand what happened.
