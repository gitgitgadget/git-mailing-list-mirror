Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 339721F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753490AbeAaLGe (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:06:34 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44474 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752373AbeAaLGd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:06:33 -0500
Received: by mail-pf0-f193.google.com with SMTP id 17so10797516pfw.11
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bokUUZqOZ0qOFZRzgJTGrWIjEWq9gOTInnbQebGoS+s=;
        b=IEnRPzkXNDwbAHpyu8u3z9mMK/uoHWSRAjA3rMGbJrcRnvIcesAJG/fLwQp4S3svT8
         hy8N2y63GjVXdCxGAVLVfUHK3Qb79CT0Vx531TxaTV7YhyYY6w7kYcrp11FVGKa+OrEq
         h6rYUrV/8x0reUQEW50fg/PbldRRMpWJEB7ZWwKWUgVmBpi0UNmOigkk2n8PLqn3hRCv
         OHIE5au7NG0ZVUgDmGsw4qjFgAFoFmgwwirGlP7wcTbE76HzZyQ2f8Y5+hJx8x51hdOx
         zxYMs3UiIoM9rjK/3Zb9BBIoh2XueRjvOnOkMgGTRcNnMHCZhcZ0yWZ/8vTIKnpY+j+e
         KvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bokUUZqOZ0qOFZRzgJTGrWIjEWq9gOTInnbQebGoS+s=;
        b=O+zo15SGI6byrFHuhAfbGgO83Tdbd/4r8k/iWK0/nZUdYIEGuNylNj4B28bXAljdBQ
         L8RY0k48QHRg/QbBz5HwdOp0nJOkNxZEJ97DBYcRENkp5VvGgjVD9LzE1l5BwQsVWvuQ
         qC3hKm3rTfIt4A6d5ZSxQAUoCWi+TqMnbSJZU+xCCGPtI7GuxBJfsXEQ8frzwGgPbHbn
         jAsMVnTBgHMxNuLXIVqa0YckHEBn9Q404PHkgyR1mof9EnTFbiBJTFWwdKuEP8wShszB
         2YNpRVov0FJOCg0Y78t1nwxuUZ2AtqA27vIiUuZT3Z/wmlN04bbP8LB+7FSlWyln/Ebr
         utsg==
X-Gm-Message-State: AKwxytdB/uneWRy81N5U5/YJCnSiXBaTJgk0/N+j4bbrRnNkSRWXA2tT
        Z6HWhGEN+PIO6RpzpIhqET8teg==
X-Google-Smtp-Source: AH8x224R5j4GV8svZbQ4gql31Y4RjSVvLMDRg8/sndgBA0LlxhhbcawvFyPiRGt13bp35Mq7hZ3lOg==
X-Received: by 10.98.231.11 with SMTP id s11mr33303753pfh.174.1517396792711;
        Wed, 31 Jan 2018 03:06:32 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id 184sm39920007pfd.156.2018.01.31.03.06.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:06:32 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:06:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 07/41] completion: use __gitcomp_builtin in _git_apply
Date:   Wed, 31 Jan 2018 18:05:13 +0700
Message-Id: <20180131110547.20577-8-pclouds@gmail.com>
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

The new completable options are:

--3way
--allow-overlap
--build-fake-ancestor=
--directory
--exclude
--include

--index-info is no longer completable but that's because it's renamed to
--build-fake-ancestor in 26b2800768 (apply: get rid of --index-info in
favor of --build-fake-ancestor - 2007-09-17)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 apply.c                                | 5 +++--
 contrib/completion/git-completion.bash | 9 +--------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/apply.c b/apply.c
index 321a9fa68d..65eb37e6a4 100644
--- a/apply.c
+++ b/apply.c
@@ -4943,8 +4943,9 @@ int apply_parse_options(int argc, const char **argv,
 			N_("make sure the patch is applicable to the current index")),
 		OPT_BOOL(0, "cached", &state->cached,
 			N_("apply a patch without touching the working tree")),
-		OPT_BOOL(0, "unsafe-paths", &state->unsafe_paths,
-			N_("accept a patch that touches outside the working area")),
+		OPT_BOOL_F(0, "unsafe-paths", &state->unsafe_paths,
+			   N_("accept a patch that touches outside the working area"),
+			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "apply", force_apply,
 			N_("also apply the patch (use with --stat/--summary/--check)")),
 		OPT_BOOL('3', "3way", &state->threeway,
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ce53b78c81..6f763c524e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1123,14 +1123,7 @@ _git_apply ()
 		return
 		;;
 	--*)
-		__gitcomp "
-			--stat --numstat --summary --check --index
-			--cached --index-info --reverse --reject --unidiff-zero
-			--apply --no-add --exclude=
-			--ignore-whitespace --ignore-space-change
-			--whitespace= --inaccurate-eof --verbose
-			--recount --directory=
-			"
+		__gitcomp_builtin apply
 		return
 	esac
 }
-- 
2.16.1.205.g271f633410

