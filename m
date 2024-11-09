Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500471E4BE
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731162488; cv=none; b=e68aTf5lMajS+EhXJGb1UOEcxST5+v+oRw2b4ZU2hnmnwINuU1iua9q1CrtekpyEeVk7uiFba2yg3Fe1dnB14v4lLee08sNyddSsAicsyG9MX89AB0pEo7bcbbF/mli0JLXaPtd7VJwD9zpaQKhcuKLjKDuLYTnN9yZVmnjVJc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731162488; c=relaxed/simple;
	bh=TG5vyl2GnmzGvvNNALImZyKVVDscjwjLku3IfHgze08=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FvlEctKWuDTc52uibJ2ain6fKqOEyFpaRPekqyfYki0gEU+XA+QmOKdokqr4xe12CJIfxZNv6C52Mif2tGd7/76j38cJCtkLC1NsbiUFI48X6XJK82NPq4204pMgSZr8Ln9L+eSyaIpxKeHvGyjb8BHD5f5JAgJE5OcAXWH26r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lSosgV7Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XT/snYip; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lSosgV7Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XT/snYip"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7CDAE114011A;
	Sat,  9 Nov 2024 09:28:04 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 09 Nov 2024 09:28:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731162484;
	 x=1731248884; bh=QI+qI+YlkKnPKXloepveHEGQspe1bNCQmcEhtIPEif0=; b=
	lSosgV7Q1jWyp7raXtwCMcY5BUso0YzU5lH0Urg057GTwWGPUx9cJXx5eRyxj9kI
	FYfwtwslbpmRHlMuPjVTqYwhksMUnn9R7mEnsFD3OtD/B6fwspE0MSse/svOM5YR
	qJ2ziUrooZQI+Xfh1F2/+02V1chK/IFZa7XnjM6QNmVMQLerafLksuEgGjC/dGVc
	2H1UzYe2kIJe36qhTrHfqnB8tH/1sNwoM3e7V2AsSqEgq5ys/u9RkQRniW536M2H
	HtBA55tdLXKDyC8j8iiSPT9c7e3bLGrK1NnomA7+I1zkA4qck3q3I+xSumnU9SMy
	gu2qGP/FuwWPoQZyi7EJ/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731162484; x=1731248884; bh=Q
	I+qI+YlkKnPKXloepveHEGQspe1bNCQmcEhtIPEif0=; b=XT/snYipfqFofHSyQ
	ONd5i0dd43Tihyq8XO560c/smjj2MkuZSRyb03XRX07SMDxfj0Mi+O4Rv5VMQDqJ
	VrANpTkymj0aA2t+O+bStEdHJzQVpU1E0GRzGK5Su8nLmdBBylsvjlxTsUa1ee8I
	zz4gkVp0i6Iz6cPn5st44rUk54a2xqDjLPSUFeHTNeuA/KBecZUCbeHv9/EKaK4h
	1SuKakqWkrC/xP70hvDa7n6NCgFuRwdBtV/u3E8tIzHZmWidwOC9cyMTaTwwuWr7
	jBF91X8MQZH5GeNPE5DcDmO8Zzye/yFE8iOBgdDzexDkd8mkogcNTGVrku/IwizS
	GshpQ==
X-ME-Sender: <xms:dHEvZ3aVxi3LTjoS_19rxAclN1kttegEUMFf0AQPERVA4mgoAqfiPuI>
    <xme:dHEvZ2bDk0zU_Kr2hD1wRx2ZrKTc9R_u23bduKM9Am3bu5aPuTiLwz61mXLhNbcKt
    jA-ACjm7eqK4U9_dA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdekgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggfffhvf
    fkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgr
    uhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtfefgleeltdegudfhjeejheehtefg
    vdetuedtgefhjefhjeejkeefgeffieeggfenucffohhmrghinhepmhhinhhuthgvshdrmh
    ihnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprh
    gtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrggthhgvrdhs
    khesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:dHEvZ58u4OmUzwYpVAa6hggyotMgQsxdvvUFvydSry4nz12B1sPdag>
    <xmx:dHEvZ9ofzh-CD4oITlkTRR8cwlvYykCE7k26wTkop3sZpApYZkdlCQ>
    <xmx:dHEvZyownWCWFKUEtuqfnv_TLCxghZwoEM3eUYJKL0pHak666YwNsA>
    <xmx:dHEvZzTa0a_3Ke0dGf6aTuZNaT5eZmbDbYlHhN2oTItaB_rZU-lYRA>
    <xmx:dHEvZ3CMMztLV66ABAX9oarcUAnoDE5YIsIbwYZQE6snV_OQbSI3bu4O>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1FDE4780068; Sat,  9 Nov 2024 09:28:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 09 Nov 2024 15:27:42 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Peter Kassak" <cache.sk@gmail.com>, git@vger.kernel.org
Message-Id: <447bb623-28be-4667-b571-935ff7d163d0@app.fastmail.com>
In-Reply-To: <bc028fc5-c0e3-4d31-9790-86bdd3911cc5@app.fastmail.com>
References: 
 <CADYnh+Fudpy9kfg8npUMutMjzYNDy-XxJCCJ_9O4kLoB807_3Q@mail.gmail.com>
 <bc028fc5-c0e3-4d31-9790-86bdd3911cc5@app.fastmail.com>
Subject: Re: Extremely long subtree split duration
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 8, 2024, at 23:07, Kristoffer Haugsbakk wrote:
> On Fri, Nov 8, 2024, at 22:40, Peter Kassak wrote:
>> Main difference (except OS) is git version. On Ubuntu is latest
>> installed via apt 2.43.0, on Windows is 2.47.0.windows.2.
>
> I tried a bit on Ubuntu 22.04, Git 2.47.0.  I gave it 14 minutes and then
> it was apparently about 10000/32714 done.
>
> --
> Kristoffer Haugsbakk

I tried again and ran the whole command.  It took 3 hours and 43
minutes.  My `/bin/sh` is dash(1).

I then checked out the first parent of the commit that you pointed to:
bcf524023e (Merge branch 'zf/subtree-split-fix', 2024-02-02).  In other
words I checked out bbc8c05670 (Merge branch 'jc/ls-files-doc-update',
2024-02-02).

A *split* on that took 3m49s.

-- 
Kristoffer Haugsbakk
