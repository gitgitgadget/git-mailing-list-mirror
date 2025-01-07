Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A411EE032
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736253053; cv=none; b=X/lqVYsnNv7OGgZV5v4ckMGMISTQNqfNZpXkwhgsVfvxCwO6AZ/JPGHrWmfJMIesGQQVDivsw9yPTp6De/00/lWZtQedWZ5SO3Po4aA3Gho1ykPY9TTgdW8wdYuci69/5WdepwiudbVifmhQlRXsI9vnjc8Qo3RkW81c3r+F5pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736253053; c=relaxed/simple;
	bh=l/ozMFbaoGA8t/6v6INXRzM7GJLpdGpr45Pg6+yR1gQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fOLM3BrdNfq2AP5Z8t1xgAlZd7wg2GxaDQRMTQlUaPnGA20cDSHPMsbukNnQAsN/396NMhcHJtjJ5jNpFV/RfiEroJ5DjZLSmrZv7uld6iYCYic6eMV7/4q6H4L3VwiDDNNeCdvdnQwVlSFpUZb7elXg/zip5mamz1AveODO/98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MssWOGFo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BlkEJhta; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MssWOGFo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BlkEJhta"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3B1C313802B8;
	Tue,  7 Jan 2025 07:30:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 07 Jan 2025 07:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736253049;
	 x=1736339449; bh=Jz2ghC/bGZoaciTKmW8i+4e+adnEso/CGbXgcme7PSw=; b=
	MssWOGFoRP56liMwYQTJW8L4qDXBaK+AxPZBq0KaY2CcJjQcOyTBUkVSXX/Vwj8r
	76Uf1XYu+ypAeB7fwcIOkSXuIZ2/OwDVxDgrf3nRgJboUEj+f8Sz+V/AZ9gYw0/6
	Im9zCOWrutHEy5nEQOWi1l9cmAVyLvxNMb2hbSrzuXGCDICU9hb+625SiRrK7gEJ
	hGOg98t7oZNihu0b+oL9DGGxYcQNaYwkQQUdNDJMjI/nmxwPy4892rUQe97UzpDB
	4/vFS/xrFVpLRY1jNsgeLMM6dm8zvfR0jpOFxpREZ7AU8cOtymV9JGYDujtRWHMO
	/EiYjAj3+Zy1cuOeEKtY/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736253049; x=
	1736339449; bh=Jz2ghC/bGZoaciTKmW8i+4e+adnEso/CGbXgcme7PSw=; b=B
	lkEJhtaxxwYY0K1Dyki8f6syX8hJQrUg0tyl6cJuiDLReRirx7OXwttGB7+Qe4bE
	3wzQm4vMIcmDqwqQuys8yuc/nhSD7q3dVWtftGrQyswdkgeza/nbTqA+ywwCWDoF
	S5F+G2ixiE2VXgoxZIgGiXgjzb+gOVW7ia0bzHf10csJvZr5zStadgT91NDrnn/p
	6+BTMOyCoiSyf7IvaiWaLuDy22Iah/XohWoHpWXaFlZZ+p3+3hN9qwxJnZLpyEST
	G25//llG6VpHsY3EljvIxQ+42BctxHAuNlYuHAyZGyXyxO3xyLO2XfMwSeTvoa1t
	gRitqDpN8HopFxS0uRQjA==
X-ME-Sender: <xms:eR59Z82BSmNf1ld9NGbQigvNhR3dByhuhusYTjIHJLeEU4UmSkjWlg>
    <xme:eR59Z3GOSe5ZUNB4Cdm4g6YlGTtGPQae3if6Ca8Bb9Yoxx7PgkmGDNommjgieSz6C
    GfwLX2T6dU8wc5ZuA>
X-ME-Received: <xmr:eR59Z06E19C6L2MCPGRO-gLrKzPHtiIwJmoRBCTQvqun4WopXX0HoA7ZL1tCXvB5QPupMueCnFYdDbm9jFPA7YRJNzdcvZhBG0luIZqAMRILXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:eR59Z13VbG25jFBkZTrfFgz1EjOTtZMgpnHMxoaq4THRzQqQqCOR3g>
    <xmx:eR59Z_EqCPP3uM0K4OUC0e0tgmiIOJBtfUVeZ2UcaydNS7DnUVDjRQ>
    <xmx:eR59Z-9qIeao3PrBiJDUYf5ogVX62DKOvTCHf_SOBAlEMfgZAR5Xvw>
    <xmx:eR59Z0nTPkse9Xce9TDdqp_r-zeJxq3lY9lYCGgQBUe_a5NQFzZJIw>
    <xmx:eR59Zzgi0u3KOcuhFG5g_p8Obe_0HUGium20SHAQGd9ObU5is56D6qHk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 07:30:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 11b90111 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 12:30:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jan 2025 13:30:44 +0100
Subject: [PATCH v3 02/10] t7422: fix flaky test caused by buffered stdout
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-b4-pks-ci-fixes-v3-2-546a0ebc8481@pks.im>
References: <20250107-b4-pks-ci-fixes-v3-0-546a0ebc8481@pks.im>
In-Reply-To: <20250107-b4-pks-ci-fixes-v3-0-546a0ebc8481@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.2

One test in t7422 asserts that `git submodule status --recursive`
properly handles SIGPIPE. This test is flaky though and may sometimes
not see a SIGPIPE at all:

    expecting success of 7422.18 'git submodule status --recursive propagates SIGPIPE':
            { git submodule status --recursive 2>err; echo $?>status; } |
                    grep -q X/S &&
            test_must_be_empty err &&
            test_match_signal 13 "$(cat status)"
    ++ git submodule status --recursive
    ++ grep -q X/S
    ++ echo 0
    ++ test_must_be_empty err
    ++ test 1 -ne 1
    ++ test_path_is_file err
    ++ test 1 -ne 1
    ++ test -f err
    ++ test -s err
    +++ cat status
    ++ test_match_signal 13 0
    ++ test 0 = 141
    ++ test 0 = 269
    ++ return 1
    error: last command exited with $?=1
    not ok 18 - git submodule status --recursive propagates SIGPIPE

The issue is caused by us using grep(1) to terminate the pipe on the
first matching line in the recursing git-submodule(1) process. Standard
streams are typically buffered though, so this condition is racy and may
cause us to terminate the pipe after git-submodule(1) has already
exited, and in that case we wouldn't see the expected signal.

Fix the issue by generating a couple thousand nested submodules and
matching on the first nested submodule. This ensures that the recursive
git-submodule(1) process completely fills its stdout buffer, which makes
subsequent writes block until the downstream consumer of the pipe either
fully drains it or closes it.

To verify that this works as expected one can apply the following patch
to the preimage of this commit, which used to reliably trigger the race:

    diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
    index 3c5177cc30..df6001f8a0 100755
    --- a/t/t7422-submodule-output.sh
    +++ b/t/t7422-submodule-output.sh
    @@ -202,7 +202,7 @@ test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE'
     		cd repo &&
     		GIT_ALLOW_PROTOCOL=file git submodule add "$(pwd)"/../submodule &&
     		{ git submodule status --recursive 2>err; echo $?>status; } |
    -			grep -q recursive-submodule-path-1 &&
    +			{ sleep 1 && grep -q recursive-submodule-path-1 && sleep 1; } &&
     		test_must_be_empty err &&
     		test_match_signal 13 "$(cat status)"
     	)

With the pipe-stuffing workaround the test runs successfully.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7422-submodule-output.sh | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
index f21e9203678b94701281d5339ae8bfe53d5de0ed..023a5cbdc44bac2389fca45cf7017750627c4ce9 100755
--- a/t/t7422-submodule-output.sh
+++ b/t/t7422-submodule-output.sh
@@ -167,10 +167,45 @@ do
 done
 
 test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE' '
-	{ git submodule status --recursive 2>err; echo $?>status; } |
-		grep -q X/S &&
-	test_must_be_empty err &&
-	test_match_signal 13 "$(cat status)"
+	# The test setup is somewhat involved because triggering a SIGPIPE is
+	# racy with buffered pipes. To avoid the raciness we thus need to make
+	# sure that the subprocess in question fills the buffers completely,
+	# which requires a couple thousand submodules in total.
+	test_when_finished "rm -rf submodule repo" &&
+	git init submodule &&
+	(
+		cd submodule &&
+		test_commit initial &&
+
+		COMMIT=$(git rev-parse HEAD) &&
+		for i in $(test_seq 2000)
+		do
+			printf "[submodule \"sm-$i\"]\npath = recursive-submodule-path-$i\n" "$i" ||
+			return 1
+		done >gitmodules &&
+		BLOB=$(git hash-object -w --stdin <gitmodules) &&
+
+		printf "100644 blob $BLOB\t.gitmodules\n" >tree &&
+		for i in $(test_seq 2000)
+		do
+			printf "160000 commit $COMMIT\trecursive-submodule-path-%d\n" "$i" ||
+			return 1
+		done >>tree &&
+		TREE=$(git mktree <tree) &&
+
+		COMMIT=$(git commit-tree "$TREE") &&
+		git reset --hard "$COMMIT"
+	) &&
+
+	git init repo &&
+	(
+		cd repo &&
+		GIT_ALLOW_PROTOCOL=file git submodule add "$(pwd)"/../submodule &&
+		{ git submodule status --recursive 2>err; echo $?>status; } |
+			grep -q recursive-submodule-path-1 &&
+		test_must_be_empty err &&
+		test_match_signal 13 "$(cat status)"
+	)
 '
 
 test_done

-- 
2.48.0.rc1.245.gb3e6e7acbc.dirty

