Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2B3170A37
	for <git@vger.kernel.org>; Mon,  5 May 2025 09:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746438622; cv=none; b=OhwyQTZxWLE96L95z58HvXwtsxrcrIqzHIA6xRVyUM+JOVCISmoKc3ErIIPeqiLArpOVsSvmSCKl/aflzBXHP2GBVK4lF8TjyqS6QCFIf34I/UjsD/ElidyzeBn/glfHnEfuGArXsntgQTTmaFzN6SdOBzljp6xliZacmO5GVf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746438622; c=relaxed/simple;
	bh=EewSnIQ+ZoJpLc3jxLN0+T5LhxCNigDns5AXxhQ32Is=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=M6DJxJFYy+q3/czG/5M0bfZccPWiadhtoD0rWX4RY8glwMQXnW+gq2/GMM7eAWBrzngfZlH3d8gtx1/Lx0/GanZCJcXqaxIK42FhxeOqkLMxAtAkuN3Ua1oN3HDJ1Sh19fhnITvw/Jm2TNvvEz1dd9+tDJ9NtRR/GzOvluFqQY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=nyfigaAb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B5cyDEf4; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="nyfigaAb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B5cyDEf4"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5B3702540262;
	Mon,  5 May 2025 05:50:18 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-09.internal (MEProxy); Mon, 05 May 2025 05:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746438618;
	 x=1746525018; bh=UVygnwpvHHp59yESh3Mi1w02RbtlOrSP8KUCG/VC5Xo=; b=
	nyfigaAbxnL/fA57wRWQkMiQD3SUcLqzlWb/fJFcNJYGlZaH4xUZaTeEIFbzy6HZ
	ocdxuYuadbmAI7n53vYNjK95QDjL/jo6mPXT3PscfBrOmOfBTJuu3jgmcCqiT8CT
	HkYEQWcMFlpbqqPDlS12P+ees2kyIrKr4u6f21aFD9B/s2/xQEb4ClNTO8Vsv2Z6
	D228dAzlJsrnkFBk6Jj6AcCq0xvppazEmkw71l2h1LtKOLSD2fm6NUpf0M1EczrX
	Hwzwi3WH02iBIjT4FYaIEWYUO5hkYuYiOcmuov2rLxycw77mPDoXLbn8rbujqcpS
	a13zvvnxs8QOHqYvYq79cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746438618; x=
	1746525018; bh=UVygnwpvHHp59yESh3Mi1w02RbtlOrSP8KUCG/VC5Xo=; b=B
	5cyDEf4Ys8Koc0mqPxm0WL1MeHXE4fmKRKJNKrYvLbNzCkfN3yV+G81IRHMN70vQ
	gdaNEH58X4p+p1OmmPQHb6BkmFDfOS81Ynl7IjUeXlkmtvjzAIbVpK7wKZdW7t75
	eF9D9GsKUzS7Nr5aax79+auPEHFv8qWVbAkWnjoEPMeCPW6oZAo6MCYF3zyB2RTg
	J4IOBp4TMcbyEn+hc0RjjsfmmGSi9Vg2GUkPaVJROavmBAXjsAKip/nUfgl+wfnx
	ZIF6k1hsmbV+mqVdQHPMGXoPmAuOsTavnk90p8oFwHxQRxoVff91qcKtAId8pugr
	z5RJ+oU3sVGjAfGF9ZnXQ==
X-ME-Sender: <xms:2okYaKea86KBJobNImb6qfzb5m5dQF2L4A5PZSdxMBJdFALSSoY__HE>
    <xme:2okYaEP_lOpfzeQoGTulhYPQ06hcVcfn3phPdACdWbRyzaOlk0s4lT2UfGq0Ifytp
    HTZ7MUhauuAwwREvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggft
    rfgrthhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgie
    fgfeekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehlvghonhhmihgthh
    grlhgrkheisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:2okYaLg56yHqpqIIh0HK02hCXiGGZ-aw8fLXLPbq_Px_YAdH-3aBIg>
    <xmx:2okYaH9PhtEXKHd4oQMoGOD3gZ-TY1JBJzXMIqm1yAMvhfTJKbqdPA>
    <xmx:2okYaGu384i-AUDgE5jMlDXFYht7PO7-tz3rJJAdSoo4tBsrzG0ZoQ>
    <xmx:2okYaOHWGaj4iFPl0EfF1lfqROUkVXB-KenmXUrmSPCv9fgQMQujQA>
    <xmx:2okYaOKCMLeENzyHoaxYXLeD52s2s73AcAZ2J31J7mFSP-iNDW0E5zEF>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 03532780069; Mon,  5 May 2025 05:50:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T8d2a763bd325cfb0
Date: Mon, 05 May 2025 11:49:57 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Leon Michalak" <leonmichalak6@gmail.com>
Message-Id: <d2dedbd7-6797-4f1d-a0b2-243f9bef57f2@app.fastmail.com>
In-Reply-To: 
 <7700eb173e73bb240852dc1c7ce26f3d1f95d8ca.1746436719.git.gitgitgadget@gmail.com>
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
 <7700eb173e73bb240852dc1c7ce26f3d1f95d8ca.1746436719.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 2/3] add-patch: add diff.context command line overrides
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025, at 11:18, Leon Michalak via GitGitGadget wrote:
> From: Leon Michalak <leonmichalak6@gmail.com>
>
> This patch compliments `8b91eef812`, where builtins that accept
> `--patch` options now respect `diff.context` and `diff.interHunkContex=
t`
> file configurations.

8b91eef812 is patch 1.  This hash will change once the patches have been
imported via git-am(1).  So it won=E2=80=99t make sense when these patch=
es land
as commits.

I think the usual approach is to refer to a previous commit in the
series as =E2=80=9Cin a previous commit we...=E2=80=9D.  Or maybe =E2=80=
=9Cin the previous
commit=E2=80=9D for this patch and =E2=80=9Ctwo commits ago=E2=80=9D for=
 patch 3.

For commits that are in the stable history (like `master`) the
convention is to use:

    git show -s --pretty=3Dreference <commit>

Without backticks (`).  See SubmittingPatches, commit-reference.
