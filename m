Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25DF01F404
	for <e@80x24.org>; Mon, 25 Dec 2017 10:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750936AbdLYKh1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 05:37:27 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39826 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbdLYKh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 05:37:26 -0500
Received: by mail-pl0-f66.google.com with SMTP id bi12so16541253plb.6
        for <git@vger.kernel.org>; Mon, 25 Dec 2017 02:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0FNmZFmcdtVUjqtdt5QwSjG/4v0jOEsYQWhcBuBELHA=;
        b=DPcbkux49TU+I+6vy1Tw2wI7KTxpT7bJoMn5UeG1K1N15TBc5kJ7tx7vTCLKAKQ87i
         olcn3IdEP1blbsYO+84PsaPXeY0wjQJ/Hl5djK2iH8uijKGrpbhug8Qja+PuAY/oDY6F
         CEow1nEvbi+tQtG3+AtABKnF98LK6m8CDxnp3DhE+DQ9ZrAVNjvUBgfKcnfPMpNi2+sm
         buUq1MQDRQGtD04DUf5wHW1AyfLJHRspAf+njoj2/BOP2WhW5r1IscXZ1JrdiQb/Hc4f
         f/2rzPL8IYxW3BIp6c8FfSXBC+Qz254QbHbybkKGk2jeHKdrxR7N2q3Yz1QbqG99luNM
         VP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0FNmZFmcdtVUjqtdt5QwSjG/4v0jOEsYQWhcBuBELHA=;
        b=rhOWo/p8IUBQdSpsVLQikaUzRCjKUPWfMQEpS/RYkfASVGfC7fRIIjmX2y2a97quu3
         sapsJ2I43qndprHogtQUf1/1MT/K7WN3aBVCnkPWzCGBpe6/O7BEdG9nGXKpvCElRF7s
         04BQ+ycWivlVFr92wkECDUFjDsW+sAw+G82Y3t89YaQxx+0A41YyDRexV1y8PQ/Guk/o
         kaLVYjJNcIeFCMthBcdh0gXr1AFEGpniR04Dsm8WZkc4/5Ss6qP9qW8ipjiSmi95SoiX
         OR7fwKRpiyArSUGwkjDOoersLR8mzKRdZlWs34X5MH2EMe5EPwo2Znrp0CEfJ4v6Qd2w
         S5Rw==
X-Gm-Message-State: AKGB3mKApJ6VtsNdoJhqn+MAgczQ7bLuPXtYZ7CBysotFxp6aJ3Eo8Kb
        68N0ysDNed8WWNQErwrwtf98Ew==
X-Google-Smtp-Source: ACJfBot73wiKQLSnS6iHX3Mpa7C4AfFkdyMTMV/KPtM7ib327N4WjYCH4wDxDAzEe1uiutGzpJhQNQ==
X-Received: by 10.159.203.198 with SMTP id r6mr22348497plo.11.1514198245326;
        Mon, 25 Dec 2017 02:37:25 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id t66sm60461734pfa.153.2017.12.25.02.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Dec 2017 02:37:24 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 25 Dec 2017 17:37:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     alexmv@dropbox.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] status: handle worktree renames
Date:   Mon, 25 Dec 2017 17:37:18 +0700
Message-Id: <20171225103718.24443-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.0.320.g0453912d77
In-Reply-To: <alpine.DEB.2.10.1712221829430.29746@alexmv-linux>
References: <alpine.DEB.2.10.1712221829430.29746@alexmv-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before 425a28e0a4 (diff-lib: allow ita entries treated as "not yet exist
in index" - 2016-10-24) there are never "new files" in the index, which
essentially disables rename detection because we only detect renames
when a new file appears in a diff pair.

After that commit, an i-t-a entry can appear as a new file in "git
diff-files". But the diff callback function in wt-status.c does not
handle this case and produces incorrect status output.

Handle this rename case. While at there make sure unhandled diff status
code is reported to catch cases like this easier in the future.

The reader may notice that this patch adds a new xstrdup() but not a
free(). Yes we leak memory (the same for head_path). But wt_status so
far has been short lived, this leak should not matter in practice.

Noticed-by: Alex Vandiver <alexmv@dropbox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t2203-add-intent.sh | 15 +++++++++++++++
 wt-status.c           | 24 +++++++++++++++++++-----
 wt-status.h           |  1 +
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 1bdf38e80d..41a8874e60 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -150,5 +150,20 @@ test_expect_success 'commit: ita entries ignored in empty commit check' '
 	)
 '
 
+test_expect_success 'rename detection finds the right names' '
+	git init rename-detection &&
+	(
+		cd rename-detection &&
+		echo contents > original-file &&
+		git add original-file &&
+		git commit -m first-commit &&
+		mv original-file new-file &&
+		git add -N new-file &&
+		git status --porcelain | grep -v actual >actual &&
+		echo " R original-file -> new-file" >expected &&
+		test_cmp expected actual
+	)
+'
+
 test_done
 
diff --git a/wt-status.c b/wt-status.c
index ef26f07446..f0b5b3d46a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -376,6 +376,8 @@ static void wt_longstatus_print_change_data(struct wt_status *s,
 			strbuf_addch(&extra, ')');
 		}
 		status = d->worktree_status;
+		if (d->worktree_path)
+			one_name = d->worktree_path;
 		break;
 	default:
 		die("BUG: unhandled change_type %d in wt_longstatus_print_change_data",
@@ -432,7 +434,7 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 		struct wt_status_change_data *d;
 
 		p = q->queue[i];
-		it = string_list_insert(&s->change, p->one->path);
+		it = string_list_insert(&s->change, p->two->path);
 		d = it->util;
 		if (!d) {
 			d = xcalloc(1, sizeof(*d));
@@ -459,6 +461,12 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 			/* mode_worktree is zero for a delete. */
 			break;
 
+		case DIFF_STATUS_COPIED:
+		case DIFF_STATUS_RENAMED:
+			d->worktree_path = xstrdup(p->one->path);
+			d->score = p->score * 100 / MAX_SCORE;
+			/* fallthru */
+
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_TYPE_CHANGED:
 		case DIFF_STATUS_UNMERGED:
@@ -467,8 +475,8 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 			oidcpy(&d->oid_index, &p->one->oid);
 			break;
 
-		case DIFF_STATUS_UNKNOWN:
-			die("BUG: worktree status unknown???");
+		default:
+			die("BUG: unhandled worktree status '%c'", p->status);
 			break;
 		}
 
@@ -548,6 +556,10 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
 			 * values in these fields.
 			 */
 			break;
+
+		default:
+			die("BUG: unhandled worktree status '%c'", p->status);
+			break;
 		}
 	}
 }
@@ -1724,8 +1736,10 @@ static void wt_shortstatus_status(struct string_list_item *it,
 	} else {
 		struct strbuf onebuf = STRBUF_INIT;
 		const char *one;
-		if (d->head_path) {
-			one = quote_path(d->head_path, s->prefix, &onebuf);
+
+		one = d->head_path ? d->head_path : d->worktree_path;
+		if (one) {
+			one = quote_path(one, s->prefix, &onebuf);
 			if (*one != '"' && strchr(one, ' ') != NULL) {
 				putchar('"');
 				strbuf_addch(&onebuf, '"');
diff --git a/wt-status.h b/wt-status.h
index fe27b465e2..572a720123 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -48,6 +48,7 @@ struct wt_status_change_data {
 	int mode_head, mode_index, mode_worktree;
 	struct object_id oid_head, oid_index;
 	char *head_path;
+	char *worktree_path;
 	unsigned dirty_submodule       : 2;
 	unsigned new_submodule_commits : 1;
 };
-- 
2.15.0.320.g0453912d77

