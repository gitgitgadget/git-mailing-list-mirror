Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4531196D
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 21:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767649742; cv=none; b=fZFD1Ns6TaWyPZFX6KNVulwuJpIdim8hvgGEBYJbjZwd6olRw9VSo2ytNPWiWprk1pW7HeibGr4xpo/Hi/XNxxanp1vltFDBHYrMhQfxrBqgeHDb1bs+p/XjfMQFEM0Q9wtObllNWrQiN7UcSh3G+gCEPs1RRKAiiOPf2wxzhs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767649742; c=relaxed/simple;
	bh=bXkosycHxvFBKQR1Jwx8P5SNrhVsHCS2Zh+K0KBgPUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKTOfsBZgJ6o/H7uLjRsAsqyrB/ClGdcwK3TqVnb2PYsulCtpt3rpIZO8RkfUJsWewqaaPo75JhdhbOeWnEoVRm3X1jUBocN2sSp1AV24QbWE60Gwv3MJ1gccJCOH90OHYSB4Itp9a3t//D9Ce9jO/zgvR3ZnHnHB7zGtIOGV8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ew/bcnvN; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ew/bcnvN"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6447743ce90so440351d50.2
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 13:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767649739; x=1768254539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hXUwY7jbQFb9jjieJVqlDzEkqpLp9rSF3EknOeSyIQ=;
        b=ew/bcnvNxc5RICYreOANnpLfQ8TydbRkuAIgfmy3rXjCQzbJxe+K2bLjwYo1tGcAKA
         vfh+R7OTkLvAVu6Bh46zObU0Leo/qx+l5u5Lha06TI2B3hegU//ewUaWUekjR6sTA3U7
         IqsKRA/DzR4NR85TwoxJNAn5fDgsnOJ14bewkAJxlszlFdWyd4WOHwt3SppQcXRTeBm3
         Y3wYJQcCxASAe1JJmJI38BDSvxeKWqkMaa1x+2bAH/OPMiD6rymtzl4BxYB3xssi3MMo
         wH93/Xh+FpCkjS1YttkstJ66iX34/nae8Ll/qLu4B/zy8GD2Nwn7MlTaBdsGP491z6BZ
         85/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767649739; x=1768254539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3hXUwY7jbQFb9jjieJVqlDzEkqpLp9rSF3EknOeSyIQ=;
        b=C88+Fuk9zmjL1fvViVSV4w6f2fH4ixkbh2fTdDn4zbyV9BVU0/M9IGK64kNP83lq1y
         1OyPnLFa8ubgQ9ya2XoGHG6yLlpBGO6HDbpRcyoM8DlY/XONcidrFPMv713UWMqO/Z6Y
         a6Za6jvEayFYaSm8EWfudgwP1cy00sGT9KAArpViwOKrSv/Nxp+xOYboJpJZh5c5cs3M
         tYg6iSeu9nREvKr/2AcWoiN+ZXT7lj3dtH/3Qzkxn1pgHPtugALlUbvgnX2l6IIA1hUh
         B6folAWeHuteXEsHL6pun9jaEmXprBMA4oWfs0FiG2v/XZbXOpXDa1VI3/3fRJKqjQ3g
         GsXA==
X-Gm-Message-State: AOJu0YwoIxy51s0DqNSoAh8+2J28hQZRrV7WhqtvU+PeoZSi50z0Oiwz
	iJEbUbcebjbFEGxj1L1hpvMSFdC3Vz88G3yCA5pDMoCq2Dc3TpdIACxRtoWAiQ==
X-Gm-Gg: AY/fxX5wxXp1/6I5YhijwKyfBB6o+FCXC88Vqr7Bh8BV0eOBSuQJ5ESlX22dHN3kLIJ
	MHPwonTwrTJELPerzWDxwQLzmOaCBvM1OFHVTv9OZqYvJ+D64kwPxFlysawjZQNQjt3WkfjAC/o
	V5Ubx7T5SXCzuTVNi83O32yoxD51meSw/2bUeH+3QjH/Z4GhFluqXkkjuyMGb49jeMcc0QfQlLc
	Db0ZTG3cznaV85KmpfYsVyqtc4Nyly753G8xNFRYw7YcgRIGUx0dOvNu7dNuykBMyInRr+Bdj/E
	yS68zue2s2BT1/PYGMhWSeL9cr34cHrUtJNojhwF6w9XCI3DW6hNVAR2w1zEhy3CUyJpjZ8axTe
	v3E6yj6J5U/VaqwihY5FQQ68bjSOjjUiZ5D/zfzBAYESG+6tmVvFxQqzuENXKYiO7HcppQIUzcH
	8RnNoTmIjDil1yz78=
X-Google-Smtp-Source: AGHT+IFCJdS+lPfaXfFbgU3jZ3J76buGZ7rWP6Fb91l2JsvCh0oyJWz51h6SKb1EC8fnhzCX7QD0Ow==
X-Received: by 2002:a53:b1a5:0:b0:644:60d9:7519 with SMTP id 956f58d0204a3-6470c98a418mr537040d50.93.1767649739344;
        Mon, 05 Jan 2026 13:48:59 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90a8:8b00::a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa679385sm706737b3.32.2026.01.05.13.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:48:58 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: Julia Evans <julia@jvns.ca>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: [PATCH v4 2/4] doc: git-reset: clarify intro
Date: Mon,  5 Jan 2026 16:48:16 -0500
Message-ID: <3fc46c7158fdfb5fea5616bebb713e564d843d8e.1767649692.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.426.g1df11fb20d.dirty
In-Reply-To: <cover.1767649692.git.ben.knoble+github@gmail.com>
References: <cover.1767307382.git.ben.knoble+github@gmail.com> <cover.1767649692.git.ben.knoble+github@gmail.com>
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
index 9843682e81..91dc6e6278 100644
--- a/Documentation/git-reset.adoc
+++ b/Documentation/git-reset.adoc
@@ -3,7 +3,7 @@ git-reset(1)
 
 NAME
 ----
-git-reset - Reset current HEAD to the specified state
+git-reset - Set `HEAD` or the index to a known state
 
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
+1. `git reset [<mode>] <commit>` changes which commit `HEAD` points to. This
+   makes it possible to undo various Git operations, for example commit, merge,
+   rebase, and pull.
+2. When you specify files or directories or pass `--patch`, `git reset` updates
+   the staged version of the specified files.
 
 `git reset [<mode>] [<commit>]`::
 	This form resets the current branch head to _<commit>_ and
-- 
2.52.0.rc0.426.g1df11fb20d.dirty

