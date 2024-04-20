Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D7AD51C
	for <git@vger.kernel.org>; Sat, 20 Apr 2024 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713611305; cv=none; b=HQuR45eOhZMQykLP3WbkWIeD0GZBmyF8urIHo3G3YMjf3NbUJ9Gl0l4vLkNdicyvevm+OIiV3OAoBnR3wUc3f7V35EuKS8jhpRY1NY99PcqIbNLtObrIBn/GkdPp4YMJjcy+ClugSUCwClaSqTPfN3+1/x1nUlIGmGq8dGOhYCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713611305; c=relaxed/simple;
	bh=PYmaBkfbEwgyxolzUir7bkixwP2KNpoQOT9Dzzs4eH0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=oO6y28lu/Mb0DPJC8TPwiPGRcBfmZcJ6ingmFFe5lnZSPaXZZAI8xGmLftnOdu7oQmAPyCvCfSBzyl5ZH7hMlIuXhisas5zNE0/a+5T2YwOik8q8BuwitJzeNFdpEycT13T2LXZDbXAPIR4Dgl3ATX8Pfr1cVKK/SkybSAlR4R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOxu9k/r; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOxu9k/r"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-346b09d474dso2650942f8f.2
        for <git@vger.kernel.org>; Sat, 20 Apr 2024 04:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713611302; x=1714216102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yqnWseaFI/Kwy5PJpMIOvS/GFQzgu5maCemhJrru1oc=;
        b=fOxu9k/rIUmZ3YTQ8LPASYxkNa7dZKsSIKtxOytZVbSAUqRFapDVjq1oNcqLVfbNC0
         t6ev1wkd78fWDWlba9VJmHPnoRM2FR3ePaxIiaN5tg2LlLCwRYHuDt6cn4yD4Ep7ZTGw
         5mv8slew743vMUmnvHQToj68iLwExXHH7+lokbA839o69PyezUWTPDrYh3fRYwKAG5Uu
         v9Ch6WlFIQz62hpLY8yuI0jD0z60bD3TlytG1siakpBwoXX+o+QziE3gZ9gnVLLzrZ3J
         kmW+YuPRkhwmOb3bZk7gm03lB/+8WVIeM7LW8GXKHY5ABHirUhEYSKrUOGhDu39dRMeb
         x5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713611302; x=1714216102;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yqnWseaFI/Kwy5PJpMIOvS/GFQzgu5maCemhJrru1oc=;
        b=daFlLFpiuuX6Z43cDnw6lryUUwzNZkBu1G7RmZ1f6W4y0i+pslhs7x3BQzdRAb4xO8
         DwP6JJAJxQ6/v8mke6cssH5j82weTeNV6Kooxqexk16XMggBK5PywfCkBCaGbWLmHoIc
         Ti1d0WqXVe+OLdpAarBHUq0h7zq90qLSk0uDD4weI4jD2e+HWJpEMsx7Dc1w/+OJT1N8
         WCIkFNT5+DZ96y5ZpIVkB00OIqKFb13EpxfqCYaujiLDwoQlu2YM+lv8oK++4AbWOveZ
         yJMT19B7pPt2IJumURUZOI92D4yqv2HaHwM2fcNH4cl5xMoEQXwDKSTDtKNTsqW+4QIm
         B3SQ==
X-Gm-Message-State: AOJu0Yxc4neuim0BrJgNStTF0+zYZgE8lljpH15uVsvDu92f4Hu95PnJ
	0umxlU+4lDDTVjcPt3ywifIvTh1pQVqsSlWnk94zCK17b2ENUUYKqrCNJw==
X-Google-Smtp-Source: AGHT+IFJOBMgnkTamLmXN4jxMYuqjWX/rkxsJM9fyFM5cfleiGzUIXZNXN38F3dCuvA0Z0Rt9FjUsQ==
X-Received: by 2002:adf:f0c7:0:b0:343:7653:ad14 with SMTP id x7-20020adff0c7000000b003437653ad14mr4142401wro.30.1713611301530;
        Sat, 20 Apr 2024 04:08:21 -0700 (PDT)
Received: from gmail.com (145.red-88-13-173.dynamicip.rima-tde.net. [88.13.173.145])
        by smtp.gmail.com with ESMTPSA id q12-20020adfcd8c000000b00343cad2a4d3sm6585361wrj.18.2024.04.20.04.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 04:08:21 -0700 (PDT)
Message-ID: <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
Date: Sat, 20 Apr 2024 13:08:14 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] add-patch: response to invalid command
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt
 <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
In-Reply-To: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the user enters an invalid command, we respond with a list of
accepted commands; the response we give to the command '?'.

However, the invalid command may be due to either a user input error or
a malfunctioning interface component, rather than the user not knowing
the valid command.

Our response is unlikely to provide help in such situations.

To reduce the likelihood of user confusion and error repetition, if an
unrecognized command is received, stop displaying the help text and
display a short error message with the invalid command received, as
feedback to the user.

Include a reminder about the current command '?' in the new message, to
guide the user if they want help.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

Changes since v1:

  - Use a temporary file for the lines.
  - Say explicitly in the message that '?' is an existing command.
  - Instead of "option", use "command".
  - Test for stdout, not just stderr.

 add-patch.c                |  5 ++++-
 t/t3701-add-interactive.sh | 23 ++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index a06dd18985..7be142d448 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1667,7 +1667,7 @@ static int patch_update_file(struct add_p_state *s,
 			}
 		} else if (s->answer.buf[0] == 'p') {
 			rendered_hunk_index = -1;
-		} else {
+		} else if (s->answer.buf[0] == '?') {
 			const char *p = _(help_patch_remainder), *eol = p;
 
 			color_fprintf(stdout, s->s.help_color, "%s",
@@ -1691,6 +1691,9 @@ static int patch_update_file(struct add_p_state *s,
 				color_fprintf_ln(stdout, s->s.help_color,
 						 "%.*s", (int)(eol - p), p);
 			}
+		} else {
+			err(s, _("Unknown command '%s' (use '?' for help)"),
+			    s->answer.buf);
 		}
 	}
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index bc55255b0a..4c3901de17 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -7,6 +7,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
+SP=" "
+
 diff_cmp () {
 	for x
 	do
@@ -61,6 +63,26 @@ test_expect_success 'setup (initial)' '
 	echo more >>file &&
 	echo lines >>file
 '
+
+test_expect_success 'unknown command' '
+	test_when_finished "git reset command && rm command" &&
+	echo W >command &&
+	git add -N command &&
+	cat >expect <<-EOF &&
+	diff --git a/command b/command
+	new file mode 100644
+	index 0000000..a42d8ff
+	--- /dev/null
+	+++ b/command
+	@@ -0,0 +1 @@
+	+W
+	(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
+	(1/1) Stage addition [y,n,q,a,d,e,p,?]?$SP
+	EOF
+	git add -p -- command <command >actual 2>&1 &&
+	test_cmp expect actual
+'
+
 test_expect_success 'status works (initial)' '
 	git add -i </dev/null >output &&
 	grep "+1/-0 *+2/-0 file" output
@@ -231,7 +253,6 @@ test_expect_success 'setup file' '
 '
 
 test_expect_success 'setup patch' '
-	SP=" " &&
 	NULL="" &&
 	cat >patch <<-EOF
 	@@ -1,4 +1,4 @@
-- 
2.45.0.rc0.1.gc94c838fad
