Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCF41714AC
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508726; cv=none; b=krBGZ4+C/u6hmGrCxzAksHIpGPVoyiKKACFS84Y9miPxCQc5v0o4ZNTWmbRcK0vqLOATAgU8HdsY1WYDp2l0wubQB0/HT3kFKuYW5ycBWJD4GdoJ7JNRYNwSxPd3Y9xnfvWfdad1aKxKIHWxPZ0UEyYClsWsz11nxOYern89jQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508726; c=relaxed/simple;
	bh=WWC92ZoEIct9hgT478fYMZQxt8KV9UWVryGh7h/2YSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IDI8J5SKn/ofyOkhWa/frYw8hzTgDsWc6N8N04Gx36mSWSPTMkfFvWEmsUhjjr+Yw7SNKv4wslqconxXWKDYw1AqbGv5UiQw/wwNDf0N/D/T0gBGQd4AD2LJOmYyCCXANQDHVsfMI/dLCWxwxzd0fENvlYUm6AvKtEg8bMEj5qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tz0oFxEl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SE3ffNEA; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tz0oFxEl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SE3ffNEA"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E55A1114018A;
	Fri, 10 Jan 2025 06:32:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 10 Jan 2025 06:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736508723;
	 x=1736595123; bh=EVyQC1Mf+thTfICtgwfvmYoAQe/VwfHxyVSrKhDhtyM=; b=
	Tz0oFxEl4/2l9Ry/sFK7rhPc4jdz5DC7fBhuQKOWx+EgejwejjPYeh6RVfUcpV91
	meKl4gCTEqIKS4E2ltBN2PlsJNVt7T96y4tN1TdK/BjFl5zSiTx+EUdgZx0wTIE/
	H9ldZix5Op2+8Lnhov5dZ/lsyCcEAc0ZHQ66r1sllL8IThY+pc1SeXYUTzHZKeLc
	kn29V+eXfrSHdKAi9ki2QqqhWJ6apYoOi97vV2ZaredNMu5+3dgoZPRdz27a39ef
	QyBH0wXFhgWU/kcbQtkP9xCU9eLZNnuqmA/cBl1VrqNEqKxINfuW+YmgakcXAWsy
	yKnnbX8CEu5ws7U+8cL8fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736508723; x=
	1736595123; bh=EVyQC1Mf+thTfICtgwfvmYoAQe/VwfHxyVSrKhDhtyM=; b=S
	E3ffNEAaFYEAo1YuOmPNP6CJNz9rixmze0LrIf+nXiItBcM3C298fOIghJbFNTyp
	TkchqUhyz1qnDEGWOhsXFWeWDU/u+W7fIGaAEBhBqodEL3R+kpMk5QsTYKIglmg5
	OIkGpZqKXqz0M69LZbvghzM1Qr/Tz4gWatEcejYj7KxflqWDb1Ew5gm89735wojS
	UElPrU9S/zX9f5pKti0IAvmFmF9k/JAVSSR0pckh2qX2nnzoP8bCPWEqBzfqBJUg
	vDWAK7PQyfYwluPwWux8D0myrhVlLPpB2f5UZ6r62ZyIxG2mXA6KCAUWb3HU6KK5
	ouTYC25wnChe9UxuefShg==
X-ME-Sender: <xms:MwWBZ0leNSpaEv-vbzG5HqnMgnZGwI_QDQsLWmJiC_GNXKwMTQ55QA>
    <xme:MwWBZz3XsGyybqJU5e91Y3Yv3qoowKBZJPEEoCaO6SFK979TId7a-YCyT3CqObds0
    NvmNMVm_JtYJraEmg>
X-ME-Received: <xmr:MwWBZyrLSHIOHW76o1BdYGBUJpkjYtDnyaihubdAJ6Lel4rsYQ-8gnQHxvcWceJejGCZfh16gx8HhJHpcALgx1IAX5fUT5ARkTiD0MeziRzUDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MwWBZwmpIQuEJ70UFhRGn7fSIm5GgNEbm1r54v9GII9y9RHSLzm2Gg>
    <xmx:MwWBZy3TwtmJPjx06JDv1im0oXcv4JfjiDuYGWao8Q_2lynlIeQBMg>
    <xmx:MwWBZ3v0EPa1lEfJOXD9WCwQGejSaNQ62VkPsC0f5GUi_rJsCd4amw>
    <xmx:MwWBZ-Ur4H5_CefNAB8IXgrEt5S-ejibgmsTY2VUu5KDtMaQCAEuFQ>
    <xmx:MwWBZ1RyM35lN22Lq9QdTCWRIF76bY9do1tmhKXmD06SpohnL01m_XMl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 06:32:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cb0f295d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jan 2025 11:32:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jan 2025 12:31:57 +0100
Subject: [PATCH v4 01/10] t0060: fix EBUSY in MinGW when setting up runtime
 prefix
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-pks-ci-fixes-v4-1-6e4613446080@pks.im>
References: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
In-Reply-To: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.2

Two of our tests in t0060 verify that the runtime prefix functionality
works as expected by creating a separate directory hierarchy, copying
the Git executable in there and then creating scripts relative to that
executable.

These tests fail quite regularly in GitLab CI with the following error:

    expecting success of 0060.218 '%(prefix)/ works':
            mkdir -p pretend/bin &&
            cp "$GIT_EXEC_PATH"/git$X pretend/bin/ &&
            git config yes.path "%(prefix)/yes" &&
            GIT_EXEC_PATH= ./pretend/bin/git config --path yes.path >actual &&
            echo "$(pwd)/pretend/yes" >expect &&
            test_cmp expect actual
    ++ mkdir -p pretend/bin
    ++ cp /c/GitLab-Runner/builds/gitlab-org/git/git.exe pretend/bin/
    cp: cannot create regular file 'pretend/bin/git.exe': Device or resource busy
    error: last command exited with $?=1
    not ok 218 - %(prefix)/ works

Seemingly, the "git.exe" binary we are trying to overwrite is still
being held open. It is somewhat puzzling why exactly that is: while the
preceding test _does_ write to and execute the same path, it should have
exited and shouldn't keep any backgrounded processes around. So it must
be held open by something else, either in MinGW or in Windows itself.

While the root cause is puzzling, the workaround is trivial enough:
instead of writing the file twice we simply pull the common setup into a
separate test case so that we won't observe EBUSY in the first place.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0060-path-utils.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index dbb2e73bcd912ae6a804603ff54e4c609966fa5d..8545cdfab559b4e247cb2699965e637529fd930a 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -592,17 +592,19 @@ test_lazy_prereq CAN_EXEC_IN_PWD '
 	./git rev-parse
 '
 
+test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD 'setup runtime prefix' '
+	mkdir -p pretend/bin &&
+	cp "$GIT_EXEC_PATH"/git$X pretend/bin/
+'
+
 test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD 'RUNTIME_PREFIX works' '
-	mkdir -p pretend/bin pretend/libexec/git-core &&
+	mkdir -p pretend/libexec/git-core &&
 	echo "echo HERE" | write_script pretend/libexec/git-core/git-here &&
-	cp "$GIT_EXEC_PATH"/git$X pretend/bin/ &&
 	GIT_EXEC_PATH= ./pretend/bin/git here >actual &&
 	echo HERE >expect &&
 	test_cmp expect actual'
 
 test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD '%(prefix)/ works' '
-	mkdir -p pretend/bin &&
-	cp "$GIT_EXEC_PATH"/git$X pretend/bin/ &&
 	git config yes.path "%(prefix)/yes" &&
 	GIT_EXEC_PATH= ./pretend/bin/git config --path yes.path >actual &&
 	echo "$(pwd)/pretend/yes" >expect &&

-- 
2.48.0.rc2.279.g1de40edade.dirty

