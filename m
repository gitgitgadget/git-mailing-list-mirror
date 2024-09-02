Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A3119E972
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725279244; cv=none; b=ikWdrAQUsU2BZQq4vWkEDb7Wajz8ExIKHJCuHCDiRiPheN29dFSR9v+Xq6QKdPNnm9WUDGzPJYl1JFuKLjJaOnUJ4l8onxN9D2kgew4MNY+C2aGL+3w/R0wpVCUa/RciVKHfE5MyXUVO/SymxBp+7AjLlaHDlhA1U+Qs5ylQXcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725279244; c=relaxed/simple;
	bh=J9evciFjy21Cv4mkdL0vdvZaylQj0gcwFv0sDmaUV0Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MVyMfMLwfml1TsQ/F67UYr1rleaYsIKTvUo7enaZzW9oyWvu/fynINAfxSz7/eA6KDCcSo5YtjrEmJp/8FF4nyPvMhkQFjbpww6eoxdDPRQ84QKZvs/IL7M5NYkaVMiaOigmypANhBvkUneyDOL6K931GHyDXXYgSukpJRsIPHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcdDWoK0; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcdDWoK0"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a843bef98so417580366b.2
        for <git@vger.kernel.org>; Mon, 02 Sep 2024 05:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725279240; x=1725884040; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0DfQUCEiul5DlW3aptNnboK7UWTR8BkQZ+f0M26DD0=;
        b=hcdDWoK0Qf14Wk7JVFGjjFjvyts0hNexiglU2OMvhayYiYD2/qluxxW3Rn96j0xHYu
         qzL6DL2pWZPQwYVY1WM3p7Do26O4A2/z7XEgPf+88JiZ6DwtCXYlifczf1zhyM+d6/7k
         CG4EAoFxZ4GSlYIWo1OFPERoammp0MfiwKIhCWoblb91JVUnEfNdpDDKRoUFw6V4lOwM
         3SPMgSB8Cjq1dMdMPzfBk/8StwhjQtEBL8b5FPsKW7DNCgiy0pPXMw2YYjWFAXo1eCrw
         CelRCYLDNWGBRMrdCTT5T3WgtPbR4wRC6GwmJwuFIzZlHY7R6SRIWv4FLltO6jXPiafF
         +Ykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725279240; x=1725884040;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0DfQUCEiul5DlW3aptNnboK7UWTR8BkQZ+f0M26DD0=;
        b=IQbVmDKCJ2MMCn4pfgfCFMKJ+aVOKOEHOuCoX+HlPrRGzMaolAmnn4SMnnXh1Y1BSH
         Di4zmUwfqz8fclVVP/V25NrujAtED2GPMTZrsAuSMg7it+6HAdkzyuQX9VMUFHdtCSLB
         5HCkmutizXIQ7t+HQxvkxkKLqF96M94Q/ZY/qRsedLQr/bWmBBTG9T8cFaSjrh6p044r
         9xlMV0MsuiSWHShcBYt4i4UT8V3bgSIUaY0ucfooKcmW0697axtb23WuHlXALqElal8M
         Ns6FIM4BSAidQv+/NhZSE96yp/BfsH4NLSxhNxTrgkYEOuJ4fhIN3ELuhHKDHKxB3WX1
         VLwQ==
X-Gm-Message-State: AOJu0YyNlDZ59yOLtrnzy/l78rYJpIfdteByz17zueYZQSl7GUw8NToG
	6OixGjTZsgkc/ut67ciC9qTVO/Mv8bYu0SneYVUlGZaDiwSaI/i3Nt2i4Q==
X-Google-Smtp-Source: AGHT+IFsHx+72TGvFc2EUVHbgBJnTSDOJl1Ec5wJ2fMynLU4518ykZAh3R6kThVuywWr+N+52+O3XA==
X-Received: by 2002:a17:907:7b92:b0:a7d:e98c:5bd1 with SMTP id a640c23a62f3a-a89d8782279mr513920666b.26.1725279239633;
        Mon, 02 Sep 2024 05:13:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d6d88sm553211466b.151.2024.09.02.05.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 05:13:59 -0700 (PDT)
Message-Id: <7e2d5c504d762bb9cdb9ca008b92d349d81c194b.1725279236.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Sep 2024 12:13:54 +0000
Subject: [PATCH 2/4] builtin/fetch.c: add fetch.serverOption configuration
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Brandon Williams <bmwill@google.com>,
    Jonathan Tan <jonathantanmy@google.com>,
    blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

Currently, server options for Git protocol v2 can only be passed via the
command line using "--server-option <option>", which is inconvenient
when we want to specify a list of default options to send.

This commit introduces a new multi-valued configuration
`fetch.serverOption`, which is designed similar to `push.pushOption`. It
allows specifying default server options to be sent automatically if not
explicitly set. Subsequent commits will extend this configuration to
other commands that involve server options, such as git-ls-remote and
git-clone.

When server options are set in lower-priority configuration files (e.g.,
/etc/gitconfig or $HOME/.gitconfig), they can be overridden or unset in
more specific repository configurations using an empty string.

Tests and documentation have been updated accordingly.

Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 Documentation/config/fetch.txt  | 29 +++++++++++++++++++++++
 Documentation/fetch-options.txt |  3 +++
 builtin/fetch.c                 | 31 +++++++++++++++++-------
 t/t5702-protocol-v2.sh          | 42 +++++++++++++++++++++++++++------
 4 files changed, 90 insertions(+), 15 deletions(-)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index d7dc461bd16..9987d2a7425 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -126,3 +126,32 @@ fetch.bundleCreationToken::
 The creation token values are chosen by the provider serving the specific
 bundle URI. If you modify the URI at `fetch.bundleURI`, then be sure to
 remove the value for the `fetch.bundleCreationToken` value before fetching.
+
+fetch.serverOption::
+	When no `--server-option=<option>` argument is given from the
+	command line, fetch behaves as if each <value> of this variable is
+	given as `--server-option=<value>`.
++
+This is a multi-valued variable, and an empty value can be used in a higher
+priority configuration file (e.g. `.git/config` in a repository) to clear
+the values inherited from a lower priority configuration files (e.g.
+`$HOME/.gitconfig`).
++
+----
+
+Example:
+
+/etc/gitconfig
+  fetch.serverOption = a
+  fetch.serverOption = b
+
+~/.gitconfig
+  fetch.serverOption = c
+
+repo/.git/config
+  fetch.serverOption =
+  fetch.serverOption = b
+
+This will result in only b (a and c are cleared).
+
+----
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index e22b217fba9..39969aeb326 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -304,6 +304,9 @@ endif::git-pull[]
 	unknown ones, is server-specific.
 	When multiple `--server-option=<option>` are given, they are all
 	sent to the other side in the order listed on the command line.
+	When no `--server-option=<option>` is given from the command
+	line, the values of configuration variable `fetch.serverOption`
+	are used instead.
 
 --show-forced-updates::
 	By default, git checks if a branch is force-updated during
diff --git a/builtin/fetch.c b/builtin/fetch.c
index c297569a473..d49dff8a76a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -95,7 +95,7 @@ static struct transport *gtransport;
 static struct transport *gsecondary;
 static struct refspec refmap = REFSPEC_INIT_FETCH;
 static struct list_objects_filter_options filter_options = LIST_OBJECTS_FILTER_INIT;
-static struct string_list server_options = STRING_LIST_INIT_DUP;
+static struct string_list config_server_options = STRING_LIST_INIT_DUP;
 static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
 
 struct fetch_config {
@@ -170,6 +170,13 @@ static int git_fetch_config(const char *k, const char *v,
 			    "fetch.output", v);
 	}
 
+	if (!strcmp(k, "fetch.serveroption")) {
+		if (!v)
+			return config_error_nonbool(k);
+		parse_transport_option(v, &config_server_options);
+		return 0;
+	}
+
 	return git_default_config(k, v, ctx, cb);
 }
 
@@ -2063,7 +2070,8 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 
 static int fetch_one(struct remote *remote, int argc, const char **argv,
 		     int prune_tags_ok, int use_stdin_refspecs,
-		     const struct fetch_config *config)
+		     const struct fetch_config *config,
+		     struct string_list *server_options)
 {
 	struct refspec rs = REFSPEC_INIT_FETCH;
 	int i;
@@ -2124,8 +2132,8 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 		strbuf_release(&line);
 	}
 
-	if (server_options.nr)
-		gtransport->server_options = &server_options;
+	if (server_options && server_options->nr)
+		gtransport->server_options = server_options;
 
 	sigchain_push_common(unlock_pack_on_signal);
 	atexit(unlock_pack_atexit);
@@ -2152,6 +2160,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	const char *submodule_prefix = "";
 	const char *bundle_uri;
 	struct string_list list = STRING_LIST_INIT_DUP;
+	struct string_list option_server_options = STRING_LIST_INIT_DUP;
+	struct string_list *server_options = NULL;
 	struct remote *remote = NULL;
 	int all = -1, multiple = 0;
 	int result = 0;
@@ -2231,7 +2241,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			 N_("accept refs that update .git/shallow")),
 		OPT_CALLBACK_F(0, "refmap", &refmap, N_("refmap"),
 			       N_("specify fetch refmap"), PARSE_OPT_NONEG, parse_refmap_arg),
-		OPT_STRING_LIST('o', "server-option", &server_options, N_("server-specific"), N_("option to transmit")),
+		OPT_STRING_LIST('o', "server-option", &option_server_options, N_("server-specific"),
+				N_("option to transmit")),
 		OPT_IPVERSION(&family),
 		OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
 				N_("report that we have only objects reachable from this object")),
@@ -2272,6 +2283,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
 
+	server_options = option_server_options.nr ?
+			 &option_server_options : &config_server_options;
+
 	if (recurse_submodules_cli != RECURSE_SUBMODULES_DEFAULT)
 		config.recurse_submodules = recurse_submodules_cli;
 
@@ -2418,8 +2432,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			result = 1;
 			goto cleanup;
 		}
-		if (server_options.nr)
-			gtransport->server_options = &server_options;
+		if (server_options && server_options->nr)
+			gtransport->server_options = server_options;
 		result = transport_fetch_refs(gtransport, NULL);
 
 		oidset_iter_init(&acked_commits, &iter);
@@ -2430,7 +2444,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		if (filter_options.choice || repo_has_promisor_remote(the_repository))
 			fetch_one_setup_partial(remote);
 		result = fetch_one(remote, argc, argv, prune_tags_ok, stdin_refspecs,
-				   &config);
+				   &config, server_options);
 	} else {
 		int max_children = max_jobs;
 
@@ -2529,5 +2543,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
  cleanup:
 	string_list_clear(&list, 0);
+	string_list_clear(&option_server_options, 0);
 	return result;
 }
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 1ef540f73d3..ae25400010e 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -368,17 +368,45 @@ test_expect_success 'ref advertisement is filtered during fetch using protocol v
 test_expect_success 'server-options are sent when fetching' '
 	test_when_finished "rm -f log" &&
 
-	test_commit -C file_parent four &&
-
+	# Specify server options from command line
 	GIT_TRACE_PACKET="$(pwd)/log" git -C file_child -c protocol.version=2 \
 		fetch -o hello -o world origin main &&
+	test_grep "server-option=hello" log &&
+	test_grep "server-option=world" log &&
+	rm -f log &&
 
-	git -C file_child log -1 --format=%s origin/main >actual &&
-	git -C file_parent log -1 --format=%s >expect &&
-	test_cmp expect actual &&
+	# Specify server options from fetch.serverOption config
+	GIT_TRACE_PACKET="$(pwd)/log" git -C file_child -c protocol.version=2 \
+		-c fetch.serverOption=hello -c fetch.serverOption=world \
+		fetch origin main &&
+	test_grep "server-option=hello" log &&
+	test_grep "server-option=world" log &&
+	rm -f log &&
 
-	grep "server-option=hello" log &&
-	grep "server-option=world" log
+	# Cmdline server options take a higher priority
+	GIT_TRACE_PACKET="$(pwd)/log" git -C file_child -c protocol.version=2 \
+		-c fetch.serverOption=hello -c fetch.serverOption=world \
+		fetch -o foo=bar origin main &&
+	test_grep ! "server-option=hello" log &&
+	test_grep ! "server-option=world" log &&
+	test_grep "server-option=foo=bar" log
+'
+
+test_expect_success 'empty value of fetch.serverOption in config clears the list' '
+	test_when_finished "rm -f log" &&
+	GIT_TRACE_PACKET="$(pwd)/log" git -C file_child -c protocol.version=2 \
+		-c fetch.serverOption=hello -c fetch.serverOption=world \
+		-c fetch.serverOption= -c fetch.serverOption=foo=bar \
+		fetch origin main &&
+	test_grep ! "server-option=hello" log &&
+	test_grep ! "server-option=world" log &&
+	test_grep "server-option=foo=bar" log
+'
+
+test_expect_success 'invalid fetch.serverOption in config' '
+	test_when_finished "rm -f log" &&
+	test_must_fail git -C file_child -c protocol.version=2 \
+		-c fetch.serverOption fetch origin main
 '
 
 test_expect_success 'warn if using server-option with fetch with legacy protocol' '
-- 
gitgitgadget

