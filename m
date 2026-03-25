Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3022DECCB
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 06:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774419680; cv=none; b=r/4WX5Q6wQjWgCAdMcAFwn4iGntoVsZXdul9wG27HAod12WcMWSpeLink6miWHLq4udKheU3f0QZo7dAt7MNiH94y6fWt7vA6ofZbwVkcE0dxPMDh+p6joQTxJwHFOV+A2+aGfLgXu7ssOXZsnLpahagCyRLkib48b/5fP+eNHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774419680; c=relaxed/simple;
	bh=Bf0EAT2DGVlw1F+/iYgUhPh43dhoTevZHMOUY1aO110=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYUJMU99JBPOfgVh9QAe3HPxEBCycIzZbDztwdVYpGH/IC6YrWXmgjwDsZ5hMcvHQ1xPBkcIdbDr/R7PUH/MS3IwRxFESnSTnkkHf5uoO4l/BT6UKkVn28z3ChiElgBgxRjRJHlzjdFOtURyOhXHXOEJfVoZ6v0uTE5xYv6Lp7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O0kjDFvs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A9MYVCIg; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O0kjDFvs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A9MYVCIg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 441307A006C;
	Wed, 25 Mar 2026 02:21:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 25 Mar 2026 02:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1774419678; x=
	1774506078; bh=uF+qcMo2OlU7c+T6Y23Hepv0VcSNTPwrTGBHZ2rC/NI=; b=O
	0kjDFvsxYjj1WpUx0SViLZtezDvQNB7o8vo+iRasfkHC77DCJGNjG0NORoI0a8YX
	4TGSfJJJUcMfNQdcViWyyRdtPW5aBzvnf4Npf5iUH9S5x0bq/4uiStaphfaOSomi
	DUQEak7iF7AMioXRD9hgX8P2SOYZuWhvcYdZdv98oV3cYOAeAmSR03dIVHw1+YHL
	sQ5Pyu4VirI1+ZIKf4Rb2lh1YuMDPJy6DzwUTfEAjJ3AI3phEcFYbxcqDAJtGHep
	83Xm7pk/UWHW7zZW+SXAS+d+ABM/Z31lnX/BUXdoSV+0NYkhlTn+NZh1fHA1KDdh
	+jffwxLxT1jbUjN7wuoDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1774419678; x=1774506078; bh=uF+qcMo2OlU7c+T6Y23Hepv0VcSN
	TPwrTGBHZ2rC/NI=; b=A9MYVCIgVuVHssqGs49w2s22BqsY2JDcppPU396Rp5iT
	xWAL+oFUUCTPil/lsosH2y+Pg5anGzPann4Vhg2AGQhnmUVINzop77uh2rU5EOlK
	rb0ryjtKJXToarsikCpjzuS1m5krHRs5CfQ1Gzo1r1DXLTD8c5/UvRiUG8zJgy7O
	fhJGP+90YNYnafOrSEH4OiU2wbK1bCZqIPI5oZvOjZH7czjIlazexi5ybowW2dvE
	3JgbNHEhzUlQbMpM/E6PlyHt8pVRY0YrhW59BDy/moHzjHBO6b85geSSsZFKMeTn
	ge3JV2m21T7o/hLUEcFWv60AjHnx8pUNzElcIF+xag==
X-ME-Sender: <xms:3n7DaWEtsRNySKSOgSxnQN0dWMk5JfP2dYvdNaSAeZxKXpkukMtS4w>
    <xme:3n7DadUXNV3Nqh4NtioJQlxcXMRmeyUE_30VXC0uxVPzbJen-zBU8Psb_HTBs7aS9
    gqJTg-3UpfxWwsQ57zZLPD6KSrnZJ6t4rHy9mTf1NGAxyFeZte_u08>
X-ME-Received: <xmr:3n7Dadx5qUXxxRhL56l_GGxZx1zLhbPtHb2Tens7nNMf1wGblMf5oNtwsRfT_zw-b_MOdudgc_xRYBJaFVArwE-vN8MNS2pB-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:3n7DabPTTjNfpbAJuWqD7CVagoKoF0U3nlBeL7Nl1uj5blsstyCnxA>
    <xmx:3n7Dae5yjfdVfhuLjtU25XtyEZlYpXDzVKd14vDQmA7N55eQ-ONRoQ>
    <xmx:3n7DacOue3E1XIQt8NdNfYIZlONK85dLh8pXjTEPy0eeSb68SS7bNg>
    <xmx:3n7DaclNBYKckrMDvd3Xon8LWDP3WzehAvcFXF3QcuyiARG_6K2oJw>
    <xmx:3n7DaReA9fbjO197V7FLFU7w08mq_JFRcNKz35kvR9Dblo2L8ttYVEK5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 02:21:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 01/11] test-lib: catch misspelt 'test_expect_successo'
Date: Tue, 24 Mar 2026 23:21:04 -0700
Message-ID: <20260325062114.2067946-2-gitster@pobox.com>
X-Mailer: git-send-email 2.53.0-886-g529cbd14ff
In-Reply-To: <20260325062114.2067946-1-gitster@pobox.com>
References: <20260325062114.2067946-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to catch mistakes like misspelling "test_expect_success",
we would like to eventually be able to run our test suite with the
"-e" option on.

All tests dot-source "test-lib.sh" as the first thing to do.
Starting the script with "set -e" immediately reveals one place in
the test framework itself that is not clean.

The test framework runs "$GIT_BINARY" without any argument. We
expect it to exit with status 1 (i.e., "git<RETURN>" that spits out
the list of common commands) as a sign that we have an instance of
Git that we want to test.  We cannot quite say

    git
    if test $? != 1; then you have not built git; fi

as the first invocation that exits non-zero is caught with "set -e".

Work this around by rewriting the construct like so:

    status=0; git || status=$?
    if test $status != 1; then you have not built git; fi

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 70fd3e9baf..a2aa97fba3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -17,6 +17,9 @@
 
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in 'trash directory' subdirectory.
+
+set -e
+
 if test -z "$TEST_DIRECTORY"
 then
 	# ensure that TEST_DIRECTORY is an absolute path so that it
@@ -143,8 +146,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 ################################################################
 # It appears that people try to run tests without building...
 GIT_BINARY="${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X"
-"$GIT_BINARY" >/dev/null
-if test $? != 1
+status=0 && "$GIT_BINARY" >/dev/null || status=$?
+if test $status != 1
 then
 	if test -n "$GIT_TEST_INSTALLED"
 	then
-- 
2.53.0-886-g529cbd14ff

