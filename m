Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A1626AD3
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720973065; cv=none; b=S+s8pFt6aRbcb38x+Y4zf8WFJagYwReHfS7TRCZdPhnFCvO0ZNps7pPLW3y+msefxWZKIRhJOQ2L+VgWh+r39cjEo94PPAJ7e91BWcQv+C8pHnuQTImJwUDiHDbi36twcwyfB8+9rfV54FwNQ9Os8NUxEi7/dm6m/yG+6XyZHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720973065; c=relaxed/simple;
	bh=p8LCW7iiwE2ajuCerFvulRJiMfzHzkJkqoz+BljPqPk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=E5iEG3Ss0Oh9gTRSFaE25FUZDbxwrgG//jZTfMxJZhherXp1iyGr2W1pylauE7zgvI/YPl6BDeKQgkYxvAFRk3+UIvoJtscB6i1H3VqncDQNpH6lvBJBdj+CSN98EmuIGt6/WGy6vv90F0Z2uQfxpDf47tayq+QxaXKYS0KW1nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgwRehcR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgwRehcR"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fbfb7cdb54so11370015ad.2
        for <git@vger.kernel.org>; Sun, 14 Jul 2024 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720973063; x=1721577863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IkA0CUXrddYzrJOg8A/I9AiX9zcgmQMc9XHVhkbX+jw=;
        b=UgwRehcRio+lLuWVpwWcp+UVI8EVBJxUATUEVJuas5rdkjYjbi3+Ew3sw4QO1sbt5Q
         laArRGhixQSW+rAHMn6smE3wtItpRbm0qhyrY0DkqvIh1FxHDOtWvFbr/RRbVYS/FdJm
         myjMLtd32quTnzdTH/ctK9hmaC31PkAffnY6BqfNM4PRVKqcwog2redgaLtX0q9g0zO9
         B3lN+11CHNC9OZvGb84LvEB33nqKbKhAwh1QGT8X+PtHgH1LvnjO2XqUuSIn9WGlV3HG
         J4BXWjtER1DEEHRHhNUuJZaliS2nW4OuOYcYduitBKOagM2N2Mqm12/7j6CpWPyYmUzE
         DmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720973063; x=1721577863;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IkA0CUXrddYzrJOg8A/I9AiX9zcgmQMc9XHVhkbX+jw=;
        b=ciRh/THnKHxszUt8jl7SlO5Z6b0YBIL82sCj6q+JtvbkzJpF1+dph6Ev1SwrPcf1Wm
         H2LPY7sTzDaZkwy05rh4i6tuK4RDEM9YlSdPagNB+uWHA3+WylBCeGPePmD3gz8j9Ox4
         GTNTHDsFmg3cjEXfAAa+FpFvq+YserxSlxBsdAxERkIx0uJqo+zg0b2G401bPkEv9XTo
         tZAoXuoJy52BS1pfWNNFnErM+qsrOxmFPqk6vkwwl+rWZ2tHs9z5j2J3cJHlxkjG85Zo
         KwsAke86xDasxO0UC5Iej/9BPyCwt3IjbSMnZHD1c3t/NnRwNF8ITBkPaSftDE3ajtiR
         6cYA==
X-Gm-Message-State: AOJu0YyJXCNsvsYbtLcK30DKLvmYuzYPuJulze3QPdqRcEasOAffBSV0
	KEKMjX8qvRS46wucEa0yJhFTCet+FYEB3B5Zskd1LUQUyKP/wJRvWk4riA==
X-Google-Smtp-Source: AGHT+IFbpWqJ5wQyBuvXENQ/+8R+A+O8IkL7pfqz2XbYG42V92EuluDHj2Nzc06uhilnfAX5x0B40Q==
X-Received: by 2002:a17:902:e5ca:b0:1fb:484a:d0 with SMTP id d9443c01a7336-1fbb6ea43b7mr136273245ad.54.1720973062880;
        Sun, 14 Jul 2024 09:04:22 -0700 (PDT)
Received: from gmail.com (p4357013-ipoe.ipoe.ocn.ne.jp. [123.222.98.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bbbf9c4sm25068305ad.98.2024.07.14.09.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 09:04:22 -0700 (PDT)
Message-ID: <1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com>
Date: Mon, 15 Jul 2024 01:04:18 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 4/4] add-patch: render hunks through the pager
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
Content-Language: en-US
In-Reply-To: <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make the print command trigger the pager when invoked using a capital
'P', to make it easier for the user to review long hunks.

Note that if the PAGER ends unexpectedly before we've been able to send
the payload, perhaps because the user is not interested in the whole
thing, we might receive a SIGPIPE, which would abruptly and unexpectedly
terminate the interactive session for the user.

Therefore, we need to ignore a possible SIGPIPE signal.  Add a test for
this, in addition to the test for normal operation.

For the SIGPIPE test, we need to make sure that we completely fill the
operating system's buffer, otherwise we might not trigger the SIGPIPE
signal.  The normal size of this buffer in different OSs varies from a
few KBs to 1MB.  Use a payload large enough to guarantee that we exceed
this limit.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 add-patch.c                | 18 +++++++++++++++---
 t/t3701-add-interactive.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 3 deletions(-)

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
index 6daf3a6be0..2ac860cc42 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -591,6 +591,34 @@ test_expect_success 'print again the hunk' '
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
+test_expect_success TTY 'P does not break if pager ends unexpectedly' '
+	test_when_finished "rm -f huge_file; git reset" &&
+	printf "\n%2500000s" Y >huge_file &&
+	git add -N huge_file &&
+	test_write_lines P q | GIT_PAGER="head -n 1" test_terminal git add -p >actual
+'
+
 test_expect_success 'split hunk "add -p (edit)"' '
 	# Split, say Edit and do nothing.  Then:
 	#
-- 
2.46.0.rc0.4.g913e7f3d09
