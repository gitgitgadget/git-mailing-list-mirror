Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A11441F404
	for <e@80x24.org>; Wed, 12 Sep 2018 05:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbeILKix (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 06:38:53 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:45571 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeILKix (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 06:38:53 -0400
Received: by mail-qt0-f202.google.com with SMTP id u45-v6so678468qte.12
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 22:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g4+TvSFNSNYoL0aBVKum343Cm1LNB1BVZsk1WdhawnA=;
        b=iRBKlzH3xJ8EZJve+O2N/X9j71c8B1w9mtE7R+Wl5xW4q33xO3LTrhCMfj3xbNuKv8
         gHTuu7hITkrSj3Edl008LmYVAo+upjiwBiJ7bdIdJBEzxLDWwHF1Jrmzve3eRqSXc50Q
         ugP7+7WornSrMA8eUAXBbBgYalWSrHQ8+c4ryB1XYvBrcv4ZUe+gdWanr/N3ppfhV2ha
         4jXwFbQkydGGl/cG4TTNAcgLSRVBDdpd0419MOrwOHqcili1m5XC1dR2/m7oPzL4LfLX
         VblhYmk5mnm01r/C2ThbJOuQHA+ALCtFPAyG/zKbL5U+lytjaGe+LLuPx0qCvTMbryvl
         dWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g4+TvSFNSNYoL0aBVKum343Cm1LNB1BVZsk1WdhawnA=;
        b=KjQHPLcwPjme3mKCkHlI7h3SqJ9h+cliXT77G58Ib+PWuVtIk+n+Z0KsmFPQpUZ/lL
         GHsQi2AKGXaeO06r2IBCRUxguN9ofS3zKtRZosiZgwK6/LntUbkH9Ke+FoigsZvJuwNf
         IsZAZzuR+JXCmdm+lL+sDxG1Z0zSJaJ0fQeky7x7l7SQM7xPJTci61dLtU5yprPFn1Q6
         4WM0ItwqJGJwmRwGZkFXY1jAEOrFAjZ/Gry/2zB/qkvk7ypzeqMy0tcwAG+/HVfq3QK0
         TZEQafJFnExMD/T71SNPu63509vWcoc69hvfLa1VETw4WgeR4MBrRE7MgjGDZlNIlivR
         O7ww==
X-Gm-Message-State: APzg51A2n5DiTAdKtKtdrl6aFvNjOQfy0G2B7OxI09ObNMB+nrGsaOpV
        WRbz0wbzQeUqOevkRbO+RXyeB/BD3MJj5AQs/zEXKtrlIGP/Exg4PqAI5BZKNbu/u84YhH9Eca7
        E5dkPhQyhBPKwQ5sSubnXecVEzdWYbOFKgYtrIYCRWLEVdxmhu3TFcBCYECOKUsU=
X-Google-Smtp-Source: ANB0VdZGsRxMMAyVWXsiyqKbLpwD0HdBrsr/Q+6J5n1JR9nAZxoVqaAv6sZnl4CCthj4pFokFWgftUEtCwAKhg==
X-Received: by 2002:a0c:86d7:: with SMTP id 23-v6mr60875qvg.44.1536730562953;
 Tue, 11 Sep 2018 22:36:02 -0700 (PDT)
Date:   Tue, 11 Sep 2018 22:35:19 -0700
In-Reply-To: <20180912053519.31085-1-steadmon@google.com>
Message-Id: <20180912053519.31085-4-steadmon@google.com>
Mime-Version: 1.0
References: <20180912053519.31085-1-steadmon@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 3/3] archive: allow archive over HTTP(S) with proto v2
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, gitster@pobox.com, l.s.r@web.de,
        sandals@crustytoothpaste.net, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/archive.c  |  8 +++++++-
 http-backend.c     | 10 +++++++++-
 transport-helper.c |  5 +++--
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index 73831887d..5fa75b3f7 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -87,7 +87,13 @@ static int run_remote_archiver(int argc, const char **argv,
 		status = packet_reader_read(&reader);
 		if (status != PACKET_READ_FLUSH)
 			die(_("git archive: expected a flush"));
-	}
+	} else if (version == protocol_v2 &&
+		   starts_with(transport->url, "http"))
+		/*
+		 * Commands over HTTP require two requests, so there's an
+		 * additional server response to parse.
+		 */
+		discover_version(&reader);
 
 	/* Now, start reading from fd[0] and spit it out to stdout */
 	rv = recv_sideband("archive", fd[0], 1);
diff --git a/http-backend.c b/http-backend.c
index 458642ef7..d62d583c7 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -32,6 +32,7 @@ struct rpc_service {
 static struct rpc_service rpc_service[] = {
 	{ "upload-pack", "uploadpack", 1, 1 },
 	{ "receive-pack", "receivepack", 0, -1 },
+	{ "upload-archive", "uploadarchive", 1, 1 },
 };
 
 static struct string_list *get_parameters(void)
@@ -637,6 +638,12 @@ static void service_rpc(struct strbuf *hdr, char *service_name)
 	struct rpc_service *svc = select_service(hdr, service_name);
 	struct strbuf buf = STRBUF_INIT;
 
+	if (!strcmp(service_name, "git-upload-archive")) {
+		/* git-upload-archive doesn't need --stateless-rpc */
+		argv[1] = ".";
+		argv[2] = NULL;
+	}
+
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "application/x-git-%s-request", svc->name);
 	check_content_type(hdr, buf.buf);
@@ -713,7 +720,8 @@ static struct service_cmd {
 	{"GET", "/objects/pack/pack-[0-9a-f]{40}\\.idx$", get_idx_file},
 
 	{"POST", "/git-upload-pack$", service_rpc},
-	{"POST", "/git-receive-pack$", service_rpc}
+	{"POST", "/git-receive-pack$", service_rpc},
+	{"POST", "/git-upload-archive$", service_rpc},
 };
 
 static int bad_request(struct strbuf *hdr, const struct service_cmd *c)
diff --git a/transport-helper.c b/transport-helper.c
index 143ca008c..b4b96fc89 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -605,7 +605,8 @@ static int process_connect_service(struct transport *transport,
 		ret = run_connect(transport, &cmdbuf);
 	} else if (data->stateless_connect &&
 		   (get_protocol_version_config() == protocol_v2) &&
-		   !strcmp("git-upload-pack", name)) {
+		   (!strcmp("git-upload-pack", name) ||
+		    !strcmp("git-upload-archive", name))) {
 		strbuf_addf(&cmdbuf, "stateless-connect %s\n", name);
 		ret = run_connect(transport, &cmdbuf);
 		if (ret)
@@ -639,7 +640,7 @@ static int connect_helper(struct transport *transport, const char *name,
 
 	/* Get_helper so connect is inited. */
 	get_helper(transport);
-	if (!data->connect)
+	if (!data->connect && !data->stateless_connect)
 		die(_("operation not supported by protocol"));
 
 	if (!process_connect_service(transport, name, exec))
-- 
2.19.0.397.gdd90340f6a-goog

