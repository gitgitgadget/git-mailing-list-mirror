Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4599C1E9B39
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736253053; cv=none; b=cMssfJ2M+qZOppRLj9dtERNiy+j9TarYU5QRHrOQROqpG7x6/ctpv1cmxm+tTIrqWUhdNszt1XHflO4h3htOIkedg8JjGdMnk/Nwexw9BLdAH5nOWRXJrRiurs4GSFM2SVE/IiQjpxLHpuv2wAkZV1HU+Av0FQcpaYJNmWaOczQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736253053; c=relaxed/simple;
	bh=z2yXrFIIx/kzY+XRyEzDmzKJ2mEeomjwJNLuoJsBiHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r2+sOvuTQUQ7pXtDph0M4HQDccj6o6G+rqZa2CGjBRDKO2mKuJFGmQ5B6aJFyZmdN7EfwqYG4u5+w9PXBEiwGGdK9QoZCCbLj7q9ANfYH3B5QHfMVCXxc1Exn3I0S8hhBQ62pOG+JPR3GY30umSratIw+3q2FbHDzLicrL624Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q8LIHokh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p9QX3JJR; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q8LIHokh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p9QX3JJR"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 227BA1140156;
	Tue,  7 Jan 2025 07:30:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 07 Jan 2025 07:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736253049;
	 x=1736339449; bh=xDGWAlUYMLnmvk9Zdzu5+T+r+PHSVzDC+gN0Cds64ls=; b=
	q8LIHokhPODuhjDbAd+amAVSK4TKIIBaTKWxR+WASXKSLwhwNJ5PZQoJXMA6Xiw9
	Tv/kYtFtvGm3FMqsljLSeSyy+5bCC7j37GXL7k2KZ6wCa2aocddVqFjTIrAWa21W
	/zudYCHRZjyGIoNyQYi7p1CHUk2MzbDe9wtRaLo+La0z31+sHsMui1KbifaYVWaJ
	UbfUrocFdJL9x8JPJqFN8s5e29lZ2/myTiR/LUTmZ8iv2s0wxXyG/drlnYeO9MI6
	k+aw7Qdcw1uGCMKqj9OBMd2kWBcXuUKpdhFbHjQYqPDFb6otEz4Ge/mBZ3cRn2Z1
	82cyiRgHeQhQjDAnRwWafg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736253049; x=
	1736339449; bh=xDGWAlUYMLnmvk9Zdzu5+T+r+PHSVzDC+gN0Cds64ls=; b=p
	9QX3JJRmunqotLuOfee73B6M5aeEUbeoioTrEDgE2iGjLQ7WhEgkyIDhX9hVUXSG
	rQZz7YlVgVV4NdgGxorQXR2mf3o0hNHpTTrKM8Z3Vy3jHqS5YiKfMd54qxdYFpY2
	FrTX/C/cdsGQucfKb4VkKKO9goI4pLLsSYOXmgEK4Nbx2dpaKKjVAkB4enBzjV5G
	dRAN8EUxU7TynIZzDdO2qhLMIIFnkFN35OzmweGQznIyc9pa8tNrzzkuyoYbwJud
	uPfzP92WuynfdXWYzqRdbo9KuLQZdf2PN4jVH4Rwja5fLfyilA/tDf4lNT0HSdXg
	BF0n5lCuu+RyUPCChxjfQ==
X-ME-Sender: <xms:eB59Z9TjaWygdxN-IoRYgDwVZYZ0-X2CiIag7C86S9HF8WohsJQ_rQ>
    <xme:eB59Z2yVLHMbluV5RflNYdF0eSQpf3_ZSXxcMP2YLRyEfhds99BeIWDAp9SfEEzQz
    -qEbApNoyLFIbZ_EQ>
X-ME-Received: <xmr:eB59Zy3_KnflNs6k0AGFIo4MWjSHCYv-jg7nP2fWNwm-03OvOj0i8WtT2nqPJzeZRbRuoUIlpLCaGyZK7BImseD7hR-fTMJCA7Q-YiZKeAouYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgfeelucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:eB59Z1CA8OYbtJyY9u_JpHNToneyDGSoKYy-0G3bbjnHTKBB0ItMfg>
    <xmx:eB59Z2hGsk104NEGZMhIKZWc92qg8O5OCde5CuegaDGDhElix2fgTg>
    <xmx:eB59Z5oG8NhdK69z7FAOCjNYAVaC1GIVHdER9KgjYc3jF90bVQjfKQ>
    <xmx:eB59Zxi9thgrFAmN76WcdwrfR8cqjB8LSwjk9hK1Hioxu42wyEWomg>
    <xmx:eR59Z-fWaUDCN3WVxEYxB7rcq4E0kvE2LvLzqT-lmpFu9AiPW4428sg2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 07:30:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 69a23767 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 12:30:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jan 2025 13:30:43 +0100
Subject: [PATCH v3 01/10] t0060: fix EBUSY in MinGW when setting up runtime
 prefix
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-b4-pks-ci-fixes-v3-1-546a0ebc8481@pks.im>
References: <20250107-b4-pks-ci-fixes-v3-0-546a0ebc8481@pks.im>
In-Reply-To: <20250107-b4-pks-ci-fixes-v3-0-546a0ebc8481@pks.im>
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
2.48.0.rc1.245.gb3e6e7acbc.dirty

