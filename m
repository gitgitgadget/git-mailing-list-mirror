Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FCF10E9
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 01:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720746054; cv=none; b=UKCUVz33UjhHLJCbhqEoBeWIvMqFLl2PvUmW7AJN4/ictRFsX1B+4d5fpA17GGDj091U+X2i7lx29cIZ0ok1413AzpE2Fyi/yhiAZUSzzBNrk6C8OKc9LsKKrP+zMaAAGvgBKLLATgUYgQK0vnbffap1wx+eTCBSlkRT7bZcxdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720746054; c=relaxed/simple;
	bh=IocAn3QdAZZdfiPTYqrCUs8kspnsG4E5Ghv0+2JhKCQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dmcjwXUltlt5tARDZhZe5Ez4QeKJXN8i5jpQUqfv+oD6/LZW5ev49Jm8h1Ge+IrAxUsIEQ1w7mrt6lYHL5BYdKcQ5gxs3WTc8ttmGOcqnREllrj8UzjxEWy3R36YSUf2yN6JQf+jrGfLPBUGuT7/HnXPRavbpRj7oMVhxwLbZvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmVe1xlW; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmVe1xlW"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-375af3538f2so5798615ab.3
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 18:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720746052; x=1721350852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9CRxaq3bF1Ug2b9v12SMlvjREeqlUde/obnHVSoHnjc=;
        b=VmVe1xlWe4gze6XdB+0zr9hgPtg2/JZXUpBmo3GndfsQKhAOMZveGMaH2eCUaTCnzH
         YlW3PecPzP9Y9+zbPSceR9DHAx2lAT2U30+yieXp3bhSqDn5G/i219h2TdVRvTneTKCy
         oBF5Poxe+9kV1epPVWIpkzgxhKzVB/M2SCNxYVsVwnMtzGHCzlkyHwgyJ25ZgoXYHCaw
         KPkTZXO4txpKZq65qqvz59z6g8/szqj7bSTKCsWxIxyW7u+yiYgRskM4uy1cDpFeh4FV
         XfX83LtwAiEKcVPuSZRqOFSepqqJSvNt6g4P7/tyhge61fybkIW+a6wV5LepyH7XWr/G
         ZULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720746052; x=1721350852;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9CRxaq3bF1Ug2b9v12SMlvjREeqlUde/obnHVSoHnjc=;
        b=JGpNyUo7Aazbia0ijy5neA4e6q8WS8lA8891BN3xqO6mDnRV8MtqL2qNW9w/8Zdif6
         97yNFOvnvzATWLOkYNyH7Sgp/w+Se7WOFnYYuQkX+hP8fIBxWNykaQtaNfawbpdYUyTj
         49aYyJAl+Mx0NXA1BNIPrBL5dHFaUFCBcKu5v45/0WOjmKWZawuyRWWxb5wUC7s3/yEL
         tIbwCNgt0Q9CWSFw4WGiaXZBSjtmHtcgRYAsODe8mAej6/s73mv8fI9LlEcaa1rjYsb0
         JmD+TQqpBNSl78yvGyDlhxSYiR5gpmfg+K8wEenD+uGtnY2veSwEO0Ja+ehiDRCStOIh
         QDZA==
X-Gm-Message-State: AOJu0YwE1aorIerng4JYSmtBFnvfxQJXOjlmUQLC//sPZ87zpOdKUlMf
	Q9XywBhJbGfhFNzkd9NwLjpgiY2v57Lgu3HLkOR2rnFSGAH1jruOKVLo+g==
X-Google-Smtp-Source: AGHT+IFFOQqyZxEsq7nfHwv69SsSLqyxQptgfJwjt/gg0Wb5xrKvKUGT04K5/cDuNmvI8HeoA0jGlg==
X-Received: by 2002:a05:6e02:b49:b0:383:284:113 with SMTP id e9e14a558f8ab-38a57214449mr126898985ab.4.1720746051638;
        Thu, 11 Jul 2024 18:00:51 -0700 (PDT)
Received: from gmail.com (p4357013-ipoe.ipoe.ocn.ne.jp. [123.222.98.12])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d5f0ab0d8sm4909240a12.19.2024.07.11.18.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 18:00:51 -0700 (PDT)
Message-ID: <5effca4d-536c-4e51-a024-5f1e90583176@gmail.com>
Date: Fri, 12 Jul 2024 10:00:48 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/4] add-patch: render hunks through the pager
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
Content-Language: en-US
In-Reply-To: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make the print command to trigger the pager when invoked using a capital
'P', to make it easier for the user to review long hunks.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 add-patch.c                | 18 +++++++++++++---
 t/t3701-add-interactive.sh | 44 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 6e176cd21a..f2c76b7d83 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -7,9 +7,11 @@
 #include "environment.h"
 #include "gettext.h"
 #include "object-name.h"
+#include "pager.h"
 #include "read-cache-ll.h"
 #include "repository.h"
 #include "strbuf.h"
+#include "sigchain.h"
 #include "run-command.h"
 #include "strvec.h"
 #include "pathspec.h"
@@ -1391,7 +1393,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
    "/ - search for a hunk matching the given regex\n"
    "s - split the current hunk into smaller hunks\n"
    "e - manually edit the current hunk\n"
-   "p - print the current hunk\n"
+   "p - print the current hunk, 'P' to use the pager\n"
    "? - print help\n");
 
 static int patch_update_file(struct add_p_state *s,
@@ -1402,7 +1404,7 @@ static int patch_update_file(struct add_p_state *s,
 	struct hunk *hunk;
 	char ch;
 	struct child_process cp = CHILD_PROCESS_INIT;
-	int colored = !!s->colored.len, quit = 0;
+	int colored = !!s->colored.len, quit = 0, use_pager = 0;
 	enum prompt_mode_type prompt_mode_type;
 	enum {
 		ALLOW_GOTO_PREVIOUS_HUNK = 1 << 0,
@@ -1452,9 +1454,18 @@ static int patch_update_file(struct add_p_state *s,
 		strbuf_reset(&s->buf);
 		if (file_diff->hunk_nr) {
 			if (rendered_hunk_index != hunk_index) {
+				if (use_pager) {
+					setup_pager();
+					sigchain_push(SIGPIPE, SIG_IGN);
+				}
 				render_hunk(s, hunk, 0, colored, &s->buf);
 				fputs(s->buf.buf, stdout);
 				rendered_hunk_index = hunk_index;
+				if (use_pager) {
+					sigchain_pop(SIGPIPE);
+					wait_for_pager();
+					use_pager = 0;
+				}
 			}
 
 			strbuf_reset(&s->buf);
@@ -1675,8 +1686,9 @@ static int patch_update_file(struct add_p_state *s,
 				hunk->use = USE_HUNK;
 				goto soft_increment;
 			}
-		} else if (s->answer.buf[0] == 'p') {
+		} else if (ch == 'p') {
 			rendered_hunk_index = -1;
+			use_pager = (s->answer.buf[0] == 'P') ? 1 : 0;
 		} else if (s->answer.buf[0] == '?') {
 			const char *p = _(help_patch_remainder), *eol = p;
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 6daf3a6be0..bf82a9dc35 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -591,6 +591,50 @@ test_expect_success 'print again the hunk' '
 	test_cmp expect actual.trimmed
 '
 
+test_expect_success TTY 'print again the hunk (PAGER)' '
+	test_when_finished "git reset" &&
+	cat >expect <<-EOF &&
+	<GREEN>+<RESET><GREEN>15<RESET>
+	 20<RESET>
+	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
+	PAGER  10<RESET>
+	PAGER <GREEN>+<RESET><GREEN>15<RESET>
+	PAGER  20<RESET>
+	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET>
+	EOF
+	test_write_lines s y g 1 P |
+	(
+		GIT_PAGER="sed s/^/PAGER\ /" &&
+		export GIT_PAGER &&
+		test_terminal git add -p >actual
+	) &&
+	tail -n 7 <actual | test_decode_color >actual.trimmed &&
+	test_cmp expect actual.trimmed
+'
+
+test_expect_success TTY 'P does not break if pager ends unexpectly' '
+	test_when_finished "rm -f huge_file; git reset" &&
+	printf "%2500000s" Y >huge_file &&
+	git add -N huge_file &&
+	cat >expect <<-EOF &&
+	<GREEN>+<RESET><GREEN>22<RESET>
+	<GREEN>+<RESET><GREEN>23<RESET>
+	<GREEN>+<RESET><GREEN>24<RESET>
+	 30<RESET>
+	 40<RESET>
+	 50<RESET>
+	<BOLD;BLUE>(1/1) Stage this hunk [y,n,q,a,d,s,e,p,?]? <RESET>
+	EOF
+	test_write_lines P |
+	(
+		GIT_PAGER="head -1" &&
+		export GIT_PAGER &&
+		test_terminal git add -p >actual
+	) &&
+	tail -n 7 <actual | test_decode_color >actual.trimmed &&
+	test_cmp expect actual.trimmed
+'
+
 test_expect_success 'split hunk "add -p (edit)"' '
 	# Split, say Edit and do nothing.  Then:
 	#
-- 
2.45.1
