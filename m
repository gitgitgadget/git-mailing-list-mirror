Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9EB1D61B9
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 07:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864772; cv=none; b=B7cIK6G5fZsD+IJYq5AAErK2KCawr86fOqtyUCGuJUZ1aSy539eTNW0yQlAMHtOWmVt0rwFtYTYPzFohBTej/xK1fAkkma7+AYSMuFlyYGn7Sh5TCPOTmCr2I6HKF6VtN5XDn2qOuyZhSE+Qqcf8iSjxPYG6aghQ8wzZKn2VmP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864772; c=relaxed/simple;
	bh=HFQWyZjRhwHglC3UhVOgAr7YOWEKQdQgU17NhNA0iyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l7bGqy4hw97xlNFjH0IznGD4ZTNZcotHkHYEBNbENS9auprk6qRhzJhyG0fkB3IatzVxFAGh5s7m7OClqpdctYrYIFLLdndmRiZKUvtBo87taJhDiBfRYC0J1rCU1z54iqD8QFrGQQGl2US49xUpeHGYMHJFvVu74BjAujfCQtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kKV092dF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=slCG0Zkw; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kKV092dF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="slCG0Zkw"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D21CE1380A36;
	Tue, 18 Feb 2025 02:46:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 18 Feb 2025 02:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739864768;
	 x=1739951168; bh=vgt4wMFS1iiz6IOHy6D6csP0Vz64K+GXFckqy38ABfE=; b=
	kKV092dFeaRsnVExNSb73Vqfb3KaIUSi/Ng9NGpc1ykL6OCSAGxmRIOeCTn5xIYj
	lmBkjM4MxLe6ibWyzNA8XvpKdt9ujaWFoX6mUs8Hqp7H4FTmsTREzv4feRTrZxg1
	b8gSJ6IyKNB8bb+kuF1rcivRKmZxXG8BR+i6tXbx1+R4uHT6veqf77jECmWoh77b
	7Zj0nLbkVPsTtpcqq61VHgGfHscb6n4KzyWXnzIbZWAJ+nkL+LWH/h3tcix7xsn8
	dXa2Xx18sukXqCIwXYAMSo8yMY9Tfc+NoVZlmTfBCA6FADTkREc3vede3gsWdZAf
	KnHK9Jft6lWYsMHCWKI+jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739864768; x=
	1739951168; bh=vgt4wMFS1iiz6IOHy6D6csP0Vz64K+GXFckqy38ABfE=; b=s
	lCG0ZkwZACF10Fnpfowat35JbTRt4OUkRt5RBUNyDQnD69MO3g/FpGZCGM9GPSAz
	FnCKK+9EnhWaCi3el3tVrJ13heULSlEe0N2JXaOUsjCcvD3dFWG0phmjX6t7A7Ov
	hDllUcR5FxzuQsHJVm+oj/6PIvmSfcWn965AQz0IwdLCRGh/Vw4Axx83T4lZd90j
	i4d7yV8/aOqV61rMQa1pE36oLW7MU8sIvsXkLyQ9NFFLWehepdPhWIex+OdqbhCE
	heu9EWrkBqGYcTykuDVeskbsvDsJ1E8/GJyuQRK6YpPIrk5hfpCDn0NbmOPeT73Y
	V6J7XpZUuT6ywBZA6S2+g==
X-ME-Sender: <xms:wDq0Z5Ettn9d6y-YfRjuexyfTVFAnX8me5Kyv6NpOB16w0OUIxIA1A>
    <xme:wDq0Z-XIIxXArd8V1TYgXIlfd_oBwKMCa_DynfHy0u49XAYHuWVGLck1oQEO76vBr
    NFQkz5sDNinivtrtg>
X-ME-Received: <xmr:wDq0Z7KfNuefmk9Z5WRgPLiWaJyhGqdSiFXCjstuuKnX22brC1tjWT1N7xfA-SGiy1EgTRCczVBzk3LSlbcL4WZO_wU1IY8h_1D7Q_ypoy7Uz8XX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wDq0Z_FWt14RWmC024OSCny_Bjti6MancQH6F_6SoY791SIT8DeIRA>
    <xmx:wDq0Z_VOnGwg-bPkJFAVujmIe4w1b2pITMiXmD4qd8NCkqknRORopg>
    <xmx:wDq0Z6NYQG4UrZl2l_M9iEkxeK2FiqkfoIiWpafwcXOgoz2JrA0Q6Q>
    <xmx:wDq0Z-3A6UNrBOZTcSQAWGnqWY8G1GWFxg3SzUZs-L5ue7DD4X9Dvw>
    <xmx:wDq0Z8hlZGaOf_-2RaA0s6HdoMhD5v1lhp1vhm-YUlrVhjhURgYGa8JJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 02:46:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3b22e35c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 07:46:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 08:45:50 +0100
Subject: [PATCH 02/12] contrib/credential: fix "netrc" tests with
 out-of-tree builds
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-b4-pks-meson-contrib-v1-2-c3edd292beb8@pks.im>
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
In-Reply-To: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>
X-Mailer: b4 0.14.2

Tests of the "netrc" credential helper aren't prepared to handle
out-of-tree builds:

  - They expect the "test.pl" script to be located relative to the build
    directory, even though it is located in the source directory.

  - They expect the built "git-credential-netrc" helper to be located
    relative to the "test.pl" file, evne though it is loated in the
    build directory.

This works alright as long as source and build directories are the same,
but starts to break apart with Meson.

Fix these first issue by using the new "GIT_SOURCE_DIR" variable to
locate the test script itself. And fix the second issue by introducing a
new environment variable "CREDENTIAL_NETRC_PATH" that can be set for
out-of-tree builds to locate the built credential helper.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/credential/netrc/t-git-credential-netrc.sh | 2 +-
 contrib/credential/netrc/test.pl                   | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/contrib/credential/netrc/t-git-credential-netrc.sh b/contrib/credential/netrc/t-git-credential-netrc.sh
index bf2777308a5..1b7b8b3a9aa 100755
--- a/contrib/credential/netrc/t-git-credential-netrc.sh
+++ b/contrib/credential/netrc/t-git-credential-netrc.sh
@@ -15,7 +15,7 @@
 
 	export PERL5LIB="$GITPERLLIB"
 	test_expect_success 'git-credential-netrc' '
-		perl "$GIT_BUILD_DIR"/contrib/credential/netrc/test.pl
+		perl "$GIT_SOURCE_DIR"/contrib/credential/netrc/test.pl
 	'
 
 	test_done
diff --git a/contrib/credential/netrc/test.pl b/contrib/credential/netrc/test.pl
index c0fb3718b28..67a0ede5644 100755
--- a/contrib/credential/netrc/test.pl
+++ b/contrib/credential/netrc/test.pl
@@ -15,10 +15,11 @@ BEGIN
 
 my @global_credential_args = @ARGV;
 my $scriptDir = dirname rel2abs $0;
-my ($netrc, $netrcGpg, $gcNetrc) = map { catfile $scriptDir, $_; }
+my ($netrc, $netrcGpg) = map { catfile $scriptDir, $_; }
                                        qw(test.netrc
-                                          test.netrc.gpg
-                                          git-credential-netrc);
+                                          test.netrc.gpg);
+my $gcNetrc = $ENV{CREDENTIAL_NETRC_PATH} || catfile $scriptDir, qw(git-credential-netrc);
+
 local $ENV{PATH} = join ':'
                       , $scriptDir
                       , $ENV{PATH}

-- 
2.48.1.666.gff9fcf71b7.dirty

