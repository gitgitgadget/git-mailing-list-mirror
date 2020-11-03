Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF88C00A89
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 00:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4569422268
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 00:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jivpCSFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgKCA1P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 19:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgKCA1O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 19:27:14 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C5BC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 16:27:14 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id z12so9140282qto.4
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 16:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wMB7rRaE+f+qYdBZR4vOfyPKyZuUBfNajYcnOZdqbaI=;
        b=jivpCSFTp/jYm8Kyt0ajhjMFObYknno0UeVp+4ECh2AZc6SF19Kh7tGu8cWtX+/5tj
         +XSKhWRg8eay/3OylHJnZlLTIyMZ4toLZ2Yr7XidbUkVOA67xZiRqzVNTI8r6xC5Y4if
         uzsW0ehxwiTX9h+1Ory3BB2OgIgqFdnIqYEhma4mUvx1sbTbGgQg4Tf3LeTQEYghmXOB
         OPROCavkiMVEd609zkFHQDre6uEwgnwz9/qsWaImv6x3LYQUGtY6v55jbXgOQp3tGy3q
         nTwtK6xdiDN5APEh+ebcjCNrBz4ZnMA6PgRQRiwtjeiPCzQCU9CnbFw4qKXcf3ua6VSS
         XItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wMB7rRaE+f+qYdBZR4vOfyPKyZuUBfNajYcnOZdqbaI=;
        b=sHu8PRR6MzjaVHzsQUWiqbrPexWpJlLCd7fWTMgmh9a2BSSN67CFQQ0CigOYGWC+xQ
         bQF+zUE/+jcprCkLiRt02aurN/QLo43r8qeptFo4ctnqPbily/CPJ5gU+bgK48rK+xCC
         Q9uOqG2jnq3SXwz9OWaH3xygHLKUCV/4vStk2LTUBfEX6Ss3mxejWZnHttPds4dgKodU
         c5TdzpJzpjTu+wf551OjjE12GPPeyFNQbOVdy6tZ4+7V8z8TxaLpSCJc4ZS8X46H6Z6C
         kz/qZzu8MLCr0JOeXFI06jKpoNW+39I3Fr07pwQNyDTT0lGWPLgPGxRPwulX14OExRkd
         APnw==
X-Gm-Message-State: AOAM533LUNXACR3EH4DQLgJPEWPnZnM1JAz5Bdj/0rR85dO3rCsqsYtU
        0tkKHxo6YSlz82OgkYRmnbD+xZYdodDl4AX/AIUwqBNBoVdQrhNd3QO4WNusfM/9r5miahF4xEN
        vOKL8VK/XnFT9AWqCSBTyfl+Jbx9bj8hENEDbGTng6Q9hrxiXATVpE5lBwr65q0j/3WZSjLt/YG
        ra
X-Google-Smtp-Source: ABdhPJwiaD3ERVkVxvU6+jmklynqtNDMbUNf9S8+JXe5zjvWHlAtymt09Rh0eB5uNNmb+4L/dWV6wPzQGxDXDvTesfpn
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:b525:: with SMTP id
 d37mr24922151qve.31.1604363233313; Mon, 02 Nov 2020 16:27:13 -0800 (PST)
Date:   Mon,  2 Nov 2020 16:26:12 -0800
In-Reply-To: <cover.1604362701.git.jonathantanmy@google.com>
Message-Id: <d0a996f77689a12a52b192599fd5e6d27192a648.1604362701.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1604362701.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 3/4] remote-curl: teach --base for http(s)://
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For the http(s):// transports, teach push the "--base" parameter, which
indicates an ancestor of the commits to be pushed that is believed to be
known by the server.

This is done through a new remote helper capability and option
"push-base". If a remote helper advertises this capability, then it also
supports the option of the same name. Git can then use this option to
inform the remote helper of a base that the user has specified.

See the commit message of this commit's parent for more information.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/gitremote-helpers.txt |  8 ++++++++
 remote-curl.c                       | 25 +++++++++++++++++-------
 t/t5700-protocol-v1.sh              | 30 +++++++++++++++++++++++++++++
 transport-helper.c                  | 15 +++++++++++++++
 4 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 6f1e269ae4..b4eff16a59 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -116,6 +116,9 @@ Supported commands: 'stateless-connect'.
 +
 Supported commands: 'list for-push', 'push'.
 
+'push-base'::
+	Indicates that this remote helper supports the 'push-base' option.
+
 'export'::
 	Can discover remote refs and push specified objects from a
 	fast-import stream to remote refs.
@@ -541,6 +544,11 @@ set by Git if the remote helper has the 'option' capability.
 If set to an algorithm, indicate that the caller wants to interact with
 the remote side using that algorithm.
 
+'option push-base' <ref>::
+	Only supported if this remote helper advertises the 'push-base'
+	capability. Indicate that <ref> is an ancestor of the commits to be
+	pushed, and it is believed to be known by the server.
+
 SEE ALSO
 --------
 linkgit:git-remote[1]
diff --git a/remote-curl.c b/remote-curl.c
index 32cc4a0c55..7919e4ebcf 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -29,6 +29,7 @@ struct options {
 	struct string_list deepen_not;
 	struct string_list push_options;
 	char *filter;
+	struct object_id push_base;
 	unsigned progress : 1,
 		check_self_contained_and_connected : 1,
 		cloning : 1,
@@ -205,6 +206,10 @@ static int set_option(const char *name, const char *value)
 			options.hash_algo = &hash_algos[algo];
 		}
 		return 0;
+	} else if (!strcmp(name, "push-base")) {
+		if (get_oid(value, &options.push_base))
+			die(_("%s is not a valid object"), value);
+		return 0;
 	} else {
 		return 1 /* unsupported */;
 	}
@@ -364,16 +369,21 @@ static int show_http_message(struct strbuf *type, struct strbuf *charset,
 }
 
 static int get_protocol_http_header(enum protocol_version version,
+				    const struct object_id *base,
 				    struct strbuf *header)
 {
-	if (version > 0) {
+	if (version > 0)
 		strbuf_addf(header, GIT_PROTOCOL_HEADER ": version=%d",
 			    version);
-
-		return 1;
+	if (!is_null_oid(base)) {
+		if (version > 0)
+			strbuf_addch(header, ':');
+		else
+			strbuf_addstr(header, GIT_PROTOCOL_HEADER ": ");
+		strbuf_addf(header, "base=%s", oid_to_hex(base));
 	}
 
-	return 0;
+	return !!(version > 0 || !(is_null_oid(base)));
 }
 
 static void check_smart_http(struct discovery *d, const char *service,
@@ -469,7 +479,7 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		version = protocol_v0;
 
 	/* Add the extra Git-Protocol header */
-	if (get_protocol_http_header(version, &protocol_header))
+	if (get_protocol_http_header(version, &options.push_base, &protocol_header))
 		string_list_append(&extra_headers, protocol_header.buf);
 
 	memset(&http_options, 0, sizeof(http_options));
@@ -1074,7 +1084,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
 	strbuf_addf(&buf, "Accept: application/x-%s-result", svc);
 	rpc->hdr_accept = strbuf_detach(&buf, NULL);
 
-	if (get_protocol_http_header(heads->version, &buf))
+	if (get_protocol_http_header(heads->version, &options.push_base, &buf))
 		rpc->protocol_header = strbuf_detach(&buf, NULL);
 	else
 		rpc->protocol_header = NULL;
@@ -1406,7 +1416,7 @@ static int stateless_connect(const char *service_name)
 	rpc.service_url = xstrfmt("%s%s", url.buf, rpc.service_name);
 	rpc.hdr_content_type = xstrfmt("Content-Type: application/x-%s-request", rpc.service_name);
 	rpc.hdr_accept = xstrfmt("Accept: application/x-%s-result", rpc.service_name);
-	if (get_protocol_http_header(discover->version, &buf)) {
+	if (get_protocol_http_header(discover->version, &options.push_base, &buf)) {
 		rpc.protocol_header = strbuf_detach(&buf, NULL);
 	} else {
 		rpc.protocol_header = NULL;
@@ -1538,6 +1548,7 @@ int cmd_main(int argc, const char **argv)
 			printf("push\n");
 			printf("check-connectivity\n");
 			printf("object-format\n");
+			printf("push-base\n");
 			printf("\n");
 			fflush(stdout);
 		} else if (skip_prefix(buf.buf, "stateless-connect ", &arg)) {
diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
index 22459d37f5..4ee29c1be0 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -373,6 +373,36 @@ test_expect_success 'push with http:// using protocol v1' '
 	grep "git< version 1" log
 '
 
+test_expect_success 'push with http:// using protocol v1 and --base' '
+	test_commit -C http_child four &&
+	COMMON_HASH=$(git -C http_child rev-parse three) &&
+
+	# Push to another branch, as the target repository has the
+	# master branch checked out and we cannot push into it.
+	GIT_TRACE_PACKET=1 test_might_fail git -C http_child -c protocol.version=1 \
+		push --base=three origin HEAD:client_branch_four 2>log &&
+
+	# Server responded using protocol v1
+	grep "git< version 1" log &&
+	# Server advertised only the expected object
+	grep "$COMMON_HASH .have" log
+'
+
+test_expect_success 'push with http:// using protocol v0 and --base' '
+	test_commit -C http_child five &&
+	COMMON_HASH=$(git -C http_child rev-parse four) &&
+
+	# Push to another branch, as the target repository has the
+	# master branch checked out and we cannot push into it.
+	GIT_TRACE_PACKET=1 git -C http_child -c protocol.version=0 \
+		push --base=four origin HEAD:client_branch_five 2>log &&
+
+	# Server did not respond with any version
+	! grep "git< version" log &&
+	# Server advertised only the expected object
+	grep "$COMMON_HASH .have" log
+'
+
 # DO NOT add non-httpd-specific tests here, because the last part of this
 # test script is only executed when httpd is available and enabled.
 
diff --git a/transport-helper.c b/transport-helper.c
index b573b6c730..15d9527419 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -27,6 +27,7 @@ struct helper_data {
 		export : 1,
 		option : 1,
 		push : 1,
+		push_base : 1,
 		connect : 1,
 		stateless_connect : 1,
 		signed_tags : 1,
@@ -186,6 +187,8 @@ static struct child_process *get_helper(struct transport *transport)
 			data->option = 1;
 		else if (!strcmp(capname, "push"))
 			data->push = 1;
+		else if (!strcmp(capname, "push-base"))
+			data->push_base = 1;
 		else if (!strcmp(capname, "import"))
 			data->import = 1;
 		else if (!strcmp(capname, "bidi-import"))
@@ -1183,6 +1186,18 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
 			exit(128);
 	}
 
+	if (!is_null_oid(&data->transport_options.push_base)) {
+		if (data->push_base) {
+			write_str_in_full(helper->in, "option push-base ");
+			write_str_in_full(helper->in, oid_to_hex(&data->transport_options.push_base));
+			write_str_in_full(helper->in, "\n");
+			if (recvline(data, &buf) || strcmp(buf.buf, "ok"))
+				exit(128);
+		} else {
+			warning(_("transport does not support --base"));
+		}
+	}
+
 	if (data->push && for_push)
 		write_str_in_full(helper->in, "list for-push\n");
 	else
-- 
2.29.1.341.ge80a0c044ae-goog

