Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFEBB20285
	for <e@80x24.org>; Thu, 24 Aug 2017 22:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754040AbdHXWyF (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 18:54:05 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34214 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753702AbdHXWyC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 18:54:02 -0400
Received: by mail-pg0-f50.google.com with SMTP id a7so4202417pgn.1
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 15:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2l7XitPRBT5c22kbmQ4ruTyFwyr1WLg/1+camrexyMs=;
        b=de57Ox+xZjNjJc4jW54nPsgJqUbSlTU5x5iRgExRVWm+BCxw2GI2sZF9+Z/EiGxeMo
         QN0DbYvIqUtEZ8UHf6GPBbuT6FrqGd5zSuyZlqMnYmOS8ksjOwSbxZSO14V8QRsQONLf
         96uGI42p54mQTwzANA8Z2tMcTu9eIS89rECxB/wg7y3rLXsRDFZFEMSswm33m4wGhvPm
         2kj63tyeU3guPmUoYn5A8Tx1t1vEtUggXYMX6z0noyBT9enIaDpzrzy3nBmmVtS+mWie
         TzC2UTz+/kMx/+9gn81mq7dK6Q95jxYPR7/atO3QvrScrFf0Rlw9c5qSmA4kJbbYjhqr
         sM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2l7XitPRBT5c22kbmQ4ruTyFwyr1WLg/1+camrexyMs=;
        b=Rgt+oF/Mr7RLTToi7HN4olyylHqPDZ+lLw2GoJORwr8ys8g4Gg8Vqri65x5K8SbihV
         GYLu2TapdWz2YsrxnPbTLQhHfG4Bit2XwpcAMtQfPvnH2YE29/Q3dk8mLM/QD36+JZXM
         tEmr3ZjS7fhu7SRK3CbiuLna8MG+lDTGdbkmiiBXjnVullcZyorSwyZiycV6wbTNZLPQ
         jHIFNfwU6rw/EgjAX2eZBK+JKBBZk5ujjjFVZR2/Aw8XMO5YhyVBFUGZ9ZxQ696C+IOu
         18y6QwtU2O8pjWAuPRY8yJUXHOkY1BrliuDhvhzzgPtD+oAFSAemhinA1azIvman/hQE
         eIZQ==
X-Gm-Message-State: AHYfb5hPEGiixjOrKBQbHqI5RgaAMce7ptgJe3GgRhmrTMT8O5edcZyf
        27cG1PmD/26Kxo71pgRedQ==
X-Google-Smtp-Source: ADKCNb7/21xsG3usREdLXNlACMTloOKiYSpApGqft52MoCd2QJwr0f2UogR6ClccN6N0OoqWUwdVRw==
X-Received: by 10.101.91.66 with SMTP id y2mr7805573pgr.88.1503615241905;
        Thu, 24 Aug 2017 15:54:01 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id x8sm9402667pfi.174.2017.08.24.15.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Aug 2017 15:54:01 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, sbeller@google.com,
        gitster@pobox.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [RFC 5/7] http: send Git-Protocol-Version header
Date:   Thu, 24 Aug 2017 15:53:26 -0700
Message-Id: <20170824225328.8174-6-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.342.g6490525c54-goog
In-Reply-To: <20170824225328.8174-1-bmwill@google.com>
References: <20170824225328.8174-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tell a serve that protocol v2 can be used by sending an http header
indicating this.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 http.c                      | 7 +++++++
 t/t5551-http-fetch-smart.sh | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/http.c b/http.c
index fa8666a21..504a14a5a 100644
--- a/http.c
+++ b/http.c
@@ -896,6 +896,11 @@ static void set_from_env(const char **var, const char *envname)
 		*var = val;
 }
 
+static const char *get_version(void)
+{
+	return "Git-Protocol-Version: 2";
+}
+
 void http_init(struct remote *remote, const char *url, int proactive_auth)
 {
 	char *low_speed_limit;
@@ -926,6 +931,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	if (remote)
 		var_override(&http_proxy_authmethod, remote->http_proxy_authmethod);
 
+	extra_http_headers = curl_slist_append(extra_http_headers, get_version());
+
 	pragma_header = curl_slist_append(http_copy_default_headers(),
 		"Pragma: no-cache");
 	no_pragma_header = curl_slist_append(http_copy_default_headers(),
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index a51b7e20d..ce13f2425 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -27,6 +27,7 @@ cat >exp <<EOF
 > GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
 > Accept: */*
 > Accept-Encoding: gzip
+> Git-Protocol-Version: 2
 > Pragma: no-cache
 < HTTP/1.1 200 OK
 < Pragma: no-cache
@@ -34,6 +35,7 @@ cat >exp <<EOF
 < Content-Type: application/x-git-upload-pack-advertisement
 > POST /smart/repo.git/git-upload-pack HTTP/1.1
 > Accept-Encoding: gzip
+> Git-Protocol-Version: 2
 > Content-Type: application/x-git-upload-pack-request
 > Accept: application/x-git-upload-pack-result
 > Content-Length: xxx
-- 
2.14.1.342.g6490525c54-goog

