Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB1E10E9
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 00:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753747551; cv=none; b=ZPf5+WIk3QeWB5d7BE0CTRF6oYDYciYrXhr7O9NrzudgdYkiRImMsJNhxvaJfpR09Q04RMD5x+RUvUjHUYD8dkGflBu0qkdd8ItQrkNhcQcQK8tgrxuYQRcyxPRA+R0DK8c0jTCyBzIIjVwo4zj6oFkOrftbXg1AGZ7jhIz5gBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753747551; c=relaxed/simple;
	bh=aMGZikMz7HS0OZz5NSXj7QA9XAYQIadWoYNba4TD6Xc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FILFPr36n38NTKu3vX8oM7C1Z6/LIvhIJXm4m6r604690E33evbF9WE4CHs5qWcFgGtS35If7uJRm5lNwOmB6Jwr2DM7ZHgmmTVf2qvCzQKHs0elTIrkgZquvnx4lzNBNsHU5dgpPmoOtsTcq32KPnxy/QF31N8MSUqrdPzqTMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IsEqZKA6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bXt4tRVp; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IsEqZKA6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bXt4tRVp"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 41001EC1523;
	Mon, 28 Jul 2025 20:05:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 28 Jul 2025 20:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753747548; x=1753833948; bh=m51vhbuP+l
	izDdkzX4zNnEU6dHnXq8XEKY8Z5Z4DXKc=; b=IsEqZKA631LkoiPaWNpuaznpiD
	kpS4Xgj98WtAU/v3gaMM/0xuu2gA6pgbDFazTIgvLhsXpMkGiLH9fouIorEKVK55
	oQ+KE8JwOPuVtoAKytjv/H49atVHlxiZcyITC20Fn6cf5FuaL3pIlyXBF2ueUgtB
	uWBmzQ3Gi+VjjiRumrcvgVzS+mlbda+Gf53FCJfjZUmDriznZa49KlGrGr1ozcHY
	sAtdxiSVxjvcIeg80SFFTh2UcJL5V+BYMzp69W2aW0MZLSAKp+Sx5fVGPOXrEVq1
	7Jmktz3qW/CAVzYFeV9V0ke7B9xbeCIktxBOzg1ueQozBxj+a0l8sxxueLhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753747548; x=1753833948; bh=m51vhbuP+lizDdkzX4zNnEU6dHnXq8XEKY8
	Z5Z4DXKc=; b=bXt4tRVph52VYAuOjnWVsfoh/ER8+d0XYPfPMCntGONcwda127R
	KS1QwNdK/lnZPB8Qoo45hCYv4/xItrshVM6a9XByWljsZSKBxNS14/Gfgfmsdwog
	vAKOFM58+XVctDLstJiuQTHMvbUehAVPjjv7yCC2RM45d2conUHlbYkp6uGxOA78
	2YUM30vBiSnzmVAmG+FfTPhHn4aYGJAfY6eBIgOehDEsCPVY+LTmDXTTrS3ja6l0
	jQCE/F+jOZ39JW5slMc4tmlQpkZ8CM4QS7MHeBE2NoTJWkC7x5WQfTTUgAgm5W6+
	y5HudE2cOFJxQmUgyFoAdTQ0ZpRohCX/QbQ==
X-ME-Sender: <xms:WxCIaKLDLOlmDUU2QsTa_E2FJYI-QBxgmz0ttItR7MGr68-v3ODGqA>
    <xme:WxCIaMvlFMM2H23aypX6XqqfyhP0dbF1zL0LNvtrjEroBqD4Yo4D1Cyjs6rCS7JoI
    m3dROCJTXhbdVMZFw>
X-ME-Received: <xmr:WxCIaHRHnpAm15IXJ8xVydkgH3_iY-YEC8e-ylW5OzLYIwA-a1Q3MBWbV4jEi_vmck7lBh154kX0grEjl5L0ZvShC1OStYLTXul3X3k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelfeehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeije
    egfefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtgho
    mhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjh
    honhgrshdrsghrrghnughsthhovghtthgvrhesghhmgidrrghtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:XBCIaCPax-u4BwJMv5luS3x2IX0b-x3eSqarLFgvyUD5l1JBvmHmog>
    <xmx:XBCIaMag7bJPVAGvDxKVi2edy5cRMUarEauA8mv_Y9tFDUjm2Ho6yg>
    <xmx:XBCIaMxrEiAUY6mebLvHt7uViyaxZZg9C9QgHHGcacUHGgCw7H4STg>
    <xmx:XBCIaHIU7pcee_hpAbltb7YLL5e2Hx9HeEs-NZPyWamj8cYAeXraQg>
    <xmx:XBCIaOmJIfTkrfhqJ8Dq0cDUb_tfmsMwIA5JgUB1RBjTtYzhWSx1sMgA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 20:05:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Jonas =?utf-8?Q?Brandst=C3=B6tter?= <jonas.brandstoetter@gmx.at>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] t7510: add test cases for non-absolute gpg program
In-Reply-To: <20250725043043.GA3002998@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 25 Jul 2025 00:30:43 -0400")
References: <20250711232348.460804-1-jonas.brandstoetter@gmx.at>
	<20250722190922.51183-3-jonas.brandstoetter@gmx.at>
	<20250725043043.GA3002998@coredump.intra.peff.net>
Date: Mon, 28 Jul 2025 17:05:46 -0700
Message-ID: <xmqq5xfbuahx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> This second test seems to fail on Windows. E.g., in this CI job:
>
>   https://github.com/git/git/actions/runs/16509422831/job/46688307091
>
> Right before the failure, the trace shows that we are setting PATH like
> this:
>
>   ++env 'PATH=D:/a/git/git/t/trash directory.t7510-signed-commit:/d/a/git/git:/d/a/git/git/t/helper:/c/Users/runneradmin/path:/mingw64/bin:/usr/bin/:/usr/bin/core_perl:/c/WINDOWS/system32:/c/WINDOWS:/c/WINDOWS/System32/Wbem'
>
> Should it be "/d/a/git/git/..." instead of "D:/a/git/git/..."? Which we
> could get by using $PWD, I think.
>
> The earlier one using $HOME uses D:/, but this one is different because
> colons are meaningful separators in $PATH.

Here is what I have on top of the posted patches.  If today's
integration goes well, I plan to merge it to 'next'; the rest of the
series is already in 'next'.

---- >8 ----
Subject: [PATCH] t7510: Windows fix

$PATH and $(pwd) does not mix very well, because PATH is a colon
separated list of directories, but on Windows port of the shell
Git-for-Windows uses, $(pwd) looks like "D:/path/to/a/directory".

With $PWD, we would get /d/path/to/a/directory instead, which would
fit better on $PATH.  This broke Windows CI job.

While at it, drop unnecessary use of "env VAR=VAL" before "git
commit"; one-shot export "VAR=VAL git commit" is sufficient.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7510-signed-commit.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 95d2ebe277..c51e2e2589 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -453,13 +453,11 @@ test_expect_success 'custom `gpg.program`' '
 
 	# `gpg.program` starts with `~`, the path should be interpreted to be relative to `$HOME`
 	test_config gpg.program "~/fake-gpg" &&
-	env HOME="$(pwd)" \
-	git commit -S --allow-empty -m signed-commit &&
+	HOME="$(pwd)" git commit -S --allow-empty -m signed-commit &&
 
 	# `gpg.program` does not specify an absolute path, it should find a program in `$PATH`
 	test_config gpg.program "fake-gpg" &&
-	env PATH="$(pwd):$PATH" \
-	git commit -S --allow-empty -m signed-commit
+	PATH="$PWD:$PATH" git commit -S --allow-empty -m signed-commit
 '
 
 test_done
-- 
2.50.1-589-gf1cdebda82

