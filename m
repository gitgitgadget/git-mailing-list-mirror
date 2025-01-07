Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418F71F3D52
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264095; cv=none; b=L6Y2R4UWo5BIeuV0l3KB5/KQEcDT1qQmGA4HqgTWnSj7bWJNBP+PiWepm7vN80M52hh38DNmHWnhCNIkIXgTy7JqyExAvp1ATpkfGtEUID55LtVQfYnYflNUSRvILYNqNSNmyp5PxS3Z68fXUgWAzuJXvA56T4a0s6Q0pdWuavo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264095; c=relaxed/simple;
	bh=hecAYzQOfeYlgx7Jb0tQQ+2bTukOu65nHOtlVVIZZLs=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=alLTUA05ANjX83c2h4BcXjuirQ+TRmHDSwO+FNGHJychoD3cb8jGGX9c2oV5866J3bs9/9NnYRR9tKPk+gOVQYz9ZyTA8Ir5qbGbcmnjtloNc76wPLGSiU7NUCF4jJp5Ffztrw/rURDpicIBMjmtEoaZl/peZhns6khnWqNy8AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PVMaOI3k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wL93yMH/; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PVMaOI3k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wL93yMH/"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 540C1114016F;
	Tue,  7 Jan 2025 10:34:52 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 07 Jan 2025 10:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736264092;
	 x=1736350492; bh=pcAhIo7MzdGrPj6rDvPXqpdtavUsC6zqtcOVhUHWx80=; b=
	PVMaOI3kRVQRLVPqZ+rQkWkxDG5MavdtEj1f1CJgqPCVkZrvyxTZvYRt7k4wQkC0
	eQpAKGJiFn7dQby6PW4kveliQCTQrUkdFD+julv+5W2xC5Ea+ab6GOHzwxO9bID+
	1DXXInArDXEbVOooEE48Z9XUN++Sy8MLgItgkgBcqKAy7wgU2usTw48E2N7IfHqh
	CBdvStcfX92I7lRAcrTvGSpl9iTx8RBG3KuMktktdYpMi1fT7bz6WHgqma93uXDE
	nSQ7VBtq99EK992gYfwrNdD6afeVMuu6CArbX5oKD4RZo+dcO+8xvz72S8FVbz8K
	FDtIWhOkflLSlWJXiy9dEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736264092; x=1736350492; bh=p
	cAhIo7MzdGrPj6rDvPXqpdtavUsC6zqtcOVhUHWx80=; b=wL93yMH/stANY4+m9
	vEd8RBgUgsQegCRIYhwlqIFjOy1AFhFDT9H1uckRLoFZeONRFqWhfuKwgHyzCzt+
	2m5uywNdBhZIIuKMao45H3BMKI80YKv6TitjI80QahsXzS4t9AUcPlM7UYFDGnAj
	R9LFv0ElfZgJzZ9+LNgFP76rKXXh3eSKogjhwUIXIB3p/ZEk/VLJhWnz7VvfuXfL
	odVZRJke8vmcCjL7d7qOZcf9Tf0IQ2wH/QUF8NUCZSajpiwYHM4KBeO/EKicCEMa
	k5geeYKf5RJDE1NRx6VYeaPQzG3ePfndMeTkaSvME5zPxfH4eIpbACGA12XwjbMf
	v1jVA==
X-ME-Sender: <xms:m0l9Z-mu_agh6vFtj4tq9rM-z8MEXrhPCLi5gLUPz9QXP4bTUGSJvGE>
    <xme:m0l9Z13r6nPqUbd7kIHLJnMvwigP2EaLHuEMZPcLh5SXEfrQPsFbgIJslt8cJS1-x
    kxJptQw0n0jiaXWdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpeffieeftefgheekgeeitedujefgveehvdevieelfeeiiedttedtgfduhfejie
    fggfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkmhgvnhguohiirgessggvhihonhguthhruhhsthdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:nEl9Z8ocmAHYmf-goVdhF7BN4TbpE141q2tCDDH0azuvyO27HxNQeg>
    <xmx:nEl9ZykqvVI07sDvY6fHkza46MsuDYkAy4bICFTnk9r8kUwYBdwlBA>
    <xmx:nEl9Z82Ne9bJcqZZ9ToNznbGknJDmCmzR_I62BmDImxPfWfpUte9ug>
    <xmx:nEl9Z5sq5FMrTzQnJP6-f6qZ7hYbT9ksrKh7Wktr2jaRdyQxXJ_Mlg>
    <xmx:nEl9Z5_x1dEgAqoB5HMzC7QVJfZ2rFk9-HoyaxFcftTI5ISzamkEL5Zo>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DD2BB780068; Tue,  7 Jan 2025 10:34:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 07 Jan 2025 16:34:19 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Keith Mendoza" <kmendoza@beyondtrust.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>
Message-Id: <27ec479b-b116-4fa7-b87c-416a5f7f3b25@app.fastmail.com>
In-Reply-To: 
 <DM8PR02MB7942969BE7FEAFB48D9AEDCEC7112@DM8PR02MB7942.namprd02.prod.outlook.com>
References: 
 <DM8PR02MB7942969BE7FEAFB48D9AEDCEC7112@DM8PR02MB7942.namprd02.prod.outlook.com>
Subject: Re: git restore --staged -p on merge conflict causes crash
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025, at 15:41, Keith Mendoza wrote:
> What did you do before the bug happened? (Steps to reproduce your issu=
e)
> 1. Start with a main branch
> 1. Add a new file (test.yaml)
> 1. git checkout --no-track -b branch-1
> 1. Commit a change to test.yaml
> 1. git checkout main
> 1. Commit a change to the same lines in test.yaml that was updated in =
branch-1
> 1. git checkout branch-1
> 1. git merge main
> 1. git restore --staged -p test.yaml
>
> What did you expect to happen? (Expected behavior)
> Be able to select which updates to restore
>
> What happened instead? (Actual behavior)
> The following is displayed on the console
> ```
> BUG: add-patch.c:497: diff starts with unexpected line:
> * Unmerged path test.yaml
>
> Aborted (core dumped)
> ```

It looks[1] like this was fixed in 28d1122f9ca (add-patch: handle "*
Unmerged path" lines, 2023-03-09).[2] That fix was included in v2.41.0
and later.  So not on your maintenance release (v2.39.5).

The bug was introduced in 2.37.0:

Jeff King wrote:
> Thanks, a fix is below. While the escape-hatch of the perl version is
> going away in v2.40, people have been exposed to the bug since we
> flipped the default in v2.37.0.

At least I wasn=E2=80=99t able to reproduce on 2.48.0.rc2 with the below.

```
git init &&
touch test.yaml &&
git add test.yaml &&
git commit -minit &&
git checkout --no-track -b branch-1 &&
echo something >test.yaml &&
git add test.yaml &&
git commit -mchange &&
git checkout main &&
echo 'something else (conflict)' >test.yaml &&
git add test.yaml &&
git commit -m'change here too' &&
git checkout branch-1 &&
# Merge conflict
git merge main
git restore --staged -p test.yaml
```

=E2=80=A0 1: Based on:

      BUG: add-patch.c:498: diff starts with unexpected line:

=F0=9F=94=97 2: https://lore.kernel.org/git/ZAmfqC9WMl3XeyEr@coredump.in=
tra.peff.net/
