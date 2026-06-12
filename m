Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F97C3385A7
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272121; cv=none; b=YlvTUXeD3da0FWDfHFCnDSDBDzPF5eIwVIWY0YyjqUM1QBw7PPEogkrgVAXVF/PHxY1z7Hq8c/Y6edhY+S14hTEMoDMDOThZ05LxRe69oWhvSnJiNOJek9OfOk/niHwBCuvfE0053Ilu+2I2xqJHdwz+7nyDTa9fpJcs6JkdZ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272121; c=relaxed/simple;
	bh=5+ZfR8XvEwx5E6cMWX/bekzBqebMVxwsVg2lh4ORkGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3RjRIpN2tCzwB1GxsZqvAiE6H2pqVo+FgMr2mJPwHv7t/7k1+aGBLEPcim37aMqdKXVLi7Ayca4x2SPOzvPstc8ZbyuED3FwywLrLIkNlR6AeoSDags3TbQ8QaIdiKGKUxAKRMzOoEI1SntFtpXrGc0tQ/rYXo7ZyEp5EdGYjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VakdAicI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VakdAicI"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-491b390f9e9so3171215e9.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781272116; x=1781876916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGdYlewSN7OUQ7pm+FR5E4kkyuYfaCNwL/OntQPDIBg=;
        b=VakdAicIiII9TTQl5m3yQC/uBQpXIPmPhiagb1/ZL8jp/K4e4oy/2BokHovXNU69v/
         tWiIf7ccJH1PtAM1/5hdvjynq8PbFj1oEKkHGwOOJ2UkivVwwfwIosXiyrGCdVvsshix
         R5hPwk+ddLCzxrjArOEPe2UgGXjSTVqSQSxShQO5lAXz9u+OeNJlh4rTKV0NVfpn9uQU
         zc9zYszHJm11/7Gma2b29boDg9TVJshwOS8sLe2sRjSwZTY8eKZg5UyZrB4cBPg8V8tl
         d3ZUMj6WQFODD+MRYDPklJ4ehFSf0u77ovNrGJtvFk5ocB55iG3qiMVtzS90G35qQfuh
         Lp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781272116; x=1781876916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZGdYlewSN7OUQ7pm+FR5E4kkyuYfaCNwL/OntQPDIBg=;
        b=D+ifK4L3XCQp6ItGni5kRzy/gAH9aIX0FcG0OXFrChXEgE7p6J29TCegtfnqUCk7FM
         WurxgkLOo6d7xPp/hg3mkJIqgqazb6haenK4F6E9s6gDOfmd/epMNS+2O3sP3XVUbz3e
         4TdeVQLu1Fw7k/8+TvCNPKe6akQI11NUjp0KVQUkBOxrKnUeLwbjG2Ktk+2t6imZx/vL
         rPbabJ/I2uM2VhsgxNCk7TDLJ0uloJH0R6CdAM7g+Dnb3XTZeqS1CwktSz0hPgl8Thtp
         +nbyO9WIvY8ZPCVH0OIahihIh1uLfyb8SWktlsiuQN+WbCU4ftBawzvRD+6B9Gtw+bDd
         P+pg==
X-Gm-Message-State: AOJu0YxyF4mwpLi8QcXtvRrersIhFpcsGYJXoyUEw1E1xOQWIw9XSeff
	LipNGbQLIvtn73iBRKJ7WvrDrjMtn7/x7nFFMFnCmkmgh46tUChrXD3dUrU5gock
X-Gm-Gg: Acq92OH9nhyOxvostxGttmuIBY6C/HdvkGkxMkQEpR5SEJsoHzo9FwYUPwAtHo9I2SW
	L7wvR2j4oOQukDsXZ/D//8EsZqARJvhofies0nay7Q5NTi/r4teW4Qbmp5yeg8t+wT8TVoX2KWc
	/tQwTKfORymdwW3S6far9J7osgYCjnQYg4Jm3yWaXPgDoPp9EWdun2YBgyMGSmjpL0eKLKE3vRN
	8xfSPLDVHVM1ZR4FoZhjrhM+LMSLeiv4X+dcxTI4rbqoC6EdAkDa6Wq4hBXFkFE8SsnqV9LU6tp
	wsA4aONBR47hpRuGFIGuvhumuo3OhieMxMN/9axhA+q0Otqyxp0uuENEAvLCCMIZYNws5Q5CXBV
	37woEthaPpWnhACWPVuFWntW7XH1x+5BANsF9cHWWLmOKdBU+T2Pc2o87u3JHB2zTQGvgQ6/u49
	ecMCXj/BoUBaQOWcGkqXPFCn/m+xx4xyi48ccKXLS1J8J28PPk029WExzizYk7+lDFYyWwIeUU2
	rzPC16/6ys3yB6YaS8AZ529I9zBw+rUN8rJe//8cugekWvluGt9sNj2s8NQgKDGsEFqqyRlUiyz
	AUU8fOWhYGOJswZxqFGY17Y0XLPQILgxsXK0l0HMR9xxqRQz9r84DbA3+g==
X-Received: by 2002:a05:600c:1d11:b0:492:1e36:552c with SMTP id 5b1f17b1804b1-4921e365572mr6799755e9.37.1781272115759;
        Fri, 12 Jun 2026 06:48:35 -0700 (PDT)
Received: from localhost.localdomain ([155.54.213.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea7c0960sm61223305e9.3.2026.06.12.06.48.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jun 2026 06:48:35 -0700 (PDT)
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
Subject: [PATCH v4 0/2] graph: indent visual roots in graph
Date: Fri, 12 Jun 2026 15:48:29 +0200
Message-ID: <20260612-ps-pre-commit-indent-v4-0-e8492037ebae@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427102838.44867-1-pabloosabaterr@gmail.com>
References: <20260427102838.44867-1-pabloosabaterr@gmail.com>
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

V3 DIFF:

 - Completly changes the approach to indent the visual roots instead of the
   commits after the visual roots.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
Pablo Sabater (2):
      lib-log-graph: move check_graph function
      graph: indent visual root in graph

 graph.c                                    | 262 +++++++++++++++++
 t/lib-log-graph.sh                         |   5 +
 t/meson.build                              |   1 +
 t/t4215-log-skewed-merges.sh               |  33 +--
 t/t4218-log-graph-indentation.sh           | 455 +++++++++++++++++++++++++++++
 t/t6016-rev-list-graph-simplify-history.sh |  25 +-
 6 files changed, 747 insertions(+), 34 deletions(-)
---
base-commit: 3e65291872de10c3f0bf05ea8c24187e7a71ebf0
change-id: 20260612-ps-pre-commit-indent-39ca72816382

Best regards,
--  
Pablo Sabater <pabloosabaterr@gmail.com>
