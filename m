Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AC421FF53
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949081; cv=none; b=e9ZktMkSQ/WIoep3aVPfidxbSorvY5LT6XCmBdwctnWOytOQySqeCBL2pt31EHqfp+D/Pa68VCl3NKaZC0VyiiwG0OjiJG0uy3ou050aKUniUJBrVBZOWcyAH4Qc+4nj2UD2qm3g51so+MqaUH20QKqfLLbaA27mKeTda1jAJaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949081; c=relaxed/simple;
	bh=zv1Qp7WHKpWgLyeZFXJrdToWkz46Ro+JeRyyTSwMcIg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EYOjD6o7Jd4/lxekSfwaaVB1YZjhz4fa9VdP8IXuHO+pz2ouYHRhjXrE3wwpKcHviRk0gLYXLnjRqpElFr+FNu5f9Rcu1GHjIcWM74FhAHA05LVnwY7mRjd07gQCmXPQz+2zs/hT6S4ZcTmVgvMQSVTEm5nBEYq075sZ2hzrM34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OH4EXe5R; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OH4EXe5R"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b7961cf660so3885079f8f.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 14:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754949078; x=1755553878; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oQc0uVpWvCny1ZGlUNwBc8xRvmihROYVwRfD68hBUA=;
        b=OH4EXe5Rutbh++RoYqEg6HTUBE6TcdVNTw51fymv91fBpK6nm6lqRCNOC65yYFJEwX
         O81Z/JSEGg605jYDVrSgHP0yZkjkanTyWTOsqsomrwuA/yk7gwSx7pElclZXAPUByHY5
         Lojuslnq5FsVx+ZeNM+K9qtj7niibHJ98XqFjhsCb6NaeA3YhCZaIP2if91Bl08OfT07
         4iaHc8hJbnhe8bAYI9eoRqa9uL+LZapQ2YWEyxO8SWltM7TZ0yvsDtbPN5NYsOrfYDcr
         MiBlvd3iVKHHKcCoe6gpDyuhHY0qYAkFheC7KneePPeSQftvn90tco6CFgM14JFWA2ts
         uRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754949078; x=1755553878;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oQc0uVpWvCny1ZGlUNwBc8xRvmihROYVwRfD68hBUA=;
        b=CuzWOGwhhdepbxAtxJQuMkdhhqFutNL6VJqwRF5p/YhVaPYRV24sGAgOEqqQVSVsWC
         IRK2nBJi0amYykmWoe2Lc2s7o6Fj9L5/2rI4ukT7WJHcWNrnh8bNGIY0Vorg7QN369V9
         yvcMBEFGpD3YvjWKTqvu+yWkSDb8ZPoi+Xu02pqbDGrNRjtEueh4ownjADzVuBoJog+N
         OqRH/xN18XyRqxkK2Jw58OQ+SHinCr6rpEbXsv5tuvO0ibb2nY/ho8dHv2P52e1gVCV1
         wSr6uqL19YcSapKLl/nFe4lErravx9XENYRLee8k2x705el11C9BnOcq8LeqThMhwa5/
         PWwQ==
X-Gm-Message-State: AOJu0YzEQJ/ivJITKnlnH0g4osdAOJPV3KW8C8zbLme4MOOlVbVXKzTZ
	jeZzrfg13RxzeCqot0C1qVH/oIK8+brrBEvzQGhfQtm4Gli7UhTfKOR0Br0h6g==
X-Gm-Gg: ASbGnctFqbpFDoKXNmog+bRHNywRHMtQkokuM1tESmW1WiLSuxzqguqlvdUpLnaN1qu
	FJAINV4Q7JuvABWVvn06sI/PCbjpZ5zNzBAO13IjC45AD5Vf8PTI8B7+qEj1t4vbEII6rn3ubcL
	30aOlWYM4vSaqeLtxWMwCP1qMjSQkisReyqei70q10lfpakzVnXIOGxW+4x728WTgI455BuTioY
	uwjESxHHWODJ+gYAvjGNxoQV4vGaG7DDbH9tDS+lqlNqvx/ETgwB5SVA/tRxq2DHOPHaknnSpxb
	a6YjO6o5wpJZtB4tywabVgqvg+XutC3r7OEv/b12FamT5Pwmb5PF5yUtVWlfKrLbidRGgoOq/UU
	uuXxp21Sin65EHw/0YeOgTSc=
X-Google-Smtp-Source: AGHT+IF/5QuhRTiVwb2kiOBzCDMw/R7PwysFGALl6MSkuKypfj314kLz2/ocxq3mAi/ZqYhew1TXeQ==
X-Received: by 2002:a05:6000:1ac7:b0:3a6:ec1d:1cba with SMTP id ffacd0b85a97d-3b900b4dd2bmr10257693f8f.20.1754949077929;
        Mon, 11 Aug 2025 14:51:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e009e465sm33526432f8f.43.2025.08.11.14.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:51:17 -0700 (PDT)
Message-Id: <e7a8fbbe53c9cf5cb7b8d822e72ff4219de37e1c.1754949075.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
References: <pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
	<pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 21:51:11 +0000
Subject: [PATCH v6 1/5] doc: git-rebase: start with an example
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

- Start with an example that mirrors the example in the `git-merge` man
  page, to make it easier for folks to understand the difference between
  a rebase and a merge.
- Mention that rebase can combine or reorder commits

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 52 +++++++++++++++++------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 956d3048f5a6..bb5a3ff7f828 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -16,6 +16,32 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
+Transplant a series of commits onto a different starting point.
+You can also use `git rebase` to reorder or combine commits: see INTERACTIVE
+MODE below for how to do that.
+
+For example, imagine that you have been working on the `topic` branch in this
+history, and you want to "catch up" to the work done on the `master` branch.
+
+------------
+          A---B---C topic
+         /
+    D---E---F---G master
+------------
+
+You want to transplant the commits you made on `topic` since it diverged from
+`master` (i.e. A, B, and C), on top of the current `master`.  You can do this
+by running `git rebase master` while the `topic` branch is checked out.  If you
+want to rebase `topic` while on another branch, `git rebase master topic` is a
+shortcut for `git checkout topic && git rebase master`.
+
+------------
+                  A'--B'--C' topic
+                 /
+    D---E---F---G master
+------------
+
+
 If `<branch>` is specified, `git rebase` will perform an automatic
 `git switch <branch>` before doing anything else.  Otherwise
 it remains on the current branch.
@@ -58,32 +84,6 @@ that caused the merge failure with `git rebase --skip`.  To check out the
 original `<branch>` and remove the `.git/rebase-apply` working files, use
 the command `git rebase --abort` instead.
 
-Assume the following history exists and the current branch is "topic":
-
-------------
-          A---B---C topic
-         /
-    D---E---F---G master
-------------
-
-From this point, the result of either of the following commands:
-
-
-    git rebase master
-    git rebase master topic
-
-would be:
-
-------------
-                  A'--B'--C' topic
-                 /
-    D---E---F---G master
-------------
-
-*NOTE:* The latter form is just a short-hand of `git checkout topic`
-followed by `git rebase master`. When rebase exits `topic` will
-remain the checked-out branch.
-
 If the upstream branch already contains a change you have made (e.g.,
 because you mailed a patch which was applied upstream), then that commit
 will be skipped and warnings will be issued (if the 'merge' backend is
-- 
gitgitgadget

