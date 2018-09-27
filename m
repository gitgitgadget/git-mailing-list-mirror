Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 388EC1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 01:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeI0Hl1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 03:41:27 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:49079 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbeI0Hl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 03:41:27 -0400
Received: by mail-vk1-f202.google.com with SMTP id g71-v6so322172vke.15
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 18:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IJjbq8DDjp/TM3ofFJtHDEPDb7EyViyLhbWH6raeeEo=;
        b=vaXUPCMh+tb5A2xps1QTGNU7K27OmQT4uAyDFoikBDaFfLCI4jCJhLuvqheE1NahOU
         4KFdr5P4qkbnOvVpj/ssudvmzq26Od0PxhQAt4x/l74vDmHDgcFYQOfSHY126E1Ri3wL
         6E49kUo0Ou3/3+MN/yOMJInlqeL22kc0RuUkKsUBZP+j2yoOE8DOmrll9WZyoFXAT6Zl
         Jwc/oDa9ZbUmUo0Ox3O7oKJOwJ//His/e/BOveK07EOQzA0INtWpZbwyKH4CBEYJ1S5K
         HMhJXFw1aL4lckKM7Suum22eqdO72KcunzToyEviTStQ9rlu3fjpwrRtqQ1hbfHQeJ5f
         7t3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IJjbq8DDjp/TM3ofFJtHDEPDb7EyViyLhbWH6raeeEo=;
        b=aRyxImT6xA4DtR+iCG1ZbUzmgltsHYw+RAkAuKm/AeFzGPwenVHbJrYlXS2RZpqIlN
         3hjFUQdxUihiSYOishTEb5GvHq351VWuCtPqzHOi4jD6WD99IuM6Fx8bEYxWFyb+mjDH
         ZbTPNnnHzb/WVj/63tROAI+PFrPJq9nsGIrPGSaT0RlGwv0W0LPUmerq49/zH3NSU9pI
         leJDsBK6o0yYmkClOT4WqaN3oqP/WHZRiaVODXnLSg/YbshVTOIAqUx+88OY+eaNCAQB
         XOs8R2b/+ofTZRr6Xy1R8VAN3EIy61c/V8GcQ3+Plrz4mrylDdab1IBQcqewsnlGCEy7
         IjHw==
X-Gm-Message-State: ABuFfoj6ZpJuxWmoihMDeMkg+ru3h8gES3b+xOqTSVXvJPRwewKaTTRY
        e4eLpERkiS79fip6O09GvZgyE6H2x10LqSIUewq1MIF6hDdRW4YbPx6tb+s/PJod63UxUYzksUp
        n39P5KOBqHOR5tznq8MYLmGViRVRsLsKdjvq/vdLpU68kQBkiIfrJmc6vSMavjew=
X-Google-Smtp-Source: ACcGV60Oei/DcTxXRdKH3dcPziS6gzS11UBxwHqzucQK+6QHCysuH3oo2+1zcE4Z1uM8lBtC8XI7KzYyWGmbSA==
X-Received: by 2002:a1f:b915:: with SMTP id j21-v6mr3597538vkf.13.1538011543767;
 Wed, 26 Sep 2018 18:25:43 -0700 (PDT)
Date:   Wed, 26 Sep 2018 18:24:55 -0700
In-Reply-To: <20180927012455.234876-1-steadmon@google.com>
Message-Id: <20180927012455.234876-5-steadmon@google.com>
Mime-Version: 1.0
References: <20180912053519.31085-1-steadmon@google.com> <20180927012455.234876-1-steadmon@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v2 4/4] archive: allow archive over HTTP(S) with proto v2
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/archive.c  | 12 +++++++++++-
 http-backend.c     | 13 ++++++++++++-
 transport-helper.c |  7 ++++---
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index f91d222677..78a259518d 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -87,7 +87,17 @@ static int run_remote_archiver(int argc, const char **argv,
 		status = packet_reader_read(&reader);
 		if (status == PACKET_READ_NORMAL && reader.pktlen > 0)
 			die(_("git archive: expected a flush"));
-	}
+	} else if (version == protocol_v2 &&
+		   (starts_with(transport->url, "http://") ||
+		    starts_with(transport->url, "https://")))
+		/*
+		 * Commands over HTTP require two requests, so there's an
+		 * additional server response to parse. We do only basic sanity
+		 * checking here that the versions presented match across
+		 * requests.
+		 */
+		if (version != discover_version(&reader))
+			die(_("git archive: received different protocol versions in subsequent requests"));
 
 	/* Now, start reading from fd[0] and spit it out to stdout */
 	rv = recv_sideband("archive", fd[0], 1);
diff --git a/http-backend.c b/http-backend.c
index 9e894f197f..8e262d50e0 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -32,6 +32,7 @@ struct rpc_service {
 static struct rpc_service rpc_service[] = {
 	{ "upload-pack", "uploadpack", 1, 1 },
 	{ "receive-pack", "receivepack", 0, -1 },
+	{ "upload-archive", "uploadarchive", 1, 1 },
 };
 
 static struct string_list *get_parameters(void)
@@ -637,6 +638,15 @@ static void service_rpc(struct strbuf *hdr, char *service_name)
 	struct rpc_service *svc = select_service(hdr, service_name);
 	struct strbuf buf = STRBUF_INIT;
 
+	if (!strcmp(service_name, "git-upload-archive")) {
+		/*
+		 * git-upload-archive doesn't need --stateless-rpc, because it
+		 * always handles only a single request.
+		 */
+		argv[1] = ".";
+		argv[2] = NULL;
+	}
+
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "application/x-git-%s-request", svc->name);
 	check_content_type(hdr, buf.buf);
@@ -713,7 +723,8 @@ static struct service_cmd {
 	{"GET", "/objects/pack/pack-[0-9a-f]{40}\\.idx$", get_idx_file},
 
 	{"POST", "/git-upload-pack$", service_rpc},
-	{"POST", "/git-receive-pack$", service_rpc}
+	{"POST", "/git-receive-pack$", service_rpc},
+	{"POST", "/git-upload-archive$", service_rpc},
 };
 
 static int bad_request(struct strbuf *hdr, const struct service_cmd *c)
diff --git a/transport-helper.c b/transport-helper.c
index 143ca008c8..c41c3dfcff 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -604,8 +604,9 @@ static int process_connect_service(struct transport *transport,
 		strbuf_addf(&cmdbuf, "connect %s\n", name);
 		ret = run_connect(transport, &cmdbuf);
 	} else if (data->stateless_connect &&
-		   (get_protocol_version_config() == protocol_v2) &&
-		   !strcmp("git-upload-pack", name)) {
+		   get_protocol_version_config() == protocol_v2 &&
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
2.19.0.605.g01d371f741-goog

