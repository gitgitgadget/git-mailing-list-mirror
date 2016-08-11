Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 016E2203BD
	for <e@80x24.org>; Thu, 11 Aug 2016 18:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbcHKSrJ (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 14:47:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33182 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932339AbcHKSrE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 14:47:04 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so881369wme.0
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 11:47:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O785ToW+AEoQC11WuJmw+Dzp8yQDVrdelmTeEFynaB8=;
        b=eubdL6RiEFTnyTg4yPyuOOF8f3QvLeVXTMvZ6xnhuev60BwbB61y86qGhuSW8vUS6w
         fpIgvtK9/hz6azxs2u9cNibasedqfgGlOWWYaTf3iD427KFBUCyXJN6l7XPsE6493bYH
         eiN6UySooyFkXpp7UQpPeplH0XZXgOHM/xX6It07rFh1j60L/fcfOZmrXxezDIZi2+go
         EMgvkdRt0/rMDJKoCDPw7MxroQmQJ0nQB+PDvJ7DLTftRpYPo9RBZwLIub3xCgrfHo/j
         /Ir1Q5LEPlhSwS+l7bTrIPbryLpq369LJZnYHjaTlZY7hpUxhSJ9YA3aZUfz9/TDyS51
         QkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O785ToW+AEoQC11WuJmw+Dzp8yQDVrdelmTeEFynaB8=;
        b=NgL8RuuVDNEDDiFQiunVL536T99Cp4MBEqsTVT34z2VwM1BTaueV8pD90vGNgJL7P1
         GLaomDZzDmhVlrrEFkagXPYJWBDZTz9lkP5zwhbYCVstaqzKgtA8eSZtjFOylVULwkl2
         mhL1t97Z/eDEfHj9x3DOMg9OKHsT5bUZ0fRN/QNNyna/5PrC6qtAtR2CqCE2ylGxVqdl
         8o1WCy/TP6YjzEVBPl3berNhWaBhpgCbldw7I0xzT3LbtCtX3+CLLE1vQfO9ixrfkFJU
         iQ3h7J6wx3tKXzyBS/shD+4JVNAbtbX+T9JIVl4TlLONYAyqszg5jQLndGLW84gsdeO+
         BgJA==
X-Gm-Message-State: AEkoous2Pjn437dJKtBUX2wa9l4quG6rHpyyYmWuppi0KWMTaE2fm74xNqpdboYqGJnKVg==
X-Received: by 10.194.140.35 with SMTP id rd3mr11068164wjb.88.1470941223574;
        Thu, 11 Aug 2016 11:47:03 -0700 (PDT)
Received: from localhost.localdomain ([80.215.37.180])
        by smtp.gmail.com with ESMTPSA id 190sm1047236wmk.13.2016.08.11.11.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 11:47:02 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v12 09/13] usage: add get_error_routine() and get_warn_routine()
Date:	Thu, 11 Aug 2016 20:44:57 +0200
Message-Id: <20160811184501.384-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.769.gc0f0333
In-Reply-To: <20160811184501.384-1-chriscool@tuxfamily.org>
References: <20160811184501.384-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Let's make it possible to get the current error_routine and warn_routine,
so that we can store them before using set_error_routine() or
set_warn_routine() to use new ones.

This way we will be able put back the original routines, when we are done
with using new ones.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-compat-util.h |  2 ++
 usage.c           | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index c7a51f8..de04df1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -440,7 +440,9 @@ static inline int const_error(void)
 
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
 extern void set_error_routine(void (*routine)(const char *err, va_list params));
+extern void (*get_error_routine(void))(const char *err, va_list params);
 extern void set_warn_routine(void (*routine)(const char *warn, va_list params));
+extern void (*get_warn_routine(void))(const char *warn, va_list params);
 extern void set_die_is_recursing_routine(int (*routine)(void));
 extern void set_error_handle(FILE *);
 
diff --git a/usage.c b/usage.c
index 67e5526..2fd3045 100644
--- a/usage.c
+++ b/usage.c
@@ -70,11 +70,21 @@ void set_error_routine(void (*routine)(const char *err, va_list params))
 	error_routine = routine;
 }
 
+void (*get_error_routine(void))(const char *err, va_list params)
+{
+	return error_routine;
+}
+
 void set_warn_routine(void (*routine)(const char *warn, va_list params))
 {
 	warn_routine = routine;
 }
 
+void (*get_warn_routine(void))(const char *warn, va_list params)
+{
+	return warn_routine;
+}
+
 void set_die_is_recursing_routine(int (*routine)(void))
 {
 	die_is_recursing = routine;
-- 
2.9.2.769.gc0f0333

