Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82218202AA
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfBXKLl (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:41 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38301 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbfBXKLc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:32 -0500
Received: by mail-ed1-f66.google.com with SMTP id h58so5218961edb.5
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tYoGZ41nrrzIjpk8aBFFoBwnTV/1q3D+4sVaC1hcBPQ=;
        b=KmoY9Df17QBYketBS3jQw3xwbaq1E/FzbQOyUez8MJbUq3wsv6PwnyxFS2RECUVfBq
         6vgOk+el6ne+HkmWmIRiQU98IwCBuVCSvlOPxx+S2I2La7mEbl7Q01i52TqxOqztf3aj
         1yMrP8fmE37LkHuvQdAaCrqoX3tYBV7Bo79Nk4TqLYfWYrHgz2YfJvd1nid3hRaDDpmZ
         DMZFJWlVuPp5brytgE9/ekdXiUqQQhgS77pP+vqNXWOkwdV+Pa4yiyk9DoQkYSsnxXqX
         YPZr7OxGDKvMXJt9EtcJpvPnL12kA1RnNcj4WFFZJ5MIKo8507tAXSReX6+FVYjyCA99
         RNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tYoGZ41nrrzIjpk8aBFFoBwnTV/1q3D+4sVaC1hcBPQ=;
        b=SW4UZeVXtWKMZ3X6DaDoDPhm5mdk5lgJtosQyNJGtF3ZO1KpjUe80Ki/25eN4IrE5J
         w3IA8TzQ0FlTbmdEkXvbvkpzlws6HAktiZCKDL1KV9thwcn9c7sCIfUNCQ2tFOnC69NQ
         nD3znCEnmwJFpG+kigHEXCgtobQdq4cUP2Kz024bATO8fuMS5nAs0R2Hbvl4DMwquQ5H
         Tvn6q26RmMQ8BFLmAcNTt1CkStTaqE9tJm9mpMdwj1ACVKej7wmcL6skiBQdYzVU/pKm
         qt4lFqPbNafkEfVDW2cnPvUXxOBu52LE9Dz1PHPJf+Kf66h+HD09N+h2PPnziaEmy2db
         43Rw==
X-Gm-Message-State: AHQUAuZ0gffUEo2wbzYTafR3fVW0N/iAR5YGNU6lskD2mLde7LtvhQdL
        Bf4oeCEPzgbxH+v4LF6fzXAybGPg
X-Google-Smtp-Source: AHgI3IZpvz4aBzYuPQpSP5eZ+K7J9rky1MZpziHAe1UrCs7dzIOGoyFO9RiC7HwwBznkouqv4dwmMg==
X-Received: by 2002:a17:906:f05:: with SMTP id z5mr9241772eji.19.1551003090515;
        Sun, 24 Feb 2019 02:11:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x34sm1832138edm.70.2019.02.24.02.11.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:30 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:30 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:11:07 GMT
Message-Id: <56e46dc23679b6301385df6ad63e6a5678019944.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 19/26] bisect--helper: `bisect_log` shell function in C
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Reimplement the `bisect_log()` shell function in C and also add
`--bisect-log` subcommand to `git bisect--helper` to call it from
git-bisect.sh .

Using `--bisect-log` subcommand is a temporary measure to port shell
function to C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired and will be called by some
other method.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c | 22 +++++++++++++++++++++-
 git-bisect.sh            |  7 +------
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index d6308cabd2..0a482d67cf 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -887,6 +887,18 @@ static int bisect_state(struct bisect_terms *terms, const char **argv,
 	return -1;
 }
 
+static int bisect_log(void)
+{
+	int fd, status;
+	fd = open(git_path_bisect_log(), O_RDONLY);
+	if (fd < 0)
+		return -1;
+
+	status = copy_fd(fd, STDOUT_FILENO);
+	close(fd);
+        return status ? -1 : 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -899,7 +911,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
 		BISECT_AUTOSTART,
-		BISECT_STATE
+		BISECT_STATE,
+		BISECT_LOG
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -923,6 +936,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("start the bisection if BISECT_START is empty or missing"), BISECT_AUTOSTART),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
+		OPT_CMDMODE(0, "bisect-log", &cmdmode,
+			 N_("output the contents of BISECT_LOG"), BISECT_LOG),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -995,6 +1010,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_state(&terms, argv, argc);
 		break;
+	case BISECT_LOG:
+		if (argc > 1)
+			return error(_("--bisect-log requires 0 arguments"));
+		res = bisect_log();
+		break;
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 4a5afc7a93..151358aeda 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -167,11 +167,6 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 	done
 }
 
-bisect_log () {
-	test -s "$GIT_DIR/BISECT_LOG" || die "$(gettext "We are not bisecting.")"
-	cat "$GIT_DIR/BISECT_LOG"
-}
-
 get_terms () {
 	if test -s "$GIT_DIR/BISECT_TERMS"
 	then
@@ -209,7 +204,7 @@ case "$#" in
 	replay)
 		bisect_replay "$@" ;;
 	log)
-		bisect_log ;;
+		git bisect--helper --bisect-log ;;
 	run)
 		bisect_run "$@" ;;
 	terms)
-- 
gitgitgadget

