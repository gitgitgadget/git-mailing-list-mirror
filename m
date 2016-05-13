From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH 2/2] bisect--helper: `bisect_voc` shell function in C
Date: Sat, 14 May 2016 01:32:17 +0530
Message-ID: <1463169737-12701-2-git-send-email-pranit.bauva@gmail.com>
References: <1463169737-12701-1-git-send-email-pranit.bauva@gmail.com>
Cc: christian.couder@gmail.com, chriscool@tuxfamily.org,
	larsxschneider@gmail.com, Pranit Bauva <pranit.bauva@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 22:04:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1JKL-0003Ej-Eg
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 22:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbcEMUEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 16:04:45 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34295 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932211AbcEMUEo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 16:04:44 -0400
Received: by mail-pf0-f194.google.com with SMTP id 145so10038784pfz.1
        for <git@vger.kernel.org>; Fri, 13 May 2016 13:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OfvI2nbbI67M3WsGDfmnijm6kQS+FgTJoz2UOysXA0w=;
        b=RN2C8yBHZGXNECLxrDbJzlcmKuckfy4Uqd0oAivL7Q/j4jh+D4rhKakMoFGmnocELx
         SGLB8A+n454hmA9asZx7MJZq7hJ88c58yaa96C/79D8cmXk0LElOJTVMxa3CnwRzyVy0
         upT3ayGL5E73ZGF/xtz+w86Gm5nubW64wecjR0dMPzlMXe4Y2dHfTnSoRJh/Lxc5/FXv
         5hRPI9PA6YUS1o2jRPv1BAQMnpazyBXIS0joZbSuI0mzyXl7PfH4OFlQuG8fhBjERNBU
         xZbfAYkWft7mmJl2uwOXOakvErGjsijLE3Qge8/A98L4fwYR1e+7D/jR+axBg2NM8JQq
         ybFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OfvI2nbbI67M3WsGDfmnijm6kQS+FgTJoz2UOysXA0w=;
        b=IJGfujI3iLyUkwfc137LR4NtkMyqQKjewvL4m4Add0lU7RlQFMMVWGw/T6yszfXrXl
         ZftkV6dSfDA/Az2rizCl2hgVil6rTS3tSIklmpBeMdCqKK3r+UC5KMErszqv36ImPv2c
         zLFSh/yAmi81UVg4bu/rOBEGX0AOy3MDUNz37iPcttJQNPwrxyro7m2Lgw34gvoJ/ROL
         Yx5OKT5Y8/SXlsF3Uy1XI3gAkWv9jQdbZLoCUsN17+RVu1S8ISOOA68zA3EE8UwXdXjS
         MnuZuutDBliffKQ3Qoa6CfEvUlhOkcDp/CiKXzsJWyXo0FiuPLORdSWzg9GQ+FcDM0vA
         +IGw==
X-Gm-Message-State: AOPr4FUy6gK9d8pMk5qPhZ3icsB4QZ7E02cznnANgxGFCgS1VAiqrJ6BsJ8S5whLChka/A==
X-Received: by 10.98.25.15 with SMTP id 15mr26051310pfz.60.1463169883892;
        Fri, 13 May 2016 13:04:43 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id g77sm29308345pfg.78.2016.05.13.13.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 May 2016 13:04:42 -0700 (PDT)
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1463169737-12701-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294572>

Reimplement the `bisect_voc` shell function in C. This is a too small
function to be called as a subcommand though the working of this
function has been tested by calling it as a subcommand.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
The PR for testing of this function by the subcommand approach can be
found at:
https://github.com/pranitbauva1997/git/pull/5

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 87764fe..455f1cb 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -94,6 +94,16 @@ int bisect_log(void)
 	return 0;
 }
 
+int bisect_voc(const char *term)
+{
+	if (!strcmp(term, "bad"))
+		printf("bad|new\n");
+	if (!strcmp(term, "good"))
+		printf("good|old\n");
+
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
-- 
2.8.2
