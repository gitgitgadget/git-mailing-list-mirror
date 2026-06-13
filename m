Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28844299929
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781377765; cv=none; b=Bqkhp7b5Zc/J374c7yvQJ7qZPmieymOOVkOr2I171oX2VnMUfInjvCq+BEBabCu6M9kKF3YaId6rZXq0Xt62UMXzD9KQ4N3DmyNmbs0NTHOc6A7+Y8xR6p5I8iycJ4IZhpB1LzFDbk62YiUpMLCh44HyLGTDSmaeaSNmPD5ouV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781377765; c=relaxed/simple;
	bh=gCC5a51OtAwRwY/DO8UyXWs7trDjSnqNwpyccCP69Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uh6Uy6wV+yaob9WaW9DnCPL2jNF2gbdldgyfC/ej6iVcDUvptjUNolBMV+xHLrQiIxXVVu2LVXpt2DJVmqg2N7LBiGj9qdOerKHfjYu8uYKzpVLF4QyuT7Hkw1bKG4ohioy0E+1Bl4z7w/nAu4xNEA+8um9f261tfZi0E4vbBxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BU2uf/Ti; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BU2uf/Ti"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef5146b56so1883580f8f.0
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 12:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781377762; x=1781982562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byZ0+yrit7dHw12nrPPcSyaaYN03mdql6xGH8/azw1A=;
        b=BU2uf/TiFHoacXoEVL6Z/Xa81XRId4QxkQpTMwCEwT7o4a6aHrLlDPHTGZkOsbnzOV
         6R8LjSzmbbyvvr1BD8KWQ4VWQqAbO6i1Fs6mePYvH2V8g2vD/WD2+NWkTVMwcZi4vIxk
         ywp2yyEGm2ythwK4bflRcJXCfSJ1bkSZPQiVgmutPJIuLNvdlMuSuBEaVHzl7X6v8E3g
         z0SJWRI9IuL+H3pSskipN2K5+MDZ3p63CzEhNH/I/2KBVPfPy//tYUfqc9BS7B47S/nx
         iw0bBkf6wWxacb+HFJYxq0UC8KROuA14ZFjW2iUuyhQY0zJvtGwWt00x/dazWxBeGykC
         My7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781377762; x=1781982562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=byZ0+yrit7dHw12nrPPcSyaaYN03mdql6xGH8/azw1A=;
        b=DWOwAA1/FEPUvn8mTmYNqVYCBdtulyrwpjrgaNSVaD/DBkDu77jpzIPZpq/0PtYeSB
         jGgYg7kqx0KSpeq14SnL0c2S4rEs8Cx7OtUpQ+jYu4FmrpaZ9JTSH8ODpMiFneZSfGZ1
         gqw57ViRbmZno4GWa5NxiejCY17YwljKi12a7ZnOmZFrYuQiqRMeuQrjdLXQJ2Y8JU4D
         khuZhQSdDrPa1a7tsOipJKorEixo06Uniw+9539oJW36bPjKfkA9oAkOwfXej/QH9BMY
         lbfVzNgPDQG2uoQ55LJaL9C/1n5tva/y2V5N88wzm4V76Al7TL3w/TvOGDsQkPIFr9KQ
         1I/w==
X-Gm-Message-State: AOJu0YzZxsWiG1JDytJbn41NPCFJpYTa3ngcgulWojRi3wjL6+ZWhQ9S
	9G3+VDEMHcsCs1sDDk8S/x6lz1tZoufT5YG0cYSsLgm6qF/iOihTd7dkfJdapKYr
X-Gm-Gg: Acq92OF8w+kwsCuQeZvBvNYE19boJIOsYYL+SgMcTYzLPGNbYfEara8sIMWxBNk8bps
	yv1fTZ2Kfrx4Nnw/xROU9GKeHSpMg6hykwOGOieTNv8Y6N4zZN0LK1Gr2a5W2tVB463ryR6P5Fi
	9B+OwJDhtptX/OIy0xiBh1lBVYOaGgD1tvo+K8vfCJGDC5aigDm7ppvFf86mSTmZgMAzzvT8Bk4
	hgkHQbbGIcd9f6EBRHiUSGAcsHfNZkSISbbGItMVKcolVbiR8QmqX6vcsRztJ8pzYU+jiwu4+nu
	gA0SSlw9IL5Ca4+G+Q9hqAW3OibYb+qerHTv4whlcRs98eMrfyKKjmG8gpB4dxTdZn5w7KVdEoY
	WOyvhd8fi30MpkOGBs8rkeRLCDCIgOa55KiwzoIVjO+dWLXgHK5428MZCAN6lxZpKWFWNSuoXIC
	QxuObS2OAdkbrLNi3jsv0jNpVmDg4ZRWFNy75JJEjcu4UTaUt+4/jf2eVFde+TP1LksPhnX/I6o
	MWNN7Oqg47fwARah3N1yB/iiEuE3fmo0EQiHtOYihH8AJ92XiS56DCpQgjf/0TUwN5I5DGgB0Mv
	gR+FQ1j9LZuOBN3kTX4qQodFhrIUORDg7kTpQxs+SAIOE/CBIxihjexzw+hIVLMmITZawIsv1/l
	Og4Ha2UtHlnrzEJLqlptU9byw
X-Received: by 2002:a05:6000:2586:b0:460:684d:d565 with SMTP id ffacd0b85a97d-4606f255ab8mr9173229f8f.15.1781377761880;
        Sat, 13 Jun 2026 12:09:21 -0700 (PDT)
Received: from localhost.localdomain (static-204-100-6-89.ipcom.comunitel.net. [89.6.100.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0d28sm18238110f8f.20.2026.06.13.12.09.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 13 Jun 2026 12:09:21 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH v5 0/2] graph: indent visual roots in graph
Date: Sat, 13 Jun 2026 21:09:14 +0200
Message-ID: <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612-ps-pre-commit-indent-v4-0-e8492037ebae@gmail.com>
References: <20260612-ps-pre-commit-indent-v4-0-e8492037ebae@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260612-ps-pre-commit-indent-39ca72816382
Content-Transfer-Encoding: 8bit

When rendering a graph, if the history contains multiple "visual roots",
actual roots or commits that look like roots (i.e. have their parents
filtered out) can end up being vertically adjacent to unrelated commits,
falsely appearing to be related.

A fix for this issue was already attempted [1] a while ago.

This series adds indentation to the visual root commits, so they cannot be
vertically adjacent anymore making it easier to identify them.

before indentation:

	* A
	* B1
	* B2
	* C1
	* C2

after indentation:

	  * A
	* B1
	 \
	  * B2
	* C1
	* C2

Indents the visual root commits that have still commits to show after them, and
if they have children it connects them with an edge at a new row.

If there are multiple visual roots adjacent in history, the indentation starts
with the second one, avoiding redundant indentation of the first one and cascades
after the second.

	* A
	  * B
	    * C
	* D1
	* D2

This series first commit is a cleanup that brings a common function from t4215
and t6016 to a graph functions file which they both use, so the new test file
for indentation, t4218, can use it as well.

The lookahead used to set the cascading and avoid extra indentation is not
completely reliable, as the walker goes through the commits it simplifies the
history of the current commit and its parents, but it doesn't simplify it
for the next unrelated or the grandparents. When the walker simplifies the
history, it removes filtered commits from the history and sets its flags.
When the next commit is an unrelated commit and its parents will be filtered
out, for the lookahead the commit is still a child of, it cannot know that the
next commit once simplified (advancing the walker) it will become a visual root.
This makes the lookahead fail, failing to set the cascading and starting it
with the first visual root, carrying an extra indent for the cascade.

given:

	* A unrelated (visual root)
	* B child of C
	* C visual root WILL BE FILTERED OUT
	* D unrelated (visual root)

the actual output is:

	  * A
	    * B
	* D

A test has been added to t4218 and a NEEDSWORK to the lookahead function to
document this edge case but I'm not that familiar with revision.c. Maybe there's
a better way to make the lookahead more reliable.

[1]: https://lore.kernel.org/git/xmqqwnwajbuj.fsf@gitster.c.googlers.com/

V4 DIFF:

- Fixed test to be shown as expected by unsetting COMMIT_GRAPH

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
Pablo Sabater (2):
      lib-log-graph: move check_graph function
      graph: indent visual root in graph

 graph.c                                    | 262 ++++++++++++++++
 t/lib-log-graph.sh                         |   5 +
 t/meson.build                              |   1 +
 t/t4215-log-skewed-merges.sh               |  33 +-
 t/t4218-log-graph-indentation.sh           | 467 +++++++++++++++++++++++++++++
 t/t6016-rev-list-graph-simplify-history.sh |  25 +-
 6 files changed, 759 insertions(+), 34 deletions(-)
---
base-commit: 3e65291872de10c3f0bf05ea8c24187e7a71ebf0
change-id: 20260612-ps-pre-commit-indent-39ca72816382

Best regards,
--  
Pablo Sabater <pabloosabaterr@gmail.com>
