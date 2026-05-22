Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B641E49F
	for <git@vger.kernel.org>; Fri, 22 May 2026 00:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779409960; cv=none; b=PhnIk/s+rQaDnN4gHlwPR6uJGiFSEikUeTCHPyFGqz3PBo0JF5JQi1HPDmYzgafoHrqnxdnnYrBjWRcUydSSuS34+u15D08oB4GWsmoDB1GyHDMfAhm89bA7d8r9xVO0KFea2cHXEpgfDJ2uMte6e2Q3gquwbuP6h9xemVMeusc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779409960; c=relaxed/simple;
	bh=0Dkah8Hxc2zfKJ2PG/iehBM1Srn5wAg5ufCO8YDjEuk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZDeaBaj9FGHybgpdD51GG8t1RLdTndYhzyy0xFeobJ/j3+bFvmZiCGe4f75TIEOOMGtSY9M6kvr1Imvq2yAzEYOfO9BuyUTya8WNpIkQftVc60GqP5nM15xl3b6Ng1d+kz0dnZp/gFTgTKqtp93/dBTsUj1Z6s7EOzwKu5QOGg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nn/TLvlh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rt4nsm7L; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nn/TLvlh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rt4nsm7L"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 98ED57A00B2;
	Thu, 21 May 2026 20:32:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 21 May 2026 20:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779409957; x=1779496357; bh=+zk19+Mrbj
	ln09qFB52DcIctaJcaYir7yTdG7g6aTwY=; b=nn/TLvlhDjp2REJ0tiEYvhnI6m
	+/XrTij4gHmfFvBbLWzBCX/VIS122q7QqBmbBjEIDGVS6HnWG9T2rLpAnYb0tk4M
	y53Y6+vUM7MKNpmWmY/t0jUm0Bott1KyQAUTVbcJsjfBzeHD152Nck1InhXdM5WT
	HapJLhiDqvT/r0+rtxQkIqHvB/xTpau4RyUIxOVn1OpvU/fQTuui3tQHQwZZ6RwI
	/Or+2HH4bEjcR+VKG9982q+X3NqVvEExna+wi2tciE1q1ox4tdbWzrGm4tKiTBxJ
	f6vaNgvCt53OiZCsKVlfykUbaA5A3scPaE+aNjrOgxbkKZHlYME7wAIxTL0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779409957; x=1779496357; bh=+zk19+Mrbjln09qFB52DcIctaJcaYir7yTd
	G7g6aTwY=; b=rt4nsm7LBUGNgpDdwzx765JKI9xWNX22rvnkbufk83nKsFfJ+44
	rnHhK/7vwJ45lFdEfADzWCVX7znI+6/1/PDAiu+g/k2jZ87rBINE4HWxaz+rt9v1
	McelrfYITxEJcyVvmJ3lCjW7/eQFylNESslpqAeRZZxMV64PbCxxfBOyMvMhlb4m
	F2nWKAYXfdbjHQzqArp3WkMlzB10U2Mfrbi1YIOlK1CrrftB2kNF6YZnYXYGeO3L
	nt0fwaFsjo/iz5g/sHyQwVtojl3YcaRwkWrVVvSIZx4fkreM6yP3DA1SmV8ItE6M
	I96HTLzNOZ9wsOxw2OLuhhaYXPaq67CYVYw==
X-ME-Sender: <xms:JaQPaiR9iQcS5cvNOiHf3TyZs7hPb9oTEzo0Hy7evQibrL62y42dhw>
    <xme:JaQPavOX-gKdVJg80DPPXPPjTeddPGf7TffmnYBjU68b42Z-9pPWv8Qliff4LDE7l
    LKLHUHLOZazl-GRBpnbvVKDDyeKJzxq6D3RJwQhcs3ou79-gXu7>
X-ME-Received: <xmr:JaQPatMMuWvX6QrjAg9yJ9coc-VKRcxcOZ8KYNSqY_WftBMs-Qk5Vz-13MY00Kp3GoId0Yz8AmeyR5lfkXG961ulZxjNwnTeaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeekleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:JaQPanuLntTz0GZuwUNISMJiHZyZNXV4rjGGPhh-c7mPyBoEdnUnmQ>
    <xmx:JaQPavVgl6J9mOWuuhvbxB9yihkuu6M-zXgAcY6KkOaE8ry8JsodEw>
    <xmx:JaQPanvn_R1gPqXOgyE5XlnU1acZ2MghBO3H3rf2NnscenqSuUVaPQ>
    <xmx:JaQPajUbS2CfhJmhcB1SJ3z6g8jLDnuXGwi14LbHD7meufIX7AxZjQ>
    <xmx:JaQPanX7VyKtsQdy5jjWNwiIFMdpNcmCVExlKrLeOaNH6reS0P3Fb0yf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 20:32:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/8] setup: centralize object database creation
In-Reply-To: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
	(Patrick Steinhardt's message of "Thu, 21 May 2026 09:42:27 +0200")
References: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
Date: Fri, 22 May 2026 09:32:35 +0900
Message-ID: <xmqqqzn4xp0c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The series is built on top of aec3f58750 (Sync with 'maint', 2026-05-21)
> with ps/setup-wo-the-repository at df69f40c34 (setup: stop using
> `the_repository` in `init_db()`, 2026-05-19) merged into it.

FWIW, this merge needs the following merge-fix squashed into it,
for the topic to build standalone.

commit ce350f62ceb26f3276ea3b7ad78b7f8cb4c35cf7
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed May 13 12:20:29 2026 +0900

    merge-fix/ps/setup-wo-the-repository
    
    with  js/objects-larger-than-4gb-on-windows

diff --git a/t/helper/test-synthesize.c b/t/helper/test-synthesize.c
index 1f28ecf0f2..3fa534fbdf 100644
--- a/t/helper/test-synthesize.c
+++ b/t/helper/test-synthesize.c
@@ -506,7 +506,7 @@ static int cmd__synthesize__pack(int argc, const char **argv,
 		OPT_END()
 	};
 
-	setup_git_directory_gently(&non_git);
+	setup_git_directory_gently(the_repository, &non_git);
 	repo = the_repository;
 	algo = unsafe_hash_algo(repo->hash_algo);
 
