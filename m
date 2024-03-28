Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB3A20DF1
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 01:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711588330; cv=none; b=LqkihtMN0t5y9A+VvCa8hJKp3RmHozXAE4RIU/wCoo/ESNKTxKsu6djmF3+hglUA1OaF0nMp70uRs8PiCwHsZE+6qnAhEgdPYIi6z9M/gHAc+MjajeGMAH7E/ZT1bU1aQMAVfIQaL/iqp55tir4giPR4MsSZefcev+Me/vSdR3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711588330; c=relaxed/simple;
	bh=eHmh3jUr+YQ2XbAa4OB9QdXtYyjwWuTBJN4J1eyKhaw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=s0uL6nTMdd6jEn6K4BkZDDgSs7aVOUHgaG8SIrimKhVNTF/fMklhdRf7PLWVj51W/eW1BzpCUDLdNCJA1gx3w5RxX46gs7EyUYO3Vs6lGyEn9Tc9NCaW3i2cKMvR+PrQBxe/uy4RLJ+vb2K4tGDzReqaXHj0m7BxTo6OUkQRtU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfNz+se3; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfNz+se3"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-341b01dbebbso308109f8f.0
        for <git@vger.kernel.org>; Wed, 27 Mar 2024 18:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711588327; x=1712193127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZZ6LnDfXjG3ZNUP7ssOWbtRJDTR45oxiTa+ammtmXdU=;
        b=NfNz+se38tnouher/nZywc9+fuMo9vSPNGp2Q0V1oMY+vyhoEhc9eaQpKw4wJxXODx
         EwdhjwzZhc08vKGre9BVqIpItcMij60wl2nIswOk9XW84TMSwrYqhyDIev0e5q+GLAmR
         GlR+oBSBxv+2fuRsAbG9jqoobxQTM0XO8lt4XWbFTubAe3pL+ExDZSHSm7fHuH2zlDQK
         gK/P1UNzQg5m4VuwCd1tLH+JqPqjyeRCLsPVnF9W0DI50o7AeUmcIgW/2X/qwvN5Ye/Q
         DtyF9TXwWjCj7DizdBhsOH9McgmpL9cBb33BxPAkd4LYwuEzlKsrpIYFZt1IfyDH3+OC
         5wDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711588327; x=1712193127;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ6LnDfXjG3ZNUP7ssOWbtRJDTR45oxiTa+ammtmXdU=;
        b=GA2tCZc12ILbWdzIF/bApauXJeoQed8Z9uC67TOkD7J3OpUBP8uXU7d3WBwLRW0t75
         wjFTegGa+VAowOnqISX5uGu5yiUTe5h90KAUpNZinKn/mn9+WEdrrCMYoLogbeq5FXmS
         lj1yhR5pixFl4ZXNwD4JGhbZUCnjx0wf0WpKpWUp5DsylMjzbBd9f1WfxSpmoiFZFFZf
         pkEwVkprGpBhBpGYTbHLouEWLz6REcS6Lyzy1M2nruk2IZ6ZDOgIXB55QE9kjnbUrTLb
         KTxLD7qlbfRIucFMpFOD+a8r9oE+qrnTg2Nc6mb8znN5e2me0LKVamtN3/zSe8JQSnhZ
         F2Kw==
X-Gm-Message-State: AOJu0YwnLrPLuU3celR+5TWtMkqrAE8Zzzd4w8CrDLOR80fyG7HShxfU
	L9oJHTs6q7wrN6kkvDLbL/lwMxcqg8qD/QWkr6PcdHbaZ2xoTkscj/5z8Edm
X-Google-Smtp-Source: AGHT+IFyDaSSzwD7EBRqcVbzzba95iAzt9lqUx2BV++K/uMaMaKuQLgdhO7g4u8Ca0jljUs1Nqw1xw==
X-Received: by 2002:a5d:5748:0:b0:341:ab13:6d50 with SMTP id q8-20020a5d5748000000b00341ab136d50mr1323813wrw.28.1711588326836;
        Wed, 27 Mar 2024 18:12:06 -0700 (PDT)
Received: from gmail.com (200.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.200])
        by smtp.gmail.com with ESMTPSA id l14-20020a5d560e000000b00341b8edbe8csm335204wrv.87.2024.03.27.18.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 18:12:06 -0700 (PDT)
Message-ID: <4fc0e4ba-16c2-48ae-beaa-239568dcd16d@gmail.com>
Date: Thu, 28 Mar 2024 02:12:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 1/2] add-patch: introduce 'p' in interactive-patch
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
 <60d978d0-f69a-4b65-b4ba-d30dac8f112a@gmail.com>
Content-Language: en-US
In-Reply-To: <60d978d0-f69a-4b65-b4ba-d30dac8f112a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Shortly we're going make interactive-patch stop printing automatically
the hunk under certain circumstances.

Let's introduce a new option to allow the user to explicitly request
the printing.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 Documentation/git-add.txt  |  1 +
 add-patch.c                |  4 ++++
 t/t3701-add-interactive.sh | 22 +++++++++++-----------
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 14a371fff3..2965cd0fb6 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -348,6 +348,7 @@ patch::
        K - leave this hunk undecided, see previous hunk
        s - split the current hunk into smaller hunks
        e - manually edit the current hunk
+       p - print the current hunk again
        ? - print help
 +
 After deciding the fate for all hunks, if there is any hunk
diff --git a/add-patch.c b/add-patch.c
index 68f525b35c..922c43378e 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1388,6 +1388,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
    "/ - search for a hunk matching the given regex\n"
    "s - split the current hunk into smaller hunks\n"
    "e - manually edit the current hunk\n"
+   "p - print the current hunk again\n"
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
+			/* nothing special is needed */
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
2.44.0.370.gd7ad5e5424
