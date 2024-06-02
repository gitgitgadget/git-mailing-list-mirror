Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0718D17736
	for <git@vger.kernel.org>; Sun,  2 Jun 2024 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717343079; cv=none; b=k7AsNz2jzpPU2HflpLPPayWxma7FYi0z/7yb62ePBEvwITvQYyHMoc+T4l1i/gM4efziLV4yzJA6vQmXh4YkfQ7Taw4QTWJpd/E4lO0MocRyKoqsj7kgs7In2VrchlA8y4wE0OxRz1LxMxE6HTABDZrTPFAGu0QGUyNVcqAGh98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717343079; c=relaxed/simple;
	bh=bSW15G3g+SVVHJ1OqiggnLfGMkln6BkL0AYO9jazQTo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=drbCozaQ2MaBlQaqTgFCiJIZqie+P5v3AmKt+MARxcWtLrPPssM56GG/LETXQzAtzy7E8fjoFHK7PqO+PmG0YA//0dg5WN0OAVBRuArZV2UUf0MzAdUUw098WiCeaWeUs9qBQDCjh4rmgMM8StwjWLUxChQuiG0yKOC2AJrcgvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWJymA/G; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWJymA/G"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4213870aafdso5555685e9.2
        for <git@vger.kernel.org>; Sun, 02 Jun 2024 08:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717343076; x=1717947876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kuG14p4YsOmz2nPp1ARGD9Q25Fq/m9QJ8lN8+AvaEB8=;
        b=NWJymA/G0zD9ddZ5HHIHIlsmu9m9Nm5XdhXmdU7MnVpYeOboPnpOIH3TohrguSX5yR
         URAsxt4Bg7dACl+fvKJnpIXYARdwQq75mrr4x6G0yee6oxMpeSDyDB6+OB1jtvzGynfr
         uOv6mG/GS8vjQkoe0DSM/eXATQ18kznq6Z0RbWWvrJwMXfgAnRNGHYANq/ACQSHiVc8x
         A4ZJtfu/kgfIwp5ur3PgK4vjP+PB08mbnV4OFohEB09gxinHvwJ1ZIpjYxkOJB3CDuva
         jQhD0ZMFtBQRgLv3GaLAdhqyXK8qyQdO3BFn1XnwBkrX5dbWeb4FDockoyu9Rh30eqIj
         +NUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717343076; x=1717947876;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuG14p4YsOmz2nPp1ARGD9Q25Fq/m9QJ8lN8+AvaEB8=;
        b=YYrWVvYKvo5awUBoyO6dY4p8eIlMPZj4I9P9UPpo4/Lp//QETVjVIn/pwTi6Wbv+Xa
         PeDTvi3M48r5pgXo94vqI2/LpRAPuovQY+UcrZvBp1bmYl7Uf085LP2bM1qi/A0Xejve
         rz0bARdeOz4dVM/AN9bb5pedLsPaIfZA5Wd2hkPTw6fAT8DvdVq2VTJWalu/riEldGSE
         /S823b6SrDt2xBLryIzhrcuGW5YujxgW4mdqMlgiRFcv3gvo4RxLKt0lvzOFs92IYxia
         aBFRw8tigEwCmPgAom0fD1cf0g2Xu6ULYrjGo4EWsbD8eRaH9oYZaC0LRsWtR8ZsXLCP
         v6ew==
X-Gm-Message-State: AOJu0Yz+gEyRvYrTsvCIUx8YZYQSdh1zXDQgfY6HqaW3VkEcm7gvrcOP
	htFxlXVrKAqNEI8z3wgbU0Sgkqe/GAKR5gXlXDbvXR8qSKLKpLTICy/Cww==
X-Google-Smtp-Source: AGHT+IGHAHpe85N5helGdkxomKXkpKeQyrAI1hsBioogm0PJHBX5ugzkJfqaCUUTjLq7dwWPgrR2+g==
X-Received: by 2002:a05:600c:4e52:b0:420:2986:ccee with SMTP id 5b1f17b1804b1-4212e0a5363mr57263145e9.30.1717343076188;
        Sun, 02 Jun 2024 08:44:36 -0700 (PDT)
Received: from gmail.com (12.red-88-14-51.dynamicip.rima-tde.net. [88.14.51.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b8a4c88sm87423205e9.31.2024.06.02.08.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 08:44:35 -0700 (PDT)
Message-ID: <8dbbfd1d-0e74-4423-9c8b-3a40df3b78c1@gmail.com>
Date: Sun, 2 Jun 2024 17:44:35 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 6/6] add-patch: introduce the command '|'
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
Content-Language: en-US
In-Reply-To: <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce a new command: '|', to send the current hunk to a program.

If no program is specified, default to the pager.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 add-patch.c                | 17 ++++++++++--
 t/t3701-add-interactive.sh | 55 ++++++++++++++++++++++++++------------
 2 files changed, 53 insertions(+), 19 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 814de57c4a..5a586d1b9b 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -5,6 +5,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "object-name.h"
+#include "pager.h"
 #include "read-cache-ll.h"
 #include "repository.h"
 #include "strbuf.h"
@@ -1389,6 +1390,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
    "s - split the current hunk into smaller hunks\n"
    "e - manually edit the current hunk\n"
    "p - print the current hunk\n"
+   "| - pipe the current hunk to the pager, or |<program> to use a program'\n"
    "? - print help\n");
 
 static int patch_update_file(struct add_p_state *s,
@@ -1401,6 +1403,7 @@ static int patch_update_file(struct add_p_state *s,
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int colored = !!s->colored.len, quit = 0;
 	enum prompt_mode_type prompt_mode_type;
+	const char* pager = NULL;
 	enum {
 		ALLOW_GOTO_PREVIOUS_HUNK = 1 << 0,
 		ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK = 1 << 1,
@@ -1449,9 +1452,15 @@ static int patch_update_file(struct add_p_state *s,
 		strbuf_reset(&s->buf);
 		if (file_diff->hunk_nr) {
 			if (rendered_hunk_index != hunk_index) {
+				if (pager)
+					setup_custom_pager(pager);
 				render_hunk(s, hunk, 0, colored, &s->buf);
 				fputs(s->buf.buf, stdout);
 				rendered_hunk_index = hunk_index;
+				if (pager) {
+					wait_for_pager();
+					pager = NULL;
+				}
 			}
 
 			strbuf_reset(&s->buf);
@@ -1485,6 +1494,7 @@ static int patch_update_file(struct add_p_state *s,
 				strbuf_addstr(&s->buf, ",e");
 			}
 			strbuf_addstr(&s->buf, ",p");
+			strbuf_addstr(&s->buf, ",|");
 		}
 		if (file_diff->deleted)
 			prompt_mode_type = PROMPT_DELETION;
@@ -1512,8 +1522,8 @@ static int patch_update_file(struct add_p_state *s,
 			continue;
 		ch = tolower(s->answer.buf[0]);
 
-		/* 'g' takes a hunk number and '/' takes a regexp */
-		if (s->answer.len != 1 && (ch != 'g' && ch != '/')) {
+		/* 'g' takes a hunk number, '/' takes a regexp and '|' takes a program */
+		if (s->answer.len != 1 && (ch != 'g' && ch != '/' && ch != '|')) {
 			err(s, _("Only one letter is expected, got '%s'"), s->answer.buf);
 			continue;
 		}
@@ -1674,6 +1684,9 @@ static int patch_update_file(struct add_p_state *s,
 			}
 		} else if (s->answer.buf[0] == 'p') {
 			rendered_hunk_index = -1;
+		} else if (ch == '|') {
+			rendered_hunk_index = -1;
+			pager = s->answer.buf + 1;
 		} else if (s->answer.buf[0] == '?') {
 			const char *p = _(help_patch_remainder), *eol = p;
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 6f6d174687..7b3ebb671d 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -64,8 +64,8 @@ test_expect_success 'unknown command' '
 	git add -N command &&
 	git diff command >expect &&
 	cat >>expect <<-EOF &&
-	(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
-	(1/1) Stage addition [y,n,q,a,d,e,p,?]?$SP
+	(1/1) Stage addition [y,n,q,a,d,e,p,|,?]? Unknown command ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
+	(1/1) Stage addition [y,n,q,a,d,e,p,|,?]?$SP
 	EOF
 	git add -p -- command <command >actual 2>&1 &&
 	test_cmp expect actual
@@ -348,9 +348,9 @@ test_expect_success 'different prompts for mode change/deleted' '
 	git -c core.filemode=true add -p >actual &&
 	sed -n "s/^\(([0-9/]*) Stage .*?\).*/\1/p" actual >actual.filtered &&
 	cat >expect <<-\EOF &&
-	(1/1) Stage deletion [y,n,q,a,d,p,?]?
-	(1/2) Stage mode change [y,n,q,a,d,j,J,g,/,p,?]?
-	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]?
+	(1/1) Stage deletion [y,n,q,a,d,p,|,?]?
+	(1/2) Stage mode change [y,n,q,a,d,j,J,g,/,p,|,?]?
+	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,|,?]?
 	EOF
 	test_cmp expect actual.filtered
 '
@@ -537,13 +537,13 @@ test_expect_success 'split hunk setup' '
 test_expect_success 'goto hunk 1 with "g 1"' '
 	test_when_finished "git reset" &&
 	tr _ " " >expect <<-EOF &&
-	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? + 1:  -1,2 +1,3          +15
+	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,|,?]? + 1:  -1,2 +1,3          +15
 	_ 2:  -2,4 +3,8          +21
 	go to which hunk? @@ -1,2 +1,3 @@
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,|,?]?_
 	EOF
 	test_write_lines s y g 1 | git add -p >actual &&
 	tail -n 7 <actual >actual.trimmed &&
@@ -556,7 +556,7 @@ test_expect_success 'goto hunk 1 with "g1"' '
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,|,?]?_
 	EOF
 	test_write_lines s y g1 | git add -p >actual &&
 	tail -n 4 <actual >actual.trimmed &&
@@ -566,11 +566,11 @@ test_expect_success 'goto hunk 1 with "g1"' '
 test_expect_success 'navigate to hunk via regex /pattern' '
 	test_when_finished "git reset" &&
 	tr _ " " >expect <<-EOF &&
-	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? @@ -1,2 +1,3 @@
+	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,|,?]? @@ -1,2 +1,3 @@
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,|,?]?_
 	EOF
 	test_write_lines s y /1,2 | git add -p >actual &&
 	tail -n 5 <actual >actual.trimmed &&
@@ -583,7 +583,7 @@ test_expect_success 'navigate to hunk via regex / pattern' '
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,|,?]?_
 	EOF
 	test_write_lines s y / 1,2 | git add -p >actual &&
 	tail -n 4 <actual >actual.trimmed &&
@@ -595,17 +595,38 @@ test_expect_success 'print again the hunk' '
 	tr _ " " >expect <<-EOF &&
 	+15
 	 20
-	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? @@ -1,2 +1,3 @@
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,|,?]? @@ -1,2 +1,3 @@
 	 10
 	+15
 	 20
-	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,|,?]?_
 	EOF
 	test_write_lines s y g 1 p | git add -p >actual &&
 	tail -n 7 <actual >actual.trimmed &&
 	test_cmp expect actual.trimmed
 '
 
+test_expect_success TTY 'print again the hunk (PAGER)' '
+	test_when_finished "git reset" &&
+	cat >expect <<-EOF &&
+	<GREEN>+<RESET><GREEN>15<RESET>
+	 20<RESET>
+	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,|,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
+	PAGER  10<RESET>
+	PAGER <GREEN>+<RESET><GREEN>15<RESET>
+	PAGER  20<RESET>
+	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,|,?]? <RESET>
+	EOF
+	test_write_lines s y g 1 \| |
+	(
+		GIT_PAGER="sed s/^/PAGER\ /" &&
+		export GIT_PAGER &&
+		test_terminal --no-stdin-pty git add -p >actual
+	) &&
+	tail -n 7 <actual | test_decode_color >actual.trimmed &&
+	test_cmp expect actual.trimmed
+'
+
 test_expect_success 'split hunk "add -p (edit)"' '
 	# Split, say Edit and do nothing.  Then:
 	#
@@ -780,21 +801,21 @@ test_expect_success 'colors can be overridden' '
 	<BLUE>+<RESET><BLUE>new<RESET>
 	<CYAN> more-context<RESET>
 	<BLUE>+<RESET><BLUE>another-one<RESET>
-	<YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,p,?]? <RESET><BOLD>Split into 2 hunks.<RESET>
+	<YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,p,|,?]? <RESET><BOLD>Split into 2 hunks.<RESET>
 	<MAGENTA>@@ -1,3 +1,3 @@<RESET>
 	<CYAN> context<RESET>
 	<BOLD>-old<RESET>
 	<BLUE>+<RESET><BLUE>new<RESET>
 	<CYAN> more-context<RESET>
-	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET><MAGENTA>@@ -3 +3,2 @@<RESET>
+	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,|,?]? <RESET><MAGENTA>@@ -3 +3,2 @@<RESET>
 	<CYAN> more-context<RESET>
 	<BLUE>+<RESET><BLUE>another-one<RESET>
-	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? <RESET><MAGENTA>@@ -1,3 +1,3 @@<RESET>
+	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,|,?]? <RESET><MAGENTA>@@ -1,3 +1,3 @@<RESET>
 	<CYAN> context<RESET>
 	<BOLD>-old<RESET>
 	<BLUE>+new<RESET>
 	<CYAN> more-context<RESET>
-	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET>
+	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,|,?]? <RESET>
 	EOF
 	test_cmp expect actual
 '
-- 
2.45.0.97.g9fa538478d
