Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE31414419
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790930023; cv=none; b=ZCjjs5wNjqDT3wAlDc6EBi6dBgb/mt7PZvDfTc5Q9eIP0wTtzEbAhXF72sFH4O0ZcSFQA0FmictLYiTyXhtVR9sqKq7qaXjTpTkZkADQXPUhsne2SkdG9XhwolQz9osKlgPbXGLYr82Ouoiq9LxuuzZGv+Ij5dZpxa/1j3pF8R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790930023; c=relaxed/simple;
	bh=6zQI+cVYIC6kfCvA+mDTY8Hx6OzE+SxTz5qAZWWgCiA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=B7EbYPHDIe7q+8FSk8d5xztYovqUj2/vDAGvAzDw5/AHAUHmDc03JRYAFvnbymAZjo19ENbLCyUi4MNn5soPtkTnP5ZpYxoCmUxOHLjc30ztNxrFdVDnQj76Izgp4D+ba8U/dK97oemuQovnAKU25L6pLyETWJ5xiNHQvZOA0Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDt6wRAG; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDt6wRAG"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939109fafd7so593384485a.2
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 01:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790930020; x=1791534820; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cb1Tjw8+ZlZ27I0atKejz4moke7ci+Go6lNrLOCc7W0=;
        b=BDt6wRAG4MzBWwdd0LdIHSxU/yQoJg5pdLNYUvt/od7wXY2OT5dfcbCtWMCyq2gdA8
         I0gm28JmAC+c7dHpKtfveBrOKm/740nuh+DMd7oZLBEH6PRO5v6l45+/eNCIpr7+8fZz
         gDNhDtq+rDuFQD+6xhHAd6jSvXlq5S6ihvaqjdVmxc9UXfpL4eQ/JMbnXCm7JbzE+ZSq
         mkIRueP8h5K/Zi7Je58hoqxySo9Jp/LKFxReVG5ISDmipiD1xL/U6Br5I0oq2Z2g2FdP
         nEzXdlpiy+YqXrJ8LhPM6NUuXb1GRcLtvSXK69WIfVGBcySIxzDig6oXyW+RCERAz9pr
         0Bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790930020; x=1791534820;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cb1Tjw8+ZlZ27I0atKejz4moke7ci+Go6lNrLOCc7W0=;
        b=ppmLStQf7S4yQssOQD56FfaMQ4502mjrHB5Iqp4W3WQYlwYcOi2+np4QI4mcw9Qsky
         AWuijsAV54zdjS6wTitc647xNFbcwZ64gfrmJw1ahibn+HUCXN81U7GETBeXG7W8EBe1
         GV5+9XKibrDvHzBZRKzN08NgdICT3DlrALWMFhKQaPoWfxjUQ4P71O/Dmc8sSuUJFyoV
         9f9c8ObhkmdHYBVyiGINHh/g39x1iN5NY9a8U4BHF5pUxvYIwkEQgZmlPfg/l33nnUQk
         YBiKWe+HbXb+o334rxtSJ/8T6ENYSNEsvxmFKlyxwfbzIuVxubyRYNEP/ZHkZ5PKuvpx
         Fffw==
X-Gm-Message-State: AFuF++miklSgr0CGOL8y3WqiX4W+3m2KpMDfi26A2AK5upXCqGLXS+TL
	YV+BEyXWl4vsv+jyKdiYidG51fVuPztQTFgbevXsFpinslF37uFTv2aESNcVEA==
X-Gm-Gg: AYBFou2+pYchDECTIlIPYxjDnpi43RZP0mipVgf0Q9CUZxBZ0b8SPswhMY8XLjX/Lwf
	kpmfCODpLVr0o/30X0bQYXHP6EZgd12bxrQHV+kKFW4vt+EKa/d4Ho6vwjErXqb9P7bKFqkn3ab
	fkIK5DpKvvZZHOwHXAU3ifOhVAYrxpG+TGYVHDPD09p4tPfGe3W4D1pXUD/cNCtIyE538C1ilSx
	1W7QCecjYSHJPFP3BtaIQdPekOV+l2/25mfSk0kQMyYEjeGycqdBWHx9Dg8oXzohq6pkiBSlHR2
	iwkUGi208A3aK9ZzsFn3j17w+qUN2sXNk4AAXFq153yS2Zu/C7bV21AMTXo9R1PO4CrRgPfcRtS
	/m30YcA6WSBnAEBvhD7dWJyCpRP3YkhyW4BhFjN9y+AvQrRfhl7X/xuvsBdBufqfc8rlLb8RuT4
	63+aFuhUvPeM5hQc8+BO/vQDY1vd+s+TvU9Y4eXVZDFsl9NyVlXbA8hnwbhzn6zIn12z3P/Adlb
	0sbenxPZac=
X-Received: by 2002:a05:620a:4713:b0:939:ab90:8f6a with SMTP id af79cd13be357-93ce82c5a53mr335774085a.18.1790930020078;
        Fri, 02 Oct 2026 01:33:40 -0700 (PDT)
Received: from [127.0.0.1] ([20.83.159.48])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca263708sm160400185a.31.2026.10.02.01.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 01:33:39 -0700 (PDT)
Message-Id: <pull.2239.git.1790930019.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Oct 2026 08:33:36 +0000
Subject: [PATCH 0/2] fetch: write commit-graph using updated refs only
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Taylor Blau <me@ttaylorr.com>,
    Jeff King <peff@peff.net>,
    Kristofer Karlsson <krka@spotify.com>

When fetch.writeCommitGraph is enabled, the commit-graph is currently
rebuilt from all reachable refs after every fetch. This is unnecessarily
expensive on repositories with many refs, since add_ref_to_set() validates
each ref against the odb.

This series optimizes the commit-graph write by using only the newly updated
refs as seeds instead of scanning all refs. It introduces a three-mode enum
(REACHABLE / TIPS / SKIP) to make the policy explicit:

 * No-op fetch: skip the commit-graph write entirely
 * Updated refs + existing graph: write incrementally from updated tips only
 * No existing graph or multi-remote fetch: fall back to full reachable scan

Patch 1 adds a commit-info subcommand to test-tool read-graph for verifying
graph contents in tests.

Patch 2 implements the optimization in builtin/fetch.c with four tests
covering the incremental, unrelated-commit, no-op, and fallback cases.

Kristofer Karlsson (2):
  test-tool read-graph: add commit-info subcommand
  fetch: write commit-graph using updated refs only

 builtin/fetch.c            | 65 ++++++++++++++++++++++++++++++++------
 commit-graph.c             |  2 +-
 commit-graph.h             |  1 +
 t/helper/test-read-graph.c | 23 +++++++++++++-
 t/t5510-fetch.sh           | 58 ++++++++++++++++++++++++++++++++++
 5 files changed, 138 insertions(+), 11 deletions(-)


base-commit: 0f8e75abebff0877cae681a3d5ff31ac47f54220
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2239%2Fspkrka%2Fkrka%2Fincremental-commit-graph-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2239/spkrka/krka/incremental-commit-graph-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2239
-- 
gitgitgadget
