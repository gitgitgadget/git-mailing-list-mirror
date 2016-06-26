Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E7C21F744
	for <e@80x24.org>; Sun, 26 Jun 2016 05:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbcFZF6a (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 01:58:30 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35496 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbcFZF60 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 01:58:26 -0400
Received: by mail-lf0-f68.google.com with SMTP id w130so25692304lfd.2
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 22:58:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DnWJ0clf+mXDRKtRL10XyDlsgUJkPNePFyk2ZgXSxqc=;
        b=QPHamBUQF4MmN5tW6XLkQLsK9A/3PhxoLr6GEJVMKKiFNSUxRZ1sGMaNeWJwh3jaJc
         w/tGcLuTrp4i5dmtDryeR4g7oeeAXsTiTZPdQkJr6R6bJwHajPGWjnF5Jw+G96wF7eTn
         VwWEfLCMgAdqSThe9hBi7lWah1GwesporY9sJu8W3RLhe2ykftVROJvThIc245aio7Xe
         grjVNFcuXbo2S8CT38PJajzgydSW0NNYxJ/59aS0uH7GBE30oj8Ykg6L36dBBOILXx10
         VzXWxL7bgxs5IlXOrJhDtTpcLW2mCwqjgNgcYJT+ZMQ1DMsIqqyzH3rDVDLg8G7vGsc+
         ao1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DnWJ0clf+mXDRKtRL10XyDlsgUJkPNePFyk2ZgXSxqc=;
        b=QnQmRaJJsWcAha7IKEVJKq8KF9NZ+DQyuV4IO0E03/uaDOLHnHzf1lJjYlpB3EGFDr
         YvIe/FvFH6IIebyGvRZLPa/EzMc6WqVjzUS9eu+RG4ZDacoK8A9mtGEWBPuZpwoXLUIB
         EFBpsUCIwiE66gLKLFOKN++llqEKfFY0ROJt5OJVJSsC70r3it+r2Rb5QJMzzswl6PAG
         bRcmsFbEVmwbTajw2eKTm2yrw5wxWXyl4A4rVybRm8NgpPJYKuYWRKQ9VtH4MNrspwpy
         eNwoQNmlMvNWQK8b7hecWXYb3sRaeGsYkj+b/C+I4BgMcNPdNxv4ZUrunFoBxpayF3nB
         o7VA==
X-Gm-Message-State: ALyK8tKX7R3HDg1aJkwb+JxwobBLVzMULuoliw+ycSYx4QEdpKTWnL82DCuiDNqZTQH7iA==
X-Received: by 10.25.16.96 with SMTP id f93mr3659340lfi.114.1466920704802;
        Sat, 25 Jun 2016 22:58:24 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g24sm2123775ljg.20.2016.06.25.22.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Jun 2016 22:58:24 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	marcnarc@xiplink.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 2/5] fetch: refactor ref update status formatting code
Date:	Sun, 26 Jun 2016 07:58:07 +0200
Message-Id: <20160626055810.26960-3-pclouds@gmail.com>
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

This makes it easier to change the formatting later. And it makes sure
translators cannot mess up format specifiers and break Git.

There are a couple call sites where the length of the second column is
TRANSPORT_SUMMARY_WIDTH instead of calculated by TRANSPORT_SUMMARY(),
which is enforced now. The result should be the same because these call
sites do not contain characters outside ASCII range.

The two strbuf_addf() calls instead of one is mostly to reduce
diff-noise in a future patch where "ref -> ref" is reformatted
differently.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/fetch.c | 77 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 38 insertions(+), 39 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1582ca7..a7f152a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -451,6 +451,16 @@ fail:
 
 #define REFCOL_WIDTH  10
 
+static void format_display(struct strbuf *display, char code,
+			   const char *summary, const char *error,
+			   const char *remote, const char *local)
+{
+	strbuf_addf(display, "%c %-*s ", code, TRANSPORT_SUMMARY(summary));
+	strbuf_addf(display, "%-*s -> %s", REFCOL_WIDTH, remote, local);
+	if (error)
+		strbuf_addf(display, "  (%s)", error);
+}
+
 static int update_local_ref(struct ref *ref,
 			    const char *remote,
 			    const struct ref *remote_ref,
@@ -467,9 +477,8 @@ static int update_local_ref(struct ref *ref,
 
 	if (!oidcmp(&ref->old_oid, &ref->new_oid)) {
 		if (verbosity > 0)
-			strbuf_addf(display, "= %-*s %-*s -> %s",
-				    TRANSPORT_SUMMARY(_("[up to date]")),
-				    REFCOL_WIDTH, remote, pretty_ref);
+			format_display(display, '=', _("[up to date]"), NULL,
+				       remote, pretty_ref);
 		return 0;
 	}
 
@@ -481,10 +490,9 @@ static int update_local_ref(struct ref *ref,
 		 * If this is the head, and it's not okay to update
 		 * the head, and the old value of the head isn't empty...
 		 */
-		strbuf_addf(display,
-			    _("! %-*s %-*s -> %s  (can't fetch in current branch)"),
-			    TRANSPORT_SUMMARY(_("[rejected]")),
-			    REFCOL_WIDTH, remote, pretty_ref);
+		format_display(display, '!', _("[rejected]"),
+			       _("can't fetch in current branch"),
+			       remote, pretty_ref);
 		return 1;
 	}
 
@@ -492,11 +500,9 @@ static int update_local_ref(struct ref *ref,
 	    starts_with(ref->name, "refs/tags/")) {
 		int r;
 		r = s_update_ref("updating tag", ref, 0);
-		strbuf_addf(display, "%c %-*s %-*s -> %s%s",
-			    r ? '!' : '-',
-			    TRANSPORT_SUMMARY(_("[tag update]")),
-			    REFCOL_WIDTH, remote, pretty_ref,
-			    r ? _("  (unable to update local ref)") : "");
+		format_display(display, r ? '!' : '-', _("[tag update]"),
+			       r ? _("unable to update local ref") : NULL,
+			       remote, pretty_ref);
 		return r;
 	}
 
@@ -527,11 +533,9 @@ static int update_local_ref(struct ref *ref,
 		    (recurse_submodules != RECURSE_SUBMODULES_ON))
 			check_for_new_submodule_commits(ref->new_oid.hash);
 		r = s_update_ref(msg, ref, 0);
-		strbuf_addf(display, "%c %-*s %-*s -> %s%s",
-			    r ? '!' : '*',
-			    TRANSPORT_SUMMARY(what),
-			    REFCOL_WIDTH, remote, pretty_ref,
-			    r ? _("  (unable to update local ref)") : "");
+		format_display(display, r ? '!' : '*', what,
+			       r ? _("unable to update local ref") : NULL,
+			       remote, pretty_ref);
 		return r;
 	}
 
@@ -545,11 +549,9 @@ static int update_local_ref(struct ref *ref,
 		    (recurse_submodules != RECURSE_SUBMODULES_ON))
 			check_for_new_submodule_commits(ref->new_oid.hash);
 		r = s_update_ref("fast-forward", ref, 1);
-		strbuf_addf(display, "%c %-*s %-*s -> %s%s",
-			    r ? '!' : ' ',
-			    TRANSPORT_SUMMARY_WIDTH, quickref.buf,
-			    REFCOL_WIDTH, remote, pretty_ref,
-			    r ? _("  (unable to update local ref)") : "");
+		format_display(display, r ? '!' : ' ', quickref.buf,
+			       r ? _("unable to update local ref") : NULL,
+			       remote, pretty_ref);
 		strbuf_release(&quickref);
 		return r;
 	} else if (force || ref->force) {
@@ -562,18 +564,14 @@ static int update_local_ref(struct ref *ref,
 		    (recurse_submodules != RECURSE_SUBMODULES_ON))
 			check_for_new_submodule_commits(ref->new_oid.hash);
 		r = s_update_ref("forced-update", ref, 1);
-		strbuf_addf(display, "%c %-*s %-*s -> %s  (%s)",
-			    r ? '!' : '+',
-			    TRANSPORT_SUMMARY_WIDTH, quickref.buf,
-			    REFCOL_WIDTH, remote, pretty_ref,
-			    r ? _("unable to update local ref") : _("forced update"));
+		format_display(display, r ? '!' : '+', quickref.buf,
+			       r ? _("unable to update local ref") : _("forced update"),
+			       remote, pretty_ref);
 		strbuf_release(&quickref);
 		return r;
 	} else {
-		strbuf_addf(display, "! %-*s %-*s -> %s  %s",
-			    TRANSPORT_SUMMARY(_("[rejected]")),
-			    REFCOL_WIDTH, remote, pretty_ref,
-			    _("(non-fast-forward)"));
+		format_display(display, '!', _("[rejected]"), _("non-fast-forward"),
+			       remote, pretty_ref);
 		return 1;
 	}
 }
@@ -714,11 +712,10 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				rc |= update_local_ref(ref, what, rm, &note);
 				free(ref);
 			} else
-				strbuf_addf(&note, "* %-*s %-*s -> FETCH_HEAD",
-					    TRANSPORT_SUMMARY_WIDTH,
-					    *kind ? kind : "branch",
-					    REFCOL_WIDTH,
-					    *what ? what : "HEAD");
+				format_display(&note, '*',
+					       *kind ? kind : "branch", NULL,
+					       *what ? what : "HEAD",
+					       "FETCH_HEAD");
 			if (note.len) {
 				if (verbosity >= 0 && !shown_url) {
 					fprintf(stderr, _("From %.*s\n"),
@@ -812,13 +809,15 @@ static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map,
 
 	if (verbosity >= 0) {
 		for (ref = stale_refs; ref; ref = ref->next) {
+			struct strbuf sb = STRBUF_INIT;
 			if (!shown_url) {
 				fprintf(stderr, _("From %.*s\n"), url_len, url);
 				shown_url = 1;
 			}
-			fprintf(stderr, " x %-*s %-*s -> %s\n",
-				TRANSPORT_SUMMARY(_("[deleted]")),
-				REFCOL_WIDTH, _("(none)"), prettify_refname(ref->name));
+			format_display(&sb, 'x', _("[deleted]"), NULL,
+				       _("(none)"), prettify_refname(ref->name));
+			fprintf(stderr, " %s\n",sb.buf);
+			strbuf_release(&sb);
 			warn_dangling_symref(stderr, dangling_msg, ref->name);
 		}
 	}
-- 
2.8.2.526.g02eed6d

