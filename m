Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57E928EC
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728232297; cv=none; b=q6vJXvCME7ObGY2EE8pvEpaqCzjqxNIh3rdnqGesuyll99MaN1ah9AQ9YXhFfqQUY8AgdeZ4lLxKqnBm1oESFGc6zH72AxSPt731c5Lirh4DPCaveXS83H5MGXJIFE4soQJvbO+GT49Rp8btn0eae0BZ/98rRdkY86dmAINiUhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728232297; c=relaxed/simple;
	bh=dtCmUfhvyKwrosNRlGpTCiaRmovXzLiwXJ63W5PH0Bo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=P9MG98qkoaS2pOrijgq20YTjyvAyPqGHvWJEdKEArkcoYji/RdAdYm5qC2OsGRBXtN8jiwErLPZBLiS4BIJot+1EsFvscMvTVfoDQlXC0Oe4OueDbVFgYOHAIjd5xr/bxj2T+oEehj5y0VBXa4I4Lq+inYSEU4fuqNymxwJ6mxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=sMKX8dtx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dB/Muumd; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="sMKX8dtx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dB/Muumd"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id DB198138018A;
	Sun,  6 Oct 2024 12:31:34 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 06 Oct 2024 12:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728232294;
	 x=1728318694; bh=Kob7YYOlTpZR4Qh7n8hLb9CCPChe0OgZHIToKuDUf0E=; b=
	sMKX8dtxM+1HbremF1wxJYGEMoNGDGur7dOsNGgS/M+psYhLgCfgsbn781onQaDg
	cTidxVCUwEAvC+Rcww5ecdvQnQ3rmvu2W5z38R/PywgAWsIPcqfGk05zbKAMSmvm
	W/4xsUahQUnvsptrQjSFckYiSb/MjxdbosiFoB7enheO1GoKNW+Sss8nVlF9c7ik
	8jKUPni41LtcwN4ixN0B+SER3HqYxIhlyiNmy37c7X6p9qjrKXoGpOiuPsB0T6AO
	qB0ro4f/uftTclZxTRr6Wpo8zvvirVH9TMkHRv4cIbeADw/wslpf4kk29UM75ou+
	RpyTCozNDLqiY6UhryxwDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728232294; x=
	1728318694; bh=Kob7YYOlTpZR4Qh7n8hLb9CCPChe0OgZHIToKuDUf0E=; b=d
	B/MuumdYL40Mf+3fGhMsKco/8clk6MpVZrKH+PwCSgHabvV450PO7F4G4X3HBquB
	3VxCVi+hw4O80uZiR+uYw5DKazgWhdA0EGreuweiBIyAsT0ms7kecoFWAwfyQ0HJ
	/OE1sqopayT1K0CKHsIUzYKC53iD0f1Kr0Bf9VLa6zHrz/dMdFzCRBh065cX4Fg6
	D62ee+AzA6pgoQYgeM09bcI+aOr4+/kqrTa346eotTt6MvEDb1QUCa8Yh1cqnHte
	tzASocnEMXCKvQidH0uNk6TlRHbWIUUEBQVrnS7HTJFSbKngWT4MJNtvoS8m7yRq
	7krSj2qDVbMM+Oy0pJRIw==
X-ME-Sender: <xms:ZrsCZxNFue7NKnPLF6n49rXcr3eQwFZkIGvgERMOb01yQzs8YBv4sdo>
    <xme:ZrsCZz-Xa4iilyMsLtfl-qu_j53mOKpe7c5ZQQuiHsvX69Ez18CZ2QfhL7V3qxfjz
    fuKF8SAi0Mq-NWEFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvjedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpeegtdejieetgefhuedtuedttdeigfdvgeetkedtuedtudfgkeeluefgle
    etffejffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoheptghhrhhish
    htihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihht
    ghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesgh
    hmrghilhdrtghomhdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhm
    rghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhunh
    hshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZrsCZwRYJsfPsdOUeQjzO6KxGGKEPpLzGrx8Rqvf5OyhkKQjTgRIlQ>
    <xmx:ZrsCZ9t9-h7fRYF09tbQsyhodSrNfGDDd8kLnEydQypRcqvfylKAAA>
    <xmx:ZrsCZ5cc4mm6BVvAFtUXZ07_EkXB6kneT0vx3p8nNt3OGgXA2af2yQ>
    <xmx:ZrsCZ51yEAlsctKpOjKhocYzl6ZZWwH2MWwW78TUt2JlSDcvYN73TQ>
    <xmx:ZrsCZztvdZXR6_j7gSwqkExgdTa7_qLY2AM69pIA8yRRWBGO0ryUsnxp>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 94231780068; Sun,  6 Oct 2024 12:31:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 06 Oct 2024 18:31:13 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Christian Couder" <christian.couder@gmail.com>,
 "Patrick Steinhardt" <ps@pks.im>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Eric Sunshine" <sunshine@sunshineco.com>, shejialuo <shejialuo@gmail.com>,
 "Usman Akinyemi" <usmanakinyemi202@gmail.com>
Message-Id: <5a0f09e0-d181-44e8-ab04-5b544bddd21a@app.fastmail.com>
In-Reply-To: 
 <37b1411ee2c420f1a8578d27a2f7d54ccd3f329f.1728230769.git.gitgitgadget@gmail.com>
References: <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com>
 <37b1411ee2c420f1a8578d27a2f7d54ccd3f329f.1728230769.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v3 2/2] [Outreachy][Patch v1] t3404: employing test_line_count() to
 replace test
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Oct 6, 2024, at 18:06, Usman Akinyemi via GitGitGadget wrote:
> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
>
> Refactor t3404 to replace instances of `test` with `test_line_count()`
> for checking line counts. This improves readability and aligns with Git's
> current test practices.
>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>

Nice commit message.

-- 
Kristoffer Haugsbakk

