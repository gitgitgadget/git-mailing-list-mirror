Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8463A1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 22:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932574AbeDWWqm (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 18:46:42 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:34443 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932514AbeDWWqj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 18:46:39 -0400
Received: by mail-qk0-f202.google.com with SMTP id e21so12161106qkm.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 15:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=iTlOFxgGEJ5K55cGLRczodPAcMnQi7wOTsWaWDpBfOA=;
        b=mOzhGzb6AGxfbbqkum7PPnQqvmRTmb6To/0siKzzU0vPazgTw2/1D7eGjpBLlOskDB
         IDhr8cUh5aB2kzlfsvBFtGKWJUQqGx64yzzmsS87DRhItyQ/1lusOavJZBUIWC8lPNF5
         GlZVj8iM3za+cqGstPcA5/cHCtOjVNiRRjlpNgqtzNKmxy7HeqcU16PtyThyZ4g79d+W
         eyk19+UIr4xdj/Zn00tOlw1jFQdzHWs5afUiKEXDpBTAarOMuGVi0VrD7D7BEibj+ffD
         tUeb1njgNObzXiJzu+t9JCyaiZ/Dml6uWA+kimMty3Kkerz4Mb2cJct0tmrukMjPgmx1
         mrgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=iTlOFxgGEJ5K55cGLRczodPAcMnQi7wOTsWaWDpBfOA=;
        b=PzcbZEqA3G3GRLdifdCTl5eJk1ADqAM5hjtMwPgneYxQkmiqp0FIx7ZQ01v2ohLO0e
         exx447E8TJhxKcf3fTpvZOy/sZLVShAg2Zz2NUjh40hKgCVhtaP7AhZBiJt9vbYIKWAC
         v2upmz4PMIo8dX0xEgL1WQeuIzRH0nWBtA8i0/mQdwC0EIqpf47Cu2HfXyXmYmkn+rXA
         vNq8TqxiDYdgqWq37dImYVXjIK62xn/iKjT443am9SASeXkv8I3FVls+pQ961q3bXUuM
         eBgQN+aWNs8UkxCIwGXpeq+mvVHtHwhDIXk8x4tKYURyFJozvwAD9mr8mNVzgLIz3TUJ
         NxTA==
X-Gm-Message-State: ALQs6tDmNaUqVdHtxbOcOiCqPWbAAsE4Ia3gpDV9uDJFXJKEsVXUj9Gw
        s6AFwN49LskS3lxujHcSoiVPFHwd7m1q5IlPEhrmbmkRYKJ+PKlvt02kMxWUT40qrVeJAiYJ4qG
        2KHiMdY8y3uIkucDZWUSGWpVJ0k7+XCfjPrihVJJt9UZQjrSta9nXTlJ6nA==
X-Google-Smtp-Source: AIpwx4/OHl7KQ3X57XHktbUJDjAzyjYBt7en4wP3nZG5leBXeLcN2abg4QHujiROJ5eZEPPG8eC5jjOI3MA=
MIME-Version: 1.0
X-Received: by 2002:aed:3d76:: with SMTP id h51-v6mr13787819qtf.35.1524523598502;
 Mon, 23 Apr 2018 15:46:38 -0700 (PDT)
Date:   Mon, 23 Apr 2018 15:46:24 -0700
In-Reply-To: <20180423224624.213341-1-bmwill@google.com>
Message-Id: <20180423224624.213341-4-bmwill@google.com>
References: <20180423224624.213341-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Subject: [PATCH 3/3] fetch: send server options when using protocol v2
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach fetch to optionally accept server options by specifying them on
the cmdline via '-o' or '--server-option'.  These server options are
sent to the remote end when performing a fetch communicating using
protocol version 2.

If communicating using a protocol other than v2 the provided options are
ignored and not sent to the remote end.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/fetch-options.txt |  8 ++++++++
 builtin/fetch.c                 |  5 +++++
 fetch-pack.c                    |  7 +++++++
 fetch-pack.h                    |  1 +
 t/t5702-protocol-v2.sh          | 16 ++++++++++++++++
 transport.c                     |  1 +
 6 files changed, 38 insertions(+)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 8631e365f..97d3217df 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -188,6 +188,14 @@ endif::git-pull[]
 	is specified. This flag forces progress status even if the
 	standard error stream is not directed to a terminal.
 
+-o <option>::
+--server-option=<option>::
+	Transmit the given string to the server when communicating using
+	protocol version 2.  The given string must not contain a NUL or LF
+	character.
+	When multiple `--server-option=<option>` are given, they are all
+	sent to the other side in the order listed on the command line.
+
 -4::
 --ipv4::
 	Use IPv4 addresses only, ignoring IPv6 addresses.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7ee83ac0f..5a6f6b2dc 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -62,6 +62,7 @@ static int shown_url = 0;
 static int refmap_alloc, refmap_nr;
 static const char **refmap_array;
 static struct list_objects_filter_options filter_options;
+static struct string_list server_options = STRING_LIST_INIT_DUP;
 
 static int git_fetch_config(const char *k, const char *v, void *cb)
 {
@@ -170,6 +171,7 @@ static struct option builtin_fetch_options[] = {
 		 N_("accept refs that update .git/shallow")),
 	{ OPTION_CALLBACK, 0, "refmap", NULL, N_("refmap"),
 	  N_("specify fetch refmap"), PARSE_OPT_NONEG, parse_refmap_arg },
+	OPT_STRING_LIST('o', "server-option", &server_options, N_("server-specific"), N_("option to transmit")),
 	OPT_SET_INT('4', "ipv4", &family, N_("use IPv4 addresses only"),
 			TRANSPORT_FAMILY_IPV4),
 	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
@@ -1417,6 +1419,9 @@ static int fetch_one(struct remote *remote, int argc, const char **argv, int pru
 		}
 	}
 
+	if (server_options.nr)
+		gtransport->server_options = &server_options;
+
 	sigchain_push_common(unlock_pack_on_signal);
 	atexit(unlock_pack);
 	refspec = parse_fetch_refspec(ref_nr, refs);
diff --git a/fetch-pack.c b/fetch-pack.c
index 216d1368b..199eb8a1d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1174,6 +1174,13 @@ static int send_fetch_request(int fd_out, const struct fetch_pack_args *args,
 		packet_buf_write(&req_buf, "command=fetch");
 	if (server_supports_v2("agent", 0))
 		packet_buf_write(&req_buf, "agent=%s", git_user_agent_sanitized());
+	if (args->server_options && args->server_options->nr &&
+	    server_supports_v2("server-option", 1)) {
+		int i;
+		for (i = 0; i < args->server_options->nr; i++)
+			packet_write_fmt(fd_out, "server-option=%s",
+					 args->server_options->items[i].string);
+	}
 
 	packet_buf_delim(&req_buf);
 	if (args->use_thin_pack)
diff --git a/fetch-pack.h b/fetch-pack.h
index 667024a76..f4ba851c6 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -15,6 +15,7 @@ struct fetch_pack_args {
 	const char *deepen_since;
 	const struct string_list *deepen_not;
 	struct list_objects_filter_options filter_options;
+	const struct string_list *server_options;
 	unsigned deepen_relative:1;
 	unsigned quiet:1;
 	unsigned keep_pack:1;
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 71ef1aee1..dbfd0691c 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -217,6 +217,22 @@ test_expect_success 'ref advertisment is filtered during fetch using protocol v2
 	! grep "refs/tags/three" log
 '
 
+test_expect_success 'server-options are sent when fetching' '
+	test_when_finished "rm -f log" &&
+
+	test_commit -C file_parent four &&
+
+	GIT_TRACE_PACKET="$(pwd)/log" git -C file_child -c protocol.version=2 \
+		fetch -o hello -o world origin master &&
+
+	git -C file_child log -1 --format=%s origin/master >actual &&
+	git -C file_parent log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	grep "server-option=hello" log &&
+	grep "server-option=world" log
+'
+
 # Test protocol v2 with 'http://' transport
 #
 . "$TEST_DIRECTORY"/lib-httpd.sh
diff --git a/transport.c b/transport.c
index 42fd468f3..b088bcd49 100644
--- a/transport.c
+++ b/transport.c
@@ -266,6 +266,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.no_dependents = data->options.no_dependents;
 	args.filter_options = data->options.filter_options;
 	args.stateless_rpc = transport->stateless_rpc;
+	args.server_options = transport->server_options;
 
 	if (!data->got_remote_heads)
 		refs_tmp = get_refs_via_connect(transport, 0, NULL);
-- 
2.17.0.484.g0c8726318c-goog

