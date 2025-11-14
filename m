Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405BD2FABE3
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763152460; cv=none; b=WNysdMRZ2fWxWcqhjPbUrNChpPmiasrej7+QpZi/ydvhK3UvmiMFCRHG3f1GS1gPFFausTIEVk4EIl0uBXvFJyFZdnk37UZY4JnYPMMBcc3tbj8/YdQd9P7oPADKXN0izG6bRb0PJafh+L79fvN9IE2efaAbjiQhxB6fmMgNhhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763152460; c=relaxed/simple;
	bh=dM3mwrd1+Xpq23xgmUgcEcGWjz/LSfaPsf6DoPA93hE=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jj5wXFxuTE15Ty/oi6wCeRAWe/TA+HH1A5fy+aO+kFCNXN9zhhTAq8ji5vZ5JU9dhjU9/YMkb7z3OnzVVmjdhPjptKL+OlNNJvD0smamhFI0jYJdfi8dKQsdsu3LGQ9gU7mu4K7VZhi4m4bodNMrBoKPgVsuSd/unkOPdOE6kkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HrqbYzyy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mi1oJia2; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HrqbYzyy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mi1oJia2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 746E0EC0129;
	Fri, 14 Nov 2025 15:34:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 14 Nov 2025 15:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763152455; x=1763238855; bh=otiJi+mk2g
	NQ1T+Td5jnrJ7yy/AV/or2aBdDIfAhW5E=; b=HrqbYzyyoI1TRr2Mo5Yjg6ItzF
	6NHJI0ev393xapJPjw472g9i6j4g/iq1I7Bq+wC0zKalhHUaRqFnfGnKSlCCoEob
	XASN+qwZsAFtxJ3k8aQwWaUS4CBOU9m9tdN8Fq/e3GiOQGKHf2hFXOj9WQgt+VOM
	sL8cyXlXt0IUIJOTont8bdoY6udhoMmab7Ec/lJwc41b+7PzQd3NbR66d2J0bxzM
	ge1ZatU0wBoy23HEeueFZIaTodRAiRx9OQyNnf2GmzMn3f337IZ2qK6UJk/mVtwL
	JPE2KdLy6eryAX/W/zMWTuPGPtvBQCaOwSZf20k7s+ig6lvxt3HDE1skGKqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763152455; x=1763238855; bh=otiJi+mk2gNQ1T+Td5jnrJ7yy/AV/or2aBd
	DIfAhW5E=; b=Mi1oJia2X10Nj+e1xMcm5rQPBTcaiwAmVbZnpAbPTSoasQnevjN
	dX+spuFoxRRbakZVIIG9cjbYepeSr4Cz0xtqePToNhb9HLgMNAPTTzg65Xjnpz1k
	V92J0HT7ZrWUjlYCS6vYj6eMXkq55NMTc19HPL0gOKXTlW8G80rOu1RBc6NBh2tt
	rKl+mgA2/T79/u8Dv9RbmIz9/re/73ohY6Px0IvuR0TdocDwM/ZtS19BjQlNiPKi
	UyjEjPHxRc4lNZ894cSPtju771LNF9uO+j+NqL9oatFdU0YNfzPeGuYXCSZTlfs+
	DfoKbGrkCEIm40PBi7SQsSJ7cEqO8VsfnTA==
X-ME-Sender: <xms:R5IXaWzWROfsPVX5RMRjoqBh8nKEbc44RsOZQbmiUTnZ1zxFSJKWwA>
    <xme:R5IXaYTzF33Y1yczgHUnsefk6iQznozWAbzcEcA4BTXMvBjVvTI7vY0RmW8HYpZwd
    zdCzcXuquTTZJzzNYP3mNpJeIyxFHRGNEYJri1OJ4O0YzncrJVApQ>
X-ME-Received: <xmr:R5IXaV899PGKQ6fv0UEN6IaKCvI4rs1Vl9Q3bzeEfGu5uCJ81Hw6vwVZ9xSXBtE09getVi-S-nOr9A1zEyPIUFr0bvD9EwNfBmgm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddtjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepkefhueduteekgfdtueegvdfgueeiue
    dvlefggfefkedvffduvddvkeeuhfeifeejnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:R5IXaXrEj5HDBxlnnJLcD79eBeHCMLx-5VOahiJNlBlM1kLoY3NejA>
    <xmx:R5IXaanB-vrx5v52ZuwVJ2pOrG4p93AIwHAilsPf2lSp2Unf0vCG5g>
    <xmx:R5IXaWI2JtqOVwYk3B2iUAFw-SB4Um0MOQYLfmrgLZgactrWYbmU1A>
    <xmx:R5IXaXzmDTFEy4rI4XA-M4LHhM6zXiJHhz_6ieDdLuiuYpfmlnjjiQ>
    <xmx:R5IXaaKKwUpKrVRk-xPDmYGZOzgLT73HgUrQjz-11HYBRdBOx79k8P5V>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Nov 2025 15:34:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
Subject: CI Failures (osx with p4)
In-Reply-To: <xmqqv7jcgy8y.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	14 Nov 2025 12:22:53 -0800")
References: <ddefb36d-f023-45c1-b518-a9f70dba0696@gmail.com>
	<b1775e1a-4f6c-4116-9587-69526d379b42@gmail.com>
	<xmqqv7jcgy8y.fsf@gitster.g>
Date: Fri, 14 Nov 2025 12:34:13 -0800
Message-ID: <xmqqqzu0gxq2.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Speaking of CI failures, I think we are seeing unusually high rate
of failures from random osx jobs failing to successfully run t98xx
series.  Is p4 on macOSX still a thing?  As macOSX tests tend to
take very long to complete compared to other jobs, I am tempted to
suggest dropping p4 tests from there.

Opinions?

----- >8 -----
Subject: [PATCH] CI: drop Perforce tests from macOSX jobs

It seems that we seem to be getting unusually higher rate of
failures from random macOSX jobs failing to run t98xx series, even
though we haven't changed Perforce interaction part of our codebase
for quite some time, and the failures seem to be limited to macOSX
jobs and no other platforms.

Most importantly, nobody from the macOSX community seems to have
raised an issue here, reporting any failures.

Perhaps we should stop testing the combination of P4 and macOSX to
save cycles, electricity, and my sanity ;-)

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/install-dependencies.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git c/ci/install-dependencies.sh w/ci/install-dependencies.sh
index 50628ee2dd..3f718dad41 100755
--- c/ci/install-dependencies.sh
+++ w/ci/install-dependencies.sh
@@ -109,10 +109,6 @@ macos-*)
 	brew link --force gettext
 
 	mkdir -p "$CUSTOM_PATH"
-	wget -q "$P4WHENCE/bin.macosx1015x86_64/helix-core-server.tgz" &&
-	tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d &&
-	sudo xattr -d com.apple.quarantine "$CUSTOM_PATH/p4" "$CUSTOM_PATH/p4d" 2>/dev/null || true
-	rm helix-core-server.tgz
 
 	case "$jobname" in
 	osx-meson)
