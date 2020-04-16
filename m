Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913DBC2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 21:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD96221F4
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 21:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YvINIn2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgDPVSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729283AbgDPVS3 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 17:18:29 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872D6C061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 14:18:29 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id t9so66874plq.10
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 14:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=ryKk4rkw525L/geiZOSEDNqFNXRgcA1LUGZARUviQFU=;
        b=YvINIn2W8dEYBiBxjs9DZM05oRm+5HTP7gvKXkD/ic6YcHECNvUbWhO3OYFcIVd5qu
         xOc6k1I027ksUWHTzN/2q5bubkVLkqPxB4qOmk43TKL+g8i8bMEgRnN1GtTAhYOfc8qJ
         mrP+ttJz055WXONkLnOp+W7BVlWUGV7Q/RLgTjrlryirHrKGVkv/WC3vAvKZEv/J1DbD
         exMx+o0zeJuSCunA+rmO6PYMy+TAZ+y0SmurwQ81vbDGZZhRva1PQH5x4/UaU6x6rxeT
         UGaYCt5o5FaXadUoMmid6bBuMDg3y89jaNNL+uRp8xhPC8pZ9xeiTQcfXyL34Md/PksJ
         MvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=ryKk4rkw525L/geiZOSEDNqFNXRgcA1LUGZARUviQFU=;
        b=blb9c5vqAlRBY+oNX8+alrezDQFurL1vi9Baq8LYNsU6hX6gWeU4kBtueu3/nRpv7y
         Cwt2+wcs9HpSO65hdeewtdpgPZHaD6GPxunYQXZQz4KtUvKsCLCRZri0PcU/BF9eXpfe
         pP/V2V39iFd2mln3MMliBE+wwMTYYv6M/FuJvYMxoXQ8/nvEp45mbkbJwqTX96VsttGk
         lw3vpVYhYuWhsEPyP/ki0TNCE6HEwWYBa+PUl1Fw5whQq7Zs9gfhFayDIjJnl30OiWme
         qf8q6WwMk0SyhR7gmuMS1KMcbv0OKkq5lKGlHwxP3lxxlsASGb5Hqyyuptl3D0QgEliL
         DAmQ==
X-Gm-Message-State: AGi0PuY4xiF6b9z9df8HmqlckIJCfkVv+QmF/CXyKunAVWptrx+ynbIu
        Qf/a0g1XFIihuGQbKFEw7pkUne3iuJrkCR3EK7jK8dVUn9bTDKikXlX0Cke6xsedjiPRL/E7Hii
        6jMLUL9Ym2xLOzWgKh0Snl3jVYYmMHKfOc5FJqIADBYIxqKtZGoqLzFnkNDse/Hza9kbb8TXeLQ
        ==
X-Google-Smtp-Source: APiQypLJE4/YZn0y9Vrf8rDMbdkR3xIY6BoKPdrc4CExpfClN1DrrmlU4jcax4DDIg8mM8uK8+2FT+0dVBPUA1aq5KA=
X-Received: by 2002:a17:90a:284e:: with SMTP id p14mr374837pjf.10.1587071908789;
 Thu, 16 Apr 2020 14:18:28 -0700 (PDT)
Date:   Thu, 16 Apr 2020 14:18:07 -0700
In-Reply-To: <20200416211807.60811-1-emilyshaffer@google.com>
Message-Id: <20200416211807.60811-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200416211807.60811-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v13 5/5] bugreport: add compiler info
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?=" 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To help pinpoint the source of a regression, it is useful to know some
info about the compiler which the user's Git client was built with. By
adding a generic get_compiler_info() in 'compat/' we can choose which
relevant information to share per compiler; to get started, let's
demonstrate the version of glibc if the user built with 'gcc'.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Helped-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail.com=
>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 Documentation/git-bugreport.txt |  1 +
 bugreport.c                     |  6 +++++
 compat/compiler.h               | 41 +++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 compat/compiler.h

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.=
txt
index 17b0d14e8d..643d1b2884 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -27,6 +27,7 @@ The following information is captured automatically:
=20
  - 'git version --build-options'
  - uname sysname, release, version, and machine strings
+ - Compiler-specific info string
=20
 This tool is invoked via the typical Git setup process, which means that i=
n some
 cases, it might not be able to launch - for example, if a relevant config =
file
diff --git a/bugreport.c b/bugreport.c
index 1a3172bcec..089b939a87 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -4,6 +4,7 @@
 #include "strbuf.h"
 #include "time.h"
 #include "help.h"
+#include "compat/compiler.h"
=20
 static void get_system_info(struct strbuf *sys_info)
 {
@@ -25,6 +26,11 @@ static void get_system_info(struct strbuf *sys_info)
 			    uname_info.release,
 			    uname_info.version,
 			    uname_info.machine);
+
+	strbuf_addstr(sys_info, _("compiler info: "));
+	get_compiler_info(sys_info);
+	strbuf_addstr(sys_info, _("libc info: "));
+	get_libc_info(sys_info);
 }
=20
 static const char * const bugreport_usage[] =3D {
diff --git a/compat/compiler.h b/compat/compiler.h
new file mode 100644
index 0000000000..10dbb65937
--- /dev/null
+++ b/compat/compiler.h
@@ -0,0 +1,41 @@
+#ifndef COMPILER_H
+#define COMPILER_H
+
+#include "git-compat-util.h"
+#include "strbuf.h"
+
+#ifdef __GLIBC__
+#include <gnu/libc-version.h>
+#endif
+
+static inline void get_compiler_info(struct strbuf *info)
+{
+	int len =3D info->len;
+#ifdef __clang__
+	strbuf_addf(info, "clang: %s\n", __clang_version__);
+#elif defined(__GNUC__)
+	strbuf_addf(info, "gnuc: %d.%d\n", __GNUC__, __GNUC_MINOR__);
+#endif
+
+#ifdef _MSC_VER
+	strbuf_addf(info, "MSVC version: %02d.%02d.%05d\n",
+		    _MSC_VER / 100, _MSC_VER % 100, _MSC_FULL_VER % 100000);
+#endif
+
+	if (len =3D=3D info->len)
+		strbuf_addstr(info, _("no compiler information available\n"));
+}
+
+static inline void get_libc_info(struct strbuf *info)
+{
+	int len =3D info->len;
+
+#ifdef __GLIBC__
+	strbuf_addf(info, "glibc: %s\n", gnu_get_libc_version());
+#endif
+
+	if (len =3D=3D info->len)
+		strbuf_addstr(info, _("no libc information available\n"));
+}
+
+#endif /* COMPILER_H */
--=20
2.26.1.301.g55bc3eb7cb9-goog

