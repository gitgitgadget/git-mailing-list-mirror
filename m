Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD5E920248
	for <e@80x24.org>; Tue,  9 Apr 2019 20:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfDIUbl (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 16:31:41 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:50397 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfDIUbl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 16:31:41 -0400
Received: by mail-qt1-f202.google.com with SMTP id g17so109902qte.17
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 13:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ajuP/5osNdbD3RSHhkoUEoR3moRS8yzHk297tJomfsE=;
        b=JF+30L0x9Neen2auI+qgigeTO1/tQa+i9ZQkyBotNGiSPkvL0llWGXGFXb+L397h+o
         uC5d+PNJocI9QofkXqSeAAuiaBLIyGdfUpq4fpvf+nb0PZotrfPFyL58ZXw9GnQv9T0n
         8HGjrqo77DFPsiL3Hb6RDObKcf5MtPbXqX/fYaBqmUTyFW2tiNGPnPMb8m/s362Ssj1b
         1phw01GFWj3yftSQWYmBW7YPsNRh8nNXg+azeCL4C3CGf6/3ZET4OcwPuuuQ7U6NEWJi
         pZn5vjTnNk9rE3JIEoeT1v9EQ11KvXJhk1g0BHowQnCnqtxCOfuQZEDUlNKQd5hu5VqO
         QnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ajuP/5osNdbD3RSHhkoUEoR3moRS8yzHk297tJomfsE=;
        b=H42k4+NOBpS/G1G8OmWGMdwtlPe1Ta77kC+kUoz3ufs4RjFTY9pGbT1RvSIlA7Zjgb
         4wh1wGNk9ysOTC/kYh7JW8/ak+W5CyFyQGfhM0Amdaty88sAaiqBEoScZFtNJqX9WcYo
         gA5awgOHbHVc+xIpFh2OvYrbrl0AfZBjQFWx6Fv1b8t1itg8gVtdlb2n1m+79FPNPUPo
         rllswDrjEhsR+TiXWjVusynTpzigt3pyYubRAEyiSJSczkRwBaXa4TMcfuhDt03ivCUI
         TLYHBKt5fxSth7AH++gBy732e7dNIbvZTvU1J26QfMx/B2iqL0c9ReodBbUkTDd/zZvA
         oBaw==
X-Gm-Message-State: APjAAAXqI2+vqQxVMO6eQY1apqPD218OmOmT3sktF6hyNV3Z5ijwMK09
        YinW4uY8N/RvjhxQZ/4SHRQP539TJPnZyBn5rdtVLyWvt5zzimS2B5iCfkAPCP/RuEiWjW6jveU
        iNDZJlZod/G+uKuMrcsMjjzKhFCQgAjmGfaARL7yUcqnvzKrq91XqcPD5FBNQ0QwTLkB7pWkn9Y
        aZ
X-Google-Smtp-Source: APXvYqwuycONYOIYTyB3LCDEiaokAW+ymthkm4FxzKQgKnAay7K4d19mnqr60FcdDpQhws7Yp2BQ/bqEJVCYF7qbT6rU
X-Received: by 2002:a05:620a:124a:: with SMTP id a10mr4679151qkl.59.1554841900185;
 Tue, 09 Apr 2019 13:31:40 -0700 (PDT)
Date:   Tue,  9 Apr 2019 13:31:33 -0700
In-Reply-To: <cover.1554841624.git.jonathantanmy@google.com>
Message-Id: <af3cc05324f53316eedb2f437789eacb24c11489.1554841624.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190405204413.93900-1-jonathantanmy@google.com> <cover.1554841624.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v2 1/2] transport: warn if server options are unsupported
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Server options were added in commit 5e3548ef16 ("fetch: send server
options when using protocol v2", 2018-04-24), supported only for
protocol version 2. Add a warning if server options are specified for
the user if a legacy protocol is used instead.

An effort is made to avoid printing the same warning more than once by
clearing transport->server_options after the warning, but this does not
fully avoid double-printing (for example, when backfulling tags using
another fetch with a non-reusable transport).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5702-protocol-v2.sh | 17 +++++++++++++++++
 transport.c            |  8 ++++++++
 2 files changed, 25 insertions(+)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index db4ae09f2f..f1a3ff1021 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -182,6 +182,12 @@ test_expect_success 'server-options are sent when using ls-remote' '
 	grep "server-option=world" log
 '
 
+test_expect_success 'warn if using server-option with ls-remote with legacy protocol' '
+	GIT_TEST_PROTOCOL_VERSION=0 git -c protocol.version=0 \
+		ls-remote -o hello -o world "file://$(pwd)/file_parent" master 2>err &&
+
+	grep "Ignoring server options" err
+'
 
 test_expect_success 'clone with file:// using protocol v2' '
 	test_when_finished "rm -f log" &&
@@ -251,6 +257,17 @@ test_expect_success 'server-options are sent when fetching' '
 	grep "server-option=world" log
 '
 
+test_expect_success 'warn if using server-option with fetch with legacy protocol' '
+	test_when_finished "rm -rf temp_child" &&
+
+	git init temp_child &&
+
+	GIT_TEST_PROTOCOL_VERSION=0 git -C temp_child -c protocol.version=0 \
+		fetch -o hello -o world "file://$(pwd)/file_parent" master 2>err &&
+
+	grep "Ignoring server options" err
+'
+
 test_expect_success 'upload-pack respects config using protocol v2' '
 	git init server &&
 	write_script server/.git/hook <<-\EOF &&
diff --git a/transport.c b/transport.c
index e078812897..14f14ef93c 100644
--- a/transport.c
+++ b/transport.c
@@ -252,6 +252,12 @@ static int connect_setup(struct transport *transport, int for_push)
 	return 0;
 }
 
+static void warn_server_options_unsupported(struct transport *transport)
+{
+	warning(_("Ignoring server options because protocol version does not support it"));
+	transport->server_options = NULL;
+}
+
 /*
  * Obtains the protocol version from the transport and writes it to
  * transport->data->version, first connecting if not already connected.
@@ -286,6 +292,7 @@ static struct ref *handshake(struct transport *transport, int for_push,
 		break;
 	case protocol_v1:
 	case protocol_v0:
+		warn_server_options_unsupported(transport);
 		get_remote_heads(&reader, &refs,
 				 for_push ? REF_NORMAL : 0,
 				 &data->extra_have,
@@ -363,6 +370,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 		break;
 	case protocol_v1:
 	case protocol_v0:
+		warn_server_options_unsupported(transport);
 		refs = fetch_pack(&args, data->fd, data->conn,
 				  refs_tmp ? refs_tmp : transport->remote_refs,
 				  dest, to_fetch, nr_heads, &data->shallow,
-- 
2.21.0.392.gf8f6787159e-goog

