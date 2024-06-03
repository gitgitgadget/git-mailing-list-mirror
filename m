Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8447A13791B
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 20:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717447126; cv=none; b=E+MwJyaqV6Nbb63TgL/Ny24WYUL7AZeApMGAObRpPgNTBXdB4lA7KjHi82Nr7xNm+5z6r91dM60glV0VHwzPaXIpQSasuRjd4AJybvWKsIAD/IXiD2Iy52bTFJhiDJr6+c4NK7ogcpHfzYXpbFgQdNSODunAaCSXycm2s+o4GRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717447126; c=relaxed/simple;
	bh=LHY27roIN3DCSarVpDprIS9PN9+fkOhsfTZwgcO75ic=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=izwQtB4wmuueVttT3XEzIFV1Q/FewXYka3JeiJG+nNkwx7zCYCGnvuutOUiodBkXhlburQ4wufimJmkwlkUSMcHaTAPVyxDuzI5JtR8OYr8tJt8v4dC08fA/lL3WAz6lYxgdjTJmKwjgHg94OWijnjiZqdmdPUHQEoB7UIOj1hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZDiDFFo; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZDiDFFo"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35dceef429bso2051320f8f.1
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 13:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717447123; x=1718051923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cD1IpnSq0XIbPuWi3/xONlVhm3J33YeM493u89zh2Jg=;
        b=NZDiDFFo9A4tXvsoErdKBJLx1wK6Vx8FziDa8kW0kUyBGpeoRfthf4ayXdI5LypiP/
         DDKHZkVCoLYhR/v2cZoo8tZ9mhnKrkm8Pg0UhsOYT9Z62q41UHS83Pwq1wfr1INsSSY/
         T9JRf/2xSg99JEgX7wRkNLPw1DrsxmK7uifbsdZEyMkiNRDsqscA3VrH0otZ21zonMCo
         rGsewLRp54SKRmATdMJkJH+ehhUb2h2nWTf/VIdjvIVw7ZHf3e0bEn4dhvO8Kg+6rghj
         GQNthC4qgBJYChqfQR24ewVxa/55Vv6C2k50GeCisAjeYlpRvAvZM2RZG1CCvT3QDOWl
         h+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717447123; x=1718051923;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cD1IpnSq0XIbPuWi3/xONlVhm3J33YeM493u89zh2Jg=;
        b=j5IvcPU47+eGGoFc+r1F3EomuK280atzklQP6juBdTi5SBFr52h/xyOva04f+R/XTr
         i3YnPxBwioo9fXc7DAEA8ELYmGFkghTAFdKPhJBAkV8VpqCPaFQvsCr4vxioaFDOYcoS
         Utot84FOtYpwgKENNCfOZU29SdUIemCW2qRcOVh1kV6qO4b/X86JcwgCUoq629EE3ypJ
         /18SewPlGNoQ6MkE4S1Cr80wZXwfzsOqdRd+HgUOP3mfOcxo0LbU914DYiGyoG2wvus4
         zBUJfttUcOx57jLKi9H5woV7HAk97OiG545iWq9uvUlJ/FJIq7H3iL5puvqAskZ/Ioax
         my+A==
X-Gm-Message-State: AOJu0YzAsxE4lyJ1okbkHIGluhik7oMxKGKZB/kHnyF7ld57kU9x/reJ
	y2qbv0X5tq8tUo+DYesgKkKfWu8zcQ1nG1cYFGrBhayYhKmMkh1iA8FKyw==
X-Google-Smtp-Source: AGHT+IGVdrZzap0+Q0073jNTGnuzrlX6wmWmLbxSriDnWTZhe8lidNtztoHX60XiwE1nTgMiU2qv0Q==
X-Received: by 2002:a05:6000:1361:b0:35e:5076:e8ce with SMTP id ffacd0b85a97d-35e7c51a31dmr575119f8f.2.1717447122687;
        Mon, 03 Jun 2024 13:38:42 -0700 (PDT)
Received: from gmail.com (20.red-88-14-43.dynamicip.rima-tde.net. [88.14.43.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04d90a8sm9777670f8f.46.2024.06.03.13.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 13:38:42 -0700 (PDT)
Message-ID: <75a3cc89-4d23-4eae-b0ad-e52e2c8ba550@gmail.com>
Date: Mon, 3 Jun 2024 22:38:41 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 6/6] add-patch: introduce the command '|'
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
Content-Language: en-US
In-Reply-To: <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce a new command '|' to send the current hunk to a program.  If
no program is specified, use the pager.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 add-patch.c                | 25 +++++++++++++++--
 t/t3701-add-interactive.sh | 55 ++++++++++++++++++++++++++------------
 2 files changed, 61 insertions(+), 19 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 814de57c4a..5d8a2f97f9 100644
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
+   "| - use pager to show the current hunk, or use |<program> to customize\n"
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
@@ -1674,6 +1684,17 @@ static int patch_update_file(struct add_p_state *s,
 			}
 		} else if (s->answer.buf[0] == 'p') {
 			rendered_hunk_index = -1;
+		} else if (ch == '|') {
+			strbuf_remove(&s->answer, 0, 1);
+			if (s->s.use_single_key && s->answer.len == 0) {
+				printf("%s", _("program? "));
+				fflush(stdout);
+				strbuf_getline(&s->answer, stdin);
+				strbuf_trim_trailing_newline(&s->answer);
+			}
+			strbuf_trim(&s->answer);
+			pager = s->answer.buf;
+			rendered_hunk_index = -1;
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
2.45.0.97.gb691764a17
