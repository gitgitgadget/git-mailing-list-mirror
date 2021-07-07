Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7C9C07E9C
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 10:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF4F6008E
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 10:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhGGKYr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 06:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhGGKYk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 06:24:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A6CC06175F
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 03:21:59 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id b14-20020a1c1b0e0000b02901fc3a62af78so3799428wmb.3
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 03:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pACzyLj3kTjIRekZbkeovwqwOWB1miQ9TfGaho9IoUU=;
        b=YXi2jnX3tme3zBLeZPUs7HWxSsrMyx0szM/ROdkzEwWjx/A/vs9PhbL5VU/qKDLNfX
         aVlO1J9350nfRP8pGKZEy8w1f2HVfmE8olOfCod3AzAd0Xoz2Lr/poyaZRn6bSxcRk95
         7nkSkQIkQ0GSI8n6kabwsCrQdfY1czUmUAyQSf8EkJdG4U4qjtrDNxl50A1ROiQZVXSZ
         1PKYsX6q3QT4apwA7rJn3xzYxqHk5xNY/DZ8FkJYLSYCNPd3p6KAfYQXtcDx92BGarxM
         chfnoUm/UjRbceKMqpozrcTrqVvmyBjc4IM50O0VGvstZR2y5KTl+pOOFQNaUn1AX97N
         KfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pACzyLj3kTjIRekZbkeovwqwOWB1miQ9TfGaho9IoUU=;
        b=fREAXxGiT6qt/lb/l3Fhg1EFUse0o+K4FbMGj/PiQUO9vaU3zPpiSq5B5si89aBHgW
         G/a4XxlrIiYunxWK+DI/ppNNHcBbl4HpqRJN4RDkdBM3UTtVU3umVl7pxZJ7aYssLMI5
         PEjTCeagRItf8JpLdWgUqDYx+U3kTWG7+CcPYB+3Zu5KJLFbot4GCdBhC/1brm4fuJuQ
         layUFvTGtVEVg7JHO/qdVSJO4rjY232uOV49LTWCSjs6wnN9t77tpVMrCXEfE+lPU/kg
         6rdHmBiZ3eM8oAIrcFiFU1KGkEXjpmn4PieHjAMp1JmC2gaOFz/8cbZsM2e+xMOIhT0h
         Fv6w==
X-Gm-Message-State: AOAM533uJOwRrUyf6dDFrq/qV+k+mPC/DPurhbmFkJFR5LWMUQuHV7gW
        XjBlQEYTJFKOB+ZSS8gtUtPdxn8i/Qpvpg==
X-Google-Smtp-Source: ABdhPJxJV7xv3DjDfVcqYxG0H3qoklr9KIlosmEmDlowUC5VVkVQI4rs8hjbnfKEtj8AzOwuRJ+/wQ==
X-Received: by 2002:a05:600c:14c6:: with SMTP id i6mr5909269wmh.169.1625653317681;
        Wed, 07 Jul 2021 03:21:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm19701187wrr.76.2021.07.07.03.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 03:21:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] tests: replace [de]packetize() shell+perl test-tool pkt-line
Date:   Wed,  7 Jul 2021 12:21:47 +0200
Message-Id: <patch-3.5-c1015fa6ab0-20210707T101549Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The shell+perl "[de]packetize()" helper functions were added in
4414a150025 (t/lib-git-daemon: add network-protocol helpers,
2018-01-24), and around the same time we added the "pkt-line" helper
in 74e70029615 (test-pkt-line: introduce a packet-line test helper,
2018-03-14).

For some reason it seems we've mostly used the shell+perl version
instead of the helper since then. There were discussions around
88124ab2636 (test-lib-functions: make packetize() more efficient,
2020-03-27) and cacae4329fa (test-lib-functions: simplify packetize()
stdin code, 2020-03-29) to improve them and make them more efficient.

Let's instead just use the test helper, I think this results in both
more legible code, and for anyone who cares about efficiency it'll be
faster.

We can't convert all the users of packetize(), it has a feature the
test-tool is missing. This'll be addressed in the subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5410-receive-pack-alternates.sh     | 42 ++++++++++++++++++--------
 t/t5411/once-0010-report-status-v1.sh  |  8 ++---
 t/t5500-fetch-pack.sh                  | 15 +++++----
 t/t5530-upload-pack-error.sh           | 24 ++++++++-------
 t/t5562-http-backend-content-length.sh | 13 ++++----
 t/t5570-git-daemon.sh                  | 12 +++++---
 t/t5704-protocol-violations.sh         | 30 +++++++++---------
 7 files changed, 86 insertions(+), 58 deletions(-)

diff --git a/t/t5410-receive-pack-alternates.sh b/t/t5410-receive-pack-alternates.sh
index 0b28e4e452f..d0053d95a44 100755
--- a/t/t5410-receive-pack-alternates.sh
+++ b/t/t5410-receive-pack-alternates.sh
@@ -16,10 +16,6 @@ test_expect_success 'setup' '
 	test_commit private
 '
 
-extract_haves () {
-	depacketize | perl -lne '/^(\S+) \.have/ and print $1'
-}
-
 test_expect_success 'with core.alternateRefsCommand' '
 	write_script fork/alternate-refs <<-\EOF &&
 		git --git-dir="$1" for-each-ref \
@@ -27,18 +23,40 @@ test_expect_success 'with core.alternateRefsCommand' '
 			refs/heads/public/
 	EOF
 	test_config -C fork core.alternateRefsCommand ./alternate-refs &&
-	git rev-parse public/branch >expect &&
-	printf "0000" | git receive-pack fork >actual &&
-	extract_haves <actual >actual.haves &&
-	test_cmp expect actual.haves
+
+	test-tool pkt-line pack >in <<-\EOF &&
+	0000
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse main) refs/heads/main
+	$(git rev-parse base) refs/tags/base
+	$(git rev-parse public) .have
+	0000
+	EOF
+
+	git receive-pack fork >out <in &&
+	test-tool pkt-line unpack <out >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'with core.alternateRefsPrefixes' '
 	test_config -C fork core.alternateRefsPrefixes "refs/heads/private" &&
-	git rev-parse private/branch >expect &&
-	printf "0000" | git receive-pack fork >actual &&
-	extract_haves <actual >actual.haves &&
-	test_cmp expect actual.haves
+
+	test-tool pkt-line pack >in <<-\EOF &&
+	0000
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse main) refs/heads/main
+	$(git rev-parse base) refs/tags/base
+	$(git rev-parse private) .have
+	0000
+	EOF
+
+	git receive-pack fork >out <in &&
+	test-tool pkt-line unpack <out >actual &&
+	test_cmp expect actual
 '
 
 test_done
diff --git a/t/t5411/once-0010-report-status-v1.sh b/t/t5411/once-0010-report-status-v1.sh
index 1233a46eac5..cf33d993192 100644
--- a/t/t5411/once-0010-report-status-v1.sh
+++ b/t/t5411/once-0010-report-status-v1.sh
@@ -34,13 +34,13 @@ test_expect_success "proc-receive: report status v1" '
 				$A $B | packetize
 		fi &&
 		printf "%s %s refs/for/main/topic1\n" \
-			$ZERO_OID $A | packetize &&
+			$ZERO_OID $A | test-tool pkt-line pack &&
 		printf "%s %s refs/heads/foo\n" \
-			$ZERO_OID $A | packetize &&
+			$ZERO_OID $A | test-tool pkt-line pack &&
 		printf "%s %s refs/for/next/topic\n" \
-			$ZERO_OID $A | packetize &&
+			$ZERO_OID $A | test-tool pkt-line pack &&
 		printf "%s %s refs/for/main/topic2\n" \
-			$ZERO_OID $A | packetize &&
+			$ZERO_OID $A | test-tool pkt-line pack &&
 		printf 0000 &&
 		printf "" | git -C "$upstream" pack-objects --stdout
 	} | git receive-pack "$upstream" --stateless-rpc \
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 8a5d3492c71..ff0b7dd89f9 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -872,14 +872,17 @@ test_expect_success 'shallow since with commit graph and already-seen commit' '
 	git commit-graph write --reachable &&
 	git config core.commitGraph true &&
 
-	GIT_PROTOCOL=version=2 git upload-pack . <<-EOF >/dev/null
-	0012command=fetch
-	$(echo "object-format=$(test_oid algo)" | packetize)
-	00010013deepen-since 1
-	$(echo "want $(git rev-parse other)" | packetize)
-	$(echo "have $(git rev-parse main)" | packetize)
+	test-tool pkt-line pack >in <<-EOF &&
+	command=fetch
+	object-format=$(test_oid algo)
+	0001
+	deepen-since 1
+	want $(git rev-parse other)
+	have $(git rev-parse main)
 	0000
 	EOF
+
+	GIT_PROTOCOL=version=2 git upload-pack . <in >/dev/null
 	)
 '
 
diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index 7c1460eaa99..8ccaae10475 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -90,18 +90,20 @@ test_expect_success 'upload-pack fails due to error in pack-objects enumeration'
 
 test_expect_success 'upload-pack tolerates EOF just after stateless client wants' '
 	test_commit initial &&
-	head=$(git rev-parse HEAD) &&
-
-	{
-		packetize "want $head" &&
-		packetize "shallow $head" &&
-		packetize "deepen 1" &&
-		printf "0000"
-	} >request &&
 
-	printf "0000" >expect &&
-
-	git upload-pack --stateless-rpc . <request >actual &&
+	head=$(git rev-parse HEAD) &&
+	test-tool pkt-line pack >request <<-EOF &&
+	want $head
+	shallow $head
+	deepen 1
+	0000
+	EOF
+
+	cat >expect <<-\EOF &&
+	0000
+	EOF
+	git upload-pack --stateless-rpc . <request >out &&
+	test-tool pkt-line unpack <out >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index e5d3d15ba8d..e6c8338b648 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -53,12 +53,13 @@ test_expect_success 'setup' '
 	test_commit c1 &&
 	hash_head=$(git rev-parse HEAD) &&
 	hash_prev=$(git rev-parse HEAD~1) &&
-	{
-		packetize "want $hash_head" &&
-		printf 0000 &&
-		packetize "have $hash_prev" &&
-		packetize "done"
-	} >fetch_body &&
+	test-tool pkt-line pack >fetch_body <<-EOF &&
+	want $hash_head
+	0000
+	have $hash_prev
+	done
+	0000
+	EOF
 	test_copy_bytes 10 <fetch_body >fetch_body.trunc &&
 	hash_next=$(git commit-tree -p HEAD -m next HEAD^{tree}) &&
 	{
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 82c31ab6cd8..2dde0348816 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -198,12 +198,14 @@ test_expect_success FAKENC 'hostname interpolation works after LF-stripping' '
 		printf "0000"
 	} >input &&
 	fake_nc "$GIT_DAEMON_HOST_PORT" <input >output &&
-	depacketize <output >output.raw &&
+	test-tool pkt-line unpack <output >actual &&
+
+	cat >expect <<-EOF &&
+	$(git rev-parse HEAD) HEAD
+	$(git rev-parse refs/heads/main) refs/heads/main
+	0000
+	EOF
 
-	# just pick out the value of main, which avoids any protocol
-	# particulars
-	perl -lne "print \$1 if m{^(\\S+) refs/heads/main}" <output.raw >actual &&
-	git -C "$repo" rev-parse main >expect &&
 	test_cmp expect actual
 '
 
diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
index 038fffd3d03..44e2c0d3ded 100755
--- a/t/t5704-protocol-violations.sh
+++ b/t/t5704-protocol-violations.sh
@@ -7,13 +7,14 @@ making sure that we do not segfault or otherwise behave badly.'
 . ./test-lib.sh
 
 test_expect_success 'extra delim packet in v2 ls-refs args' '
-	{
-		packetize command=ls-refs &&
-		packetize "object-format=$(test_oid algo)" &&
-		printf 0001 &&
-		# protocol expects 0000 flush here
-		printf 0001
-	} >input &&
+	# protocol expects 0000 flush after the 0001
+	test-tool pkt-line pack >input <<-EOF &&
+	command=ls-refs
+	object-format=$(test_oid algo)
+	0001
+	0001
+	EOF
+
 	cat >err.expect <<-\EOF &&
 	fatal: expected flush after ls-refs arguments
 	EOF
@@ -23,13 +24,14 @@ test_expect_success 'extra delim packet in v2 ls-refs args' '
 '
 
 test_expect_success 'extra delim packet in v2 fetch args' '
-	{
-		packetize command=fetch &&
-		packetize "object-format=$(test_oid algo)" &&
-		printf 0001 &&
-		# protocol expects 0000 flush here
-		printf 0001
-	} >input &&
+	# protocol expects 0000 flush after the 0001
+	test-tool pkt-line pack >input <<-EOF &&
+	command=fetch
+	object-format=$(test_oid algo)
+	0001
+	0001
+	EOF
+
 	cat >err.expect <<-\EOF &&
 	fatal: expected flush after fetch arguments
 	EOF
-- 
2.32.0.636.g43e71d69cff

