Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D453822FF41
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622291; cv=none; b=TeYY7kWnCHChP86bXQGdON09RJRApeyELjwN5PgTN4LIGBqwa+T3+v4rm5pXJ/0e2mFwCxwZAJuD93V6AwLJan98yFDVxoe3zPpSqAzyBlt8tQgXhWw1Z2j/qFREaR5E6pX4BSI3hkJNXBYvjNEVS56c3oe2l6MuewQfcZcWiBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622291; c=relaxed/simple;
	bh=larquBwQ0SyYXseLZG4+xV1xqpObrxz7cx75B5NB5p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSNFcGXQnnoBe9YwHDBR/8LHeZPdj/oujWKqXm5snXFCSCf3ORjdi0o4rj+QW0R7LmUaerl1xsR96m087NUv4OBK+6bLW5Btcgar6gi/B9p3afhZYXgFyWUwwrIB8eGm9O3aijXWIw1eWkHw0uXiKP+sB7Q/zn7owNrcRzvB9Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2y8siM0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2y8siM0"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so37539275e9.1
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 08:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741622287; x=1742227087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ai8gJHBVUz2hoFs3uXh3eIcLrSBG9GBY77l8MfJu904=;
        b=Z2y8siM0GkFKN+bFaKF6yVcf0AV0EgGB42tGGkIWNUgxAbCeO2kfPwc+83LU2oKExO
         r2sa+tmdRell6WbBX1lDo2qf3Wr2Xb5LnHOA1ai4T21a7aAeOcTyUol2oyUvr2E7IQbp
         iPjzKu0sHM23axk56mReOpm21nbcAMZKj8p5FLtBatSTspx4+FKjXAhXo4tiH1ctaYvV
         ZhCUvRbFlP3mH34P21fQaO8O4d9Zh1YFaBySjXdTieLVcel2JACnMa2OTHEe/GtdqZ7y
         iSPabJgTTa9oOQQ833ATget4YrayaDImyqrfTUPbyEyo9ZrLor8BC/cuFTkw0G5q5lXh
         cX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741622287; x=1742227087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ai8gJHBVUz2hoFs3uXh3eIcLrSBG9GBY77l8MfJu904=;
        b=rIS5behvnNV5UNaYu0iJ4YRG0wjIQ4hZQoM4URDS3GYWjUvhjZ4I5DOxLcnpD5TrbM
         Gn0ErzTHKw+FcFQ6PP7yPd8t+rf2ni6FMNz9199ZcbgpgB6F8B0/U5nY71qPM74bszwn
         ttyK3O80Q7jCvaK2bOP9LvXY24U2ehYTRD08NDmSaI+9/9pVSuHBg+mREALLfo5K4S99
         ajPJOAqY9WTsgb+xtUb3cWmIhtqMxR6OKfuvBmxeQIdX4WsMFpjAdp+XxKXg01a45uMy
         M36i1mUHQCkfVYtmHr9Hr6wAb9NfJ0CbmW6BgYKpwj0z4QzdqhLN5VeRatlK36oIDvyv
         cYiA==
X-Gm-Message-State: AOJu0YzpNKnxeXJ6+eqGaqMx4zBErrI9UnneCJDOq6zaDRIx1m88uRYR
	BYM+aT79Wp4AwETL9hd4d5XePJz89hUjsLsw6hwmqqa3JBiD1XitV8YXLw==
X-Gm-Gg: ASbGncsyrG1/MF/cmarYirHZLuOP8cGMXXP7JnXzV+BypiBAxIQYT0QTatkKiGZBrO0
	cPfi85MrrbnjLWnsjP6qfhd++lT8BFs18UxWcrbEkUDhnXttKGvnEmyBt5K9LXXaAAELuAhl5xk
	Zh71qzdFVkLKCbn9jvpkwwV/5ZWumAnsx8LfliCpaAvjHzhqpiMdCGfluyUCwYd+kvshJIQOly7
	qXdwlY/S6zpPGUXRwHujS4FKchR4PQRQnqgEy+X0i217S/XCSI5SkS6jhJzy3VOnrvaB/Nn4dRO
	7eOw91JHD+BAoV2NorIxApcNYgL5F1Sa9RC/Kn9vqz/z8qLiCDbSJ2i1WxN6nZTWRN/fElWqh7u
	bamY3nOvjUptXTay39nbKslgnDnc=
X-Google-Smtp-Source: AGHT+IH7SGoTYMGlH52pQgbmzUS2RB5b0LyUX1YhpLCwl5cCaopIIIx7bEz4QZS8mnAqNLM1op5Bng==
X-Received: by 2002:a5d:6dac:0:b0:38d:d0ca:fbad with SMTP id ffacd0b85a97d-392641bd284mr85708f8f.14.1741622286802;
        Mon, 10 Mar 2025 08:58:06 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e4065sm15551831f8f.62.2025.03.10.08.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:58:04 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Luke Shumaker <lukeshu@lukeshu.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Luke Shumaker <lukeshu@datawire.io>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 3/6] fast-export: rename --signed-tags='warn' to 'warn-verbatim'
Date: Mon, 10 Mar 2025 16:57:43 +0100
Message-ID: <20250310155746.879481-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.89.g148d1db992
In-Reply-To: <20250310155746.879481-1-christian.couder@gmail.com>
References: <20250224142744.279643-1-christian.couder@gmail.com>
 <20250310155746.879481-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luke Shumaker <lukeshu@datawire.io>

The --signed-tags= option takes one of five arguments specifying how to
handle signed tags during export.  Among these arguments, 'strip' is to
'warn-strip' as 'verbatim' is to 'warn' (the unmentioned argument is
'abort', which stops the fast-export process entirely).  That is,
signatures are either stripped or copied verbatim while exporting, with
or without a warning.

Match the pattern and rename 'warn' to 'warn-verbatim' to make it clear
that it instructs fast-export to copy signatures verbatim.

To maintain backwards compatibility, 'warn' is still recognized as
deprecated synonym of 'warn-verbatim'.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-fast-export.adoc |  6 +++---
 builtin/fast-export.c              |  8 ++++----
 t/t9350-fast-export.sh             | 18 ++++++++++++++++++
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-fast-export.adoc b/Documentation/git-fast-export.adoc
index 752e4b9b01..ab9a315fa9 100644
--- a/Documentation/git-fast-export.adoc
+++ b/Documentation/git-fast-export.adoc
@@ -27,7 +27,7 @@ OPTIONS
 	Insert 'progress' statements every <n> objects, to be shown by
 	'git fast-import' during import.
 
---signed-tags=(verbatim|warn|warn-strip|strip|abort)::
+--signed-tags=(verbatim|warn-verbatim|warn-strip|strip|abort)::
 	Specify how to handle signed tags.  Since any transformation
 	after the export can change the tag names (which can also happen
 	when excluding revisions) the signatures will not match.
@@ -36,8 +36,8 @@ When asking to 'abort' (which is the default), this program will die
 when encountering a signed tag.  With 'strip', the tags will silently
 be made unsigned, with 'warn-strip' they will be made unsigned but a
 warning will be displayed, with 'verbatim', they will be silently
-exported and with 'warn', they will be exported, but you will see a
-warning.
+exported and with 'warn-verbatim' (or 'warn', a deprecated synonym),
+they will be exported, but you will see a warning.
 
 --tag-of-filtered-object=(abort|drop|rewrite)::
 	Specify how to handle tags whose tagged object is filtered out.
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 2bf787191a..2de2adc30e 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -36,7 +36,7 @@ static const char *fast_export_usage[] = {
 };
 
 static int progress;
-static enum signed_tag_mode { SIGNED_TAG_ABORT, VERBATIM, WARN, WARN_STRIP, STRIP } signed_tag_mode = SIGNED_TAG_ABORT;
+static enum signed_tag_mode { SIGNED_TAG_ABORT, VERBATIM, WARN_VERBATIM, WARN_STRIP, STRIP } signed_tag_mode = SIGNED_TAG_ABORT;
 static enum tag_of_filtered_mode { TAG_FILTERING_ABORT, DROP, REWRITE } tag_of_filtered_mode = TAG_FILTERING_ABORT;
 static enum reencode_mode { REENCODE_ABORT, REENCODE_YES, REENCODE_NO } reencode_mode = REENCODE_ABORT;
 static int fake_missing_tagger;
@@ -62,8 +62,8 @@ static int parse_opt_signed_tag_mode(const struct option *opt,
 		*val = SIGNED_TAG_ABORT;
 	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
 		*val = VERBATIM;
-	else if (!strcmp(arg, "warn"))
-		*val = WARN;
+	else if (!strcmp(arg, "warn-verbatim") || !strcmp(arg, "warn"))
+		*val = WARN_VERBATIM;
 	else if (!strcmp(arg, "warn-strip"))
 		*val = WARN_STRIP;
 	else if (!strcmp(arg, "strip"))
@@ -833,7 +833,7 @@ static void handle_tag(const char *name, struct tag *tag)
 				die("encountered signed tag %s; use "
 				    "--signed-tags=<mode> to handle it",
 				    oid_to_hex(&tag->object.oid));
-			case WARN:
+			case WARN_VERBATIM:
 				warning("exporting signed tag %s",
 					oid_to_hex(&tag->object.oid));
 				/* fallthru */
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 40427883ec..cc110727fb 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -253,6 +253,24 @@ test_expect_success 'signed-tags=verbatim' '
 
 '
 
+test_expect_success 'signed-tags=warn-verbatim' '
+
+	git fast-export --signed-tags=warn-verbatim sign-your-name >output 2>err &&
+	grep PGP output &&
+	test -s err
+
+'
+
+# 'warn' is a backward-compatibility alias for 'warn-verbatim'; test
+# that it keeps working.
+test_expect_success 'signed-tags=warn' '
+
+	git fast-export --signed-tags=warn sign-your-name >output 2>err &&
+	grep PGP output &&
+	test -s err
+
+'
+
 test_expect_success 'signed-tags=strip' '
 
 	git fast-export --signed-tags=strip sign-your-name > output &&
-- 
2.49.0.rc1.89.g148d1db992

