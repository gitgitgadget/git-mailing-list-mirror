Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2183376A6
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703321; cv=none; b=Jt1hGQMhy4bFynPlR99wRjVt7doA272d1UUCmdKHyXN4Ah9i24wCsYhR7XZcoHpD4hBIKhM6subvmWwPd4XtYuKXB7cNROW+FoU2UMTot1lGVtPaFgcIZyWP253CltSYECK4ap7/VnkFpUNSpRM+FtHisvBymNgCWc1xHb5RNxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703321; c=relaxed/simple;
	bh=THsjd64h3D+Uhz4r2qlj07fKKh7ECYRUEBPodGh+QR0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pRAudZQ/kNygyWLmJnUnTfoLnOf6c4ByoiyUL3saNvHDhaJWvEi/Vs3heJU68gZ9EMS2JyS9gQ5gLvQAeW/E4tlAlPuzsRix/TyIZa5GYCALEDaHWGA39qUKGJMN5qIuBpMzvERZkYgeHX01F1NxFStkSkYdVDLJ/xuwcbUMcok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6AZri9E; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6AZri9E"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-88f49be4c21so59840839f.1
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 11:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757703318; x=1758308118; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtGw5/sNH5Bpxufyyr3tvmRkwRO3TPdQzneqSpDkkQ4=;
        b=Y6AZri9Ecic3YuEDq/9uiiPCcis/NFQmUzBTcJ4pgDThWKB6wZ02b6ktT/Z8TGq3Xf
         hirh30WK+hIjbKI3ZbAp3+v0QqOT47tZsanbSnfHqHq/HN0es8oNXLEi5Rnv7TAElIlg
         Q5Hkf7muS9K3igK0D9SsaUTg57ylIFpuheBJp7cBrOpLfn2wMWaNIKNHbqVpLgb3pQhB
         oYUQOHzIldsVMRKxSDiO8+E4zVjD5T8nASoA5reY4YCdzU/Wngs4jCjNhdgrQOkB3XrQ
         Iy/pg5QCb5h23wC1zNw80kUvNeXPiq6Ls3BTeaZ+XWHhGdfCITp25n6cGBoj6v8VoZj9
         ssAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757703318; x=1758308118;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtGw5/sNH5Bpxufyyr3tvmRkwRO3TPdQzneqSpDkkQ4=;
        b=rDnfhoZw+Vxt7QqiisK35XbPM0K6PawivJEKQ1xelhfwa7MdNJn+jaBHT6ZoYK6/YC
         9w0b4TliJinW1qmPFXipCC2JQo1r0iCAh/OnKPjd2HprRM1K3gn8R0pHgHhLCP0UW45P
         I4U8muBzJkBOMW1j/4clynFkA3FO8x5L+5jbspagye47oY6hDxZVgJbCLQ8ucqJRR4qk
         DfUv1sbOtmE8l49hqsf/LVd69D50bNOcHk9DXFa1uISv5mUwzg1aWqddm9l3mTVIXnAc
         UScI70EB7b6v+qyRa8IqfY0qbhjJAVTurSmaYn0xxOYcnCmHfBPUGs7auyUQ34PUDHXn
         wm6Q==
X-Gm-Message-State: AOJu0YwCS8OYZObuKY7vwsnjlvW9pSMDLi4WCmpGOQPiULqG6b6hKpc+
	oJq8BrZ0+8CCvGu/QXY7kJyyOD0FYI5NtL/2XwHIAa9zK++Vu0bI6e6Fiep76A==
X-Gm-Gg: ASbGncu2Kg+hV84Xhy17g4K2x27EaWP4gcMrcT2shZ+bPF796jE2eKrJjDTtaM9707x
	x3HGI/DaFUBaL/FBxRVlT60HqqU8EghfEPI1eHV+D9INKE7n5Py7tFzgJ8dQNIM1Qj/tFxJBXB6
	ziKdpfiiWuC6uqby2oFZiSOdLQtbUyZnYyhpkTUQVMRrYpaCGMWwD44GidhJAl8FTSnZ9SMtdVz
	dhhjH8EdAp8dA8fTmbG/5pDnellr8H1n83Q/A5PKSSKh4ZQkpkMEOSnnm1Vnj6WLJEt1OxiICjl
	8XQEi4y2VdssdJhbUv62FXjIxyS9HJM6ezGWco06J1XZGdV1Ew1oW6Lr3sOujYiTysLyTuee/P0
	q7uyBwc0V++7ljuENMnHNZnaOvAM=
X-Google-Smtp-Source: AGHT+IH6HY8bJ6OS+1oRId3BhELyoXHEy6wCa5d0qsyaYc36ZdxPzFdGnlrlWCjqu0K4m7tkJUkmmw==
X-Received: by 2002:a05:6602:496:b0:887:3efb:6101 with SMTP id ca18e2360f4ac-89032ddeb5cmr738589539f.7.1757703318183;
        Fri, 12 Sep 2025 11:55:18 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.157.180])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-88f2f0f96bfsm198581439f.18.2025.09.12.11.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 11:55:17 -0700 (PDT)
Message-Id: <59732f1e4783372d3d997f43b028269831719f63.1757703309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
	<pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Sep 2025 18:55:09 +0000
Subject: [PATCH v2 4/4] doc: git-push: clarify "what to push"
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
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback: 6 users says they found the "what to push"
paragraphs confusing, for many different reasons, including:

* what does "..." in <refspec>... mean?
* "consult XXX configuration" is hard to parse
* it refers to the `git-config` man page even though the config
  information for `git push` is included in this man page under
  CONFIGURATION
* the default ("push to a branch with the same name") is what they use
  99% of the time, they would have expected it to appear earlier instead
  of at the very end
* not understanding what the term "upstream" means in Git
  ("are branches tracked by some system besides their names?"")

Address all of these by using a numbered "in order of precedence" list
(similar to the previous commit), by giving a little bit of context
around "upstream branch": it's something that you may have to set
explicitly, and referring to the new UPSTREAM BRANCHES section.

The default behaviour is still discussed pretty late but it should be
easier to skim now to get to the relevant information.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-push.adoc | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index 909c69766c..2b2f753db4 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -27,18 +27,20 @@ argument (for example `git push dev`), then if that's not specified the
 upstream configuration for the current branch, and then defaults
 to `origin`.
 
-When the command line does not specify what to push with `<refspec>...`
-arguments or `--all`, `--mirror`, `--tags` options, the command finds
-the default `<refspec>` by consulting `remote.*.push` configuration,
-and if it is not found, honors `push.default` configuration to decide
-what to push (See linkgit:git-config[1] for the meaning of `push.default`).
-
-When neither the command-line nor the configuration specifies what to
-push, the default behavior is used, which corresponds to the `simple`
-value for `push.default`: the current branch is pushed to the
-corresponding upstream branch, but as a safety measure, the push is
-aborted if the upstream branch does not have the same name as the
-local one.
+To decide which branches, tags, or other refs to push, Git uses
+(in order of precedence):
+
+1. The `<refspec>` argument(s) (for example `main` in `git push origin main`)
+   or the `--all`, `--mirror`, or `--tags` options
+2. The `remote.*.push` configuration for the repository being pushed to
+3. The `push.default` configuration. The default is `push.default=simple`,
+   which will push to a branch with the same name as the current branch.
+   See the CONFIGURATION section below for more on `push.default`.
+
+As a safety measure, `git push` may fail if you haven't set an upstream
+for the current branch, depending on what `push.default` is set to.
+See the UPSTREAM BRANCHES section below for more on how to set and
+use upstreams.
 
 You can make interesting things happen to a repository
 every time you push into it, by setting up 'hooks' there.  See
-- 
gitgitgadget
