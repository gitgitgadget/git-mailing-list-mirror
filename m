Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051532F3C10
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 02:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763606943; cv=none; b=sv7+tuT9pCdy4vUolHYH3ovlDK//Gih+ei0t6koaFnCI90+tbY+MsX+ZiWA9KYgYIMYhw0gX6F19KK8xwx11CBzb2IGJuoZtIYbO8sIo/4tYvBGY/59IHuKOrsB+bU9kJ2A+zv+lBkakgxbUbk63gwsN6bUletLCbMie2aH0FjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763606943; c=relaxed/simple;
	bh=DMVJ9RW89/sSyAWmZvUw+9V75dRIzxJF84uU7FUH/eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVNyKDveolkJzePwEHd+absn78GjZ1FMaiR6hDLKau665XBew9bnAyxNBqkACAlDBo9QF+BJ5Gq4Nk/BeSFWF6QXFAScBwKHA24qz09inxvKNpV80R5FWDc0vSavfGpye4D90oKfGpQIKnznwX9CS9lAD4tOB7ITeqrdx9NLTgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kitware.com; spf=pass smtp.mailfrom=kitware.com; dkim=pass (1024-bit key) header.d=kitware.com header.i=@kitware.com header.b=PKqhg9dy; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kitware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kitware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kitware.com header.i=@kitware.com header.b="PKqhg9dy"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b144ec3aa8so37486485a.2
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 18:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kitware.com; s=google; t=1763606935; x=1764211735; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/8zsATG0gCnA6MbhL3qZw4WsQ3yqtxUCNZZaZgOnK8=;
        b=PKqhg9dypioIYztk6ekWMjlFeYFStdzocJzSnkkkmfOCuak9njLjht4REYR/hfqJnd
         Ow67vlX3VzeD5tDgTQVkQqQVLUeAtrJOtK1dw15vXYGXjuuXN9f++FOB1eSHyFMjeuO5
         hto7lLlXhcK/d5IuOxJk31WY8a2IkG03xE25s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763606935; x=1764211735;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z/8zsATG0gCnA6MbhL3qZw4WsQ3yqtxUCNZZaZgOnK8=;
        b=WD0nLEd8PMAuj+ObY8DLC4IyJz8cayKKPsZ6/bPZa7ye+1bHVOQWEduJ2tP1A3de17
         iroN5pS9bRn7nvAHg9ddGNIG97aMAj7s7FHw16fNwScWJgMDsS1ny3whyT194E5584Vj
         5Tcw1Ylo4PHac5oPD9ksrO7N9xDK5ppzmZQzknatBLgyKbq4WzRqZnJC5d4q/8rWjq0B
         f7GMlY4vneQ45FGuRZXcLAFchIPm0x0xiUSMmBcl7oXiyxiRDAgLvx2WLYlM6UqJwgnl
         Zv8BWMSfLRevZft7BP2V27pdc68GwL/JFLVI3LhYHgoQybRSBgM3x7rQgYtHldelbdXI
         brAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4RecJLHvq7M4p20vgQv/C6IGx46HnB3+iONLpnsghPQ09asLnepbgWLdDoysqVRHvcv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/1TAlG01+J+GriSUPsOC5GObyae5PiotjYQBxPym8aoOjnsKY
	mizZljsp1FpFkjcC12EFrNqeDC2oeGgjweNzUHU/vqxlbjcp0JuvATAC1RAHpHkbLg==
X-Gm-Gg: ASbGncta+migk7Qdyj+jcBXk4zP5AJOif+KbIq8m6pR+F4UTRTQSfwc/KaxsYbla2I2
	dEsQ8bHEiz2K3fD+xvcPQkQ4KRJSh/yTuDTHkgoZ8vNZU6wdxZfMAuiIDjaA/RQSSSHoR40aC/2
	IZs0FqNv1x5r8OrMmRJ3XbRczvfUhJb26/mfihBo2nQvHXc4J63f8fHw2Vqb+WgBZ8J4gaoV2+m
	fFVbpzneXMkVEuTTe52O9cfnOC0RJqusclyvKIAeXl40a+emq+uW1j2uvshpRu2vRGM7pevaivx
	1ueGoT6zbZsL3VxeoghAu3QHLKMexGFFTdBxlPmw62KBDUKiLj+cX7hec8QVip9f+LunUQNmhiB
	bpL1xxylVVe53NBX1crjhOIN/JiHyLOZjRJqTIkh9V8FxHYbZqjXggg603kZVZkvX1nZH5RrZ
X-Google-Smtp-Source: AGHT+IEcdjd+xxDku6hGKzPGYjOD/xv3se5dAX4OdPicYkPDcoONcOTcLZcVgqLXiSTnbZHNQpNvlg==
X-Received: by 2002:a05:620a:3952:b0:8b2:dcde:b668 with SMTP id af79cd13be357-8b32f381dc9mr27254885a.62.1763606935002;
        Wed, 19 Nov 2025 18:48:55 -0800 (PST)
Received: from localhost ([2601:985:481:1ca0::acf2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e54c32csm8404936d6.37.2025.11.19.18.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 18:48:54 -0800 (PST)
Date: Wed, 19 Nov 2025 21:48:52 -0500
From: 'Ben Boeckel' <ben.boeckel@kitware.com>
To: rsbecker@nexbridge.com
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [BUG] `git describe` doesn't traverse the graph in topological
 order
Message-ID: <aR6BlHflRVLN8_XO@rotor>
References: <ZQ21NsLmp+xQU5g+@farprobe>
 <02d701d9ed6f$abcb4b00$0361e100$@nexbridge.com>
 <ZQ3GAJ/AHsM9e9a6@farprobe>
 <02e701d9ed78$436b3c60$ca41b520$@nexbridge.com>
 <xmqqediq2j0g.fsf@gitster.g>
 <032d01d9ed80$5e569670$1b03c350$@nexbridge.com>
 <ZQ3ggxA7KOysXrba@farprobe>
 <033201d9ed85$991c6af0$cb5540d0$@nexbridge.com>
 <ZQ3leoLhljc+P5wP@farprobe>
 <033c01d9ed8a$c6916f30$53b44d90$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AhNYXGBA/mpGAjiU"
Content-Disposition: inline
In-Reply-To: <033c01d9ed8a$c6916f30$53b44d90$@nexbridge.com>
User-Agent: Mutt/2.2.14 (2025-02-20)


--AhNYXGBA/mpGAjiU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Sep 22, 2023 at 15:27:01 -0400, rsbecker@nexbridge.com wrote:
> I actually thought it worked that way. This may end up in a bigger
> change than fixing the issue because --first-parent does not appear to
> be sufficient to resolve the correct tag from your graph. My thought
> on using multiple commitish values to do that may help, but
> implementing that could lead to an O(n*m) scan (n=max commit tree
> width, m=depth to tag), plus a commitish hash lookup.

So I finally found some time to go back to this. The actual fix is
actually rather easy (patch attached). However, as guessed at previously
in the thread, the performance is in the tank without an up-to-date
commit graph ("instant" with it versus "minutes" without). On the other
hand, it is *accurate*. It does fix one expect-fail test case already in
the test suite (also included in the patch).

We could go one of two (or more! feel free to offer alternatives) ways:

- swallow the pill and accept the performance for accurate results
  (e.g., warn if there is not a recent `commit-graph`)
- add an `--accurate` flag to optionally use it with the caveat that
  reported descriptions may *change* under the flag (e.g., with the
  reproducer script, a "working" description is `tag-release-7-g<hash>`,
  but with the graph, it is the correct `tag-release-5-g<hash>`.

Also note the the reproducer provided was "fixed" in 7379046221
(describe: stop digging for max_candidates+1, 2024-11-06) because it
stopped searching because there were no more tags in the history.
Tagging the root commit preserves the reproducer state. I've attached an
updated reproducer script as well.

Thoughts on a plan forward?

--Ben

--AhNYXGBA/mpGAjiU
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename=0001-describe-traverse-commits-by-ancestry-instead-of-com.patch

From ca4df5b9c9542315f77c166d47d5c63a2ebdafd1 Mon Sep 17 00:00:00 2001
From: Ben Boeckel <mathstuf@gmail.com>
Date: Wed, 12 Nov 2025 23:53:20 -0500
Subject: [PATCH 1/1] describe: traverse commits by ancestry instead of commit
 date

An ancestor commit should never be traversed before its descendents.
This could happen if a series of commits are made in rapid succession
and they all share a commit date (to the 1-second resolution supported
in the metadata).

This was discovered in VTK's history where a `git describe` would return
the previous release's tag name rather than the one just made. The
problematic topology looks like:

    H ---- M1 -- M2 -- M3 -- M4 - ROOT
    |       \     \     \    \    /|
    |        \     \     |    \  / |
    |         \    R2 ---|---- R1 |
    |          \   /     |    /  /
     \          \ /       \  /  /
      P1 - P2 - P3 ------- P4 --

Where P1 and P3 are tagged commits. If all commits share a commit date,
`git describe` traverses in the following order:

  - H
  - M1
  - P1 (tagged)
  - M2
  - P3 (tagged)
  - P2
  - M3
  - R2
  - P4
  - M4
  - ROOT
  - R1

Although P1 is traversed before P3, P1's depth is incremented due to the
`flag_within` check despite the ancestry actually being the other way
around. When all is said and done, the description is reported as
`P3-7-g<hash>` despite the P1 tagged commit having it as an ancestor. If
P1 is restricted using `describe --match`, it is reported as
`P1-10-g<hash>` due to the traversal order issue.

Using topology sorting on the commit queue, the description is
accurately reported as `P1-5-g<hash>` instead and the traversal order
is:

Instead of commit date heuristics, use ancestry as the sort constraint.
This also fixes one expect-failure test case as well. However, the
performance depends on having a `git commit-graph` available.

Reported-in: <ZNffWAgldUZdpQcr@farprobe>
---
 builtin/describe.c  | 20 +++++++++++++++++++-
 t/t6120-describe.sh |  2 +-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index ffaf8d9f0a..789586e5a5 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -3,6 +3,7 @@
 
 #include "builtin.h"
 #include "config.h"
+#include "commit-reach.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
@@ -256,7 +257,23 @@ struct lazy_queue {
 	bool get_pending;
 };
 
-#define LAZY_QUEUE_INIT { { compare_commits_by_commit_date }, false }
+/*
+ * Topological comparison: always return parents before children.
+ * This is reverse topological order: children before parents.
+ */
+static int compare_commits_topo(const void *a_, const void *b_, void *_unused_ UNUSED)
+{
+	struct commit *a = (struct commit *)a_;
+	struct commit *b = (struct commit *)b_;
+	if (repo_is_descendant_of(the_repository, a, &(struct commit_list){ b, NULL }))
+		return -1; // a is descendant, so comes before b
+	if (repo_is_descendant_of(the_repository, b, &(struct commit_list){ a, NULL }))
+		return 1; // b is descendant, so comes before a
+	// fallback: order by hash for determinism
+	return oidcmp(&a->object.oid, &b->object.oid);
+}
+
+#define LAZY_QUEUE_INIT { { compare_commits_topo }, false }
 
 static void *lazy_queue_get(struct lazy_queue *queue)
 {
@@ -413,6 +430,7 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
 		struct commit_list *parents = c->parents;
 		struct commit_name **slot;
 
+		fprintf(stderr, "\n\nlooking at commit %s\n", oid_to_hex(&c->object.oid));
 		seen_commits++;
 
 		if (match_cnt == max_candidates ||
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 2c70cc561a..36e1b9d848 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -711,7 +711,7 @@ test_expect_success 'setup: describe commits with disjoint bases 2' '
 '
 
 check_describe -C disjoint2 "B-3-gHASH" HEAD
-check_describe -C disjoint2 --expect-failure "B-3-gHASH" --candidates=2 HEAD
+check_describe -C disjoint2 "B-3-gHASH" --candidates=2 HEAD
 
 test_expect_success 'setup misleading taggerdates' '
 	GIT_COMMITTER_DATE="2006-12-12 12:31" git tag -a -m "another tag" newer-tag-older-commit unique-file~1
-- 
2.51.1


--AhNYXGBA/mpGAjiU
Content-Type: application/x-sh
Content-Disposition: attachment; filename=2-repro-git-describe.sh
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A=0Aset -e=0Aset -x=0A=0Areadonly workdir=3D"${1:-repro}"=0A=
=0A# Give ourselves a fresh start.=0Arm -rf "$workdir"=0Amkdir -p "$workdir=
"=0Acd "$workdir"=0Agit init=0Agit branch -m main || :=0A=0A# Make a root c=
ommit.=0Atouch repro=0Agit add repro=0Agit commit -m root=0Agit tag -m root=
 "tag-prev-root"=0A=0A# Create a branch and merge it according to Kitware w=
orkflow guidelines.=0Amake_branch () {=0A    local branch=3D"$1"=0A    read=
only branch=0A    shift=0A=0A    # Create the branch.=0A    git checkout -b=
 "$branch"=0A    local base=0A    base=3D"$( git rev-parse HEAD )"=0A    re=
adonly base=0A=0A    local topic=0A    for n in $( seq 1 2 ); do=0A        =
git checkout -b "$branch-$n" "$base"=0A        echo "commit $n" >> "$branch=
=2E$n.txt"=0A        git add "$branch.$n.txt"=0A        git commit -m "topi=
c $n for $branch"=0A        topic=3D"$( git rev-parse HEAD )"=0A=0A        =
# Merge with `main`=0A        git checkout main=0A        git merge --no-ed=
it --no-ff "$topic"=0A=0A        # Merge with `branch`=0A        git checko=
ut "$branch"=0A        git merge --no-edit --no-ff "$topic"=0A=0A        # =
Sync with `main`=0A        git checkout main=0A        git merge --no-edit =
--no-ff -s ours "$branch"=0A        git checkout "$base"=0A    done=0A=0A  =
  git checkout "$branch"=0A    git tag -a -m "previous tag for $branch" "ta=
g-prev-$branch"=0A=0A    git checkout -b "$branch-tag" "$branch"=0A    echo=
 "release prep for $branch" >> "$branch.prep.txt"=0A    git add "$branch.pr=
ep.txt"=0A    git commit -m "commit for tag preparation for $branch"=0A    =
echo "tag for $branch" >> "$branch.txt"=0A    git add "$branch.txt"=0A    g=
it commit -m "commit for tag for $branch"=0A    git tag -a -m "tag for $bra=
nch" "tag-$branch"=0A    git checkout "$branch"=0A    git merge --ff-only "=
$branch-tag"=0A=0A    # Sync with `main`=0A    git checkout main=0A    git =
merge --no-edit --no-ff -s ours "$branch"=0A    git checkout "$base"=0A}=0A=
=0Amake_branch release=0A=0Agit checkout main=0Adescribe=3D"$( git describe=
 )"=0Areadonly describe=0A=0Acase "$describe" in=0A    tag-prev-*)=0A      =
  echo "failed: found 'tag-prev-'"=0A        exit 1=0A        ;;=0A    tag-=
*)=0A        echo "success"=0A        :=0A        ;;=0Aesac=0A
--AhNYXGBA/mpGAjiU--
