Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECBE1397
	for <git@vger.kernel.org>; Sat,  3 Jan 2026 22:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767478624; cv=none; b=K0mK528LSPAZFVsFl/Yq1GFqjkz16Lr9KtxsU0bYViBog3C3pn+ye89sSp8b3uh6IUanPcXYIUlMMw4cvweTkcVoYbo6AgM0T1o/anWgnemQIw59y0h+saTuJGpMo2z8o/gRGnkLRTephAyksZdgX+mmZ/Tndu/1M2ydY7i9/4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767478624; c=relaxed/simple;
	bh=HAkn/ZcwaKOwdFnis4KrE06GNp2O49uoKyqebrF9XEg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=tT+VfZYkgcwTgfJV8DgoQDNWI4vgpTd6+2Onatdmvk1UTGvn3ApH79egU8gwjQN9nQshoryuNlvLThDuJSfUAcrakQMN9M5s5cRKc3dP1JGplp/Rd+SbgvLAWBNtJXizCXriSPXvzI6418f1I4zaoUBx/uUIkmhop7Q8dkHRHVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbATiRK7; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbATiRK7"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c30365ac43so217765985a.0
        for <git@vger.kernel.org>; Sat, 03 Jan 2026 14:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767478620; x=1768083420; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9yiIBP3EuHWwkXmOJMDuemhEOFdRXn9nF0CL3uV7eJ8=;
        b=TbATiRK7OJtLVVEfqe9Dv9YfQ2dUIxxX+JSN1yH5VC0P81SAivOzHvMl6fF2HSj9GH
         /ZMXzPvDGn/oMbaX7DW4q93UxPCUcUy2vZKWMGBfAULRvci4PWCKdjmC99DDH84T/vQi
         Z7bzZ7YgiaNSsK1xHC9ihQaAVtZ18VAyg8r/wjs/q6p8cTvxcxsxUp+CxDmZyY1NT4oN
         Prw+mkz4WvgOO6aQt8TmPnKCuIq4Bux0QIgHLVZr4abnQIrxOc5E76TslWsm/ehSrq5z
         c5e7egBk9dSfIUtx7xdILPbhQhQ9Z4np/R9xTADF/DU2NmJoJtzhqpQwjSQx2mkcOh5B
         Bd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767478620; x=1768083420;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yiIBP3EuHWwkXmOJMDuemhEOFdRXn9nF0CL3uV7eJ8=;
        b=WdiWODW9rl5FkGhffkR+hj4N2v4w6C6HjGJEdes16hqgDN/GyhajUJMFFBi/NRu7M6
         oGMk4BU0J7ee3x7K74z2oN1NSgDEgWQV5/QHzqmRYlDcz6QyycWzvRFEpMjmYK5TqyIH
         /yOS+H3aPh7PaCLExV0kPXbmmyaHUO58WwUuQxut6gvOOR5+iFZ6jK95EMcOrTANN7Hi
         cYDPzlrpP+CyUBxl1BqS1aIFrhKha4MUKLv00tEUDUlPbV7gKTvzg0mULCDmlDrp+6I0
         wi9mgHmx1EPaF4yI479EFTwtU9RNJYldbOnIEFJ1Pf8ySvSYkR5p6eYsWPHYMMAdUfhr
         EhNg==
X-Gm-Message-State: AOJu0YymeSj4Z/TfrhwtS12Xp5D93/YOL4Z/CRLgBNoAx20DwWmEGqeZ
	RrjIhqJtbgYpq90MFQnlWd1piB+JAPqlZITAeKnpikNii13gb/OK6XlWwmdL+EjV
X-Gm-Gg: AY/fxX4zqj5pz0zKMqrV5ZV3c6k7LxQHgy9FKfj8YfSQh8a686EU8XYetBmC1Xn0XUi
	+/OoknIR2SZS81v2u/5szelKWpkwdKYcDibCORp4FudoqzkLUbRiUu/qu8gTGZgnDSt/N7cJSEV
	0Rp+Tyyy+8xKJG/9eHWmiaQ9TNNXOE+RIXrdzkX5W2AwM3GV5ci5UWVLEPd65wLG5RPnjwvh1Uj
	BITXSh5tn7ovQIPpQtJJYl/6bThtp6goeukNf1WHl6tGQ27XGAA26UlzVvQZfjqW96+m0qbSZdf
	2fACGtOhFb7MV9VE6JsC3YMj87wZPLvVFQCGFKqVwEY9yDiD78W3XciIMs5h869nyhAh2IbWQx9
	Z59zGNBqHF2YqWa0umLf0DJPhxUNZCWerpyy7u5hYranUMsoBSv3fNvcRxoU9TzPKMCZI7a8oET
	CDdUimMdJjx1eN
X-Google-Smtp-Source: AGHT+IHTOJSIAspTjrOtJfp4Tkm8XPvbxgJIfn9Ka36D9+Tjw9xzGBSR3qTw7Ur/BqDO82z0AsX8kQ==
X-Received: by 2002:a05:622a:1146:b0:4f1:abf2:54cb with SMTP id d75a77b69052e-4f4abd75338mr793051381cf.43.1767478619468;
        Sat, 03 Jan 2026 14:16:59 -0800 (PST)
Received: from [127.0.0.1] ([20.109.36.229])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ff833bce71sm11658151cf.26.2026.01.03.14.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 14:16:58 -0800 (PST)
Message-Id: <pull.2157.git.git.1767478617198.gitgitgadget@gmail.com>
From: "Matthieu Beauchamp-Boulay via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 03 Jan 2026 22:16:57 +0000
Subject: [PATCH] ignores: handle non UTF-8 exclude files
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Matheus Tavares <matheus.tavb@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Matthieu Beauchamp-Boulay <matthieu.beauchamp.boulay@gmail.com>,
    Matthieu Beauchamp-Boulay <matthieu.beauchamp.boulay@gmail.com>

From: Matthieu Beauchamp-Boulay <matthieu.beauchamp.boulay@gmail.com>

When reading exclude files, git assumes it is encoded in UTF-8 and will
fail to apply patterns if it isn't. This is a silent failure as no warning
or errors are shown to the users. This is a problem that can take a while
to diagnose as many users will not think of checking the encoding of their
file and may believe their patterns are wrong instead. Users may also
accidentally commit undesired files.

On Windows, this happens if a user uses Windows PowerShell to create the
file, which results in a UTF-16LE file with a BOM. This issue was discussed
here https://github.com/git-for-windows/git/issues/3329. An example of
where a user was confused that his exclude file was not working is cited
https://github.com/git-for-windows/git/issues/3227.

A minimal fix should at least warn the user if git cannot properly decode
the exclude file. Ideally, git would handle any given Unicode file.

First, check if a BOM is present. If it is, decode the file to UTF-8.
If no BOM is detected, then try to parse the file as UTF-8. If that fails,
attempt to decode the file using the working tree encoding of the file,
if any. If that fails, print a warning to tell the user that the exclude
file could not be decoded and skip the file.

This raises the issue that if the entire tree is encoded in, for example
UTF-16BE (no BOM), then even if the encoding is given in .gitattributes,
git would not be able to decode it. I believe that this is still
acceptable since a warning will be emitted for the file (since it has no
BOM, is not valid UTF-8 and no working tree encoding could be found).

One case that isn't handled is if a wrong encoding is given in the
attributes and the exclude file has no BOM and is not UTF-8. Using
iconv to convert an UTF16BE file to UTF-8 while specifying UTF-16LE
yields gibberish without an error and so this case is a silent failure
where no patterns will match.

Signed-off-by: Matthieu Beauchamp-Boulay <matthieu.beauchamp.boulay@gmail.com>
---
    ignores: handle non UTF-8 exclude files

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2157%2FMatthieu-Beauchamp%2Funicode-support-gitignore-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2157/Matthieu-Beauchamp/unicode-support-gitignore-v1
Pull-Request: https://github.com/git/git/pull/2157

 dir.c              |  29 +++++++++++++
 t/lib-encoding.sh  |   8 ++++
 t/t0008-ignores.sh | 102 +++++++++++++++++++++++++++++++++++++++++++++
 utf8.c             |  29 +++++++++++++
 utf8.h             |  12 ++++++
 5 files changed, 180 insertions(+)

diff --git a/dir.c b/dir.c
index b00821f294..895d476253 100644
--- a/dir.c
+++ b/dir.c
@@ -1154,7 +1154,9 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 	int r;
 	int fd;
 	size_t size = 0;
+	size_t reencoded_size = 0;
 	char *buf;
+	char *reencoded = NULL;
 
 	if (flags & PATTERN_NOFOLLOW)
 		fd = open_nofollow(fname, O_RDONLY);
@@ -1190,7 +1192,34 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 			close(fd);
 			return -1;
 		}
+
+		if (!try_reencode_to_utf8(buf, size, &reencoded, &reencoded_size) && !is_valid_utf8(buf, size)) {
+			struct conv_attrs ca;
+			convert_attrs(istate, &ca, fname);
+
+			if (ca.working_tree_encoding) {
+				reencoded = reencode_string_len(buf, size, "UTF-8", ca.working_tree_encoding, &reencoded_size);
+				if (!reencoded) {
+					warning(_("Failed to decode exclude file %s from encoding %s"), pl->src, ca.working_tree_encoding);
+					free(buf);
+					return -1;
+				}
+			} else {
+				warning(_("Ignoring exclude file with unknown encoding: %s"), pl->src);
+				free(buf);
+				return -1;
+			}
+		}
+
+		if (reencoded) {
+			size = reencoded_size;
+			free(buf);
+			buf = xmallocz(size);
+			memcpy(buf, reencoded, size);
+			free(reencoded);
+		}
 		buf[size++] = '\n';
+
 		close(fd);
 		if (oid_stat) {
 			int pos;
diff --git a/t/lib-encoding.sh b/t/lib-encoding.sh
index 2dabc8c73e..1b1cc357ba 100644
--- a/t/lib-encoding.sh
+++ b/t/lib-encoding.sh
@@ -23,3 +23,11 @@ write_utf32 () {
 	fi &&
 	iconv -f UTF-8 -t UTF-32
 }
+
+write_encoded () {
+  iconv -f UTF-8 -t "$1"
+}
+
+write_bom () {
+  echo "$@" | perl -pe 's/\s+//g; $_=pack("H*", $_)'
+}
\ No newline at end of file
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index db8bde280e..d5a3002ffb 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -4,6 +4,7 @@ test_description=check-ignore
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-encoding.sh"
 
 init_vars () {
 	global_excludes="global-excludes"
@@ -963,4 +964,105 @@ test_expect_success EXPENSIVE 'large exclude file ignored in tree' '
 	test_cmp expect err
 '
 
+############################################################################
+#
+# test handling of unicode for .gitignore when BOM is preset or worktree encoding is set for the file
+
+supports_encoding () {
+  encoding="$1" &&
+  d="support-bom-$encoding" &&
+  shift &&
+	mkdir -p "$d" &&
+	touch "$d/file" "$d/excluded" &&
+	write_bom "$@" > "$d/.gitignore" &&
+  echo excluded | write_encoded "$encoding" >> "$d/.gitignore"
+	git check-ignore "$d/excluded" > "$d/actual" &&
+	echo "$d/excluded" > expect &&
+	test_cmp expect "$d/actual"
+}
+
+test_expect_success ICONV 'Can read gitignore in UTF-8 with BOM' '
+  supports_encoding "UTF-8" EF BB BF
+'
+
+test_expect_success ICONV 'Can read gitignore in UTF-16LE when given a BOM' '
+  supports_encoding "UTF-16LE" FF FE
+'
+
+test_expect_success ICONV 'Can read gitignore in UTF-16BE when given a BOM' '
+  supports_encoding "UTF-16BE" FE FF
+'
+
+test_expect_success ICONV 'Can read gitignore in UTF-32LE when given a BOM' '
+  supports_encoding "UTF-32LE" FF FE 00 00
+'
+
+test_expect_success ICONV 'Can read gitignore in UTF-32BE when given a BOM' '
+  supports_encoding "UTF-32BE" 00 00 FE FF
+'
+
+supports_reading_ignore_in_working_tree_encoding () {
+  encoding="$1" &&
+  d="support-wt-$encoding" &&
+	mkdir -p "$d" &&
+	touch "$d/file" "$d/excluded" &&
+  echo ".gitignore		text working-tree-encoding=$encoding" > "$d/.gitattributes" &&
+  echo excluded | write_encoded "$encoding" > "$d/.gitignore"
+	git check-ignore "$d/excluded" > "$d/actual" &&
+	echo "$d/excluded" > expect &&
+	test_cmp expect "$d/actual"
+}
+
+test_expect_success ICONV 'Can read gitignore in UTF-8 when it is set as working tree encoding' '
+  supports_reading_ignore_in_working_tree_encoding "UTF-8"
+'
+
+test_expect_success ICONV 'Can read gitignore in UTF-16LE when it is set as working tree encoding' '
+  supports_reading_ignore_in_working_tree_encoding "UTF-16LE"
+'
+
+test_expect_success ICONV 'Can read gitignore in UTF-16BE when it is set as working tree encoding' '
+  supports_reading_ignore_in_working_tree_encoding "UTF-16BE"
+'
+
+test_expect_success ICONV 'Can read gitignore in UTF-32LE when it is set as working tree encoding' '
+  supports_reading_ignore_in_working_tree_encoding "UTF-32LE"
+'
+
+test_expect_success ICONV 'Can read gitignore in UTF-32BE when it is set as working tree encoding' '
+  supports_reading_ignore_in_working_tree_encoding "UTF-32BE"
+'
+
+test_expect_success ICONV 'Issues a warning if encoding cannot be deduced' '
+  d="warn-unknown-encoding" &&
+	mkdir -p "$d" &&
+	touch "$d/file" "$d/excluded" &&
+	echo excluded | write_encoded "UTF-16BE" > "$d/.gitignore" &&
+	test_must_fail git check-ignore "$d/excluded" > actual 2>&1 &&
+	echo "warning: Ignoring exclude file with unknown encoding: $d/.gitignore" > expect &&
+	test_cmp expect actual
+'
+
+test_expect_success ICONV 'Warns if the exclude file cannot be decoded due to encoded attributes' '
+  d="warn-cant-decode-attributes" &&
+	mkdir -p "$d" &&
+	touch "$d/file" "$d/excluded" &&
+	echo excluded | write_encoded "UTF-16BE" > "$d/.gitignore" &&
+  echo ".gitignore		text working-tree-encoding=UTF-16BE" | write_encoded "UTF-16BE" > "$d/.gitattributes" &&
+	test_must_fail git check-ignore "$d/excluded" > actual 2>&1 &&
+	echo "warning: Ignoring exclude file with unknown encoding: $d/.gitignore" > expect &&
+	test_cmp expect actual
+'
+
+test_expect_failure ICONV 'Issues a warning if the wrong encoding is given' '
+  d="warn-wrong-encoding" &&
+	mkdir -p "$d" &&
+	touch "$d/file" "$d/excluded" &&
+	echo excluded | write_encoded "UTF-16BE" > "$d/.gitignore" &&
+  echo ".gitignore		text working-tree-encoding=UTF-16LE" > "$d/.gitattributes" &&
+	test_must_fail git check-ignore "$d/excluded" > actual 2>&1 &&
+	echo "warning: Ignoring exclude file with unknown encoding: $d/.gitignore" > expect &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/utf8.c b/utf8.c
index 35a0251939..904cf20f97 100644
--- a/utf8.c
+++ b/utf8.c
@@ -252,6 +252,17 @@ int is_utf8(const char *text)
 	return 1;
 }
 
+int is_valid_utf8(const char *text, size_t len)
+{
+	while (text && len > 0) {
+		ucs_char_t ch = pick_one_utf8_char(&text, &len);
+		if (text && ch == 0 && len > 0)
+			return 0;
+	}
+
+	return text != NULL;
+}
+
 static void strbuf_add_indented_text(struct strbuf *buf, const char *text,
 				     int indent, int indent2)
 {
@@ -643,6 +654,24 @@ int is_missing_required_utf_bom(const char *enc, const char *data, size_t len)
 	);
 }
 
+int try_reencode_to_utf8(const char *text, size_t len, char **out_text, size_t *out_len)
+{
+	const char *in_encoding;
+	if (has_bom_prefix(text, len, utf32_be_bom, sizeof(utf32_be_bom)))
+		in_encoding = "UTF-32BE";
+	else if (has_bom_prefix(text, len, utf32_le_bom, sizeof(utf32_le_bom)))
+		in_encoding = "UTF-32LE";
+	else if (has_bom_prefix(text, len, utf16_be_bom, sizeof(utf16_be_bom)))
+		in_encoding = "UTF-16BE";
+	else if (has_bom_prefix(text, len, utf16_le_bom, sizeof(utf16_le_bom)))
+		in_encoding = "UTF-16LE";
+	else
+		return 0;
+
+	*out_text = reencode_string_len(text, len, "UTF-8", in_encoding, out_len);
+	return *out_text != NULL;
+}
+
 /*
  * Returns first character length in bytes for multi-byte `text` according to
  * `encoding`.
diff --git a/utf8.h b/utf8.h
index cf8ecb0f21..e52e4f7c06 100644
--- a/utf8.h
+++ b/utf8.h
@@ -10,6 +10,12 @@ int utf8_width(const char **start, size_t *remainder_p);
 int utf8_strnwidth(const char *string, size_t len, int skip_ansi);
 int utf8_strwidth(const char *string);
 int is_utf8(const char *text);
+
+/*
+ * Checks that the string is valid UTF-8 that does not contain the null byte
+ * except at the end of the string
+ */
+int is_valid_utf8(const char *text, size_t len);
 int is_encoding_utf8(const char *name);
 int same_encoding(const char *, const char *);
 __attribute__((format (printf, 2, 3)))
@@ -48,6 +54,12 @@ static inline char *reencode_string(const char *in,
 				   NULL);
 }
 
+/*
+ * Returns true if an unicode BOM is detected and the string can be reencoded to UTF-8.
+ * In that case the string is reencoded to UTF-8 in *out_text.
+ */
+int try_reencode_to_utf8(const char *text, size_t len, char **out_text, size_t *out_len);
+
 int mbs_chrlen(const char **text, size_t *remainder_p, const char *encoding);
 
 /*

base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
-- 
gitgitgadget
