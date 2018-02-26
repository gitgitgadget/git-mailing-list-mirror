Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5E0B1F404
	for <e@80x24.org>; Mon, 26 Feb 2018 17:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751777AbeBZR1X (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 12:27:23 -0500
Received: from mout.web.de ([212.227.17.12]:60967 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751465AbeBZR1U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 12:27:20 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M09ZI-1eZwh71RIC-00uHl3; Mon, 26
 Feb 2018 18:27:09 +0100
From:   tboegi@web.de
To:     peff@peff.net, j6t@kdbg.org, lars.schneider@autodesk.com,
        git@vger.kernel.org, gitster@pobox.com, patrick@luehne.de,
        larsxschneider@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH/RFC 1/1] Auto diff of UTF-16 files in UTF-8
Date:   Mon, 26 Feb 2018 18:27:06 +0100
Message-Id: <20180226172706.7822-1-tboegi@web.de>
X-Mailer: git-send-email 2.16.1.194.gb2e45c695d
In-Reply-To: <20171218131249.GB4665@sigill.intra.peff.net>
References: <20171218131249.GB4665@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:g79Gc/lYHUqFNNlCLD9eQnSjAHk/AKLmFGUqQY1UcuTNH4Zqm94
 CMjJDXeG9ODkpWfspZgrESc+2jokcO7ZOlRXZXnj/+uJw/POMEXep9oZ9Dp6NREjve1L5Te
 kkcZ3sI1HKNXk8UqHLYWdTmFPU7IC29haattjPteUyVuS/6FUoX9anfwYUi9aJr/5UnVtwu
 3ZoyZzLiWU/Sm7Iggd1UQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6geVMsARGP8=:fvZXHujxRqwpta+p9O3Fo9
 GDUS7za2WTDKRBLmxEjhFPCbqOq2e10P1T0FwWXNBfWwZU3XFtsSWWHoGXqo+upERiOKfQId+
 2BmQ2llBri5Js1eD0WdMfzXKH9u/c5IRrFjC5UJk6jAFMxiGSG1nVddJK5INacq0vOKSL4l6o
 OQfaUqj/e485Se6aeqFjKSsYmF4bg+KDIkhJujD6E6XuzF4Jdho1dodv2DhjWStjeTDfyjBKC
 oTXbAGZ4PlpKI8oxRZpuGQq+skIqbNAoR5ejXGHYWNChsS3S1MQ0V7tTri/C4X1JkEmTDIkr5
 AeBKQb491PxoEavi14v9CRjrN8MctkmW0yLE3YMJOHeNHXONULG3RvKdKOqDuK3Ik1ue6QJIJ
 bMUkR9N11dC8sP4GSnFMz3iKg6oom8eam5/oZTHfhrVxmBPwkJnLWPbEcKrT6iBgNoIa7klAm
 ybilAccuTjGeTLb0IJREc6ssl1RDaHh4j95W7BZRRCLWGoVyMAFXfBtkpcnh86j3beid5Z5dk
 Sez7bXv0fI8uCHLrLqmasGTATj5sLou/udgw8CYkYhHDlNvzwlpGQkNwlgn7/Wpwa0m6Oh7G0
 U34Ix9RHSxTmng0TeFKEMFdGkUVkXU/GLMyw5I0Lk4xOAqLI6+Od7bbow5oF5ZqE+QHJR6q3P
 CxM0DglIlR70MXm4vQeb1RWALEKBAN6xYzQVRoySL0Vhzz0XdOTzBuWNYwKMCFuNYzCtCcYvr
 Z8+kIOngvaNg+65jlVV6WuB3n9mqvY+bkhgf1NWwYhTW1tAHNMV6ruw1frvMX8O3wYnxKMKkA
 t+lHN60USwGAHsd2yu6ra+XKObk+WxrQ3+es0eCnojLE3a6diA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

When an UTF-16 file is commited and later changed, `git diff` shows
"Binary files XX and YY differ".

When the user wants a diff in UTF-8, a textconv needs to be specified
in .gitattributes and the textconv must be configured.

A more user-friendly diff can be produced for UTF-16 if
- the user did not use `git diff --binary`
- the blob is identified as binary
- the blob has an UTF-16 BOM
- the blob can be converted into UTF-8

Enhance the diff machinery to auto-detect UTF-16 blobs and show them
as UTF-8, unless the user specifies `git diff --binary` which creates
a binary diff.

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 diff.c                   | 43 ++++++++++++++++++++-
 diffcore.h               |  3 ++
 t/t4066-diff-encoding.sh | 98 ++++++++++++++++++++++++++++++++++++++++++++++++
 utf8.h                   | 11 ++++++
 4 files changed, 153 insertions(+), 2 deletions(-)
 create mode 100755 t/t4066-diff-encoding.sh

diff --git a/diff.c b/diff.c
index fb22b19f09..51831ee94d 100644
--- a/diff.c
+++ b/diff.c
@@ -3192,6 +3192,10 @@ static void builtin_diff(const char *name_a,
 			strbuf_reset(&header);
 		}
 
+		if (one && one->reencoded_from_utf16)
+			strbuf_addf(&header, "a is converted to UTF-8 from UTF-16\n");
+		if (two && two->reencoded_from_utf16)
+			strbuf_addf(&header, "b is converted to UTF-8 from UTF-16\n");
 		mf1.size = fill_textconv(textconv_one, one, &mf1.ptr);
 		mf2.size = fill_textconv(textconv_two, two, &mf2.ptr);
 
@@ -3611,8 +3615,25 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 			s->size = size;
 			s->should_free = 1;
 		}
-	}
-	else {
+		if (!s->binary && buffer_is_binary(s->data, s->size) &&
+		    buffer_has_utf16_bom(s->data, s->size)) {
+			int outsz = 0;
+			char *outbuf;
+			outbuf = reencode_string_len(s->data, (int)s->size,
+						     "UTF-8", "UTF-16", &outsz);
+			if (outbuf) {
+				if (s->should_free)
+					free(s->data);
+				if (s->should_munmap)
+					munmap(s->data, s->size);
+				s->should_munmap = 0;
+				s->data = outbuf;
+				s->size = outsz;
+				s->reencoded_from_utf16 = 1;
+				s->should_free = 1;
+			}
+		}
+	} else {
 		enum object_type type;
 		if (size_only || (flags & CHECK_BINARY)) {
 			type = sha1_object_info(s->oid.hash, &s->size);
@@ -3629,6 +3650,19 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		s->data = read_sha1_file(s->oid.hash, &type, &s->size);
 		if (!s->data)
 			die("unable to read %s", oid_to_hex(&s->oid));
+		if (!s->binary && buffer_is_binary(s->data, s->size) &&
+		    buffer_has_utf16_bom(s->data, s->size)) {
+			int outsz = 0;
+			char *buf;
+			buf = reencode_string_len(s->data, (int)s->size,
+						  "UTF-8", "UTF-16", &outsz);
+			if (buf) {
+				free(s->data);
+				s->data = buf;
+				s->size = outsz;
+				s->reencoded_from_utf16 = 1;
+			}
+		}
 		s->should_free = 1;
 	}
 	return 0;
@@ -5695,6 +5729,10 @@ static int diff_filespec_is_identical(struct diff_filespec *one,
 
 static int diff_filespec_check_stat_unmatch(struct diff_filepair *p)
 {
+	if (p->binary) {
+		p->one->binary = 1;
+		p->two->binary = 1;
+	}
 	if (p->done_skip_stat_unmatch)
 		return p->skip_stat_unmatch_result;
 
@@ -5735,6 +5773,7 @@ static void diffcore_skip_stat_unmatch(struct diff_options *diffopt)
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 
+		p->binary = diffopt->flags.binary;
 		if (diff_filespec_check_stat_unmatch(p))
 			diff_q(&outq, p);
 		else {
diff --git a/diffcore.h b/diffcore.h
index a30da161da..3cd97bb93b 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -47,6 +47,8 @@ struct diff_filespec {
 	unsigned has_more_entries : 1; /* only appear in combined diff */
 	/* data should be considered "binary"; -1 means "don't know yet" */
 	signed int is_binary : 2;
+	unsigned binary : 1;
+	unsigned reencoded_from_utf16 : 1;
 	struct userdiff_driver *driver;
 };
 
@@ -72,6 +74,7 @@ struct diff_filepair {
 	unsigned is_unmerged : 1;
 	unsigned done_skip_stat_unmatch : 1;
 	unsigned skip_stat_unmatch_result : 1;
+	unsigned binary : 1;
 };
 #define DIFF_PAIR_UNMERGED(p) ((p)->is_unmerged)
 
diff --git a/t/t4066-diff-encoding.sh b/t/t4066-diff-encoding.sh
new file mode 100755
index 0000000000..9bb3c70ada
--- /dev/null
+++ b/t/t4066-diff-encoding.sh
@@ -0,0 +1,98 @@
+#!/bin/sh
+
+test_description='git diff with encoding attribute'
+
+. ./test-lib.sh
+
+printf '\303\244rger\n\303\266se\n\303\274bel\n' |
+	iconv -f UTF-8 -t UTF-16 >UTF-16
+printf '\303\266se\n\303\274bel\n\303\245st\n' |
+	iconv -f UTF-8 -t UTF-16 >file2
+
+test_expect_success 'setup' '
+	cp UTF-16 file &&
+	git add file &&
+	git commit -m "add file in UTF-16" &&
+	test_tick &&
+	echo "file encoding=UTF-16" >.gitattributes
+'
+
+test_expect_success 'diff against local change' '
+	cp file2 file &&
+	test_tick &&
+	cat >expect <<-\EOF &&
+	diff --git a/file b/file
+	index 26acf09..e98d27a 100644
+	a is converted to UTF-8 from UTF-16
+	b is converted to UTF-8 from UTF-16
+	--- a/file
+	+++ b/file
+	@@ -1,3 +1,3 @@
+	-ärger
+	 öse
+	 übel
+	+åst
+EOF
+	git diff file >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff --binary against local change' '
+	cp file2 file &&
+	test_tick &&
+	cat >expect <<-\EOF &&
+	diff --git a/file b/file
+	index 26acf09b0aad19fb22566956d1a39cb4e2a3b420..e98d27acfb90cfcfc84fcc5173baa4aa7828290f 100644
+	GIT binary patch
+	literal 28
+	ecmezW?;ArgLn;Fo!ykquAe{qbJq3!C0BHb{ln3Pi
+
+	literal 32
+	icmezW?+HT@Lpnn$kmO?c#!w7oaWVX1NCMJ1Ko$VA_z0~4
+
+EOF
+	git diff --binary file >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'commit local change' '
+	git add file &&
+	git commit -m "add file V2 in UTF-16" &&
+	test_tick
+'
+
+test_expect_success 'diff HEAD against HEAD^' '
+	cat >expect <<-\EOF &&
+	diff --git a/file b/file
+	index 26acf09..e98d27a 100644
+	a is converted to UTF-8 from UTF-16
+	b is converted to UTF-8 from UTF-16
+	--- a/file
+	+++ b/file
+	@@ -1,3 +1,3 @@
+	-ärger
+	 öse
+	 übel
+	+åst
+EOF
+	git diff HEAD^ HEAD -- file >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff --binary HEAD against HEAD^' '
+	cat >expect <<-\EOF &&
+	diff --git a/file b/file
+	index 26acf09b0aad19fb22566956d1a39cb4e2a3b420..e98d27acfb90cfcfc84fcc5173baa4aa7828290f 100644
+	GIT binary patch
+	literal 28
+	ecmezW?;ArgLn;Fo!ykquAe{qbJq3!C0BHb{ln3Pi
+
+	literal 32
+	icmezW?+HT@Lpnn$kmO?c#!w7oaWVX1NCMJ1Ko$VA_z0~4
+	
+EOF
+	git diff --binary HEAD^ HEAD -- file >actual &&
+	test_cmp expect actual
+'
+
+test_done
diff --git a/utf8.h b/utf8.h
index 6bbcf31a83..a2184d0300 100644
--- a/utf8.h
+++ b/utf8.h
@@ -16,6 +16,17 @@ int utf8_fprintf(FILE *, const char *, ...);
 extern const char utf8_bom[];
 extern int skip_utf8_bom(char **, size_t);
 
+static inline int buffer_has_utf16_bom(const void *buf, size_t len) {
+  const unsigned char *text = (unsigned char *)buf;
+  if (!text ||  len < 2)
+    return 0;
+  if (text[0] == 0xff && text[1] == 0xfe)
+    return 1;
+  if (text[0] == 0xfe && text[1] == 0xff)
+    return 1;
+  return 0;
+}
+
 void strbuf_add_wrapped_text(struct strbuf *buf,
 		const char *text, int indent, int indent2, int width);
 void strbuf_add_wrapped_bytes(struct strbuf *buf, const char *data, int len,
-- 
2.16.1.194.gb2e45c695d

