Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C4EC433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 09:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238545AbiBJJ3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:29:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238530AbiBJJ25 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 04:28:57 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2362510CB
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:28:59 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id e7-20020a170902ef4700b0014d2b420f1fso1151578plx.17
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=EN32OlSdIPLW/h0ox/yybskI+VjrxA2w7zI+99muzsA=;
        b=sP99KIU6E9j2NUgDojm8tt+ROeXuhZt3qKM2UygduZTczCfQlS/K0iMG9IY2ZIz55F
         LQsqi2jJh1d59BZcD+0dceoJng+HfenSFLGzrfqotuys5GFH9tGh/D2wNhF6k/KNFPgf
         zv07bSj/gfFeu7TMx9T2wfcUSCMxiEf1eusY0vHEcfEBBHsrlUHENQHYk1Y7eX78/TcR
         HjnUEBkreVB25J32DrhPUbN1IeLVWd7xaEU8iy41utQvuJ/nr1HuroFJBHLhy5IpoC7a
         vm8yPhkjGTgvw3krn0dbc9ivm1uTiPhX3qdp6CH2iW6PhxzFS73Nqii4bAQXJ9K8JdH0
         6+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=EN32OlSdIPLW/h0ox/yybskI+VjrxA2w7zI+99muzsA=;
        b=oNmKk4crkr0qs8EJ1BpS9g1FKSCSQazWYoYTdtdRsKWYpu4g26zUlYa5IhPct9oMNB
         t4ylAk60MiXtfpDson/ksqEzcF0FelDFBt5olJ7gX7IcsU+qSSe29kG/0NIZkuPhkBv1
         zIhzGW+fLBkPUjMjc/FgRc8ke7mfqQMZ2L8PF8XPMuV+L+GihdTpSIZaJckZDXFJA9+T
         N3l3DTDylnnpMd6epJcQq5oK3WA4W6tJOD08kvc5ytSuSUJTWXaABwckW/bo8sXVr5EG
         5hKQGaTvyy8h6rox5z0R9xb7ZAfNxK2hw/fhYCp81dd+aQpQOKsKDMdicJRUs6XTMyq6
         ECgA==
X-Gm-Message-State: AOAM531WHntjgg00QE8gk1L+yEltTNrtM4ZzQLaA7BEnVB66Jc7uyfr4
        Pzh9QodA0Kfw5enE/iQGidnJLIui3Yb6Cr1vvm0JbdzQ/vgPuI3AhqDFNn/SQ/xsCWD2L0mfgcX
        9NAs/mlQerfweCevBAyQwQDO/3M/Qv33H81GbhVWRiCvFLr9MA+Bj0rrp0xGch0Y=
X-Google-Smtp-Source: ABdhPJy5JGCOi11QNUYC38pI1obUoVz5yddwa/6oQxBR3X5ZA1DebZcskE18gJeLt1CJ8Y2W4Coxhr40oGJrwg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:dd0f:: with SMTP id
 t15mr5426654pgg.12.1644485338481; Thu, 10 Feb 2022 01:28:58 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:28:18 +0800
In-Reply-To: <20220210092833.55360-1-chooglen@google.com>
Message-Id: <20220210092833.55360-6-chooglen@google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 05/20] builtin/submodule--helper.c: reformat designated initializers
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Atharva Raykar <raykar.ath@gmail.com>

The second hunk here will make a subsequent commit's diff smaller, and
let's do the first and third hunks while we're at it so that we
consistently format all of these.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index db71e6f4ec..9f79bdf4d5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1654,7 +1654,10 @@ struct module_clone_data {
 	unsigned int require_init: 1;
 	int single_branch;
 };
-#define MODULE_CLONE_DATA_INIT { .reference =3D STRING_LIST_INIT_NODUP, .s=
ingle_branch =3D -1 }
+#define MODULE_CLONE_DATA_INIT { \
+	.reference =3D STRING_LIST_INIT_NODUP, \
+	.single_branch =3D -1, \
+}
=20
 struct submodule_alternate_setup {
 	const char *submodule_name;
@@ -2047,7 +2050,9 @@ struct update_data {
 	unsigned int nofetch: 1;
 	unsigned int just_cloned: 1;
 };
-#define UPDATE_DATA_INIT { .update_strategy =3D SUBMODULE_UPDATE_STRATEGY_=
INIT }
+#define UPDATE_DATA_INIT { \
+	.update_strategy =3D SUBMODULE_UPDATE_STRATEGY_INIT, \
+}
=20
 static void next_submodule_warn_missing(struct submodule_update_clone *suc=
,
 		struct strbuf *out, const char *displaypath)
@@ -3013,7 +3018,9 @@ struct add_data {
 	unsigned int progress: 1;
 	unsigned int dissociate: 1;
 };
-#define ADD_DATA_INIT { .depth =3D -1 }
+#define ADD_DATA_INIT { \
+	.depth =3D -1, \
+}
=20
 static void append_fetch_remotes(struct strbuf *msg, const char *git_dir_p=
ath)
 {
--=20
2.33.GIT

