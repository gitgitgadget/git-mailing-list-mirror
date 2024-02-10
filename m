Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E07832C84
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551379; cv=none; b=l04XYR8t7SzA4WBlzyHJO7+ZXxoHy8Z+dVg89bvDw6WxsGxMS0xU0EPFZCgWgWZ2tdImP0Uo8ImZlRq4BjC+lr9VyjhwosBYhrSMHRqxwzVGGYvrw7su7WpOiTENUpKR4ur+rBPDYYYfW6jRJkARJor5bGzOGOL8Zt+U3Nw3WB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551379; c=relaxed/simple;
	bh=UTSQCEaaYgNxc3/nNlgbLBmJiW+dJn6Ylw5Chyx8mEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diqVEQuBztCpHlPrcMR+5WxIhYkICy0nw/DOLt2KaKbN7y4wiTTkTHawpuhjEAaco8xns6ywULx/5ivZoPFs10YoKePPQXy1zkp9HHYx+/vxBEkm4LRk0kG0Ey7CBPgGzQsQxuG/9OEzVDrKMvNfOOOPmK04C3FoVUVWPrwqkjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0Svi/gk; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0Svi/gk"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-21433afcc53so906244fac.3
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 23:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707551375; x=1708156175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRc0j29e+gpK6/q+Wi6Bf2dlMDQWZ1sJGeLZybtIyWc=;
        b=R0Svi/gkvwuPI6MUVtoyk9WGN79m8fBEOUlEQdvg6jIuCvQcFESb9hsFQ9d3PVcIBi
         Ho+++N/ZC2ZsrnlGCGR9oNFJxJtvhWrzzBVV/j9pkdaBzw8ytrhKQfpD7xAv4luPTbtw
         L9Sb0qCA7gmX75CAy2qtLt+FTZy7XVnUzU5hl7mktOL/GIuCxQVmt+y1zn8gAu+C9CNf
         pLdg3+wQIbQ2LFAKktBkSODEBDwgo8ZIHaNPrUclUliZluwRO1+0NMpdZvJESm4swGII
         uI1dp/jb0GGuSX4AHA0zapUYbgdyJd1rNefU3flcSogjXKSsYjK1p+NilwlwbbGY6N8z
         Ds8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707551375; x=1708156175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRc0j29e+gpK6/q+Wi6Bf2dlMDQWZ1sJGeLZybtIyWc=;
        b=axcvMw823d49Mk09J0+vl7n3CFBqQFnIoBMrEOWLjwd5LPIx6b5IQqqodr4SUHmDoL
         4diEFlfE5b+DsNTAxfa/fr5kbRDJGVCtzI6w5T/izxPIusLOTJmKB6WVAWzPBF5YE7Rg
         3SQYCXoQY+2V9KM0Yk1Owfa4ba0bTAgrZqUP9y5ZeKs7OPBkeSAXwBGAe4qbwVxqMIhT
         QjE8okkBWA6x4hHIFOOdtA1vCNXKCvF1QjNwO0Xn1d1XVLG6TltlRPxVOBwU772nWJtq
         Jd8M+LMNLTtzlhMDrGiys7w6d+kQmuStm8EJxNHPtGzHnOTyDl84LjmYuK3K3U4jRlGY
         5zDA==
X-Gm-Message-State: AOJu0Yxl6IjJ8D1Jk+OLU0/Iv1KE7p1BCqK5D0d88+BWlT48EQbAmMUo
	cR/B1C/qDb0i9EXTirfCMBFbUbi+oqTxj2p13LM4boT13kt+fpQQwPF5NxSmSJI=
X-Google-Smtp-Source: AGHT+IHTDbAtEharXj+THY3tUcil/AQDh+jbNnpj42vNpcdRCg/TDKLGeO2NuBpvgPCbQcJ0ZPuAow==
X-Received: by 2002:a05:6870:3325:b0:218:df68:87b2 with SMTP id x37-20020a056870332500b00218df6887b2mr1827366oae.44.1707551375438;
        Fri, 09 Feb 2024 23:49:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqRSm4RrQvDvQvPCtSlPoBINN3Af4HxYwxdLDZ7jp/Xrw2vhdTryYmdgP7E/mD9nwuuwyLPzUDXDkkj/OAwQKGh0w0KmD75c9rzv6MlMEwSuzgAtg4Mft1JQ40Xmnq422VRpWS2gpK+872VKqRlTKgaDRwS6Hs+4ZFySxCiZu/
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id v19-20020a056870955300b00219fd9e3194sm310028oal.7.2024.02.09.23.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 23:49:34 -0800 (PST)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v2 3/8] rebase: update `--empty=ask` to `--empty=drop`
Date: Sat, 10 Feb 2024 01:43:51 -0600
Message-ID: <20240210074859.552497-4-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When git-am(1) got its own `--empty` option in 7c096b8d61 (am: support
--empty=<option> to handle empty patches, 2021-12-09), `stop` was used
instead of `ask`. `stop` is a more accurate term for describing what
really happens, and consistency is good.

Update git-rebase(1) to also use `stop`, while keeping `ask` as a
deprecated synonym. Update the tests to primarily use `stop`, but also
ensure that `ask` is still allowed.

In a future commit, we'll be adding a new `--empty` option for
git-cherry-pick(1) as well, making the consistency even more relevant.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
Reported-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 15 ++++++++-------
 builtin/rebase.c             | 16 ++++++++++------
 t/t3424-rebase-empty.sh      | 21 ++++++++++++++++-----
 3 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 68cdebd2aa..6f64084a95 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -289,23 +289,24 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.
 
---empty=(ask|drop|keep)::
+--empty=(drop|keep|stop)::
 	How to handle commits that are not empty to start and are not
 	clean cherry-picks of any upstream commit, but which become
 	empty after rebasing (because they contain a subset of already
 	upstream changes):
 +
 --
-`ask`;;
-	The rebase will halt when the commit is applied, allowing you to
-	choose whether to drop it, edit files more, or just commit the empty
-	changes. This option is implied when `-i`/`--interactive` is
-	specified.
 `drop`;;
 	The commit will be dropped. This is the default behavior.
 `keep`;;
 	The commit will be kept. This option is implied when `--exec` is
 	specified unless `-i`/`--interactive` is also specified.
+`stop`;;
+`ask`;;
+	The rebase will halt when the commit is applied, allowing you to
+	choose whether to drop it, edit files more, or just commit the empty
+	changes. This option is implied when `-i`/`--interactive` is
+	specified. `ask` is a deprecated synonym of `stop`.
 --
 +
 Note that commits which start empty are kept (unless `--no-keep-empty`
@@ -705,7 +706,7 @@ be dropped automatically with `--no-keep-empty`).
 Similar to the apply backend, by default the merge backend drops
 commits that become empty unless `-i`/`--interactive` is specified (in
 which case it stops and asks the user what to do).  The merge backend
-also has an `--empty=(ask|drop|keep)` option for changing the behavior
+also has an `--empty=(drop|keep|stop)` option for changing the behavior
 of handling commits that become empty.
 
 Directory rename detection
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 4084a6abb8..3b9bb2fa06 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -58,7 +58,7 @@ enum empty_type {
 	EMPTY_UNSPECIFIED = -1,
 	EMPTY_DROP,
 	EMPTY_KEEP,
-	EMPTY_ASK
+	EMPTY_STOP
 };
 
 enum action {
@@ -954,10 +954,14 @@ static enum empty_type parse_empty_value(const char *value)
 		return EMPTY_DROP;
 	else if (!strcasecmp(value, "keep"))
 		return EMPTY_KEEP;
-	else if (!strcasecmp(value, "ask"))
-		return EMPTY_ASK;
+	else if (!strcasecmp(value, "stop"))
+		return EMPTY_STOP;
+	else if (!strcasecmp(value, "ask")) {
+		warning(_("--empty=ask is deprecated; use '--empty=stop' instead."));
+		return EMPTY_STOP;
+	}
 
-	die(_("unrecognized empty type '%s'; valid values are \"drop\", \"keep\", and \"ask\"."), value);
+	die(_("unrecognized empty type '%s'; valid values are \"drop\", \"keep\", and \"stop\"."), value);
 }
 
 static int parse_opt_keep_empty(const struct option *opt, const char *arg,
@@ -1136,7 +1140,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				 "instead of ignoring them"),
 			      1, PARSE_OPT_HIDDEN),
 		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
-		OPT_CALLBACK_F(0, "empty", &options, "(drop|keep|ask)",
+		OPT_CALLBACK_F(0, "empty", &options, "(drop|keep|stop)",
 			       N_("how to handle commits that become empty"),
 			       PARSE_OPT_NONEG, parse_opt_empty),
 		OPT_CALLBACK_F('k', "keep-empty", &options, NULL,
@@ -1553,7 +1557,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (options.empty == EMPTY_UNSPECIFIED) {
 		if (options.flags & REBASE_INTERACTIVE_EXPLICIT)
-			options.empty = EMPTY_ASK;
+			options.empty = EMPTY_STOP;
 		else if (options.exec.nr > 0)
 			options.empty = EMPTY_KEEP;
 		else
diff --git a/t/t3424-rebase-empty.sh b/t/t3424-rebase-empty.sh
index 73ff35ced2..1ee6b00fd5 100755
--- a/t/t3424-rebase-empty.sh
+++ b/t/t3424-rebase-empty.sh
@@ -72,6 +72,17 @@ test_expect_success 'rebase --merge --empty=keep' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rebase --merge --empty=stop' '
+	git checkout -B testing localmods &&
+	test_must_fail git rebase --merge --empty=stop upstream &&
+
+	git rebase --skip &&
+
+	test_write_lines D C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'rebase --merge --empty=ask' '
 	git checkout -B testing localmods &&
 	test_must_fail git rebase --merge --empty=ask upstream &&
@@ -101,9 +112,9 @@ test_expect_success 'rebase --interactive --empty=keep' '
 	test_cmp expect actual
 '
 
-test_expect_success 'rebase --interactive --empty=ask' '
+test_expect_success 'rebase --interactive --empty=stop' '
 	git checkout -B testing localmods &&
-	test_must_fail git rebase --interactive --empty=ask upstream &&
+	test_must_fail git rebase --interactive --empty=stop upstream &&
 
 	git rebase --skip &&
 
@@ -112,7 +123,7 @@ test_expect_success 'rebase --interactive --empty=ask' '
 	test_cmp expect actual
 '
 
-test_expect_success 'rebase --interactive uses default of --empty=ask' '
+test_expect_success 'rebase --interactive uses default of --empty=stop' '
 	git checkout -B testing localmods &&
 	test_must_fail git rebase --interactive upstream &&
 
@@ -194,9 +205,9 @@ test_expect_success 'rebase --exec uses default of --empty=keep' '
 	test_cmp expect actual
 '
 
-test_expect_success 'rebase --exec --empty=ask' '
+test_expect_success 'rebase --exec --empty=stop' '
 	git checkout -B testing localmods &&
-	test_must_fail git rebase --exec "true" --empty=ask upstream &&
+	test_must_fail git rebase --exec "true" --empty=stop upstream &&
 
 	git rebase --skip &&
 
-- 
2.43.0

