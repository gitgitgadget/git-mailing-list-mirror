Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A7A91F462
	for <e@80x24.org>; Wed, 29 May 2019 09:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfE2JLo (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 05:11:44 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43620 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfE2JLo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 05:11:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id gn7so788799plb.10
        for <git@vger.kernel.org>; Wed, 29 May 2019 02:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C7hX91qz3vqJ6SvsPoUxKHsJMUdb/xZv58Ut8nEe1vU=;
        b=Z+GB+nF4WYxRmr9IZoaszFvuZ/0257ruAly+p9ngB15SY7bqYtxVKBKjcvBhCnynrM
         MrU3VFQMVydQj4PAkNXFWNv09sQe7uYgGRlF+fF4XQSrU6hS63kUDSVeKbw0sJCpd+P7
         b8RzXkR6dyJHdR4wR9sprEw2Jd/9fbyhhbi4CbPMjGyjbJLjUMLNAENh9Qkezg2kRvQ+
         /aLRSH3jmRi08u18ZFDYKnlddexiXcbrjmnucZzpXK+LZzCYeRCwXRGx3LHWNpCFH78t
         9xJMTYd9JItbU0jTV6F/0kHWPv30R0BRfAtHWVf5ED0UYA4uX3MAj2GlnyJ3Og38gb6T
         zPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C7hX91qz3vqJ6SvsPoUxKHsJMUdb/xZv58Ut8nEe1vU=;
        b=VgH6Zw9euTgSdny3PgTDYwO+jUo4poR+tcxR1rT850jFDe94T1hflZ2kE1ChoZzl5i
         b1HoO86q31ODHqsCPwMp738Gac2+xGqk733DRoeyY2LvVCO8ladXtUIIETDUYuNWVWZU
         wJYwxr1O0L92WX3NbAfdaTNUlsNc1k7AHhK8ftsGoHH9i7CxyYjYFxJYhywv1iWLgJ9Y
         MDes5StVns8rRJ27vQGjCBKnOTLj+Y/c9Pvmks7yjT8Xknq/nvehUjSwxfq3Wa+lnxNS
         njtBCZmPWOYdjF950hMvN8yOuYoHSLcPgNmig+JbwK/CoUXfkSmbOTKrrPywCz5/Oi2t
         WgZA==
X-Gm-Message-State: APjAAAUD6CAevrr1MrNBoPn/tZS3R+/138pLcbh+UPEeAUnftZ8NCiNI
        ph3Y9u1Rkwa01cBIJjAXkno=
X-Google-Smtp-Source: APXvYqw/tzRzVelBA8IM3zCvv/jT+PV2WEQoFD/z7+VfPSV14LG/mL4RAbgr0/2HFa2qgfjywKxU2A==
X-Received: by 2002:a17:902:8d96:: with SMTP id v22mr65051145plo.282.1559121103691;
        Wed, 29 May 2019 02:11:43 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id e16sm22497632pfj.77.2019.05.29.02.11.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 02:11:43 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 29 May 2019 16:11:39 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, bturner@atlassian.com, git@vger.kernel.org,
        gitster@pobox.com, tmz@pobox.com
Subject: [PATCH v2 3/3] parse-options: check empty value in OPT_INTEGER and OPT_ABBREV
Date:   Wed, 29 May 2019 16:11:16 +0700
Message-Id: <20190529091116.21898-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190529091116.21898-1-pclouds@gmail.com>
References: <20190524092442.701-1-pclouds@gmail.com>
 <20190529091116.21898-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When parsing the argument for OPT_INTEGER and OPT_ABBREV, we check if we
can parse the entire argument to a number with "if (*s)". There is one
missing check: if "arg" is empty to begin with, we fail to notice.

This could happen with long option by writing like

  git diff --inter-hunk-context= blah blah

Before 16ed6c97cc (diff-parseopt: convert --inter-hunk-context,
2019-03-24), --inter-hunk-context is handled by a custom parser
opt_arg() and does detect this correctly.

This restores the bahvior for --inter-hunk-context and make sure all
other integer options are handled the same (sane) way. For OPT_ABBREV
this is new behavior. But it makes it consistent with the rest.

PS. OPT_MAGNITUDE has similar code but git_parse_ulong() does detect
empty "arg". So it's good to go.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options-cb.c | 3 +++
 parse-options.c    | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index 4b95d04a37..a3de795c58 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -16,6 +16,9 @@ int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
 	if (!arg) {
 		v = unset ? 0 : DEFAULT_ABBREV;
 	} else {
+		if (!*arg)
+			return error(_("option `%s' expects a numerical value"),
+				     opt->long_name);
 		v = strtol(arg, (char **)&arg, 10);
 		if (*arg)
 			return error(_("option `%s' expects a numerical value"),
diff --git a/parse-options.c b/parse-options.c
index 987e27cb91..87b26a1d92 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -195,6 +195,9 @@ static enum parse_opt_result get_value(struct parse_opt_ctx_t *p,
 		}
 		if (get_arg(p, opt, flags, &arg))
 			return -1;
+		if (!*arg)
+			return error(_("%s expects a numerical value"),
+				     optname(opt, flags));
 		*(int *)opt->value = strtol(arg, (char **)&s, 10);
 		if (*s)
 			return error(_("%s expects a numerical value"),
-- 
2.22.0.rc0.322.g2b0371e29a

