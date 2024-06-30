Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCF14D8C0
	for <git@vger.kernel.org>; Sun, 30 Jun 2024 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719783241; cv=pass; b=I7KsoAh3WN7b/pI3SqWHEA0BEY++clIS+K0UbUKjbOU/lw90nR6UHRZ8usd4gu4Ii8mP3PdXZPa71am1NsHdzXNl/JmMASRW2F4U2HWHu3FjU0gneHgiBq3aprCENBx8/Dvg73egc3/yCZTjmRCSRg6D1TLPZWL3mOjtrEcXoqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719783241; c=relaxed/simple;
	bh=pVlB+9gKjf0seZ//k/4se+cjewKEXONKg4WiLxa1qeM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=daV1s3KLP2QBpdFzcxfyLhNP0KChw+/tysU0pdQOKV0pDUVYujQubko5DUWv18R3nCBPMSjJ7brrgV7KhJ1Y4LsolP9QQ1nfU820b8lv6FeMrDTFHNk+pJVLJx524pv19KwotZaA1/+hXsYy3kUckIZjqgTkv8EJq1WHlA8zWBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=mTC+yw/S; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="mTC+yw/S"
Received: from localhost.localdomain (unknown [IPv6:2001:1ba8:120c:f201:e842:876:cf00:268])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mikko.koivunalho)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4WC2VS0Spnzyb5;
	Mon,  1 Jul 2024 00:33:52 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1719783232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FR499vg9BrCgWoctGbNKJOP1OKBe1kCeckfLuABgFI=;
	b=mTC+yw/S5bVZFAQWub8znrF/931ODbJNuI1YzDGR3zU0ANr6e38MB3RBwlV4fJf9aknA8w
	KC2QoZgFxrHddAPow92iGwmI1wunqQYBbU0/7wYr6hZJhFcKd61ebI+y78HZlp2aG50Xxi
	ELPEu9+PeedZbJvDCHVMxPwwHaamLgU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1719783232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FR499vg9BrCgWoctGbNKJOP1OKBe1kCeckfLuABgFI=;
	b=rE7JQzUFjVMwzNuViQmxAJk7VS+SGwgGdNp1nuoYahHKL6B0A7a+8Nrnni47SOJJD4NBfg
	GUTKgpGNELIxItkAh2sqIBZ0mCyt2rqMX3QMCCm2WlDoNEi76fY+42yGNOqMlozHLxrqFG
	6uKbZyXeZ0cspoqcKaif59TNdk+s6zY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mikko.koivunalho smtp.mailfrom=mikko.koivunalho@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1719783232; a=rsa-sha256; cv=none;
	b=WPRnN49pAp056hWrOuaYtwN9F60kCrcG1b2J+Lt9EK7fGF78cuT4sjFlwe1T3oI7s8W2Ny
	3ESLkC00+yQQDsYKs35qv9f3jW0pCCdYKUOPmObOCcIApNtvqzYyxkb0NvmWzxyS6uYeWA
	mOT4hSpEXE94X+YNUPakJGr49hOpboU=
From: Mikko Johannes Koivunalho <mikko.koivunalho@iki.fi>
To: git@vger.kernel.org,
	Mikko Johannes Koivunalho <mikko.koivunalho@iki.fi>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Roland Hieber <rhi@pengutronix.de>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 3/3] completion: Add hook in Bash completion for commit message; tests
Date: Sun, 30 Jun 2024 23:33:36 +0200
Message-Id: <20240630213336.2212166-4-mikko.koivunalho@iki.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240630213336.2212166-1-mikko.koivunalho@iki.fi>
References: <20240630213336.2212166-1-mikko.koivunalho@iki.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mikko Johannes Koivunalho <mikko.koivunalho@iki.fi>
---
 t/t9902-completion.sh | 68 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 932d5ad759..4ea80fddd2 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -146,6 +146,74 @@ else
 	ROOT="$(pwd)"
 fi
 
+test_expect_success 'setup for commit message completion' "
+    commit-msg-callback-function () { echo HelloFromCallbackFunction; } &&
+    printf '#!/usr/bin/env sh\necho HelloFromCallbackExe\n' >.git/hooks/commit-callback &&
+    chmod +x .git/hooks/commit-callback
+"
+
+test_expect_success 'git commit --message= (empty)' "
+    test_completion 'git commit --message=' ' '
+"
+
+test_expect_success 'setup for commit message completion (run a shell function)' '
+    git config --local completion.commitMessageCallback commit-msg-callback-function
+'
+
+test_expect_success 'git commit --message=HelloFromCallbackFunction' '
+    test_completion "git commit --message=" "HelloFromCallbackFunction"
+'
+
+test_expect_success 'setup for commit message completion (run an executable file)' "
+    git config --local completion.commitMessageCallback \"${PWD}/.git/hooks/commit-callback\"
+"
+
+test_expect_success 'git commit --message=HelloFromCallbackExe' '
+    test_completion "git commit --message=" "HelloFromCallbackExe"
+'
+
+test_expect_success 'setup for commit message completion (do completion in a subdir)' '
+    mkdir -p commit_message_completion_subdir &&
+    cd commit_message_completion_subdir
+'
+
+test_expect_success 'git commit --message=HelloFromCallbackExe' '
+    test_completion "git commit --message=" "HelloFromCallbackExe"
+'
+
+test_expect_success 'teardown from commit message completion (do completion in a subdir)' '
+    cd .. &&
+    rm -r commit_message_completion_subdir
+'
+
+test_expect_success 'setup for commit message completion (run an executable file with ENV var set)' "
+    GIT_COMPLETION_COMMIT_MESSAGE_CALLBACK=commit-msg-callback-function &&
+    export GIT_COMPLETION_COMMIT_MESSAGE_CALLBACK
+"
+
+test_expect_success 'git commit --message=HelloFromCallbackFunction (ENV var overrides config)' '
+    test_completion "git commit --message=" "HelloFromCallbackFunction"
+'
+
+test_expect_success 'setup for commit message completion (completion begins with quote char)' '
+    commit-msg-callback-function-with-quote () { echo \"HelloFromCallbackFunctionWithQuote; } &&
+    GIT_COMPLETION_COMMIT_MESSAGE_CALLBACK=commit-msg-callback-function-with-quote &&
+    export GIT_COMPLETION_COMMIT_MESSAGE_CALLBACK
+'
+
+test_expect_success 'git commit --message=HelloFromCallbackFunction (completion begins with quote char)' '
+    test_completion "git commit --message=" "\"HelloFromCallbackFunctionWithQuote"
+'
+
+test_expect_success 'teardown after commit message completion' '
+    unset -v GIT_COMPLETION_COMMIT_MESSAGE_CALLBACK &&
+    git config --local --unset completion.commitMessageCallback &&
+    unset -f commit-msg-callback-function &&
+    unset -f commit-msg-callback-function-with-quote &&
+    rm .git/hooks/commit-callback
+
+'
+
 test_expect_success 'setup for __git_find_repo_path/__gitdir tests' '
 	mkdir -p subdir/subsubdir &&
 	mkdir -p non-repo &&
-- 
2.30.2

