From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 38/44] usage: add set_warn_routine()
Date: Fri, 10 Jun 2016 22:11:12 +0200
Message-ID: <20160610201118.13813-39-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Fri Jun 10 22:13:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSnb-0003vF-0t
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbcFJUMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:12:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33743 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932628AbcFJUMo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id r5so1071441wmr.0
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1aBvKMpXoTyVkAu+wVN/7j/iKqKv3We7wUOSR85cmH8=;
        b=uWbSQzll+XhsPba9M5Zm4YB4bOOwDCzUL/PaL0lwtsvvNtSomKASn1zXxbhVwIwO6d
         +JpXV1LrNjVOYx0y/CHpNMDQX3qNL08sKSC/NctHKUDKmeLU+pf2ckgV1zEigIYX1R9B
         B7Y6CAaojcCrx/M3j1YQtewNvFCe2Ttfo0CpC5h7zi5Yo84zhZi6ZOSIbabOpVD+yaPq
         ox5eHfKSFMdB6vQ8BGM1EP+sNUISxaaDrH0CklsOqAhS+edmBDB49/9D95ArICB3Vy3h
         EJw38c+GSmHSNZ/N+xIQEGXa6GCM1a6nBugO9sSc/+oendCyRo0m9LALCpIcZIcP6j7V
         fhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1aBvKMpXoTyVkAu+wVN/7j/iKqKv3We7wUOSR85cmH8=;
        b=dS3IHpO2uJsMXaRjx3mJyYVhmJQkIQV+LjpE5VMiuwgr0wBwiYP7ciV+mzKxlwZ99m
         0o5L30h6lh0r7ieQBdC335bDDOsCc19vtY40U6lvBUOZH7SwBWzhAgQRFuXFRw73lhQg
         EVXUREkgvGYmLZaJmTPRK9DshQ+HTl6JlLFtkzxEDfbe6hPSyFP3NDSWDSY6yEXzaylE
         3UlzWYPISrYpP6FJCnE1Nsrfzns37lNxzW6wWp90QQP8kLkNmsRWCWdc2LkkN0dx4tRy
         LDv+GAjmAAJU34iWVCJ+W/+WbCLzhAtqDL5yj0MUi/vqzgEYv90DyppArZjO4NdcXjdb
         oG9w==
X-Gm-Message-State: ALyK8tIJQ1o5udlTsKcpS8OINmBYpDK8EV+f1lzYFtKvCEXW10EFpEOaWj38PF8Lvnt1OQ==
X-Received: by 10.194.101.233 with SMTP id fj9mr3676532wjb.54.1465589562871;
        Fri, 10 Jun 2016 13:12:42 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:42 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297047>

There are already set_die_routine() and set_error_routine(),
so let's add set_warn_routine() as this will be needed in a
following commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-compat-util.h | 1 +
 usage.c           | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 49d4029..f78706a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -440,6 +440,7 @@ static inline int const_error(void)
 
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
 extern void set_error_routine(void (*routine)(const char *err, va_list params));
+extern void set_warn_routine(void (*routine)(const char *warn, va_list params));
 extern void set_die_is_recursing_routine(int (*routine)(void));
 extern void set_error_handle(FILE *);
 
diff --git a/usage.c b/usage.c
index 1dad03f..67e5526 100644
--- a/usage.c
+++ b/usage.c
@@ -70,6 +70,11 @@ void set_error_routine(void (*routine)(const char *err, va_list params))
 	error_routine = routine;
 }
 
+void set_warn_routine(void (*routine)(const char *warn, va_list params))
+{
+	warn_routine = routine;
+}
+
 void set_die_is_recursing_routine(int (*routine)(void))
 {
 	die_is_recursing = routine;
-- 
2.9.0.rc2.362.g3cd93d0
