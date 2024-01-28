Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789644C626
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706481303; cv=none; b=idoouEXmYMEIsyiVS0U+OPYx74KApZv7pPkzPorF6kEWR2N4rgwJho4u8UtPH3kcxaRyExbhelcf757p3ZgBedkbqq+KopH34gZH72oxi7ljQt/N8vqGKMExOKaBto7y1H3DpD6jbYgiLI9eZmLFT4ZFFKOSK4U+MR2yDMhDT9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706481303; c=relaxed/simple;
	bh=omGF1o/2+5WqiwdFjue7pS3a5SFrhbBLVndhmJ9g7MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJM1FIkJlx6gnhosZ5nmSkhLjAbObVlR4OAaHnM9gztsjmE65w/sI3XgvRx+6e19EVat6edBGQv+CG0EgMGwm0Ai4FzeAoZX6U4NoYMcjZ4MFDTVnn0+YV4CmFSJdIeDmyoHAKnviisyMK8tOkFdjFfYKVdNd/mmeQE4cqiywi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JM7b0TwK; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JM7b0TwK"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bba50cd318so2211225b6e.0
        for <git@vger.kernel.org>; Sun, 28 Jan 2024 14:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706481301; x=1707086101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdelmLWlr+xRsniqLo4vYuuoJXVLc2gZ++2oLsRkxcQ=;
        b=JM7b0TwKdtlLrVv8/MHGb+8arRx/uwEx5geAFul3CBiN+9VldSLQF8oq7wWLBw7wNc
         Uz91nBKmEVvWTAD5p1mj1h+0Ix1tNtJ8VJdfGYiJhkh3hT7npOjH/vu5Df7Nmet91NWL
         LjFYjxaZbb5msbFgerjqts3xIzlXPs0ZL7fHY4m7sjSDNz0GjK8G0RLF8qtumglgFYeq
         11Umb0NR9spsoAeAIxwBgzt0xYASBXGAWpkb0RAHnKhFuTRT3OSshoL4+EgAyPlhBy1h
         7GAGey4Rw1iwBAruFisRmk2xmCSibOGZaKtxOOcgqn49caA+PHtE5SVRgGCOuQNUQycJ
         QLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706481301; x=1707086101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdelmLWlr+xRsniqLo4vYuuoJXVLc2gZ++2oLsRkxcQ=;
        b=uwdm30AfCYMks1tfy+lqFdxbNKzK1M2V9pHYPqpGcMqbTm7xg6QplzqAQ4KidswRE2
         kRtHyq4gY3cyhPuKXcIx8BEUr1TPQQIMv1UJpqRlLkhosAUDxt8Kb9HbL/M2dYdbJZKI
         8b5gIQKMrvBPhOUa8XgDgPTs0yf/EE7eZDynxJcwRlb2Mwl823UM2TQH5TgBUIH6oA+5
         v8zR2+QQsGCyOmd/fu/uS9ZD88+fWcOqyxqHJa8WN1qTu9E6/hPtEd7Jy/yA9v1l6v+m
         wd1PaRpMtTILgj0T2Jc/oVzeWQG6LchCoVX95QwPgCAF932Z1mUGAOb4x5HwXiBY0XUb
         QpkA==
X-Gm-Message-State: AOJu0YxHsh4oR81tCoK3k/HVddFbviUuuPvrf7PTLwBHcnNTCJWqqv8E
	oGNTQ/ooW1xuyW2Vj49OewuHxJw2Ar9WIDTny4Ndj92F7DdiDMZR6Ry8YC1P
X-Google-Smtp-Source: AGHT+IHWLb/+ZnkWj89+TbDQwffwed1SopdyRsJefs/Vfn2vakPrmoCZlHRBKxpUsD7GkrJkOJxEeA==
X-Received: by 2002:a05:6808:e85:b0:3bd:59da:57ba with SMTP id k5-20020a0568080e8500b003bd59da57bamr5137561oil.59.1706481301516;
        Sun, 28 Jan 2024 14:35:01 -0800 (PST)
Received: from brittons-large-Vivobook ([209.112.166.194])
        by smtp.gmail.com with ESMTPSA id s10-20020a17090aba0a00b00290b37765casm6712713pjr.26.2024.01.28.14.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 14:34:57 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 71742520539; Sun, 28 Jan 2024 13:34:50 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v4 6/8] completion: bisect: complete log opts for visualize subcommand
Date: Sun, 28 Jan 2024 13:34:45 -0900
Message-ID: <20240128223447.342493-7-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128223447.342493-1-britton.kerin@gmail.com>
References: <20240118204323.1113859-1-britton.kerin@gmail.com>
 <20240128223447.342493-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arguments passed to the "visualize" subcommand of git-bisect(1) get
forwarded to git-log(1). It thus supports the same options as git-log(1)
would, but our Bash completion script does not know to handle this.

Make completion of porcelain git-log options and option arguments to the
visualize subcommand work by calling __git_complete_log_opts when the
start of an option to the subcommand is seen (visualize doesn't support
any options besides the git-log options).

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 41c76c1246..ae16e742a4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1490,6 +1490,10 @@ _git_bisect ()
 		__gitcomp "--term-good --term-old --term-bad --term-new"
 		return
 		;;
+	visualize)
+		__git_complete_log_opts
+		return
+		;;
 	bad|new|"$term_bad"|good|old|"$term_good"|reset|skip)
 		__git_complete_refs
 		;;
-- 
2.43.0

