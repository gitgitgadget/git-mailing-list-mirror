Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B854422F17B
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663576; cv=none; b=AGB+G+XSFptwOw3KZYgLtKbF8wnYPd5MeAIJNDe9VUJ8M4GmH/9/gM0DaYFlps1bY6mFd2NDMEiuNNdINTq8t5XBT5XXWyqsC5B0HxJkYwZCSJz5HzbQjcp4hAzq2APeZNJaBHYgT/hbatNdUTeygyA2yOySAdIdiJMOV8v7BKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663576; c=relaxed/simple;
	bh=O14g8tTeGJEXc37mipWJvRLdLvgfBI9brD1Ux7mo4Hk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LStjUUtT9VMtN/0hLPO8V1d9YtCmdMjkBbuiys/xT3ioqPY+BzhYnV/cvjTKR8XQO4It7fGK4scL5yYmmVGbfzqVQ1mc+6T+Zl1xSLiMVKJ/yVWnRfuJvWi/KNElOytzgpHrpKkt4thWcWAHOY/IX3BSMsF6vUeRdt31rSvvA6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ExJtj/AP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bl8etNq1; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ExJtj/AP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bl8etNq1"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id AE9701382FB7;
	Thu, 27 Feb 2025 08:39:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 27 Feb 2025 08:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1740663572; x=1740749972; bh=L7rP05up9h
	24LTfxvczsnEnZyFJRO7255EgHE+nBRFc=; b=ExJtj/APd/7/720cNf6MKGtRus
	96ucjfjpxE9V1pdpuE+GPcmnSp8d/d0C7JgV1ZBXw1IhPmzxQuNTM7xK9hv43S3P
	ly6IvnFfkhqw0niiuu8Y7TM0/Gk9G1R0RojtKaUVCrzLHB0A6KJljZKYpekAArT8
	hYg0M9phA+pE+Ze79mw2LIrRk14yxF9Z5y9jkKRiFSdw2b9tUw2ORas8e2z034Jf
	fiRHeTXqkk3a0JSNaQQXvqnzukWrNVUgqai9gxCTnP4R8c5fI5J0FbNUi8jwyFQH
	LOf6WmF033HCKvTND+l26P38zLclzcWaGFo+CjOybCMxwyvIg/4IKFKF3U1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1740663572; x=1740749972; bh=L7rP05up9h24LTfxvczsnEnZyFJR
	O7255EgHE+nBRFc=; b=Bl8etNq1r5hfEarxx9bzEIboNd5BHQ+OfInnUjHbRDqs
	wFDNBablthxtLnf3YI7t0YW8ApXrAOt4ud53Col7ara0Y7SDbL+gIxkKoUgb6YSb
	KcbfqREmfUAdjsP5EN/qNEz5VDf+cjsImoVC1I96Iydzdh4sxAjD7isqxcsVA43u
	VwzG4rCMzNleFsO3VDNDtFkJpw4pbORpex+lenq9RZeWuzAqF5IrUoxeX9hnmSqj
	kmWs925VX7xmb/o79ZfDunUDktRgecNyjVfOjxrvS+qj05Z8vMv7tu6+ZBPJQSOB
	y5NbxfAdNiJ/DZyVlXrxYqod+fEnHJ9cufDXdMjqDg==
X-ME-Sender: <xms:FGvAZ2zS0TRbwCvs0-_e6v6jUD1La68BUXXBJMblyl9Z7LhJmdF8Xg>
    <xme:FGvAZyS86evSL-fz4scJZWma59CUj1tSV2-mzyT7zEnPHS8Sd-OG5NGi7HI2vu16w
    17jQacmo8rhZn4e-Q>
X-ME-Received: <xmr:FGvAZ4XLHRKGXnNyy8wBOX_Xnz3JGr90dzlDWJnqmfQOeYx0iJg2Ji01bPyZc9HcBiWcTEVWXs3qMPIsid7YdMyvIXdeGifYhiMWsnzKGzv3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpefghfevudfhke
    ejhedtteekieeljeeijedtgfdthefgvdetheeludetkeeuueejjeenucffohhmrghinhep
    ghhithhhuhgsrdgtohhmpdhgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphht
    thhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FGvAZ8iRCLW1U3WO3Z7sOIoJCS_ls1KCB67mCYFfmY1G-2SsWFJvDw>
    <xmx:FGvAZ4CGQ9hoCKl86doieo8T3ElqtRPJ3E8IhVcwVv-1rgD8NucDZA>
    <xmx:FGvAZ9LgfT7imajtgeB5-19miSlb46JhvPeHce1Gz945AUtrhNuN4w>
    <xmx:FGvAZ_D2yoODrwaYnl9utz8u7uzz_JqLQlx7N2fYJVNutGzQkEvdkw>
    <xmx:FGvAZ7PjiH4IgqIe1k9ATt1_NJyaxFUfUQflYWOSXIDdnZKNMHquUgBJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 08:39:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b4f8f26f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Feb 2025 13:39:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Feb 2025 14:39:22 +0100
Subject: [PATCH] gitlab-ci: fix "msvc-meson" test job succeeding despite
 test failures
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-b4-pks-gitlab-ci-fix-msvc-meson-tests-v1-1-0420abde3807@pks.im>
X-B4-Tracking: v=1; b=H4sIAAprwGcC/x2NwQqDMBAFf0X23Ae6akP7K8VDjFu7tEbJBimI/
 97Q48Awc5BJUjG6Vwcl2dV0jQWaS0Xh5eMs0Kkwcc19zXzF2GF7G2bNHz8iKJ76xWJ7wCK2RmS
 xbHDOt03nWnZ8o9LakhTv/3kM5/kDkgfZ5HcAAAA=
X-Change-ID: 20250226-b4-pks-gitlab-ci-fix-msvc-meson-tests-77a314732729
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

We have recently noticed that the "msvc-meson" test job in GitLab CI
succeeds even if there are failures. This is somewhat puzzling because
we use exactly the same command as we do on GitHub Actions, and there
the jobs fail as exected.

As it turns out, this is another weirdness of the GitLab CI hosted
runner for Windows [1]: by default, even successful commands will not
make the job fail. Interestingly though, this depends on what exactly
the command is that you're running -- the MinGW-based job for example
works alright and does fail as expected.

The root cause here seems to be specific behaviour of PowerShell. The
invocation of `ForEach-Object` does not bubble up any errors in case the
invocation of `meson test` fails, and thus we don't notice the error.
This is specific to executing the command in a loop: other build steps
where we execute commands directly fail as expected.

This is because the specific version of PowerShell that we use in the
runner does not know about `PSNativeCommandUseErrorActionPreference`
yet, which controls whether native commands like "meson.exe" honor the
`ErrorActionPreference` variable. The preference has been introduced
with PowerShell 7.3 and is default-enabled since PowerShell 7.4, but
GitLab's hosted runners still seem to use PowerShell 5.1. Consequently,
when tests fail, we won't bubble up the error at all from the loop and
thus the job doesn't fail. This isn't an issue in other cases though
where we execute native commands directly, as the GitLab runner knows to
check the last error code after every command.

The same thing doesn't seem to be an issue on GitHub Actions, most
likely because it uses PowerShell 7.4. Curiously, the preference for
`PSNativeCommandUseErrorActionPreference` is disabled there, but the
jobs fail as expected regardless of that. It's puzzling, but I do not
have enough PowerShell expertise to give a definitive answer as to why
it works there.

In any case, Meson 1.8 will likely get support for slicing tests [1], so
we can eventually get rid of the whole PowerShell script. For now, work
around the issue by explicitly exiting out of the loop with a non-zero
error code if we see that Meson has failed.

[1]: https://github.com/mesonbuild/meson/pull/14092

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this fix addresses the issue found and discussed in the thread at [1]. A
failing test run can be seen at [2].

Thanks!

Patrick

[1]: <xmqqh64gg0pu.fsf@gitster.g>
[2]: https://gitlab.com/gitlab-org/git/-/jobs/9262132042
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3f29181708f..a10bb8372d7 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -179,7 +179,7 @@ test:msvc-meson:
     - job: "build:msvc-meson"
       artifacts: true
   script:
-    - meson test -C build --list | Select-Object -Skip 1 | Select-String .* | Group-Object -Property { $_.LineNumber % $Env:CI_NODE_TOTAL + 1 } | Where-Object Name -EQ $Env:CI_NODE_INDEX | ForEach-Object { meson test -C build --no-rebuild --print-errorlogs $_.Group }
+    - meson test -C build --list | Select-Object -Skip 1 | Select-String .* | Group-Object -Property { $_.LineNumber % $Env:CI_NODE_TOTAL + 1 } | Where-Object Name -EQ $Env:CI_NODE_INDEX | ForEach-Object { meson test -C build --no-rebuild --print-errorlogs $_.Group; if (!$?) { exit $LASTEXITCODE } }
   parallel: 10
 
 test:fuzz-smoke-tests:

---
base-commit: 5a526e5e18ddb9a7dfc5a2967d21d6154df64a4f
change-id: 20250226-b4-pks-gitlab-ci-fix-msvc-meson-tests-77a314732729

