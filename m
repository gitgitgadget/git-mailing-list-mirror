Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFEA1FA8E2
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915630; cv=none; b=f71gLt7Bc5LlypZhhqHXayKy1pZYvVHkar7OLEv7s8It6fNotyMf7WQdhS6dPBEq6c7N9FXHBDzCjE17o+jQ2S0w7Ypp414SJNdR99zplt1OSbz+5sjKMdwkXLEfzVj7nECUvSU0B8Ucepwgaqq/F1jTH3PGy3PHCmFiScK+Kb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915630; c=relaxed/simple;
	bh=hUUjoJVHhnbKX6Dve6xUtGl6aG8rwJz0j7IkToXzRYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CjmIyP7NDz50Kn4d/LAZp/k2cf9spNfNV0V2YyGb18PSvwRYopgne1hg+fmvqABBDauAAXAznCgpuWuEE443jZbwf+TXfcxNj/DnxyWKwWMEAQuNaCjj7//hQ3Wo/eKia+25WFrmIzckl9w7thlcfXfToyAHtsCbuL9aZnU9ifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lh/qyH+d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HQCfbOA3; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lh/qyH+d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HQCfbOA3"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 26B121380683
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 09:47:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 03 Jan 2025 09:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735915627;
	 x=1736002027; bh=GpnJSDHbCxx99UXaUbgN7iQj9dVJKT/I/QBjOvZZS80=; b=
	lh/qyH+dQRuPbIDZnEx/UtsAoA9lKHNhhXU88ltoKXONciBhpYdPW3Ji8HCe/2GS
	VkfdK1szD5xpsjTYYWDbwZrtGSQ+/GLq8lALWmfBfzhOdINrfWleouZPLMs9/k3F
	GBq1UJqgYltmVTlFGM117nqeu5FrNWrgzl5lErqmaxta3iVD4FYSfcfHPgg9Nq4u
	3T6U8xXD3ZRJHJYMvBdgUQLFCMw8NErvHIpvrOzErV8JTsnaE+JGMHddK1URJ1wT
	9ZrplxcX8OTTWXtCx/DRTmh7z0iHzLlqlpnpkCqEPuoM1HH7yhn/hZXBoJKePo33
	1NaBdAofOTQBoGLv1+VtHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735915627; x=
	1736002027; bh=GpnJSDHbCxx99UXaUbgN7iQj9dVJKT/I/QBjOvZZS80=; b=H
	QCfbOA303tbhCrt2BoMUsEMMVBftjos7jlpM5JOUM4i6ma63y+a8fjUiYY8FLNuj
	R6TUeFNX7zh7dp11bxL0Jnw2ZOt8xsTORIARq3I3Js/bAqASY1BvsWRPbG+1ZaY1
	4t49VizI1403JsaJHN5hJSuHJ8cWY2lIP0PuqtBfQSnYpbB2RR83ax+IIpzutRQh
	OOjA5xdGziF0EKi9HAvAcD+LXQgXtOFbg6YJ69Fkw43K9Hqtg7OpEPL+GIxiBP+G
	jzYgRI9hqFr7rOiN6/CGCAjvf2iksu5oy2z/JfiplfxR9ekPNuIXG1P4kEHmabCj
	gUvC1IOHrvy4a1nXwDtXA==
X-ME-Sender: <xms:avh3Z426_TI5cByEcniQnS9nix6m7OT80gut9dc63NoYRKc-Ec1xTg>
    <xme:avh3ZzE4lTPlihTYYic_B6cK7PWzU0cQuPzxI77A2Up-TwZesHsLZw4uAIoD6etpy
    l-cbtZzTdcC8LBlBA>
X-ME-Received: <xmr:avh3Zw5LkUmH1BIbY1TdTstA9IpcEeJSFLq2FXENlnM79BLN8WNSzpY_lPMh1UegFQiRdrQRKhWaRx7ijIVnjrEF5JU2uFSrIKdzQ5DTGXdpkJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:a_h3Zx31FnbCS7yD00qugWXJUfZGT7EdaASyMqAQjs-sjB12q-sUIw>
    <xmx:a_h3Z7Ev_kDVhV6bqBsm8Ap_5whpLtGg_uwagb-sv0AJ_sZoCIsYfw>
    <xmx:a_h3Z6_wJQEuItlPpnOWu00yqNy-kahHFvcRvdt-xym0oUb0ZGh-mQ>
    <xmx:a_h3ZwlGVqk8FGZmHiRD2lp6A4QtJMYitnKOZng9MmbpwtzJmYfAbg>
    <xmx:a_h3ZxOnugZMo3SP-CR_jOCGPqMEPaUyQZc9yDFTZRV2jps4wmbY8VvR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Jan 2025 09:47:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a9eb20d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Jan 2025 14:47:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jan 2025 15:46:38 +0100
Subject: [PATCH 01/10] t0060: fix EBUSY in MinGW when setting up runtime
 prefix
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-b4-pks-ci-fixes-v1-1-a9bb95dff833@pks.im>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
In-Reply-To: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.48.0.rc1.241.g6c04ab211c.dirty

