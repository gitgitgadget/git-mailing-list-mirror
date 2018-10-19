Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 460771F453
	for <e@80x24.org>; Fri, 19 Oct 2018 14:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeJSW71 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 18:59:27 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46806 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbeJSW70 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 18:59:26 -0400
Received: by mail-lf1-f66.google.com with SMTP id p143-v6so14416797lfp.13
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 07:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NEtBvUThpEHRlOETq3nx4SIUlA7bs6m2FUOX5N2XslI=;
        b=CXRv3XucMwi4u95FX/GtbIIbKpc/u88aftKox0yUq+w/rwB9gOezR3fq9vqEAwkFR6
         MYW4B3oy7ucH2FANarB+EPEcQmulspVY5RJRk2wM1PeYtwmf84l/HTB1QsswTTibCe8E
         9L3XUFKunYPeCSGO9sZIaka+NKZvynAtldle9DmUoD7zJLuk/F6/25hPINb7FyBrQBXS
         ssS61rLWxfSwe/7KjPEukxaOaOXcJVOK7YnSJBuEovOwdCi8J6RFSi+MZO+hiWZrqXHy
         4cUG2MhdUYbeiscKaLOdV9TzgDyPaSFfiaed/gHPU3etDE8DKiqZ0hdGq7yj9IWP2zxy
         dBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NEtBvUThpEHRlOETq3nx4SIUlA7bs6m2FUOX5N2XslI=;
        b=CHxnqjILxXTT/W6iEePGmyPRbowvdhJYIPf+bqVb1jIQYf6HapVlQCqoa6TCXsySyF
         dAHBgH5NH1pTkRvlHKaaExT5NFadACEhJgXh0dNEvTS5BdRuVz4aa5ExR8wyezeNnt3l
         +nC9Yw20LNdaCD61GDssR14TNzeujBqJgcekNlcRSO/VoX80pTcxbSroiwjHbm33X6yC
         iLin+ggNfKuP42d/x6aN67/VuGxmJi1G9S74RLgIL6O1+62iAoEGlKMfXphyqrsX78zt
         0PU5sVOTz+rkYT+C7BebW2qeK6MZs/zo7cLdrJm9GV8nEetZVnNxOkhAcajJipE1EzHF
         k3BQ==
X-Gm-Message-State: ABuFfoif+TVS63Em3TazDY8iZGMDVxcXS++I+oqFbJId8nKdb5zPUbmK
        yQ+zRGUerU5aUz8r9qpAYjY5z+hO
X-Google-Smtp-Source: ACcGV621yJg6fQbXbzU8fdGJClrW0YUlKanh8DZOSQ5TqVFOwjsg7a9IHYXjCOS/ZuV7+OPdyFodAw==
X-Received: by 2002:a19:8d11:: with SMTP id p17-v6mr3069124lfd.116.1539960777756;
        Fri, 19 Oct 2018 07:52:57 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g64-v6sm4002414lfe.87.2018.10.19.07.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 07:52:57 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 13/19] transport.c: remove implicit dependency on the_index
Date:   Fri, 19 Oct 2018 16:52:31 +0200
Message-Id: <20181019145237.16079-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181019145237.16079-1-pclouds@gmail.com>
References: <20181019145237.16079-1-pclouds@gmail.com>
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
index f4ffbd96cb..b86b2b12c6 100644
--- a/transport.c
+++ b/transport.c
@@ -1105,7 +1105,8 @@ static int run_pre_push_hook(struct transport *transport,
 	return ret;
 }
 
-int transport_push(struct transport *transport,
+int transport_push(struct repository *repo,
+		   struct transport *transport,
 		   struct refspec *rs, int flags,
 		   unsigned int *reject_reasons)
 {
@@ -1172,7 +1173,7 @@ int transport_push(struct transport *transport,
 					oid_array_append(&commits,
 							  &ref->new_oid);
 
-			if (!push_unpushed_submodules(&the_index,
+			if (!push_unpushed_submodules(repo->index,
 						      &commits,
 						      transport->remote,
 						      rs,
@@ -1197,7 +1198,7 @@ int transport_push(struct transport *transport,
 					oid_array_append(&commits,
 							  &ref->new_oid);
 
-			if (find_unpushed_submodules(&the_index,
+			if (find_unpushed_submodules(repo->index,
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
2.19.1.647.g708186aaf9

