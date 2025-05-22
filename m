Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EAE2620FC
	for <git@vger.kernel.org>; Thu, 22 May 2025 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747930384; cv=none; b=dtd23mjDIapvQKoL9kKBMIzH0dvc5PYEjVuypSSROFlXu96GekGgTfuK5uba6pNJpsBqpf6eYOnl4ZUFscHQv0jMnmrbXR3RQvM74qRvZ8WXINf2dUtHBxc1M64ki/FQbdfUeKa4QRvGSGSlDIJyVU5bHP5MbK9wMoghpRuV/m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747930384; c=relaxed/simple;
	bh=PEZ8gauTWLpQQfHdi7g17174uyER52dEhhvmrJU/Be0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aHJalR6ULThOIesMV1Y9XpGiHieShDavrDbuKby8LTThTu3P6a/cVWOsfHu1/0sktzXYs5YVVa6ias1cfjK+y6dmcHjXZl+aT9Z9v9DqIxg3jPJyik9AWNqeK+e55ZsetxoZPWlaOBKJQzNmTDsjo2DmfyJEPvu4qn28o2ymiEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DS0cwKUN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ugKtX2JT; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DS0cwKUN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ugKtX2JT"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 28A4011400E8;
	Thu, 22 May 2025 12:13:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 22 May 2025 12:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747930381; x=1748016781; bh=MkP4QJhyZZ
	3kfAFeDe6VByPsCLUa8ZqAE/IPdmncrEk=; b=DS0cwKUNWEV+6g36Kh/WcdzJ6s
	KRIssqIbKLcnRmSgavsQGjJj7vXfes6MCnBDHLtpskcQAbPPDlNyqf1Teh1KxFQs
	2fv1qnGRmMGVNbs0wLgX9aLx+0bxM8Z12hHwkRTs0KLIzUEWhPg3mi+BQP24VE6L
	VwmpDYoegr0zT48A32Zqsb48CbqGX7ax/YsXwr4nR7TqiNjnK83BCJyBbOANQFnb
	UTmCd0v2vPZvuOCX4H0mQSMU3sMNp2CT256Hqb9N3vk5LSbN/IbjuOyj7xiuHeUZ
	KrZbZDBQc3CKPwU+g1UvPb8ZaVCWdbuDeECeYduAk56h/YZenxScnUZzlCGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747930381; x=1748016781; bh=MkP4QJhyZZ3kfAFeDe6VByPsCLUa8ZqAE/I
	PdmncrEk=; b=ugKtX2JT1gdm6pTwo/KvgJDdsKpaIFhw4BUDFuG1F+8r6sdX7zp
	Okg1pPkbjcp7xduUhDwlgi7g6GD3CeEqkWWNHwlAycJv1wgA4bVowtQirwz3YE41
	EyutMs8IHZGYIGgBjDvMR1RJkFtKs/U2fye0ltrOLizwxRzyQC9mFp8/87fdULSu
	peoOFLWZDnQ0vok66fEJQV0xcqZAf1NHCJQAiZHmOGbfOaHynGAQwjsmKOY27WpR
	xyJDlKsXa9jicr3eKduwtgxKW4PlhdMeSPr2tsS4ICwo2cJa6yKc4lmoIw1U/WPg
	JbTpH5mHhALFKY+KecMRvFPhWxNuT82WvOQ==
X-ME-Sender: <xms:DE0vaNa6BzVNYygR6Yl_fg-D0T4swQGPCF2d4JxtcL88-qHTr1y9Wg>
    <xme:DE0vaEbtZJ8pwtbFLvqQQ7THWfEqSY21HLJH8zv2nAAOI547WzHjdRpR79_wBeYDP
    Ha_w0Nsb9JR1Y3htA>
X-ME-Received: <xmr:DE0vaP9CDvOPJJcCsKLjCwDmKbjL97koyasT3l7PJ0r5YDti3PflpFWW2-tWawabaqffBlMqYrERrmcBUAd0U4m3qXW54y4vdAfuQfE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeigedtucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepjhdrfihithhtvghvvggvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:DU0vaLoMO3fowXWdQY5fVpiwSxFRvQ2vwC5cac3-FL-ACakzq0C96A>
    <xmx:DU0vaIpLTxWV6IBaERF8H861-W4FmK_G-0f434SqSdMlKpRQMiU7dQ>
    <xmx:DU0vaBTCvyDsLO7wmGtB8tqfsBZbibfumNJCkJgJfTr8O3ZwVdoWxQ>
    <xmx:DU0vaAosEe_hHSSg2alAGZzDOQsbH_U6ZMHvkQf1xFirPR5p0DlVpg>
    <xmx:DU0vaH243NKfJePYMIfFsIjZQ_4kryGKUTxpRco8mQlnC_yhOPatnEWI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 May 2025 12:13:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jouke Witteveen <j.witteveen@gmail.com>
Cc: Jouke Witteveen via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] doc: update references to renamed AsciiDoc files
In-Reply-To: <CAJ2ouazRuF8CGddobgV=xJr8=1RQ4Pv8+ndH0E4qxk-gJhG4AQ@mail.gmail.com>
	(Jouke Witteveen's message of "Thu, 22 May 2025 11:23:29 +0200")
References: <pull.1971.git.git.1747854310479.gitgitgadget@gmail.com>
	<xmqqr00hahdt.fsf@gitster.g>
	<CAJ2ouazRuF8CGddobgV=xJr8=1RQ4Pv8+ndH0E4qxk-gJhG4AQ@mail.gmail.com>
Date: Thu, 22 May 2025 09:12:59 -0700
Message-ID: <xmqq34cw7hf8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jouke Witteveen <j.witteveen@gmail.com> writes:

>> >  The platforms which must be supported by the tool should be aligned with our
>> > -[platform support policy](platform-support.txt).
>> > +xref:platform-support.adoc[platform support policy].
>>
>> ... this one did not stop at "txt" -> "adoc" replacement, but
>> attempts to make a proper link.
>>
>>     Side note: I do not think we are using an explicit xref: syntax
>>     in our documentation anywhere; have you checked how this gets
>>     rendered?
>>
>
> Turns out I was too lazy and blindly replaced what I recognized as a
> Markdown link to the appropriate AsciiDoc link. However, the
> inter-document xref functionality is unavailable in the legacy
> AsciiDoc processor (`asciidoc`) and is disabled in Asciidoctor by our
> use of `--atribute compat-mode`. I'm not sure what the right course of
> action is now. The old link was wrong, but the suggested change only
> starts working when we drop support for `asciidoc` :-(.

Perhaps let the sleeping dog lie for now by doing "txt" -> "adoc"
only, with a bit of comment why we are not doing xref: yet next to
it, perhaps like:

diff --git c/Documentation/technical/build-systems.adoc w/Documentation/technical/build-systems.adoc
index d9dafb407c..3c5237b9fd 100644
--- c/Documentation/technical/build-systems.adoc
+++ w/Documentation/technical/build-systems.adoc
@@ -32,7 +32,10 @@ that generally have somebody running test pipelines against regularly:
   - OpenBSD
 
 The platforms which must be supported by the tool should be aligned with our
-[platform support policy](platform-support.txt).
+platform support policy (see platform-support.adoc).
+// once we lose AsciiDoc compatibility, we can start writing the above as:
+// xref:platform-support.adoc#platform-support-policy[platform support policy]
+// or something like that, but until then....
 
 === Auto-detection of supported features
 

Thanks.
