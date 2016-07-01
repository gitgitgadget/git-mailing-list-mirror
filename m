Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B467A2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 16:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbcGAQUJ (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 12:20:09 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36349 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbcGAQUH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 12:20:07 -0400
Received: by mail-lf0-f65.google.com with SMTP id a2so11774763lfe.3
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 09:19:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=spr4eFgcKjDehaTeSEmYXRJU+VR2WWCyVPHhAys9zgw=;
        b=ymX+c5AFK7lT/ORM6CxWZcX3bb0KNmBnPHZ7QJ99sHamCpoXCVdOJCpAfZaRzgx4Sp
         yBCS0mq6twbXVF7S8AZC4O0abki7KDxf5X2N3N5xJla1kWxqZKwJDZvKdIk/U8xkZm75
         SGRtDkskzPhYa+Noks4RJnDHCz5ZYjHRQdqJd7SQmbFDCwmIXVtlcG5Nt7rdFZaFWW9r
         7XRiwRveZWIo9BeR365Br+gZBNvvh8gqGTJH6wcWzE/odiHGSBVcqrvAUmLHBrkVhaSx
         jdZtM1zpo0cfLN2CToUlkIruTt9nwzf9cv7bGrqduzSPKMIzaq1O27zrhlMd5SOlb/1h
         3X+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=spr4eFgcKjDehaTeSEmYXRJU+VR2WWCyVPHhAys9zgw=;
        b=ZPSGOnXFygFdgJ/W5u0akTKTon6BTem4iGbOMgGWawuJS2lm8YhicjLz1wLp274e1S
         6IMtnE1dmGKi7dZpnHEEl9wV3yMw3F+/lOtOQFoTBNU/mz+hl9UHBYo8t3UOhJQjSxIo
         RCR/dntJIO3/JO/TimpYaKR5c8xyLULtSwBk0PPkc7NcVg1IAfDz8dNTk6MAgy4ZzeEP
         2JiT5BxMVLr2jmcYzJa5LnmsOhx5OnlVk02T1OuzxKMrGtbTVQtUX/KFRDLJZYHPAvaF
         mcv+q9+ydPkk1COe/rU6+7nCMB5LC3awNk84N2paFK7TD08AWIxdGN0/ytp7pVAzVzqB
         5RIQ==
X-Gm-Message-State: ALyK8tLXmeCcAUo9CK8VCSebeCfCn8DvFJJrN4+eB1L2AX1gmkPZRGLCUf0+6ukFSfLBuA==
X-Received: by 10.25.38.213 with SMTP id m204mr7105131lfm.107.1467389031626;
        Fri, 01 Jul 2016 09:03:51 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id k18sm884102lfg.47.2016.07.01.09.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Jul 2016 09:03:50 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, marcnarc@xiplink.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 4/5] fetch: align all "remote -> local" output
Date:	Fri,  1 Jul 2016 18:03:30 +0200
Message-Id: <20160701160331.29252-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.531.gd073806
In-Reply-To: <20160701160331.29252-1-pclouds@gmail.com>
References: <20160626055810.26960-1-pclouds@gmail.com>
 <20160701160331.29252-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We do align "remote -> local" output by allocating 10 columns to
"remote". That produces aligned output only for short refs. An extra
pass is performed to find the longest remote ref name (that does not
produce a line longer than terminal width) to produce better aligned
output.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/fetch.c  | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 t/t5510-fetch.sh | 15 +++++++++++++++
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8177f90..2bc609b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -15,6 +15,7 @@
 #include "submodule.h"
 #include "connected.h"
 #include "argv-array.h"
+#include "utf8.h"
 
 static const char * const builtin_fetch_usage[] = {
 	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
@@ -449,14 +450,54 @@ fail:
 			   : STORE_REF_ERROR_OTHER;
 }
 
-#define REFCOL_WIDTH  10
+static int refcol_width = 10;
+
+static void adjust_refcol_width(const struct ref *ref)
+{
+	int max, rlen, llen, len;
+
+	/* uptodate lines are only shown on high verbosity level */
+	if (!verbosity && !oidcmp(&ref->peer_ref->old_oid, &ref->old_oid))
+		return;
+
+	max    = term_columns();
+	rlen   = utf8_strwidth(prettify_refname(ref->name));
+	llen   = utf8_strwidth(prettify_refname(ref->peer_ref->name));
+
+	/*
+	 * rough estimation to see if the output line is too long and
+	 * should not be counted (we can't do precise calculation
+	 * anyway because we don't know if the error explanation part
+	 * will be printed in update_local_ref)
+	 */
+	len = 21 /* flag and summary */ + rlen + 4 /* -> */ + llen;
+	if (len >= max)
+		return;
+
+	if (refcol_width < rlen)
+		refcol_width = rlen;
+}
+
+static void prepare_format_display(struct ref *ref_map)
+{
+	struct ref *rm;
+
+	for (rm = ref_map; rm; rm = rm->next) {
+		if (rm->status == REF_STATUS_REJECT_SHALLOW ||
+		    !rm->peer_ref ||
+		    !strcmp(rm->name, "HEAD"))
+			continue;
+
+		adjust_refcol_width(rm);
+	}
+}
 
 static void format_display(struct strbuf *display, char code,
 			   const char *summary, const char *error,
 			   const char *remote, const char *local)
 {
 	strbuf_addf(display, "%c %-*s ", code, TRANSPORT_SUMMARY(summary));
-	strbuf_addf(display, "%-*s -> %s", REFCOL_WIDTH, remote, local);
+	strbuf_addf(display, "%-*s -> %s", refcol_width, remote, local);
 	if (error)
 		strbuf_addf(display, "  (%s)", error);
 }
@@ -618,6 +659,8 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 		goto abort;
 	}
 
+	prepare_format_display(ref_map);
+
 	/*
 	 * We do a pass for each fetch_head_status type in their enum order, so
 	 * merged entries are written before not-for-merge. That lets readers
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 454d896..f50497e 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -688,4 +688,19 @@ test_expect_success 'fetching with auto-gc does not lock up' '
 	)
 '
 
+test_expect_success 'fetch aligned output' '
+	git clone . full-output &&
+	test_commit looooooooooooong-tag &&
+	(
+		cd full-output &&
+		git fetch origin 2>&1 | \
+			grep -e "->" | cut -c 22- >../actual
+	) &&
+	cat >expect <<-\EOF &&
+	master               -> origin/master
+	looooooooooooong-tag -> looooooooooooong-tag
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.8.2.531.gd073806

