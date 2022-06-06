Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD2BC433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 19:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiFFTzx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 15:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbiFFTzb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 15:55:31 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6775C663
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 12:55:30 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t13so21230374wrg.9
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 12:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=roYviVZ8WQy8VHN136fWD/I4C5Ve+n/NlfvpptSSn5w=;
        b=jKXy3R8Q3jeAN2/7oOjC2BNashYX1PspUIG4pNdPiph91eSF2tZZc6kW7h/5T8e24U
         djlqeyYyjtrhlwWSq2iLP1kL2ANQAy3QNxMLsXd1Zm0bEGbZaM+eq0srIFT/20bRGYMf
         YB3gbYbNTfXbYH6rkahuDf2Q0e1lBYvcjt5lnqtXmagPBx6rADl41/2ESfgLj437o6W7
         uIFZZmN+cwLJUouXLKM8llpzkOrTq8wzjI47EiysKBuuT4zosYGMwH7EjoLCMPbPefJS
         dBc/8sFKNVvzn8RuZC5UnWfcN7qLJts+JWhoDaxK+iKVnVetcb7SgXqLQkNSFE3HVH01
         28dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=roYviVZ8WQy8VHN136fWD/I4C5Ve+n/NlfvpptSSn5w=;
        b=ZTqtnygIZx89Ls9ukqibihAPkG9sM6a/yLEvsPjAllhvUGmvSL6NaINSqjyj4/ZLny
         +24D6utrDwjBEv8dvhJzA/mmbmnAkF+Gxcp7QpLATwq0JmXxVPyLnfxcwFJTTAvv2p9J
         RgVS4XMgOZkuLel98DakxSI7/DDrrhi5h6PrHSg1Lyr/NVO/paC9pwgP5rBiIk21e1Gp
         M1EovvfDBpvUHzKySKCe07cj4hom4eBSO2TtJTZCYgoFpf93nW3BZgNScx1DHtcEi6gP
         ouwggI0K+goWG4FUAt33REGiK+Y2i5vXKZxcH6LLljZVkKb9caf9RfTbWDOj4ETGy6dL
         QwJg==
X-Gm-Message-State: AOAM5322Y07JPBrI7K/iJaogtO3j828uSwRBoTbGV/D6Jb+tnSbzVGUK
        ZC2MgP8GonoHwtFh8HRvlZM4w/d44TqeJ5s7
X-Google-Smtp-Source: ABdhPJwRFv1m/Y7xjMCYT4rYTQuabRsBYXR8wT8peMwSMBGn0vI5Xno/22Kpj7KprL4neyiUoozHRg==
X-Received: by 2002:adf:e0c3:0:b0:20c:5672:9577 with SMTP id m3-20020adfe0c3000000b0020c56729577mr23545275wri.466.1654545328800;
        Mon, 06 Jun 2022 12:55:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h11-20020a5d688b000000b0020e63ab5d78sm15999527wru.26.2022.06.06.12.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 12:55:28 -0700 (PDT)
Message-Id: <977f0af40fc5cf3f0a7f167e2d2a47099168f47f.1654545325.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Jun 2022 19:55:21 +0000
Subject: [PATCH 2/6] remote-curl: add 'get' capability
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
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
 remote-curl.c                       | 33 +++++++++++++++++++++++++
 t/t5557-http-get.sh                 | 37 +++++++++++++++++++++++++++++
 transport-helper.c                  |  5 +++-
 4 files changed, 83 insertions(+), 1 deletion(-)
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
index 67f178b1120..f005419f872 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1276,6 +1276,34 @@ static void parse_fetch(struct strbuf *buf)
 	strbuf_reset(buf);
 }
 
+static void parse_get(struct strbuf *buf)
+{
+	struct http_get_options opts = { 0 };
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
+	if (http_get_file(url.buf, path.buf, &opts))
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
@@ -1549,9 +1577,14 @@ int cmd_main(int argc, const char **argv)
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
index 00000000000..1fd4ded3eb1
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
+	test_must_fail git remote-http $url $url <input 2>err &&
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
+	GIT_TRACE2_PERF=1 git remote-http $url $url <input &&
+	test_cmp "$HTTPD_DOCUMENT_ROOT_PATH/exists.txt" file2
+'
+
+test_done
diff --git a/transport-helper.c b/transport-helper.c
index b4dbbabb0c2..dfbeaebe40c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -33,7 +33,8 @@ struct helper_data {
 		check_connectivity : 1,
 		no_disconnect_req : 1,
 		no_private_update : 1,
-		object_format : 1;
+		object_format : 1,
+		get : 1;
 
 	/*
 	 * As an optimization, the transport code may invoke fetch before
@@ -210,6 +211,8 @@ static struct child_process *get_helper(struct transport *transport)
 			data->no_private_update = 1;
 		} else if (starts_with(capname, "object-format")) {
 			data->object_format = 1;
+		} else if (!strcmp(capname, "get")) {
+			data->get = 1;
 		} else if (mandatory) {
 			die(_("unknown mandatory capability %s; this remote "
 			      "helper probably needs newer version of Git"),
-- 
gitgitgadget

