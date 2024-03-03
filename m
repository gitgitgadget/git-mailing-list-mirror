Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF8FB641
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709459438; cv=none; b=nLvGuTL106Sz1qsSKpB+8SgRVkrJSrQXgK1/tZyre2RZykZdDCGvOwEePKPJFldrZZgc9ihElxtz7Pa2r5uwCLQEDUZrFFj+WJWW59TZn8iQfEWvj4MtWZIx2tpbEkkbTh+chpf0dgx/OhU1QTFgmGDhAXuNY6jpM4gKaTMWR8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709459438; c=relaxed/simple;
	bh=Z1B8GjNPoA0vne0h4W5wm/jEszmMb21qP3i7HacyxhA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=C1S1QTLz7hFtLANKxb8AUVZaU3iuT4JFQx+6n0AkSUh/ZQEzEmDciYj0+tKcd9cCSlm3XVKfqlzrvN2HeqL1G9iK2Oi8HE7NIyDdOyDJ7QrEa//7qvQvYpDHBh4tgFCvh/4on1rrBjJV2urj2TCSd0TZn26B5iEoDlKrI/Lz2sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZSp825c; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZSp825c"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512e4f4e463so3578579e87.1
        for <git@vger.kernel.org>; Sun, 03 Mar 2024 01:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709459434; x=1710064234; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0h5pwDjhRJ8S2eqjPBxZpOoPvBC/6fjwrpNn8FByS6Q=;
        b=SZSp825cWXpul5MsyPotSL1tZDXlJ/m508Lolo5Ee31qXUavqH5FDSl8wMIn1POrie
         F4s+xWDw6i915pPBeVckS6Y3kSuZ5Lw2eSWWgH+BTvuITQ6vSKedD1szGvfAMLXKDD9+
         zC3jKN2ZfHjvs+uitbsiHRsjSJBz0iNnMOQ1/qATQ0IDUXn5Vx85+NfSNUu2o7/myBeJ
         nePejw3dvDqbrEwU6yiGWfayZvT/urPWepQ9ghLfSRl/jfc1jIbAzJGR0R4gccgfY3Ej
         70Kq/bH4NJIDNA9CAhPi94tij8/i2NF5dMy8+pwFXHy/t7wzJlrUxYvXFPP7vJoocA8m
         2neA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709459434; x=1710064234;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0h5pwDjhRJ8S2eqjPBxZpOoPvBC/6fjwrpNn8FByS6Q=;
        b=iCksHNm23bQ3fG1yO+w9VrLh254m9afTgNrj0ubWSUqcwX+MugenEOKEMySVHrbieK
         dBtigKwy6NI5KSmyAbIGMV2j0fB1wnRWqPJh/IYV7IzKr9iZ+S2bpxUbdb80V4bosIvL
         UYp5Uuve3xFd1aavFzxEsz9D2hIWqkF2wvwMioa7mIPI/70YaXx7g5cof5sstidskWFs
         XtrPJZyMFDE9q9UYm3bK6NfUhVoknHotAvMDL4/TfjKO/VHfbQb0gGkgNsoCRcPm3CqH
         bI9RJ3SRoyTvN8zKqFjji5Feyq5UXFjD0Zvgerf8aoMOAV1A+XstTmAJXAB2N2i9WNaZ
         VVSQ==
X-Gm-Message-State: AOJu0YxUrCP8zaNXfc6S5GnWaOGVvZ7ctyKCjGkqAvzlNm5lS/+RADWf
	SMYjjJp1Cj84GjqyLZpgPNbkKTvpgEKyWtSqVGI4aPPqK0h+8K3P
X-Google-Smtp-Source: AGHT+IGPwIvxX6pCv3oP28MWTdlVBTVDaDwFPGbtKZ6G2UmryCXUz/MG+rOqWhFlqzxcNOmZlGeVyw==
X-Received: by 2002:a05:6512:51a:b0:513:114c:5b3 with SMTP id o26-20020a056512051a00b00513114c05b3mr4187721lfb.21.1709459433890;
        Sun, 03 Mar 2024 01:50:33 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j9-20020a056512028900b005131a3c496esm1286642lfp.241.2024.03.03.01.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 01:50:33 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <avila.jn@gmail.com>, "Kristoffer
 Haugsbakk" <code@khaugsbakk.name>
Subject: [PATCH v2] clean: improve -n and -f implementation and documentation
References: <xmqq34v6gswv.fsf@gitster.g> <875xy76qe1.fsf@osv.gnss.ru>
Date: Sun, 03 Mar 2024 12:50:32 +0300
In-Reply-To: <875xy76qe1.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
	29 Feb 2024 22:07:18 +0300")
Message-ID: <87le6ziqzb.fsf_-_@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

What -n actually does in addition to its documented behavior is
ignoring of configuration variable clean.requireForce, that makes
sense provided -n prevents files removal anyway.

So, first, document this in the manual, and then modify implementation
to make this more explicit in the code.

Improved implementation also stops to share single internal variable
'force' between command-line -f option and configuration variable
clean.requireForce, resulting in more clear logic.

Two error messages with slightly different text depending on if
clean.requireForce was explicitly set or not, are merged into a single
one.

The resulting error message now does not mention -n as well, as it
neither matches intended clean.requireForce usage nor reflects
clarified implementation.

Documentation of clean.requireForce is changed accordingly.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---

Changes since v1:

 * Fixed style of the if() statement

 * Merged two error messages into one

 * clean.requireForce description changed accordingly

 Documentation/config/clean.txt |  4 ++--
 Documentation/git-clean.txt    |  2 ++
 builtin/clean.c                | 23 +++++++++--------------
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/Documentation/config/clean.txt b/Documentation/config/clean.txt
index f05b9403b5ad..b19ca210f39b 100644
--- a/Documentation/config/clean.txt
+++ b/Documentation/config/clean.txt
@@ -1,3 +1,3 @@
 clean.requireForce::
-	A boolean to make git-clean do nothing unless given -f,
-	-i, or -n.  Defaults to true.
+	A boolean to make git-clean refuse to delete files unless -f
+	or -i is given. Defaults to true.
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 69331e3f05a1..662eebb85207 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -49,6 +49,8 @@ OPTIONS
 -n::
 --dry-run::
 	Don't actually remove anything, just show what would be done.
+	Configuration variable clean.requireForce is ignored, as
+	nothing will be deleted anyway.
 
 -q::
 --quiet::
diff --git a/builtin/clean.c b/builtin/clean.c
index d90766cad3a0..41502dcb0dde 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -25,7 +25,7 @@
 #include "help.h"
 #include "prompt.h"
 
-static int force = -1; /* unset */
+static int require_force = -1; /* unset */
 static int interactive;
 static struct string_list del_list = STRING_LIST_INIT_DUP;
 static unsigned int colopts;
@@ -128,7 +128,7 @@ static int git_clean_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "clean.requireforce")) {
-		force = !git_config_bool(var, value);
+		require_force = git_config_bool(var, value);
 		return 0;
 	}
 
@@ -920,7 +920,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 {
 	int i, res;
 	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
-	int ignored_only = 0, config_set = 0, errors = 0, gone = 1;
+	int ignored_only = 0, force = 0, errors = 0, gone = 1;
 	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
 	struct strbuf abs_path = STRBUF_INIT;
 	struct dir_struct dir = DIR_INIT;
@@ -946,22 +946,17 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_clean_config, NULL);
-	if (force < 0)
-		force = 0;
-	else
-		config_set = 1;
 
 	argc = parse_options(argc, argv, prefix, options, builtin_clean_usage,
 			     0);
 
-	if (!interactive && !dry_run && !force) {
-		if (config_set)
-			die(_("clean.requireForce set to true and neither -i, -n, nor -f given; "
-				  "refusing to clean"));
-		else
-			die(_("clean.requireForce defaults to true and neither -i, -n, nor -f given;"
+	/* Dry run won't remove anything, so requiring force makes no sense */
+	if (dry_run)
+		require_force = 0;
+
+	if (require_force != 0 && !force && !interactive)
+		die(_("clean.requireForce is true and neither -f nor -i given:"
 				  " refusing to clean"));
-	}
 
 	if (force > 1)
 		rm_flags = 0;

base-commit: 0f9d4d28b7e6021b7e6db192b7bf47bd3a0d0d1d
-- 
2.25.1

