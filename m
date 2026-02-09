Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFFB163
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 22:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770676687; cv=none; b=uAupWoU6HwWHPWy5RTBYs3f1XjQIV2whAjtreSQH/cXVfABmCUsNXdZuk32StwjLZTUNp7Vxykm3l8c/A2U6fUNfkpt02MqWE2dKYEojsXmULCfo8Ef0zwlexA31oH6orGIZr/8e1gPPXIsd+08NHqSad20CfW+6jBf74zVXyfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770676687; c=relaxed/simple;
	bh=xmXHle3vdJnhSKFLVQWZJYAftK21PwWpKeiLX0AdN6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZRWb4zx4Ebxk4nSHNzj7rhAibM9w9dwahkPNwI/LpoAuCX/NVholslV/l8I4KZZTv+p7maL9+ERzWdA6VlGYjdkvzPdbJzSniRTk+OOLLTIrjKGnVt6HGO2jDEFkvUrU0vo/HmLGvn9Hi2aSuix6EfVmXp5fdygx/aIuto38ahg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Hvolac1F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VQpJ3R9d; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hvolac1F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VQpJ3R9d"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C68C6EC0305;
	Mon,  9 Feb 2026 17:38:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 09 Feb 2026 17:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770676685; x=1770763085; bh=hLJuPetdoQ
	e58ZrPMl8Su91OfrxdCcgiD7fECXtcZZo=; b=Hvolac1FmlDf05LppNO5E/alN8
	f/OsdiMys4PJovDhDGwxZDfPtr5bQ+goKszp48fIEQybcb+NxdyYJ1lKEVl7zmn9
	Z6o8K/QNUC6nwxFUHFVQHoKGMBrnJrL6PFqlJmHKeVrozeqR6bV1wX9z1nTDwh0H
	XJgWYQedcyeJVv4MTDw/3utcNDV+ZrbVY7Qpj7ghXo5ymmvE+foRdsRsUsCarCHD
	F4j+iU6AghZRqyeQCBZFe8o4ELc7WBIZbn+0cdvB3/5VRkmvk4fqVdrt8Xo0YYFS
	0x8Y45bQO7AKGOYgvyhmN9lTaSgaq70eaK2og+f6B5OqgEtXu2Wad+M9/DDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770676685; x=1770763085; bh=hLJuPetdoQe58ZrPMl8Su91OfrxdCcgiD7f
	ECXtcZZo=; b=VQpJ3R9dWgA0AT3B6e5kGKOFwekhN20B7zvjv+cAOA0CBnOo+yo
	6LcVdCWzWf5lkrf9FDJ7Ija6/z668EeYBzLib+gPM/cUz7rnLpFPl4pe8xNeyC4+
	PP0UEQIf15Bp7GUJSMZ+1bihGnxgwe7CT8txZAVO43BcZixEadG1TDINQlFT5h7i
	88vi/9l3oYSYEtMFaLExNqY2nv/KkdfzBF4nU/ieg0q0oGKmCr1r8ovmibvxM7UZ
	NQqfgGL/NJDJJFt15rTs3roDucs2TLdTPQTWuxcCM4NbsuQ9MjaaBzKlKthJJ/9r
	/3962KAnaovTzCNgj7L6/JMg+q8BVshq/bQ==
X-ME-Sender: <xms:zWGKacRk_2lOi9a5Slre8hb31qGwzc5F0qhg3Q-8v2QHcMCY5OwUQg>
    <xme:zWGKaQzAJNaU9iV7SPLUcaHB_HWbFtjhV08nnQyR6WOH3qmf43K3ksAlvV_dgRxIP
    vUM8Wv5hYP_AaaulGID4JHeegv_m2DNFZGhqTpUaNN19dVkQgfdPhc>
X-ME-Received: <xmr:zWGKae2aKhOqpnKUPcE_Ot9JKxuIyxJ0DM5lzq4K65k85RAYG-D1YjNLwFopEIvJ9rKmgi4C4VtTOR6sO08vgkQCm3rpLKZygQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleektdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheprhihrghnrdhjohhhnhhsohhnrdgtohguvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:zWGKae7y8KHDq3uXwKvV5kyN9gvlrOBMGwCXMtA3g7ZT4Qixwk1oXg>
    <xmx:zWGKaRV5gnKbxj0bRLUKJ9XZQvUCnD7IXqgolT9RekRqZ5or52vDgA>
    <xmx:zWGKadC5SB4EB-ZAaLDCZnhpANs3PVoXss_GEJ64U12wSwLD5o4lzg>
    <xmx:zWGKaQ4Rk2_nQEc8n3I7zkFj98wcVXIFbrTKRLW25bEOiPL2pQocsQ>
    <xmx:zWGKaWXL9ulXktuUsl2Yncbaj3IWB6bCnOYetc0im9Pj00iPONebKse4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 17:38:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Ryan Johnson <ryan.johnson.code@gmail.com>,  git@vger.kernel.org
Subject: Re: git branch behavior after git init needs fixing
In-Reply-To: <xmqqjywl6e0w.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	09 Feb 2026 09:08:15 -0800")
References: <DS0PR03MB72900848B03D2B87A6846DCAA365A@DS0PR03MB7290.namprd03.prod.outlook.com>
	<D1CA4E13-B279-4931-81EF-364169564612@gmail.com>
	<xmqqjywl6e0w.fsf@gitster.g>
Date: Mon, 09 Feb 2026 14:38:03 -0800
Message-ID: <xmqqms1h35mc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Ben Knoble <ben.knoble@gmail.com> writes:
>
>> You are probably looking for init.defaultBranch and the 3.0
>> breaking changes plan (which will make main the default).
>
> In other words, run
>
>     $ git config --global init.defaultbranch main
>
> just once to live in the future?  That sounds like a sensible
> suggestion to me.

And that is excatly what "git init" gives our users already, until
s/he sees it sufficiently often and declines to see it anymore, at
which point they are on their own ;-)

After temporarily disabling init.defaultBranch setting in my
configuration files (and I left advice.defaultBranchName setting to
the default), here is what I (or anybody) would get.

$ git init
hint: Using 'master' as the name for the initial branch. This default branch name
hint: will change to "main" in Git 3.0. To configure the initial branch name
hint: to use in all of your new repositories, which will suppress this warning,
hint: call:
hint:
hint: 	git config --global init.defaultBranch <name>
hint:
hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
hint: 'development'. The just-created branch can be renamed via this command:
hint:
hint: 	git branch -m <name>
hint:
hint: Disable this message with "git config set advice.defaultBranchName false"
Initialized empty Git repository in /var/tmp/x/.git/
