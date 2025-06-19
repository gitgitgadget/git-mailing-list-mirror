Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3F928DF12
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 22:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750373904; cv=none; b=k50rh6p2wuUyMNgQmGeLqEHdcEbLLhLRhHY0eFTtDi/IAq09Fx1bA1CN4Fw3x+5REv5zbV3/H8/3e884mAZ5KkzDKrE9iPM3uxLYH2KC6RBFA6ZVl09xta41zluY7jzVeJkxXL3/fSvMNH6I7TxX3GnXNCYWIf9pmB2PfeFrpC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750373904; c=relaxed/simple;
	bh=gyHZiE3hOHHFTN7mhAsj1OvBytGVBU9NWeJ0MjBE0pQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NzLoupe5G8AgVaTN4qvoUNIYttB8HmC70x5VI5AcHIkWusQwiZFBHlRDqDcfD/Hj0LErym+wRZQfnIfKuQ3NQeyc7HOPBT4eHqrBOLDRSD5lGznd0wCiWYI6DOhvqqfEv2jGEMlKHA7EOLtEEEOEvYwwJXqdIunyFmZvA3GQ/40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcpauTsc; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcpauTsc"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742caef5896so898755b3a.3
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 15:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750373901; x=1750978701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDiTcaCxTh4YIqkgT2yDMeABBUgBS+VTUjVci6erqWM=;
        b=IcpauTsc5/XLFw2NB/KdiFFhXVpHX8K5nVE960Q69DLs/FRvrKRFJBFVe10m2QYXtY
         UUDGJk3TVeDioECNpM8zBAaK9OD3NHXI1RVtIjbVU0j87fTTPmdvsZC/+s5VTjfNedqc
         G1GGRV6oGZWiDXInF0BfEijDr8O+3XCa9HhACHLjZc58ZS7pIjw2QZWK13RajcUZ7+OJ
         M85sEQZ6+WmYZjw8yqUaHFvuV+nxCQPSS0SsVmLEO43eewt2cdCCEZUAVswrRBim4jH7
         y84IPr32JM6nsDbcg6Uwgjayu6p55bz3m3XoqVINP6Zx33gH5HXk709qvpeO8lvDVPFA
         lhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750373901; x=1750978701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDiTcaCxTh4YIqkgT2yDMeABBUgBS+VTUjVci6erqWM=;
        b=aJ8Sfa8b85BcKkoTmUjkXKQw25GXsAs4Iy08yLR/lzU4qMnc4+wd/GHruZKkidtnTS
         qRiP7rV47AkuC8abhEp5ZUB0HyBWQUlt9ilavPDSuMjgxW5C6GCLG0lt8l9UFJPS8I52
         37TZC6hQM2WekgdThmQ0XQX+UylxUBRhkuuY6HtjoZAAZ0mqDPe7BrLtvbO/gBh5tlyu
         CHZRoqaiUUCUZX5tsXZ/jMYmBMgG/uv9nwJy8giXruv8Thq0qZWOVv8GI2fnd5wZVH2p
         kRuT7XBhT4hZI4oDH/SbLhZX8+BAwL7VQo+0sxap0BmImUHT4E78eH7e4LS8MA52bK+u
         Zzig==
X-Gm-Message-State: AOJu0YzaxlVqjG7jhC1rBQj1ctFNLKnXLhXFjsRdwOsckl8v7bUzLH3B
	7M/DjydO0mPHOQsZQVE7cyxfN3yT5ch465u+o8ufzoAWayMwp1Lm/2YdNz/EAQ==
X-Gm-Gg: ASbGncu4Ji4Vg5Pwk6NKTM5J9L0i6ZHUwTTWpz3ztB0pALgcUBUeXvtkyFajlS0ji0T
	02+UfZ7ppS5/HlKKDNHAsPiCPisMRazXSV90wzH6pSe5R5HnpeBsuZIuW4l1pxE8OvQRE7rqJ1p
	FJ7jO0PlmYek2n8+n7+M1x0jPeALT/G00FGCdtKWE5ppWDiNi2+eEtwY6+kG9HRZF3nhOBKop4Q
	Q2mkHaNOcBs+GTgZBPR0mu/1ZAWvI2jpKVjFprBXUxH6L9QLTl8VQj6+mNGMjZtqzPlMiKkWvlL
	HKWWQvMaA1xNGrUnJrk8XKhgI7RN3HTvuL0fvPE0AhyfcGMQFFnKPNniEEMRnEi+VZUW0+t7NC2
	IdAIxRnnzppKitpsAeg==
X-Google-Smtp-Source: AGHT+IEEHG9vhO8joMjAMvZV4PA/Ki+NhVrTml7GKXlxoVJY5pRCYuBLmbmoFjC7/lFEv5HvrXr39g==
X-Received: by 2002:a17:902:ce81:b0:235:c973:ba20 with SMTP id d9443c01a7336-237d99ba95cmr8215935ad.49.1750373901412;
        Thu, 19 Jun 2025 15:58:21 -0700 (PDT)
Received: from localhost.localdomain ([179.100.18.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8695440sm3470515ad.185.2025.06.19.15.58.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Jun 2025 15:58:20 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH v2 7/7] repo-info: add field layout.shallow
Date: Thu, 19 Jun 2025 19:57:51 -0300
Message-Id: <20250619225751.99699-8-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250619225751.99699-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the field layout.shallow to the repo-info command. The data
retrieved in this field is the same that currently is obtained by
running `git rev-parse --is-shallow-repository`.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/repo-info.c  | 21 ++++++++++++++++++++-
 t/t1900-repo-info.sh | 16 +++++++++++++++-
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/builtin/repo-info.c b/builtin/repo-info.c
index 1650d3595c..4c265c05fa 100644
--- a/builtin/repo-info.c
+++ b/builtin/repo-info.c
@@ -7,6 +7,7 @@
 #include "parse-options.h"
 #include "quote.h"
 #include "refs.h"
+#include "shallow.h"
 
 enum output_format {
 	FORMAT_JSON,
@@ -23,7 +24,8 @@ enum repo_info_references_field {
 };
 
 enum repo_info_layout_field {
-	FIELD_LAYOUT_BARE = 1 << 0
+	FIELD_LAYOUT_BARE = 1 << 0,
+	FIELD_LAYOUT_SHALLOW = 1 << 1
 };
 
 struct repo_info_field {
@@ -49,6 +51,10 @@ static struct repo_info_field default_fields[] = {
 	{
 		.category = CATEGORY_LAYOUT,
 		.field.layout = FIELD_LAYOUT_BARE
+	},
+	{
+		.category = CATEGORY_LAYOUT,
+		.field.layout = FIELD_LAYOUT_SHALLOW
 	}
 };
 
@@ -91,6 +97,9 @@ static void repo_info_init(struct repo_info *repo_info,
 			} else if (!strcmp(arg, "layout.bare")) {
 				field->category = CATEGORY_LAYOUT;
 				field->field.layout = FIELD_LAYOUT_BARE;
+			} else if (!strcmp(arg, "layout.shallow")) {
+				field->category = CATEGORY_LAYOUT;
+				field->field.layout = FIELD_LAYOUT_SHALLOW;
 			} else {
 				die("invalid field '%s'", arg);
 			}
@@ -125,6 +134,11 @@ static void repo_info_print_plaintext(struct repo_info *repo_info) {
 						is_bare_repository() ?
 							"true" : "false");
 				break;
+			case FIELD_LAYOUT_SHALLOW:
+				print_key_value("layout.shallow",
+						is_repository_shallow(repo) ?
+							"true" : "false");
+				break;
 			}
 			break;
 		}
@@ -173,6 +187,11 @@ static void repo_info_print_json(struct repo_info *repo_info)
 			jw_object_bool(&jw, "bare",
 				       is_bare_repository());
 		}
+
+		if (layout_fields & FIELD_LAYOUT_SHALLOW) {
+			jw_object_bool(&jw, "shallow",
+				       is_repository_shallow(repo));
+		}
 		jw_end(&jw);
 	}
 	jw_end(&jw);
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 0d1096b40b..5cd2f8d187 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -6,7 +6,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
-DEFAULT_NUMBER_OF_FIELDS=2
+DEFAULT_NUMBER_OF_FIELDS=3
 
 parse_json () {
 	tr '\n' ' ' | "$PERL_PATH" "$TEST_DIRECTORY/t0019/parse_json.perl"
@@ -77,6 +77,20 @@ test_repo_info 'bare repository = false is retrieved correctly' '
 test_repo_info 'bare repository = true is retrieved correctly' '
 	git init --bare repo' 'layout.bare' 'true'
 
+test_repo_info 'shallow repository = false is retrieved correctly' '
+	git init repo' 'layout.shallow' 'false'
+
+test_repo_info 'shallow repository = true is retrieved correctly' '
+	git init remote &&
+	cd remote &&
+	echo x >x &&
+	git add x &&
+	git commit -m x &&
+	cd .. &&
+	git clone --depth 1 "file://$PWD/remote" repo &&
+	rm -rf remote
+	' 'layout.shallow' 'true'
+
 test_expect_success 'plaintext: output all default fields' "
 	git repo-info --format=plaintext >actual &&
 	test_line_count = $DEFAULT_NUMBER_OF_FIELDS actual
-- 
2.39.5 (Apple Git-154)

