Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC5851F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932812AbeDWXnt (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:43:49 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45414 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932761AbeDWXng (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 19:43:36 -0400
Received: by mail-pf0-f194.google.com with SMTP id l27so10614004pfk.12
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 16:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bD2klxCSxY5TcwO1Tp5b1q67He3TJDRMNeBK6nfLN7w=;
        b=k64SR+W78f8Au6/CGgVuUK+H0RuRTr/kKBFLDdVi84OQoMCsHsUbRYW9uANu12CxCl
         3vs96uRBv29PjD733N41NCrwpuigbn5tF5qIbO/qaZDQJhTkUZWASF0ZfMpHXb2BfX01
         VF0Vi5Y/NSaf2PdO05R/uxgqOHWZpA1CFbJem4wRftNZQdzEAiIfbcA1aSOuNhqkAN+y
         7xB/yFn1WJ+IfeW8eKvGI8bDhk1kZjBdlSyPRcYzfJsig3PNVNzfhX3/t5CZPV6aMVAr
         oka+vcyFDUvfG9wbT0E4Ug+KwHxxNFUQHE8BQAM9AXoi/yrlbLu8D5kxPqy3Y2kVStmQ
         wujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bD2klxCSxY5TcwO1Tp5b1q67He3TJDRMNeBK6nfLN7w=;
        b=ijXsTUTMThvooKOpaBKE438CtrgB1v75HnWdCeVMifXw33hmj6+CkUTcwXRkE0yZnS
         QBcr85SVHmPsItlR7+o65GciM3iVWMsF3Xsp6pC9EFrzqtpXe53X2sS0ixapDQZjSVhR
         CZ9DK2WYzKLdXQBEOS0Znl8fOU4DBeXs6awH1JsGQ+qt18qNyioLHQ9+Hm94qLUdHIg2
         QKUIinvs/hW1ooNqbgTcYd8p/z+xKmX3QIaY5rbLBgtCCekShW+I0ZE3hwRUfQ1C2Um4
         Cyo3ytOJL8GJSrVZJYX4NPtzZ3JpA+WobiKNctcBcdW6wN+Bvas4DldasP2tRaK9Jf9I
         2g7g==
X-Gm-Message-State: ALQs6tCBsa+W2r3Wi9arC4WneGnNlLuChXQrM70MuNFFv7mI4Vbmn7da
        /GceBFrjUo7a8M6nOkRyvYU9+cxsf58=
X-Google-Smtp-Source: AIpwx48RX1rBO/tT7CXkI+fyBCAS7k2ssBd0Q00BeVs9oRNv0XJNMfDllMMNrabLmTVPPTD1UxQMVQ==
X-Received: by 10.101.70.72 with SMTP id k8mr16402334pgr.47.1524527015970;
        Mon, 23 Apr 2018 16:43:35 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id m3sm26361545pff.150.2018.04.23.16.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 16:43:35 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/9] packfile: add repository argument to packed_to_object_type
Date:   Mon, 23 Apr 2018 16:43:22 -0700
Message-Id: <20180423234327.250484-5-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180423234327.250484-1-sbeller@google.com>
References: <20180423234327.250484-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of packed_to_object_type
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/packfile.c b/packfile.c
index d2b3f3503b..3ecfba66af 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1124,11 +1124,13 @@ static int retry_bad_packed_offset_the_repository(struct packed_git *p, off_t ob
 
 #define POI_STACK_PREALLOC 64
 
-static enum object_type packed_to_object_type(struct packed_git *p,
-					      off_t obj_offset,
-					      enum object_type type,
-					      struct pack_window **w_curs,
-					      off_t curpos)
+#define packed_to_object_type(r, p, o, t, w, c) \
+	packed_to_object_type_##r(p, o, t, w, c)
+static enum object_type packed_to_object_type_the_repository(struct packed_git *p,
+							     off_t obj_offset,
+							     enum object_type type,
+							     struct pack_window **w_curs,
+							     off_t curpos)
 {
 	off_t small_poi_stack[POI_STACK_PREALLOC];
 	off_t *poi_stack = small_poi_stack;
@@ -1378,8 +1380,8 @@ int packed_object_info(struct packed_git *p, off_t obj_offset,
 
 	if (oi->typep || oi->type_name) {
 		enum object_type ptot;
-		ptot = packed_to_object_type(p, obj_offset, type, &w_curs,
-					     curpos);
+		ptot = packed_to_object_type(the_repository, p, obj_offset,
+					     type, &w_curs, curpos);
 		if (oi->typep)
 			*oi->typep = ptot;
 		if (oi->type_name) {
-- 
2.17.0.484.g0c8726318c-goog

