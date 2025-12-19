Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515361F5435
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 00:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766103881; cv=none; b=ar9mqhYfybDvTNn5is/sVPG0dCpszEeJM0/fnyGtpe3aAuysDLCm74xT1J8oMbMN1d5m3wIxxCOUembBy2Y+PWOB8AerdRTilYUj2PzvZSjF+tRmlF2+MLvhBxlctszrmqAG9yf5OAahGBA2gZpkTJKjg4Qoew7U/4ER/LMTS0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766103881; c=relaxed/simple;
	bh=KIdLeM2UxAkPjYQgofy5PO69UqL6Jz3/LBcr4Xh9UA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBoUGVpvNDiDqo7lFr6mW6z7e+7ew33PjztKkpvkibiaXxrpv86DR3GVxbXeX3MLtUBWmreRLYYj1xUoyHfqptqWalQuVKMqvnBWF+GnvTdOP1sp3Cmi6SXO3wGsMiB6K5qvehknjdVR9mQ+/okMtUTlLIoaKMAy5PD9v97pOWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k93AyoPL; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k93AyoPL"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78e7a16e4c0so11134427b3.3
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 16:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766103879; x=1766708679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51c52S8PiQ5lYoTnBdMugtNzagVue9scTNmxwzHP7bM=;
        b=k93AyoPLY9UlPDLSqCY4V4ju3SsU7aS2UyiX+BH5XXD7OhckW4c70QKhKDr7KebXH0
         xHStCQtYs10MDZalwZ84lpxD45j9Jw9IbwtorG64KYAklB8OWjq1z5UMi9Z9zIuZe5B5
         Yv3Pf7gXB6rVLeL8tGZzxN4DeTcHcnU3+am8wsP2VjsLF0tUU5jBMd/5wvoueE/qCwk7
         HuNplAkOGakDcyroLa8cLHTDPe1Ja3BS4oJBz+WEzf8bUcdr0rl53wRY81ITPh67nDXe
         MeW1D013zZnVdbkIc7s+nsZyjJlXtOlr4thbAsoevg+mysENhTQJOBaLr4bwEkE9b1C+
         j1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766103879; x=1766708679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51c52S8PiQ5lYoTnBdMugtNzagVue9scTNmxwzHP7bM=;
        b=FGZRZNtk2Cw3Uu/qnJLeKStwhQkPYehIYTycgsBNM/cHxizehIAqTWlyuGPQROLWWp
         mupSr+BasTM2P2XGnbBCUbURXOyBcGKnKU1UvtSdWLwKYxp9BBGzxIxQY5lu30+nZRnD
         +SpKqMF8et3YUy3i0OPHB7el1ffcZ2hXgS6Vwln1oCLuanRFb3SnJKVPFdm5k0S/5HOs
         4LGpMy7Qj8pIkmSjRZNVveq3MoOe4GHoKsaDsWQcphiiV0l5EL7TL3+e0W/j1Y4lyHtY
         ggs8o9ngzv/5feYn9DwEgg0jXp4Ar+SkGM3BmWTPjTJXh/zFKjOVjLXhAqrlH3uCITFY
         8ZxA==
X-Gm-Message-State: AOJu0YwIkWIo0eZ8lz2dpoMreHsc2CnBxiazo0nPC7MUsKDNh53uL4Zp
	uAiEclgyhtVUBpZORo+KJ1eC+XTqhGrNZpTJ57teuzo20RZJJDn3//UpS5az9g==
X-Gm-Gg: AY/fxX7zHRpniluBpSaRh8W9SrdQBjeD+AHVFfBbuX9edkaPTAUheE2aTB2UJ7RIAoQ
	gqzENnuU9BbhIWd68qCUpm/VIc6qhuC6u9iqX086uQ8YD9EfBOIHMKIyjkrItb7iuOsYdXZPrlJ
	KMIWdamhshnXYM+M3C8A45Aj+/IElvXCUzGdOi9JF4xvCGnfNz3MLe9Vg62UPR3rN3gsS9Cbq7l
	y37y0x/ItEpaMqrMnxEtao8FmazjU/Pg13FCzMrZRTtSQa+fAXxtU24QEAea6lFEKmw2jZruCZQ
	7fEyV+jlNiFSk/pDPteSPK9QazvpFGC75qLHlD8x9I7P265mt7xBc47OJpFsoJ0xAqXNcnHn2ns
	XkMSlTLmX3lfJtBP6fz8H4jtjWPym4MhDcjG2H3Z5WrKhyABV623n+jRc6+1o3lltMWVBQdv/Mb
	TSCimm+zahmaBSRFU=
X-Google-Smtp-Source: AGHT+IFrvVM7JoPID31u3ZH4liGlnjZ5JHhO6b2L1KRoYCGnkm2ZXz24BK7F+IlZB5NNaypOPSqVhg==
X-Received: by 2002:a05:690c:22c3:b0:784:8cb4:d935 with SMTP id 00721157ae682-78fb41dd553mr10633517b3.65.1766103878892;
        Thu, 18 Dec 2025 16:24:38 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90a8:8b00::a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb44f0dcdsm3658427b3.30.2025.12.18.16.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 16:24:38 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: Julia Evans <julia@jvns.ca>,
	Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v2 4/4] doc: git-reset: clarify `git reset <pathspec>`
Date: Thu, 18 Dec 2025 19:23:56 -0500
Message-ID: <d6582dc53ca852ef01421d2dd2c446dadb731dad.1766103827.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.365.g9bf09b728d.dirty
In-Reply-To: <cover.1766103827.git.ben.knoble+github@gmail.com>
References: <pull.1991.git.1760731558.gitgitgadget@gmail.com> <cover.1766103827.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Julia Evans <julia@jvns.ca>

From user feedback:

- Continued confusion about the terms "tree-ish" and "pathspec"
- The word "hunks" is confusing folks, use "changes" instead.
- On the part about `git restore`, there were a few comments to the
  effect of "wait, this doesn't actually update any files? What? Why?"
  Be more direct that `git reset` does not update files: there's no
  obvious reason to suggest that folks use `git reset` followed by `git
  restore`, instead suggest just using `git restore`.

Continue avoiding the use of the word "reset" to
describe what "git reset" does.

Signed-off-by: Julia Evans <julia@jvns.ca>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 Documentation/git-reset.adoc | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
index 6de0d524c3..ab7f565286 100644
--- a/Documentation/git-reset.adoc
+++ b/Documentation/git-reset.adoc
@@ -81,29 +81,25 @@ linkgit:git-add[1]).
 
 `git reset [-q] [<tree-ish>] [--] <pathspec>...`::
 `git reset [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]`::
-	These forms reset the index entries for all paths that match the
-	_<pathspec>_ to their state at _<tree-ish>_.  (It does not affect
-	the working tree or the current branch.)
+	For all specified files or directories, set the staged version to
+	the version from the given commit or tree (which defaults to `HEAD`).
 +
 This means that `git reset <pathspec>` is the opposite of `git add
-<pathspec>`. This command is equivalent to
-`git restore [--source=<tree-ish>] --staged <pathspec>...`.
+<pathspec>`: it unstages all changes to the specified file(s) or
+directories. This is equivalent to `git restore --staged <pathspec>...`.
 +
-After running `git reset <pathspec>` to update the index entry, you can
-use linkgit:git-restore[1] to check the contents out of the index to
-the working tree. Alternatively, using linkgit:git-restore[1]
-and specifying a commit with `--source`, you
-can copy the contents of a path out of a commit to the index and to the
-working tree in one go.
+In this mode, `git reset` updates only the index (without updating the HEAD or
+working tree files). If you want to update the files as well as the index
+entries, use linkgit:git-restore[1].
 
 `git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]`::
-	Interactively select hunks in the difference between the index
-	and _<tree-ish>_ (defaults to `HEAD`).  The chosen hunks are applied
-	in reverse to the index.
+	Interactively select changes from the difference between the index
+	and the specified commit or tree (which defaults to `HEAD`).
+	The chosen changes are added to the index.
 +
 This means that `git reset -p` is the opposite of `git add -p`, i.e.
-you can use it to selectively reset hunks. See the "Interactive Mode"
-section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
+you can use it to selectively unstage changes. See the "Interactive Mode"
+section of linkgit:git-add[1] to learn how to use the `--patch` option.
 
 See "Reset, restore and revert" in linkgit:git[1] for the differences
 between the three commands.
-- 
2.52.0.rc0.365.g9bf09b728d.dirty

