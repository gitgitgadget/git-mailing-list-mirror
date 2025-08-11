Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E3F246783
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754943231; cv=none; b=WA36EhvpUIKJr9k1TzfVVhQaj46/sDzM4tm0HVCxbD5TJ4ov8goC+CN0i0nQ/OpqR2K85U8Qu4qAiJMBY6JrnC9Crl4xqwvJNaWTaHINZ/9+EiX8FAWIMjXdZi1dYhkZEanH8A8zByVVKg3t9KNVy7r7eZ6yO7rCHvLnlSLLv2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754943231; c=relaxed/simple;
	bh=3BGHUZu9fubCEFdr8NvEv/e//LYA40oTufTaGyIc/wE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oV7c5Kps9ua9W6Kn4n9m8+7D8BfQKW1u+Mt7S0elU8pDEE1RiuzXAdSQJ5F/fp8ZUasNM9ODhFLnVoOo+rLKC9Z9VBkxdtUWXTIyyVRnNIXaP8+5/RDAkpDa6jRHULpygp71IpsbV7+IPXONDnOtOV5c9uD1oDT5iPsst3as7t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDI9MMLN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDI9MMLN"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b7862bd22bso2877004f8f.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754943228; x=1755548028; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KplK85vCAI6MG79I1tYeIHJxu2eE9P+Fhrny8j05G0M=;
        b=EDI9MMLNHAlc56JAWzVGBLn+XuhMUN0gx7741+BDkdTGCK+kqQ2ONvCoIqz5Jyr3Qw
         OuOEZOYutR1khyqkTOEQibHMlJqy1DZTJgcvr5RIcQILmUHq6q+k6qQ8OOI8r/A9owJk
         u3AN4AbrR/57ldRXx9/wA7sTPsI+k3B9zZNUrbRTLCPCzJmgDcOwkXIvAe/BBxabE0Pq
         ebcLRvJ4fyTudbsmbd1Ip+Q/mHYgYll68CEWWfPoyOTRfCJBXLqkd8nz/hJ6ftvxl2c+
         i6XpBY/TW6R1CLu+Imm88vKZ8+foaHIsfdkss5RoSR999ady7iXaLDTS9E1QVz97lnhJ
         FCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754943228; x=1755548028;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KplK85vCAI6MG79I1tYeIHJxu2eE9P+Fhrny8j05G0M=;
        b=QLBTZMQM7WwfM5JAHVdCblZKY7nO6WLFH/tA8L64LRi35ZCi5hX8erioIs2ZeMCVBY
         zNlFWCBYH94IJpqiB/O1UAyNcGPg0MkhzXT5/ff46+NumF+a2uqlxcBAyeQr/3w329Vt
         vvfNiydkU2ZD5Ak4cU3SuI6jnT6H+4bqmTMcVxyrivc43Dd11mWwHgdYr3dsSQtwhS4D
         dLjJMBaazkAfmjHSjmUZIUtjByERgc2FR1hFV0RmyOr7J+Ac3/KtDpvJHkiJWbfELVPt
         0pG9rP39qJq1gdju24mcccZv/4a6KcJcNPi0+uQwAYDR7KR9vuHo7dniHimDHYZPUeF7
         1SeA==
X-Gm-Message-State: AOJu0YyxmaNeqmSXqIluSId8N2m7J6vxhfSYDqCFiZfkktvIS6rKM9Ns
	ndoUX1/q6mIbRBvJY91rIyViBR/Y+jhafo9Y34vY9+m46rVdOheVL5SU/5k3sw==
X-Gm-Gg: ASbGncswQYfN7v8Qkwq+OY0t9om0SQj2cKwEf0nPewjStvYULwQgb7ArdkGKZmZNn/2
	kLdWpGRrXCsDWv5z/99phmSyqmu4AZKzKuIYUiNgj2FiffwuNHQXcLq+fCe0cttSsSLDTQH4gIz
	S2V9NDBTV5L6oyANynU7jctxZRaTUj5KyeZ60rvnxFLIX9WtzcsK1vCZV+J6Tb/0mQd72gw9SUU
	f1qxe121772POZh8m6QooupursCcHAuPXpPXlSdtOTe50Bc6VtdiLNEoecCV9Xq68mLcB9KlDt1
	W7Xtb+acua9nAqwvsdHpTuetSixVUUEcm5xLgLah765XKGZm8IGvWeY4wbhlCaxdU9qtbV8rYo3
	dZroRl2yYdv7WsyvOUFbeGx0=
X-Google-Smtp-Source: AGHT+IHvFcKUWMcC1q+gl/qRtWNbdZ1PveotEHw4C2msTAdpkeZ5JX5k6+c5Y+Va8MruKANm0mPBkw==
X-Received: by 2002:a5d:5f81:0:b0:3a5:8991:64b7 with SMTP id ffacd0b85a97d-3b9111f458bmr718499f8f.26.1754943227536;
        Mon, 11 Aug 2025 13:13:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459ee17535bsm230810615e9.16.2025.08.11.13.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 13:13:38 -0700 (PDT)
Message-Id: <5ab235b067b40e468185ee905f735ff73ccc9552.1754943127.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
References: <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
	<pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 20:12:07 +0000
Subject: [PATCH v5 5/5] doc: git-rebase: update discussion of internals
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

- make it clearer that we're talking about a multistep process
- give a more technically accurate description how rebase works with the
  merge backend.
- condense the explanation of how git rebase skips commits with the same
  textual changes into a single bullet point and remove the explanatory
  diagram. Lots of things which are more complicated are already being
  explained without a diagram.
- remove the explanation of how exactly `--fork-point` and `--root`
  work since that information is in the OPTIONS section
- put all discussion of `ORIG_HEAD` inside the note

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 66 ++++++++++++-----------------------
 1 file changed, 23 insertions(+), 43 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 750f5e67e4c3..b4e5519d2839 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -68,51 +68,31 @@ linkgit:git-config[1] for details) and the `--fork-point` option is
 assumed.  If you are currently not on any branch or if the current
 branch does not have a configured upstream, the rebase will abort.
 
-All changes made by commits in the current branch but that are not
-in `<upstream>` are saved to a temporary area.  This is the same set
-of commits that would be shown by `git log <upstream>..HEAD`; or by
-`git log 'fork_point'..HEAD`, if `--fork-point` is active (see the
-description on `--fork-point` below); or by `git log HEAD`, if the
-`--root` option is specified.
-
-The current branch is reset to `<upstream>` or `<newbase>` if the
-`--onto` option was supplied.  This has the exact same effect as
-`git reset --hard <upstream>` (or `<newbase>`). `ORIG_HEAD` is set
-to point at the tip of the branch before the reset.
+Here is a more detailed description of what `git rebase <upstream>` does:
+
+1. Make a list of all commits in the current branch that are not in
+   `<upstream>`. This is the same set of commits that would be shown by `git log
+   <upstream>..HEAD`. You can use `--fork-point` or `--root` to change how this
+   list of commits is constructed.
+2. Check whether any of those commits are duplicates of commits already
+   in `<upstream>`, remove them from the list, and print out a warning about
+   each removed commit. You can use `--reapply-cherry-picks` to include
+   duplicate commits.
+3. Check out `<upstream>` (or `<newbase>` if the `--onto` option was
+   supplied) with the equivalent of `git checkout --detach <upstream>`.
+4. Replay the commits, one by one, in order. This is similar to running
+   `git cherry-pick <commit>` for each commit. See REBASING MERGES for how merges
+   are handled.
+5. Update your branch to point to the final commit with the equivalent
+   of `git switch -C <branch>`.
 
 [NOTE]
-`ORIG_HEAD` is not guaranteed to still point to the previous branch tip
-at the end of the rebase if other commands that write that pseudo-ref
-(e.g. `git reset`) are used during the rebase. The previous branch tip,
-however, is accessible using the reflog of the current branch
-(i.e. `@{1}`, see linkgit:gitrevisions[7]).
-
-The commits that were previously saved into the temporary area are
-then reapplied to the current branch, one by one, in order. Note that
-any commits in `HEAD` which introduce the same textual changes as a commit
-in `HEAD..<upstream>` are omitted (i.e., a patch already accepted upstream
-with a different commit message or timestamp will be skipped).
-
-If the upstream branch already contains a change you have made (e.g.,
-because you mailed a patch which was applied upstream), then that commit
-will be skipped and warnings will be issued (if the 'merge' backend is
-used).  For example, running `git rebase master` on the following
-history (in which `A'` and `A` introduce the same set of changes, but
-have different committer information):
-
-------------
-          A---B---C topic
-         /
-    D---E---A'---F master
-------------
-
-will result in:
-
-------------
-                   B'---C' topic
-                  /
-    D---E---A'---F master
-------------
+When starting the rebase, `ORIG_HEAD` is set to point to the commit at the tip
+of the to-be-rebased branch. However, `ORIG_HEAD` is not guaranteed to still
+point to that commit at the end of the rebase if other commands that change
+`ORIG_HEAD` (like `git reset`) are used during the rebase. The previous branch
+tip, however, is accessible using the reflog of the current branch (i.e. `@{1}`,
+see linkgit:gitrevisions[7].
 
 MODE OPTIONS
 ------------
-- 
gitgitgadget
