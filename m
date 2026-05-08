Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8046B35F8D1
	for <git@vger.kernel.org>; Fri,  8 May 2026 09:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231262; cv=none; b=DUzcoG+oueBc8G34bde5RdVyER/675s8QqpkHx30hu7eReap4S1+shmDRSGNcYgD8QNpPCv1GfJAjKqq5XsorZvoOAaNvHxLaeHlxTc3DmRtwp0OYtiyhHJ168qAn5SQGvb7xFregZxFiJFF+J64oU2UdgxQNzvUJlDrMmeSi28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231262; c=relaxed/simple;
	bh=zEivSupvltVlfNTnD/lT0TWRXVeTJRBPkBx+wMJJrx4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=vC1J5GSwrZhh+1VGj70zWaJ3HENhzoJwLGmdMSLDiThXQ7yXxJ2HDO0R1OoAXqMuF1KVM5j1hJPuIcJTpAB9bwgzsHZpwCRQbe/3g0X5b7KP6PvaFSULJZpoJdDZPfFcTCoSr/JZ99116AvEDX18871+6ldq46C+Wn0glOdwJdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3HgCbVr; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3HgCbVr"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-47c941f6bdcso1105319b6e.3
        for <git@vger.kernel.org>; Fri, 08 May 2026 02:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778231258; x=1778836058; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hePwM+qbFL6G/iEXmTmWDA7AgGM67+sTlQJejHAc0u8=;
        b=d3HgCbVrYzsp1H0dn9l9NsS6D7mO7CFgoxLHxeZiGuVxeW/UqaqwqxMtbqvYYF5btq
         I3ywq+YvfR/Ci7wvRp/9joj6AXcVqYJD7pAJcydMZJQANNzcVlWQD96gS4nzzxLzcqEd
         oB3/HsExmcUkPLjNfvvUud89ughGzPzzhu26QfDn0Q/VDVmAqjdyTnAelzCHGNIMbL6S
         z0ljfMteRCRoVRqGcPgTG5GmjW3lFfdZ10Hyg/3mO2K9neQrDtNjmb+BzibwlJ12iVr7
         SvZXTJV6eo1vRw0fkuJpoFsd/rhKghEHcEqjwxMCt0iI3UWWhYVBFRZhqAQPM/j5+aRt
         TZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778231258; x=1778836058;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hePwM+qbFL6G/iEXmTmWDA7AgGM67+sTlQJejHAc0u8=;
        b=YuLdchMX0jd/idxVc4xioGuXhHSYltjjFOGfCNVpOZwDFBwDJYo4QomRCcSkj1Hf/Y
         aMkxK2qMddbZkEaduIAhZlfHKLj9Regj6GRnUqdoCTcxTS7nAvxPacRBYc3hx8zudN0e
         mPIBEjuMg7IAqlZnqU+mITiVWk5Sc9WVDGHJqbBEpZd/ZQ2jabg8KHJaCKFfdz05SFav
         i/TQjGGpBfa8UXvy/Rx75HG2REKFx/SfyQf4ZDrGi8Q9dEQP8s6mdEV2MbE0zyiy/sf0
         G7vwF6UmzsWQmBLm5X/Qzc6VuBmy9sIPL8E+UnlXKDqInsMdAx273NHZhl3Kv/ggrW9x
         ElFQ==
X-Gm-Message-State: AOJu0YxmsXzc8xfDe9X9ud7j5nCku6yDqDMKv2Pw0QsUakiQCUJrux8m
	GRlCb4KkfOmmH9XT5S2aWSQjuN0S/4JqtX6dWBGkMpOWZ5VTWxHuGqL01YZfRhso
X-Gm-Gg: AeBDietMjwjemoQu/zxhAkHooB7ES4mWbLerFE5TIZttasdVQIMfGy/+BmisWKJorvV
	HXEL/Agor68fT7RwbAvsE4EKFofrPermgkDhXXklJCoXK1AQzpmr2IyWVywQKgnPFivvOJ5EHYR
	iQPJOYTjm8ce7Mc3pcnmXBPjV+7a1h4W7IcsyusWrL/nGIaN1u2a5fUycW5Y64Te6raOMr7bg5d
	i1wYcYNEkzOf3AXL7bQQamtyVW6srAtOP5fuZj1LogSBHdcLJe+oPuzUG1tWJM/NNHKJCfznAl0
	CWrZtoLtXdTKPVb/b0Ld/+p7tQJmEsEb79vuLTsTEQMloWTjOOtF0RHp5iyDpnV+2cH+cpocTbO
	CKMFRDvd57eT28mpzQjhfbFfEOKL7Y8REu9Tq0MRgNc7VNrp/lwx6nJjVS9fjE/MSG1+Vn2SOF8
	lA4ZyR/OMcs/vfzUtD5I97ilF4IQ==
X-Received: by 2002:a05:6808:2222:b0:467:e7b:6fd5 with SMTP id 5614622812f47-48042503bbemr7143495b6e.41.1778231257859;
        Fri, 08 May 2026 02:07:37 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.139.86])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76986f9dsm14444166b6e.16.2026.05.08.02.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:07:36 -0700 (PDT)
Message-Id: <pull.2108.git.1778231254871.gitgitgadget@gmail.com>
From: "Greg Hurrell via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 May 2026 09:07:34 +0000
Subject: [PATCH] git-jump: pick a mode automatically when invoked without
 arguments
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
Cc: Jeff King <peff@peff.net>,
    Greg Hurrell <greg.hurrell@datadoghq.com>,
    Greg Hurrell <greg.hurrell@datadoghq.com>

From: Greg Hurrell <greg.hurrell@datadoghq.com>

When `git jump` is invoked with no positional arguments (and no
arguments after `--stdout`) it currently prints usage and exits with
status 1.

But there are two situations where we can usefully infer the most
valuable and likely mode that a user would want to use, and select it
automatically when they run `git jump` without arguments:

1. When there are unmerged paths in the index, the user likely
   wants `git jump merge`.

2. When the working tree has unstaged changes, the user likely
   wants `git jump diff`.

Detect these two cases and dispatch to the corresponding mode
automatically, falling back to the existing usage-and-exit behavior
when neither holds.

Signed-off-by: Greg Hurrell <greg.hurrell@datadoghq.com>
---
    git-jump: pick a mode automatically when invoked without arguments

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2108%2Fwincent%2Fauto-jump-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2108/wincent/auto-jump-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2108

 contrib/git-jump/README   |  4 ++++
 contrib/git-jump/git-jump | 16 +++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/contrib/git-jump/README b/contrib/git-jump/README
index 3211841305..420b20b6a2 100644
--- a/contrib/git-jump/README
+++ b/contrib/git-jump/README
@@ -55,6 +55,10 @@ To use it, just drop git-jump in your PATH, and then invoke it like
 this:
 
 --------------------------------------------------
+# pick a mode automatically: "merge" if there are unmerged paths,
+# "diff" if the worktree has unstaged changes, otherwise show usage
+git jump
+
 # jump to changes not yet staged for commit
 git jump diff
 
diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 8d1d5d79a6..ac0ad2f037 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -2,7 +2,7 @@
 
 usage() {
 	cat <<\EOF
-usage: git jump [--stdout] <mode> [<args>]
+usage: git jump [--stdout] [<mode>] [<args>]
 
 Jump to interesting elements in an editor.
 The <mode> parameter is one of:
@@ -99,8 +99,18 @@ while test $# -gt 0; do
 	shift
 done
 if test $# -lt 1; then
-	usage >&2
-	exit 1
+	if test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" != "true"; then
+		usage >&2
+		exit 1
+	fi
+	if test -n "$(git ls-files -u)"; then
+		set -- merge
+	elif ! git diff --quiet; then
+		set -- diff
+	else
+		usage >&2
+		exit 1
+	fi
 fi
 mode=$1; shift
 type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
gitgitgadget
