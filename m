From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 36/40] usage: add set_warn_routine()
Date: Mon, 13 Jun 2016 18:09:38 +0200
Message-ID: <20160613160942.1806-37-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Mon Jun 13 18:11:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUSX-0004Qg-Sz
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424974AbcFMQLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:11:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35480 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424915AbcFMQK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:58 -0400
Received: by mail-wm0-f68.google.com with SMTP id k184so16030966wme.2
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4pgygwWjoKO3z8OCw8GIZGaTL5aX7pSxmqsW1fgWkbo=;
        b=KTz4FUXPFM1l0XwufqstXU2Qu7u2zmm59F6CTnsUWSxSvVZSy7/PqrHcXQaptYnC9n
         SC7QARIeWTb9RA3hDnu4swnAnJBbZPLWQFspi4Gzkk3NgxqKsn3sTAt9sGva9wGDIpP1
         2cHghsYHZ/zoG2zf1lkR9cYOaeddebuxqIJk69OwTekG0dXj0W19adlEmPLFu8yQkIT9
         TBWy3tPFGQk18RbQWnwY6/xiA9328VxBV3lISJRSg/I26mw/oTo0NJVFj/di2tMLN9Q5
         mlCptJ1YHOAVyKkNWmCBQC+R51C/VaJdPgH6p5VN3BXpV/iIEOzQCkp3CRMF4KEmdenp
         nN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4pgygwWjoKO3z8OCw8GIZGaTL5aX7pSxmqsW1fgWkbo=;
        b=XJ3afLj/nvmMLD+vJTgKjM0r+zPHEwSZFgG/VYumq5xaaE96QU3b1QOZuk2fM80PNn
         aMhvWdyRDNExETXjhPYVw+kP5Ft6W7l7yBt6514NOfNbKWKzcyiSleJY9LYtzWNmMxrv
         1HgYL5yN/VZ9dvzt5x3J3gdh2+Ouiz+90dIm+tvGXqY8utIb0ti02xZJslMpoUb/1W84
         CqpGcLh+zeRYRSBjiVovxaOjS6Ylw53iTtY2O+9sLAWKosDq+49vdr1Ou9BtJ7gAkXLI
         PokNuDA0+BYpQO/+tiUHVgK7ZXTqfgKR0gWcBClqR7c5axzFqsCyXPfN6HXFNq8ZmFNQ
         6veA==
X-Gm-Message-State: ALyK8tKZTm/38VsfqhlgeeuocOBKa5JgFtoNQaKs7lbdtd5fhx87V+YL/u7dCsXIAbpJTA==
X-Received: by 10.28.184.77 with SMTP id i74mr376285wmf.66.1465834257065;
        Mon, 13 Jun 2016 09:10:57 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:56 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297217>

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
2.9.0.rc2.411.g3e2ca28
