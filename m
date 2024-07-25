Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63D719DF65
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721925830; cv=none; b=GXiPSMf7dAUnddevEeyRnvv/ElpBcmzujTYjQdpExNn3ECG8e02UZU5/PJUG9+FVqmwh/Y0LunKx7p2SlF3Nnwd6Eyte+/y3EmnvIwhNTLY0heB/pAQuXiJw2Dv53XLwcz/C+v0nlBJ7D3AISWAG99peKNRCLCTzBGlBMWvHVY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721925830; c=relaxed/simple;
	bh=RcgqOmxQz/XsULQCM1qmrot+j6Us2CihO8YlaZRloGE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sE40lr3Z1zEIeF0E+slv/wbpFyrEOd8FP8ZmHBr6ZwRQ7goqb8/74+o3RhBg5b4mABiqfRtwsEo+pm3eK00n80OeRrzVrlKQ31YBM/EHg77v7nzab6l0/qo2wI4wRRQY63OTy/53duXSH8UmUhpBgxaYgaxi1pgvws0glDX8Xnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTsC0+J9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTsC0+J9"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4280854e236so4918965e9.2
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 09:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721925827; x=1722530627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QFb2+t1cSyX57jpOf3Wn0GTkcW42bAs8kxh1RVDAB0Q=;
        b=VTsC0+J94nkjKm+IjqBw/tQnz5sLnvlXHJwP4kCQ6TPzPdfqk37X6zObyySMUYmJGH
         GPgQgGRNZLp05cwTy9RzXzrVodyTh6UQ9J434XJVXpBBdg/wkxPeTnTJ7Ix3aBTElKPn
         oBJcD3TXaXokCZUoJPIp99g6VzS1wRiwwfRAW0ayd6hevNrKXtAGy9XNL1Y7TIRZjzpv
         v/EMWKlxhsJBffFZjV+Uqv8Mc81WqJcnnmAol/S1z2+V/Id8KHPw0B8sd6UPyPrrJXa+
         21ARotG8TVGWJ1Ya/VDDAZVhmYpw6hXZmo4ikEpXN39tUsF+MqQoUUzMQcw+i7cCDocH
         xEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721925827; x=1722530627;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFb2+t1cSyX57jpOf3Wn0GTkcW42bAs8kxh1RVDAB0Q=;
        b=pHLkQkg4kxru/kreYDkCQ664h0UOmRSJiBmunqM4IKL8O16QyyPTNeynuSlJcLB7u5
         qW51U+0eBKMB78wWfyjr72mdSZNAEqimAYTXrTMAjn4vNtD3jBPtKW8knrpqv+e8lSmx
         Spz+hZqKu4RYzmnCp/cMUXjQqjIOm0p34OXhXYRxspWjpRQMrSiuPDSHrX3RX8eDrQrN
         K7ucWVLuRTsNvhbQVV8nyP057ezZSMi8C7nmqUTtCNceKVVLs9xY9hx6VnNBGYBMacwA
         YGn//xKCRbB1tIJtmESzkBithrHLkw59vggspLj40lU4EgzeSc26bNGboej5sPDILpy9
         wx1g==
X-Forwarded-Encrypted: i=1; AJvYcCVpjJjgKEu224CTaiaZXjxASMVlcSBk7wTB4A6jwVo5ztJySH98vg6QRDlDaE9YT7XQNDfK28Fzzvw2WVpbaYfLk5bK
X-Gm-Message-State: AOJu0YybJqCrBigI49Dl6XokNbduMRueIwAnBtMEgwxno8lMKFzwGyXm
	eitVXVfnHSDilMlqpdaFfhze0RUMtPBQmODXGgrd/XXlbHz2e84jZIz5TA==
X-Google-Smtp-Source: AGHT+IETLLtNIcquavxFYijNsz9+QrQakPE3BPkCCqQLAJa4Pru1iYMBrkfLk6tvkWpborzkBKGubg==
X-Received: by 2002:a05:600c:3b87:b0:426:5f8f:51a4 with SMTP id 5b1f17b1804b1-42805703a5cmr19178165e9.12.1721925826458;
        Thu, 25 Jul 2024 09:43:46 -0700 (PDT)
Received: from gmail.com (155.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427fb7bdfa0sm73637625e9.14.2024.07.25.09.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 09:43:46 -0700 (PDT)
Message-ID: <38e190de-cbe4-4f75-acdb-fe566e541179@gmail.com>
Date: Thu, 25 Jul 2024 18:43:45 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] add-patch: render hunks through the pager
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
 <62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
 <2333cb14-f020-451c-ad14-3f30edd152ec@gmail.com>
 <5735bee3-0532-4894-b717-12a0bdcb9e84@gmail.com>
 <a25c37e2-fcfd-4a4c-890b-a85039ccef12@gmail.com>
 <97902c27-63c9-4537-8ebe-853ef0cb1d3b@gmail.com> <xmqqcyn1lcjo.fsf@gitster.g>
 <24e83a0f-b0c8-4cd5-b321-1d7702b844ce@gmail.com>
Content-Language: en-US
In-Reply-To: <24e83a0f-b0c8-4cd5-b321-1d7702b844ce@gmail.com>
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

For the tests, avoid the common construct to set and export one-shot
variables within the scope of a command:

    VAR=VAL command args

It happens that when "command" is a shell function that in turn executes
a "command", the behavior with "VAR" varies depending on the shell:

 ** Bash 5.2.21 **

    $ f () { bash -c 'echo A=$A'; }
    $ A=1 f
    A=1

 ** dash 0.5.12-9 **

    $ f () { bash -c 'echo A=$A'; }
    $ A=1 f
    A=1

 ** dash 0.5.10.2-6 **

    $ f () { bash -c 'echo A=$A'; }
    $ A=1 f
    A=

POSIX explicitly says the effect of this construct is unspecified.

One of our CI jobs on GitHub Actions uses Ubuntu 20.04 running dash
0.5.10.2-6, so avoid using the construct and use a subshell instead.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 add-patch.c                | 18 +++++++++++++++---
 t/t3701-add-interactive.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 3 deletions(-)

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
index 6daf3a6be0..1b8617e0c1 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -591,6 +591,38 @@ test_expect_success 'print again the hunk' '
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
+	test_write_lines P q | (
+		GIT_PAGER="head -n 1" &&
+		export GIT_PAGER &&
+		test_terminal git add -p
+	)
+'
+
 test_expect_success 'split hunk "add -p (edit)"' '
 	# Split, say Edit and do nothing.  Then:
 	#
-- 
2.46.0.rc0.4.g6f4990c0d4
