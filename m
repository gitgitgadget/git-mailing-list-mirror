Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224861EB37
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705842948; cv=none; b=U45qOxTCN4vNFUccuB+xLcX3rcTYgcqwJbnEnSAC6eMzMKRLQUTt1UhbgJZd4IIHL3HRyZ6PoJ05C6eyi7foeTEt2B4xu/ha7dg8+H6nNxRRA6AEJAyAA37lgUUOdo8NVXOZJnLtJBJtIDu6wBkJK9UCIo94CwfUTGnq/9biGYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705842948; c=relaxed/simple;
	bh=A8ggfsAAido3UXW46H+H8bumqOBYX7Aqply9tNbF5ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DYd0ml2oPs1a53ejG8ATizoDqLT0The+JM/0LbFrOPNSFwabvfGAO3fZFJYnF6AosHlCINTHPhjg4rWK3yq0kb6mcN+B8PrgIZbBpGVborligAkC6IbQYS5tRAllvH+W2jyrSrrssi6/TE6jAx+7uHMfhuR59IFZ3GhBJcMfGSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdmFul6W; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdmFul6W"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7ba903342c2so151738839f.3
        for <git@vger.kernel.org>; Sun, 21 Jan 2024 05:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705842946; x=1706447746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoNFgjU2uuAwx1uE3fJGx4ANiWcUafSa0KGE2hPV8Zg=;
        b=VdmFul6WTQiYixleRpVzw01HLSNCiLP2kHYX/zXSyxdYtuPxCb7ZTtg0rdx++1tscD
         l1Pjhmeo/DUjg/ufdJmsOQFAzdYob67gQU45H+Z269fXw3/Jm+1JoSpneCuV30ZE1IQ2
         3NWGeQeijWEMo+EBsM2TfpFUv0ky5CSwXAag7GW4UD53sJhk20vqGFrHWjE1ACSQTCG1
         PUTfjhpEo85eDoStIK0e8rpkmJM3cSirMrjzNgvQZpPf+ZhWYqm2j7qBNr989cDYYvBp
         /B7dREI4KyzfIV+Km8rI2KowA7JAKd8j1c0yauBKMKRuYbwQbj/H8I5TDaMzFGkP0yIo
         Tdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705842946; x=1706447746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AoNFgjU2uuAwx1uE3fJGx4ANiWcUafSa0KGE2hPV8Zg=;
        b=NBOoEeNJrNqNrvylQ2Q/jYf98rYu6916M4qIgYF/lNoC/pHz9GT6jq978nlU78EQj3
         lsnyLnCZCz+HPO3XxUC2WLh8paCogi/slU4XaLQVMTuOW6koFQOjiL0ueGYsy7xUib2a
         +GFbgXNr4kA8QzrQ5pj3YPQufdbkl6pIA8lupTO6p7IZWFESsJ9G2ddJ/l839vstMveq
         qidb6LuXOiggRyuG1Om6UHzZbsduco1hY1AmN02qryZmeB+OE94IJ5nNOedeR2Xyqb9a
         VBO1SyAZyDwP1pRWuDyGcM+nh6bHfRULzN+b6ohM3Hs9cumW8XEVSocBpRjpL4D2zIqB
         /rdQ==
X-Gm-Message-State: AOJu0Yzk2vNDfScVyMv7LIvfe1VPp2sY5mvnx07n8K6Va0nZQ3XgAA8W
	vstLX5lgExdnUH4/tp3cTXfxswrbqUzdlnCq6m/LhU0ZuScgWIkQIsKfEuCT
X-Google-Smtp-Source: AGHT+IGb6yPm0Mm6b/YBjhx8ZyJgEmospaGzoFyL0uctxXmvhJ94nWNwGxyddavTzmsTPfTChvCPWA==
X-Received: by 2002:a05:6e02:52d:b0:35f:fb58:e5be with SMTP id h13-20020a056e02052d00b0035ffb58e5bemr4414727ils.17.1705842945927;
        Sun, 21 Jan 2024 05:15:45 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id g5-20020a636b05000000b005bd980cca56sm6619005pgc.29.2024.01.21.05.15.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jan 2024 05:15:45 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Arver <linusa@google.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 4/6] http-backend: new rpc-service for git-upload-archive
Date: Sun, 21 Jan 2024 21:15:36 +0800
Message-Id: <4a5d48859324b21092b95865d2d02f6fe83fa0ea.1705841443.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1705841443.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1705411391.git.zhiyou.jx@alibaba-inc.com> <cover.1705841443.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Add new rpc-service "upload-archive" in http-backend to add server side
support for remote archive over HTTP/HTTPS protocols.

Also add new test cases in t5003. In the test case "archive remote http
repository", git-archive exits with a non-0 exit code even though we
create the archive correctly. It will be fixed in a later commit.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 http-backend.c         | 13 ++++++++++---
 t/t5003-archive-zip.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index ff07b87e64..1ed1e29d07 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -38,6 +38,7 @@ struct rpc_service {
 static struct rpc_service rpc_service[] = {
 	{ "upload-pack", "uploadpack", 1, 1 },
 	{ "receive-pack", "receivepack", 0, -1 },
+	{ "upload-archive", "uploadarchive", 0, -1 },
 };
 
 static struct string_list *get_parameters(void)
@@ -639,10 +640,15 @@ static void check_content_type(struct strbuf *hdr, const char *accepted_type)
 
 static void service_rpc(struct strbuf *hdr, char *service_name)
 {
-	const char *argv[] = {NULL, "--stateless-rpc", ".", NULL};
+	struct strvec argv = STRVEC_INIT;
 	struct rpc_service *svc = select_service(hdr, service_name);
 	struct strbuf buf = STRBUF_INIT;
 
+	strvec_push(&argv, svc->name);
+	if (strcmp(service_name, "git-upload-archive"))
+		strvec_push(&argv, "--stateless-rpc");
+	strvec_push(&argv, ".");
+
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "application/x-git-%s-request", svc->name);
 	check_content_type(hdr, buf.buf);
@@ -655,9 +661,9 @@ static void service_rpc(struct strbuf *hdr, char *service_name)
 
 	end_headers(hdr);
 
-	argv[0] = svc->name;
-	run_service(argv, svc->buffer_input);
+	run_service(argv.v, svc->buffer_input);
 	strbuf_release(&buf);
+	strvec_clear(&argv);
 }
 
 static int dead;
@@ -723,6 +729,7 @@ static struct service_cmd {
 	{"GET", "/objects/pack/pack-[0-9a-f]{64}\\.idx$", get_idx_file},
 
 	{"POST", "/git-upload-pack$", service_rpc},
+	{"POST", "/git-upload-archive$", service_rpc},
 	{"POST", "/git-receive-pack$", service_rpc}
 };
 
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index fc499cdff0..6f85bd3463 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -239,4 +239,38 @@ check_zip with_untracked2
 check_added with_untracked2 untracked one/untracked
 check_added with_untracked2 untracked two/untracked
 
+# Test remote archive over HTTP protocol.
+#
+# Note: this should be the last part of this test suite, because
+# by including lib-httpd.sh, the test may end early if httpd tests
+# should not be run.
+#
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success "setup for HTTP protocol" '
+	cp -R bare.git "$HTTPD_DOCUMENT_ROOT_PATH/bare.git" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/bare.git" \
+		config http.uploadpack true &&
+	set_askpass user@host pass@host
+'
+
+setup_askpass_helper
+
+test_expect_success 'remote archive does not work with protocol v1' '
+	test_must_fail git -c protocol.version=1 archive \
+		--remote="$HTTPD_URL/auth/smart/bare.git" \
+		--output=remote-http.zip HEAD >actual 2>&1 &&
+	cat >expect <<-EOF &&
+	fatal: can${SQ}t connect to subservice git-upload-archive
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'archive remote http repository' '
+	test_must_fail git archive --remote="$HTTPD_URL/auth/smart/bare.git" \
+		--output=remote-http.zip HEAD &&
+	test_cmp_bin d.zip remote-http.zip
+'
+
 test_done
-- 
2.43.0

