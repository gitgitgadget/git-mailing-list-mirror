Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E78020248
	for <e@80x24.org>; Tue,  9 Apr 2019 20:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfDIUbn (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 16:31:43 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:36475 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfDIUbn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 16:31:43 -0400
Received: by mail-ot1-f74.google.com with SMTP id k28so10657389otf.3
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 13:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Tj7tN8hD2sV6s77GOLZBLyWda8/wpa5me6YqptRetnc=;
        b=P/UM+BhfYs7Dz7up00faijMJJy5A1DYdCyjclG4SH/ZpSCVE4Wa4icRNS5NDe8nIMC
         QY+XQ8N3GvdszCCWno7gJ/ZJA/vW4yIxWrc5+YZ24damW3tyIM+CWrxdZd0mzf+z3ALc
         3LB9EMuE/2gcaa2XJaCPg6Pv10uEEAd/9OVonmkiWQKpMavE0sRHRAOP8K2CmxialnZx
         hEJBdOEgXtSnN9t2PkptmppG6WEiASVQv/gMxkDi0iE8+QY6YFHF0Cg0jg9Ud8dR2BuQ
         9dZhanelVvoe2Ehwqi8hCiS4kJ/io4fUap4bcXSJyzrfRRquJhnCXeEyX1UZ403WTzHz
         HM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Tj7tN8hD2sV6s77GOLZBLyWda8/wpa5me6YqptRetnc=;
        b=PZukspZyLiwQs8yWNOVVIBUkn3C8E66Puh9moClbaltJl8RItgjP2TjrYqFv9ey6KZ
         ts+yVnHrP9IWSpqtSq/4eHzvnDQL+t4ws1lEVh2mOzSOyg68gidZJXu0NZEJfX660SNH
         pyI4d+G3/ZQHP4Oqw8u8EuOSM16BsMDTZE+XI7qjMHcn/Um7ftfH/Qevgt+VGkqMT3Dc
         /5QYqFbBfgi5uz+Q33s23/BoJPpZ2leJOmtd7a2zm9jO1272lIuyQZIvN16L7fdVzztl
         D7F/qP4pOSRgiIpkvtqJklfBdJ1uALk++FEnkFt7KgSyf6vSntDUuwSJbrsp9RhHpkBh
         KXhQ==
X-Gm-Message-State: APjAAAWasIr3RI7/ZIHcGhd/AifUjusnHlxibKECnIjLrpQHTr5TI83R
        Mot5ghs3p24aquCvJh4dAAc/nexl2IiCOKmhLmmkLfPtJsr9+GTo7t6/hEG20an3aFzcrsWsUBB
        ZJBuO3Cs0XswnIxl3JLDpudwwKzd7EJmI4Ps9SOU7H7Hs3mdbUaMxuj8E4L0IVGW4gi612Y8402
        eM
X-Google-Smtp-Source: APXvYqy8BlvJ7Lctta1pspgx5AtEzfcNjmoGA5mcnDjI+ZC1HOcH0OQJuZOGPEYuLuiD0FS/9GgcHCkuhrNKEb8uR6PS
X-Received: by 2002:aca:4c11:: with SMTP id z17mr3427128oia.13.1554841902374;
 Tue, 09 Apr 2019 13:31:42 -0700 (PDT)
Date:   Tue,  9 Apr 2019 13:31:34 -0700
In-Reply-To: <cover.1554841624.git.jonathantanmy@google.com>
Message-Id: <142c25abd2c5c5c477c44d0e47cb20a3d504ab1c.1554841624.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190405204413.93900-1-jonathantanmy@google.com> <cover.1554841624.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v2 2/2] clone: send server options when using protocol v2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 5e3548ef16 ("fetch: send server options when using protocol v2",
2018-04-24) taught "fetch" the ability to send server options when using
protocol v2, but not "clone". This ability is triggered by "-o" or
"--server-option".

Teach "clone" the same ability, except that because "clone" already
has "-o" for another parameter, teach "clone" only to receive
"--server-option".

Explain in the documentation, both for clone and for fetch, that server
handling of server options are server-specific.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/fetch-options.txt |  3 ++-
 Documentation/git-clone.txt     |  8 ++++++++
 builtin/clone.c                 |  6 ++++++
 t/t5702-protocol-v2.sh          | 21 +++++++++++++++++++++
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index fa0a3151b3..91c47752ec 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -216,7 +216,8 @@ endif::git-pull[]
 --server-option=<option>::
 	Transmit the given string to the server when communicating using
 	protocol version 2.  The given string must not contain a NUL or LF
-	character.
+	character.  The server's handling of server options, including
+	unknown ones, is server-specific.
 	When multiple `--server-option=<option>` are given, they are all
 	sent to the other side in the order listed on the command line.
 
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 2fd12524f9..a0f14b51f2 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -131,6 +131,14 @@ objects from the source repository into a pack in the cloned repository.
 	is specified. This flag forces progress status even if the
 	standard error stream is not directed to a terminal.
 
+--server-option=<option>::
+	Transmit the given string to the server when communicating using
+	protocol version 2.  The given string must not contain a NUL or LF
+	character.  The server's handling of server options, including
+	unknown ones, is server-specific.
+	When multiple `--server-option=<option>` are given, they are all
+	sent to the other side in the order listed on the command line.
+
 --no-checkout::
 -n::
 	No checkout of HEAD is performed after the clone is complete.
diff --git a/builtin/clone.c b/builtin/clone.c
index 50bde99618..31a47d190a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -66,6 +66,7 @@ static int option_dissociate;
 static int max_jobs = -1;
 static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
 static struct list_objects_filter_options filter_options;
+static struct string_list server_options = STRING_LIST_INIT_NODUP;
 
 static int recurse_submodules_cb(const struct option *opt,
 				 const char *arg, int unset)
@@ -137,6 +138,8 @@ static struct option builtin_clone_options[] = {
 		   N_("separate git dir from working tree")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 			N_("set config inside the new repository")),
+	OPT_STRING_LIST(0, "server-option", &server_options,
+			N_("server-specific"), N_("option to transmit")),
 	OPT_SET_INT('4', "ipv4", &family, N_("use IPv4 addresses only"),
 			TRANSPORT_FAMILY_IPV4),
 	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
@@ -1136,6 +1139,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK,
 				     option_upload_pack);
 
+	if (server_options.nr)
+		transport->server_options = &server_options;
+
 	if (filter_options.choice) {
 		struct strbuf expanded_filter_spec = STRBUF_INIT;
 		expand_list_objects_filter_spec(&filter_options,
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index f1a3ff1021..7ecef5f768 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -268,6 +268,27 @@ test_expect_success 'warn if using server-option with fetch with legacy protocol
 	grep "Ignoring server options" err
 '
 
+test_expect_success 'server-options are sent when cloning' '
+	test_when_finished "rm -rf log myclone" &&
+
+	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
+		clone --server-option=hello --server-option=world \
+		"file://$(pwd)/file_parent" myclone &&
+
+	grep "server-option=hello" log &&
+	grep "server-option=world" log
+'
+
+test_expect_success 'warn if using server-option with clone with legacy protocol' '
+	test_when_finished "rm -rf myclone" &&
+
+	GIT_TEST_PROTOCOL_VERSION=0 git -c protocol.version=0 \
+		clone --server-option=hello --server-option=world \
+		"file://$(pwd)/file_parent" myclone 2>err &&
+
+	grep "Ignoring server options" err
+'
+
 test_expect_success 'upload-pack respects config using protocol v2' '
 	git init server &&
 	write_script server/.git/hook <<-\EOF &&
-- 
2.21.0.392.gf8f6787159e-goog

