Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531951BF3A
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 21:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707256254; cv=none; b=r3m2bHKaPxLjD0SaFV+b57XLANJ0CtRkuuNfxd4drwjUzksmOtQd5XfPw9BncuWTYy9cbSqh3ux3yAJ73Ru/7mVCxTw9zi0qtm0DErDRJqvvTzyI2u5tRiaq35XIMYMUX+PBJHZBZgv3SmwxNTcuKEFiV/hd610ilx5K04cO2C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707256254; c=relaxed/simple;
	bh=DBk+2zv0adQkg65TZq3xcmTqTnLqCOBealQqdOlRuUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okFliarrJNVNysKe0LqthqI1A7eUeEmrgB+OJeiOPJCy7Hd+7f82tno7qgzKzX9/9fjFpvrxGcYq0gtDbDsgtqdyg9sK+VuHQiHjDWCpIUQOQwwk+DPTHZWvmT+n42fk0AaA/422gnxM8opOtwOFap1hKaq+FrfClI+nnFBnl70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jn4Epj1c; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn4Epj1c"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e02fa257eeso814944b3a.0
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 13:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707256252; x=1707861052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kckf0+1Dd8DH7fBXYNF6Z+oPRvbwMoWyyN9tcYm1Ztc=;
        b=Jn4Epj1cIzEDqP/R6Es0TVMnpO5187T2C5OuNp2GzInnh60y9wbgNtXcEGDjmlaES6
         3OfjxP6tL0di/0nh24sjtuPR4W3ZYMhJPYkt0uZIOLKxLnfcxgiMnDO8EjK6xSXDvH0L
         5KGrTVQcnAd38eNteNOqo7cYPQwUNGqKp18ALTq8YNr3ejlgxy5/XqoAyXAzLfx8E0xd
         PayOPhDpFUSFlXC7mDHw8XxnRKka/oM7v+VcXj/3e/MPFZeNpKDkiPLjAmIabrX8GRQt
         tNExFRzx8Ef9HU0SqLufo1GDJkhjmAiVZksB0P1yujif7xS9mKeM4S/PowSbhNv5JNlr
         Ksxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707256252; x=1707861052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kckf0+1Dd8DH7fBXYNF6Z+oPRvbwMoWyyN9tcYm1Ztc=;
        b=aRpuqIqK/zd71RBvnYMqEfXGwj2bV6wLIjsVxgj1FIYpmA3wVywptFU36U1qmn45J3
         Tn9d7tjRtEBezvB6GnMTZ2e68QllGzW1pIVb8spqttr3qm3+/bzr98EXwqwOsLBAre5m
         7A1SoJfIeKX9xl05cwbhI08xQKLNBO9POp2GfK6nUC6gGk6WZAu0Oz5VnOGiW0BcK19c
         3Lke89d/y8G1jvf/SDstpwIK47l5252JpHmB5nQstJRaix7CZSvTz80tE4hx/xU0cw14
         +uxZQqnl91KEvwtQgkf5n5XBrCxwRfRHBPOTvYfO/qeM5y5jVg9w3MJfBtQUIAeDZPR7
         emng==
X-Gm-Message-State: AOJu0YyH8wF32kxxfhmajRq475Ql/3RzfUXF/Ea+HxgNXiRQnh+guLFP
	7+J8+uOi5zOdhVyglLi2qHJmQbevUUM8u9sI4Gtk79EC3rOTqY0j
X-Google-Smtp-Source: AGHT+IGb/Yav8R1w2gVo5VZqtBsujPImiSw5J2plvhtyWCWKKx/Pk+9M6vDcrdMkQoBYqz9XJ2B30A==
X-Received: by 2002:a05:6a00:228d:b0:6e0:50cb:5f0a with SMTP id f13-20020a056a00228d00b006e050cb5f0amr876745pfe.12.1707256252421;
        Tue, 06 Feb 2024 13:50:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU4w3wOrjyqDdzwiyB1yEIQWUMpfDIakSWmL+e2rgYZyuH1fQeX84mmZsvTtcSfcR/4xhNXJQ7w21Hq0H613K7QeNgisIV5yYm1FRaWQT+HaAM6
Received: from brittons-large-Vivobook ([209.112.166.194])
        by smtp.gmail.com with ESMTPSA id du17-20020a056a002b5100b006e047a34834sm2464582pfb.182.2024.02.06.13.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 13:50:51 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 4B4675202A2; Tue,  6 Feb 2024 12:50:50 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v6 3/7] completion: bisect: complete custom terms and related options
Date: Tue,  6 Feb 2024 12:50:44 -0900
Message-ID: <20240206215048.488344-4-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206215048.488344-1-britton.kerin@gmail.com>
References: <20240206020930.312164-1-britton.kerin@gmail.com>
 <20240206215048.488344-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git bisect supports the use of custom terms via the --term-(new|bad) and
--term-(old|good) options, but the completion code doesn't know about
these options or the new subcommands they define.

Add support for these options and the custom subcommands by checking for
BISECT_TERMS and adding them to the list of subcommands.  Add tests.

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 32 ++++++++++++++++++++++++--
 t/t9902-completion.sh                  | 15 ++++++++++++
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 06d0b156e7..6a3d9c7760 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1449,7 +1449,20 @@ _git_bisect ()
 {
 	__git_has_doubledash && return
 
-	local subcommands="start bad new good old skip reset visualize replay log run help"
+	__git_find_repo_path
+
+	# If a bisection is in progress get the terms being used.
+	local term_bad term_good
+	if [ -f "$__git_repo_path"/BISECT_TERMS ]; then
+		term_bad=$(__git bisect terms --term-bad)
+		term_good=$(__git bisect terms --term-good)
+	fi
+
+	# We will complete any custom terms, but still always complete the
+	# more usual bad/new/good/old because git bisect gives a good error
+	# message if these are given when not in use, and that's better than
+	# silent refusal to complete if the user is confused.
+	local subcommands="start bad new $term_bad good old $term_good terms skip reset visualize replay log run help"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__git_find_repo_path
@@ -1462,7 +1475,22 @@ _git_bisect ()
 	fi
 
 	case "$subcommand" in
-	bad|new|good|old|reset|skip|start)
+	start)
+		case "$cur" in
+		--*)
+			__gitcomp "--term-new --term-bad --term-old --term-good"
+			return
+			;;
+		*)
+			__git_complete_refs
+			;;
+		esac
+		;;
+	terms)
+		__gitcomp "--term-good --term-old --term-bad --term-new"
+		return
+		;;
+	bad|new|"$term_bad"|good|old|"$term_good"|reset|skip)
 		__git_complete_refs
 		;;
 	*)
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 7388c892cf..304903b1a7 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1321,9 +1321,12 @@ test_expect_success 'git-bisect - when bisecting all subcommands are candidates'
 		test_completion "git bisect " <<-\EOF
 		start Z
 		bad Z
+		custom_new Z
+		custom_old Z
 		new Z
 		good Z
 		old Z
+		terms Z
 		skip Z
 		reset Z
 		visualize Z
@@ -1335,6 +1338,18 @@ test_expect_success 'git-bisect - when bisecting all subcommands are candidates'
 	)
 '
 
+test_expect_success 'git-bisect - options to terms subcommand are candidates' '
+	(
+		cd git-bisect &&
+		test_completion "git bisect terms --" <<-\EOF
+		--term-bad Z
+		--term-good Z
+		--term-new Z
+		--term-old Z
+		EOF
+	)
+'
+
 test_expect_success 'git checkout - completes refs and unique remote branches for DWIM' '
 	test_completion "git checkout " <<-\EOF
 	HEAD Z
-- 
2.43.0

