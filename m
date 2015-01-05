From: Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH] format-patch: Add config option format.coverbodytext to change the cover letter body
Date: Mon,  5 Jan 2015 11:28:25 -0800
Message-ID: <1420486105-30242-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 05 20:29:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8DKW-00019I-Do
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 20:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744AbbAET2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2015 14:28:40 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:59212 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342AbbAET2j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2015 14:28:39 -0500
Received: by mail-ie0-f181.google.com with SMTP id rl12so18307521iec.12
        for <git@vger.kernel.org>; Mon, 05 Jan 2015 11:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=HTslpQvqB5Lmwh18Aq06pAxhhLV71ecVToYmF22Bv5g=;
        b=U4CtiSssIUj4piWLHO3/TpRN0YugLazVU3/7/+lKVBWQKY4cTOcQZsdss0gR02qDHw
         oPGmdnPkfNMrNMPGbfi+9LwCVcFhy5T2l4TyLqtrotaDPv094U9XdNhFrCq8L3ygv4+N
         uB6Jb9BoFBoaWxTaCROVUdP1cDWVmNJPNmbepWtcXpTLkK+DzacB5JbkGIvWSRyiusL3
         sMrRrFUgOxvOSNp6dlrj2cZCsLcMYDkyRzmrftEJ5QmtxoopKxDzK9nxHqqyEsb3IWQw
         vbY9HWU3ZzR6z8o3dCEsaMUnzLx/98wg7283ip55oFLWh0hAb+4IzxO3UgqZMVtp08b/
         Kp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HTslpQvqB5Lmwh18Aq06pAxhhLV71ecVToYmF22Bv5g=;
        b=hkdvPyBeaA6Z1nAuSbNWZ0QuVBf96hxnT7Y0ALuPBOeTiZMVecc0rdpkHxfbvwwBbY
         iNuNtkcchs5DEut5CZM8QqILE7OaHV7CuECVe+PnqGN7ruiSm2RT9gZL8R/yhNiCPgQ4
         sVVB535n9RLyZq4oa8yp80u+mz+k+c+T//Fztm3cLu6Uj9VF8ieROGzyTz6HVS83g5FJ
         Fzfz5MG/U0LptTcImPA0P5zDUD1HbFJloC+xSZnyBlyGQIcIjM2/9WzD0VHCrZp5bxsb
         EffsaasIo4kjDn7X1x8oLu//NN3L+YDYHnwwUNknRFEnI6G9SIWe200IhJt9Hqc+FZmH
         Z0qg==
X-Gm-Message-State: ALoCoQkJ4CybiNROsZ60o67aJDCIdVJh6yTlw41KThIP2DqCB1Z7ydR68gVl8I8xAEHC6TR4fxyB
X-Received: by 10.107.160.143 with SMTP id j137mr22635069ioe.43.1420486118689;
        Mon, 05 Jan 2015 11:28:38 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:9882:2f2a:8d4c:ba76])
        by mx.google.com with ESMTPSA id m2sm26998648ioi.10.2015.01.05.11.28.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Jan 2015 11:28:38 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262027>

When sending out patch series one of the last things doing is writing
the cover letter. The cover letter would be a good place to remind
people to check the todo list for sending patches. As people have
different levels of confidence and sloppiness this todo list may be
lengthier for some people compared to others. To make this possible
this adds a way to put your personal todo list for sending patches in
the cover letter, so you'll see it every time you intend to send patches.

This intentionally doesn't let you configure the subject line of the cover letter
as send email will stop you if you want to send out the coverletter with untouched
subject line (*** SUBJECT HERE***).

Not-signed-off-by: Stefan Beller <sbeller@google.com> as it's RFC.

---
 builtin/log.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 734aab3..84da54d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -34,6 +34,7 @@ static int default_show_root = 1;
 static int decoration_style;
 static int decoration_given;
 static int use_mailmap_config;
+static const char *fmt_patch_body_text = "*** BLURB HERE ***";
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
@@ -374,6 +375,8 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		return git_config_string(&fmt_pretty, var, value);
 	if (!strcmp(var, "format.subjectprefix"))
 		return git_config_string(&fmt_patch_subject_prefix, var, value);
+	if (!strcmp(var, "format.coverbodytext"))
+		return git_config_string(&fmt_patch_body_text, var, value);
 	if (!strcmp(var, "log.abbrevcommit")) {
 		default_abbrev_commit = git_config_bool(var, value);
 		return 0;
@@ -904,8 +907,8 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			      int quiet)
 {
 	const char *committer;
-	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n";
-	const char *msg;
+	const char *subject = "*** SUBJECT HERE ***\n\n";
+	struct strbuf msg = STRBUF_INIT;
 	struct shortlog log;
 	struct strbuf sb = STRBUF_INIT;
 	int i;
@@ -937,16 +940,18 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	if (!branch_name)
 		branch_name = find_branch_name(rev);
 
-	msg = body;
+	strbuf_addstr(&msg, subject);
+	strbuf_addstr(&msg, fmt_patch_body_text);
 	pp.fmt = CMIT_FMT_EMAIL;
 	pp.date_mode = DATE_RFC2822;
 	pp_user_info(&pp, NULL, &sb, committer, encoding);
-	pp_title_line(&pp, &msg, &sb, encoding, need_8bit_cte);
-	pp_remainder(&pp, &msg, &sb, 0);
+	pp_title_line(&pp, &msg.buf, &sb, encoding, need_8bit_cte);
+	pp_remainder(&pp, &msg.buf, &sb, 0);
 	add_branch_description(&sb, branch_name);
 	printf("%s\n", sb.buf);
 
 	strbuf_release(&sb);
+	strbuf_release(&msg);
 
 	shortlog_init(&log);
 	log.wrap_lines = 1;
-- 
2.2.1.62.g3f15098
