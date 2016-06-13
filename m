From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 30/40] apply: make some parsing functions static again
Date: Mon, 13 Jun 2016 18:09:32 +0200
Message-ID: <20160613160942.1806-31-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:11:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUSe-0004W9-BM
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425001AbcFMQLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:11:30 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34556 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424931AbcFMQKu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id n184so16054725wmn.1
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ELPLV22vECQipcnD3X5EsovkkMvlBo38rLDERfpqv3E=;
        b=ap99siax83DFPAIQmS+GqyPyHO1a7HkByLxcR+RrLwztdN5xXzkekkuDcMu/FHDpVr
         6tioo+fJG26ICqSphfHxkxnLIlGSpNzRMfvdJ/xdoQP9DIQXsVnjLVaSMGJOvCoBrBZw
         mzBdmLLZDVOy1/CK5M+VQhfnsHiAGLNb0oFdMF9W+cTd0tuyHbhwJIuhC59t4L4BQCF7
         zsFgq9NuWqB9cQ46hsl2pLZWcm+BOgnD8yvMxlpUxWxwwv56M2nZTVGv+HdUla2jpVac
         wlzIks9T7QIYabfCzCg1MKODtE3ke55kMHCkBpo0Cb+ewu4vMpVob+Kd+bYv6yHG84t2
         JS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ELPLV22vECQipcnD3X5EsovkkMvlBo38rLDERfpqv3E=;
        b=A9TWN44fcyRUWNTnfe3XHXZ+KUwI0rdz0q2evkRynaX7hhoNsf9Q1/yCwqLc2wWET1
         S2Hy8/9PTTmDZXCtyKnMyB+ucUi1zdHx1kVId2it9qbZxoJ62vEeWVY1707+fZOx3RLL
         JX2GqRoWvfZWSpEHe0aa0u4k8otstKWYlzB3pKn5ifujHhsQwWDl/sk5sNK0X65sWG5l
         UMwVXfhsrKHDx7HDQ2eM372jZcRi+PUYY1CO0y0BFG/mORaJ40VEG6JiqP+n1DdU/DUr
         qp70vUtbOjJZabcK7iutSZ0gP/ZQujMRE2LVJAj5FAWRYA1CKgyRsD1oGjg/K7fcGbDC
         Xmsg==
X-Gm-Message-State: ALyK8tJZh1EICYOmMOahcNmCNTlM3fRH1G5iJi8Oauoq8iMSIwEB74g8HeYS7F3DBitjsw==
X-Received: by 10.194.242.163 with SMTP id wr3mr1880526wjc.1.1465834249159;
        Mon, 13 Jun 2016 09:10:49 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:48 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297220>

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
2.9.0.rc2.411.g3e2ca28
