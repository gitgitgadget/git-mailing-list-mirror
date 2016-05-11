From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 80/94] apply: make some parsing functions static again
Date: Wed, 11 May 2016 15:17:31 +0200
Message-ID: <20160511131745.2914-81-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:21:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U4o-0004fs-8a
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbcEKNVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:21:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34046 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932369AbcEKNVN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:21:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id n129so9423483wmn.1
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4oEwGezap6FvPd7cFAukVIlOY9TVKH9YgZsbVsRLAb4=;
        b=u0Xb0Xak95T/L6ToC2f3PN42gZ5/l1+RPasCqj2LXczx4ka4rO8UbYQCF6PNw0gGZL
         v7+b9ifk5oxrt/FzaV7tbXAt4BaFBCxW19JWg0Ox75jQL0PkOghgmyC5+KenGkfzSDOi
         IxlkoTCwpPh2KYf6oRo6sEPkDpqQSs20Y6EO8RGLGZhA/MF10g4tHs49VJV4y431tR0c
         MUAGtUy8blX72D09TOk60e2z56CXBBfbPyvRdBh2P2lbSbdfBDVv76wpjrMAhSHjKSqA
         XkQs27zVE3Ia/Rz+6REps5STowM9hbSAFzchXgHHZ7jg1dVu7SRwViC2V9ldmsd53lNd
         RL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4oEwGezap6FvPd7cFAukVIlOY9TVKH9YgZsbVsRLAb4=;
        b=etfNd0xnyWyugKscTZFOVIkYNwww8TEZLo+/6i5OtpSMqEFKV356RCFS53h0Fk/GwN
         EOmqznK8ZmlfNJ5UEa0UTHO+FFqrxJSZ43hPw32fXQ6buVVvp0Ar4qatopYm5FV8s79e
         YVxDyEPJ7J+JuirfWVA2fp+MZiSSSgSQyN+d+eS8OAlKKNuCrbQ5BNnLZYVkBjQ9mkzi
         W1rg1hhYSVYebgw1HDJJtlsVVmjH2S0H8EaJur3dVoz7epjOh2DFfhkfqOGXIck8hKcV
         skOJI907YxyPPkDIH3NSgQU2ZgyvmOw2qFTFiB8MVcwVAqZ70pd3GXt53Sx6h4Sgh1vc
         Kqnw==
X-Gm-Message-State: AOPr4FVFKHOdATFudRo8L+sgaD9zyaOMdJ3GR9vfVUDpGoB5xplOxNkiFj4e9Q2bszAySg==
X-Received: by 10.28.62.15 with SMTP id l15mr92078wma.30.1462972872375;
        Wed, 11 May 2016 06:21:12 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:21:11 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294295>

Some parsing functions that were used in both "apply.c" and
"builtin/apply.c" are now only used in the former, so they
can be made static to "apply.c".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 6 +++---
 apply.h | 5 -----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/apply.c b/apply.c
index 537221b..3285bf7 100644
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
index c8b79ce..27b26a2 100644
--- a/apply.h
+++ b/apply.h
@@ -112,11 +112,6 @@ struct apply_state {
 	enum ws_ignore ws_ignore_action;
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
2.8.2.490.g3dabe57
