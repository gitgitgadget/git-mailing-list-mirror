Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0F041A4E4
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 12:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806883; cv=none; b=XerZosxi5ke6WeBkQbsIHtlgYZmiXUm8FW1vmEsqn/k9uqqnGXCoIp3+faNA3NhxzhyOp443t/J4+QapbLHyWixNNPlcjPWqxfUY1h4xgsteffuPpYoxGd4lYdvngMhfAb9kXyDqZWohJwt48Rv5OJpImoV9286a6hj9NHVvDIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806883; c=relaxed/simple;
	bh=8FeJGv9N4YEnQppXS52mkhFufn7uWJg1QsWV++vSk7Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XTjXYY+10sHMIr/C5rId6htmDR9xHYi0CADQJVgWJdvG4j0geyj6IacenBHn6Go+OKTaI0ojp+akB5qHb30H+SoxSPIfcvyB3TXPtJDZlkv3Ja2VHo2OLQZGB2MQxOYOwd44LP9FARGR1cbJ/Q+tu0atv3HAl/ApM/8j8USx6Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjbYIi1y; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjbYIi1y"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5350c1b9e0dso25336951cf.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 05:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791806881; x=1792411681; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zgcms1j0aYpyX5eULPHt3HibaiwhUIc+CPdH/H82ckQ=;
        b=RjbYIi1yiiIGgQ9WwtQise7EKM+0y8S7XpIWeNFdA5uyWZyWlc7y6LToAKfPARJiWL
         wWHfD0jKTmBb4XjxU7cD1m0RdwV4hxHSM4Ygx6nzJwcfceBcEJ0glNlVf3lbUiZZ3msg
         D513h7z+Ml3uOg79STPI2zp0LbaQQBtFooOlG8+FHgzxeQBEi/c0Fv1UQSl6RkDdKxIy
         gY/tOnctbvCIKrP2/KHB4Wl/aMlPxhhYhxkDuI9lt/bREFdd8RRbvlH25YolV8EhJSox
         b3y00NQSa6ugzv54vukkcBPiajX35PZRc1dVdzKsfbRsB96BQV3SS/7DvqyzRALyS8IL
         A0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791806881; x=1792411681;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zgcms1j0aYpyX5eULPHt3HibaiwhUIc+CPdH/H82ckQ=;
        b=DfUC/GqwvD65DnoYFRKBAADhCSnvY5wMboqeDn1iQMQDbMNHnw0RgXNr/rb1eX+BFX
         VsUC1fGSb4sq/10FOh2DFkDJZc/sZu/SAJDvcbPYqFKIX2/EaBlKr2LMQaqK7xXbp0VB
         TZFAMP/t39+6bLDORXBeHNbBSdVylNCCvQezjnUGHMejP1//ooL9l+V9MRsCKZUjSWMU
         2sAtqkuTt6d62L0jX+UkyJTkYeZL5Ibnkq7q0mph/XhWx6+BUwcZ8t7ZnwnsWkyj2/gz
         /8/yY3msYxaAfll/cdU/9NU3XVNs1dRCUzvPF7TQizs5/4TK6E2H6lG7XImD1cuV4nmP
         Nisw==
X-Gm-Message-State: AFq9FYLB77SUYyEy7M3DzM/bJ8TtltJqlvFaFypVkepiUgbmLAawqcTp
	LAR42MVXxt8YJ3p+pB1zKN1tUxBLa0tP2wZEpiqmUVGotYo+jF5Bc41nNQorMUpH
X-Gm-Gg: AYBFou21XPmsZErA93z7zimSK6PyWhoORRHIzNQeYV+lFQI/t3XTcI78mCisY8qTq5n
	OZ26KnBP9LLRvhQNVDqW5SbmVGuDcuizP+VJ9hkV+CfSwpgm6ZIvMoQhrGecNmWg9qbTHhK7mBm
	R26H9ml7kYx2kchpido35Ca6z309/x5/dhN2suf8Rm0r1GYUhfFceVlj/0KTwVVVf8vR7sluWvW
	VplxUk8Y9dCfpFgeisuqkAa63xkT2EACNvuqxrjiYtHjeo5I0a3x/ffT3BDFZ7+AJ+kQ3Z06Grq
	rSM7f0fg61NpUu6/X0oWa7l+NzG5ZwwGM7wkplrSJAlW58rPpfI9mkJvjAwYSx/4I+lP39VBHWh
	++NqOt3csfiDmm3OWkWVVGiOg8WlarJHANaLfeWAGDMruIwvnCdhfrM6DybBnX85zs5uC2za8cR
	CGPYya3ql8DmeM35QFLCfXg6FIJS0Grp2iUBu/sTmQUS9dKk6v+v1Zxl1aoQGfr1fZPdVJFTzgb
	80Ur7LfYNx3
X-Received: by 2002:ac8:5f92:0:b0:535:92a6:22e7 with SMTP id d75a77b69052e-5359fb4794cmr153449391cf.42.1791806880747;
        Mon, 12 Oct 2026 05:08:00 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.13.57])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b6fa173sm77546411cf.7.2026.10.12.05.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 05:08:00 -0700 (PDT)
Message-Id: <19ea8cb534f0aaabdf21f358364ad32295b6bfc8.1791806877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2211.v3.git.1791806877.gitgitgadget@gmail.com>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<pull.2211.v3.git.1791806877.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 Oct 2026 12:07:54 +0000
Subject: [PATCH v3 1/4] Documentation: describe connectivity checking
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Patrick Steinhardt <ps@pks.im>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add Documentation/technical/connectivity-check.adoc describing
the connectivity invariant and the full connectivity check.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 .../technical/connectivity-check.adoc         | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/technical/connectivity-check.adoc

diff --git a/Documentation/technical/connectivity-check.adoc b/Documentation/technical/connectivity-check.adoc
new file mode 100644
index 0000000000..abef02debd
--- /dev/null
+++ b/Documentation/technical/connectivity-check.adoc
@@ -0,0 +1,110 @@
+Connectivity checking
+=====================
+
+After receiving new objects via fetch, push (receive-pack), clone,
+or bundle, Git verifies that the new reference tips do not leave
+the repository in a state where reachable objects are missing.
+This verification is called the connectivity check.
+
+Connectivity invariant
+----------------------
+
+A repository is connected when every object reachable from its
+references is available locally (with exceptions noted below).
+The reverse does not hold: objects that exist in the object
+database but are not reachable from any reference may be
+incomplete or lack a connected closure.
+
+The connectivity check maintains this invariant when references
+are updated.  It trusts that all objects reachable from existing
+reference tips are already fully connected and verifies that the
+new reference tips do not introduce references to unavailable
+objects.  Verification is permitted to stop when it reaches
+objects already reachable from existing references, since their
+closure is already connected.  These trusted references include
+local references and references from alternate object stores.
+
+Without this check, a truncated or corrupted transfer could leave
+a repository in a state where later history walks encounter
+missing objects.
+
+Exceptions
+~~~~~~~~~~
+
+Gitlink entries (submodule references) are excluded from
+connectivity checking.  Their target objects belong to a separate
+repository.
+
+In partial clones, objects promised by a promisor remote are
+accepted as connected without requiring local existence.  The
+check excludes promisor objects from traversal so that it does
+not trigger on-demand fetches for them.
+
+Full connectivity check
+-----------------------
+
+The full connectivity check runs a `rev-list` subprocess, feeding
+the new reference tips via stdin.  A normal invocation is roughly:
+
+    git rev-list --objects --stdin --not --all --quiet
+        --alternate-refs [--exclude-promisor-objects]
+
+When promisor remotes are configured, a fast path based on
+promisor packfiles is attempted first.  If it falls back to
+the `rev-list` check, `--exclude-promisor-objects` is added so
+that the traversal does not trigger on-demand fetches.
+
+Consider the following graph after a fetch, where all reference
+tips point directly to commits.  For simplicity, only local
+references appear on the already-connected side; alternate refs
+play the same role.  N3 is a merge commit:
+
+            /-------------L2
+           /
+    C1---B1---C2---B2-----L1
+          \         \
+           N1        N3---T2
+            \       /
+             N2-----------T1
+
+    L1, L2:         local refs
+    T1, T2:         incoming tips (new refs)
+    N1, N2, N3:     incoming commits (N3 is a merge)
+    B1, B2:         boundary commits (already connected)
+    C1, C2:         already connected (but not boundary)
+
+The incoming set is the commits reachable from the incoming
+tips but not from the already-connected side.  Boundary commits
+are the already-connected commits at the edge of that set.  Here
+B1 is an ancestor of B2, which happens when incoming branches
+fork at different depths in the existing history.
+
+The `--not --all` arguments establish the trust boundary: the
+incoming set is the commits reachable from the new tips but not
+from any existing reference.
+
+The traversal then walks the trees of the boundary commits and
+marks those objects uninteresting.  Trees of incoming commits
+are verified against these marks, stopping at objects already
+covered.  The cost of marking boundary trees uninteresting
+dominates when the boundary commits have large trees, even when
+the incoming changes are small.
+
+Deepening fetches
+~~~~~~~~~~~~~~~~~
+
+For deepening fetches (where the shallow boundary moves), the
+full check omits `--not --all`.  There is no existing-reference
+boundary at which the walk can stop.  Instead, traversal follows
+the effective shallow boundary supplied for the deepened
+repository.  The new content may be below the old shallow
+boundary even when the tips themselves have not changed.
+
+Non-commit tips
+~~~~~~~~~~~~~~~
+
+When a new reference points to a non-commit object, such as a
+tag, tree, or blob, that object is not part of the commit walk.
+These non-commit tips are verified during the tree and blob
+traversal that follows the commit walk within the same rev-list
+invocation.
-- 
gitgitgadget

