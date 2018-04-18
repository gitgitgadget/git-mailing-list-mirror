Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58A6D1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 14:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbeDROx4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 10:53:56 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44570 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752326AbeDROxw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 10:53:52 -0400
Received: by mail-lf0-f68.google.com with SMTP id g203-v6so3078845lfg.11
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 07:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=09s9wflIpBvJdpJCLuuaJufvfQrUDaEugLVsbQljrg4=;
        b=sfqU5Et0Gt1GPnRYwtHopOczFuoPpPtobRZi+Ss1DPol/uBTDXCRmV1s+yXgVpxPtf
         QIaN6u0nBUA20MXSdAelJOMJdFPhFT0hr3VKprJkbF9ewTmVJw4xojyFeLLzT4Oe6lRm
         FBBVNHgSJAdZgKJNpfkGIN4KB8PXSn9ffHOtN/Pr4Ht3JTKinNmwccuz2iAZt0iXXPUp
         fOicjDpmkLxFF/5hGKX3mCHiPY/o9Qt8UvSexXD6uoNC1AUV89TNcO3gmpwiqJp0KyOi
         htZtDkL0ggSE/oKJQf0NSGaiyAFIg10TZzhD6iqJBvsfcc+piX/NHcWogiPiRoVjklul
         YqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=09s9wflIpBvJdpJCLuuaJufvfQrUDaEugLVsbQljrg4=;
        b=C14GkKSGmU1Hw9DuOrFGgRIPxZr2fI8tjTJHiXfxHyYee7EecmbK04HzKPVj/pgi03
         yqlW9TUfnQ33XrpP7Ok0gRUf2yZNajUtlwWas7nOnEycZzc6/h6OdSCuYgWc0AxSPwYp
         EQ5BJ+AFBGAFRE2RjWGLtzptf0m+n7LWXkfwcUPQSAB54SPtzxWwwqrjjuU9bR+IhhNA
         ntyMEaUsZpxk3UecJgN73HO8StR40keszqiLDMpCHpDWeZMvRCwRsDCvMcZwrH8CJYZb
         a1OfA9tcZU8TDlgvZ8GFPcPWbkIieZhgPeJLJ5PU347/JFiX3fBqobOw3bpZf/dS1Nba
         6LEg==
X-Gm-Message-State: ALQs6tA35PlFYwWd6SRGHvGJo/tEGXwEMs3kVoWW7x38fvMTA19uO0I4
        Pii6QV5qEJjE/O3hU7pJeUuAbQ==
X-Google-Smtp-Source: AIpwx49ieZXthtAHNvoPTgV6PuWcyrVmSWR7H21mYkWYXdySq4WhMj8y9EeQPlmOFbk/tetnZiLuFg==
X-Received: by 10.46.104.8 with SMTP id c8mr1827138lja.20.1524063230354;
        Wed, 18 Apr 2018 07:53:50 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s25sm234108ljg.43.2018.04.18.07.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Apr 2018 07:53:49 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     pc44800@gmail.com, christian.couder@gmail.com, sbeller@google.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] submodule--helper: don't print null in 'submodule status'
Date:   Wed, 18 Apr 2018 16:53:37 +0200
Message-Id: <20180418145337.7591-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function compute_rev_name() can return NULL sometimes (e.g. right
after 'submodule init'). The current code makes 'submodule status'
print this:

 19d97bf5af05312267c2e874ee6bcf584d9e9681 sha1collisiondetection ((null))

This ugly 'null' adds no value to the user using this command. More
importantly printf() on some platform can't handle NULL as a string
and will crash instead of printing '(null)'.

Check for this and skip printing this part (the alternative is
printing '(n/a)' or something but I think that is just noise).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/submodule--helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a404df3ea4..4dc7d7d29f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -596,8 +596,12 @@ static void print_status(unsigned int flags, char state, const char *path,
 
 	printf("%c%s %s", state, oid_to_hex(oid), displaypath);
 
-	if (state == ' ' || state == '+')
-		printf(" (%s)", compute_rev_name(path, oid_to_hex(oid)));
+	if (state == ' ' || state == '+') {
+		const char *name = compute_rev_name(path, oid_to_hex(oid));
+
+		if (name)
+			printf(" (%s)", name);
+	}
 
 	printf("\n");
 }
-- 
2.17.0.367.g5dd2e386c3

