Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 139691F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbeACATM (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:19:12 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:34320 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbeACAS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:18:59 -0500
Received: by mail-it0-f50.google.com with SMTP id m11so12559139iti.1
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9J7vhHb2d2edB1oxfgWZTnynWWHoTxg11iygRlZu4EQ=;
        b=biFO5C4ZjWvFxSfpiGakbIBW5PinTT2WMkbHAGstBO2p5vLk0hmlKXa9/8jYTxUWDU
         i6T2hCloqym2rylSSQY9Lcs5MayKPM4+aIXIueo0eiSlQ+mqFCJQrPd4xtM7+B23wDmE
         YOs6fHwZqDj9t4Dk0a1MiwmNhsSBITRlmVamuO4GsIxYqfALWgfKwdpTezuW/7Pw3zFO
         b89wYDH2eq//NhFnpbGFMex4kVqycVsepunQ3lq2F5hcby0z9yW95ZdiVR6uJS+GT5DV
         0MZRLpJ5Znn32Wuj8P80PUowbnTQYU5IOQ/qibaQo3amT31Ksy7nmkU5ONlFGHNGlk06
         V3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9J7vhHb2d2edB1oxfgWZTnynWWHoTxg11iygRlZu4EQ=;
        b=YUXa/E91MYRktGWlDlWEnisGEBXoYfwZ8N9nZR5UyjIfFTbLryz3rNuiAFOCFIMcbd
         OItvFNrCrmCqlvPM8RkvqBqUYq9RmkN6pK5+FQl9DEdAdvdMkkaw9k5qZpxQ+K+ISPAp
         gOqykUHfpkDBd6EkHHwFb5eNPnZbFxILXK8NjMRSWYUS1Lu8CBqCOXRSkVF6kE5YNcEm
         JLIPk8M/oDlJVAlU6vJQAP7h/tFugbVItfkvQc6a2rTmC94zJj6rpVzam+sjTL6dqrHM
         VNaHUpW29sxAoRRuJTirrLGqqkow41mEhNUSbjoHZIu9Gb1l7MGxm5sImtM3sjg5DKi6
         lFAA==
X-Gm-Message-State: AKGB3mJ7xKd/CcwQd5G33O9hvm4msdjaJTUgp0HsZemvRQ5JWl2dMgCQ
        uRR9zfbpzrzE5H86aFg2b6xUwWdOng0=
X-Google-Smtp-Source: ACJfBoseYB/4eD/QcNMrevEYEAdutq74wOePW/F5qCjtWiXrswMWiqO0yrsgG3yFeU68zUT0sV1HaQ==
X-Received: by 10.36.34.12 with SMTP id o12mr90405ito.115.1514938738540;
        Tue, 02 Jan 2018 16:18:58 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:18:57 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 12/26] ls-refs: introduce ls-refs server command
Date:   Tue,  2 Jan 2018 16:18:14 -0800
Message-Id: <20180103001828.205012-13-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce the ls-refs server command.  In protocol v2, the ls-refs
command is used to request the ref advertisement from the server.  Since
it is a command which can be requested (as opposed to mandatory in v1),
a client can sent a number of parameters in its request to limit the ref
advertisement based on provided ref-patterns.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/technical/protocol-v2.txt | 26 +++++++++
 Makefile                                |  1 +
 ls-refs.c                               | 97 +++++++++++++++++++++++++++++++++
 ls-refs.h                               |  9 +++
 serve.c                                 |  2 +
 5 files changed, 135 insertions(+)
 create mode 100644 ls-refs.c
 create mode 100644 ls-refs.h

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index b87ba3816..5f4d0e719 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -89,3 +89,29 @@ terminate the connection.
 Commands are the core actions that a client wants to perform (fetch, push,
 etc).  Each command will be provided with a list capabilities and
 arguments as requested by a client.
+
+ Ls-refs
+---------
+
+Ls-refs is the command used to request a reference advertisement in v2.
+Unlike the current reference advertisement, ls-refs takes in parameters
+which can be used to limit the refs sent from the server.
+
+Ls-ref takes in the following parameters wraped in packet-lines:
+
+  symrefs: In addition to the object pointed by it, show the underlying
+	   ref pointed by it when showing a symbolic ref.
+  peel: Show peeled tags.
+  ref-pattern <pattern>: When specified, only references matching the
+			 given patterns are displayed.
+
+The output of ls-refs is as follows:
+
+    output = *ref
+	     flush-pkt
+    ref = PKT-LINE((tip | peeled) LF)
+    tip = obj-id SP refname (SP symref-target)
+    peeled = obj-id SP refname "^{}"
+
+    symref = PKT-LINE("symref" SP symbolic-ref SP resolved-ref LF)
+    shallow = PKT-LINE("shallow" SP obj-id LF)
diff --git a/Makefile b/Makefile
index 5f3b5fe8b..152a73bec 100644
--- a/Makefile
+++ b/Makefile
@@ -820,6 +820,7 @@ LIB_OBJS += list-objects-filter-options.o
 LIB_OBJS += ll-merge.o
 LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
+LIB_OBJS += ls-refs.o
 LIB_OBJS += mailinfo.o
 LIB_OBJS += mailmap.o
 LIB_OBJS += match-trees.o
diff --git a/ls-refs.c b/ls-refs.c
new file mode 100644
index 000000000..ac4904a40
--- /dev/null
+++ b/ls-refs.c
@@ -0,0 +1,97 @@
+#include "cache.h"
+#include "repository.h"
+#include "refs.h"
+#include "remote.h"
+#include "argv-array.h"
+#include "ls-refs.h"
+#include "pkt-line.h"
+
+struct ls_refs_data {
+	unsigned peel;
+	unsigned symrefs;
+	struct argv_array patterns;
+};
+
+/*
+ * Check if one of the patterns matches the tail part of the ref.
+ * If no patterns were provided, all refs match.
+ */
+static int ref_match(const struct argv_array *patterns, const char *refname)
+{
+	char *pathbuf;
+	int i;
+
+	if (!patterns->argc)
+		return 1; /* no restriction */
+
+	pathbuf = xstrfmt("/%s", refname);
+	for (i = 0; i < patterns->argc; i++) {
+		if (!wildmatch(patterns->argv[i], pathbuf, 0)) {
+			free(pathbuf);
+			return 1;
+		}
+	}
+	free(pathbuf);
+	return 0;
+}
+
+static int send_ref(const char *refname, const struct object_id *oid,
+		    int flag, void *cb_data)
+{
+	struct ls_refs_data *data = cb_data;
+	const char *refname_nons = strip_namespace(refname);
+	struct strbuf refline = STRBUF_INIT;
+
+	if (!ref_match(&data->patterns, refname))
+		return 0;
+
+	strbuf_addf(&refline, "%s %s", oid_to_hex(oid), refname_nons);
+	if (data->symrefs && flag & REF_ISSYMREF) {
+		struct object_id unused;
+		const char *symref_target = resolve_ref_unsafe(refname, 0,
+							       &unused,
+							       &flag);
+
+		if (!symref_target)
+			die("'%s' is a symref but it is not?", refname);
+
+		strbuf_addf(&refline, " %s", symref_target);
+	}
+
+	strbuf_addch(&refline, '\n');
+
+	packet_write(1, refline.buf, refline.len);
+	if (data->peel) {
+		struct object_id peeled;
+		if (!peel_ref(refname, &peeled))
+			packet_write_fmt(1, "%s %s^{}\n", oid_to_hex(&peeled),
+					 refname_nons);
+	}
+
+	strbuf_release(&refline);
+	return 0;
+}
+
+int ls_refs(struct repository *r, struct argv_array *keys, struct argv_array *args)
+{
+	int i;
+	struct ls_refs_data data = { 0, 0, ARGV_ARRAY_INIT };
+
+	for (i = 0; i < args->argc; i++) {
+		const char *arg = args->argv[i];
+		const char *out;
+
+		if (!strcmp("peel", arg))
+			data.peel = 1;
+		else if (!strcmp("symrefs", arg))
+			data.symrefs = 1;
+		else if (skip_prefix(arg, "ref-pattern ", &out))
+			argv_array_pushf(&data.patterns, "*/%s", out);
+	}
+
+	head_ref_namespaced(send_ref, &data);
+	for_each_namespaced_ref(send_ref, &data);
+	packet_flush(1);
+	argv_array_clear(&data.patterns);
+	return 0;
+}
diff --git a/ls-refs.h b/ls-refs.h
new file mode 100644
index 000000000..9e4c57bfe
--- /dev/null
+++ b/ls-refs.h
@@ -0,0 +1,9 @@
+#ifndef LS_REFS_H
+#define LS_REFS_H
+
+struct repository;
+struct argv_array;
+extern int ls_refs(struct repository *r, struct argv_array *keys,
+		   struct argv_array *args);
+
+#endif /* LS_REFS_H */
diff --git a/serve.c b/serve.c
index da8127775..88d548410 100644
--- a/serve.c
+++ b/serve.c
@@ -4,6 +4,7 @@
 #include "pkt-line.h"
 #include "version.h"
 #include "argv-array.h"
+#include "ls-refs.h"
 #include "serve.h"
 
 static int always_advertise(struct repository *r,
@@ -44,6 +45,7 @@ struct protocol_capability {
 static struct protocol_capability capabilities[] = {
 	{ "agent", agent_advertise, NULL },
 	{ "stateless-rpc", always_advertise, NULL },
+	{ "ls-refs", always_advertise, ls_refs },
 };
 
 static void advertise_capabilities(void)
-- 
2.15.1.620.gb9897f4670-goog

