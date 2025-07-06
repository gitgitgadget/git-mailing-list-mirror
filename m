Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6412877F8
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 23:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751844022; cv=none; b=Llafc8+Pu9zW5H5yJAdtewSXeZ9pxnXBMblxPtWQKdBdwLn2rG8XK5FUxpM4hFxNPR2QueiWn831w8fPCbo66+YFqFDDf8paYyefXVwgl/vbcESdd29agRdSEBaulU4IAA+0XA699+oNTHTRIF+ZJB3dQhRSquHxUbjENG+8HaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751844022; c=relaxed/simple;
	bh=jlrA82gweUnTQuYyPDx1iSTcdCUS/DPuOjDfdMze+QA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UMWKlJccwvt+gusKfZWqX0fNOJHUTaztblHXqgVb+MsXfmPcKp5cpWzlR09p7sA2Xwrehl09QEsD1uN82zMA1aHSkEZw5CagegNxDEqhMmQnntzWElrUT7fffc0BCko04mXyN4CD2lsXdKW7N43v16AzpCV+P5NmEmV3MVMTH8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqvURbur; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqvURbur"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6ecf99dd567so38649956d6.0
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 16:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751844020; x=1752448820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTKhSScI+hJwfB7b5yxY4EHtDHm5gHXLR3yAis9hJpk=;
        b=BqvURburPHF6pCmmdif3SxPhKBZlLbui/2Opa88Pa/E4ubRdSmUTomGK0lBN4QNIgH
         iS5MWKgmYW0K5iSb44cMy4YQh+yWM63Xgdv9Bbp7J81ev0jTQmnK9AHwCj0Mzk/TX2wt
         87yJ8CD0jYVXEhRPnnM7tCRaTectoH5MRbN33K+S/jO8Oh+0BBZNX+dz4og5MNohNyD9
         L4j0gHC9Riqur35D6EHqp7xFz1knH/eKYWETzj9p4Z8fR/ol1kPRAgyhfmhro8rwdYww
         RlgsoPa4xQdY+FwDHUTw7ue3ScG19me7lZ+S5OBBG0GVvg3arp4qXZIa4tR+iGoyR5IJ
         FFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751844020; x=1752448820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTKhSScI+hJwfB7b5yxY4EHtDHm5gHXLR3yAis9hJpk=;
        b=hpiflXari25C0WRQbmpit20ON2unHN3z74M9Wt7Nkp/TG8yPitEZIe9NUaUcGIQxyY
         IEndAE2q5wxzVnz3yfaH0RKyUIAQY0p7Mr1Jier8tMCQYasSLfQJxEZCeUXmxIgs2wWL
         tXaLSBBmHe2O6n1msVY0Ll4Bv79ZfmVZg0GBlcLuKzXL07MO2gV4D617thIA3fGaK/yL
         b5/dTBh7DIjS7uStaK/dVR8yB1/lKFRlBTPyDkHwHVqOlYIGZR/sbkjLEDaedhDlAaRK
         bcAM/qUi4C/6VJ95a3qMY8IAnTjOXBCQmwiI8qu1np7lnfbiA9W0NezQwFEGT72ARvz1
         gwpA==
X-Gm-Message-State: AOJu0Yw9O4zO+hxUyBcKFIE8wyT2cf2kmWyvwLnLsBot1ouQ4y6wVR9J
	Wu9ehowpjWvVk+AJx8ctarOt7wHFlyaTfKFLdFVwGKW5ojYkbjiq+kr8o/Lj8g==
X-Gm-Gg: ASbGncsrXSuU7BY6V9zNcyfgDo1qHQXQEwK+90J1LQC4vw989IXlVOj5zKpjaRMF7Xf
	vvQRN5bHOR/i88+96H07PPKlh1WBBLX6BiIHRLrDUXQLaqErsh6ISMRPbD7gwPxKLSMqyUpphKe
	Jxpi3bhqxaeoQpjiEoZt2uSX+XAEu/WOEles627Bf2RHtRIJqpZx/NPfEJKbZk55O6dS4WQZgsd
	SaFfxwCd2sMzn9/quSsuNE/P8EuFjRhV4fSbuNv1uxjm1oTqkd+jq3VXm9akv9uMBzVR0T2O3+2
	wO0miTFfjsyMGHLmvsKhY6HOHraBpOlBJHl+fn5IGdwGR/V2Szou9OKQe3xVcFCsqPs1/NPbLnE
	UnAPl8kFF/Aw/kFMEeadbUPEnuA==
X-Google-Smtp-Source: AGHT+IGJtlro6ONWay4Rq2LVFlCmDotFvxG8B14E3Z6msq2BztAyLgeNzD9e32ZdUMvyoLpN6PdpRw==
X-Received: by 2002:a05:6214:4008:b0:6fa:cb05:b455 with SMTP id 6a1803df08f44-702c8bd3e7fmr146572326d6.35.1751844019955;
        Sun, 06 Jul 2025 16:20:19 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:934a:8cb5:107d:e42b:6887])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d50947sm49891716d6.78.2025.07.06.16.20.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 06 Jul 2025 16:20:19 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH v3 5/5] repo-info: add field layout.shallow
Date: Sun,  6 Jul 2025 20:19:38 -0300
Message-Id: <20250706231938.16113-6-lucasseikioshiro@gmail.com>
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

The flag `--is-shallow-repository` from git-rev-parse is used for
retrieving whether the repository is shallow. This way, it is used for
querying repository information, fitting in the purpose of
git-repo-info.

Then, add a new field `layout.shallow` to the git-repo-info command
containing that information.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo-info.adoc |  1 +
 builtin/repo-info.c              | 15 +++++++++++++++
 t/t1900-repo-info.sh             | 14 ++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/git-repo-info.adoc b/Documentation/git-repo-info.adoc
index 67d19406ad..3261cd97b5 100644
--- a/Documentation/git-repo-info.adoc
+++ b/Documentation/git-repo-info.adoc
@@ -73,6 +73,7 @@ Reference-related data:
 `layout`::
 Information about the how the current repository is represented:
 * `bare`: `true` if this is a bare repository, otherwise `false`.
+* `shallow`: `true` if this is a shallow repository, otherwise `false`.
 
 SEE ALSO
 --------
diff --git a/builtin/repo-info.c b/builtin/repo-info.c
index 7e29ae8519..2fa6544d15 100644
--- a/builtin/repo-info.c
+++ b/builtin/repo-info.c
@@ -6,6 +6,7 @@
 #include "json-writer.h"
 #include "parse-options.h"
 #include "refs.h"
+#include "shallow.h"
 
 enum output_format {
 	FORMAT_JSON,
@@ -23,6 +24,7 @@ enum repo_info_references_field {
 
 enum repo_info_layout_field {
 	FIELD_LAYOUT_BARE = 1 << 0,
+	FIELD_LAYOUT_SHALLOW = 1 << 1,
 };
 
 struct repo_info_field {
@@ -66,6 +68,9 @@ static void repo_info_init(struct repo_info *repo_info,
 		} else if (!strcmp(arg, "layout.bare")) {
 			field->category = CATEGORY_LAYOUT;
 			field->u.layout = FIELD_LAYOUT_BARE;
+		} else if (!strcmp(arg, "layout.shallow")) {
+			field->category = CATEGORY_LAYOUT;
+			field->u.layout = FIELD_LAYOUT_SHALLOW;
 		} else {
 			die("invalid field '%s'", arg);
 		}
@@ -103,6 +108,11 @@ static void append_null_terminated_field(struct strbuf *buf,
 			strbuf_addstr(buf, is_bare_repository() ? "true" :
 								  "false");
 			break;
+		case FIELD_LAYOUT_SHALLOW:
+			strbuf_addstr(buf, "shallow\n");
+			strbuf_addstr(buf, is_repository_shallow(repo) ? "true" :
+									 "false");
+			break;
 		}
 		break;
 	}
@@ -165,6 +175,11 @@ static void repo_info_print_json(struct repo_info *repo_info)
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
index 246c4bc40c..fdbbfb42a0 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -67,4 +67,18 @@ test_repo_info 'bare repository = false is retrieved correctly' '
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
 test_done
-- 
2.39.5 (Apple Git-154)

