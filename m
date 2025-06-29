Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C99A19ABD1
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 04:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751171285; cv=none; b=gXOfvL4XFek16qfcuhRm+BNUQ8/i+guCL/FH1Qv+/ZsfZYNSP/Dsy6kFeL7vM5hhSF01qH3fwVQJgELQt7dhwLqWmiC790HtNH8mW9swcMY84UD4doauHehTRFPMQ2F6AjTzWd6Q+Tu9tOdyFS/YA1r2Q7YpQdMyM3XdEo5br9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751171285; c=relaxed/simple;
	bh=cUsX6lQ74qRtnKkixJlE8ApJQHvPr2D4fhBQAiB+saI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoKiHJZZ6RlGIkPYgYff1qV9dDrOL0UnFv5WqsMRaciaCsZVaSgW6XVOOcCMEgksPSST21SbHjOr89AfOE9XHwuIO48jClZ2gVUbR8rc6Wz5irBkBZwqk23rRyYkOtKJM2htzm6Q850sUlaZ5kZtgQQ6myL9PaUBli4qQKn05+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zro+bZli; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zro+bZli"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7490cb9a892so2577506b3a.0
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 21:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751171283; x=1751776083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sow4y8bYvnscrvbnvKJz+Zlb3LHc1AVbelgqb1YERH8=;
        b=Zro+bZliubZafp3LwGAwdvB5yKp8kVt2/baV2J925DeAsyHE3nWKHXQvdp/tCFzItM
         HkytA8cMqjZgDbS5gDycrjB3gYysyOmJGG2A9OkxwFbYW03AduTypuzb9OoDtOD+syx2
         t4G3ISszl7tIDMDWDIpylk0YQNqJL6dSM/OMvufRn+vRhdZo7ieEeAM74X9i8qguMYj3
         davoOgEoZrM45RnDoifpdc8wd71AujWXcVZIr49YxPDvCSTTW5e5hjkEH+Wvt6I0gfUe
         L3TbijOczJtws8Hzc8O87+1olzUpzAFRvIF9qVLLIjmZGxs59zzjBZuVSM/7AuDo8oxm
         su5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751171283; x=1751776083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sow4y8bYvnscrvbnvKJz+Zlb3LHc1AVbelgqb1YERH8=;
        b=n1OpJ/VvduCOz0UI5krao7d7HXze1yMlDh5m/q8lnw/CCWfQdoMgQDgUSPtVPWghyq
         laM8WgFSYINPiDgsnenFtTJNLHmS1SX0skdcekRXKYQc0r4RR3zxOYgf7BBvNJgqFZhY
         jixovocAIu1Qid8UGn605I1YQalaJJLYeXd8sr7JvDTT7NPNeSo2mv6/hhEVtKr3xVbb
         CTpTa1xzkthDq2LRCg1g2XFVTj+VDv6irfAPIcI14FIRK0g1Qaz38RXfjcxVMAgbLpsj
         WojuD8Uq4v2vkBq7rcvjVtf7Or3xvCqNYNLLl83c77wTPFN1XJZmGMcPStah/d58Ks7S
         Br+A==
X-Gm-Message-State: AOJu0YycP31f3uV3sLX1JRHEpzDEpLTBpecBf/U8pk4SwOvG/YnBDpw3
	MhYxrl+PLCif+/E5CRYt2e+hHbRVhwc5GvMFA2kxoLhovQUiHwDPnL1DwevP/w==
X-Gm-Gg: ASbGncsMjIoNmsodg1JkXcTELnxDXEYgd57IeIHliwRv81t4j7NA642U0UhwWhPbAhr
	UE/t1k3rM8w3EFH4uMa8En6opHiLX0KaHyxZS296EG3WnQHrm6Po2brxKxVzoRF+PYc9Tr7UrCB
	zGGJ9KhNr5WcuSWnMaG1g3JV80ULuPjHRKKAdMCD4bXKYjfo3DReOpcEzPPkhTaFBojT2ioL50O
	QJAxezdt3GFKj2jLv95OXojZWEzX1ig7p0Tl5ITwlLlsCC/jRpTDPfhMqXo0P4tKH0Mr2PiaJOp
	l4uQQJ/unSfuw52nDadzkEgsRvDgfJigxoLE03ftWe7bqnc4oTfGn/aPAkMFLclyG0QX
X-Google-Smtp-Source: AGHT+IESvdxVV+rBRhPAypQ17C3F0lPharqJyVZAvifebMnEblXjOBWLot1ewNxY4IbOmr/Dveu+Og==
X-Received: by 2002:a05:6a20:c90e:b0:21f:53e4:1925 with SMTP id adf61e73a8af0-220a12dbff0mr12630912637.10.1751171283167;
        Sat, 28 Jun 2025 21:28:03 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af5573e71sm6146181b3a.98.2025.06.28.21.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 21:28:02 -0700 (PDT)
Date: Sun, 29 Jun 2025 12:28:14 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 5/8] u-string-list: move "test_split" into
 "u-string-list.c"
Message-ID: <aGDA3vLgdoj3d3h4@ArchLinux>
References: <aGDAZ6a0-PyXXGmK@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGDAZ6a0-PyXXGmK@ArchLinux>

We rely on "test-tool string-list" command to test the functionality of
the "string-list". However, as we have introduced clar test framework,
we'd better move the shell script into C program to improve speed and
readability.

Create a new file "u-string-list.c" under "t/unit-tests", then update
the Makefile and "meson.build" to build the file. And let's first move
"test_split" into unit test and gradually convert the shell script into
C program.

In order to create `string_list` easily by simply specifying strings in
the function call, create "t_vcreate_string_list_dup" function to do
this.

Then port the shell script tests to C program and remove unused
"test-tool" code and tests.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Makefile                     |  1 +
 t/helper/test-string-list.c  | 14 ---------
 t/meson.build                |  1 +
 t/t0063-string-list.sh       | 53 ----------------------------------
 t/unit-tests/u-string-list.c | 55 ++++++++++++++++++++++++++++++++++++
 5 files changed, 57 insertions(+), 67 deletions(-)
 create mode 100644 t/unit-tests/u-string-list.c

diff --git a/Makefile b/Makefile
index 70d1543b6b..744f060e53 100644
--- a/Makefile
+++ b/Makefile
@@ -1367,6 +1367,7 @@ CLAR_TEST_SUITES += u-prio-queue
 CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
 CLAR_TEST_SUITES += u-strcmp-offset
+CLAR_TEST_SUITES += u-string-list
 CLAR_TEST_SUITES += u-strvec
 CLAR_TEST_SUITES += u-trailer
 CLAR_TEST_SUITES += u-urlmatch-normalization
diff --git a/t/helper/test-string-list.c b/t/helper/test-string-list.c
index 6f10c5a435..17c18c30f6 100644
--- a/t/helper/test-string-list.c
+++ b/t/helper/test-string-list.c
@@ -46,20 +46,6 @@ static int prefix_cb(struct string_list_item *item, void *cb_data)
 
 int cmd__string_list(int argc, const char **argv)
 {
-	if (argc == 5 && !strcmp(argv[1], "split")) {
-		struct string_list list = STRING_LIST_INIT_DUP;
-		int i;
-		const char *s = argv[2];
-		int delim = *argv[3];
-		int maxsplit = atoi(argv[4]);
-
-		i = string_list_split(&list, s, delim, maxsplit);
-		printf("%d\n", i);
-		write_list(&list);
-		string_list_clear(&list, 0);
-		return 0;
-	}
-
 	if (argc == 5 && !strcmp(argv[1], "split_in_place")) {
 		struct string_list list = STRING_LIST_INIT_NODUP;
 		int i;
diff --git a/t/meson.build b/t/meson.build
index 50e89e764a..d3b3916580 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -11,6 +11,7 @@ clar_test_suites = [
   'unit-tests/u-reftable-tree.c',
   'unit-tests/u-strbuf.c',
   'unit-tests/u-strcmp-offset.c',
+  'unit-tests/u-string-list.c',
   'unit-tests/u-strvec.c',
   'unit-tests/u-trailer.c',
   'unit-tests/u-urlmatch-normalization.c',
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
index aac63ba506..6b20ffd206 100755
--- a/t/t0063-string-list.sh
+++ b/t/t0063-string-list.sh
@@ -7,16 +7,6 @@ test_description='Test string list functionality'
 
 . ./test-lib.sh
 
-test_split () {
-	cat >expected &&
-	test_expect_success "split $1 at $2, max $3" "
-		test-tool string-list split '$1' '$2' '$3' >actual &&
-		test_cmp expected actual &&
-		test-tool string-list split_in_place '$1' '$2' '$3' >actual &&
-		test_cmp expected actual
-	"
-}
-
 test_split_in_place() {
 	cat >expected &&
 	test_expect_success "split (in place) $1 at $2, max $3" "
@@ -25,49 +15,6 @@ test_split_in_place() {
 	"
 }
 
-test_split "foo:bar:baz" ":" "-1" <<EOF
-3
-[0]: "foo"
-[1]: "bar"
-[2]: "baz"
-EOF
-
-test_split "foo:bar:baz" ":" "0" <<EOF
-1
-[0]: "foo:bar:baz"
-EOF
-
-test_split "foo:bar:baz" ":" "1" <<EOF
-2
-[0]: "foo"
-[1]: "bar:baz"
-EOF
-
-test_split "foo:bar:baz" ":" "2" <<EOF
-3
-[0]: "foo"
-[1]: "bar"
-[2]: "baz"
-EOF
-
-test_split "foo:bar:" ":" "-1" <<EOF
-3
-[0]: "foo"
-[1]: "bar"
-[2]: ""
-EOF
-
-test_split "" ":" "-1" <<EOF
-1
-[0]: ""
-EOF
-
-test_split ":" ":" "-1" <<EOF
-2
-[0]: ""
-[1]: ""
-EOF
-
 test_split_in_place "foo:;:bar:;:baz:;:" ":;" "-1" <<EOF
 10
 [0]: "foo"
diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
new file mode 100644
index 0000000000..881720ed6e
--- /dev/null
+++ b/t/unit-tests/u-string-list.c
@@ -0,0 +1,55 @@
+#include "unit-test.h"
+#include "string-list.h"
+
+static void t_vcreate_string_list_dup(struct string_list *list,
+				      int free_util, va_list ap)
+{
+	const char *arg;
+
+	cl_assert(list->strdup_strings);
+
+	string_list_clear(list, free_util);
+	while ((arg = va_arg(ap, const char *)))
+		string_list_append(list, arg);
+}
+
+static void t_string_list_equal(struct string_list *list,
+				struct string_list *expected_strings)
+{
+	cl_assert_equal_i(list->nr, expected_strings->nr);
+	cl_assert(list->nr <= list->alloc);
+	for (size_t i = 0; i < expected_strings->nr; i++)
+		cl_assert_equal_s(list->items[i].string,
+				  expected_strings->items[i].string);
+}
+
+static void t_string_list_split(const char *data, int delim, int maxsplit, ...)
+{
+	struct string_list expected_strings = STRING_LIST_INIT_DUP;
+	struct string_list list = STRING_LIST_INIT_DUP;
+	va_list ap;
+	int len;
+
+	va_start(ap, maxsplit);
+	t_vcreate_string_list_dup(&expected_strings, 0, ap);
+	va_end(ap);
+
+	string_list_clear(&list, 0);
+	len = string_list_split(&list, data, delim, maxsplit);
+	cl_assert_equal_i(len, expected_strings.nr);
+	t_string_list_equal(&list, &expected_strings);
+
+	string_list_clear(&expected_strings, 0);
+	string_list_clear(&list, 0);
+}
+
+void test_string_list__split(void)
+{
+	t_string_list_split("foo:bar:baz", ':', -1, "foo", "bar", "baz", NULL);
+	t_string_list_split("foo:bar:baz", ':', 0, "foo:bar:baz", NULL);
+	t_string_list_split("foo:bar:baz", ':', 1, "foo", "bar:baz", NULL);
+	t_string_list_split("foo:bar:baz", ':', 2, "foo", "bar", "baz", NULL);
+	t_string_list_split("foo:bar:", ':', -1, "foo", "bar", "", NULL);
+	t_string_list_split("", ':', -1, "", NULL);
+	t_string_list_split(":", ':', -1, "", "", NULL);
+}
-- 
2.50.0

