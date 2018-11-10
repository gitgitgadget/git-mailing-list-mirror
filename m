Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D17EA1F454
	for <e@80x24.org>; Sat, 10 Nov 2018 05:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbeKJPdQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:33:16 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41825 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbeKJPdN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:33:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id z80-v6so3371411ljb.8
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u02DXy0BJW9Ov4wCgY6lRKxRABCMteq+PJt2AdIdy+I=;
        b=T+DoFT0r+5N1F6dhzg+gQ//1DOCiWbRTTYUW6D/+ekGsm5zvQYTh+EuKIweWIs+g2A
         sjpS5fa1i+cch05CTQQnGw1q/0fF6pn/HFYMEGM8OivOZYwUEAo91D4tP1PWZrkfCu4+
         4d9AmuDAcHWYThUvRIbtCEtKx5T8K75UK58MuiwCIigOwiphA8xdPEkQCPjGKdLeiDxf
         rGIl+qbaPwgLU2rskf7eBg2W7CmQWkN8lMgqlr2cHTkcI43sRTftS7RV0JrFwYB1P1oN
         VhBwkgxPC2UVnZGWRC4g4R0o93h15GhurTDZhfcLvcFgmniLciJgaVRwnnXZlRzuYt3O
         3I6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u02DXy0BJW9Ov4wCgY6lRKxRABCMteq+PJt2AdIdy+I=;
        b=pniVy9z+xXHMejYV6qQ5b2Ws/kDOTu+vdaiMyjr7dYI3TrSI6TK1BUQpajJ58lYpFp
         Pqw9jrWBubahXNqTQV1YkgQf6ik+FQGFiT5pSwzZfr5qCozUPJEKzS2+jtRdXpr4GXWY
         k1Ow0ipu7xReZTwYocL8UN6AuoFCrVnwPnQ9cTjQ4dvxdEPPNNJ7BgM2+cr9HL/TNJmg
         pJDeCNRCDWwo3H/CDN5JViFGuQhBtylqEjjd7IsDhw8D5ZBGvgVfO6FShKdWOaD4U8oq
         7OZHPQdfUteUL7fAcIlkyPn+V4NkOyoRfNQWu5XqWxOpjx8kKdrbjB/OySFxrsEe8puc
         DT8Q==
X-Gm-Message-State: AGRZ1gIcYMyKRRkiCCrjmRfqwltXvb/Nakug0N78z3jx+meT32RfsPrT
        vCngmG9U/29DHjst5sI+9CqmxLsM
X-Google-Smtp-Source: AJdET5cEUu33AKDpnF2OttbXQM3kaKdQTs6wLDJGqjsLDWI7mCYPl9xMR0+Ph+puDtAcVpHDLX1Wmw==
X-Received: by 2002:a2e:91d1:: with SMTP id u17-v6mr7304741ljg.160.1541828967036;
        Fri, 09 Nov 2018 21:49:27 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h3sm144445lfj.25.2018.11.09.21.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:49:26 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 07/22] transport.c: remove implicit dependency on the_index
Date:   Sat, 10 Nov 2018 06:48:55 +0100
Message-Id: <20181110054910.10568-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110054910.10568-1-pclouds@gmail.com>
References: <20181110054910.10568-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

note, there's still another hidden dependency related to this: even
though we pass a repo to transport_push() we still use
is_bare_repository() which pretty much assumes the_repository (and
some other global state).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/push.c | 3 ++-
 transport.c    | 7 ++++---
 transport.h    | 3 ++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index d09a42062c..efb3e38a8d 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -355,7 +355,8 @@ static int push_with_options(struct transport *transport, struct refspec *rs,
 
 	if (verbosity > 0)
 		fprintf(stderr, _("Pushing to %s\n"), transport->url);
-	err = transport_push(transport, rs, flags, &reject_reasons);
+	err = transport_push(the_repository, transport,
+			     rs, flags, &reject_reasons);
 	if (err != 0) {
 		fprintf(stderr, "%s", push_get_color(PUSH_COLOR_ERROR));
 		error(_("failed to push some refs to '%s'"), transport->url);
diff --git a/transport.c b/transport.c
index 5a74b609ff..71f663743f 100644
--- a/transport.c
+++ b/transport.c
@@ -1105,7 +1105,8 @@ static int run_pre_push_hook(struct transport *transport,
 	return ret;
 }
 
-int transport_push(struct transport *transport,
+int transport_push(struct repository *r,
+		   struct transport *transport,
 		   struct refspec *rs, int flags,
 		   unsigned int *reject_reasons)
 {
@@ -1172,7 +1173,7 @@ int transport_push(struct transport *transport,
 					oid_array_append(&commits,
 							  &ref->new_oid);
 
-			if (!push_unpushed_submodules(the_repository,
+			if (!push_unpushed_submodules(r,
 						      &commits,
 						      transport->remote,
 						      rs,
@@ -1197,7 +1198,7 @@ int transport_push(struct transport *transport,
 					oid_array_append(&commits,
 							  &ref->new_oid);
 
-			if (find_unpushed_submodules(the_repository,
+			if (find_unpushed_submodules(r,
 						     &commits,
 						     transport->remote->name,
 						     &needs_pushing)) {
diff --git a/transport.h b/transport.h
index 9baeca2d7a..f2ee7c4f49 100644
--- a/transport.h
+++ b/transport.h
@@ -223,7 +223,8 @@ void transport_set_verbosity(struct transport *transport, int verbosity,
 #define REJECT_FETCH_FIRST     0x08
 #define REJECT_NEEDS_FORCE     0x10
 
-int transport_push(struct transport *connection,
+int transport_push(struct repository *repo,
+		   struct transport *connection,
 		   struct refspec *rs, int flags,
 		   unsigned int * reject_reasons);
 
-- 
2.19.1.1231.g84aef82467

