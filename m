Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8779820248
	for <e@80x24.org>; Fri, 12 Apr 2019 19:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfDLTva (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 15:51:30 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:38300 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfDLTv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 15:51:29 -0400
Received: by mail-pl1-f201.google.com with SMTP id cs14so6899375plb.5
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 12:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sXfUsjoQZu8h9yCIzx+VMxMakZa6UoNRMElPLcl8XW8=;
        b=W/DffTEKK/HSkMlB+ZWaUcyleAjiJh5B4+qgoKT8LhjJ5xGC66Z57GqF9iTE4Q7X9X
         UQzRLnHebmxhZcoEF7USo10A6kqJN6vasqL0dgZIIx9u9a2TJNGA2skYgkZIIJbQFhM4
         4wlENGiadohVR13ISfMlJ237IwrJ33bxntX68KxCYs5tXQnHdX7wqBJFwxmcNYgEa0t7
         HyRL8+toyev6mt0ahj6X1uTJ3YH5gxFHHz5/8m7R24+uDpqqmNQUL3Iuuw6A164ameAF
         bE5cUnIltwdjRuO+PwBsqKcXZIBdOCMwINKkppcHCXkS4QdLNQV9uktdgxUrn5dtJEg9
         CwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sXfUsjoQZu8h9yCIzx+VMxMakZa6UoNRMElPLcl8XW8=;
        b=dRBUs/Ks/AsGmcxR9g8swnSGSTFhaBzjs/yqxcqij8ivf8oiSw95y39WiRJWn+dDyl
         hGcPSsO+HhwD2VCuzU/1bIQGpJx8mG0KIhKyYQRaz2nn4fsUQjw8G4fbtAyTOZFSedWl
         HH1j4tjQcTffV2L5BG0OZXl+kneEYh794Xgo91W+N8id2R5igDAhggx2P/ioPCvW8ZWT
         Hj2rRztVCSDrQsOdU/nFVc5QUUYCaopKzbHNGAWYKWb5uTLljWOhXvO5Fej4cGB0xb/M
         i4W4VqCNMX30UMUzay7XJsqjAx8ost1ih3/VjZSRbi3rJmlujSRuPm4V/s76Yyzfk1xc
         T4KQ==
X-Gm-Message-State: APjAAAWFYuc0d0RI3QGwAD0iF5Z8VbsWggUV5KI90xWWu6ppZhSuXuxj
        8uWXa0WE4ivfkyS/gbi5CbkBQod67JMJCsA+aizs9N0wDHLjIRpikEfCu6vfb2qk3D9Qdjlw/4x
        j96rJ+V/tPBSW2qleSTw9bb1Do3V54Mkfgz3tJBjIbw+dobNWbbPBgw7WaDO8iPDhcVWDjvzNcq
        9J
X-Google-Smtp-Source: APXvYqwu5CUbdQc9DEqwj21v2moQWuMc6ojZQXf5XgjNGyJ1nnzPPDXubtZQQzxKjZV0zxhteyWsqwgJGfR69fKpRh0v
X-Received: by 2002:a63:fa46:: with SMTP id g6mr1143072pgk.73.1555098688268;
 Fri, 12 Apr 2019 12:51:28 -0700 (PDT)
Date:   Fri, 12 Apr 2019 12:51:21 -0700
In-Reply-To: <cover.1555098572.git.jonathantanmy@google.com>
Message-Id: <598b2de0162e240521f04d40d41eb11843be7198.1555098572.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190405204413.93900-1-jonathantanmy@google.com> <cover.1555098572.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v4 1/2] transport: die if server options are unsupported
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
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
index db4ae09f2f..1e8357a4c7 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -182,6 +182,13 @@ test_expect_success 'server-options are sent when using ls-remote' '
 	grep "server-option=world" log
 '
 
+test_expect_success 'warn if using server-option with ls-remote with legacy protocol' '
+	test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 git -c protocol.version=0 \
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
+	test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 git -C temp_child -c protocol.version=0 \
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

