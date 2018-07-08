Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D967B1F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 18:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932834AbeGHSbz (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 14:31:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37702 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932383AbeGHSbv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jul 2018 14:31:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id q10-v6so8689624wrd.4
        for <git@vger.kernel.org>; Sun, 08 Jul 2018 11:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CNZ5IEIh4bYws+hxlsMQD62UrTh5NBri7LCubmYhY1I=;
        b=QCY6KLgxXYMqsRgOogxtTa4Ux7golL1pQ5FbzGPKHncsHwXglXeof5wnaoEbOYyvb9
         IiJoa9SGUaB64BkjCv4tF5FAJDqzywO2K1kKeI68d3QeP0VHSIAMW0aIDocyOS/dKzlN
         MLe/YJRezTy6z9pKY3EsUun+uEM0jN9sLMNNaCD1+X6igGLsXcNui9Fzdd56afXAr8CP
         Nkle1pLaX/ByVvsWS3kAUVwLqcUFVFt/lacd45/SnIYizrsct7cguNj3fjXfsTxsn5nh
         0CaQDIlb28aqRnad+NXuFhmmWUOcarBL8uRRtyydJQme+Npb5/bKUc7qMAxfFAIDpGzU
         3Cwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CNZ5IEIh4bYws+hxlsMQD62UrTh5NBri7LCubmYhY1I=;
        b=mnLPYoJtjTZ33Y77oiOPGxvz1iiPIfe32juSEt92Dw9OHYSi5ZNPueRLeL2PmIT9M/
         YV8YNDfO/+ONn9QWsTwcoDQuN9RFCDgJo3VDzL6ru8UZEoPBrE92gUp+HqdsOagYacAK
         7mpZN3FVH8FC2FNFvxH7ig+fZSr4X14s0e40IpShgJQUia/1QXHQ+W4U4NBczXeNUIXg
         rQpkkevYl9orW5j+hRT9XS7h2w/GkYmT8mW2pJjKegowBsYVtsYA+cfmjvUGgexnV8uM
         1VLda8U+xfyHMFrzPS4V++tcEJk9DSk8+rRL/gmbRCqNpoO9znHR995XApW5cYAvrjyU
         J+jQ==
X-Gm-Message-State: AOUpUlGaheIZf401WQigmZuotWag/fWDy8oD+HlD0aMDEWoexHT8Lfre
        K143Wmi1htyuMq5AcH3LTUQF9z5Q
X-Google-Smtp-Source: AAOMgpe8ZfJZChT18QmMJQmxQ4eQJdPllVs9AfgEmUPSHmk5j6LVvoNmU0FDPU4tR0ASzro32BvujA==
X-Received: by 2002:adf:aeea:: with SMTP id y97-v6mr3833731wrc.140.1531074710228;
        Sun, 08 Jul 2018 11:31:50 -0700 (PDT)
Received: from C02WQ21WHTDF.fritz.box (p5DDB5D90.dip0.t-ipconnect.de. [93.219.93.144])
        by smtp.gmail.com with ESMTPSA id c7-v6sm26114917wre.73.2018.07.08.11.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 11:31:49 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Johannes.Schindelin@gmx.de,
        jehan@orb.com, whee@smaertness.net, me@ttaylorr.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1 2/2] convert: add alias support for 'working-tree-encoding' attributes
Date:   Sun,  8 Jul 2018 20:30:36 +0200
Message-Id: <20180708183036.29459-3-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708183036.29459-1-larsxschneider@gmail.com>
References: <20180708183036.29459-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

In 107642fe26 ("convert: add 'working-tree-encoding' attribute",
2018-04-15) we added an attribute which defines the working tree
encoding of a file.

Some platforms might spell the name of a certain encoding differently or
some users might want to use different encodings on different platforms.
Add the Git config "encoding.<iconv-name>.insteadOf = <alias-name>" to
support these use-cases with a user specific mapping. If the alias
matches an existing encoding name, then the alias will take precedence.
The alias is case insensitive.

Example:

	(in .gitattributes)
	*.c	working-tree-encoding=foo

	(in config)
	[encoding "UTF-16"]
		insteadOf = foo

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/gitattributes.txt  | 19 ++++++++++++
 convert.c                        | 50 ++++++++++++++++++++++++++++++++
 t/t0028-working-tree-encoding.sh | 28 ++++++++++++++++++
 3 files changed, 97 insertions(+)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 92010b062e..3628f0e5cf 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -366,6 +366,25 @@ command to guess the encoding:
 file foo.ps1
 ------------------------
 
+The encoding in all examples above was directly defined in the Git
+attributes. In addition, it is possible to define encodings indirectly
+using aliases set via Git config:
+
+------------------------
+[encoding "UTF-16"]
+    insteadOf = my-custom-alias
+------------------------
+
+The alias name can be used in the Git attributes instead of the actual
+encoding name:
+
+------------------------
+*.ps1   text working-tree-encoding=my-custom-alias
+------------------------
+
+This mapping can be useful if equivalent encodings are spelled
+differently across platforms. It can also be useful if a user wants to
+use different encodings on different platforms for the same file.
 
 `ident`
 ^^^^^^^
diff --git a/convert.c b/convert.c
index 949bc783e4..4f19ce1a04 100644
--- a/convert.c
+++ b/convert.c
@@ -997,6 +997,15 @@ static int apply_filter(const char *path, const char *src, size_t len,
 	return 0;
 }
 
+struct alias2enc {
+	struct hashmap_entry ent; /* must be the first member! */
+	const char *alias;
+	const char *encoding;
+};
+
+static int encoding_aliases_initialized;
+static struct hashmap encoding_map;
+
 static int read_convert_config(const char *var, const char *value, void *cb)
 {
 	const char *key, *name;
@@ -1040,6 +1049,36 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 			drv->required = git_config_bool(var, value);
 			return 0;
 		}
+	} else if (
+		parse_config_key(var, "encoding", &name, &namelen, &key) >= 0 &&
+		name &&	!strcmp(key, "insteadof")) {
+		/*
+		 * Encoding aliases are configured using
+		 * "encoding.<iconv-name>.insteadOf = <alias-name>".
+		 */
+		struct alias2enc *entry;
+		if (!value)
+			return config_error_nonbool(key);
+
+		if (!encoding_aliases_initialized) {
+			encoding_aliases_initialized = 1;
+			hashmap_init(&encoding_map, NULL, NULL, 0);
+			entry = NULL;
+		} else {
+			struct alias2enc hashkey;
+			hashmap_entry_init(&hashkey, strihash(value));
+			hashkey.alias = value;
+			entry = hashmap_get(&encoding_map, &hashkey, NULL);
+		}
+
+		if (!entry) {
+			entry = xmalloc(sizeof(*entry));
+			entry->encoding = xstrndup(name, namelen);
+			entry->alias = xstrdup(value);
+
+			hashmap_entry_init(entry, strihash(value));
+			hashmap_add(&encoding_map, entry);
+		}
 	}
 
 	return 0;
@@ -1225,6 +1264,17 @@ static const char *git_path_check_encoding(struct attr_check_item *check)
 		die(_("true/false are no valid working-tree-encodings"));
 	}
 
+	/* Check if an alias was defined for the encoding in the Git config */
+	if (encoding_aliases_initialized) {
+		struct alias2enc hashkey;
+		struct alias2enc *entry;
+		hashmap_entry_init(&hashkey, strihash(value));
+		hashkey.alias = value;
+		entry = hashmap_get(&encoding_map, &hashkey, NULL);
+		if (entry)
+			value = entry->encoding;
+	}
+
 	/* Don't encode to the default encoding */
 	if (same_encoding(value, default_encoding))
 		return NULL;
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 12b8eb963a..d803e00cbe 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -242,4 +242,32 @@ test_expect_success 'check roundtrip encoding' '
 	git reset
 '
 
+test_expect_success 'encoding alias' '
+	test_when_finished "rm -f test.foo16.git test.foo8" &&
+	test_when_finished "git reset --hard HEAD" &&
+
+	test_config encoding.UTF-16.InsteadOf foo16 &&
+
+	text="hallo there!\ncan you read me with an alias?" &&
+	printf "$text" >test.foo8 &&
+	printf "$text" | iconv -f UTF-8 -t UTF-16 >test.foo16 &&
+
+	echo "*.foo16 text working-tree-encoding=fOO16" >.gitattributes &&
+	git add test.foo16 .gitattributes &&
+
+	git cat-file -p :test.foo16 >test.foo16.git &&
+	test_cmp_bin test.foo8 test.foo16.git
+'
+
+test_expect_success 'encoding alias overwrites existing encoding' '
+	test_when_finished "git reset --hard HEAD" &&
+
+	test_config encoding.CONFUSE.insteadOf UTF-16 &&
+
+	echo "*.garbage text working-tree-encoding=UTF-16" >.gitattributes &&
+	printf "garbage" >t.garbage &&
+	test_must_fail git add t.garbage 2>err.out &&
+	test_i18ngrep "failed to encode .* from CONFUSE to UTF-8" err.out
+'
+
 test_done
-- 
2.18.0

