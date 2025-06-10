Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE08B23506C
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 15:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568929; cv=none; b=shx9N9S98Vh2JzWEZEQgehK4C9mLMQ4mX4GgoXvy5r0QoNjk6oJZq9E6oWD0NU/aajsPYIByr/jXyWwzTPKbZeIFHm1eAAjjS2NWiayUDZDDcPW046Hv0BK0GBOVj0DPj66OvoUMSPV71ZBUF13+1E7YkggowVrMHW2D824BpoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568929; c=relaxed/simple;
	bh=hTlA9qG434hjrg+In4LWH515Cf/s+T/UhcgvcEp7Gmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=htsTIVllmENIQc4u7bckpg4hqESNaM/cuZzHY10CgRkkgUt13Pvt4Lw4cMx25igKDX2jHGkfLALX3HjErOhXE8Wvna1H6q5lVAlG7ptXreScD80Vyz6kH3NPLZ2gy4bnE1Uolg9cn4MprsC1YxJVwYsFMJQ93aM9ZYCkp5A6KXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhSyUoIg; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhSyUoIg"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7382a999970so3532864a34.3
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 08:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749568926; x=1750173726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0BH44qFrf3ZuHJg0ywcF9KqKSDOPK7eVVYoQCLXiDw=;
        b=GhSyUoIg6KdxFwfr63NHABPQOknEZOb70qq0nYZ94EuBzKvxKz6vz5rOAMmNvy+dvy
         hajjRMrg1JqcF6YXVBt3vm4rnwAgWhs3ZhHkRk6SFKD6olL8gavc5Ehz64+JACDuNT9K
         ShQt9VrH/pvphFtQujbzU/sjLRoY3ywCYy78SdGZBpjPXvpdzuk38bfriAuuJkT59hTN
         bDoajrQzdyiow4pZMLlH7FRNiqWUOQdaHJlu0z628s+0eCSq4m0kYkpfA+BUHqBdTaPZ
         09sCCp3jrXtSPt4l8JxoFneTEh/BSUCkVcbUVNtd9QfFA/0Q+Fyo2o688MTEmD2OwwgO
         DyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749568926; x=1750173726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0BH44qFrf3ZuHJg0ywcF9KqKSDOPK7eVVYoQCLXiDw=;
        b=YAYLk+oY9JGoEAY8lk7UdBDB0q2SOndieGjrHbAkgrvXDUm6QXZzfodlGf1Efiloss
         jJXEI6jxXlAQwdnMPWrAAsR2lwqcGpyfgwKmO7qqOPkAvobPmnzaeOURQMj9ACdacb6U
         TOT5PNxTZV8/S8VMP9S8wocqH/R/rE54yQw47WWMNXja2boga/oIrPBGibh3p3JHv7vs
         lSuFNNtphYLU2SlbKLRVoCuFIVP0h0TorzYltwMOsEuPQhO9ZoAKC71BtS9+6PWopf9h
         7BuXVm5uN0+V4ZKb2xaHVfKB4qBZNd88C/LFuo7PpAywGvf2gP7JtlWMBgv8Yg8ELAcU
         ERgw==
X-Gm-Message-State: AOJu0Yzwk/FiTPBAMpzF23jlpjwAa6XhPJnWGuyIxB1zzUddI1Ui8Gur
	BJMISyjGFN/SgZNC40wdWl2iUGZaigp8oNAUnkiFeGKptsRQjxOcwyKQ5Oi+QQ==
X-Gm-Gg: ASbGnctJqh4+fL5UIJhISfkEp1nJ013GVkKhuN5DRE5UWcbu4e8y98lHo+tjrJQW15h
	kUppBdOPJGBxEOdNXFOi1VBlATlK23fqUfwrPxJCBBRQqxZbxT3MzRXkgBRK8PrI74d4BGu6jc4
	q/idJsneFIgQj9JrK5xXcZryRf51lvJggjqO9MyLraXogFC1QAKz9q1PWIwcfePo37Igq3ihO6r
	/GA9hTih+EIoTzHF6cVOnfphFCvsrDozNZlSLuHfbotPj3imakQFRZfyG0HSAzmL+RqooWjL9Tc
	PYmyjEHUHnGFJAoECnIxYHhdUz27tGnmAHZj++mPO9u0cVN2SLdCxXwODWeRcDsVRuzVokiZzIk
	b5sEcYimrMSvlCgclf1IJJSqJeQ==
X-Google-Smtp-Source: AGHT+IEgx6kCMbypExwFlLFEEzichb25rT1ybKTuZ87uUtessc2rm7GNzGxJXYZJjpyGDDnG8u5dFw==
X-Received: by 2002:a05:622a:251a:b0:48d:d1fb:3eee with SMTP id d75a77b69052e-4a5b9a49129mr326611941cf.23.1749568915220;
        Tue, 10 Jun 2025 08:21:55 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:93bc:ecb0:85aa:3d44:2d04])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87eeae4c86bsm1379180241.3.2025.06.10.08.21.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Jun 2025 08:21:54 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH 4/5] repo-info: add field layout.bare
Date: Tue, 10 Jun 2025 12:21:16 -0300
Message-Id: <20250610152117.14826-5-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the field layout.bare to the repo-info command. The data
retrieved in this field is the same that currently is obtained by
running `git rev-parse --is-bare-repository`.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/repo-info.c  | 35 ++++++++++++++++++++++++++++++++++-
 t/t1518-repo-info.sh | 12 ++++++++++--
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/builtin/repo-info.c b/builtin/repo-info.c
index a1c9d3942e..bc25a0809f 100644
--- a/builtin/repo-info.c
+++ b/builtin/repo-info.c
@@ -1,4 +1,7 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "builtin.h"
+#include "environment.h"
 #include "hash.h"
 #include "json-writer.h"
 #include "parse-options.h"
@@ -10,17 +13,22 @@ enum output_format {
 };
 
 enum repo_info_category {
-	CATEGORY_REFERENCES = 1
+	CATEGORY_REFERENCES = 1,
+	CATEGORY_LAYOUT = 1 << 1
 };
 
 enum repo_info_references_field {
 	FIELD_REFERENCES_FORMAT = 1
 };
 
+enum repo_info_layout_field { FIELD_LAYOUT_BARE = 1
+};
+
 struct repo_info_field {
 	enum repo_info_category category;
 	union {
 		enum repo_info_references_field references;
+		enum repo_info_layout_field layout;
 	} field;
 };
 
@@ -33,6 +41,7 @@ struct repo_info {
 
 const char *default_fields[] = {
 	"references.format",
+	"layout.bare"
 };
 
 static void repo_info_init(struct repo_info *repo_info,
@@ -68,6 +77,10 @@ static void repo_info_init(struct repo_info *repo_info,
 			field->category = CATEGORY_REFERENCES;
 			field->field.references = FIELD_REFERENCES_FORMAT;
 		}
+		else if (!strcmp(arg, "layout.bare")) {
+			field->category = CATEGORY_LAYOUT;
+			field->field.layout = FIELD_LAYOUT_BARE;
+		}
 		else {
 			die("invalid field '%s'", arg);
 		}
@@ -92,6 +105,13 @@ static void repo_info_print_plaintext(struct repo_info *repo_info) {
 				break;
 			}
 			break;
+		case CATEGORY_LAYOUT:
+			switch (field->field.layout) {
+			case FIELD_LAYOUT_BARE:
+				puts(is_bare_repository() ? "true" : "false");
+				break;
+			}
+			break;
 		}
 	}
 }
@@ -102,6 +122,7 @@ static void repo_info_print_json(struct repo_info *repo_info)
 	int i;
 	unsigned int categories = 0;
 	unsigned int references_fields = 0;
+	unsigned int layout_fields = 0;
 	struct repository *repo = repo_info->repo;
 
 	for (i = 0; i < repo_info->n_fields; i++) {
@@ -111,6 +132,9 @@ static void repo_info_print_json(struct repo_info *repo_info)
 		case CATEGORY_REFERENCES:
 			references_fields |= field->field.references;
 			break;
+		case CATEGORY_LAYOUT:
+			layout_fields |= field->field.layout;
+			break;
 		}
 	}
 
@@ -127,6 +151,15 @@ static void repo_info_print_json(struct repo_info *repo_info)
 		}
 		jw_end(&jw);
 	}
+
+	if (categories & CATEGORY_LAYOUT) {
+		jw_object_inline_begin_object(&jw, "layout");
+		if (layout_fields & FIELD_LAYOUT_BARE) {
+			jw_object_bool(&jw, "bare",
+				       is_bare_repository());
+		}
+		jw_end(&jw);
+	}
 	jw_end(&jw);
 
 	puts(jw.json.buf);
diff --git a/t/t1518-repo-info.sh b/t/t1518-repo-info.sh
index a99198b0f6..1831b74551 100755
--- a/t/t1518-repo-info.sh
+++ b/t/t1518-repo-info.sh
@@ -6,7 +6,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
-DEFAULT_NUMBER_OF_FIELDS=1
+DEFAULT_NUMBER_OF_FIELDS=2
 
 parse_json () {
 	tr '\n' ' ' | "$PERL_PATH" "$TEST_DIRECTORY/t0019/parse_json.perl"
@@ -22,7 +22,7 @@ test_repo_info () {
 		test_when_finished 'rm -rf repo' &&
 		git init $init_args repo &&
 		cd repo &&
-		echo '$expected_value' >expect &&
+		echo '$expected_value' | sed 's/^false$/0/' | sed 's/^true$/1/' >expect &&
 		git repo-info '$key'| parse_json >output &&
 		grep -F 'row[0].$key' output | cut -d ' ' -f 2 >actual &&
 		test_cmp expect actual
@@ -56,6 +56,14 @@ test_repo_info 'ref format reftable is retrieved correctly' \
 	'--ref-format=reftable' \
 	'references.format' 'reftable'
 
+test_repo_info 'bare repository = false is retrieved correctly' \
+	'' \
+	'layout.bare' 'false'
+
+test_repo_info 'bare repository = true is retrieved correctly' \
+	'--bare' \
+	'layout.bare' 'true'
+
 test_expect_success 'plaintext: output all default fields' "
 	git repo-info --format=plaintext >actual &&
 	test_line_count = $DEFAULT_NUMBER_OF_FIELDS actual
-- 
2.39.5 (Apple Git-154)

