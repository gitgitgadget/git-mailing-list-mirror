Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3AC37F014
	for <git@vger.kernel.org>; Fri,  1 May 2026 23:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777677328; cv=none; b=LSbrHE1ZTd9IjzHlBez0HY0uVzrzqVmupe+/r0CuSmAIB7+mmJsjeoeagrfJL8prwDfXsyOUjxibvhehjYbh3ugWF89LgNUolY80VqBrk9PNN8x0ii3LiZqJHa8kbbRR+piPEpPl4nBb5HCw7VfZxz6qHkH1BL2nzDExUad8QNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777677328; c=relaxed/simple;
	bh=XRwXDg3JGji9hMytFCJOznjp2qNUGJJe7kXyIiafDes=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=WFxYqPM00x3VBFUX/NA8NSX9VoXSCOL0XR3N4+CtfRjFFB3zvQgbTysaV8kc9pMigSw2uOXPrykoDc7nLwSOLqboZ6SqdownF3uuk5XCCsEaDka1PwvkxaOoa8X1D2LcfOsrVOE52xQyaIdzudMb6qUdgzyBomhLa0Z4BQimIuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WM6kuS8W; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM6kuS8W"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2d832f2f44cso2320458eec.0
        for <git@vger.kernel.org>; Fri, 01 May 2026 16:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777677325; x=1778282125; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdKnDal4ATo3dq5FFQY8RgWergrIXZOKUxyoosrtMe4=;
        b=WM6kuS8Wobt2YILXdsjdbTUoMvcEnB35KFsnpVeamSHsdeIGFEtNT0k0gOHkgr7u7y
         xdWECh5ZiIjKMR0h9aJ9tValOYUITogB6HDYBQ9sEIoEx7f5RJGoCziQU8J6BPFgG2KY
         eM8Me3DzKn8o4ba28PcSzcrMD3RLwgXz2sDuXA7oFNIVbZGiW50rCNNpAdMopKD61mzm
         jlUcxRTYrSILP6nME5gz59vV5swLEHiqPujW9opjOKZbBpg2hlM0dZcNr/xbYYX0r70w
         ZqbF2fKSTbQOSx3kFAeYPozeqAAq85Vn795M7LYhMniIk2bKD95r5gBDHqCU8/laOJkk
         3ksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777677325; x=1778282125;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PdKnDal4ATo3dq5FFQY8RgWergrIXZOKUxyoosrtMe4=;
        b=Q4uxdOdwLWxWtuqtHuSyeSmIOM40VDrisshXESqgxPumErnAx6uNn38igsybLERuzQ
         lJus2sgJlKTD+nM9B8zWsgg4g5MgVLAzwAJBrQi2tKE+dmF2zUohzjoQ0aMaavohXVZd
         YH2UGLQXo7q+S4DINJLNwmraNKSpo9pyHQhGuSUPvdtImfKeeATfAx1LDA8mrngZSxOA
         QSZiS8VUiiUkkzjunahySa3VVodqzElCUps+ArUNdYvs9xbzHQ9B2skQ4kiq21SSm7rI
         uXy2yRVyhGtFxUxeOE/HmSXUNccyOslp4pA11/qG8AZJdbm/HzuL86EmJn+EcqhX6jib
         txCw==
X-Gm-Message-State: AOJu0Yy5yKr10Z9VYYi/F6Os6Jb53V5Fq9sO+EclaQAbFN+hHBdkQO+O
	6GXR/N4hOOSMsYDEVKhVSEKx5A0qGQ5LacpBbqa0gCGDP+gDGYQBC7LQwiv+q5iV
X-Gm-Gg: AeBDiesvtk0u8D422toRTUxx7YBiFTTo+IjQ7SJ2eFMc2Gl/dkSfS4+e3sicYGSndc7
	vROp9zZzejzpz+wWtPe3iw+J9Z5SwMhOPvn0zmEjgOy/tq443eeSK/N1Xm0OxTXzRKNo7XeswFH
	alkE+Yrm7uC25W7oRhBAwPEw7VWUKaGXFpqY2pTwwy8xrFRA0g1pJKSUexcKfr6Fpa/OFeo3mTl
	Eh2fCpmL7Alft+NZ+4OkjoXCOHWnDeiuQsy33B0XSHIf4/lT+/qQp1RdocixXr42JGfADsu2u0l
	6YbH5gjY59SNKtiRLGoof9pWbOV5jnbuY9YvR6kwLaXpqnqd2GX3nV66znkmn0pF7Yf0h36tVRh
	MIC9FRlwWmSaRREcs8X2tsiEdP5V+j9U+NbtUZRYZM7qO4mq4AreztYQ+Rtb75w98vAJv/m4Wm6
	g8hF4sFSSyteLxGzT1sRq8/x68gdjkDA2C40kJUy4=
X-Received: by 2002:a05:7301:9f06:b0:2ea:5057:a331 with SMTP id 5a478bee46e88-2efb9c85625mr568135eec.21.1777677325279;
        Fri, 01 May 2026 16:15:25 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.231.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b390df0sm6188672eec.17.2026.05.01.16.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 16:15:24 -0700 (PDT)
Message-Id: <cf2ae409e6eb4aa24c6afdcdca4ce4c4df2ae7b8.1777677310.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
	<pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 01 May 2026 23:15:10 +0000
Subject: [PATCH v2 8/8] t9904: add tests for the new url-parse builtin
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
    Matheus Moreira <matheus@matheusmoreira.com>,
    Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

Test git URL parsing, validation and component extraction
on all documented git URL schemes and syntaxes.

Add IPv6 host coverage in URL form:

    ssh://[::1]/path
    ssh://user@[::1]:1234/path
    git://[::1]:9418/path
    http://[2001:db8::1]/path
    https://[2001:db8::1]/path

In URL form the brackets are kept in the host component (RFC 3986
syntax for IPv6 literals).

Also exercise the bracketed scp short forms that t5601-clone.sh
covers via parse_connect_url:

    [host]:path
    [host:port]:path
    [::1]:repo
    user@[::1]:repo
    user@[host:port]:path

In scp form, brackets are kept for IPv6 literals (two or more inner
colons) and stripped for plain hostnames or host:port pairs.

Suggested-by: Torsten Bögershausen <tboegi@web.de>
Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 t/meson.build        |   1 +
 t/t9904-url-parse.sh | 319 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 320 insertions(+)
 create mode 100755 t/t9904-url-parse.sh

diff --git a/t/meson.build b/t/meson.build
index 7528e5cda5..41b389a472 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1114,6 +1114,7 @@ integration_tests = [
   't9901-git-web--browse.sh',
   't9902-completion.sh',
   't9903-bash-prompt.sh',
+  't9904-url-parse.sh',
 ]
 
 benchmarks = [
diff --git a/t/t9904-url-parse.sh b/t/t9904-url-parse.sh
new file mode 100755
index 0000000000..32b3f4a286
--- /dev/null
+++ b/t/t9904-url-parse.sh
@@ -0,0 +1,319 @@
+#!/bin/sh
+#
+# Copyright (c) 2024 Matheus Afonso Martins Moreira
+#
+
+test_description='git url-parse tests'
+
+. ./test-lib.sh
+
+test_expect_success 'git url-parse -- ssh syntax' '
+	git url-parse "ssh://user@example.com:1234/repository/path" &&
+	git url-parse "ssh://user@example.com/repository/path" &&
+	git url-parse "ssh://example.com:1234/repository/path" &&
+	git url-parse "ssh://example.com/repository/path"
+'
+
+test_expect_success 'git url-parse -- git syntax' '
+	git url-parse "git://example.com:1234/repository/path" &&
+	git url-parse "git://example.com/repository/path"
+'
+
+test_expect_success 'git url-parse -- http syntax' '
+	git url-parse "https://example.com:1234/repository/path" &&
+	git url-parse "https://example.com/repository/path" &&
+	git url-parse "http://example.com:1234/repository/path" &&
+	git url-parse "http://example.com/repository/path"
+'
+
+test_expect_success 'git url-parse -- scp syntax' '
+	git url-parse "user@example.com:/repository/path" &&
+	git url-parse "example.com:/repository/path"
+'
+
+test_expect_success 'git url-parse -- username expansion - ssh syntax' '
+	git url-parse "ssh://user@example.com:1234/~user/repository" &&
+	git url-parse "ssh://user@example.com/~user/repository" &&
+	git url-parse "ssh://example.com:1234/~user/repository" &&
+	git url-parse "ssh://example.com/~user/repository"
+'
+
+test_expect_success 'git url-parse -- username expansion - git syntax' '
+	git url-parse "git://example.com:1234/~user/repository" &&
+	git url-parse "git://example.com/~user/repository"
+'
+
+test_expect_success 'git url-parse -- username expansion - scp syntax' '
+	git url-parse "user@example.com:~user/repository" &&
+	git url-parse "example.com:~user/repository"
+'
+
+test_expect_success 'git url-parse -- file urls' '
+	git url-parse "file:///repository/path" &&
+	git url-parse "file://"
+'
+
+test_expect_success 'git url-parse -c scheme -- ssh syntax' '
+	test ssh = "$(git url-parse -c scheme "ssh://user@example.com:1234/repository/path")" &&
+	test ssh = "$(git url-parse -c scheme "ssh://user@example.com/repository/path")" &&
+	test ssh = "$(git url-parse -c scheme "ssh://example.com:1234/repository/path")" &&
+	test ssh = "$(git url-parse -c scheme "ssh://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c scheme -- git syntax' '
+	test git = "$(git url-parse -c scheme "git://example.com:1234/repository/path")" &&
+	test git = "$(git url-parse -c scheme "git://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c scheme -- http syntax' '
+	test https = "$(git url-parse -c scheme "https://example.com:1234/repository/path")" &&
+	test https = "$(git url-parse -c scheme "https://example.com/repository/path")" &&
+	test http = "$(git url-parse -c scheme "http://example.com:1234/repository/path")" &&
+	test http = "$(git url-parse -c scheme "http://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c scheme -- scp syntax' '
+	test ssh = "$(git url-parse -c scheme "user@example.com:/repository/path")" &&
+	test ssh = "$(git url-parse -c scheme "example.com:/repository/path")"
+'
+
+test_expect_success 'git url-parse -c user -- ssh syntax' '
+	test user = "$(git url-parse -c user "ssh://user@example.com:1234/repository/path")" &&
+	test user = "$(git url-parse -c user "ssh://user@example.com/repository/path")" &&
+	test "" = "$(git url-parse -c user "ssh://example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c user "ssh://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c user -- git syntax' '
+	test "" = "$(git url-parse -c user "git://example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c user "git://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c user -- http syntax' '
+	test "" = "$(git url-parse -c user "https://example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c user "https://example.com/repository/path")" &&
+	test "" = "$(git url-parse -c user "http://example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c user "http://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c user -- scp syntax' '
+	test user = "$(git url-parse -c user "user@example.com:/repository/path")" &&
+	test "" = "$(git url-parse -c user "example.com:/repository/path")"
+'
+
+test_expect_success 'git url-parse -c password -- http syntax' '
+	test secret = "$(git url-parse -c password "https://user:secret@example.com:1234/repository/path")" &&
+	test secret = "$(git url-parse -c password "http://user:secret@example.com/repository/path")" &&
+	test "" = "$(git url-parse -c password "https://user@example.com/repository/path")" &&
+	test "" = "$(git url-parse -c password "https://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c host -- ssh syntax' '
+	test example.com = "$(git url-parse -c host "ssh://user@example.com:1234/repository/path")" &&
+	test example.com = "$(git url-parse -c host "ssh://user@example.com/repository/path")" &&
+	test example.com = "$(git url-parse -c host "ssh://example.com:1234/repository/path")" &&
+	test example.com = "$(git url-parse -c host "ssh://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c host -- git syntax' '
+	test example.com = "$(git url-parse -c host "git://example.com:1234/repository/path")" &&
+	test example.com = "$(git url-parse -c host "git://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c host -- http syntax' '
+	test example.com = "$(git url-parse -c host "https://example.com:1234/repository/path")" &&
+	test example.com = "$(git url-parse -c host "https://example.com/repository/path")" &&
+	test example.com = "$(git url-parse -c host "http://example.com:1234/repository/path")" &&
+	test example.com = "$(git url-parse -c host "http://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c host -- scp syntax' '
+	test example.com = "$(git url-parse -c host "user@example.com:/repository/path")" &&
+	test example.com = "$(git url-parse -c host "example.com:/repository/path")"
+'
+
+test_expect_success 'git url-parse -c port -- ssh syntax' '
+	test 1234 = "$(git url-parse -c port "ssh://user@example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c port "ssh://user@example.com/repository/path")" &&
+	test 1234 = "$(git url-parse -c port "ssh://example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c port "ssh://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c port -- git syntax' '
+	test 1234 = "$(git url-parse -c port "git://example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c port "git://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c port -- http syntax' '
+	test 1234 = "$(git url-parse -c port "https://example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c port "https://example.com/repository/path")" &&
+	test 1234 = "$(git url-parse -c port "http://example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c port "http://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c port -- scp syntax' '
+	test "" = "$(git url-parse -c port "user@example.com:/repository/path")" &&
+	test "" = "$(git url-parse -c port "example.com:/repository/path")"
+'
+
+test_expect_success 'git url-parse -c path -- ssh syntax' '
+	test "/repository/path" = "$(git url-parse -c path "ssh://user@example.com:1234/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "ssh://user@example.com/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "ssh://example.com:1234/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "ssh://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c path -- git syntax' '
+	test "/repository/path" = "$(git url-parse -c path "git://example.com:1234/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "git://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c path -- http syntax' '
+	test "/repository/path" = "$(git url-parse -c path "https://example.com:1234/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "https://example.com/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "http://example.com:1234/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "http://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c path -- scp syntax' '
+	test "/repository/path" = "$(git url-parse -c path "user@example.com:/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "example.com:/repository/path")"
+'
+
+test_expect_success 'git url-parse -c path -- username expansion - ssh syntax' '
+	test "~user/repository" = "$(git url-parse -c path "ssh://user@example.com:1234/~user/repository")" &&
+	test "~user/repository" = "$(git url-parse -c path "ssh://user@example.com/~user/repository")" &&
+	test "~user/repository" = "$(git url-parse -c path "ssh://example.com:1234/~user/repository")" &&
+	test "~user/repository" = "$(git url-parse -c path "ssh://example.com/~user/repository")"
+'
+
+test_expect_success 'git url-parse -c path -- username expansion - git syntax' '
+	test "~user/repository" = "$(git url-parse -c path "git://example.com:1234/~user/repository")" &&
+	test "~user/repository" = "$(git url-parse -c path "git://example.com/~user/repository")"
+'
+
+test_expect_success 'git url-parse -c path -- username expansion - scp syntax' '
+	test "~user/repository" = "$(git url-parse -c path "user@example.com:~user/repository")" &&
+	test "~user/repository" = "$(git url-parse -c path "example.com:~user/repository")"
+'
+
+test_expect_success 'git url-parse -c path -- username expansion strips query and fragment' '
+	test "~user/repository" = "$(git url-parse -c path "ssh://example.com/~user/repository?query")" &&
+	test "~user/repository" = "$(git url-parse -c path "ssh://example.com/~user/repository#fragment")" &&
+	test "~user/repository" = "$(git url-parse -c path "git://example.com/~user/repository?query")" &&
+	test "~user/repository" = "$(git url-parse -c path "user@example.com:~user/repository?query")"
+'
+
+test_expect_success 'git url-parse -- ssh syntax with IPv6' '
+	git url-parse "ssh://user@[::1]:1234/repository/path" &&
+	git url-parse "ssh://user@[::1]/repository/path" &&
+	git url-parse "ssh://[::1]:1234/repository/path" &&
+	git url-parse "ssh://[::1]/repository/path" &&
+	git url-parse "ssh://[2001:db8::1]/repository/path"
+'
+
+test_expect_success 'git url-parse -- git syntax with IPv6' '
+	git url-parse "git://[::1]:9418/repository/path" &&
+	git url-parse "git://[::1]/repository/path"
+'
+
+test_expect_success 'git url-parse -- http syntax with IPv6' '
+	git url-parse "https://[::1]:1234/repository/path" &&
+	git url-parse "https://[::1]/repository/path" &&
+	git url-parse "http://[2001:db8::1]/repository/path"
+'
+
+test_expect_success 'git url-parse -c host -- IPv6 in URL form' '
+	test "[::1]" = "$(git url-parse -c host "ssh://user@[::1]:1234/repository/path")" &&
+	test "[::1]" = "$(git url-parse -c host "ssh://[::1]/repository/path")" &&
+	test "[2001:db8::1]" = "$(git url-parse -c host "ssh://[2001:db8::1]/repository/path")" &&
+	test "[::1]" = "$(git url-parse -c host "git://[::1]/repository/path")" &&
+	test "[2001:db8::1]" = "$(git url-parse -c host "https://[2001:db8::1]/repository/path")"
+'
+
+test_expect_success 'git url-parse -c port -- IPv6 in URL form' '
+	test 1234 = "$(git url-parse -c port "ssh://user@[::1]:1234/repository/path")" &&
+	test "" = "$(git url-parse -c port "ssh://[::1]/repository/path")" &&
+	test 9418 = "$(git url-parse -c port "git://[::1]:9418/repository/path")"
+'
+
+test_expect_success 'git url-parse -- scp syntax with IPv6' '
+	git url-parse "[::1]:repository/path" &&
+	git url-parse "user@[::1]:repository/path" &&
+	git url-parse "[2001:db8::1]:repo"
+'
+
+test_expect_success 'git url-parse -- scp syntax with bracketed hostname' '
+	git url-parse "[myhost]:src" &&
+	git url-parse "user@[myhost]:src"
+'
+
+test_expect_success 'git url-parse -- scp syntax with bracketed host:port' '
+	git url-parse "[myhost:123]:src" &&
+	git url-parse "user@[myhost:123]:src"
+'
+
+test_expect_success 'git url-parse -c host -- scp+IPv6' '
+	test "[::1]" = "$(git url-parse -c host "[::1]:repository/path")" &&
+	test "[::1]" = "$(git url-parse -c host "user@[::1]:repository/path")" &&
+	test "[2001:db8::1]" = "$(git url-parse -c host "[2001:db8::1]:repo")"
+'
+
+test_expect_success 'git url-parse -c path -- scp+IPv6' '
+	test "/repository/path" = "$(git url-parse -c path "[::1]:/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "[::1]:repository/path")" &&
+	test "/repo" = "$(git url-parse -c path "[2001:db8::1]:repo")"
+'
+
+test_expect_success 'git url-parse -c host,port,path -- scp [host:port]:src' '
+	test myhost = "$(git url-parse -c host "[myhost:123]:src")" &&
+	test 123 = "$(git url-parse -c port "[myhost:123]:src")" &&
+	test "/src" = "$(git url-parse -c path "[myhost:123]:src")"
+'
+
+test_expect_success 'git url-parse -c host,path -- scp [host]:src' '
+	test myhost = "$(git url-parse -c host "[myhost]:src")" &&
+	test "/src" = "$(git url-parse -c path "[myhost]:src")"
+'
+
+test_expect_success 'git url-parse -c user -- scp with user@ and brackets' '
+	test user = "$(git url-parse -c user "user@[::1]:repo")" &&
+	test user = "$(git url-parse -c user "user@[myhost:123]:src")" &&
+	test user = "$(git url-parse -c user "user@[myhost]:src")"
+'
+
+test_expect_success 'git url-parse -- scp+IPv6 with username expansion' '
+	test "~user/repo" = "$(git url-parse -c path "[::1]:~user/repo")" &&
+	test "~user/repo" = "$(git url-parse -c path "user@[::1]:~user/repo")"
+'
+
+test_expect_success 'git url-parse fails on invalid URL' '
+	test_must_fail git url-parse "not a url"
+'
+
+test_expect_success 'git url-parse helpful error for absolute local path' '
+	test_must_fail git url-parse "/abs/path" 2>err &&
+	test_grep "is not a URL" err &&
+	test_grep "file:///abs/path" err
+'
+
+test_expect_success 'git url-parse helpful error for relative local path' '
+	test_must_fail git url-parse "./rel" 2>err &&
+	test_grep "is not a URL" err &&
+	test_grep "absolute path" err
+'
+
+test_expect_success 'git url-parse fails on unknown -c component name' '
+	test_must_fail git url-parse -c bogus "https://example.com/repo"
+'
+
+test_expect_success 'git url-parse fails on URL missing host' '
+	test_must_fail git url-parse "https://"
+'
+
+test_expect_success 'git url-parse with no URL prints usage' '
+	test_must_fail git url-parse 2>err &&
+	test_grep "usage:" err
+'
+
+test_done
-- 
gitgitgadget
