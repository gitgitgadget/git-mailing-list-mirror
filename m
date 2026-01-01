Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F0D2874E0
	for <git@vger.kernel.org>; Thu,  1 Jan 2026 22:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767307466; cv=none; b=DbbqJviEHxXB2RQfg4DX79Lzuh4nK60ZAlabRNFPOdBtgbtf8hI+pcIwSrw6Q2u6s0bz/UY/0AJQUN4UMh3gZPM42LQvqs52t+nUFbetEwcRbIFxd70LrqAmnUO2Sqd3iYLZpgRQ5wtQfD2A4d5ufckR8se65gIajUk+XLJ8n5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767307466; c=relaxed/simple;
	bh=8lOMMuX9RgDNKE6HJBQrdiD0qOC6mZ2jtwNnkiDn/TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwYb1CPSXKFEh7aatbm7qFbaqu0LKURQkRVv0slYRmh+GOtTFeya1av4qanCiJPoVpsCBxTfq+xQn1S0Ffd8ZBzchv0zCl4sQ7N7vSNcsQdoadUMXZv6Yc+TszbtFyNiwJu5yH2anWJLvA9tCUyKBFRRA8QTJ77YvW06Hq/obEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpi8vEa3; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpi8vEa3"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78fc3572431so86621177b3.0
        for <git@vger.kernel.org>; Thu, 01 Jan 2026 14:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767307464; x=1767912264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZSEIFfXaVUvjirpTcLYiDeTTX0zOn0UD5n8COzkvfY=;
        b=lpi8vEa37odyOTSr+2AheIuesxvLYZqJIGs9b4vnXHTwvo1Y/l4tek1j/jtI76JDzp
         1LWuUxRPlTcGI9gMZynW66PUsZ3MUnuzpBcAgmigCW/5xTVfQIe/ywRTOdpYfCzgVZGb
         2QEXFa9O3wiKuTc4AILxwgESXxqW3ZGanThAeeKasWRLk8vquWUQPK6HnM+OSeQSzcmR
         AQ0y8SAZ0CX7oO1V+tbS0cAznooZCdfa6Rv8FGfpC3tRe/uq8L4y4ZJj+X1vbVt1KqS4
         /B87MO2pVQiMcAojwQ9rFaTVcfCy0Hxk8HjNWbtHSoNjrT9D9SCKzGfSY0nr9BnfkOWa
         /XPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767307464; x=1767912264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZSEIFfXaVUvjirpTcLYiDeTTX0zOn0UD5n8COzkvfY=;
        b=PVkceY7xVr/2DYjlSF1m1oDiPafXoNBewOnBmg0Q5Ret6eWapY02ROd5zk8jRD699X
         zZYVEfifmYVKmoOoGN1sM/orhXT1i5q3z7kApfmtJ3dkHURhH+2zh/zLmXIAoK0Gy1Z4
         CdrHTvtwHLaGJtYDiskPdsUWvd30QSDA2ZMALH22SQ//cdh9mpsFHAeG/AOpAKz0Oozv
         bL6QWNreN+REN398hIQjC/5RUZzvtGsCiEwu/09faSUwehR5EBpCF3trTPFjFymQCFlc
         53oKOuYMLjbuS0DZwGGg7LMlOLA4qpIzSuLejX2C/PHij2eTRleKDdbNFBOTN5r9g7Gm
         LJ9Q==
X-Gm-Message-State: AOJu0YxMG8xqCQAJLA+HebMFk/Ph4qTuEHzNKjCzc5oV2q5bx0P6qWaS
	/geQRuCBhvwHV6oQgK90lln7z1HMEGsnX1tNSQiVplkJAw9dvNtVJ9Z6JWQ55A==
X-Gm-Gg: AY/fxX7K6Gii9Dpf8rHsoBBZSgcY0W8buh+qBXB2v7/7poGyZ12zSBMHrl5I+tKNHiI
	1SQiCQRL56McX5+MBjSlRRBjBSvKSiAqyIGyXz5gsB7S8QrqLWkCm946nBOXdqB+Hfmvi/2jsir
	9yKKbvQo31cfJeVvdDsPv9Qa+0xj05sAaQHO2THszwxZr7JoVFE8XgtqYeUQqomLClAJruLHmWv
	d/U1HYwgVZfV/Z0Pp9yNZmffK3DNS4Fl9btKkMOxtJz3l0j7BptNhPIXO8IVOStWAhOY9DOEiTa
	ykWfWbBQfWbz7kO7ZbKwlwxvSoFZHIAXv9wfnwyMLvCOh7+gRFHJ7Lgp/lCPn8Kap+JRfISM+LJ
	WP6uVws7ERR157jVd0CZ7eWMHaKTzZT6oM5BG3hM+gJmuMdO/7uOnxgmV3Z14e91YrFF3meWCT2
	AOL/GviXN3R2JdAAw=
X-Google-Smtp-Source: AGHT+IHaNm/cdm8mNX9+54RhUL/cWHgavWFemDnK9J7CnQDbG7GnNP4VazGNX+PAMxWH7DpNA1334g==
X-Received: by 2002:a05:690c:6308:b0:78f:ca4f:83b4 with SMTP id 00721157ae682-78fca4f8cc2mr287110367b3.22.1767307463972;
        Thu, 01 Jan 2026 14:44:23 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90a8:8b00::a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb43790dcsm150521117b3.11.2026.01.01.14.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 14:44:23 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: Julia Evans <julia@jvns.ca>,
	Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v3 2/4] doc: git-reset: clarify intro
Date: Thu,  1 Jan 2026 17:43:57 -0500
Message-ID: <f90be8559f7d1d8362077a6f888687ee8be063b4.1767307382.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.426.g1df11fb20d.dirty
In-Reply-To: <cover.1767307382.git.ben.knoble+github@gmail.com>
References: <cover.1766103827.git.ben.knoble+github@gmail.com> <cover.1767307382.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Julia Evans <julia@jvns.ca>

From user feedback, there were several points of confusion:

- What "tree-ish", "entries", "working tree", "HEAD", and "index" mean
  ("I have no clue what the index is", "I've been using git for 20 years
  and still don't know what a tree-ish is"). Avoid using these terms
  where it makes sense.
- What "optionally modifying index and working tree to match" means
  ("to match what?" "optionally based on what?")
  Remove this from the intro, we can say it later when giving more
  details.
- One user suggested that "The <tree-ish>/<commit> defaults to HEAD
  in all forms." should be repeated later on, since it's easy to miss.
  Instead say that HEAD is the default in each case later.

Another issue is that `git reset` consistently describes the action
it does as "Reset ...", commands should not use their name to describe
themselves, and that the word "mode" is used to mean several different
things on this page.

Address these by being more clear about two use cases for `git reset`
("to undo operations" and "to update staged files"), and explaining what
the conditions are for each case instead of forcing the user to figure
out the pattern is in first form vs the other 3 forms.

Signed-off-by: Julia Evans <julia@jvns.ca>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 Documentation/git-reset.adoc | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
index 9843682e81..71e8f52430 100644
--- a/Documentation/git-reset.adoc
+++ b/Documentation/git-reset.adoc
@@ -3,7 +3,7 @@ git-reset(1)
 
 NAME
 ----
-git-reset - Reset current HEAD to the specified state
+git-reset - Set HEAD or the index to a known state
 
 SYNOPSIS
 --------
@@ -15,10 +15,13 @@ git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
-In the first form, set the current branch head (`HEAD`) to _<commit>_,
-optionally modifying index and working tree to match.
-The _<tree-ish>_/_<commit>_ defaults to `HEAD` in all forms.
-In the last three forms, copy entries from _<tree-ish>_ to the index.
+`git reset` does either of the following:
+
+1. `git reset [<mode>] <commit>` changes which commit HEAD points to. This makes
+   it possible to undo various Git operations, for example commit, merge,
+   rebase, and pull.
+2. When you specify files or directories or pass `--patch`, `git reset` updates
+   the staged version of the specified files.
 
 `git reset [<mode>] [<commit>]`::
 	This form resets the current branch head to _<commit>_ and
-- 
2.52.0.rc0.426.g1df11fb20d.dirty

