Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAB42F24
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728609154; cv=none; b=K0eKx2BW1OzxeI4Vu+4g4cxym9zVmBmyCnjilWawzdXg+NupcuAMhNvXChXjwKhA9QxbiBGbNaLHZMfVgfSwRkXCs9dSlnGeb4hZiz/3q//NLKT6KL2E4lykLL87vm8AKugEM1e93bBiWFol1cJmYqSAs9tJgh8NAXoYo2P4eYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728609154; c=relaxed/simple;
	bh=Efy/ySSWQvaFdF3qroWdE5UVdX4Eo27235d/watq1C4=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=FZM0mtWS9iEvBqsnFH7iJqXckgpUX/7UzpCNCMi2oCcA8HtgeMRZRgG62JgHr0RtXvgyCEY/AsTSOo1daMkAOOJI1AX2BXftzlj0DhoM0l/EzIbtE38M42QEGS6Pmjv0ssjrxQIKs5W/Lfyhx+5JtmwGTYNVRXV5CCUpUAQU0bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kRsw7VJD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jwYP5qnR; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kRsw7VJD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jwYP5qnR"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id B0643114007A
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 21:12:30 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Thu, 10 Oct 2024 21:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1728609150; x=1728695550; bh=4Ax0sdg2D9
	OrxPdZi2HNuTblJchMiS9dU5cyLyl8zWI=; b=kRsw7VJDWJhhZRqal/73Z7m0j8
	0UYJ2TRh/PnHDj9dvMONebdfOAzlmSXZZtnfP/K9dagyskrRcdyD7qmMPF66IBpb
	2Jx4Tu2thAsMz+Jl6vMZ++Mlanh4XzQc1XGEWmnadNVByPUS935nTdWIu5KCa+An
	pjOgSRk8zFAo0PxU5ERYM6fDNurkmd0kbpE1HeNtNXbsFXr0Cx/zkCntMlV5G70h
	qsYYKfpB0EISzT6eAeCkrSZ06acB+viCIUx5pzgQnsTVUW34/n4E6YKb+ZuMFOdN
	TgwGqovPbtYTLDUX6rifArmjQbFO4sjBd4DNi3xqDl4LwYPCb8hGkka2DQcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728609150; x=1728695550; bh=4Ax0sdg2D9OrxPdZi2HNuTblJchM
	iS9dU5cyLyl8zWI=; b=jwYP5qnRaNZsqneIFbSS8ufNj+TmuVID4TG/vKDG1zJI
	J11yoVR6NdUmCxSjqe1JIaY/aWNaWMmR7tGx0HNgPSr9QBR9eQcAOwh20kNh7Yg4
	lUpK8aH9n5nDJgV2llyBS5TN6Z7TsnGh/S33twX0+GHRCSeJk+KbhejsxYXugiGD
	hij3qAhygbVHoyIXJkJGU41qjBsfPx/BBfUoKSkXwcdkmgRnbftrmsgvVsie6nV4
	acBGShCYzSMy/UgRH+BQp389YeEUSfC8JVvzcJq+B4Ayeda/Ytw9e1hRjN2p1TfU
	bkEPCHqsMKi94ayWqTvK9tCfclvEXFvaqwOP3328DQ==
X-ME-Sender: <xms:fnsIZ4v5EyAfP4zZE1KrQSuxb3b62DTyp4PVsF4rSHrUjk0dEfpMhw>
    <xme:fnsIZ1c-znjEN-ekLFThvdeigrPC_bc-D7KjuEt1zkNAyuIMmjMgTNPfwEQ6PtIRa
    pzcoQGaSwSZLNOHHLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvkffutgfgsehtjeertdertddtnecuhfhrohhmpedftfgvsggvtggtrgcuvfhurhhnvghr
    fdcuoehrsghtsehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepledtve
    ffueeiieeuvedufeeghfduudeiffduteekgfegkeehgeejudeljeevjeeunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgsthesfhgrshhtmh
    grihhlrdgtohhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fnsIZzwNZ515IwmP8MCEXKAuvXTp0RUr3vUN0k0ZJNOMMAvK48BkAg>
    <xmx:fnsIZ7P29xpvh6rkJ_KMA0BTdUQZyp19nYA7ShnjwLPqfRqVSZ9_Qg>
    <xmx:fnsIZ4-ggCZwkkjA5NPvlCOpTjD2QIkQrPqVroqvvYiPTOKZ1B8uCw>
    <xmx:fnsIZzVzv3tizKJaz30RzFKM9rJW_ZZPzRaI0m5M_ylkyAjklcRJLw>
    <xmx:fnsIZ9EVeqHLyc6sw9-fEz_ID4zhLp8eTB1hLVjq7C_8pNDRDshnLyw->
Feedback-ID: i445c46d3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5B30A2220071; Thu, 10 Oct 2024 21:12:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Oct 2024 18:12:09 -0700
From: "Rebecca Turner" <rbt@fastmail.com>
To: git@vger.kernel.org
Message-Id: <8f961645-2b70-4d45-a9f9-72e71c07bc11@app.fastmail.com>
Subject: `git worktree list` when bare repository is named `.git`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

It seems that `.git` is always stripped from the `git worktree list` output (including in `--porcelain` mode). This becomes relevant with bare repositories. Here is a bare repository functioning as expected:

$ mkdir bare1
$ cd bare1
$ git init --bare
Initialized empty Git repository in /private/tmp/bare1/
$ git worktree list
/private/tmp/bare1  (bare)

But if we create a bare repository in a directory named `.git`, `git worktree list` displays the parent directory as the worktree, even though `git status` doesn't recognize it as a worktree:

$ mkdir -p bare2/.git
$ cd bare2/.git
$ git init --bare
Initialized empty Git repository in /private/tmp/bare2/.git/
$ git worktree list
/private/tmp/bare2  (bare)
$ cd /tmp/bare2
$ git status
fatal: this operation must be run in a work tree

However, Git _will_ recognize the parent directory (/tmp/bare2) as a Git repository for the purposes of commands like `git rev-parse --git-dir`. I suspect this can be fixed in `get_main_worktree` by only stripping a `.git` suffix from the path if the main worktree is not bare.
