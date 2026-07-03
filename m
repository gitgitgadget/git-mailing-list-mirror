Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB7526A0B9
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 02:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783046174; cv=none; b=uNcDSwdtsudIYQ/Pe7KwOLWONobsRyuYFLyLEKhDADpGEKkN7WFDowYMYkexqr6Xy+4Izc22D5TAr3AMXP2QVjjeBwwdkY1rQ5HMLvMJoS0z6mQKOGSlOawNSM8Nip+bQdnvR5EuPFK4oebw9RYaF9b8Q7ICMVA2aP9Rj/5Ok2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783046174; c=relaxed/simple;
	bh=asAawWfPeIn5+sOeW/jxrYfYReluD7fmQOSChlXpKVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GTXXC6ckecABh15mIIWrM/q7+WXUWLyeKmlgHuWRU0NTHZkxCAkTDpSSsx7eOAtVVwI/a1DdKQEMiiQOUIlBHjS3Gg+K1vk3Omv4Xu1Hurf+du+oBKWqaLsWEFSwk3E8rEnlo+MnFcn1SLpgy8+5c8tnnXY4LLBp6/m1Yqg6vWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1foZwyd; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1foZwyd"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-664b3831a20so126462d50.3
        for <git@vger.kernel.org>; Thu, 02 Jul 2026 19:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783046170; x=1783650970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0H3R/XpbM9Qq5IQpAe6Yc5hLYaZT1VIIprhTUOKMENs=;
        b=Y1foZwydZ+Rd5QBVBqJC63tyZeP9pENW/ig+10g2Vwh5XjG0jcb5bDb81at7q56A07
         8iHe4ISUHRKjr+jtsFN37C7hUBxQW4C8shOCBuqpYFhyd6+IcH0WbifFLWlx61rZ802G
         qeEfnHREEn+7yIwFPpzDDjpajoMgQcgw4x63m1M2SrYWdDMc/595NRfbsqetpej7Bye7
         Qb45HTRG92UfsOJpH7vqminN7VzSnSsMpHZaNaQOIqywHVutJrZGIomBT+8/vqAqnJ9l
         ltOce3OI4hUFjuocI+0YSKXHZWZWi/BJX3Fv/xVmH3klUKS63GoiUJai1eXVMYkxR7x7
         0pVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783046170; x=1783650970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0H3R/XpbM9Qq5IQpAe6Yc5hLYaZT1VIIprhTUOKMENs=;
        b=lDnKx03BWgiz4tnSZYNqZRUF2PlZVGSW9Vzv5uo2fvf1oY6sY7YU6g/9f25nKQlDNv
         cVU4KLF1k4ePKqOZms4L0gO5aDxzDT50q+0XXGyOV5YyYwYf6Jc68HuAHyHnwHrzu564
         gjTE67TI9aAtrciqyMGtYTUm2XJg+DSAw5f0/0orhHI4zVwDxg/2nnem6r32G2a1CJkW
         rk2fFx8tKAv3EEJslgG8ACg3/M/saN5nRv+02W8H4X85M8y77cIebFB/lOIXdO9PTH71
         gfMAlPLuAQw6xtQHotE/uX8WDGNwTcEld0uIh9ABSqB2WGWFWjRrdbMJKuPh3dc1Cpmw
         J7lg==
X-Gm-Message-State: AOJu0YxCIZrNWJqAoEcwf3Ion8HRCkZqWZOupyOc1VdojIz9R2qs3pP/
	jOLw7G2zDb3KvMZ+89qekLLDIpGrBiQ4WB2kjyI8cJN7sZtgFJUdXRD35mSqbw==
X-Gm-Gg: AfdE7cl52bLzsYLBjkuzlL8tmKe6MsjPGgZSB7LzYU6jI/TrPl2GGpA+Bd+Q9K68Rdl
	8cXXDAkSl6krbwzLASbXY62FyNjDJOKcGLuG+wH9gf7zKO5/v0hi6y742TyG+NXk/jWSZhFU2h0
	3Mkv6zW3TLgfF2dKqr29S30+6TCN+DDFqEXIguDflsbIpI/yzikgX/C4mVPGO34C+zsmtXLf4Sk
	ylYt1aRlaYSp1mcj3HrpGYPXUh4ppa8eWVFf7ETWb/JC3YxkBQLPlqY4rge4uckGGAJmFuK2xVR
	3zl7IZru5TygySnZbcW3ntM9HpY9GkdSVMxYbkyck19nOMnjxsXmHHE2rwmy0ZMkgl8sHwf0y1W
	qzbVtNYanF/KPs8QrT0MGFDYaC2V4bVnXf64UFdnYsUZSzKFdPvxDJUDIBDQTUGjohfu/7n/sra
	vZI+xe9gaAcx1XhJECMJ7IhtjOAsip04VBPQlOcQ==
X-Received: by 2002:a05:690e:140a:b0:664:9306:fc50 with SMTP id 956f58d0204a3-66521b855camr7610771d50.48.1783046169566;
        Thu, 02 Jul 2026 19:36:09 -0700 (PDT)
Received: from mair.home.arpa ([65.187.96.176])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-666407cd3d8sm174507d50.13.2026.07.02.19.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 19:36:08 -0700 (PDT)
From: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
To: git@vger.kernel.org
Cc: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
Subject: [PATCH] precompose_utf8: use a flex array for d_name
Date: Thu,  2 Jul 2026 22:35:54 -0400
Message-ID: <20260703023554.36577-1-ihar.hrachyshka@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On macOS, git status may abort while reading a directory entry
whose UTF-8 name grows past NAME_MAX bytes:

  __chk_fail_overflow
  __strlcpy_chk
  precompose_utf8_readdir
  read_directory_recursive
  wt_status_collect
  cmd_status

The precompose wrapper already reallocates dirent_prec_psx for
long names, but d_name is declared as char[NAME_MAX + 1]. A
fortified libc can still see that declared object size and reject a
larger strlcpy bound, even though the allocation was grown.

Make d_name a FLEX_ARRAY and size allocations from offsetof(). That
matches the actual object layout with the dynamic allocation, so the
fortified copy sees a destination whose size can grow with max_name_len.

Add a regression test that creates a 261-byte non-ASCII basename and
runs status with core.precomposeunicode enabled.

Signed-off-by: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
---
 compat/precompose_utf8.c     | 12 ++++++++----
 compat/precompose_utf8.h     |  9 +++++----
 t/t3910-mac-os-precompose.sh | 15 +++++++++++++++
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 1711794..8077f62 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -19,6 +19,11 @@ typedef char *iconv_ibp;
 static const char *repo_encoding = "UTF-8";
 static const char *path_encoding = "UTF-8-MAC";
 
+static size_t dirent_prec_psx_size(size_t max_name_len)
+{
+	return st_add(offsetof(dirent_prec_psx, d_name), max_name_len);
+}
+
 static size_t has_non_ascii(const char *s, size_t maxlen, size_t *strlen_c)
 {
 	const uint8_t *ptr = (const uint8_t *)s;
@@ -114,8 +119,8 @@ const char *precompose_argv_prefix(int argc, const char **argv, const char *pref
 PREC_DIR *precompose_utf8_opendir(const char *dirname)
 {
 	PREC_DIR *prec_dir = xmalloc(sizeof(PREC_DIR));
-	prec_dir->dirent_nfc = xmalloc(sizeof(dirent_prec_psx));
-	prec_dir->dirent_nfc->max_name_len = sizeof(prec_dir->dirent_nfc->d_name);
+	prec_dir->dirent_nfc = xmalloc(dirent_prec_psx_size(NAME_MAX + 1));
+	prec_dir->dirent_nfc->max_name_len = NAME_MAX + 1;
 
 	prec_dir->dirp = opendir(dirname);
 	if (!prec_dir->dirp) {
@@ -145,8 +150,7 @@ struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *prec_dir)
 		int ret_errno = errno;
 
 		if (new_maxlen > prec_dir->dirent_nfc->max_name_len) {
-			size_t new_len = sizeof(dirent_prec_psx) + new_maxlen -
-				sizeof(prec_dir->dirent_nfc->d_name);
+			size_t new_len = dirent_prec_psx_size(new_maxlen);
 
 			prec_dir->dirent_nfc = xrealloc(prec_dir->dirent_nfc, new_len);
 			prec_dir->dirent_nfc->max_name_len = new_maxlen;
diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
index fea06cf..c7c3cc2 100644
--- a/compat/precompose_utf8.h
+++ b/compat/precompose_utf8.h
@@ -14,11 +14,12 @@ typedef struct dirent_prec_psx {
 
 	/*
 	 * See http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/dirent.h.html
-	 * NAME_MAX + 1 should be enough, but some systems have
-	 * NAME_MAX=255 and strlen(d_name) may return 508 or 510
-	 * Solution: allocate more when needed, see precompose_utf8_readdir()
+	 * Start with room for NAME_MAX + 1 bytes, but keep d_name as a
+	 * flexible array. Some systems have NAME_MAX=255 while strlen(d_name)
+	 * from readdir() may return 508 or 510 bytes. Grow the allocation as
+	 * needed in precompose_utf8_readdir().
 	 */
-	char   d_name[NAME_MAX+1];
+	char   d_name[FLEX_ARRAY];
 } dirent_prec_psx;
 
 
diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.sh
index 6d5918c..fda4a76 100755
--- a/t/t3910-mac-os-precompose.sh
+++ b/t/t3910-mac-os-precompose.sh
@@ -207,6 +207,21 @@ test_expect_success "Add long precomposed filename" '
 	git commit -m "Long filename"
 '
 
+test_expect_success "status with long non-ASCII filename" '
+	test_when_finished "rm -rf long-utf8-status" &&
+	git init long-utf8-status &&
+	(
+		cd long-utf8-status &&
+		test "$(git config --bool core.precomposeunicode)" = true &&
+		long_utf8_name=$(
+			perl -e "print q(a) x 249, qq(\342\200\224) x 3, q(.md)"
+		) &&
+		test "$(printf "%s" "$long_utf8_name" | wc -c | tr -d " ")" = 261 &&
+		printf "content\n" >"$long_utf8_name" &&
+		git status --porcelain=v1 >actual
+	)
+'
+
 test_expect_failure 'handle existing decomposed filenames' '
 	echo content >"verbatim.$Adiarnfd" &&
 	git -c core.precomposeunicode=false add "verbatim.$Adiarnfd" &&

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.54.0

