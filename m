Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39F729290A
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 23:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751844020; cv=none; b=l/qWA9zJVZgpI+P++ZUif6efffPAHP94buQ51Po8EQlNJPy3VMait6x/Yzxi09iJ9bEB4pmkXxA/weJjPuBb2v1In5zFBuAKK1jh+DweyDAmuF9xboWxuJE347DvXYOUBGR5DOcjZ0pZ1g+lFM/2faDrGdj1UTl7XrfgPJlnOAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751844020; c=relaxed/simple;
	bh=nJld4Afrx304FTVXqVBDGtGIJLxAhn9jYUOr6DbFCmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hJd7pIx+SO8zkCrOUlwAp68RdeY+lQBym0F7JwW0Gt08VmxZ60ugcKjajj6T7cEQjJGYGPuO7Aw3piu84b9yq4UOMSYHXyGwIagl1gtw6qIslo/eZvcqK74IEX6bdKbG5Kz5IPO6lgKxGDao7JYpNBU8Prfr0BJtJpGpI/X2xD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCKOTO8v; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCKOTO8v"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fadd3ad18eso28779886d6.2
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 16:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751844017; x=1752448817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dOacmHPHUr0DWBYdjc6SSSSDkm3BCBhf3S9xb8vV+A=;
        b=UCKOTO8vs0x6Ar98CdZF8OI4AmZe6HTS+hhwOMKu2HVn9GtPkycmVP952q3CvSAEh9
         cOFoQdUl2UywvQIs8CdIfhOQ+UPRuyG8xQOqGKDWu2NAdd9Yoh/xzCXlyOHSoVPSl69u
         DFgvMfo5LVzFe1aS0mzoObYFv4voK2s+NSruLqWeQFlBvgyaoXiVlZX0kl2bQr8vN5At
         dAqbYD/IZH9IWWoc2Xnq+M/3rujVUaX/4dI881iifZJKAoQkwxhCB2LEtoMyNjcQHYKA
         kGzSdr8SIIOF0cIL+9fKcnY6NY8624i3eFKVnDwnPMwBbSadHKYPmXvi6nOJLgP9BafX
         lAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751844017; x=1752448817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dOacmHPHUr0DWBYdjc6SSSSDkm3BCBhf3S9xb8vV+A=;
        b=YVSJaxJfhg8A5AEG1aOg9MM1sztyduqLQmlrV/0AwsLe7DCPy6Ika/s01aZgL4HiVp
         +wCKH59K5snx5BChyFtleLYbQGi5BL4VgZbOhMxCCl0ULm9ouhppiYT7JLVaji42rEjs
         HyITM8BR180jEmmhanQFxSIl6aQ7GZ0u4nkKXCfHgyMRxzn04BRVWb0hktstqbe4bfXR
         QMmKUcIrRooUxZp9V/NB34JZtpo4LF5nbqYeaoNX3gdWjS8rmrzQk+o+07PQzAAzPDnA
         vvNppVnQwc2p52g84iUSMR7qQXjP20IDZVKUIXkE1Rn2BWuZAEbHIUIHqhAG+L8V0lzu
         f9UQ==
X-Gm-Message-State: AOJu0Yz4SgI3/90GvgcDLkfvnkLt4Qv8j2b2QLx7IzFtiVktWOnyShIQ
	JOejGf96Vms96qvu2bcG4VSH/2A1L0r7GFPwolr9OZ6BJLt5eJeRKIrd1TE2gA==
X-Gm-Gg: ASbGncvFrD0KmwR/8uYXwLw6l4NBE4oSb1rxu3ElUSmNwguNggSryNyMSJL2cqWACrZ
	wj6l7N8tfTdSTVf8/3HIr3AoJvpxC15jZQtCkcuawLoac7OPWcNK5/WrBJxmu4FLUJK8fr8wazB
	vvkLRDs1TninKSd2gS6Kaj4WdJy9QJYynWqnQ6KhAxxd5WMJe7zj5mIzpFDtu25MYKFPnF6swiR
	K6a7FoC8fmcXd1tFlRxm7P52I2TGu37tBAhpsv/XrimQNRvoboAuNHEggXhVQrpu28PGWjdbz0/
	7Gi6AvBVmMksvMXbAc2NnzCp5nB6+mHp6V+gw/OsLNIVvVG52RSsH9zbJM0QGKXn96x0uu+sc/9
	PoeRFa+snPjJrh8PRKM1tD5+ECg==
X-Google-Smtp-Source: AGHT+IHg/ZTWzaMo5nfWHPcuWNw3rk1DyzJqUOaNcaXj3MYlaTIeEzUUf6Lh983Qbpslsn5U5Q4FCg==
X-Received: by 2002:a05:6214:19ca:b0:6fb:474:42b4 with SMTP id 6a1803df08f44-702d15320eamr101037896d6.18.1751844017402;
        Sun, 06 Jul 2025 16:20:17 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:934a:8cb5:107d:e42b:6887])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d50947sm49891716d6.78.2025.07.06.16.20.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 06 Jul 2025 16:20:17 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH v3 4/5] repo-info: add field layout.bare
Date: Sun,  6 Jul 2025 20:19:37 -0300
Message-Id: <20250706231938.16113-5-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250706231938.16113-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250706231938.16113-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit is part of the series that introduces the new command
git-repo-info.

The flag --is-bare-repository from git-rev-parse is used for retrieving
whether the current repository is bare . This way, it is used for
querying repository information, fitting in the purpose of
git-repo-info.

Then, add a new field layout.bare to the git-repo-info command
containing that information.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo-info.adoc |  4 ++++
 builtin/repo-info.c              | 37 ++++++++++++++++++++++++++++++++
 t/t1900-repo-info.sh             |  6 ++++++
 3 files changed, 47 insertions(+)

diff --git a/Documentation/git-repo-info.adoc b/Documentation/git-repo-info.adoc
index dd221b236e..67d19406ad 100644
--- a/Documentation/git-repo-info.adoc
+++ b/Documentation/git-repo-info.adoc
@@ -70,6 +70,10 @@ categories. Each category is composed by one or more fields.
 Reference-related data:
 * `format`: the reference storage format, either `files` or `reftable`.
 
+`layout`::
+Information about the how the current repository is represented:
+* `bare`: `true` if this is a bare repository, otherwise `false`.
+
 SEE ALSO
 --------
 linkgit:git-rev-parse[1]
diff --git a/builtin/repo-info.c b/builtin/repo-info.c
index 98a0d83d51..7e29ae8519 100644
--- a/builtin/repo-info.c
+++ b/builtin/repo-info.c
@@ -1,4 +1,8 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "builtin.h"
+#include "environment.h"
+#include "hash.h"
 #include "json-writer.h"
 #include "parse-options.h"
 #include "refs.h"
@@ -10,16 +14,22 @@ enum output_format {
 
 enum repo_info_category {
 	CATEGORY_REFERENCES = 1 << 0,
+	CATEGORY_LAYOUT = 1 << 1,
 };
 
 enum repo_info_references_field {
 	FIELD_REFERENCES_FORMAT = 1 << 0,
 };
 
+enum repo_info_layout_field {
+	FIELD_LAYOUT_BARE = 1 << 0,
+};
+
 struct repo_info_field {
 	enum repo_info_category category;
 	union {
 		enum repo_info_references_field references;
+		enum repo_info_layout_field layout;
 	} u;
 };
 
@@ -53,6 +63,9 @@ static void repo_info_init(struct repo_info *repo_info,
 		if (!strcmp(arg, "references.format")) {
 			field->category = CATEGORY_REFERENCES;
 			field->u.references = FIELD_REFERENCES_FORMAT;
+		} else if (!strcmp(arg, "layout.bare")) {
+			field->category = CATEGORY_LAYOUT;
+			field->u.layout = FIELD_LAYOUT_BARE;
 		} else {
 			die("invalid field '%s'", arg);
 		}
@@ -81,6 +94,17 @@ static void append_null_terminated_field(struct strbuf *buf,
 			break;
 		}
 		break;
+
+	case CATEGORY_LAYOUT:
+		strbuf_addstr(buf, "layout.");
+		switch (field->u.layout) {
+		case FIELD_LAYOUT_BARE:
+			strbuf_addstr(buf, "bare\n");
+			strbuf_addstr(buf, is_bare_repository() ? "true" :
+								  "false");
+			break;
+		}
+		break;
 	}
 
 	strbuf_addch(buf, '\0');
@@ -106,6 +130,7 @@ static void repo_info_print_json(struct repo_info *repo_info)
 	struct json_writer jw;
 	unsigned int categories = 0;
 	unsigned int references_fields = 0;
+	unsigned int layout_fields = 0;
 	struct repository *repo = repo_info->repo;
 
 	for (size_t i = 0; i < repo_info->fields_nr; i++) {
@@ -115,6 +140,9 @@ static void repo_info_print_json(struct repo_info *repo_info)
 		case CATEGORY_REFERENCES:
 			references_fields |= field->u.references;
 			break;
+		case CATEGORY_LAYOUT:
+			layout_fields |= field->u.layout;
+			break;
 		}
 	}
 
@@ -130,6 +158,15 @@ static void repo_info_print_json(struct repo_info *repo_info)
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
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 2af9d1d9c3..246c4bc40c 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -61,4 +61,10 @@ test_repo_info 'ref format files is retrieved correctly' '
 test_repo_info 'ref format reftable is retrieved correctly' '
 	git init --ref-format=reftable repo' 'references.format' 'reftable'
 
+test_repo_info 'bare repository = false is retrieved correctly' '
+	git init repo' 'layout.bare' 'false'
+
+test_repo_info 'bare repository = true is retrieved correctly' '
+	git init --bare repo' 'layout.bare' 'true'
+
 test_done
-- 
2.39.5 (Apple Git-154)

