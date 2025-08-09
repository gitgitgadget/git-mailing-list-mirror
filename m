Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2444B275B0D
	for <git@vger.kernel.org>; Sat,  9 Aug 2025 01:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754702065; cv=none; b=keT5x1WLv599E/2fLzFNW8HWgl56iVpIW+uWTtjXLKAJZ+3YCI1T7RewsorUF9uxWNU1Y9pYBBx6OkbQYpvQQOd1WLbhzEfDW0hdn2tF3Iz8fHBV4322uh/CfMvZpn2EVXqVYmU+1GCr/4i6R3YvxstUGqN0bZYp5KPEQbghbuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754702065; c=relaxed/simple;
	bh=FeztmAaVgBVDc9j/1OG0V7xtEkXSzYpva8fSkB50s5U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TzWQ8KBjnc3NMqM4YYRu0+D82vIkEPk2Gx8MY4pvcRglyZ6zaf2gf9X0WaTFVFoPwWQ42+YIhwr6XzN7HmHCEq04YgyfLsgdEyN7JOMIntl6EqYUuVjYD4t/RO1KJ3QpomAJ0N35f++v9ksNMhSS6Oj7CZeFko8L/8//qtSjWDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALhIfIOZ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALhIfIOZ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b78d337dd9so1636606f8f.3
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 18:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754702062; x=1755306862; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xv1/2FTA09Hele32zfr52UcF1x5vbbVSHerVPV6hSyA=;
        b=ALhIfIOZQdMn7ltN4iVCSiRZbhEpW0S1bkMvFy8wjkdBzlwCuL6nsPbVeV4LbsyB1b
         GeYHnGotrOtJpzT2Z6Cdp6/hgqVR5tjdTScLVetzbYJapfuyKFbSKU747OA2K3nncqd0
         wHY3C3Ty47+g2007zsvseVxF3w2tDCPzyLHGX7QnrKxLn2+LINxZRCcn2KKXURdgEzSP
         h81QTBUrWMGwXbbZDZYKhIs9oAy7KiG/w7+VDMMU2VCfMiVsB8eHrnkkne0QH8PPX1Mv
         acCCjTNwESbe8tK4S/2zBfcxqSAGHdCX/BN5P7qghhxxKNTXEbnuNK5kjxbW6ekC+Z7V
         j3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754702062; x=1755306862;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xv1/2FTA09Hele32zfr52UcF1x5vbbVSHerVPV6hSyA=;
        b=ZrKIrAA0VStHC+82e9Wvi9DTCcuUF7FB80RX4AibbMT3pDyv3OCRV+f0PZ8gPKhmpC
         XnCmUywM+nCfojHrj95EooMVDmccxqteYJ1oyvpctJehmSsfI8wLSLUXpcVqdckOlU6C
         86NxuIUIH7LOMar8KNknJA2sgdFn13BCIpo7Xi/bFjIRGZV/TD/tfXIUiXUevUcUrkVw
         w5m484cGahfG99hGbi2SrXpSSKhh8UvmqcGFam6A6QKVcKidNW+LxK9UK3zbYpFSzuF+
         eIXI5V2gPVNMiKSZtKg4lag/njzWlVq9P0o3MrPi8iyTkcDdeA7Oxibd/Cuklas9fvQw
         0EEg==
X-Gm-Message-State: AOJu0YwTC0mOJHkfudgSAtAL/ku2czPueFmoakffS9VX5YtNgnP0GyTs
	EiOUo8ZHBjzUd/VQpTXLHm17s+GeDG3h+6pLdypnjrFUg5Lqu21W1y8UbEL2bA==
X-Gm-Gg: ASbGncult/rijTIe2qjDnwpgcLUoiLYTtXG7wMCOXdWNSAYAWTYOl216H+Zukjfdoly
	yoJp6OT9a9b1eD2okqFzMYZQwVhLEQS5tCK6X2c8cBHWQnDW8v37DdSeClQlEW2a/flP0lTPf4+
	ODDqRGWW1gRB+ihN4+CAwwlGlSDb8ZSRfhrIHcGeiHAvQRWDvmueJRZxzIstyn5G6HKuNnjcMcc
	CPAC2SvgoEfPC55VrrB9qzhzHXhxAWtHLuAExFDde4SWS7Tl7/GxrnKEV/wG7rjPM1e3y3EO2JC
	1hoGmObqYEd3CcaGji3Md2B4wzFez2AhvTWdL9kIGS0HmLciWaFafszMsra3h1f2sKrsYmUxE75
	f2Qz7GDcrjzYJYO4BRZQCVn8=
X-Google-Smtp-Source: AGHT+IHTvhl2qVRhZjasa0IdqOmBmTElx137Z7V+SxIWXKLWP2uAPKBZMG0HJ1UAZW2aPdDv49RVpg==
X-Received: by 2002:a5d:5f45:0:b0:3a5:3a03:79c1 with SMTP id ffacd0b85a97d-3b900b55170mr3609850f8f.48.1754702062048;
        Fri, 08 Aug 2025 18:14:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453328sm33756907f8f.46.2025.08.08.18.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 18:14:21 -0700 (PDT)
Message-Id: <061790686b9036cf862c5b918126eac1ca02a79b.1754702057.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
References: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
	<pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 09 Aug 2025 01:14:14 +0000
Subject: [PATCH v4 2/5] doc: git rebase: dedup merge conflict discussion
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Previously there were two explanations, this combines them both into a
single explanation.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 50 +++++++++++++++--------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 449f01fba560..e30b9535fff1 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -39,6 +39,27 @@ shortcut for `git checkout topic && git rebase master`.
     D---E---F---G master
 ------------
 
+If there is a merge conflict during this process, `git rebase` will stop at the
+first problematic commit and leave conflict markers. If this happens, you can do
+one of these things:
+
+1. Resolve the conflict. You can use `git diff` to find the markers (<<<<<<)
+   and make edits to resolve the conflict. For each file you edit, you need to
+   tell Git that the conflict has been resolved. You can mark the conflict as
+   resolved with  `git add <filename>`. After resolving all of the conflicts,
+   you can continue the rebasing process with
+
+   git rebase --continue
+
+2. Stop the `git rebase` and return your branch to its original state with
+
+   git rebase --abort
+
+3. Skip the commit that caused the merge conflict with
+
+   git rebase --skip
+
+
 If `<branch>` is specified, `git rebase` will perform an automatic
 `git switch <branch>` before doing anything else.  Otherwise
 it remains on the current branch.
@@ -74,13 +95,6 @@ any commits in `HEAD` which introduce the same textual changes as a commit
 in `HEAD..<upstream>` are omitted (i.e., a patch already accepted upstream
 with a different commit message or timestamp will be skipped).
 
-It is possible that a merge failure will prevent this process from being
-completely automatic.  You will have to resolve any such merge failure
-and run `git rebase --continue`.  Another option is to bypass the commit
-that caused the merge failure with `git rebase --skip`.  To check out the
-original `<branch>` and remove the `.git/rebase-apply` working files, use
-the command `git rebase --abort` instead.
-
 If the upstream branch already contains a change you have made (e.g.,
 because you mailed a patch which was applied upstream), then that commit
 will be skipped and warnings will be issued (if the 'merge' backend is
@@ -183,28 +197,6 @@ This is useful if F and G were flawed in some way, or should not be
 part of topicA.  Note that the argument to `--onto` and the `<upstream>`
 parameter can be any valid commit-ish.
 
-In case of conflict, `git rebase` will stop at the first problematic commit
-and leave conflict markers in the tree.  You can use `git diff` to locate
-the markers (<<<<<<) and make edits to resolve the conflict.  For each
-file you edit, you need to tell Git that the conflict has been resolved,
-typically this would be done with
-
-
-    git add <filename>
-
-
-After resolving the conflict manually and updating the index with the
-desired resolution, you can continue the rebasing process with
-
-
-    git rebase --continue
-
-
-Alternatively, you can undo the 'git rebase' with
-
-
-    git rebase --abort
-
 MODE OPTIONS
 ------------
 
-- 
gitgitgadget

