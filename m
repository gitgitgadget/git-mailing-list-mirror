Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA5F81F404
	for <e@80x24.org>; Fri, 29 Dec 2017 13:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750898AbdL2N2p (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 08:28:45 -0500
Received: from mout.web.de ([212.227.17.11]:52313 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750744AbdL2N2n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 08:28:43 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MDgDS-1eij2E0M7q-00H3kL; Fri, 29
 Dec 2017 14:28:32 +0100
From:   tboegi@web.de
To:     peff@peff.net, j6t@kdbg.org, lars.schneider@autodesk.com,
        git@vger.kernel.org, gitster@pobox.com, patrick@luehne.de,
        larsxschneider@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH/RFC 2/2] git diff: Allow to reencode into UTF-8
Date:   Fri, 29 Dec 2017 14:28:29 +0100
Message-Id: <20171229132829.17637-1-tboegi@web.de>
X-Mailer: git-send-email 2.15.1.271.g1a4e40aa5d
In-Reply-To: <20171218131249.GB4665@sigill.intra.peff.net>
References: <20171218131249.GB4665@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:b83toDjdttW+lqE4vfqMp5+wxh+FLrgoGnCfs9UlDkmZt/+iApp
 oYBuqWSAHnp6ECJiVkqJopNJ1W1BD1QelE2zFQauYqn1+CEAq+OoEK8TOQes1IFkGTRcu6f
 nt9f0svAxBo1ibb/mFNiPg0b5pLC4URlt+X30uFmNbXcbqeJbYqhhvYuZqACm7uhGALbG5q
 afV8PbStT6McYN2m8MVkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q2JS2+5e8tI=:beSKBUf11PlQLoWDYD8C6Q
 M9ady1TbINflgt3NluSiT8rrqMTc+A1dca5zJq2P4f+PFcPiDbjcCcB5TEoHdmqDP75wRxkDO
 YpBPG4dGqHyQlf8lNiBZ6SmfhjkzgogF/oy6ra+qDcNI/HJFM9StzpOFd1k3RsM3uAepduJhs
 nHj4ykMZBmUIJn7dVOyRCTLAdT3ZaBFucoJ+NO44OuL4QG2SDXuvHyH7/NGYpfYcdkJ+MUEmL
 XRSsAW7DRGI0bwbZ1IB4n38Q7lW9VYA4hd6LJyEP+iIEScJ7Z/d98PHtnxYzhEZZP+hmtulxf
 LmInteTWPF4q8Wl5MpggYsI9yOdrsBgUUurZwYImJdP/5/V20wPmGpxxJ3S0Q0p0xgfPXGOdp
 2r4rg91dhhbk9hqHDp3iwHXUIOSxwT4xRZvbhRrjogXcFAFpgTlYpG4lRjF+tGmsQPVtbzvvN
 sDq01y9eGfQyEWmkQJbIL/M9S0Jtisznhwe1TQV5RyNi30c4NIg7ld48EMYAtWiS9mw6+EF+q
 xK1ziyCpmJbsf91vNMG29HWCZZOOTQ/mhAyMuAoJOFqSBDR1qx25V8esAggyIDCKJNon/5C63
 TfwP+6gq720JHrWpExsgS7WEAOnEM0sdctoVqn4UE7yD2d+50sRaosX/gUaqSBIvmdjf+L4E2
 AaE6KYUzcmPSSIW/uP2fbchtk9o/3dXGujRwQ078rY3KVnGXQWQgg3Y3VCMzi7uosAXPwtkxX
 IEp8VKOqkhh8T+FnqiTwDjj8evUMAa/CQl2RFJVE6yPdihwqy+TV0LJszcEW9Yz2s3p0iEgcs
 twDgi7q4fsNk8AaPUFxriwbRzU9ZOH/Lxihoe4FuVSBwQC6+pU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

When blobs are encoded in UTF-16, `git diff` will treat them as binary.
Make it possible to show a user readable diff encoded in UTF-8.
This allows to run git diff and feed the into a web sever.

Improve Git to look at the "encodig" attribute and to reencode the
content into UTF-8 before running the diff itself.

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 Documentation/diff-options.txt  |  4 ++
 Documentation/gitattributes.txt |  9 +++++
 convert.c                       | 40 +++++++++++++++++++
 convert.h                       |  2 +
 diff.c                          | 38 ++++++++++++++++--
 diff.h                          |  1 +
 diffcore.h                      |  3 ++
 t/t4066-diff-encoding.sh        | 86 +++++++++++++++++++++++++++++++++++++++++
 8 files changed, 180 insertions(+), 3 deletions(-)
 create mode 100755 t/t4066-diff-encoding.sh

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 9d1586b956..bf2f115f11 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -629,6 +629,10 @@ endif::git-format-patch[]
 	linkgit:git-log[1], but not for linkgit:git-format-patch[1] or
 	diff plumbing commands.
 
+--UTF-8::
+	Git converts the content into UTF-8 before running the diff when the
+	"encoding" attribute is defined. See linkgit:gitattributes[5]
+
 --ignore-submodules[=<when>]::
 	Ignore changes to submodules in the diff generation. <when> can be
 	either "none", "untracked", "dirty" or "all", which is the default.
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 30687de81a..753a7c39b7 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -881,6 +881,15 @@ advantages to choosing this method:
 3. Caching. Textconv caching can speed up repeated diffs, such as those
    you might trigger by running `git log -p`.
 
+Running diff on UTF-16 encoded files
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Git can convert UTF-16 encoded into UTF-8 before they are feed
+into the diff machinery: `diff --UTF-8 file.xxx`.
+
+------------------------
+file.xxx encoding=UTF-16
+------------------------
 
 Marking files as binary
 ^^^^^^^^^^^^^^^^^^^^^^^
diff --git a/convert.c b/convert.c
index 5efcc3b73b..45577ce504 100644
--- a/convert.c
+++ b/convert.c
@@ -7,6 +7,7 @@
 #include "sigchain.h"
 #include "pkt-line.h"
 #include "sub-process.h"
+#include "utf8.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -734,6 +735,34 @@ static struct convert_driver {
 	int required;
 } *user_convert, **user_convert_tail;
 
+const char *get_encoding_attr(const char *path)
+{
+	static struct attr_check *check;
+	if (!check)
+		check = attr_check_initl("encoding", NULL);
+	if (!git_check_attr(path, check)) {
+		struct attr_check_item *ccheck = check->items;
+		const char *value;
+		value = ccheck->value;
+		if (ATTR_UNSET(value))
+			return NULL;
+		return value;
+	}
+	return NULL;
+}
+
+static int reencode_into_strbuf(const char *path, const char *src, size_t len,
+				struct strbuf *dst, const char *encoding)
+{
+	int outsz = 0;
+	char *buf;
+	buf = reencode_string_len(src, (int)len, "UTF-8", encoding, &outsz);
+	if (!buf)
+		return 0;
+	strbuf_attach(dst, buf, outsz, outsz);
+	return SAFE_CRLF_REENCODE;
+}
+
 static int apply_filter(const char *path, const char *src, size_t len,
 			int fd, struct strbuf *dst, struct convert_driver *drv,
 			const unsigned int wanted_capability,
@@ -1136,6 +1165,17 @@ int convert_to_git(const struct index_state *istate,
 
 	convert_attrs(&ca, path);
 
+	if (checksafe & SAFE_CRLF_REENCODE) {
+		const char *encoding = get_encoding_attr(path);
+		if (encoding) {
+			ret |= reencode_into_strbuf(path, src, len, dst,
+						    encoding);
+			if (ret && dst) {
+				src = dst->buf;
+				len = dst->len;
+			}
+		}
+	}
 	ret |= apply_filter(path, src, len, -1, dst, ca.drv, CAP_CLEAN, NULL);
 	if (!ret && ca.drv && ca.drv->required)
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
diff --git a/convert.h b/convert.h
index 532af00423..0b093715c9 100644
--- a/convert.h
+++ b/convert.h
@@ -13,6 +13,7 @@ struct index_state;
 #define SAFE_CRLF_WARN        (1<<1)
 #define SAFE_CRLF_RENORMALIZE (1<<2)
 #define SAFE_CRLF_KEEP_CRLF   (1<<3)
+#define SAFE_CRLF_REENCODE    (1<<4)
 
 extern int safe_crlf;
 
@@ -60,6 +61,7 @@ extern const char *get_cached_convert_stats_ascii(const struct index_state *ista
 						  const char *path);
 extern const char *get_wt_convert_stats_ascii(const char *path);
 extern const char *get_convert_attr_ascii(const char *path);
+extern const char *get_encoding_attr(const char *path);
 
 /* returns 1 if *dst was used */
 extern int convert_to_git(const struct index_state *istate,
diff --git a/diff.c b/diff.c
index 5e3aaea6e0..07480a465c 100644
--- a/diff.c
+++ b/diff.c
@@ -3191,6 +3191,12 @@ static void builtin_diff(const char *name_a,
 					 header.buf, header.len, 0);
 			strbuf_reset(&header);
 		}
+		if (one && one->reencoded_to_utf8)
+		  strbuf_addf(&header, "a is converted to UTF-8 from %s\n",
+			      get_encoding_attr(one->path));
+		if (two && two->reencoded_to_utf8)
+		  strbuf_addf(&header, "b is converted to UTF-8 from %s\n",
+			      get_encoding_attr(two->path));
 
 		mf1.size = fill_textconv(textconv_one, one, &mf1.ptr);
 		mf2.size = fill_textconv(textconv_two, two, &mf2.ptr);
@@ -3520,6 +3526,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 {
 	int size_only = flags & CHECK_SIZE_ONLY;
 	int err = 0;
+	int ret = 0;
 	/*
 	 * demote FAIL to WARN to allow inspecting the situation
 	 * instead of refusing.
@@ -3527,7 +3534,8 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 	int checksafe = (safe_crlf == SAFE_CRLF_FAIL
 				    ? SAFE_CRLF_WARN
 				    : safe_crlf);
-
+	if (s->reencode_to_utf8)
+		checksafe |= SAFE_CRLF_REENCODE;
 	if (!DIFF_FILE_VALID(s))
 		die("internal error: asking to populate invalid file.");
 	if (S_ISDIR(s->mode))
@@ -3603,17 +3611,22 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		/*
 		 * Convert from working tree format to canonical git format
 		 */
-		if (convert_to_git(&the_index, s->path, s->data, s->size, &buf, checksafe)) {
+		ret = convert_to_git(&the_index, s->path, s->data, s->size, &buf, checksafe);
+
+		if (ret) {
 			size_t size = 0;
 			munmap(s->data, s->size);
 			s->should_munmap = 0;
 			s->data = strbuf_detach(&buf, &size);
 			s->size = size;
 			s->should_free = 1;
+			if (ret & SAFE_CRLF_REENCODE)
+				 s->reencoded_to_utf8 = 1;
 		}
 	}
 	else {
 		enum object_type type;
+		const char *encoding = NULL;
 		if (size_only || (flags & CHECK_BINARY)) {
 			type = sha1_object_info(s->oid.hash, &s->size);
 			if (type < 0)
@@ -3629,6 +3642,20 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		s->data = read_sha1_file(s->oid.hash, &type, &s->size);
 		if (!s->data)
 			die("unable to read %s", oid_to_hex(&s->oid));
+		if (s->reencode_to_utf8)
+			encoding = get_encoding_attr(s->path);
+		if (encoding) {
+			int outsz = 0;
+			char *buf;
+			buf = reencode_string_len(s->data, (int)s->size,
+						  "UTF-8", encoding, &outsz);
+			if (buf) {
+				free(s->data);
+				s->data = buf;
+				s->size = outsz;
+				s->reencoded_to_utf8 = 1;
+			}
+		}
 		s->should_free = 1;
 	}
 	return 0;
@@ -4627,7 +4654,9 @@ int diff_opt_parse(struct diff_options *options,
 		enable_patch_output(&options->output_format);
 		options->flags.binary = 1;
 	}
-	else if (!strcmp(arg, "--full-index"))
+	else if (!strcmp(arg, "--UTF-8")) {
+		options->flags.reencode_to_utf8 = 1;
+	} else if (!strcmp(arg, "--full-index"))
 		options->flags.full_index = 1;
 	else if (!strcmp(arg, "-a") || !strcmp(arg, "--text"))
 		options->flags.text = 1;
@@ -5695,6 +5724,8 @@ static int diff_filespec_is_identical(struct diff_filespec *one,
 
 static int diff_filespec_check_stat_unmatch(struct diff_filepair *p)
 {
+	p->one->reencode_to_utf8 = p->reencode_to_utf8;
+	p->two->reencode_to_utf8 = p->reencode_to_utf8;
 	if (p->done_skip_stat_unmatch)
 		return p->skip_stat_unmatch_result;
 
@@ -5735,6 +5766,7 @@ static void diffcore_skip_stat_unmatch(struct diff_options *diffopt)
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 
+		p->reencode_to_utf8 = diffopt->flags.reencode_to_utf8;
 		if (diff_filespec_check_stat_unmatch(p))
 			diff_q(&outq, p);
 		else {
diff --git a/diff.h b/diff.h
index 7cf276f077..d2137bab58 100644
--- a/diff.h
+++ b/diff.h
@@ -65,6 +65,7 @@ struct diff_flags {
 	unsigned recursive:1;
 	unsigned tree_in_recursive:1;
 	unsigned binary:1;
+	unsigned reencode_to_utf8:1;
 	unsigned text:1;
 	unsigned full_index:1;
 	unsigned silent_on_remove:1;
diff --git a/diffcore.h b/diffcore.h
index a30da161da..2e84730778 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -47,6 +47,8 @@ struct diff_filespec {
 	unsigned has_more_entries : 1; /* only appear in combined diff */
 	/* data should be considered "binary"; -1 means "don't know yet" */
 	signed int is_binary : 2;
+	unsigned reencode_to_utf8 : 1;
+	unsigned reencoded_to_utf8 : 1;
 	struct userdiff_driver *driver;
 };
 
@@ -72,6 +74,7 @@ struct diff_filepair {
 	unsigned is_unmerged : 1;
 	unsigned done_skip_stat_unmatch : 1;
 	unsigned skip_stat_unmatch_result : 1;
+	unsigned reencode_to_utf8 : 1;
 };
 #define DIFF_PAIR_UNMERGED(p) ((p)->is_unmerged)
 
diff --git a/t/t4066-diff-encoding.sh b/t/t4066-diff-encoding.sh
new file mode 100755
index 0000000000..9b89253877
--- /dev/null
+++ b/t/t4066-diff-encoding.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+
+test_description='git diff with encoding attribute'
+
+. ./test-lib.sh
+
+printf '\303\244rger\n\303\266se\n\303\274bel\n' |
+	iconv -f UTF-8 -t UTF-16 >UTF-16
+printf '\303\266se\n\303\274bel\n\303\245gren\n' |
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
+test_expect_success 'diff --UTF-8 against local change' '
+	cp file2 file &&
+	test_tick &&
+	cat >expect <<-\EOF &&
+	diff --git a/file b/file
+	index 26acf09..06d06e4 100644
+	a is converted to UTF-8 from UTF-16
+	b is converted to UTF-8 from UTF-16
+	--- a/file
+	+++ b/file
+	@@ -1,3 +1,3 @@
+	-ärger
+	 öse
+	 übel
+	+ågren
+EOF
+	git diff --UTF-8 file >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff against local change' '
+	cp file2 file &&
+	test_tick &&
+	cat >expect <<-\EOF &&
+	diff --git a/file b/file
+	index 26acf09..06d06e4 100644
+	Binary files a/file and b/file differ
+EOF
+	git diff file >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'commit local change' '
+	git add file &&
+	git commit -m "add file V2 in UTF-16" &&
+	test_tick
+'
+
+test_expect_success 'diff --UTF-8  HEAD against HEAD^' '
+	cat >expect <<-\EOF &&
+	diff --git a/file b/file
+	index 26acf09..06d06e4 100644
+	a is converted to UTF-8 from UTF-16
+	b is converted to UTF-8 from UTF-16
+	--- a/file
+	+++ b/file
+	@@ -1,3 +1,3 @@
+	-ärger
+	 öse
+	 übel
+	+ågren
+EOF
+	git diff --UTF-8 HEAD^ HEAD -- file >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff HEAD against HEAD^' '
+	cat >expect <<-\EOF &&
+	diff --git a/file b/file
+	index 26acf09..06d06e4 100644
+	Binary files a/file and b/file differ
+EOF
+	git diff HEAD^ HEAD -- file >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.15.1.271.g1a4e40aa5d

