Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4442D63EF
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 05:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763099579; cv=none; b=NlTG4PdB3el7hHipJ+YBA2YG8Qz/ZG1+b2VHCgfqB/Jl+A6TwhCE6iEymFTbYGvPoCON4gPuUaTh3l4xxj8anuvuAe1D6Q5JzQK6QgzUQQIZlDUFHKIt44eWYi/2AFf2J/BHLf62JhQg2J+NAjuc8koq5/aHgBFZp9D/HvSXyh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763099579; c=relaxed/simple;
	bh=EjjZYFhYRLwjk8d5L/NtjFSwQS6oqIBFVX3bO76V+Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBk5EddEVWAW89/Cwu68pr9k8RFThNZwpjDMnnmYNv39uSW5MiU+AtbgoVU/RU7RYMWmF6I53D7YD67jgIK4hRBqb+hPt2rVR99ln8QAzxPyQzyyMgA3+zstDSFHQl6WcEDHyCL57+BHIK+uHxErGWsIk7zCVKaJ15lzQxenVFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRmTV9bq; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRmTV9bq"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-787e7aa1631so28449607b3.1
        for <git@vger.kernel.org>; Thu, 13 Nov 2025 21:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763099576; x=1763704376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZQhJHIf5KYsjAmWr9xH3CrPmlsDMHmxs1d/pMKA9NA=;
        b=fRmTV9bqXes1TKhK2YjG+Q1YJ96kvKgXCez31qI0Ru2XiVu6HnbIGA3ohu3gGPogRE
         /h7ZtsrwdtNwnYrfNBJ1leEII79kOb6UkDwxpae0+wxSHEoK7B9DxIUB1AZxC9QgkDgO
         HOztgKKrXZckSNdXZHMbJpgTxULpiWGEvxuuSLcvqSvhW4PI7TjPfo9kXYzikIq1c3po
         wkUDoqUvZyOa+4i9Pw8WqluaNGKANsr7J7Gx8Cmo8vrG0Q4apwmMh3wkCUyOo4w4r3UE
         +hnUdEUpEczCp0Xz430qjehB2OeGTQmdMxvMhrSYLcJ8s/BqHyTyTXoGgvAkbtCp38k2
         ADfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763099576; x=1763704376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ZQhJHIf5KYsjAmWr9xH3CrPmlsDMHmxs1d/pMKA9NA=;
        b=EUVuQ08GEXQYAHrvprZAbhWNV2ercugRaXzQIvLf6EbNRL96QBJfGy2YEJriVmj3zK
         gvykAmV96CjPAKsB+vPeaSnnJuHsvTaivbeSBHeK7pe9vJfWmBgjhalm1aNl0gEjKukP
         cmEoUn+58jFANOMkeLHAmLdgDRyRKCZIPaQAKwSVEEnJaJ32ve7jnVr6UxHhJax6snnx
         0jnYiPOjnC9Q4OWGjgmZKUtk2bIKmwHTd6ePEt8bjjA7oi6uZm/+D4RxN02tY9WQtLVI
         fYk4rwLn74866qewmzY+UBojiL4HrO+NrkBh8D1EwqPF+N3YL1/mYIZkfl4Yq4WS6n8Y
         sYDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9hDGbapUYBK5S2ER+JIUbh/kNi9cpLsonje+FQHn/CQ1VPKcgzn1vdwkfaWFKOJQ0QeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJiu5zRvP5vp5cMcgo+hyEhKFIuHlvN2A/MRqJ3nx16yOVo3BP
	+zS21EKYUDIveD502HbHxoJ261/vqNqyrSO5H76L/+CPm14/WMNejOd3
X-Gm-Gg: ASbGncvxN+zEtRfawCYLcmUNRUh4IZ4x6H6Mu8ZDgMuseeo6XIgFBTnLMU0c/qTbNdt
	cJUj4AeP7mEH5TSTr1VSv9i1j4oZQ2oeXS83An72+4bnT1gs7fLSGGEJ7rQRaUDlwXudlqSgj66
	cMhLtrsU6Hx4rfP4SHlYWVROcSPx3fd2MoR8aNY7HPQoglEaciOS75y7zUI0f8M7cKHjdd1R42p
	lucoPBDT0yyYLPBJI9lkAHX2RkdMOsn8daUXPsm6o+uhMj8NqkuQGiGh+2Eij5D6QkcDdz6wj56
	28sJ8RAbZ/DUbpi9nOti/yCaWSdpM/goxK6EvMEEASpii5b+h6S97HZ8IvjdXDUotakqcqMPsbI
	it8CTRnA+Si+Jfn42RtvLhlh08o11cQ31hD4x3S8OU4v8dxFCf6fpOs+gi+1dUHDku37glNsdWt
	d3OeG4vZFjiEiYwr/Z5uw8JX52lWrCqaNi6p4Xet9fhe1BAmzIvxS/4NWRjNzXBw==
X-Google-Smtp-Source: AGHT+IHE/lieY/h2pfeaNRT3DBxFpYZ+CJYP4ut+V8ypXEcf8akOQchTlno46N5zIUJWFqYo/MKifA==
X-Received: by 2002:a05:690e:1483:b0:640:db57:8d93 with SMTP id 956f58d0204a3-6410d0b3634mr4824828d50.15.1763099576309;
        Thu, 13 Nov 2025 21:52:56 -0800 (PST)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410ea037besm1411408d50.9.2025.11.13.21.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 21:52:56 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Justin Tobler <jltobler@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Mikel Forcada <mikel.forcada@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	Emir SARI <bitigchi@me.com>,
	Arkadii Yakovets <ark@cho.red>,
	=?UTF-8?q?V=C5=A9=20Ti=E1=BA=BFn=20H=C6=B0ng?= <newcomerminecraft@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>,
	Gemini <noreply@developers.google.com>
Subject: [PATCH 2/2] builtin/repo: fix table alignment for UTF-8 characters
Date: Fri, 14 Nov 2025 00:52:45 -0500
Message-ID: <a50bcde6446fbd87b4fb04b28c579a915457813a.1763098804.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
In-Reply-To: <cover.1763098804.git.worldhello.net@gmail.com>
References: <cover.1763098804.git.worldhello.net@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The output table from "git repo structure" is misaligned when displaying
UTF-8 characters (e.g., non-ASCII glyphs). E.g.:

    | 仓库结构   | 值  |
    | -------------- | ---- |
    | * 引用       |      |
    |   * 计数     |   67 |
    |     * 分支   |    6 |
    |     * 标签   |   30 |
    |     * 远程   |   19 |
    |     * 其它   |   12 |
    |                |      |
    | * 可达对象 |      |
    |   * 计数     | 2217 |
    |     * 提交   |  279 |
    |     * 树      |  740 |
    |     * 数据对象 | 1168 |
    |     * 标签   |   30 |

The previous implementation used simple width formatting with printf()
which didn't properly handle multi-byte UTF-8 characters, causing
misaligned table columns when displaying repository structure
information.

This change modifies the stats_table_print_structure function to use
strbuf_utf8_align() instead of basic printf width specifiers. This
ensures proper column alignment regardless of the character encoding of
the content being displayed.

Co-developed-by: Gemini <noreply@developers.google.com>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/repo.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 9d4749f79b..d0b4a060b1 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -292,14 +292,21 @@ static void stats_table_print_structure(const struct stats_table *table)
 	int name_col_width = utf8_strwidth(name_col_title);
 	int value_col_width = utf8_strwidth(value_col_title);
 	struct string_list_item *item;
+	struct strbuf buf = STRBUF_INIT;
 
 	if (table->name_col_width > name_col_width)
 		name_col_width = table->name_col_width;
 	if (table->value_col_width > value_col_width)
 		value_col_width = table->value_col_width;
 
-	printf("| %-*s | %-*s |\n", name_col_width, name_col_title,
-	       value_col_width, value_col_title);
+	strbuf_addstr(&buf, "| ");
+	strbuf_utf8_align(&buf, ALIGN_LEFT, name_col_width, name_col_title);
+	strbuf_addstr(&buf, " | ");
+	strbuf_utf8_align(&buf, ALIGN_LEFT, value_col_width, value_col_title);
+	strbuf_addstr(&buf, " |");
+	printf("%s\n", buf.buf);
+	strbuf_reset(&buf);
+
 	printf("| ");
 	for (int i = 0; i < name_col_width; i++)
 		putchar('-');
@@ -317,9 +324,16 @@ static void stats_table_print_structure(const struct stats_table *table)
 			value = entry->value;
 		}
 
-		printf("| %-*s | %*s |\n", name_col_width, item->string,
-		       value_col_width, value);
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, "| ");
+		strbuf_utf8_align(&buf, ALIGN_LEFT, name_col_width, item->string);
+		strbuf_addstr(&buf, " | ");
+		strbuf_utf8_align(&buf, ALIGN_RIGHT, value_col_width, value);
+		strbuf_addstr(&buf, " |");
+		printf("%s\n", buf.buf);
 	}
+
+	strbuf_release(&buf);
 }
 
 static void stats_table_clear(struct stats_table *table)
-- 
2.52.0.rc2.5.g4c20a63325.dirty

