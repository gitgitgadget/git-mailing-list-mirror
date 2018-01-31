Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5F71F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753045AbeAaLI2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:08:28 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46675 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbeAaLI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:08:26 -0500
Received: by mail-pg0-f67.google.com with SMTP id s9so9750572pgq.13
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jkbmwn8eZZfdAcxbhJ+/tL+PHXUtUjzwkfpJzaMrQGA=;
        b=Egupk1s4sAttzq+Tig8MxsmjU5dKaLGiAxHxdhI9cIp2X8kYWRFPcqNbshDbfVlw1R
         CV1CSFH85ccsD0J0U0Dd0BS12e9qRxyEje0GApLyTYsP0UFoHErMOXKuiJDqpo4K5gsA
         Asr2eaA/nZ/qCepyYltUgh9bqirANXulkv+tAYMkS8Tql1ixmi41hnUU3783+Qll/n+W
         BvGauPEBCcbOyPa7Li0/akIGNzYFVZCbr37K+buAu7KGol6ZNY005JehCOhgzJ4sNvYK
         Thcf+erLppM6tPfPz3tgL/Z/J+os41VeNAHTrXR19kSCADqIySSRihRcvfKDVKmX19T7
         czOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jkbmwn8eZZfdAcxbhJ+/tL+PHXUtUjzwkfpJzaMrQGA=;
        b=ez18TOM7GwvWehnn0NGWeDzinurZRYELjSa+6RHmIxfgVvPXHrnatRT5RzCsH+VLtZ
         /kbRoK4dM/cjz/boOG7mSvGMxMisLh71i8gYyVLH0VUqRn37MAB+Xsd7fKm1CYPDweIu
         pDzwQbFsxp5nD9u/M8eclEcd/SQhUWz1z65rOXqdtdERtWFRXFIkMio0EYdvbYIxOiZw
         qMff47boVl+7UwYE0Njy+mB/4+KqASAd+7OmQuafy1OpyY3x9ya9mMk6uACfLHKJp6gY
         GsO6W6ptuAoupV+Lbvear+Go4Phq3YpMpJrvifTRzCMwpWD+J8qeHIpfiCVW9XrE47Yv
         wxzA==
X-Gm-Message-State: AKwxytexBtSiVGpg/WRk0eFVM5zmzJg4jPDHogzYxIC3paAmzODASVIY
        qyzyabdmZW+nXy0R2slCwUeHeA==
X-Google-Smtp-Source: AH8x227DgO9DVYu4oUsSzgKsQTfh5G3BtoxGkTbspYUyCwDMIdUpI2Rem4jSZ3aO74fWzeUxYzqkLw==
X-Received: by 10.98.63.93 with SMTP id m90mr33295895pfa.231.1517396906068;
        Wed, 31 Jan 2018 03:08:26 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id p75sm43266811pfi.148.2018.01.31.03.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:08:25 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:08:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 33/41] remote: force completing --mirror= instead of --mirror
Date:   Wed, 31 Jan 2018 18:05:39 +0700
Message-Id: <20180131110547.20577-34-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git remote --mirror" is a special case. Technically it is possible to
specify --mirror without any argument. But we will get a "dangerous,
deprecated!" warning in that case.

This new parse-opt flag allows --git-completion-helper to always
complete --mirror=, ignoring the dangerous use case.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/remote.c | 2 +-
 parse-options.c  | 2 ++
 parse-options.h  | 6 +++++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d95bf904c3..fce9e5c0f6 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -168,7 +168,7 @@ static int add(int argc, const char **argv)
 		OPT_STRING('m', "master", &master, N_("branch"), N_("master branch")),
 		{ OPTION_CALLBACK, 0, "mirror", &mirror, N_("push|fetch"),
 			N_("set up remote as a mirror to push to or fetch from"),
-			PARSE_OPT_OPTARG, parse_mirror_opt },
+			PARSE_OPT_OPTARG | PARSE_OPT_COMP_ARG, parse_mirror_opt },
 		OPT_END()
 	};
 
diff --git a/parse-options.c b/parse-options.c
index 29f4defdd6..979577ba2c 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -459,6 +459,8 @@ static int show_gitcomp(struct parse_opt_ctx_t *ctx,
 		default:
 			break;
 		}
+		if (opts->flags & PARSE_OPT_COMP_ARG)
+			suffix = "=";
 		printf(" --%s%s", opts->long_name, suffix);
 	}
 	fputc('\n', stdout);
diff --git a/parse-options.h b/parse-options.h
index fa75df17b4..f63151fbda 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -39,7 +39,8 @@ enum parse_opt_option_flags {
 	PARSE_OPT_NODASH = 32,
 	PARSE_OPT_LITERAL_ARGHELP = 64,
 	PARSE_OPT_SHELL_EVAL = 256,
-	PARSE_OPT_NOCOMPLETE = 512
+	PARSE_OPT_NOCOMPLETE = 512,
+	PARSE_OPT_COMP_ARG = 1024
 };
 
 struct option;
@@ -92,6 +93,9 @@ typedef int parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
  *				Useful for options with multiple parameters.
  *   PARSE_OPT_NOCOMPLETE: by default all visible options are completable
  *			   git-completion.bash. This option suppresses that.
+ *   PARSE_OPT_COMP_ARG: this option forces to git-completion.bash to
+ *			 complete an option as --name= not --name even if
+ *			 the option takes optional argument.
  *
  * `callback`::
  *   pointer to the callback to use for OPTION_CALLBACK or
-- 
2.16.1.205.g271f633410

