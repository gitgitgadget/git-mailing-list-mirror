Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DBED1FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751699AbdFHXlx (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:41:53 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36588 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751679AbdFHXls (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:41:48 -0400
Received: by mail-pg0-f47.google.com with SMTP id a70so20693597pge.3
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0ubRKToedvL//9P7jhXyGfoeodPLCDtwLFN5SKYt9sY=;
        b=fC/YWvER4NhfxiaTTJcqi4LfFhjMPXbVyy51eRdG3YoUWCwAYMGyM4fwoIn0gfP7IZ
         056SrwLjF/FNuf2vCssSDx1K0+lKeUrUXYkNaNM2WBjRpmNFw6GcenPveHfmbIm2V8aS
         jbewNIhw7z2KNjR7xh2nsgCbpBV2VwTNo98gNyFvNUOl9h29nFLuRHrnB8FOO4VSjiYv
         1TFz6gYWwQc3UJcAyXU7tolnUW9tVA4ttAHUETeS3e7o7xDVIj22vwTQinty3pnxB40Y
         7vTS3cMTvaIk2fnFmRfDB3o8xzbXfcqzsak7l8zZQGpXYhuCyoC8OvOkOSv1z2JNkmKS
         X9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0ubRKToedvL//9P7jhXyGfoeodPLCDtwLFN5SKYt9sY=;
        b=bOsIP+cHVqeVlEdFeTk/bihAVe4vghO2EE6iQJ6IW82JvljcKiUd21O3rnysPOdA+u
         eNpqwir9gkG0i69TOPhJYr7Y98pQYQAjNtB3ZhcCKueitQSxj9wdzqpSyl1EaRKomGoW
         d5MquouFqXRDNB4z5VcxqbWitFIcdQgdMgoxdgzQyr/2vysYEVpP3LGWnSLqri/pyMPz
         ySy+nCr7lQ+6wP9+YXRKirvNuIjWos0uxCYAsDojJ1iYMRv4QEfROBumM54pEbbt/ylK
         JBYWpD5jDKgmhgsIakUjOUtX445EGo02uClHF+/NjkI6vXX+gtlf93O7G2ncHUo9ykip
         qu6Q==
X-Gm-Message-State: AODbwcDxq1F8RmDW9+m5KVjTx+XBl3EPFm1rc2+5hc+t3vsmU631zo9y
        o/UvGYberRUa8jTVh98LAA==
X-Received: by 10.98.18.148 with SMTP id 20mr20668084pfs.142.1496965302041;
        Thu, 08 Jun 2017 16:41:42 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.41.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:41:41 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 17/32] convert: convert crlf_to_git to take an index
Date:   Thu,  8 Jun 2017 16:40:45 -0700
Message-Id: <20170608234100.188529-18-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 convert.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/convert.c b/convert.c
index 574003023..ff3e72657 100644
--- a/convert.c
+++ b/convert.c
@@ -219,13 +219,13 @@ static void check_safe_crlf(const char *path, enum crlf_action crlf_action,
 	}
 }
 
-static int has_cr_in_index(const char *path)
+static int has_cr_in_index(const struct index_state *istate, const char *path)
 {
 	unsigned long sz;
 	void *data;
 	int has_cr;
 
-	data = read_blob_data_from_cache(path, &sz);
+	data = read_blob_data_from_index(istate, path, &sz);
 	if (!data)
 		return 0;
 	has_cr = memchr(data, '\r', sz) != NULL;
@@ -255,7 +255,8 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 
 }
 
-static int crlf_to_git(const char *path, const char *src, size_t len,
+static int crlf_to_git(const struct index_state *istate,
+		       const char *path, const char *src, size_t len,
 		       struct strbuf *buf,
 		       enum crlf_action crlf_action, enum safe_crlf checksafe)
 {
@@ -287,7 +288,8 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 		 * unless we want to renormalize in a merge or
 		 * cherry-pick.
 		 */
-		if ((checksafe != SAFE_CRLF_RENORMALIZE) && has_cr_in_index(path))
+		if ((checksafe != SAFE_CRLF_RENORMALIZE) &&
+		    has_cr_in_index(istate, path))
 			convert_crlf_into_lf = 0;
 	}
 	if ((checksafe == SAFE_CRLF_WARN ||
@@ -1099,7 +1101,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		src = dst->buf;
 		len = dst->len;
 	}
-	ret |= crlf_to_git(path, src, len, dst, ca.crlf_action, checksafe);
+	ret |= crlf_to_git(&the_index, path, src, len, dst, ca.crlf_action, checksafe);
 	if (ret && dst) {
 		src = dst->buf;
 		len = dst->len;
@@ -1119,7 +1121,7 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
-	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
+	crlf_to_git(&the_index, path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
 
-- 
2.13.1.508.gb3defc5cc-goog

