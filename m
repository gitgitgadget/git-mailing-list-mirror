Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E995D72637
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 01:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751418802; cv=none; b=QExailLuW0YJ7Sf13GxL7YXs5/tKoqLJY6ik3DxszQgpYkuLfB4N5QNOqNJJIlNe08MdhHz8JpcUJgV10QcpRiG+yRUGPifful7I269mSLThMjJ4FnRDTH+YDR0QsF0i4OtB0G0T7PfmVssAgfgGVO4L6rON+7slvZHbPdTxm9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751418802; c=relaxed/simple;
	bh=9BpDpWm/OOD4j2qYqVC6JKrD/zE8f/cIafYEf36R3JA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G/7QLNerbp+PLKjbG21fD1iAxQ7PAmIgZPY1PW8vrZ606LMgO1L38Nm00YqLw5h920FWhN3roYTuipjJDmbyBSPWeqH4vlGpMlOvUA07jhzpuozTDAQGG7SxePPROXlY78deeihiGcsShQfjoXZ82qDsLSyeTgP0ti3MrpSTkDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHyZroTX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHyZroTX"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23526264386so35685525ad.2
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 18:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751418800; x=1752023600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qe+nPT3O1BHBmAEswUqA3+RsBt+tmI2fqetwrM8swtk=;
        b=DHyZroTXhRfbBVFpFofWlWMyc1SCB9onAdhZ+kdapVMZzcSPha7QLEGlR85aNzJs87
         tF9IG4GONvzD9Tp20NMGFIzDIDVMLNg1gj38w+g98TmKe/2lzE1RwoeiUDhkduYIbtdk
         py4W2BMlTJCV62FiMesxwtfpLmwjIOLjrUlm55e5ejvucffns1fSHQXRrpxtZaDwvTd/
         oE4FSKMsu1qAp70Yml1GnipF7B0vm350dmP9ish4zd3hxzJGAt89yPdxCPZE/JfNpbe+
         34XAFJSDgmQAUegQqNZ38UfjrQgJXogtgbhPtpAv3IHVp3u8xGXrU3QLD2TSDHbfJsJv
         onow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751418800; x=1752023600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qe+nPT3O1BHBmAEswUqA3+RsBt+tmI2fqetwrM8swtk=;
        b=Eb+pnGGgHnB19oRSUpnZMWDqW9SworlLJP2AsZFHYvueghe1RE4t2ayJWHM+t+y4xQ
         SB3sUKA23j+1v7Kd17C65Ow8R5xrRN927oS95LzqYMv7uumS0g+3Oz4dl1gGMgVfgf/3
         3Pq5zeJNVIsWsooXX1pjZXuf90Mx7OGadQ+4cYslg9MUlFCz7XMuqjGzx9Aiy+uhoEtd
         6V19on60hOiNy1ugCr/rasFeEnOB7fh1eYCB75WRw7rBDOMvIlGHJJTfQwFTCe8k/6NF
         uzjlpGGVDAfUcxQq6y07XqIEwBcbZWxR8lnPSkYUYa4OHFl7iWSKAEafvPHrFpRNty69
         d+BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN2/+j7I3EAZk76p2JtydIJ8egiYqY9PFVTOwLhfs4usdqv+6Hz5L3nB4pyDaEbV97aE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgZ5nG7YpZLQpmyePcTkzoLTKZ98icnpAiQhVTq+8OkDs/HH+q
	GNhY7sp5aPyDG3aBrAOe6BYbPP0sxvbKsPxx2wQyiSLDHQ+BW2tfZaDi
X-Gm-Gg: ASbGncsRF7SrHc/GivkDixkJDFejxJFvM1roMF4UEJ/nFx5/Xq3Pi+TAZKnsXh/3dyi
	33+nGxpaau8O48nJbeZIzB+7ijcPePWOHYPuTvFVHaKBrI9cXLctqoQ+IGrnhzhnifz+T1BpXaY
	aI1Dl2TLqKIzQBel2hnqHkGesf15CEYWMnm5Zy6R4xooK2WpHPoBOUkLKrdZY/O2vgkHSqWrb/V
	9KdF5x+pV0Dj9IEW7fDvzQNjQlWWq0VnkpzumKq+JE7mzyQJYQ3S024UrpC5qqpAoNxX8VY7y+1
	Abk8iexvUIAH0D8G/IJc5tI4NZ94i9kg0ohjyCMWj4NlFbjqjlC82uRN51w=
X-Google-Smtp-Source: AGHT+IE8BfL0qCoQe8+25fKNrpoWyZuHzvu/IwyYaJ1EfRVuru1mcPbhAcBlIju4dGrHsLnV2hyyBw==
X-Received: by 2002:a17:902:c942:b0:235:1b91:9079 with SMTP id d9443c01a7336-23c6e589789mr10657445ad.32.1751418800144;
        Tue, 01 Jul 2025 18:13:20 -0700 (PDT)
Received: from dev-phord.dev.purestorage.com ([208.88.159.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3af74fsm123208125ad.148.2025.07.01.18.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 18:13:19 -0700 (PDT)
From: Phil Hord <phil.hord@gmail.com>
X-Google-Original-From: Phil Hord
To: gitster@pobox.com
Cc: peff@peff.net,
	git@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Phil Hord <phil.hord@gmail.com>
Subject: [PATCH v4 0/3] fetch --prune performance problem
Date: Tue,  1 Jul 2025 18:12:12 -0700
Message-ID: <20250702011214.2835529-2-phil.hord@gmail.com>
X-Mailer: git-send-email 2.50.0.149.g1bab277d62
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phil Hord <phil.hord@gmail.com>

`git fetch --prune` runs in O(N^2) time normally. This happens because the code
iterates over each ref to be pruned to display its status. In a repo with
174,000 refs, where I was pruning 15,000 refs, the current code made 2.6 billion
calls to strcmp and consumed 470 seconds of CPU. After this change, the same
operation completes in under 1 second.

The loop looks like this:

    for p in prune_refs { for ref in all_refs { if p == ref { ... }}}

That loop runs only to check for and report newly dangling refs. A workaround to
avoid this slowness is to run with `-q` to bypass this check.

There is similar check/report functionality in `git remote prune`, but it uses a
more efficient method to check for dangling refs. prune_refs is first sorted, so
it can be searched in O(logN), so this loop is O(N*logN).

    for ref in all_refs { if ref in prune_refs { ... }}

We can use that function instead, with some minor cleanup to the output to deal
with the ordering being changed.

This patch version only adds the deleted branch name to the output of the dangling
sym refs since the ordering has changed. This is only a minor cleanup and was
not actually needed since, for example, `git origin prune` already did not
mind losing track of this information in its output. But now it is improved
to be more explicit.

V3 forgot to include the first commit in the series (I forgot it grew).
So here's V4.

Phil Hord (3):
  fetch-prune: optimize dangling-ref reporting
  refs: remove old refs_warn_dangling_symref
  clean up interface for refs_warn_dangling_symrefs

 builtin/fetch.c  | 19 ++++++++-----------
 builtin/remote.c |  5 +----
 refs.c           | 34 ++++++++++++----------------------
 refs.h           |  5 ++---
 4 files changed, 23 insertions(+), 40 deletions(-)

-- 
2.50.0.149.g1bab277d62

