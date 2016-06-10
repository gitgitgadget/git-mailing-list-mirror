From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 30/44] apply: make some parsing functions static again
Date: Fri, 10 Jun 2016 22:11:04 +0200
Message-ID: <20160610201118.13813-31-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:13:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSnw-0004Bg-BR
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042AbcFJUMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:12:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34502 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932296AbcFJUMc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id n184so1057393wmn.1
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oyDA4O4OISq4mqBoI3k2oeeAH9mx+DnD2cP4iDoQLmw=;
        b=V4pMkUUYcSNdjK8ODzIqB5c5D9grjd/rnwQbT8SSHzm1bW4CW0qskH0UpVaOgWbdlC
         FW7cFNkHEDZ0Y7Jhn9NTcgA28zDz62O0yy0zOfhJ2IWTlkvvqAVHSWcJHkBh7pWBqU5I
         rRDWc+f9RSKvRNyhxbRb6xTNH+8Wf3U6BMsEu4wnvps3+LFYo7DKW7GdLWtKH06q7iqn
         RbA4/VjrYYl/ODzR0eSQjTiLVs6xM5VpoRppon+vsDWzSF3yW7+P4GW/D+qYgtkdOO95
         y2pSWqHCLv8P4OZvHx+ql0p+sLw7MLtPtbhxDtliuEd+r+MgUmFR2Sli64w8jQqpHf4P
         phDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oyDA4O4OISq4mqBoI3k2oeeAH9mx+DnD2cP4iDoQLmw=;
        b=H4LMXqsreX1qbiSrEzB2GsYSrutbxcYX5Oofzxc5qYtzewsRSSd8yG8xuXYstHZkhx
         qTE2N5KBnIwBlkSYLnB2BflGo8SNe7XNevFMtFU9txkDjFaro5Zzwj2SgP4PIIUpuHWh
         BHz97ffjQCS6lxy4LfAQKGbtq4SO6WtO63SChtx7z+K+nMdQsVC8+Bt75b5nuQO2OVxa
         0jS2L15uP8fNNsiOGSeQCq3Cdfc2VinTq9xiR4pkrMHqgEMgnJBlRtzVjGS7fDtZGiO3
         mcHwTiBI48Sm6owCGeBaH+d5CH2HBkTAbNIerDsOLOCmrqld2ZcIB4ubowhxY1apHmii
         GCAw==
X-Gm-Message-State: ALyK8tJMmvcq3eYqhaqIbBFDkIsBv9txIqjZKtuUEB9Nm3SvVDBUv4s+ad3MfLTNjkbR6g==
X-Received: by 10.28.21.204 with SMTP id 195mr626501wmv.64.1465589551534;
        Fri, 10 Jun 2016 13:12:31 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:30 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297053>

Some parsing functions that were used in both "apply.c" and
"builtin/apply.c" are now only used in the former, so they
can be made static to "apply.c".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 6 +++---
 apply.h | 5 -----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/apply.c b/apply.c
index 4920fa8..713d1c0 100644
--- a/apply.c
+++ b/apply.c
@@ -27,7 +27,7 @@ static void git_apply_config(void)
 	git_config(git_default_config, NULL);
 }
 
-int parse_whitespace_option(struct apply_state *state, const char *option)
+static int parse_whitespace_option(struct apply_state *state, const char *option)
 {
 	if (!option) {
 		state->ws_error_action = warn_on_ws_error;
@@ -57,8 +57,8 @@ int parse_whitespace_option(struct apply_state *state, const char *option)
 	return error(_("unrecognized whitespace option '%s'"), option);
 }
 
-int parse_ignorewhitespace_option(struct apply_state *state,
-				  const char *option)
+static int parse_ignorewhitespace_option(struct apply_state *state,
+						 const char *option)
 {
 	if (!option || !strcmp(option, "no") ||
 	    !strcmp(option, "false") || !strcmp(option, "never") ||
diff --git a/apply.h b/apply.h
index 736f818..89e7982 100644
--- a/apply.h
+++ b/apply.h
@@ -97,11 +97,6 @@ struct apply_state {
 	int applied_after_fixing_ws;
 };
 
-extern int parse_whitespace_option(struct apply_state *state,
-				   const char *option);
-extern int parse_ignorewhitespace_option(struct apply_state *state,
-					 const char *option);
-
 extern int apply_option_parse_exclude(const struct option *opt,
 				      const char *arg, int unset);
 extern int apply_option_parse_include(const struct option *opt,
-- 
2.9.0.rc2.362.g3cd93d0
