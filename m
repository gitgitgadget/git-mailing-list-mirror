Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607EC29D28A
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 21:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759095023; cv=none; b=LViDXmtCwjpUutIM18GOSLXVt3ZwCJT5T+xtwPNc9muASTP7YqDdyC+thtCXFdIscCQ+Fo5geScLiB4XV0lcEvJVdqcrz4ZXxGuyHrmQDCDbMSuLWPca/dc7p4EZ5MJ4NCatg11TJqoqV/ncmutxE+cZ47k6WEhvJEKkGEiiALI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759095023; c=relaxed/simple;
	bh=zk6brOS30aHISnBbQKJwgIKZOx062wv3WzO2gCgBPmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMUTM21VyF6Nl6cK6K7IhlJELlxgbg/TmDfWUcb88COM4mCdV4ZLIKsJLRHkLxTo6iXZzKcG6UAQlFQA0SyBTlVHR+ZhkZwoj6I41ZstckcZOc9U037NM1LVudBJ0jcKW8WE8pqh3YZTAVV6mDQaDw2XhwpmZQB6Ku02xKiiapo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8ESM+6H; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8ESM+6H"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d5fb5e34cso53077797b3.0
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 14:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759095018; x=1759699818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVK3UCqtNIE9p+zVw8k0rHn8L8YJx/BVEZIMMX4Q8JE=;
        b=N8ESM+6HjUQ7QdzrKQFzqFCyJYJZoPOuh//sfS3PkWJol60MqmGefwirPAKaaf/XeC
         wr5A7k+wm84yaNm3W0/Ey9vV9Q9tNvEoENLhgHeIYRk2DH/jnO0MKUw7z7GskFhrMNJc
         NGSDZTOBxf9ycVXN2guJJWPYZ50STJ5yfHMXg2Druf56BIXe1w26c2u7ptjFH9/Yzstj
         yt2vJR5vdVfQBPWza1OBj341hZ2HApy3iF34MAShqPhT+8XsYLHPkBeQbSf5sIGO9lvw
         mwVjV8k8dC4FBIaCZuUAKRsHymTtsZakje89OjpzcyQpvDxQO8vaZJLwB7mf2Mi0hi76
         UR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759095018; x=1759699818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WVK3UCqtNIE9p+zVw8k0rHn8L8YJx/BVEZIMMX4Q8JE=;
        b=CTR7yN1ehBgB2BMDUObzWuvaoskVuAimCFi8og7XELqXFwhrIfwiH1wXL72/vPTeRh
         t6/VrA5o1FxiT57YwkeopIyZtmIg3jFt/l6RDoFgDfq/xqbykAZ7wy4LnB4XHAswyp5x
         mzaed8EKCR+sE0sPxCXp688J3fQ2D2pfSOVW7CMK2QC5FkNx+vs7ejzjWbR4O6uCFTTk
         RMqtCUuaJe/v8GmW/qklqPres92/zC8gboAUH3vO5Fwrg6AYqBblAtr47oz7alP36Z8O
         iVzW3rj0RWT6MkXOFkh6fLLEJIDxoTgw1Byay6LqXJPwBBINWnUUg0E43aJG2tQYOOIl
         Aupg==
X-Gm-Message-State: AOJu0YzHDN8+Vuor751tAUQDQgyCPdVUCounr14R/tSbFH0NW4+oLAL1
	BWJ+pGKuqS0HjzVecGfwMLAQaMOK/C3rJTeoUve1nFvExLiydkiogA11ou9LMnkk
X-Gm-Gg: ASbGncsx7d8k1OcY5B//TTOOOnIqugOhSIipg0gBH9UqG5HtWBH5t3ZK2uDNE+kxn8U
	zooxpvaAGzfyoamTvWBNhXP2z6NJq6mZs51ylG6KGLfXWl+aBpOMg4U+xxEzhwA5qKtuqiFHwVL
	EIETGAZH2J/Zspknx11A1SdTI3ezK6zqVjacpbfFgqUtHgbTh0X8layXdBJ6IYvfwM2o8aGenxi
	ZxNDNp92q4g09JFml+madnnyYnju0XzsmsllngIL2mqzvZUoV5deMdHobbFfTZpvmOh1fyNvMnw
	xqpfWoNFfUN2pLvkAF0AuNw9Hm9+i1d/0dZTrjV1cyYw3WPNRRVgScsbK/ZEkVjGbeSTfHy8afp
	T7phpM5C6PcLScR0c01MqgIU+9zmMU6zEproEfyzvmj9eM4QhEXRzcH7W1Kv9mZEkdvyhnac=
X-Google-Smtp-Source: AGHT+IGbfeis+5KMIf8f9gYC88X9rqMM1XWN88g0yyi1sIBWnuwL7N9zASRG2rqqlHOIZfI+wcD91A==
X-Received: by 2002:a05:690c:630e:b0:746:d23:c70 with SMTP id 00721157ae682-765570fd1a7mr149931697b3.19.1759095017934;
        Sun, 28 Sep 2025 14:30:17 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:488:b20c:c605:ba83])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63ad64e5d45sm51448d50.29.2025.09.28.14.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 14:30:17 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Noah Pendleton <noah.pendleton@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Thranur Andul <thranur@gmail.com>,
	Michael Grosser <grosser.michael@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: [PATCH v2 3/3] parseopt: values of pathname type can be prefixed with :(optional)
Date: Sun, 28 Sep 2025 17:29:16 -0400
Message-ID: <5f7057c236c9af3152bd531eed2e4ad0ac35e291.1759094936.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1759094936.git.ben.knoble+github@gmail.com>
References: <20250501214057.371711-1-gitster@pobox.com> <cover.1759094936.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junio C Hamano <gitster@pobox.com>

In the previous step, we introduced an optional filename that can be
given to a configuration variable, and nullify the fact that such a
configuration setting even existed if the named path is missing or
empty.

Let's do the same for command line options that name a pathname.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 Documentation/gitcli.adoc                 | 14 ++++++++++
 parse-options.c                           | 31 +++++++++++++++--------
 t/t7500-commit-template-squash-signoff.sh | 10 ++++++++
 3 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/Documentation/gitcli.adoc b/Documentation/gitcli.adoc
index 1ea681b59d..ef2a0a399d 100644
--- a/Documentation/gitcli.adoc
+++ b/Documentation/gitcli.adoc
@@ -216,6 +216,20 @@ $ git describe --abbrev=10 HEAD  # correct
 $ git describe --abbrev 10 HEAD  # NOT WHAT YOU MEANT
 ----------------------------
 
+
+Magic filename options
+~~~~~~~~~~~~~~~~~~~~~~
+Options that take a filename allow a prefix `:(optional)`. For example:
+
+----------------------------
+git commit -F :(optional)COMMIT_EDITMSG
+# if COMMIT_EDITMSG does not exist, equivalent to
+git commit
+----------------------------
+
+Like with configuration values, if the named file is missing Git behaves as if
+the option was not given at all. See "Values" in linkgit:git-config[1].
+
 NOTES ON FREQUENTLY CONFUSED OPTIONS
 ------------------------------------
 
diff --git a/parse-options.c b/parse-options.c
index 5224203ffe..4faf66023a 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -133,7 +133,6 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 {
 	const char *arg;
 	const int unset = flags & OPT_UNSET;
-	int err;
 
 	if (unset && p->opt)
 		return error(_("%s takes no value"), optname(opt, flags));
@@ -209,21 +208,31 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 	case OPTION_FILENAME:
 	{
 		const char *value;
-
-		FREE_AND_NULL(*(char **)opt->value);
-
-		err = 0;
+		int is_optional;
 
 		if (unset)
 			value = NULL;
 		else if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
-			value = (const char *) opt->defval;
-		else
-			err = get_arg(p, opt, flags, &value);
+			value = (char *)opt->defval;
+		else {
+			int err = get_arg(p, opt, flags, &value);
+			if (err)
+				return err;
+		}
+		if (!value)
+			return 0;
 
-		if (!err)
-			*(char **)opt->value = fix_filename(p->prefix, value);
-		return err;
+		is_optional = skip_prefix(value, ":(optional)", &value);
+		if (!value)
+			is_optional = 0;
+		value = fix_filename(p->prefix, value);
+		if (is_optional && is_empty_or_missing_file(value)) {
+			free((char *)value);
+		} else {
+			FREE_AND_NULL(*(char **)opt->value);
+			*(const char **)opt->value = value;
+		}
+		return 0;
 	}
 	case OPTION_CALLBACK:
 	{
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 366f7f23b3..c065f12baf 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -37,6 +37,16 @@ commit_msg_is ()
 	)
 '
 
+test_expect_success 'nonexistent optional template file on command line' '
+	echo changes >> foo &&
+	git add foo &&
+	(
+		GIT_EDITOR="echo hello >\"\$1\"" &&
+		export GIT_EDITOR &&
+		git commit --template ":(optional)$PWD/notexist"
+	)
+'
+
 test_expect_success 'nonexistent template file in config should return error' '
 	test_config commit.template "$PWD"/notexist &&
 	(
-- 
2.48.1

