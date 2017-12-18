Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A07201F424
	for <e@80x24.org>; Mon, 18 Dec 2017 19:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933529AbdLRTLe (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 14:11:34 -0500
Received: from mail-pl0-f41.google.com ([209.85.160.41]:38891 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758092AbdLRTLd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 14:11:33 -0500
Received: by mail-pl0-f41.google.com with SMTP id s10so5384158plj.5
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 11:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5a3bZPnXW+01kpVA4xfCwb7FAleEYyNSgQlHr2iWgX0=;
        b=LxHCGKXYEXUEXYHQf/xq4LraAjHeZKIAvZ8TQRXbjs5sSyZQwVfs8yGW/5DscS+fqQ
         fRmkWtHherUFL1EmnvqJfaow5yu3GLsyg5DFeP5Wctg1jhaEJsmFFJ8NydO/tdbpPr5I
         rkAxIRC7lRGBTQ3eOoqdMJKlsMgPD+uAtl+e562/LN4w3jDjiLrQ9AoUB59dOaWa2beu
         9IyDmvylNxIdXqE7CuWC1n3UmZyjUEDbP9Zpdykf/ELf3svUTpqNlj/+/twCERsd4b9n
         PmW4iSdE4LNm/c4etJWyv3JOqk8HhqUxrdANe8bW9ncPoaCFcarQ6U3K4mUUhbWUsrho
         ZEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5a3bZPnXW+01kpVA4xfCwb7FAleEYyNSgQlHr2iWgX0=;
        b=g5W4DWiu4D/Bc52X0wfD1I1mssdEF0HBfD0HGv/TL5zia9b1N8V0CDtxo/p5B1Mpw7
         c4NzWl968F8NOvC2Ix2R5gu8OKRJLhD+FNqzP8FDJ58LhBTHDb6gpsG3yhj2urfqdR8G
         IhuPRTN5bV6oC+F6fb9VeQ8AiNo3HNm5L4va/1kvHcmMoQqQFzK7YCL1d8QkAe5NetL+
         S5sgU0zIPdIXEHluouxDtbpdJMGN6MBXAiAoIbMiwNU4ffAG1EJzwI59A4ix0j+7n0JY
         ejLrzTgPUEgLgPajEwu7yQSZG/23xA3n4/oMgnEjEw2EQZDMnMZSkDVx6AQcUpUfTHGI
         odJQ==
X-Gm-Message-State: AKGB3mLdIbJzeogvuVcwpm4j1lRSgLJHg+tm4u5wahXAkoR4j/rbs+te
        mEZsl9/rBFEmDm18HRZvqeMtO11H
X-Google-Smtp-Source: ACJfBovTmU3lWW0w3p7rt4hVP0KO2JGk9DBZ2vjAw5cACAKa2HWrnmAehRqgg5GhQ0LaWvRf85Jdeg==
X-Received: by 10.159.198.1 with SMTP id f1mr691521plo.450.1513624292812;
        Mon, 18 Dec 2017 11:11:32 -0800 (PST)
Received: from unique-pc.sce.com ([117.245.100.242])
        by smtp.gmail.com with ESMTPSA id h69sm27000870pfk.166.2017.12.18.11.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Dec 2017 11:11:31 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Doron Behar <doron.behar@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
Subject: [PATCH v3] imap-send: URI encode server folder
Date:   Tue, 19 Dec 2017 00:41:13 +0530
Message-Id: <20171218191113.18600-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f467
In-Reply-To: <CAPig+cSOn8PV52aL0Ky5uUwFfNMWye93UQGioRiXjj0ze9HX+g@mail.gmail.com>
References: <CAPig+cSOn8PV52aL0Ky5uUwFfNMWye93UQGioRiXjj0ze9HX+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>

When trying to send a patch using 'imap-send' with 'curl' and the
following configuration:

[imap]
	folder = "[Gmail]/Drafts"
	host = imaps://imap.gmail.com
	port = 993
	sslverify = false

results in the following error,

    curl_easy_perform() failed: URL using bad/illegal format or missing URL

This is a consequence of not URI-encoding the folder portion of
the URL which contains characters such as '[' which are not
allowed in a URI. According to RFC3986, these characters should be
URI-encoded.

So, URI-encode the folder before adding it to the URI to ensure it doesn't
contain characters that aren't allowed in a URI.

Reported-by: Doron Behar <doron.behar@gmail.com>
Signed-off-by: Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
Changes in v3:
    - updated commit message as suggested by Eric (convert past tense
      to present tense) and added a few tweaks to it that striked me

Eric Sunshine <sunshine@sunshineco.com> writes:
> Thanks for taking up the slack.

You're welcome. It was easier than waiting for this patch to be
updated so it could get into 'pu' ;-)


 imap-send.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 54e6a80fd..36c7c1b4f 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1412,6 +1412,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 {
 	CURL *curl;
 	struct strbuf path = STRBUF_INIT;
+	char *uri_encoded_folder;
 
 	if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
 		die("curl_global_init failed");
@@ -1429,7 +1430,12 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	strbuf_addstr(&path, server.host);
 	if (!path.len || path.buf[path.len - 1] != '/')
 		strbuf_addch(&path, '/');
-	strbuf_addstr(&path, server.folder);
+
+	uri_encoded_folder = curl_easy_escape(curl, server.folder, 0);
+	if (!uri_encoded_folder)
+		die("failed to encode server folder");
+	strbuf_addstr(&path, uri_encoded_folder);
+	curl_free(uri_encoded_folder);
 
 	curl_easy_setopt(curl, CURLOPT_URL, path.buf);
 	strbuf_release(&path);
-- 
2.15.1.620.gb9897f467

