Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD6178F4B
	for <git@vger.kernel.org>; Tue, 13 May 2025 07:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747120541; cv=none; b=GO3En+vyo6w+rVQyfHNNK42yApNC95v4VxgdhWtM7avXX1l3lK2eZXkrUoiUqZWLtbJIrSp1e85xNwRY0Z3j0sIYbaLs6UpfBbUsIoiK/XbkOY6Zz56/kSxp4fJG9ZWMzyTY+7mS/SVmNHAuvtDWx7KEwa97v57GNcnrPWVc7wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747120541; c=relaxed/simple;
	bh=t7Fs+mecQxx5HvZVlHrYF/o7jSv5oH0n1YnhfI6bI5g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HU2G4nnPiZ82Zih1IfW3yJjfAnByqtRu2UlYNcny+2mkJlRfw3nAw691KtawtFBMmx38KvXyPYdOLrWStOa/H10r4ovnNOz732zS7zTncwFSmvHbsY9X4zl6Abb4FzNCr/unNytC9IYJOsqfLCOJw4kLbiJRf5bDczacMn9J7H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PpbJK1Of; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lyrpK8la; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PpbJK1Of";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lyrpK8la"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id A1D7113801B0;
	Tue, 13 May 2025 03:15:37 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-09.internal (MEProxy); Tue, 13 May 2025 03:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747120537;
	 x=1747206937; bh=lkQeEYMzNqlcvA+x7spucmlDW/N0hp9/Kdw0m1A5xfs=; b=
	PpbJK1OfsmstbzOR4+Pae30q4ocq5y8SBMOBIXz4FxVmR26ewKrtfAegYWENKHwo
	difb6jchXq8TQyihWYimbkOgP7R17eEZdIPno1Po2X2khbnem8xbQUUoXubyc1jk
	STkiZsIJPGhvVCZ9m0W5/eAv/1fZrXIuUtkf+UFRd4ibJcWA8iK5MVjEMN07fszI
	s9LjH6ommSzrU+7y9VaM4Uwuvd1SQj8b8l99q0R0Z6suSY42wo2g/InWs//0JwdA
	ks+cntg8SrcRCFVQuNUgzR5bsp02HanSfzJp6JG7/h38nJ/igfBAKb7eC+QabdT1
	ZtxtFel363Tjk7FP6Ysw1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747120537; x=
	1747206937; bh=lkQeEYMzNqlcvA+x7spucmlDW/N0hp9/Kdw0m1A5xfs=; b=l
	yrpK8laQHAycdGfiG7OY7kBcGqpyNJ5gKTaExpk+fJhG4eQWxopzkbiPSXiPCUD+
	FgIm547+Y+sBzQTRc+FtFLh5fA64UozYomh0y/AcqZt2soPsO+TRJYIuARWVwwqi
	yBdb0oHv3vk1Dqhi6rcZALFO4xMfLpc6ouzjk5cWW/K5XVgrkXFcf7IKUPGKJ4WI
	jF0cb5xoiyKv8R6rdzZEdlWaAiSIGiwgbAlEtMv2NReNk/MvYfkDu/TJwrF4Y0Ie
	OoniVWMg5q11VbH11EQzqBp+/FinKtth3frzzxw9pNQE5Vf3QCTBP2Y0uwWFDcgf
	48LjR0tUUPc7MVDSsVHkw==
X-ME-Sender: <xms:mfEiaJsjnOBUyBDJjHv3vhzwTWA04twuk-jgt_7x9BO3j2-Wmw8YLg4>
    <xme:mfEiaCeHUm8VpK4IKw5DAA_nNOvGGEGWmtlHMmIyerS7vaio7_quLLuq1H-IOCRLo
    M8WPFMl3p272FGTZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdefhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggft
    rfgrthhtvghrnhepgedtjeeiteeghfeutdeutddtiefgvdegteektdeutddugfekleeugf
    elteffjeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mfEiaMzt5Ox79e4iurayQ354-OQbidjD1nCB0g_1qaIlbQ-HHtqN3w>
    <xmx:mfEiaAP0EfDKVVQ9v75FITyuVz8EudkUcoKuTe-743vRWE1B6nRJww>
    <xmx:mfEiaJ9b5yE1KTVjbnDqTK7JLgnl-iHjxvrk5k867UkMAWIRzaYhYg>
    <xmx:mfEiaAV5TSUfbG4jD7tQ04F9a5M5sYa2LJ6CbD6G0Vi8xVt8g5KV_Q>
    <xmx:mfEiaBZ7FYAFw7V6mAmzxfBtA8GhxeJFwtlSEqJ8ugzmBT8w-BVpSbJ9>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6C066280008A; Tue, 13 May 2025 03:15:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T529b57a5e478aaf2
Date: Tue, 13 May 2025 09:15:17 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Elijah Newren" <newren@gmail.com>
Message-Id: <fb1e64eb-3e38-4929-a7bd-09051490760d@app.fastmail.com>
In-Reply-To: 
 <1d18ab7feb877a4173ac55814177aefe88cee658.1747093322.git.gitgitgadget@gmail.com>
References: <pull.1920.git.1746914561.gitgitgadget@gmail.com>
 <pull.1920.v2.git.1747093322.gitgitgadget@gmail.com>
 <1d18ab7feb877a4173ac55814177aefe88cee658.1747093322.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 2/2] merge-tree: add a new --dry-run flag
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, May 13, 2025, at 01:42, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> +--mergeability-only::
> +	Disable all output from the program.  Useful when you are only
> +	interested in the exit status.  Allows merge-tree to exit
> +	early on the first conflict it finds, and allows it to avoid
> +	writing most objects created by merges.

The previous name is being used here.

-- 
Kristoffer Haugsbakk
