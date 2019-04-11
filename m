Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95B5120248
	for <e@80x24.org>; Thu, 11 Apr 2019 20:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfDKUaX (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 16:30:23 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:55943 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDKUaX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 16:30:23 -0400
Received: by mail-pg1-f201.google.com with SMTP id 14so5059720pgf.22
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 13:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GN6bHxTyxXXFGcLyHnAqRzqt+IGwDS6MCFvgwrIzCQU=;
        b=E+eL15Qq4uLsMd/s6CB0NpPH0zCGp0bGu2NMTOfVyi24m9a3p4FBWhmLcZiwWUmniz
         2ug6BQl7qHD3zvlnjrwiT28JIrQwwRRWlTJ47DiAYfv0VibHIe2Al8QzF1Mzbx2a6M+0
         vB78zABEqKuKXCpDgQXALLQkKOeGIxfRgREWQ1P8a5no0arElUjiDa+7uqe3dOgCcGU3
         WcSXIUgW1DMDoHZN5h0KMCV4MU12kbP+COhwD0FOTH4C3yITfq5BnJjPy1rfUXVj+eHf
         uh1RR/+HhCWwkalFcP5Nt0E2wMC/fGVJ65PcGuYMx+RS4pq5VQGzrKrb0rzYKYUtdaOu
         zcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GN6bHxTyxXXFGcLyHnAqRzqt+IGwDS6MCFvgwrIzCQU=;
        b=O5+7MGBfVdrYW+3VF02e8D3HZ48C2pFSXGO7xJOPhgRxZS7AGEo6OV7GITiRSSFAop
         Fd1rr2UzT5pBBbaeKtxUSBV0DpGCKlYSpc9DmR985Bs1JsXhpuS4rtyaqwMeTBPn2CEl
         Iql6DW4uWtKo+ca+GctqI7MxrHTAvCn+x4i2yC3LpMgI3dcAGRDsbE55Y9QwSPHnRICb
         VZw3kruu8a7LnZQwyreignc5mLp5y8p1Ae445cQb1FWPnKs0bBtTsLqqlCXUKgpJQKmn
         B6dmVLNf+Z/uyKUVwHKtLCuLmhNHLuMMtFfqPfEzcwCaFKsrayVnmaC2ogV6js3j9RNf
         zIdQ==
X-Gm-Message-State: APjAAAVjXIEofIMBO6Q6kqcs4vEhJXfYebggQwqmfWpRCuAeefimwH9y
        IQHZBdn9vMit5t+VusXNlh8voPfPSaLUYVBqljhXnfbAxmvnxgsXS7uikxu0GqCmTQoa0/3lOFl
        bz61um28DFewvSlOONzJ9rhYjLVr/N4AbsOcz6r2VV46KwoCS4icvGAYbKS51cxcsmB6rwd95Zh
        IS
X-Google-Smtp-Source: APXvYqwmyZYN23nBO9OtBdTnUG1AWdggduergNtLRDvai/Od8Gh3JdYOcmxHk3yc+cN1dTNa+VRIl+Hg1VRz1bMm9Dj0
X-Received: by 2002:a63:7408:: with SMTP id p8mr1029948pgc.56.1555014621974;
 Thu, 11 Apr 2019 13:30:21 -0700 (PDT)
Date:   Thu, 11 Apr 2019 13:30:15 -0700
In-Reply-To: <cover.1555014408.git.jonathantanmy@google.com>
Message-Id: <63049081c98b8612bd233a6f01104c6196a09946.1555014408.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190405204413.93900-1-jonathantanmy@google.com> <cover.1555014408.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v3 1/2] transport: warn if server options are unsupported
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Server options were added in commit 5e3548ef16 ("fetch: send server
options when using protocol v2", 2018-04-24), supported only for
protocol version 2. But if the user specifies server options, and the
protocol version being used doesn't support them, the server options are
silently ignored.

Teach any transport users to die instead in this situation, just like
how "push" dies if push options are provided when the server doesn't
support them.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5702-protocol-v2.sh | 19 +++++++++++++++++++
 transport.c            | 10 ++++++++++
 2 files changed, 29 insertions(+)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index db4ae09f2f..7ddcf26e76 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -182,6 +182,13 @@ test_expect_success 'server-options are sent when using ls-remote' '
 	grep "server-option=world" log
 '
 
+test_expect_success 'warn if using server-option with ls-remote with legacy protocol' '
+	GIT_TEST_PROTOCOL_VERSION=0 test_must_fail git -c protocol.version=0 \
+		ls-remote -o hello -o world "file://$(pwd)/file_parent" master 2>err &&
+
+	grep "see protocol.version in" err &&
+	grep "server options require protocol version 2 or later" err
+'
 
 test_expect_success 'clone with file:// using protocol v2' '
 	test_when_finished "rm -f log" &&
@@ -251,6 +258,18 @@ test_expect_success 'server-options are sent when fetching' '
 	grep "server-option=world" log
 '
 
+test_expect_success 'warn if using server-option with fetch with legacy protocol' '
+	test_when_finished "rm -rf temp_child" &&
+
+	git init temp_child &&
+
+	GIT_TEST_PROTOCOL_VERSION=0 test_must_fail git -C temp_child -c protocol.version=0 \
+		fetch -o hello -o world "file://$(pwd)/file_parent" master 2>err &&
+
+	grep "see protocol.version in" err &&
+	grep "server options require protocol version 2 or later" err
+'
+
 test_expect_success 'upload-pack respects config using protocol v2' '
 	git init server &&
 	write_script server/.git/hook <<-\EOF &&
diff --git a/transport.c b/transport.c
index e078812897..77446119da 100644
--- a/transport.c
+++ b/transport.c
@@ -252,6 +252,14 @@ static int connect_setup(struct transport *transport, int for_push)
 	return 0;
 }
 
+static void die_if_server_options(struct transport *transport)
+{
+	if (!transport->server_options || !transport->server_options->nr)
+		return;
+	advise(_("see protocol.version in 'git help config' for more details"));
+	die(_("server options require protocol version 2 or later"));
+}
+
 /*
  * Obtains the protocol version from the transport and writes it to
  * transport->data->version, first connecting if not already connected.
@@ -286,6 +294,7 @@ static struct ref *handshake(struct transport *transport, int for_push,
 		break;
 	case protocol_v1:
 	case protocol_v0:
+		die_if_server_options(transport);
 		get_remote_heads(&reader, &refs,
 				 for_push ? REF_NORMAL : 0,
 				 &data->extra_have,
@@ -363,6 +372,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 		break;
 	case protocol_v1:
 	case protocol_v0:
+		die_if_server_options(transport);
 		refs = fetch_pack(&args, data->fd, data->conn,
 				  refs_tmp ? refs_tmp : transport->remote_refs,
 				  dest, to_fetch, nr_heads, &data->shallow,
-- 
2.21.0.392.gf8f6787159e-goog

