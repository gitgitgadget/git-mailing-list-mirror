Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42201C6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 17:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCVRe2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 13:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCVRe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 13:34:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7F521950
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 10:34:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e129-20020a251e87000000b00b56598237f5so20219307ybe.16
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 10:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679506465;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fTB8NQcqq5KV32SdIYWjeq1FWgNHPf9CvIFh4WFAxMk=;
        b=Ol0dfSWPRrx3ivmSER9cZ8K5778XUPZaM9oex7NAyv8JIVKA6lM4rPwR2tEF67fH76
         +2iKsI9WXZ16aGex7ufuGFKDTGtPeW3FsqrIqrrSJcjLs6vMqSvPTxnmUySbH8OjxQ2V
         NllFHg1jehEsRuhbnbxnYIX9wZTWWLw/OSqQBiBUpKavlyOp3fJSEjvu4U4ywsq/ZeyX
         qwlcUHSRVg75OdPEI/Y+xW9j4HGmE9CXGzxwnfPc6W7Ih+/FC8F0fXIpr7FNaX3cgs/0
         Rmd5YKhF2Po7cnVD64V6JdMRgmlTh8HQ+ZJUVReCsIiLbLngzBbTvQ2DepqB/jqYx1Jl
         TPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679506465;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fTB8NQcqq5KV32SdIYWjeq1FWgNHPf9CvIFh4WFAxMk=;
        b=0HKBi3/Pcy6+pHAUByrCWRHj25lnYd3svqQi2NEydlor4pBknzFP5lRvuwb3Lqm0K/
         69pzQVkAFcn+vef0DNZjSXlv5LLqDsD8U8RyS7fGzIyyyBLBOOqRYVhDp/63LKaFG22o
         4b5I0w/CAbhNN80/nf0CmdDW0u3nbkSQuXMYRu+UuicVdgeOw+Azvc0z8Ruyv6Wmi8ZN
         2euFdl68pCW45MMSGQfuJu1C3/rc4T0t+hF5wH9siFvVpeLY4/pIWtO/qmklIIfePXdr
         jJH91MO5JPy2F1ZU0t6PqaOtAHaOWOdXTWdDD/HfQS9rY7Fi8C6mXJZK3w/9c9B4LkdY
         R5AA==
X-Gm-Message-State: AAQBX9c0mrbXIOmR6QfQqF3MI+rtkDB4BLxDBiNalvd+7KPVX0udeIa1
        rgvC1GxRUByZTVYsTr5SiE+/Bsu5rux14Tb8mcGnuktqYuDbMKxUJiB1+wn1ZoSV9QuNO3ziF2k
        NfZtEvmUFSt4QbMx7CBG2/RYZsnTI3g3ch58N8ZYSThgAGdhytTKlIvwuhFRxFQevRw/M1kNcEC
        Sn
X-Google-Smtp-Source: AKy350bCvBQcUFLxBYs2Tkxr59NK4/ZTsm3rNzMy5Y3I4KnmUq2oOn2OpBP6+IIs4ZS9Pvn3yhpilPdmkraY2f/TaVjb
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:7d33:caf6:db87:e779])
 (user=jonathantanmy job=sendgmr) by 2002:a25:aa32:0:b0:b30:d9c:b393 with SMTP
 id s47-20020a25aa32000000b00b300d9cb393mr340787ybi.12.1679506464983; Wed, 22
 Mar 2023 10:34:24 -0700 (PDT)
Date:   Wed, 22 Mar 2023 10:34:21 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230322173421.2243947-1-jonathantanmy@google.com>
Subject: [RFC PATCH] bugreport: also print value of no_proxy envvar
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At $DAYJOB, there was an issue that could have been diagnosed much more
quickly had we known what the $no_proxy environment variable was set
to. Print this value when the user runs "git bugreport". This is useful
not only when a command that explicitly uses the network (e.g. fetch
or clone) is run, but also in a partial clone (in which lazy fetches
may occur).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Taking off the author's hat and putting on the reviewer's hat, I'm
not so sure if this is the right approach, since $no_proxy might have
information that the user doesn't want to share (especially since it
could be used beyond the current repository, and even beyond Git), the
user being informed that they can delete any lines notwithstanding.

Therefore I'm sending this patch as RFC.
---
 builtin/bugreport.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 5bc254be80..c9dd817e70 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -12,6 +12,7 @@ static void get_system_info(struct strbuf *sys_info)
 {
 	struct utsname uname_info;
 	char *shell = NULL;
+	char *no_proxy = NULL;
 
 	/* get git version from native cmd */
 	strbuf_addstr(sys_info, _("git version:\n"));
@@ -39,6 +40,9 @@ static void get_system_info(struct strbuf *sys_info)
 	shell = getenv("SHELL");
 	strbuf_addf(sys_info, "$SHELL (typically, interactive shell): %s\n",
 		    shell ? shell : "<unset>");
+
+	no_proxy = getenv("no_proxy");
+	strbuf_addf(sys_info, "$no_proxy: %s\n", no_proxy ? no_proxy : "<unset>");
 }
 
 static void get_populated_hooks(struct strbuf *hook_info, int nongit)
-- 
2.40.0.348.gf938b09366-goog

