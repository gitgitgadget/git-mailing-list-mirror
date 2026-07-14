Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2113625CC57
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069329; cv=none; b=eFsHgd6qxUpWx/XRJTTD4fQVNJQbXQPHKBAQ6V826BY1vN1LEHHM7zOQ44jlT3LwnkS5kVhkia1a9KnJJZlmeYXNjULUYj4RVid0fSN+MrMjQN8/C6CdlSfvLqzYZesVhO9Gj22kFiELZqjj+qkZzmAFBquY8hxFVDiuvJ5X4m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069329; c=relaxed/simple;
	bh=gJUtsSBUi85KC7z3MS+dj9FCXXfWkxB8muf0f1li4aM=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=CtH6RT0K+sjnjTHctqHTK5P0D/iYh40vbQ5eCWlhFgKS2x66O1rps+MGR7Rkv3YcZy2BnifzfjWatCDI2uqbUdy9d0kaf3wPhRQZRvySCVf27bC2OzvfjmYG7wVxSA4TxTVdADHlgyNzq3yoWlBRZ6zxinhtLE4AtW69Gl0iZb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWbeXKW9; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWbeXKW9"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6a378f187bbso736851eaf.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 15:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784069327; x=1784674127; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZHsh3SSTk6wQMxb8j0lnzVzNiBpEZiF0YzRnlYdkXqQ=;
        b=eWbeXKW9lE0bnKyofJTEWAV2u7k1ikUxgCnnmmpdUvW3zT8nAkwNML4MufrjaRd3LD
         /pIgGOCYmGcTHtKAxBTKBke0BpyPzhen2bfJ3OQNptABlZJ4oF4q16zb+i7eVQ1a7d9a
         w+WyQkvNgC4olj80tupvkEvzwQJQkr5Wy7kfY31ivVWpU41TJLxntA4o3WFOmaMCBRx0
         479zBJKXlBQ23aW499LAjSSpa1Fzmw36bsHtcAVED5Vf7ZeS/vQ3FalkZrm3d7YdDEao
         BqZNz+6yW/OciC3ihzEwxxb2zeWOqfdapdperOIC9NgCvBfn27y90qeZKA1hiEappGVK
         jSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784069327; x=1784674127;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZHsh3SSTk6wQMxb8j0lnzVzNiBpEZiF0YzRnlYdkXqQ=;
        b=bRkMGACa0Uw48+9nCodd1ty5DYjAyd+f+If1AYDHUyTuKyDVixwkEPre3aPBr8J6A/
         5yd5f+dOqIOWy5j0C/CDxSGHvVYr+LqF+G4YqUG9KMiXQnNlAKtdyTM6v0dSf/ASgIaK
         8/yqGEAvqbpuGJJS3XOUOJ5uXLTHsk+aqLBDeGwlkQI1MszZ5lzZJeVfLy6vTRRJ5k3G
         z0O2J5PfSmHWgeNCz+qYB1lVD69kNsL9yLOXAxBx7EL3f5Ef7VLFvY8nepSsvADsp16s
         mmKzY2BG8K0X5qhQFbeLvBhICQCcmHya3mqHzF2663X4QG3vhinG0J0n+O/4vskFRqDr
         Z6tw==
X-Gm-Message-State: AOJu0YwIddpa+a9Mj983WOhAM4qxogiGk+TIS74ETkWV999x73g5zcXF
	WujPOLKiT1QAlebF5zzkWUm7AeDeWXKFU7oLSVSNX95gKOqGW6GLg26kjFoWzA==
X-Gm-Gg: AfdE7cm0IXKLZfIiT98KL9eImdlW2kRlMQ/GsE/KuGwfiHBKDvaqjUtHIvXCC5NW8id
	rd5MnlJUOWVbnhL7CrXilTXfnBEzpaV+LrTEDh7zuqnPXhASFBu1xejz0AfJQt2JxmODdBGyBjL
	XoQOsoKqjGk1dl74xY8pb7p7/glWU+rJVBf+37eiYq+RHZ81Sv6/rqNyKDoyyC9I7EV3P5ZbDsk
	LYZUHfa8c1TnNNwUKk4WWh0AnpHfGK0T6GGX8KF9jtAdo/tinepKafZkMtm4B61dfZh2wJ00PdL
	auL+msCoIhN43CqRVDeg5GK/1dR32j7Ydv1YtFFhkqmUceUy+wDMTUyksLWs2Ylbj12A389xLI7
	uZ5i/Fi123yP0SKAYRhVExovTjkNiSG+Uc3WMIQjTZGj0MLsNl1RN1atsSchjjCVd4DlDWuUqcG
	NFf9eS9zZh/lJeRE/5FGKJEJqXIF0=
X-Received: by 2002:a05:6820:2088:b0:6a3:bdc5:591a with SMTP id 006d021491bc7-6a3bdc562f2mr4589857eaf.32.1784069326906;
        Tue, 14 Jul 2026 15:48:46 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.178.217])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a36a5eee0fsm15133798eaf.5.2026.07.14.15.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:48:46 -0700 (PDT)
Message-Id: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Jul 2026 22:48:33 +0000
Subject: [PATCH 00/11] coverity: fix unchecked returns
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

This is the next batch of fixes in response to issues reported by Coverity.

Johannes Schindelin (11):
  http: die on curl_easy_duphandle failure in get_active_slot
  config: propagate launch_editor() failure in show_editor()
  reftable/block: check deflateInit() return value
  reftable tests: check reftable_table_init_ref_iterator() return
  last-modified: handle repo_parse_commit() failures
  compat/pread: check initial lseek for errors
  transport-helper: check dup() return in get_exporter
  transport-helper: warn when export-marks file cannot be finalized
  bisect: check strbuf_getline_lf return when reading terms
  bisect: check get_terms return at all call sites
  bisect: handle dup() failure when redirecting stdout

 bisect.c                        |  6 ++++--
 builtin/bisect.c                | 27 +++++++++++++++++++++++++--
 builtin/config.c                |  5 ++++-
 builtin/last-modified.c         |  9 ++++++---
 compat/pread.c                  |  2 ++
 http.c                          |  2 ++
 reftable/block.c                |  3 ++-
 t/unit-tests/u-reftable-table.c |  6 ++++--
 transport-helper.c              |  6 +++++-
 9 files changed, 54 insertions(+), 12 deletions(-)


base-commit: 55526a18268bbc1ddaf8a6b7850c33d984eac9e9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2179%2Fdscho%2Fcoverity-fixes-unchecked-returns-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2179/dscho/coverity-fixes-unchecked-returns-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2179
-- 
gitgitgadget
