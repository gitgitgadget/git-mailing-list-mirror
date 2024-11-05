Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FD11EBA1C
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730833521; cv=none; b=UfGNGid//TmfFY0QfNYc1jm0VQtOiF15jy/STVA7hak1LxqhtfWpzuYG5asDZ8UiFbXpDsK0R87BBAKphJ8jHXLf6gGnls4EyBZMeMMQTv4naCU0KU8MzOKBaKr8e7UgUC1Szj2mj3CDCHOHJGLRUvhMGXcISEjAWxdjQML3Er4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730833521; c=relaxed/simple;
	bh=ppgLqom6fZaa20yMBHFdqK/uul4hFEHx2X1Gpbev8qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUZwfL0Ed1O2ORHUz7DMeaZ8txKnFnroeXyVMcflPRR3EKzlavvn8VcdsqSgHMSc+axZbIvSgNIvGIbk9dyvCGPmN02aPv7ViplZUTedLdHRziGVPw9GPTIyGZ2W0hSvM0v8kH16btUlbZueL7PjpUWi0CBZeiayqQqhnOgjPcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=fth3GpYy; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="fth3GpYy"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e2e340218daso5924365276.0
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 11:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730833519; x=1731438319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dAEMfY3OeGKacvFEOXWBrplyPJlIVq2Sxd4oW8g6KIQ=;
        b=fth3GpYyTfgdVJjSCp1ENLZX2T093sTL9BUFTSf+WGXKAx8Fxxt/3UkpQLFGvaD+c3
         31KGUEm+/Ta8lpDdKwgs8F3kQhWFWc9qG85UOJVxLxcpOJIpLGSmY29tpP5aMT1RH1hS
         U7tOEHxLBlA+u9dKpUaz7jgGgeVa1sNN/8o9oLaxJbvszVg1wbaNJQ0KymY1CtCUIe2u
         u9I+Paad2zsYYJk4q2EEltkdCxn/nTv3iTihLgseM1rJ0o+qzT6ZMHsNFRdwQlVv0Ymo
         AclnpBZDx3NQUi0Ghkn9g6sjuexYBJueY/aqWTBqAxFmSvsQ6haRySsqB4UwymbCUA9h
         EqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730833519; x=1731438319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAEMfY3OeGKacvFEOXWBrplyPJlIVq2Sxd4oW8g6KIQ=;
        b=U7Rj0gyXjgOwTYD+IxCzELHWuQ/3lC/tKVyyiu4sJkRUw8tcJpLhSXCxXjICk3oP1R
         fbswqb1YUZnFzA2+t6Q+9mJgy/DR/sGYS2AKKRQf8iz1dTF8J88LJDAUfB21PIlj0433
         rxi0AiJ3REdWCGFI+kz+a5rKD1UUH9/u4z8wqSneZK5iq7vobQxvgnXn8vWDRcenYmce
         kct+aNyD1rZKfVtYYKpgCSCTSbDfX90/+hV0UN9Df5awwLzPhpXx16q1e7nD6JMFvmGl
         R0jWhWsphPEwy9dvqvYdlZFQchKmcWftFUORVogWwF/EMpDWDN3CREMsTlRj8u8EISgx
         0wmQ==
X-Gm-Message-State: AOJu0YwDEh4ZmIH0MIrUWhjUV8hzeMa9efcn6x5vhfUr+Vu97JmUzJZ/
	va73Wde2FJTAGpMWcdpVklkIY6pA4lAp840A+42CngGMHcSMJx3IBWHdUpCfz6hnt2qh+cb+vIJ
	KxnI=
X-Google-Smtp-Source: AGHT+IEK1Dfquqi50cuDR21ZZ2i3v+++GmG5lBWnrD9dM7PY5W9SDkQE2lngDs1xJaLzc6qQfOJkSQ==
X-Received: by 2002:a05:6902:154b:b0:e30:d89f:1342 with SMTP id 3f1490d57ef6-e30e5affc43mr18701281276.24.1730833518618;
        Tue, 05 Nov 2024 11:05:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8a61797sm2701189276.12.2024.11.05.11.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 11:05:18 -0800 (PST)
Date: Tue, 5 Nov 2024 14:05:17 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 2/2] t/helper/test-tool: implement sha1-unsafe helper
Message-ID: <d8c1fc78b57e02a140b5c363caaa14c2dc2bb274.1730833507.git.me@ttaylorr.com>
References: <cover.1730833506.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1730833506.git.me@ttaylorr.com>

Add a new helper similar to 't/helper/test-tool sha1' called instead
"sha1-unsafe" which uses the unsafe variant of Git's SHA-1 wrappers.

While we're at it, modify the test-sha1.sh script to exercise both
the sha1 and sha1-unsafe test tools to ensure that both produce the
expected hash values.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-sha1.c  |  5 +++++
 t/helper/test-sha1.sh | 38 ++++++++++++++++++++++----------------
 t/helper/test-tool.c  |  1 +
 t/helper/test-tool.h  |  1 +
 4 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/t/helper/test-sha1.c b/t/helper/test-sha1.c
index 1c1272cc1f9..349540c4df8 100644
--- a/t/helper/test-sha1.c
+++ b/t/helper/test-sha1.c
@@ -13,3 +13,8 @@ int cmd__sha1_is_sha1dc(int argc UNUSED, const char **argv UNUSED)
 #endif
 	return 1;
 }
+
+int cmd__sha1_unsafe(int ac, const char **av)
+{
+	return cmd_hash_impl(ac, av, GIT_HASH_SHA1, 1);
+}
diff --git a/t/helper/test-sha1.sh b/t/helper/test-sha1.sh
index 84594885c70..bf387d3db14 100755
--- a/t/helper/test-sha1.sh
+++ b/t/helper/test-sha1.sh
@@ -3,25 +3,31 @@
 dd if=/dev/zero bs=1048576 count=100 2>/dev/null |
 /usr/bin/time t/helper/test-tool sha1 >/dev/null
 
+dd if=/dev/zero bs=1048576 count=100 2>/dev/null |
+/usr/bin/time t/helper/test-tool sha1-unsafe >/dev/null
+
 while read expect cnt pfx
 do
 	case "$expect" in '#'*) continue ;; esac
-	actual=$(
-		{
-			test -z "$pfx" || echo "$pfx"
-			dd if=/dev/zero bs=1048576 count=$cnt 2>/dev/null |
-			perl -pe 'y/\000/g/'
-		} | ./t/helper/test-tool sha1 $cnt
-	)
-	if test "$expect" = "$actual"
-	then
-		echo "OK: $expect $cnt $pfx"
-	else
-		echo >&2 "OOPS: $cnt"
-		echo >&2 "expect: $expect"
-		echo >&2 "actual: $actual"
-		exit 1
-	fi
+	for sha1 in sha1 sha1-unsafe
+	do
+		actual=$(
+			{
+				test -z "$pfx" || echo "$pfx"
+				dd if=/dev/zero bs=1048576 count=$cnt 2>/dev/null |
+				perl -pe 'y/\000/g/'
+			} | ./t/helper/test-tool $sha1 $cnt
+		)
+		if test "$expect" = "$actual"
+		then
+			echo "OK ($sha1): $expect $cnt $pfx"
+		else
+			echo >&2 "OOPS ($sha1): $cnt"
+			echo >&2 "expect ($sha1): $expect"
+			echo >&2 "actual ($sha1): $actual"
+			exit 1
+		fi
+	done
 done <<EOF
 da39a3ee5e6b4b0d3255bfef95601890afd80709 0
 3f786850e387550fdab836ed7e6dc881de23001b 0 a
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 1ebb69a5dc4..51ed25c07e2 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -70,6 +70,7 @@ static struct test_cmd cmds[] = {
 	{ "serve-v2", cmd__serve_v2 },
 	{ "sha1", cmd__sha1 },
 	{ "sha1-is-sha1dc", cmd__sha1_is_sha1dc },
+	{ "sha1-unsafe", cmd__sha1_unsafe },
 	{ "sha256", cmd__sha256 },
 	{ "sigchain", cmd__sigchain },
 	{ "simple-ipc", cmd__simple_ipc },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index f3524d9a0f6..24149edd414 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -63,6 +63,7 @@ int cmd__scrap_cache_tree(int argc, const char **argv);
 int cmd__serve_v2(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 int cmd__sha1_is_sha1dc(int argc, const char **argv);
+int cmd__sha1_unsafe(int argc, const char **argv);
 int cmd__sha256(int argc, const char **argv);
 int cmd__sigchain(int argc, const char **argv);
 int cmd__simple_ipc(int argc, const char **argv);
-- 
2.47.0.231.gd8c1fc78b57
