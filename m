From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/3] fetch: refactor ref update status formatting code
Date: Fri,  3 Jun 2016 18:08:42 +0700
Message-ID: <20160603110843.15434-3-pclouds@gmail.com>
References: <20160522112019.26516-1-pclouds@gmail.com>
 <20160603110843.15434-1-pclouds@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 13:09:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8myi-0006oW-Q4
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 13:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbcFCLJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 07:09:07 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33823 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932646AbcFCLJF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 07:09:05 -0400
Received: by mail-pf0-f193.google.com with SMTP id c84so11250927pfc.1
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 04:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SyFBaAvuHMS7z4sC//MZd8+4nX6DWsNHHCBMKD9CWA4=;
        b=r+AgdBXAd2m7z3cOZ7up7Kcn0kOakT4+s7tx2W95zw9EpwPEBxAjGpJEk8d2iBWUNT
         uajsP2kokOELPOii50CqpRbYUnDnA+8ziJLL+9UnP+/Zpa3Bel7LprJUR4BGvk1OcWkb
         DXSgTPRhqT29Y5B8wI/7OE9aQNmoveEzsHSwcvLvRh/N5aBpzbPwPmBbPzNGcdbHjQKR
         k8kSgydubQYaPxkiP+NKaHoT34KU3YFZ8YOq2CY/6H3l6m9GyYparjcGrgf1Ie2mImyQ
         6D+HJCOBTKQQmWDY8L2PjLAS45Y4AGQTRZtygKAorMm1zaz2XypHuTrehlN4eKX29nFV
         vaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SyFBaAvuHMS7z4sC//MZd8+4nX6DWsNHHCBMKD9CWA4=;
        b=kHdcnfTZi1pLCeto2ZPolWk9J9mEb+9VHO6qETrxVgqgMjJ6vj4QDx9rqr/qsVJNan
         srdDgQoKfg1ZqMeuithQk4KYyLYjG6dV7I4hjbb8vsuu+SeB4dYWCTdxQvz2bYTTqxWg
         Ky26elAYYuW9E13Gig1h8yZLnxklqt3393biTK0coQ9qhb6vgjkEASlkbAFuyJHMrpZH
         g+5hJ9OOcUAhRSDgA3rSAGwDmBofd28z1TGhi7XN3Jp8Fm32svAjUo057nr9WBP/NnJ8
         54FinZrdp8r4/SyM+h/MhBfo0xDNfJwrQmR064BrbNqngYoQ4SrVbSk24Ia1dMPZTLBl
         F3Ng==
X-Gm-Message-State: ALyK8tICW6xU9Rlq8LS1e4akoZ+w05TYI2toxhRS85w025gXyDlmV/ATpyLoj/hfAqy02A==
X-Received: by 10.98.89.213 with SMTP id k82mr5417339pfj.99.1464952144654;
        Fri, 03 Jun 2016 04:09:04 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id c206sm7625367pfc.40.2016.06.03.04.09.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jun 2016 04:09:03 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 03 Jun 2016 18:08:59 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160603110843.15434-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296300>

This makes it easier to change the formatting later. And it makes sure
translators cannot mess up format specifiers and break Git.

There are a couple call sites where the length of the second column is
TRANSPORT_SUMMARY_WIDTH instead of calculated by TRANSPORT_SUMMARY(),
which is enforced now. The result should be the same because these call
sites do not contain characters outside ASCII range.

The two strbuf_addf() calls instead of one is mostly to reduce
diff-noise in a future patch where "ref -> ref" is reformatted
differently.
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
2.8.2.524.g6ff3d78
