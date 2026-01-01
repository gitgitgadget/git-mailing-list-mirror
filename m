Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4A4285CAA
	for <git@vger.kernel.org>; Thu,  1 Jan 2026 22:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767307466; cv=none; b=cOBzDNXgsPHHcO+WfxyQGP79vXxGbEK9F/b7YdkV8cZ03dUSCcbD4ydKk4i/M/jaaJOZesADZzz+x88qdkX9bN5e4HVHMN+PX9vBl5TcehuHLoaV9s0m0UJXEXUZigXco4q9dWJKebD4pw2r7ITlaFbUPhOG7Gy63ljRxfdntoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767307466; c=relaxed/simple;
	bh=SNyKKQy5QITE4s8uRq8V6iLEXPEFLa3mYAmQGMYdBzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NeJeWCGUiMNXzoxjxLf+FbcFlglNxWALv1rYeVAm7CRDmet6oveIwjLg0LFrK1XZcNZthzr0X48Ts071Oc6bUyfJT3bm1W7tu0UyIruygLdSvu0c2XkrCwgttB8sAMaW+Tf0hjyubxEBMzejY52FNmikoYrADzQdgATFLXtarKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgryoKFj; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgryoKFj"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78fc520433aso78608717b3.1
        for <git@vger.kernel.org>; Thu, 01 Jan 2026 14:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767307463; x=1767912263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZisRXe9V1e/Mq3z0KtpgxUl33VjvsblTS+PYmnWGJdk=;
        b=WgryoKFj/r4bXTYMxFw8sIEmwRb7WTkVviOI7i1qJx+fJ19Kd8Hb6Mo8NYvCLullW9
         qgdvjniJ0DZ4vwa2HQV7VPqjaBrYUMHFzcSu5sS8NOBO/QCxhTL4CW0W6No40OiRBgmn
         GDmITZdCU68nsQM4CyFb2AOGvFJIs0NND2OVn/MIOxOXLggbyaeOzDPMhlbYHBWAog/1
         HI+j+fEFUbX3tHitNREOM+h0kB8j1Xw9pA2cZLwxSXMh8skhau/MshFhf5FbtUheKMLI
         aC7fSsf+ImmG1GEFl2sPQ+lMhaUd8uMu7alm8sCs1eAPctLeJ9hEcXP2B3i5iiIQVCSy
         hT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767307463; x=1767912263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZisRXe9V1e/Mq3z0KtpgxUl33VjvsblTS+PYmnWGJdk=;
        b=vO1B4Zr7h60fnLhPt//f3KUpY/WjqOjVREr3gkMMmsPJ1sHmmsX1sYScS+F6keezS8
         QMFLPyVRnyMSgeOqEtPxuA5a/kydQT+8X1EOj/puT2g00l2bix7wxRBld/uOLjc4DG9j
         S7U0VzY7arVOSOJw7UY/zEx6OlPLxfNv7U7RG+T6CYI5PZ5ClDXNwCQVRt7Uh6O9kZIG
         Z/x94lW95CY+3c07WquvnWHJbJ9q2Ku+Dd2JWYIfoYrz0x/AOi5sN4ffJUVpAa+GYKDC
         K+LKDHlGpJ45qlgqBjseBSnKtB25CqEKK1Wt27lAz60NNGaU52F6QD/VrDHuFFEbMqTB
         tQDQ==
X-Gm-Message-State: AOJu0YwCWqfC/4KBTWM/jzfMF9y4hKw3La+aic0M9U4pIOAxm2c7NgMp
	qoYXbhGSKNc92JfvVpCROwpJSf+jZR1MtG05fN8hJHVaksB6r/KHpLKzbv7uGw==
X-Gm-Gg: AY/fxX6vjhYspN+6gE4fzGV2C5kE1RSy/rgE+nvfO3V5i7mDWUUIiTkDoYYifYArCp2
	vhX/X8eCl1sdZ7uJlb85KmKp5aKS29nc/BQ/JFila38982GG8fUO8uJ3qQmyCLy+fTJjCyR8hF8
	yB7nOvb+7WJYwXFC/Wa7dVDgoGTQvUzs3JuOm7ISAnpKQowU8xUGTawG82TP5LITp/tgevDOh+j
	T5NYWdHJzVgTHGJgTTRvpddO4z5H+eS0U79y/nxl04jWK89n3w+aD01IwFCHnJ2hx+M/riSEAt/
	ZkZIvemGBb88p+YGeY0Lu6FqWCsc+qGDbaI/IumAAPja4F+KliC3RAwfafZvMyOEJ/tgHt5PJSh
	+1QaugBmobwOD47gtBSbdPbh/fBat1OPXUO1woAW9c0BkiEouW37JtJ1TykcAROeQUxW9xD+0QX
	x3alxSuNHss/kTEso=
X-Google-Smtp-Source: AGHT+IF9qPTxT7/7AcxylhQPKkDZYcAuaHacEL8+Xc33pWzURGDumyEXaBm1sbUbePbsyDpmUiyfHg==
X-Received: by 2002:a05:690c:d09:b0:78f:a7aa:b686 with SMTP id 00721157ae682-78fb3f28fe7mr361831177b3.21.1767307463077;
        Thu, 01 Jan 2026 14:44:23 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90a8:8b00::a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb43790dcsm150521117b3.11.2026.01.01.14.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 14:44:22 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: Julia Evans <julia@jvns.ca>,
	Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v3 1/4] doc: git-reset: reorder the forms
Date: Thu,  1 Jan 2026 17:43:56 -0500
Message-ID: <a558c5a8684639a2e888866a650357f54f29f2a6.1767307382.git.ben.knoble+github@gmail.com>
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

From user feedback: three users commented that the `git reset [mode]`
form is the one that they primarily use, and that they were suprised to
see it listed last.
("I've never used git reset in any mode other than --hard").

Move it to be first, since the `git reset [mode]` form is what
"Reset current HEAD to the specified state" at the beginning refers
to, and because the `git reset [mode]` form is the only thing that
`git reset` uniquely does, the others could also be done with
`git restore`.

Signed-off-by: Julia Evans <julia@jvns.ca>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 Documentation/git-reset.adoc | 58 ++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
index 3b9ba9aee9..9843682e81 100644
--- a/Documentation/git-reset.adoc
+++ b/Documentation/git-reset.adoc
@@ -8,43 +8,17 @@ git-reset - Reset current HEAD to the specified state
 SYNOPSIS
 --------
 [synopsis]
+git reset [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
 git reset [-q] [<tree-ish>] [--] <pathspec>...
 git reset [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]
 git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]
-git reset [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
 
 DESCRIPTION
 -----------
-In the first three forms, copy entries from _<tree-ish>_ to the index.
-In the last form, set the current branch head (`HEAD`) to _<commit>_,
+In the first form, set the current branch head (`HEAD`) to _<commit>_,
 optionally modifying index and working tree to match.
 The _<tree-ish>_/_<commit>_ defaults to `HEAD` in all forms.
-
-`git reset [-q] [<tree-ish>] [--] <pathspec>...`::
-`git reset [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]`::
-	These forms reset the index entries for all paths that match the
-	_<pathspec>_ to their state at _<tree-ish>_.  (It does not affect
-	the working tree or the current branch.)
-+
-This means that `git reset <pathspec>` is the opposite of `git add
-<pathspec>`. This command is equivalent to
-`git restore [--source=<tree-ish>] --staged <pathspec>...`.
-+
-After running `git reset <pathspec>` to update the index entry, you can
-use linkgit:git-restore[1] to check the contents out of the index to
-the working tree. Alternatively, using linkgit:git-restore[1]
-and specifying a commit with `--source`, you
-can copy the contents of a path out of a commit to the index and to the
-working tree in one go.
-
-`git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]`::
-	Interactively select hunks in the difference between the index
-	and _<tree-ish>_ (defaults to `HEAD`).  The chosen hunks are applied
-	in reverse to the index.
-+
-This means that `git reset -p` is the opposite of `git add -p`, i.e.
-you can use it to selectively reset hunks. See the "Interactive Mode"
-section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
+In the last three forms, copy entries from _<tree-ish>_ to the index.
 
 `git reset [<mode>] [<commit>]`::
 	This form resets the current branch head to _<commit>_ and
@@ -98,6 +72,32 @@ but carries forward unmerged index entries.
 	the submodules' `HEAD` to be detached at that commit.
 --
 
+`git reset [-q] [<tree-ish>] [--] <pathspec>...`::
+`git reset [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]`::
+	These forms reset the index entries for all paths that match the
+	_<pathspec>_ to their state at _<tree-ish>_.  (It does not affect
+	the working tree or the current branch.)
++
+This means that `git reset <pathspec>` is the opposite of `git add
+<pathspec>`. This command is equivalent to
+`git restore [--source=<tree-ish>] --staged <pathspec>...`.
++
+After running `git reset <pathspec>` to update the index entry, you can
+use linkgit:git-restore[1] to check the contents out of the index to
+the working tree. Alternatively, using linkgit:git-restore[1]
+and specifying a commit with `--source`, you
+can copy the contents of a path out of a commit to the index and to the
+working tree in one go.
+
+`git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]`::
+	Interactively select hunks in the difference between the index
+	and _<tree-ish>_ (defaults to `HEAD`).  The chosen hunks are applied
+	in reverse to the index.
++
+This means that `git reset -p` is the opposite of `git add -p`, i.e.
+you can use it to selectively reset hunks. See the "Interactive Mode"
+section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
+
 See "Reset, restore and revert" in linkgit:git[1] for the differences
 between the three commands.
 
-- 
2.52.0.rc0.426.g1df11fb20d.dirty

