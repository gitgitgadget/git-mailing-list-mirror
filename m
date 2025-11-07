Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A2B252912
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762526209; cv=none; b=vAM6USNIIOIIV9n2Qo5AglKmak430lfNO7Huo9Oy5gQ5NncaUrgpJkHM+dFAXC8QvZ35ngbeZcW8PqW62AVwM/rhmyPYCxPZAQoMgvnNIKQqKdUSREYINQdrBJJGzEcEGFULihA6E4Og24ifo8ykgeY+WfMOFrZBB83F7coaMqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762526209; c=relaxed/simple;
	bh=TtDOCCaUM2ZIS9a8VWFnpmjMBGgRPrv0Ie0De0184y8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HdUizD3oP1GZnSUBsTs6Y1RgffkwVpRXozCSWMs/IyH1gLvduC1CnjLtvqmDVnKQQ38LR5HjHeAgShTBjCGNHxRekKFsB51zgFKGEbVthLVgNgI2jZxN+MSfWN5ON1X8ftt0na0vs9kDFE6+OLt9LJ4uqSDqnb3wLK16HQ9CjJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mJN7rQ9Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YCqsm/32; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mJN7rQ9Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YCqsm/32"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CF6A3EC0081;
	Fri,  7 Nov 2025 09:36:46 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 07 Nov 2025 09:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762526206;
	 x=1762612606; bh=Fbp4lUEU+mJDfjNsCNo+xEjeIJ8gx7Q0KBDsQ/W5Owk=; b=
	mJN7rQ9QLrzuCyYJASSXRbx79Id7PJcJ8ojas1wadiI4STCgKSFZK3XbKe+Cndiu
	jRCzjoFk1/wSYKfKcUWqHlp9hLiHojdDoc0H/+FEdE4yIEM5rmon9kXDhJs6CxM/
	5DvRLfSPcsP3OMSdOac6H3BeFd6Kk6eSh7QL3Q9MdSvs0Ag9Spz785x9Uwod22HZ
	/RjxesxZ+OFncQdIb0ZWXBrESNxR0MgIjsmGZBReftaOIeGKrGRE56E3VsjLpF9C
	q/vUnSbTNAgptUURMtkGpioLy/abV2ia39AfgIZt7eS9cfxoErPX+Zdo0AdmcPa3
	pH7diiwAKRRxWR58TIDKyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762526206; x=
	1762612606; bh=Fbp4lUEU+mJDfjNsCNo+xEjeIJ8gx7Q0KBDsQ/W5Owk=; b=Y
	Cqsm/32Z2p2mf5fFPdQYLiN6Q4Fyt7jZ74GXiy9NFyHjeS9g/cOUVMGcjUUfh1nq
	SfG9gbEI1d3xl4AhaXRr4u33ldaWV32z5/fDb96ftQzDod4F33udWP58e5eKDL0T
	2v4JlSSOj93HUzeYHswxLwQpY73pXiQAmZJ79NUVtuR+byA6a7/YJlxROnxBtfHY
	6DFSiXar9XymrOOOaCeoGoZdZ2+tKZCWVzL02xKCYpK++0uDv6yZwtsV1ZkZBMuC
	KYlnV9rp6oxiPhdPL1wqoTZNzckg5oqLRSBO9g/7/uonv95WWxcpjO9QzYSIttBI
	8CKYwQE7jPu3ZxhtSJ/lw==
X-ME-Sender: <xms:_gMOaZSI4Wg_wffoxqXPuv68JgQkMjaxaDrbT9jVNVqxa7hjuiyoPAk>
    <xme:_gMOadnyumRrnop3ANHnkjz6HQdzVvTz-memYPeKo19UaauLs_eiJPudsqsIyS-d-
    ecrAv31HvhSjXf6dmasBfcb98137bDW5ZdrT-l4Nrx30Ymlnm4o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeelledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_gMOaUu2_3RFj8L0mYnJFnBpkFQ3Q4BmARDcmfL3cooC7dUmN-dakw>
    <xmx:_gMOaZODlo4hHgHdmKj8qXBqD0QBt9T6SNqBOyJiyPHm87L6bX_VKw>
    <xmx:_gMOaS2TMSBKS7vXJTVzJRZIwLTJ4atM0gSU7Krs0yI1cZTetEel1A>
    <xmx:_gMOaVOZY_3xWzvbsM9TPo93_uTJvprgIwo5KH6vEC8T74iL--8VTQ>
    <xmx:_gMOaYPQLCeEr-SXRz0Vmz8wPReOJHh7g5y5YUa3_UgfPptrbx68QTnK>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8B8C01EA0062; Fri,  7 Nov 2025 09:36:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AI85WrXF7BnJ
Date: Fri, 07 Nov 2025 15:36:26 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Elijah Newren" <newren@gmail.com>
Message-Id: <2983385e-daeb-40c0-a8bc-fb8bd3b744a6@app.fastmail.com>
In-Reply-To: 
 <950236f0f812197e260159a688fc6f6fa61046c7.1762192908.git.gitgitgadget@gmail.com>
References: <pull.1992.git.1762192908.gitgitgadget@gmail.com>
 <950236f0f812197e260159a688fc6f6fa61046c7.1762192908.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 1/3] t6429: update comment to mention correct tool
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 3, 2025, at 19:01, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> A comment at the top of t6429 mentions why the test doesn't exercise git
> rebase or git cherry-pick.  However, it claims that it uses `test-tool
> fast-rebase`.  That was true when the comment was written, but commit
> f920b0289ba3 (replay: introduce new builtin, 2023-11-24) changed it to
> use git replay without updating this comment.
>
> We could potentially just strike this second comment, since git replay
> is a bonified built-in, but perhaps the explanation about why it focuses

s/bonified/bona fide/ ?

> on git replay is still useful.  Update the comment to make it accurate
> again.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
