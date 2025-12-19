Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4782D25EFAE
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 07:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766129643; cv=none; b=E+EoocuvY05cc4NoPnWfyH0pIWFNKGiSd7aML2XUFbsg+YanHiPz+S0Hva0Vmp3OVwOADCeCjlyzc64+yhf6toIOe2XKtBFnNqhM5HSf5UMUqCrIWx1fPeWAI6yc09DlXzDWn+tWiSCPn8YY0t6tJ3aMGfQzihF6PB3Z+0bKK3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766129643; c=relaxed/simple;
	bh=2n9snKoo7nZw/WGbh/Sf0kCFmmkhQ1C1msggHKWOz5o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FTgWbdL3vW4kE7tP/ePp561JmPDiSBVMciAd504uRNcJFSN1pzZUhAeMBZrHqxtA9Yyna3BikPHnLiy0Ml3+wSJ8tEJmIhNhdBJtmU9G7oi7VkBEnGv4zhMg674ldt1RxmoS+IkyeSmH3404A7CNxJ5T8yHjkGGW0J77OIK2U98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RUMPPUnq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=apspQqJm; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RUMPPUnq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="apspQqJm"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 825251D0013D;
	Fri, 19 Dec 2025 02:34:00 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 19 Dec 2025 02:34:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766129640;
	 x=1766216040; bh=2n9snKoo7nZw/WGbh/Sf0kCFmmkhQ1C1msggHKWOz5o=; b=
	RUMPPUnqiHe5FlfOcJzZEeR7XBko2vhJHwfpFmfdDoUzRXDIEZEuler5Z7Kp7NpH
	M5xEtKJ95/7g+ksa5ntEu3NkPPANt0BLgGI8+uR61+rd2mXPFBGxgd0nU1nLkYjB
	1f/RMb+x5YoDzUkdq2Bshy1KhbnI6VpMRljbZhPnu9OHI6ctx7Edmz6ocWhj3h9O
	J/TZ9TLAZ/O/h3902xs+ckmrzxUI4CInm/unnL2jOub+tbBvaZg4FXotP5yNhvo2
	ifGDJGEofWBY8y5pagI2tUs7wsFigLgpAjjesqiORzwJKgUvDbioTKznXzkG4EdK
	HvYUdfLbWqvBveQuXJrCPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766129640; x=
	1766216040; bh=2n9snKoo7nZw/WGbh/Sf0kCFmmkhQ1C1msggHKWOz5o=; b=a
	pspQqJm2dhJZ47wKW9VP2MIk/C1rymCW7dsYhBTIx2JZatW7Aam1nF0waiyy+0Sp
	RMGLHQshoFBrvzhD+S88l6FR8bEnhdQhULatUi8fEmv3eaFIieKXJPQWh58Af2UV
	dq2gdEA3m9j0k3VmkaDZKyR0Hwpy/zZHmT3nhlCfWfoBRg8H8nT05LQkYeLeHZk8
	/GRqG/ddxJ16zVvuW9jdKUV4+H+yvheR8F/PUS1fS+M5vq5ChirtQb69WmHbVSnz
	8PkLysExiJOiPMDk2NnT6mzvku4R3qbIz0+glcUv7cW2qBVb8Tvy9jIosVgTVZLf
	egWs26nwjGexAgpYAtqgw==
X-ME-Sender: <xms:6P9EaWhca_HW2ynrUravwox0Dfd9QC9taCE9wqUkdbPGBPaUsAIB-cc>
    <xme:6P9EaR2cKnsdYwM4iOzryMHOQus-tsP6EgyceHMYfTkwA3m2o1Cg07ck-EVH9plPY
    9pJ2A8c78BLrWY-r_GtL3ASt6qYSwgRXCSYOte9GFdUg4-04MAW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegjeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohht
    hhhprghsthgvrdhnvghtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:6P9EafnmTUvpQJPbybeJcYq5YzQBX2DZavIOu6KMNalHyMUbuaXjfw>
    <xmx:6P9EaUU43G7zbvogS22em3d1jyEZuvdYY7aG6gSJQXB9mWyVVBHRZg>
    <xmx:6P9EaVuwA_naZgxWgdZciilZFU5qnt2O4o4BUeHAqrzUVO4qO6FzoA>
    <xmx:6P9EaXYy5NjHMq6JBKjsWSbzoq1FH_-M7FsenYnEnHxYxzAhMnq9IQ>
    <xmx:6P9EaQ5EaX4NXs9vBpyqxNf2zH9Wqhm9lAXzJDloxB3wUjqGHEvsqVoN>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0B4AB1EA0066; Fri, 19 Dec 2025 02:34:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAEmYuDNxnYo
Date: Fri, 19 Dec 2025 08:33:40 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Cc: "Johannes Sixt" <j6t@kdbg.org>, "Elijah Newren" <newren@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Message-Id: <4f0f4d58-3f47-4479-bd7e-80f5d9d651d6@app.fastmail.com>
In-Reply-To: <xmqqv7i62r6w.fsf@gitster.g>
References: <xmqqldj48pyl.fsf@gitster.g> <xmqqv7i62r6w.fsf@gitster.g>
Subject: Re: [PATCH v2] commit: document that $command.signoff will not be added
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Dec 16, 2025, at 19:54, Junio C Hamano wrote:
>[snip]
> ++
> +Git does not (and will not) have a configuration variable to enable
> +the `--signoff` command line option by default; see the
> +`commit.signoff` entry in the gitfaq for more details.

This is in `next` now but:

s/the gitfaq/in linkgit:gitfaq[7]/
