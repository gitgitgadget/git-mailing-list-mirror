Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54637282FD
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074939; cv=none; b=kPCs47RHtPboC5+vVwGhwcRBpgZ2UK6OXIiapGGcExDAtMPZG/WB2wzX+pbmPZ76/V4HckemMDL8diRpfWlxsiNiNI6nSUXdfWEQuLY6hcHSlJvXblLmemP0rfY7k/C8KoAtC47XsFHpr+ohPAaQgmITD+lgJSge9AkEaAJEZns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074939; c=relaxed/simple;
	bh=3O1ErOTE2plHq5W6G1NNhtwDA8QxC50/Tox6k4dIpHE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nw+99eazlUY3oE+GXpmmCfgek+AUApQJYl7OrpJIN+igA94QIqfKuqPdKjZg/tiAZIUrPsyzJGj5/eWYMSNeyGO98b9lmjd29Ls+fzRwp4uGZgIw+stHetGJv6zIq5XhUus5YSSI08AYpvEbtsAdLo/3b9jFERaJu1uLaXgfQj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csdX/jYq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csdX/jYq"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fb0d7e4ee9so31330835ad.3
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 13:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721074938; x=1721679738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GvPAK4REs1Px4s/o8a09L1Zr+qkB4/XRs6ylZVJnksI=;
        b=csdX/jYqIZRxEl05DxR8hmK4CZpfxvDQsQHZHZRUok9jVjcJNDM3S+CMo/tZsjL7hr
         de0lVcS5K8HHA+iE7Dx3+TA0TTM9Y/7mZSM61zVgj11YDKi4uj+AVHubo5k6yKqAhzd0
         bTA9zu7WJ7TssvP2uGVY+xugrqVWd3hp0sMtGePuqXuJMYq6hIEjU0qk8idwz3dvAV/5
         DzFQ92wDhNKNSHoofynuHQR9zC27BKGLpwx5AeDNziyQvEsNFtih1lCofoNXB8pexjX5
         u0i6VAsPOoEWLAEOt0vgLMuPLPoULIlFw3ED3BL6aqWX5inXYsHCUICNKrDuCp/do+Bm
         zwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721074938; x=1721679738;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvPAK4REs1Px4s/o8a09L1Zr+qkB4/XRs6ylZVJnksI=;
        b=pdGZeJgvODDeNlq+OIRLFVKS6PR128zjxoGtxjZ9cqhjxdyUmpcA8utnnf7PZ1vcct
         YnzZ6FWALwJwbyrCfpGys/hvPNu4pPlOW3QM6m3E68zXN5oZF8FHfPWrwKsd/6q+gx5/
         sRDeGaTmwrZW2Zz6fJLdUkBKVde8I/UmHczm8skdxIPE3nb+o7OVvoPvAaVbctkjZy8n
         JpAnZVFzyLIOAaSF2wvvbsEBNnYEfS0JXjebJ7sR0n/oQeWRyFUImwPiPmRnmimuCw7Z
         W66qYtLoifGw/Ij9p8w4mB2Jn79lJH3uN633ndfdP0VAFTICFgQi3+O2UHlf19+3JPD2
         lylQ==
X-Gm-Message-State: AOJu0Yzc93CzffqEi8p6SS4zRiViCJoGM9L1uQPfaBQ9LiUP2hA7Qpb0
	tuQslt0Wgdh/oNIVBg8QFOreZpC75Kx+jRlz2MtDOUjhv4D8SA9v2Pj3Zw==
X-Google-Smtp-Source: AGHT+IHIN3oy/tpPqaJQ4DuXMCw90GSw6HOdqEYbnroHIEhTpXxGHR25+VD+mJJOMlct61Dytsnx3w==
X-Received: by 2002:a17:902:cf03:b0:1f9:c289:737c with SMTP id d9443c01a7336-1fbb6f0a0eemr169949795ad.60.1721074937501;
        Mon, 15 Jul 2024 13:22:17 -0700 (PDT)
Received: from gmail.com (p4453252-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.169.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb6fb1asm44936785ad.23.2024.07.15.13.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 13:22:17 -0700 (PDT)
Message-ID: <9ad2200b-46b2-40b8-abb6-5bc0c1d1684a@gmail.com>
Date: Tue, 16 Jul 2024 05:22:14 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 4/4] add-patch: render hunks through the pager
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <a70bddd4-ef2d-488e-a2cf-48515f5df357@gmail.com>
Content-Language: en-US
In-Reply-To: <a70bddd4-ef2d-488e-a2cf-48515f5df357@gmail.com>
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
index 6daf3a6be0..c60589cb94 100755
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
+test_expect_success TTY 'P handles SIGPIPE when writing to pager' '
+	test_when_finished "rm -f huge_file; git reset" &&
+	printf "\n%2500000s" Y >huge_file &&
+	git add -N huge_file &&
+	test_write_lines P q | GIT_PAGER="head -n 1" test_terminal git add -p
+'
+
 test_expect_success 'split hunk "add -p (edit)"' '
 	# Split, say Edit and do nothing.  Then:
 	#
-- 
2.46.0.rc0.4.g229d67bbd7
