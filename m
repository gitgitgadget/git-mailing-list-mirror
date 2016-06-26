Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 997091FEAA
	for <e@80x24.org>; Sun, 26 Jun 2016 05:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbcFZF6e (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 01:58:34 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33076 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbcFZF62 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 01:58:28 -0400
Received: by mail-lf0-f65.google.com with SMTP id l188so25751467lfe.0
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 22:58:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EEaCa1XnpuDZZ4sgSD5sUly542vs2uQpBlC8YL3CyCc=;
        b=L52UwwFxzt6l2GczmuFBmwj6eX5S60o3mdvvlqUp7ta2ztEKFXlYouPxYQSOyQseu4
         +eV3NZBO16/KwZsoX/YwYImPp+mjwMyWvAz+lUt97phqBZ5POaPpSaXi96/9ZT7d6S0m
         9sR0Oyc6SLO76RPDh5PJ1fer9qcZoxXqYAW7qOgGGB5PoJ/6h+hO+UNZ1HaXDno5Sjx9
         xMoJpwKL0WGIWt2Qk6/NWLXM3D5x4SlrqDWep7/1IC5ivPB7My/rBWE1U4WLcHGOaCzn
         jw34bPK56BIz5D8KSHFwkrB/4dsLA6brxpAmFpvnGJR8q8joozPMz2g6cw+2GDiv/+pb
         uwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EEaCa1XnpuDZZ4sgSD5sUly542vs2uQpBlC8YL3CyCc=;
        b=JG1aqYYhMvUqbh7a5Wp1YMHeRVynWKYLSSTX2XlgajB950MaaM3e0OdXiG8/5bX/fQ
         BDEA2lswU4gMBDFBnY+qxAn/Bl5+r8mZkDVaKvGZrfUBK7Krj+ggNXjClfK/A45+Jw0q
         Pjl1jcvXvoBz2DCKhg166Bm0aMOQaVr1Z+/pCDPkFmbYFVHQ/Am7qCQw/kxCRSn9e+hM
         m8oc0esocyIEyz3Tx0m5xow+dTUuLiXejB/mL+aaMzTYnfdr2Zy2I1+tT/U9EaDFZUb/
         sFcw/XdEB6U8CdCaVPbiq+Rj3+3af0e3UpRnj7fM9/NY+VfI+Nk0wNhyPND0c1Zz2PTm
         8Hdw==
X-Gm-Message-State: ALyK8tKgpLsSMopytUaeu59Y1nVh21ponmc1qyuVT0hxWitJjV1bftlQavdmTSCRrMyG4w==
X-Received: by 10.25.25.79 with SMTP id 76mr3721975lfz.14.1466920706727;
        Sat, 25 Jun 2016 22:58:26 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g24sm2123775ljg.20.2016.06.25.22.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Jun 2016 22:58:26 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	marcnarc@xiplink.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 4/5] fetch: align all "remote -> local" output
Date:	Sun, 26 Jun 2016 07:58:09 +0200
Message-Id: <20160626055810.26960-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160626055810.26960-1-pclouds@gmail.com>
References: <20160605031141.23513-1-pclouds@gmail.com>
 <20160626055810.26960-1-pclouds@gmail.com>
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
 builtin/fetch.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 t/t5510-fetch.sh | 15 +++++++++++++++
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8177f90..c42795b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -15,6 +15,7 @@
 #include "submodule.h"
 #include "connected.h"
 #include "argv-array.h"
+#include "utf8.h"
 
 static const char * const builtin_fetch_usage[] = {
 	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
@@ -449,14 +450,53 @@ fail:
 			   : STORE_REF_ERROR_OTHER;
 }
 
-#define REFCOL_WIDTH  10
+static int refcol_width = 10;
+
+static void adjust_refcol_width(const struct ref *ref)
+{
+	int max, rlen, llen;
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
+	if (21 /* flag and summary */ + rlen + 4 /* -> */ + llen >= max)
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
@@ -618,6 +658,8 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
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
2.8.2.526.g02eed6d

