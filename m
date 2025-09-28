Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1934C98
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759067689; cv=none; b=kLWt61770cUkQIXLoiRw2GrCqNOUbZLIvN8IsymejKxbA7Aeu6/UEHsazWLMzRstKw7wrgoWCNFKF9lip2i9uRvqykLkGB4JBkxjInRtW+Oq80defEFeV2sSSFb0mze1L+GlovSdoEJBv2UE1b68g4pUdR9euZ28fX/QNwbkPhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759067689; c=relaxed/simple;
	bh=xcDrrQ5nvR85OtjF3L6JopdnLoipt0r07FDdAXNFGnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C53FLIufNG4xD999moiCQFVhWMTmLE3kg8JncY3KhHaXI2yGlo9grBYYm8+MoeKWkomO7NLr7h9VC9NMdJNQv98/RCN0+elv8H03+rjKqTTqx/VUs2i6Kvdq32uL0zpc0Fh2vkbgmCrv0g3mJ5jPaqYS+HrycUZtqz4IAVw9o8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAWZQBgv; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAWZQBgv"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-85a4ceb4c3dso407462185a.3
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 06:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759067684; x=1759672484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lT/dAUprFctOjImfylPobbn/LkOkiTqlDwOf/pwWnBo=;
        b=BAWZQBgvut+IqUzhSCrxS9n0F69gG0sF0TmHPX2tRca7AsuYfM7ISZuM1b9HQ+Imwd
         m0UFItoqTGZJ4nN9OnP3M31iKBY73KkzuPxVaJGu5jJ0xfE6mhZ4dWEMYAIzUQFwB60/
         zSFpvbTv1HrfeB3PY5PDdLOUJ1JthyVfF+7gM4nT5hBXyzeG8Gsbudh0Tkuov0NC2GtB
         vP3omDFaRTHRYYX90b7geTBSe8vrIPIJ/iT7uuU/QFFHqgZAZBU0HLeRjYcKT1mDdRMv
         FqTBDEJyxKOK76TziSlgp3/IcUIb8Z38iB9hOjVHzY8WhoDWjG5C1SKajWcsPCA2uXXh
         D5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759067684; x=1759672484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lT/dAUprFctOjImfylPobbn/LkOkiTqlDwOf/pwWnBo=;
        b=WgJnso4w7Xm/pP6qSk3qRY5jMQsFbxcs5C+GECU78bFjj2RAQbVgmlBnVr0ALtDe30
         IiRsKajnrrV9Ne6BQ6jDcLZRJbbNyi09mNy8gMK/jbRyzu3hqBuezVMpTGUxyll+yTwH
         1F3NuiETcE7JDFH0GDboxqh+bZrLMJRnJKm4x4IMfIsgV3L7wuQt0R7b95jttEi6LVOg
         8NwvGiwlKPM55AKNz6vNIz0aV65k5x/11/THAaHFEvOo8yznjoxKv/nNlKqNG1PunTvl
         ZVVkGDUK+N9sffCjYX/5cmn9H5Q7Fi3tNS0kDyqKReiDT4+IZXJVB2wqZwiLwZ3vg9GX
         qIqA==
X-Gm-Message-State: AOJu0YzQT6+UJD3i8hr2Sp11L42eHqDcUqeeW19E7adVQf5j8VcpBKSO
	BqquCaaUYNtz2nwrCYpiB/xkV0G6REQmI4JwzzooctUmClxRhUOaauizRZYCoK4N
X-Gm-Gg: ASbGncs0l+GGx61+AEpIpLVrBOMs+wR9GuwMOtxrHOnHR0D6RzYJUgJ/7bSVBNQEaFF
	GTzghc5br4tirKSW6Be15D618QIlnJnQriMHeI1sboxiQg5q+uVsygyn8sjlNZx7G2ODLkW97nv
	RtPcX9TrSfA+0uPzJlV1Qn02xOHb2t9qQcMR+xecYMiTR5NHTFm4qj2Ta0TlLwoxJ2LKzhgcgME
	dAhzvDU74XyK+VqOtUvqFsiHSU5gbgNEervg2FfpYmBXVI1IktYLDqAXhltLjctS+69pZjmz5w4
	yJk5oWAKt4BYY0LX4unO5kQTUOfcTbdrJqjwCQzDYrCR4daSERsqr7ChVti9MTqJjXfL+3KTj1t
	dH/vN7m8gj149QEp/FpNT9D8r+debevTbDS9VB7HALqUvtpTViG2f6gEDUDjXiKtPMUXTMqcecJ
	GS70O0xDjHtTjeJfgpzoagndxS8lnPQsiA5jO+nqof
X-Google-Smtp-Source: AGHT+IFFtXC3NquF925BfY1whwX98lzJrjx3tDD3+Fl4A+fJimZpljlJaLvrD+WrKW4yU8Qwzcv/DA==
X-Received: by 2002:a05:620a:29d2:b0:813:41c3:e888 with SMTP id af79cd13be357-85ae061bc62mr1868271385a.32.1759067683598;
        Sun, 28 Sep 2025 06:54:43 -0700 (PDT)
Received: from USROMMRAPPAZZ01.rappazzo.network (pool-74-105-50-139.nwrknj.fios.verizon.net. [74.105.50.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c307ad101sm590426985a.36.2025.09.28.06.54.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 28 Sep 2025 06:54:42 -0700 (PDT)
From: Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v3 1/2] Revert "gitk: Only restore window size from ~/.gitk, not position"
Date: Sun, 28 Sep 2025 09:54:34 -0400
Message-ID: <20250928135435.59623-2-rappazzo@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250928135435.59623-1-rappazzo@gmail.com>
References: <20250928135435.59623-1-rappazzo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Sixt <johannes.sixt@telecom.at>

This reverts commit b9bee11526ec23541ddbbd75716bfd1acc241463.

The commit catered to an unsupportable port of the Windows Tcl/Tk
stuck at 8.4.1 that was used by Cygwin. 8.4.1 has some bad bugs in its
layout engine, and forced changes in Gitk to be compatible. All this
became irrelevant around 2011 after Cygwin gained an X11 server and
switched to a supportable port of the Unix/X11 Tcl/Tk (it is now on the
current 8.6 code base).

Helped-by: Mark Levedahl <mlevedahl@gmail.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 gitk | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/gitk b/gitk
index 6e4d71d585..275f353811 100755
--- a/gitk
+++ b/gitk
@@ -2764,17 +2764,9 @@ proc makewindow {} {
     .pwbottom add .bright
     .ctop add .pwbottom
 
-    # restore window width & height if known
+    # restore window position if known
     if {[info exists geometry(main)]} {
-        if {[scan $geometry(main) "%dx%d" w h] >= 2} {
-            if {$w > [winfo screenwidth .]} {
-                set w [winfo screenwidth .]
-            }
-            if {$h > [winfo screenheight .]} {
-                set h [winfo screenheight .]
-            }
-            wm geometry . "${w}x$h"
-        }
+        wm geometry . "$geometry(main)"
     }
 
     if {[info exists geometry(state)] && $geometry(state) eq "zoomed"} {
-- 
2.51.0

