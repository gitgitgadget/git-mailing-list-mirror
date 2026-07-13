Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7A943B6EB
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961050; cv=none; b=Se/llQn+lRo8ET2g7okrhzlWN8PfFAhbCYNUR+wY4dWZdJBR+E/aaNksRco+Zve5txIufa6FxQJPjDJeDi+6+Hxh1fE3iCF5Ybps+sPcTwVXV37NxHI9y3DNwf1FU8Q5qaRCHF6uDCbTrSmEeUYMNpWYT6/ihmb/bpbWrePQAus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961050; c=relaxed/simple;
	bh=K6dSdSJaFEmhHwc5c3B6OnInMh3DblNdUn40wxV6RLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0N7/s2sjYBUBB3+UDCaLbDTZl20StEqZUITZNtq9w2TbbMg6K6NBB594kOmaJwI1vJB3E83PoRpK3nZYW0M40nrwvWhejTBp9ECNWprcZxYp9eRbKZKlFKOoM98dE8HCaktDiGqK41hHkwZ4ILRvFPNCVkeEypSWHNNPjWXsWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W79hLpIS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W79hLpIS"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493bf73ec2aso23490535e9.2
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 09:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783961047; x=1784565847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gKAEihuGdZsACZ5emAdiZM1GeqAeWEYJHNDuR7Ej5m4=;
        b=W79hLpIScJ+crAq00CVTi+uK8h5Kqz1tJohkp8+mQmTyc6xa7VFlX4tKLZy+9WHF01
         o51sxuhC3ohymCIn9r2p/hNhes70BJSTiMSm7fk2h4w5XFEQ5OGOPNDGMMt9Vfq8cevL
         /mp+tLa7lvqtOSHPjJNd7B9xud+ZcHKWa+Z4aRnSk+awMUUWpX7WW1iLeCiD+sLOtoKV
         GAQ0g3uDOZr+zOB0XrqjkIDn4bZ8nDkXjKrrVzP65pIYeyLzPeEV5WmvyaN59WyKSFJz
         B1Ou/D/hIKoG16l7fQ5kWnPeqpNCvd5iNnhRzkkk3jaaDE8yuNTGBBFb+U6IuUHnE/fY
         0Vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783961047; x=1784565847;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gKAEihuGdZsACZ5emAdiZM1GeqAeWEYJHNDuR7Ej5m4=;
        b=PGtdDqXI0Ih8frQwT87REMEqyZ+0Jw2/iSae8zFhDxOk1/mwfRknayUxFUPqwZRM3p
         P9I4aXSuRxiMJtp5J4VQ2+ZV8ixPHKaJnSmx5hvvk8SOysXMzBLdsTpi4f1bXNZtjrAM
         UuQvchgiMRVSVR/DuxzWrTG8NSuBEZHmUa+IzgN3O9RJcsiSI3S4qKeT++KEGfRI25T8
         K5rHdJey5prA+9cHkUfRo47gp9pjHNNctQw6nRb7vtastBbuvl/pJCzmubqAGXGFybIy
         tFQlYsgevO4JkdsY6oz6+SxCAcQuSdyfC3H6zcBcJiBOW7AJbHohWymUvHUgaqReY/aw
         MeXg==
X-Gm-Message-State: AOJu0Yxgm2rQs8viX/952pYOjdwDH6SE4ypiiDPieLVKcxe7a1/584qx
	1EkN+l1BrHkQQ3yO9toJo2umnG7Ti1keTD+M6xH5sC+DLfh7AWkPHBa65yTA7HHV
X-Gm-Gg: AfdE7cmE0Zfkb3HiXtVxWoKNQLidEIVNY3P8jPiC340wWCPSAM57JDPf84jAyL6DGdH
	+IdQePC7kaYrdCH2dY1mKutuBB9IbvxbMkFouv7PfeIJJPFI7dRPhG+lhJfeLYxbQXQB4DWP80p
	v9QtxH5kxIsg+K8yZF69VgpWezEIhl0CMJSfvERyARnDtf+yI32WtI/L7ogekxox7LWLQRcLEom
	JfWL0Vdvayl0IFSAMcqCF5h+/WStRLzVZd4ZngSAvOojcVTUGNZhoX+t9wu+oLEnAx807xxdY2K
	qF4jFMi1Gj/TEZX5dmwLLKBanpRbTZBRfDz/E7dBe95SyoXO5hObkZymLEZeqp/n7THzcrmUMdm
	iOVi/QxuM1ue3UQt+enIX1+b9sSKN9H6WXG0LQoJXth+XWyiJYw/71vDKVGuPp4ZDsegIJj2k6w
	v7PNG/hjBYdieKsMtva1lL5wqsXxIrnyVT/Ab6Ny0erCpz5uoqGWeE/Rfee0HWz1+Vms71RcuxJ
	v5HfXWbSGgqAodxWKBVs+5YYgVOJirak4VL/pWGPNawabKL1UEBYjr89nmaGzmI9kzolWGzNzJX
	Ah5xd/roWpXj7QwZoIEB9r4J6dssT55Fom8y1GPHe8CMjFwrHfCo1QnUs1CZ2F0qihFT6AZeaAO
	b4Xsa/75YyA==
X-Received: by 2002:a05:600c:4746:b0:493:e034:a3b5 with SMTP id 5b1f17b1804b1-493f8818cb0mr113020615e9.24.1783961047460;
        Mon, 13 Jul 2026 09:44:07 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a96fdsm653768f8f.24.2026.07.13.09.44.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 09:44:07 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	krka@spotify.com,
	mroik@delayed.space,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com
Subject: [PATCH v11 0/7] graph: indent visual roots in graph
Date: Mon, 13 Jul 2026 18:43:57 +0200
Message-ID: <20260713-ps-pre-commit-indent-v11-0-dcb65bc4ba99@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713-ps-pre-commit-indent-v10-0-82ddab26bc96@gmail.com>
References: <20260713-ps-pre-commit-indent-v10-0-82ddab26bc96@gmail.com>
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

Before indentation:

	* A
	* B1
	* B2
	* C1
	* C2

After indentation:

	  * A
	* B1
	 \
	  * B2
	* C1
	* C2

Indents the visual root commits that have still commits to show after
them, and if they have children it connects them with an edge at a new
row.

If there are multiple visual roots adjacent in history, the indentation
starts with the second one, avoiding redundant indentation of the first
one and cascades after the second.

	* A
	  * B
	    * C
	      * D
	* E
	  * F
	    * G
	      * H
	  * I
	* J1
	* J2

The indentation wraps after cascading columns and when wrapping back to
the initial column if the next commit is a non-visual-root commit, force
the indentation one extra level.

Series explanation:

- Cleanup to bring a common function from t4215 and t6016 that will be
  used in t4218.

- Logic extraction of the chose of from where the commit source comes
  from.

- Add a buffer for lookahead purposes.

- Principal commit. Implement the logic to get the visual roots
  indented.

- Make visual root cascading wrap after 4 columns

- Add --[no-]graph-indent and log.graphIndent options.

GitHub CI: https://github.com/pabloosabaterr/git/actions/runs/29266560903

[1]: https://lore.kernel.org/git/xmqqwnwajbuj.fsf@gitster.c.googlers.com/

V9 DIFF:

- Changed boolean variables to be bit fields.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
Pablo Sabater (7):
      lib-log-graph: move check_graph function
      revision: add next_commit_to_show()
      graph: add a 2 commit buffer for lookahead
      graph: indent visual root in graph
      graph: wrap cascading commits after 4 columns
      graph: move config reading into graph_read_config()
      graph: add --[no-]graph-indent and log.graphIndent

 Documentation/config/log.adoc              |   4 +
 Documentation/rev-list-options.adoc        |   8 +
 graph.c                                    | 332 +++++++++++++++-
 graph.h                                    |  17 +
 revision.c                                 |  57 ++-
 revision.h                                 |   2 +
 t/lib-log-graph.sh                         |   5 +
 t/meson.build                              |   1 +
 t/t4215-log-skewed-merges.sh               |  33 +-
 t/t4218-log-graph-indentation.sh           | 595 +++++++++++++++++++++++++++++
 t/t6016-rev-list-graph-simplify-history.sh |  25 +-
 11 files changed, 1031 insertions(+), 48 deletions(-)

Range-diff versus v10:

1:  9541b410b7 = 1:  dd0bb0d215 lib-log-graph: move check_graph function
2:  4f8fb2cc1d = 2:  07e239533d revision: add next_commit_to_show()
3:  b50574bbe1 = 3:  4d71f674a1 graph: add a 2 commit buffer for lookahead
4:  fc3a8253fd = 4:  48ad2562f0 graph: indent visual root in graph
5:  204aae5061 = 5:  45be69d11b graph: wrap cascading commits after 4 columns
6:  1b42ed86a1 = 6:  8ce53ae21b graph: move config reading into graph_read_config()
7:  737331b68d ! 7:  c1fa81022e graph: add --[no-]graph-indent and log.graphIndent
    @@ revision.h: struct rev_info {
      	/* Display history graph */
      	struct git_graph *graph;
      	int graph_max_lanes;
    -+	int no_graph_indent;
    -+	unsigned int graph_indent_set;
    ++	unsigned int no_graph_indent:1;
    ++	unsigned int graph_indent_set:1;

      	/* special limits */
      	int skip_count;

---
base-commit: f60db8d575adb79761d363e026fb49bddf330c73
