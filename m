Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61360763F1
	for <git@vger.kernel.org>; Tue, 21 May 2024 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324762; cv=none; b=nPlnfOXquKI98ciIkDA89TouuUaUDwi3F1TqDkp10gs0hn+NulXOc+/mTEGddLxynyhmxZ5VsTEwp/ko5GESfpWSpteAcYtSF4RGgBgmK0fPNF50U97rve7bWtTfOOSwZfCVyQRff13uf8ZriPf8wu2bhg43gSGHA+4rbp8qpeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324762; c=relaxed/simple;
	bh=di+k1fBZdIpNofT0fGdJOTSFrmsio9qOLn9mGrQ2p0U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hcLTaNUZcGyDv6Gk/WfIIJTOF2aXqXYgjfb1KAXG2OCEpI5vYTKmTtFC99QghQdxIhZYnJBzBtOoM1oyHgdjMvY3jMZRr5O2TxCBHENn4UFYeCI7Alz3uI7vFUYTbrjBdMddjXE3d2vDJFn5qRFLSISuPhPym7Pi+64Q+bZ8dNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLsqoSFR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLsqoSFR"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42011507a4eso1524225e9.0
        for <git@vger.kernel.org>; Tue, 21 May 2024 13:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716324759; x=1716929559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lxuXLkqcksihuYPzwMC1S248HdLCp6a2jA8cJbjxLJw=;
        b=aLsqoSFRJMCo4DOYUQ8dUaVXcSFP71ZJ1vbQhKcPnp34YbJdVlWe904kUWJA1Qq5EJ
         0K3IL9mjcPvJO9kNMJjMyMKySCSGeZhUcl6WV8HAknbwGyXRwZCAs2mtqNKR6YYRye9y
         7COy5XKir2VgRWkOpuDh7FH3D7zL5siMoTVKmnxQk6dcOPykgzo6G7R9XIM2Osu7PcRd
         4VTEDghMXAJIsSJeYThh0W1yVGI1fL6bMKYwsTxH1DPaTQ65JqdkPwty0B/OK0DtkxhI
         WUe99YpTX90GB79gYy4QaBQ2x8dIwxRwis5YFkuS2eaH/+IhdfiduA9ClsJddDGZIgMG
         +G3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716324759; x=1716929559;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lxuXLkqcksihuYPzwMC1S248HdLCp6a2jA8cJbjxLJw=;
        b=jjANqg2AtjDw6jeuV5fO+wq8c/zS0qK3wr0MCZeQ1QVb2NP8sS+KSyRTlw2XAV4N2G
         5Rn/NmJ9FLegz4dkbj2dSpxWqtOl4LchfyQc4xOc3FDtJyUGeFI4rorxHr2me8iHccyC
         yfRwI7u+lsuQlUMBlfuaJAgnZsIYTZPA5fn0v7KEjidJMD00gkNwTV8gB187kLTQxO7N
         L2u8uYjx2FUacrRGRmI5KMeoMMdmBrvkFztcxetEeIXVy3+Nq0K9cnLVSTy1yXO1AI4V
         rx09XlvJO4O/Hyt0h3tySMO4syCxY0vFZ/S7T67OCfX/j8+soxK33eP4OnKXZNARPXHO
         fyQg==
X-Gm-Message-State: AOJu0YwqlK0bA8BkfjOsYiu6FcwcgI6E5USXvfVJ+XtNY7ezm+PdRYoU
	H0OyZzzZLzz2yBntENPZYuxypCSn/whYroREONSAg3OOaHjn0Etk9i9G/A==
X-Google-Smtp-Source: AGHT+IHvwO2VUwaq9ts8cOHwAl1Xl65SMh9YcDW0cYqvfWaJ5a/4IHv+rRiosKt2LQcjH1xqCOcSRg==
X-Received: by 2002:a7b:c7c5:0:b0:41b:a301:f2f9 with SMTP id 5b1f17b1804b1-420fd34562emr193165e9.39.1716324758561;
        Tue, 21 May 2024 13:52:38 -0700 (PDT)
Received: from gmail.com (96.red-88-14-210.dynamicip.rima-tde.net. [88.14.210.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce73f5sm480482415e9.21.2024.05.21.13.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 13:52:38 -0700 (PDT)
Message-ID: <310a2904-681a-4bee-96b9-90a2dc107975@gmail.com>
Date: Tue, 21 May 2024 22:52:37 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 5/5] add-patch: render hunks through the pager
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
Content-Language: en-US
In-Reply-To: <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make the print command to trigger the pager when invoked using a capital
'P', to make it easier for the user to review long hunks.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 add-patch.c                | 14 +++++++++++---
 t/t3701-add-interactive.sh | 21 +++++++++++++++++++++
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 2252895c28..d614536cb2 100644
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
@@ -1387,7 +1388,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
    "/ - search for a hunk matching the given regex\n"
    "s - split the current hunk into smaller hunks\n"
    "e - manually edit the current hunk\n"
-   "p - print the current hunk\n"
+   "p - print the current hunk, 'P' to use the pager\n"
    "? - print help\n");
 
 static int patch_update_file(struct add_p_state *s,
@@ -1398,7 +1399,7 @@ static int patch_update_file(struct add_p_state *s,
 	struct hunk *hunk;
 	char ch;
 	struct child_process cp = CHILD_PROCESS_INIT;
-	int colored = !!s->colored.len, quit = 0;
+	int colored = !!s->colored.len, quit = 0, use_pager = 0;
 	enum prompt_mode_type prompt_mode_type;
 	enum {
 		ALLOW_GOTO_PREVIOUS_HUNK = 1 << 0,
@@ -1448,9 +1449,15 @@ static int patch_update_file(struct add_p_state *s,
 		strbuf_reset(&s->buf);
 		if (file_diff->hunk_nr) {
 			if (rendered_hunk_index != hunk_index) {
+				if (use_pager)
+					setup_pager();
 				render_hunk(s, hunk, 0, colored, &s->buf);
 				fputs(s->buf.buf, stdout);
 				rendered_hunk_index = hunk_index;
+				if (use_pager) {
+					wait_for_pager();
+					use_pager = 0;
+				}
 			}
 
 			strbuf_reset(&s->buf);
@@ -1665,8 +1672,9 @@ static int patch_update_file(struct add_p_state *s,
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
index 52d7830de2..4be7a14419 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -558,6 +558,27 @@ test_expect_success 'print again the hunk' '
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
+		test_terminal --no-stdin-pty git add -p >actual
+	) &&
+	tail -n 7 <actual | test_decode_color >actual.trimmed &&
+	test_cmp expect actual.trimmed
+'
+
 test_expect_success 'navigate to hunk via regex' '
 	test_when_finished "git reset" &&
 	tr _ " " >expect <<-EOF &&
-- 
2.45.1.221.gd3c11dbb1d
