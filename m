From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 89/94] usage: add set_warn_routine()
Date: Wed, 11 May 2016 15:17:40 +0200
Message-ID: <20160511131745.2914-90-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:22:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U5P-0005Ji-Mj
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbcEKNVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:21:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34266 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932402AbcEKNVc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:21:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id n129so9425193wmn.1
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WLvx/QFWRma/Cov6eF8aJq2S/013mMui1AxTW8nKWVA=;
        b=rzZBKAMopTAaBoc1n64LgTvo4EwguVwoTNh6Wx2Pjbi9jFoz8wKh9kEET3FfosESw3
         ++V34gdEW+CcT0QeSfG6m7EChBR0Ci4HUpIFlEhymhlidiHuyUZPHIO842EV6HyiSvYC
         vhtQMWW6sNjQkbdFxlbpKB7TEMQOHIukK+21Djuu6pZIDDkJM9pAKt/VPNXscwk4HMhY
         vD477MLapH/E4IqBjvBT87HlZyrOF79naLy0mS+Y8dUPWsxsGjJWg667nyvle0jy4ySB
         RqexK+veUu5T9PbX3EpPoDSwXeooO7cdO5pr7SFt3iYrq7tHUnHfcFtTImA/lUjDHSzx
         HskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WLvx/QFWRma/Cov6eF8aJq2S/013mMui1AxTW8nKWVA=;
        b=TiqpHNGUO9YUZmqFRyA5vbtyHJjirlu7r9evX4bYNekpuhaGuY7B5ez+e/5h8sLg/4
         orD610W+bdrZkeSGSshYNy/0J0AMTi1x0wbdzc6XSzjAQ4maaK7DWV2hAaYh1G4v14YF
         TDWbcYMelXf1KezAMWzeS9TIlLIVi4mxkbSHV4ZpRKn1hUjBiL/FDQfMCGVwjHtuvsKL
         KspAICEfkKbQANCT91HaSg5ZGdJndXcOeMe9GfgIV0e9X/uu1jqKsNwIsSmk8ATgl6VR
         mKgNpaaf7tUV4JZNz7jiQimcyl0SJ6OtCh0bLOMD4Jcwn+R/pJ262mHzTF77Diu0s1Xr
         X+mQ==
X-Gm-Message-State: AOPr4FVkO+1McaAw1wYkikEkhPcF8StVO0l/ZbR7P6azR5SUL0yi1X0PDUAto2AG62n2Yg==
X-Received: by 10.194.162.130 with SMTP id ya2mr3743126wjb.141.1462972891340;
        Wed, 11 May 2016 06:21:31 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:21:30 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294306>

There are already set_die_routine() and set_error_routine(),
so let's add set_warn_routine() as this will be needed in a
following commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-compat-util.h | 1 +
 usage.c           | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 1f8b5f3..987eb99 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -438,6 +438,7 @@ static inline int const_error(void)
 
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
 extern void set_error_routine(void (*routine)(const char *err, va_list params));
+extern void set_warn_routine(void (*routine)(const char *warn, va_list params));
 extern void set_die_is_recursing_routine(int (*routine)(void));
 extern void set_error_handle(FILE *);
 
diff --git a/usage.c b/usage.c
index 82ff131..8fbedb3 100644
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
2.8.2.490.g3dabe57
