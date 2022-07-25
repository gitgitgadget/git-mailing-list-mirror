Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CABC43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 20:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbiGYUep (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 16:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiGYUem (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 16:34:42 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B86822B04
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:34:41 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so7039258wmm.4
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PL/XJobI5xVcWtGY+GITFHenF1J7M/0SWg4QdXJXehs=;
        b=PEGUQq9zyDQUtog9T7tL6CyfA/lerkt1V/haDG36Qb7YXUC3J7JwVyuSnmvS2RitLv
         H4O5JnQx1QLHAEauGYQBAYhhxVrEk4VHUQf+C3aOxsFiCgvvUVKms01YfB6umUZoJ9Nd
         8dG/i8+mmwwN8TxPRvgS/FUx43Xpj8EWlSwXtjOcuUIyLbsDrjF27P/dKAYPgVxAUwrf
         qEAv3ZAZcaFs8uZtARhUhn8+mogkuZMlIJsBsK2H+VpOeKTW9Zsb24UvISaK4uSK9s0T
         3GWGem8sM0rVgFthGF75+9r2iHek+vJ5byj38LwPoPp1EATPpzI2/AVLX7+lAZpvAxKI
         vjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PL/XJobI5xVcWtGY+GITFHenF1J7M/0SWg4QdXJXehs=;
        b=EfTxoxWcKFGpFUy8lUcm4w4Ps8NCInx5WbRLAIbsU2JtyLd84V1T8Potkg8kbueedL
         QWpxdP3rMRFlasXap90v8yFA+iCNfFI1+kug9R3up4DysOF5uDb/Tq79ot6ANKFr/346
         Wx1aEygbQDK7PxrsrceZR26WIN/DpaRyGL04OdMtJyFykqdS+r6m+FAbr0D4CAbKFGur
         /8gjDIZwEj7RiSvztE1h/Ji9xq8jLWuZ8tDboRrySU7cvGddpXTVAMNtTv6SbthsUepz
         5ZCrlD2Y0RMw4806vqvRobK8V+0+symVo7q02rnHQtQkBd91kTlbJ7ss8IjfWiW+TxPS
         3crA==
X-Gm-Message-State: AJIora/L/lk0O0SyU3Jt/3Dpq2/VRqRIE+bxzb8w+d3nE0ny0uzryrr+
        QGpGcou5ygwKloZxtH1H9/O3wfJ19wU=
X-Google-Smtp-Source: AGRyM1veHh3avX/del4v++D7sBbehxtKH2f5YzN8lYMOurex2MXdu3iRVQsno2YSqsdW5PN9LnCp/A==
X-Received: by 2002:a05:600c:6009:b0:3a3:1506:f60f with SMTP id az9-20020a05600c600900b003a31506f60fmr21699255wmb.144.1658781279650;
        Mon, 25 Jul 2022 13:34:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w10-20020adfde8a000000b0021e50971147sm12610362wrl.44.2022.07.25.13.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 13:34:38 -0700 (PDT)
Message-Id: <40808e92afb7bcf3e8e9b4b53d5e30b5e17816f8.1658781277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
References: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jul 2022 20:34:33 +0000
Subject: [PATCH 1/5] remote-curl: add 'get' capability
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        szeder.dev@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

A future change will want a way to download a file over HTTP(S) using
the simplest of download mechanisms. We do not want to assume that the
server on the other side understands anything about the Git protocol but
could be a simple static web server.

Create the new 'get' capability for the remote helpers which advertises
that the 'get' command is avalable. A caller can send a line containing
'get <url> <path>' to download the file at <url> into the file at
<path>.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/gitremote-helpers.txt |  9 +++++++
 remote-curl.c                       | 32 +++++++++++++++++++++++++
 t/t5557-http-get.sh                 | 37 +++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100755 t/t5557-http-get.sh

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 6f1e269ae43..ed8da428c98 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -168,6 +168,9 @@ Supported commands: 'list', 'import'.
 	Can guarantee that when a clone is requested, the received
 	pack is self contained and is connected.
 
+'get'::
+	Can use the 'get' command to download a file from a given URI.
+
 If a helper advertises 'connect', Git will use it if possible and
 fall back to another capability if the helper requests so when
 connecting (see the 'connect' command under COMMANDS).
@@ -418,6 +421,12 @@ Supported if the helper has the "connect" capability.
 +
 Supported if the helper has the "stateless-connect" capability.
 
+'get' <uri> <path>::
+	Downloads the file from the given `<uri>` to the given `<path>`. If
+	`<path>.temp` exists, then Git assumes that the `.temp` file is a
+	partial download from a previous attempt and will resume the
+	download from that position.
+
 If a fatal error occurs, the program writes the error message to
 stderr and exits. The caller should expect that a suitable error
 message has been printed if the child closes the connection without
diff --git a/remote-curl.c b/remote-curl.c
index b8758757ece..73fbdbddd84 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1286,6 +1286,33 @@ static void parse_fetch(struct strbuf *buf)
 	strbuf_reset(buf);
 }
 
+static void parse_get(struct strbuf *buf)
+{
+	struct strbuf url = STRBUF_INIT;
+	struct strbuf path = STRBUF_INIT;
+	const char *p, *space;
+
+	if (!skip_prefix(buf->buf, "get ", &p))
+		die(_("http transport does not support %s"), buf->buf);
+
+	space = strchr(p, ' ');
+
+	if (!space)
+		die(_("protocol error: expected '<url> <path>', missing space"));
+
+	strbuf_add(&url, p, space - p);
+	strbuf_addstr(&path, space + 1);
+
+	if (http_get_file(url.buf, path.buf, NULL))
+		die(_("failed to download file at URL '%s'"), url.buf);
+
+	strbuf_release(&url);
+	strbuf_release(&path);
+	printf("\n");
+	fflush(stdout);
+	strbuf_reset(buf);
+}
+
 static int push_dav(int nr_spec, const char **specs)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -1564,9 +1591,14 @@ int cmd_main(int argc, const char **argv)
 				printf("unsupported\n");
 			fflush(stdout);
 
+		} else if (skip_prefix(buf.buf, "get ", &arg)) {
+			parse_get(&buf);
+			fflush(stdout);
+
 		} else if (!strcmp(buf.buf, "capabilities")) {
 			printf("stateless-connect\n");
 			printf("fetch\n");
+			printf("get\n");
 			printf("option\n");
 			printf("push\n");
 			printf("check-connectivity\n");
diff --git a/t/t5557-http-get.sh b/t/t5557-http-get.sh
new file mode 100755
index 00000000000..50b7dbcf957
--- /dev/null
+++ b/t/t5557-http-get.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description='test downloading a file by URL'
+
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'get by URL: 404' '
+	url="$HTTPD_URL/none.txt" &&
+	cat >input <<-EOF &&
+	capabilities
+	get $url file1
+	EOF
+
+	test_must_fail git remote-http $url <input 2>err &&
+	test_path_is_missing file1 &&
+	grep "failed to download file at URL" err &&
+	rm file1.temp
+'
+
+test_expect_success 'get by URL: 200' '
+	echo data >"$HTTPD_DOCUMENT_ROOT_PATH/exists.txt" &&
+
+	url="$HTTPD_URL/exists.txt" &&
+	cat >input <<-EOF &&
+	capabilities
+	get $url file2
+
+	EOF
+
+	GIT_TRACE2_PERF=1 git remote-http $url <input &&
+	test_cmp "$HTTPD_DOCUMENT_ROOT_PATH/exists.txt" file2
+'
+
+test_done
-- 
gitgitgadget

