Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0415C1D5CD7
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 07:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736149904; cv=none; b=RApt/nkB4j9pSxPbWoAPwR2PMsZmdWTfDi9wGhBLhxppLWUn1S5OEg0S2GTPkfKp2xD8HWilrWPmxWMajTlZNcK9p7EiHLo2ezHdxMc9KbDU8M0bTtPpdiM+LEIbOT7gxA/S57u44tn61Kes1LeROxOB2GXhpr/54VLfPkIVlmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736149904; c=relaxed/simple;
	bh=vTzurRRouIYNVNs3LnejtWD0W7f9dT3974KQhP/wnsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Svk4gQ7vNx9dPxZzrMg1xGxXxxiKzXwrc2ytz388WghPK7NsdkA6a33eOgzw9gdSC1hGyoJYX7kQYG22y63E+QHQotC2IDCCBUPQhx+0n8LTpxCWFLMrAHvk+930J082Q9BUizyELyPzpiNSaRcmr31YizgEjGqPV4i7CB9MGOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aB3eqB6T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H7AR0xdk; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aB3eqB6T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H7AR0xdk"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2176D11405C1;
	Mon,  6 Jan 2025 02:51:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 06 Jan 2025 02:51:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736149902;
	 x=1736236302; bh=TlHKbctS5EeAsPPta1NHmgt4mYmaZIkJCRdhtVu+/1E=; b=
	aB3eqB6T6UD6vjUIrpzJgnNdK/TnGvlt28L0AAJYlxfIF2o3nM5b+659D2fX5u/3
	Yr/TdnRHIadvLQ46Erw+hpAVnZg7MFmJ1hsX1IHV1aHOu5hLUaP8Ss2bkxLrKn8N
	FKgGQdtfh1IcDK6FQ12RlsMAoMx8y+lLON5yc+Ce4SzT5Ye3gQ8WEpvCmmIKrGj6
	N0SIibUKX+7ziuj8HHRF9uLpBmHRsJC/C/p2a9xhg/mk+pPwhqKE+5vpOU1X+4ee
	FiBRLolp1cKkVfvAeF1pQOCAy5bHbiUyO0h6EYoJpsaJSJo0GV6V/k4HkxFp27HD
	ZQMxYmr4ftMOLp7iQCjM+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736149902; x=
	1736236302; bh=TlHKbctS5EeAsPPta1NHmgt4mYmaZIkJCRdhtVu+/1E=; b=H
	7AR0xdku2wxDUGFCGBoX0dtRAaq2YEgpe1ZLXmGq9gow6CSuV5TmHgGtTvY9rwcy
	0v4ISFkI3uS1F1g7fpuHUFKFT9Qs4lpMND4xsEmhp2GHaS+9B0tbdT1CxlYBpgDy
	YPwK4Rn5/G5W2Tv/IX4KKIlOic5Vz+pbA5i7sO8cuVZlpJJyR2Hk9Lw3LtCHvA/U
	bhS9dhPcjirLbhAS/iiXuNVAiWHFM8Q6MXhgkudE1OBlEnHW4HyOJ6O+d2y4e6Pd
	1KwL8pIY+21c7ksKqd9WbfkLjU1KUhN9hY7/Gaet3V5qOliNXKYkLiAyoWOufRzu
	WKLquDZkpzG76CaoCnCHg==
X-ME-Sender: <xms:jYt7Zzu3MfnelyX7Jv_u51cVAc16bjGsDFqUCmHBsEUpSMGKNQCkqQ>
    <xme:jYt7Z0ciJCHTNutRALi0WDbgwDqRuTgOFUpz-cS3gJMLw8xyFQc-Enpfw7mqFFqlr
    SDgVMfHvaP9VCsnKg>
X-ME-Received: <xmr:jYt7Z2y6ArbD38X5C20umqUuDgm-s73DMZu-zEgZQbWOewqah6LjaKDyOrzDXEB30_fnNgupWNsa9hsgRybKXOha4PkTpI8GpFXKwu9QqQdsxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefledguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:jot7ZyPUGbvikhLt5M2ugilhhleriPQzXJcUmTgQoph-HnAZ49BQ3w>
    <xmx:jot7Zz-JHgUsO2mD3UXq9yG8gCRR9SFl7JnxTz5MO58iUY8JaO7g8w>
    <xmx:jot7ZyWmSUaQGB4h5ILnDlTzF1LIIAWAqjjHS6aG6dWzRasz4hksDQ>
    <xmx:jot7Z0eNWsszjjUST_xY6TFGlpgJBKm7FloHNCq19pdw_ojNiRmKpw>
    <xmx:jot7Z1LfE1QEoPyZZ9NxcCocOoYPwD4Wr66DiRokVddK5rcrAGnvdCA3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 02:51:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 90f4ae7a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 07:51:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jan 2025 08:51:35 +0100
Subject: [PATCH v2 3/5] ci: repurpose "linux-gcc" job for deprecations
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-pks-remote-branches-deprecation-v2-3-2ce87c053536@pks.im>
References: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
In-Reply-To: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

The "linux-gcc" job isn't all that interesting by itself and can be
considered more or less the "standard" job: it is running with a
reasonably up-to-date image and uses GCC as a compiler, both of which we
already cover in other jobs.

There is one exception though: we change the default branch to be "main"
instead of "master", so it is forging ahead a bit into the future to
make sure that this change does not cause havoc. So let's expand on this
a bit and also add the new "WITH_BREAKING_CHANGES" flag to the mix.

Rename the job to "linux-breaking-changes" accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 2 +-
 .gitlab-ci.yml             | 2 +-
 ci/run-build-and-tests.sh  | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 32d35d2257812f02121b20c3cae342d626481553..46b96fb96cc6e2659fe0b4b640f7e671587d059a 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -269,7 +269,7 @@ jobs:
           - jobname: linux-reftable
             cc: clang
             pool: ubuntu-latest
-          - jobname: linux-gcc
+          - jobname: linux-breaking-changes
             cc: gcc
             pool: ubuntu-20.04
           - jobname: linux-TEST-vars
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b86bb0bdb3363e06e6fe4195c34babd67cf7e8cc..492e5d9082dbdb3389c173f2b5a45fe43f4bea41 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -43,7 +43,7 @@ test:linux:
       - jobname: linux-reftable
         image: ubuntu:latest
         CC: clang
-      - jobname: linux-gcc
+      - jobname: linux-breaking-changes
         image: ubuntu:20.04
         CC: gcc
       - jobname: linux-TEST-vars
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 2e28d02b20f2469afddc4e04fdbd18465babb1ef..2ccd812fb4e025be3b8e9ab2ec6ae44e92944ab0 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -13,8 +13,9 @@ esac
 run_tests=t
 
 case "$jobname" in
-linux-gcc)
+linux-breaking-changes)
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+	export WITH_BREAKING_CHANGES=YesPlease
 	;;
 linux-TEST-vars)
 	export GIT_TEST_SPLIT_INDEX=yes

-- 
2.48.0.rc1.245.gb3e6e7acbc.dirty

