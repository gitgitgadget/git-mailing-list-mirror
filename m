Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A605D726
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 21:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400791; cv=none; b=LsMWmKvGNqARP/la0xewMUifPi0VoWG8Arwh05WE2PdXudBZAlRf2XJb4Ldy+8v41Xd9i6JvOKUDQUSR2Q/BV6K0gfKIT5920OOf5AE0/kfhXV2NeKxmyCSe+fWxroG8Mj8oP4ZU2pBBJkr5t7PYc8iDcHKY5hiQOIjkK8RB26k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400791; c=relaxed/simple;
	bh=4rDlWbH829HvlXdB0Nxq48rFninXfwPrBENci0JLhxE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dGnhfbyFB32UT0L8R78VVdQlVsaY5ucDWy3HYGiKoth24HUVgdZdOHUGK7Xx7xWy63Ork9Tl2VbJJos7VjyIpTr80/NAIjLJADE3SwhPV5uLjVSP1ClV9Tx2eGJ1dGuZbZvN+bqYi5oaqHMqXenQcaRMEyTTwPhuLLZAiv1a+jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5R8R3xJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5R8R3xJ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4148e14799eso242125e9.0
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 14:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711400788; x=1712005588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lNQ9uJwEDpA3x93RaEt1Uqc98KlHjieGWL8S+TnFMVg=;
        b=E5R8R3xJ1k4sMD/RnxMOVXuUKDSAOFL05TBzRkK147XtrWPFegnS5isYiW1qXujrAg
         tQ4MZUgJ0IK7CyTnhN16jpxWo5IWW5oLMVnnIThH1WB5ZsxnTuUgeXjOlHWDg1PGVctJ
         Bn0HsE9RP9lMBW+3GZ20pewJVhNxxdR3kPl+hRBvgVRhWlQFNPTQIU52XuxN/WdQTySN
         qR8ulIeBDzlofFVTVKGvMa+inC+YlR28Kotmtih6XZG5kZj+Jnfndqu8h0HjkeeYgjj4
         jDXsYcZPtZGGusl6d0ySFCZ+Pyhx7/2Umda8a0P7u2BBKHf0/CfIliS/fqlTipY6GN+F
         sJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711400788; x=1712005588;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNQ9uJwEDpA3x93RaEt1Uqc98KlHjieGWL8S+TnFMVg=;
        b=REtRr3+tcM2Z+GBmFOlUINQMTrH2Sfo8zUcbPxiW638rbcrQDsz2eJd+O1s8wNfReN
         kSU9hZTYAtoJCtkXT7OZJGXtG+5pdg/guS8ZP9PMArKnHyjB4iEuEGbkPb7Kj1l7yOpI
         3ztH3uBz2C5SoFn/xQsmTBiTzVD8yWpoHyYgM1V/cTbjqQQINSfVcOKllODKh8Gl7q7k
         weJRaSiiN8heuReRXnulveNETAyT/Xa1v0m8dIQU8Rz+Z9dV6d3Xoq9kQa5tUlsuOxcG
         yeUjIoe9lLE4OO8LLsPFl9wx93yEXnEzr/y6Tc1QOJflQjNkaPFsqdfvNhnUphDu5sL6
         Rs3g==
X-Gm-Message-State: AOJu0YygKzThnXvxA3HHRyIcdoSwcRYTVLjhIFwIzTJD57EywEFyGo6j
	POjzXeTIiZGzvOgzywTNU9Pd/xjF7kzBgPeLx5NLR1SPgiyA61a/KrzKv+J4
X-Google-Smtp-Source: AGHT+IEhIdmEmYroISWltNfBkQyWLyJjnl/OzwcInCRv4gubl/yHZpcAq5C1Si5vQEDeFUjTM0+IgQ==
X-Received: by 2002:a05:600c:3113:b0:414:6bda:4735 with SMTP id g19-20020a05600c311300b004146bda4735mr5700675wmo.3.1711400787943;
        Mon, 25 Mar 2024 14:06:27 -0700 (PDT)
Received: from gmail.com (70.red-88-14-202.dynamicip.rima-tde.net. [88.14.202.70])
        by smtp.gmail.com with ESMTPSA id q20-20020a05600c46d400b004147db8a91asm9516791wmo.40.2024.03.25.14.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 14:06:27 -0700 (PDT)
Message-ID: <fa64a975-40e4-40f2-bdcf-fd2da4fc506e@gmail.com>
Date: Mon, 25 Mar 2024 22:05:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] add-patch: introduce 'p' in interactive-patch
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
Content-Language: en-US
In-Reply-To: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Shortly we're going make interactive-patch stop printing automatically
the hunk under certain circumstances.

Let's introduce a new option to allow the user to explicitly request
the printing.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 add-patch.c                |  4 ++++
 t/t3701-add-interactive.sh | 22 +++++++++++-----------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 68f525b35c..52be1ddb15 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1388,6 +1388,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
    "/ - search for a hunk matching the given regex\n"
    "s - split the current hunk into smaller hunks\n"
    "e - manually edit the current hunk\n"
+   "p - print again the current hunk\n"
    "? - print help\n");
 
 static int patch_update_file(struct add_p_state *s,
@@ -1480,6 +1481,7 @@ static int patch_update_file(struct add_p_state *s,
 				permitted |= ALLOW_EDIT;
 				strbuf_addstr(&s->buf, ",e");
 			}
+			strbuf_addstr(&s->buf, ",p");
 		}
 		if (file_diff->deleted)
 			prompt_mode_type = PROMPT_DELETION;
@@ -1658,6 +1660,8 @@ static int patch_update_file(struct add_p_state *s,
 				hunk->use = USE_HUNK;
 				goto soft_increment;
 			}
+		} else if (s->answer.buf[0] == 'p') {
+			/* nothing to do */
 		} else {
 			const char *p = _(help_patch_remainder), *eol = p;
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 0b5339ac6c..bc55255b0a 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -325,9 +325,9 @@ test_expect_success 'different prompts for mode change/deleted' '
 	git -c core.filemode=true add -p >actual &&
 	sed -n "s/^\(([0-9/]*) Stage .*?\).*/\1/p" actual >actual.filtered &&
 	cat >expect <<-\EOF &&
-	(1/1) Stage deletion [y,n,q,a,d,?]?
-	(1/2) Stage mode change [y,n,q,a,d,j,J,g,/,?]?
-	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]?
+	(1/1) Stage deletion [y,n,q,a,d,p,?]?
+	(1/2) Stage mode change [y,n,q,a,d,j,J,g,/,p,?]?
+	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]?
 	EOF
 	test_cmp expect actual.filtered
 '
@@ -514,13 +514,13 @@ test_expect_success 'split hunk setup' '
 test_expect_success 'goto hunk' '
 	test_when_finished "git reset" &&
 	tr _ " " >expect <<-EOF &&
-	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]? + 1:  -1,2 +1,3          +15
+	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? + 1:  -1,2 +1,3          +15
 	_ 2:  -2,4 +3,8          +21
 	go to which hunk? @@ -1,2 +1,3 @@
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]?_
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
 	EOF
 	test_write_lines s y g 1 | git add -p >actual &&
 	tail -n 7 <actual >actual.trimmed &&
@@ -530,11 +530,11 @@ test_expect_success 'goto hunk' '
 test_expect_success 'navigate to hunk via regex' '
 	test_when_finished "git reset" &&
 	tr _ " " >expect <<-EOF &&
-	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]? @@ -1,2 +1,3 @@
+	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? @@ -1,2 +1,3 @@
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]?_
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
 	EOF
 	test_write_lines s y /1,2 | git add -p >actual &&
 	tail -n 5 <actual >actual.trimmed &&
@@ -715,21 +715,21 @@ test_expect_success 'colors can be overridden' '
 	<BLUE>+<RESET><BLUE>new<RESET>
 	<CYAN> more-context<RESET>
 	<BLUE>+<RESET><BLUE>another-one<RESET>
-	<YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,?]? <RESET><BOLD>Split into 2 hunks.<RESET>
+	<YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,p,?]? <RESET><BOLD>Split into 2 hunks.<RESET>
 	<MAGENTA>@@ -1,3 +1,3 @@<RESET>
 	<CYAN> context<RESET>
 	<BOLD>-old<RESET>
 	<BLUE>+<RESET><BLUE>new<RESET>
 	<CYAN> more-context<RESET>
-	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]? <RESET><MAGENTA>@@ -3 +3,2 @@<RESET>
+	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET><MAGENTA>@@ -3 +3,2 @@<RESET>
 	<CYAN> more-context<RESET>
 	<BLUE>+<RESET><BLUE>another-one<RESET>
-	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]? <RESET><MAGENTA>@@ -1,3 +1,3 @@<RESET>
+	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? <RESET><MAGENTA>@@ -1,3 +1,3 @@<RESET>
 	<CYAN> context<RESET>
 	<BOLD>-old<RESET>
 	<BLUE>+new<RESET>
 	<CYAN> more-context<RESET>
-	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]? <RESET>
+	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET>
 	EOF
 	test_cmp expect actual
 '
-- 
2.44.0.494.gf640f9da83
