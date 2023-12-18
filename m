Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFAC3D564
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3Ek1DW+"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55322dbabf6so1607097a12.0
        for <git@vger.kernel.org>; Mon, 18 Dec 2023 07:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702913014; x=1703517814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NQdMZmbkSqkwjgqueEB9zCmFqJTXV5M3Jt56ko1/Lg=;
        b=Z3Ek1DW+l4x8jnlnXqyUsBQeaoL/vj3TddVVsPwAJ8sn2+gO0PFW3qpyKcKZVkqHBq
         yf4DceYFENNkajgbgAvmi02GMCcRQOicFAY/4J7RKnm6TGMMMvNFbaLVUzo23gkD4GwJ
         Y6uoxHXSC/Co1ctGDsCL3n+NTcubSgvpOo5kaITcL9X6UfB4ioF7W/4WiPHKrnr8VNzz
         js4d29UlV+bwVlujvmfqFW3+2nJDSGiig33Gybjmwq6KJb1ifkrhhzOSYzCjhELkHZog
         k9PG7S+xzsRVcMcZgNoQPEnLfGKFvbFMFq7ANnO0AMaYPVE4F5eQTG3T5gxGEXwTbZU8
         y/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913014; x=1703517814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NQdMZmbkSqkwjgqueEB9zCmFqJTXV5M3Jt56ko1/Lg=;
        b=erhT7weAHOqPfLWNGQKVHbTjs5dYvore5OksTPqyo+/5Um4t4q/K+Osb7YsEUTD654
         UR0og2iMnbpOXKfTaVwhS5v2xGJj6ddMvezPlY/JbMXOPXVaTtsWZws/rokaqQouUIJk
         LJx2at+8P9e8iJGjoa9U6hUnBgiaDczrsTOsN1CFHp6Up9YwKaaJRdQTVE/MSBF9cyeO
         nVxqQB1cBqvG2tTqHRQYSOBZaZR8O9swVx3vsZyd+57QkSN1ei3nFf48dK5Fuy5/4mTx
         JSHDBtjftJ6QU7PdhVKW9tYqE4SK1tQAlrIpCh9lwcF8E1juljM+jx1qwwrvz7wks9Nf
         knBw==
X-Gm-Message-State: AOJu0YxX1nGemWrZXdszg62kfA//gY2NClhI81dfPlPe9n5U3kRIfayL
	gvmZboK6ovm0YcwCaU0qcpNNoWalQ35deQ==
X-Google-Smtp-Source: AGHT+IEMqZxeTsCnxLlWN1VO0Q3KbXhQpYWvPCilAXRqK9KBOBcc07QWG46Na5Q1+dOeRaORtn+VZg==
X-Received: by 2002:a17:906:2c3:b0:a23:2ee5:e02a with SMTP id 3-20020a17090602c300b00a232ee5e02amr1621167ejk.20.1702913014285;
        Mon, 18 Dec 2023 07:23:34 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd7-e0bf-0-39a6-bdd4-29ba-7091.ipv6dyn.netcologne.de. [2001:4dd7:e0bf:0:39a6:bdd4:29ba:7091])
        by smtp.gmail.com with ESMTPSA id k13-20020a1709067acd00b00a2361104d5asm811847ejo.221.2023.12.18.07.23.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 18 Dec 2023 07:23:33 -0800 (PST)
From: Michael Lohmann <mial.lohmann@gmail.com>
X-Google-Original-From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: git@vger.kernel.org
Cc: Michael Lohmann <mi.al.lohmann@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rebase-interactive: show revert option and add single letter shortcut
Date: Mon, 18 Dec 2023 16:23:13 +0100
Message-Id: <20231218152313.72896-1-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <3e71666c-22a0-f52b-4025-dddb096e7e6c@gmx.de>
References: <3e71666c-22a0-f52b-4025-dddb096e7e6c@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
---
 Documentation/git-rebase.txt | 3 +++
 rebase-interactive.c         | 1 +
 sequencer.c                  | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 1dd6555f66..75f6fe39a1 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -911,6 +911,9 @@ commit, the message from the final one is used.  You can also use
 "fixup -C" to get the same behavior as "fixup -c" except without opening
 an editor.
 
+To revert a commit, add a line starting with "revert" followed by the commit
+name.
+
 `git rebase` will stop when "pick" has been replaced with "edit" or
 when a command fails due to merge errors. When you are done editing
 and/or resolving conflicts you can continue with `git rebase --continue`.
diff --git a/rebase-interactive.c b/rebase-interactive.c
index d9718409b3..e1fd1e09e3 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -53,6 +53,7 @@ void append_todo_help(int command_count,
 "                   commit's log message, unless -C is used, in which case\n"
 "                   keep only this commit's message; -c is same as -C but\n"
 "                   opens the editor\n"
+"v, revert <commit> = revert the changes introduced by that commit\n"
 "x, exec <command> = run command (the rest of the line) using shell\n"
 "b, break = stop here (continue rebase later with 'git rebase --continue')\n"
 "d, drop <commit> = remove commit\n"
diff --git a/sequencer.c b/sequencer.c
index d584cac8ed..3c18f71ed6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1767,7 +1767,7 @@ static struct {
 	const char *str;
 } todo_command_info[] = {
 	[TODO_PICK] = { 'p', "pick" },
-	[TODO_REVERT] = { 0,   "revert" },
+	[TODO_REVERT] = { 'v', "revert" },
 	[TODO_EDIT] = { 'e', "edit" },
 	[TODO_REWORD] = { 'r', "reword" },
 	[TODO_FIXUP] = { 'f', "fixup" },
-- 
2.43.0.77.g0ff82d959c

