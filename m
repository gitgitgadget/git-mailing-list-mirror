Received: from mail-qv2-f37.google.com (mail-qv2-f37.google.com [74.125.230.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16753148DD
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600573; cv=none; b=hrla+EIAciQaRmYXQpRPuCyYjlmB577h5ccbo1QE8xpP0pRDzwau8dpU4h5AoD1IpCQxeAKr3gnX/ecNY1KKLmfzxHEOJLOM9kCBnJnBozZi7K2I3uKMPmIbE7r2yvYMKIBGGlQx0e52Ljk4IXglwkNSjeOXXUMG4PtKW5wbuIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600573; c=relaxed/simple;
	bh=gAQJ4Xqp8l+T3L7N+40TPwrGWe3oiPAAJHIVXemm9m4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=B/UxPLrHdjuvG8sLOz1eu5ouxq5Ydh8FpIGmngMFiJ+4izDl3wHLHVAJ23CSwoHjIHGC8J6+a7rThmaYQBsxKX1LTbJKwtdgQa5EwRa0EUtI78I/jdPg5RV068MdAbOHPY2kSc7/6ZyAMNTmrbduvv2HEJNp+53tUYZH5zXN7wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niKRUJU4; arc=none smtp.client-ip=74.125.230.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niKRUJU4"
Received: by mail-qv2-f37.google.com with SMTP id 6a1803df08f44-91235f46716so27675216d6.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 06:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790600571; x=1791205371; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q+O6PK2EUa17RHITADJNUCSmA7pnZCYmr4Mln7xMYXg=;
        b=niKRUJU4E7Dpcb6hf72ds7kuXex/jy2DmQ7kW+KloUqTTH1fqTsz1qxN8uW1/RZ/s/
         9mu+VR7Xs22bbLtcOqg+fxN7MdD3HtAp6gzM0SDvb3Wbdgj5AmiCfXzE8HDE6Ayscjpg
         HB5usuU+10AGJZ7dI1cBJuBr3E/4OF1lNfaqvhMvrOl3Oom0LVT+DAxiBVoazJrVejlH
         tJJILzo/Wj3KnwIaQONWAcyGmeKi5/NuHMcgJGeqbpdFHxJFeFNtA0Jjwwh1GMaca3C/
         GMAjJSs3mrX5GvRXB9qN5hknm+svBHXl/Ze1lZMed+z406QqBQ/jOY0xSKKvbZW1GNUz
         bhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790600571; x=1791205371;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q+O6PK2EUa17RHITADJNUCSmA7pnZCYmr4Mln7xMYXg=;
        b=yDBgjrl0+DDLg0KJ6GZNOXj8B3jhbkuIb2eK8ln9NvpX8Y90JHeIQ9iTJE9GyAiGPu
         7UveLNCifdtxWz+PKcJYk1MjQMC4YQ8/du40eDQPRlZ6CiL52jp2Jxs27bekcgFmqP3k
         vc5aBGW6K3053t/drplLG8IHOYaiUpMb0q1Gsn06bsHlVTL1Mg3Zk6uYm8VD10kspukZ
         5+2E5ss4/K5VdBgxJ1eG/dC6GAPHi8+7dSqIYhNFbY6EIsQzFVpaMOxuvVj5o2cg8UVi
         fsSZM7mm1YgLsu3mR7BOxmBPC5UKfJ+dOQJVFGh1znkBHURF7Lkia9cBIbYr+3+Iax1L
         LzZQ==
X-Gm-Message-State: AFuF++kOWxOqkHqnEb0KahEn8vlIuH16svfMCE9ltPlCuSs4LOdgj4Ym
	1I6/NrdDkxJca5aqxFz2tN6qO2ARysiEHBNgtsmAeX6KD8Gojbk/XXWRWtxcmx1u
X-Gm-Gg: AYBFou33QOL3NdEiHrADPem8/aF2mSc/sqmkeMQAzJ33oOe1py2rSW5bZ+6ba66Zk/k
	II+7DiPvuVRdxoum8UxSaDlJEPURAXTQ+MXocAeJdP2bYdR7pminnJRHwCoetB+rII5s9bsRP0M
	GCk7QP6tN4HWvytZH+uHGasFPKNQfENEXqr+0EwKrCyptPPC4dLCzJs606LomuCujGfeesaX0CO
	vJ1ZJDsSHPrs5aQmbms8i0y32C7SB/hez2CXG0JHWf8Wwbq8856tAF8CKJMh3+JbQ3ygrOQOJ6F
	fK7DgnBDzEPcnfSlAtaLBsAY062J5vZQlV9RGDwuwJnaGkkjbt7AR0p4Zyp3aYg30TtXtFTjfUN
	fJPbxuyyQYi6g1b1FTOeAlvOl9Cj4vbhGUCuRHz5UA+vnLbkcRs+qfhn0hUMS99oo/CO8UrcRpy
	KXDuhSDcCN2qnXhpiH6XlcmLnvgeMriN6HwPICzGayuvPxtStzph3Sb+JqIGoBZi4OPXKYnBQ+
X-Received: by 2002:a05:620a:2953:b0:939:a45b:76ee with SMTP id af79cd13be357-93c43c8b51cmr1981019085a.23.1790600559538;
        Mon, 28 Sep 2026 06:02:39 -0700 (PDT)
Received: from [127.0.0.1] ([20.81.47.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c813fae1esm140447985a.23.2026.09.28.06.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:02:39 -0700 (PDT)
Message-Id: <97c11449aeae924436ba22a00a2545254e988a58.1790600552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2211.v2.git.1790600552.gitgitgadget@gmail.com>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<pull.2211.v2.git.1790600552.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Sep 2026 13:02:31 +0000
Subject: [PATCH v2 1/2] Documentation: describe connectivity checking
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
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add Documentation/technical/connectivity-check.adoc describing
the connectivity invariant and the full connectivity check.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 .../technical/connectivity-check.adoc         | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/technical/connectivity-check.adoc

diff --git a/Documentation/technical/connectivity-check.adoc b/Documentation/technical/connectivity-check.adoc
new file mode 100644
index 0000000000..d20bff6af6
--- /dev/null
+++ b/Documentation/technical/connectivity-check.adoc
@@ -0,0 +1,109 @@
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
+
+The connectivity check maintains this invariant when references
+are updated.  It trusts the existing connected state and verifies
+that the new reference tips do not introduce references to
+unavailable objects.  Verification is permitted to stop when it
+reaches objects already reachable from trusted existing
+references, since their closure is already connected.  These
+trusted references include local references and references from
+alternate object stores.
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
+`check_connected()` (see `connected.c`) normally performs the
+connectivity check using a `rev-list` subprocess, feeding the
+new reference tips via stdin.  A normal invocation is roughly:
+
+    git rev-list --objects --stdin --not --all --quiet
+        --alternate-refs [--exclude-promisor-objects]
+
+When promisor remotes are configured, `check_connected()` first
+attempts a fast path based on promisor packfiles.  If it falls
+back to the `rev-list` check, `--exclude-promisor-objects` is
+added so that the traversal does not trigger on-demand fetches.
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
+The check proceeds in three phases:
+
+1. Walk from the incoming tips (T1, T2) against the trusted
+   refs (L1, L2) to find the incoming set ({N1, N2, N3, T1, T2}).
+
+2. Walk the trees of the boundary commits (B1, B2) and mark
+   those objects uninteresting.  These trees are already trusted
+   because their commits are on the already-connected side.
+
+3. Walk the trees of each incoming commit and verify that every
+   referenced object is connected, stopping at objects already
+   marked uninteresting in phase 2.
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
+These non-commit tips are handled by the subsequent object
+traversal.
-- 
gitgitgadget

