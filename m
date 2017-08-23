Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20E4C20899
	for <e@80x24.org>; Wed, 23 Aug 2017 12:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754036AbdHWMiF (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 08:38:05 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37169 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753834AbdHWMiE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 08:38:04 -0400
Received: by mail-pg0-f67.google.com with SMTP id 83so1392519pgb.4
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 05:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GDJCwlubITM7zxB8ABqfJW56we6AH9QPRqdLkxOm1Bo=;
        b=NtarlP1JKBjw9Nq8a6hMN9SnX+0U4RktZZHnoOHHih9qORNCwjwSmGNPuu6RRKaB7p
         pu+dJ45uYDdYWsoxR5Rh3CAAIYXvWeCthMWPBmuMErP0lvME2FZh4nJKlnTTgQg33FX4
         11IKGIAmtqVZ4XpLOC0ThhcVmzlfK/Pywb36E4upAWewqQ2tgkIVhM7WxyW7G0XCjlms
         0A21KPIamn/3HVoaUlxT71oPktf8/HmV/u4pXxVvCFq7CKy0BF0inPtnY0QwJkR10Xjs
         /0Ntuvw1kGlsADb2IUrgWT69Mgn23qlSiVlx0ctgixCo0Gb8naZRRNXUycTFSsEUDUmI
         p1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GDJCwlubITM7zxB8ABqfJW56we6AH9QPRqdLkxOm1Bo=;
        b=MhR/ZTLQnPKq1ay6OtitQMWVMr6qBsVXfPIanc0Kn+j4+dGW+24TpSN2Nlpq50akFq
         XDIZftBFcKPZZC6BTFlC4dOWPi2G/aIL0NDlnMV5642UyMAtxj56INt0R9CxZTXb7bKt
         8mQH0p4054YcT46D33EslME3cXqGnolQSk4L8CiYbZ+xrJB5UnfDczX/Yq6yl7OOn3Gd
         BksdrvlUovqtMwKl41CrSGY53xTXiSRMi1kyyFIRYzQ9+fintk81UA5rf4Scwd+o1KOl
         avsqGwLmBICKS73aCPaaZixW+jLTlrdcSWaFJWqLJDPxnKkahz5TQRlrbve4HSUA8zi8
         EwEg==
X-Gm-Message-State: AHYfb5jhZHxA9Sbv7mr6hA14IT3wkDolDO7kObcdHpD8w4WwJtYxKk2s
        kzzGnqXZZnTOF2AB
X-Received: by 10.84.234.9 with SMTP id m9mr2832352plk.15.1503491883759;
        Wed, 23 Aug 2017 05:38:03 -0700 (PDT)
Received: from ash ([115.72.183.215])
        by smtp.gmail.com with ESMTPSA id o10sm3825337pgc.81.2017.08.23.05.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Aug 2017 05:38:03 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 23 Aug 2017 19:37:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 07/16] refs: add refs_head_ref()
Date:   Wed, 23 Aug 2017 19:36:55 +0700
Message-Id: <20170823123704.16518-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170823123704.16518-1-pclouds@gmail.com>
References: <20170823123704.16518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 23 +++++++++++++----------
 refs.h |  2 ++
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index ea8e6b9f42..b3a0a24469 100644
--- a/refs.c
+++ b/refs.c
@@ -1248,27 +1248,30 @@ int refs_rename_ref_available(struct ref_store *refs,
 	return ok;
 }
 
-int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
 	struct object_id oid;
 	int flag;
 
-	if (submodule) {
-		if (resolve_gitlink_ref(submodule, "HEAD", oid.hash) == 0)
-			return fn("HEAD", &oid, 0, cb_data);
-
-		return 0;
-	}
-
-	if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag))
+	if (!refs_read_ref_full(refs, "HEAD", RESOLVE_REF_READING,
+				oid.hash, &flag))
 		return fn("HEAD", &oid, flag, cb_data);
 
 	return 0;
 }
 
+int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	struct ref_store *refs = get_submodule_ref_store(submodule);
+
+	if (!refs)
+		return -1;
+	return refs_head_ref(refs, fn, cb_data);
+}
+
 int head_ref(each_ref_fn fn, void *cb_data)
 {
-	return head_ref_submodule(NULL, fn, cb_data);
+	return refs_head_ref(get_main_ref_store(), fn, cb_data);
 }
 
 struct ref_iterator *refs_ref_iterator_begin(
diff --git a/refs.h b/refs.h
index 6daa78eb50..8073f8ab56 100644
--- a/refs.h
+++ b/refs.h
@@ -275,6 +275,8 @@ typedef int each_ref_fn(const char *refname,
  * modifies the reference also returns a nonzero value to immediately
  * stop the iteration. Returned references are sorted.
  */
+int refs_head_ref(struct ref_store *refs,
+		  each_ref_fn fn, void *cb_data);
 int refs_for_each_ref(struct ref_store *refs,
 		      each_ref_fn fn, void *cb_data);
 int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
-- 
2.11.0.157.gd943d85

