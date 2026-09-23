Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9F251DAEC
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169414; cv=none; b=TmR6YZSFN75kwXjyvafnK/U3B+emvSWtQ+jdxS+DpOt8GL5G715nQazmjaEaFNCQyizPaOdSazEk2egR3lS/eUk31PPZ02TIwY7WOGwyA6YK5krMIpljG7xRjgjJ+XiqrL38jEKGoO4Qt2+o2EhW9rp9BDvBTyHbabK7QY0rkC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169414; c=relaxed/simple;
	bh=SzLUcKZ21kw+zeDaHlPhdH9EdTQab8Lp2V3uH/UlJN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eySASfN+/8OXjtG3+M5gmSWPznxyhdyuAVexHdB5tV2hDYERQBDJDEFvIfQjHQYXPAIhmHDIUqXr9atqD4JdYHOZn7hSoobL9iG85pUriIXfDuUlmBPNArLh+ASk1kklQ2g6V5izeUf2QRgQKOKVDCSvo+9m0PySN60EztXQ008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=y6Ouo19u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cTGYpYyl; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="y6Ouo19u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cTGYpYyl"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DF64B1D0007C;
	Wed, 23 Sep 2026 09:16:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 23 Sep 2026 09:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1790169411; x=1790255811; bh=t6jfWh76UX
	Vx9ItE7NSk3NWxfftmp031zUID17r08Tg=; b=y6Ouo19uvd9C9mBanlePNUIQR0
	3tcIPzxkPNYnngis7vuM9cgfxHGYZsAW5xvsWTHMDeOuYmo8CSrQG3cVyA/3wXoU
	4liTbNgE1vnlkbo1WCpuTu5hBTdnLgIKvbAPY/4k4vvd+tdquvdnWXzDRPnw2i6+
	b2xTfBfd8rBHjXE9lIpRO3rVKHSqzihLTKPfDTezHmctKQHqlCwNnzmC9rioUslR
	xXHSukR86NU80Yuk+WzQPHDvcyrHoJNpcjfOL1YUkiAPY4AFTXrs/6t01tD1dbFd
	RR0Y4ZKfpYU21koQn12bGL2QFnrcfPIzhjSUGz4jrG6CkyVqNBIvE/7x32/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790169411; x=1790255811; bh=t6jfWh76UXVx9ItE7NSk3NWxfftm
	p031zUID17r08Tg=; b=cTGYpYylGoZO6JFgt3ZIQ7ooNfkSWZBsrkxcG2QrpCgy
	96xRvV6jwin4bsDm00gQeIUEWmuJJrNTiSnbUbZnFaFfdKXDoZLPLj7CxokXWfv1
	EEsNh3KjhlkO/dhNGPxbT3q9yYWFuUZcwTkaCahC9kSnGolZQEgwhD1Rr4bjNZYy
	mz05eYxhkV2K+PW07vxjuOJ3/Om1LOo+sbj9Ru3OGuddtdueu+A3224TVFBn7q2u
	4g25ofv9APyuFOhyeLO5nvmwU2GEurhQZ/aJxr2f+5a5ndpUqY1QjK+wY6BfKEBa
	HD7jXu3IjCdsUKVBOdq1TZ6OEYE68/NjkJO5ggEabw==
X-ME-Sender: <xms:Q9GzaqnXNahC37yJNEcUlGYZ0StSdiWUuGmr8I2VvZXg9Vn9i2AlPQ>
    <xme:Q9GzapSgTA4PGF7P_kc-aPed7zhBll7tmDhGWi1i2sHZviTZdXIzAninrvTzqw6HI
    ci_ybCbX1PKNAo9r8w-A2qjR4XNujgdhEVzRL67PloShmYz_PwnWF8>
X-ME-Received: <xmr:Q9GzamBf04NPkN0i5D-jM3zIsomqQTc3ugRVoOO7XtEdL0aIom0hfg>
X-ME-Proxy-Cause: dmFkZTGm+qnOoUsABJZvVgIzcUWGn28vcttUh+T+TA2kQiybcPE7fA+0ssG64ITuWr36pN
    1e1whxyTiN2pHATrNR0Mp5MgFbHnQO+i0pUnmoJxVuWc/n8+f+JZLs0cdTgkue2RHlPF2n
    UsSTDspCJ+e5/WlAGtGqFrRPYMdM/y9BKKInwoB9r2QeZsDUjBIARYCBe3fRq1DfwALHwd
    Tt/xlT95iNky8nu/0UTjNZjDYIZ36hryqyKfK2sE/HjwL7u71yC5XTkbnGFrX2/ABHhc54
    Xgvt7ISkXmQjNeS4Wq3ZEgTLkQjvvy19AEuNe154XX5ygNLMvxxaBpvrInUuZk54UM3kqc
    XkdtxDc8O+HEgjAd72cCUoEr299rOaxePlBroi1QMSiUnbmyCrxplZa4HbmGIrcRIDtl+R
    KvPfwQ5fWxnp2IbUVotaWdL+IXiiXLEv5Ha1XGGcuMfT3pvXv1DekJ/2aiWJlm3Z7KR/MS
    pZmAhfN0bpw4KPz7QGuCngfHfeVC5E4EfwapRYh/bk8eMqzwsJ8zd2+pTfGKsqXJeALQWP
    G1mRB1NmjO4tYpqfu8i2RIY5z8+Jy/+iyJAWmTrznZubl5d1KrtJc44DUcVGpifbVHz8mu
    svTA43cZxypYH42Wv94G39p6dHyYzwMcW+7dbcXMYNfwIeH2vIXdSKJ7KwZg
X-ME-Proxy: <xmx:Q9GzaoRf-h1DEp7QEr8Xv6TBSyJLNFTDQ1i8TrxXITHHj-zAaq-ifw>
    <xmx:Q9Gzasq-fKWYfAWRJAhtml1w9sHAhc17Re08scw2HET3k5EZOiO-ZA>
    <xmx:Q9Gzaiw5UKJqb0IVRbzsc5c5ox_aJzUYqHWty5xtqLyHmmo0phYA6g>
    <xmx:Q9GzapLp6HmTr0zs0PFX8_kzQ_nf4FS8tTpds1EDxierxrFyDkrSIQ>
    <xmx:Q9GzatRLPV3e9M0qVXKhOvizPvrwBYX3mXl2iePzLIqbB-SLQNi4xJtT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 09:16:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 64ee6ea2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Sep 2026 13:16:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Sep 2026 15:16:43 +0200
Subject: [PATCH REGRESSION] builtin/rebase: allow user to amend committed
 conflicts again
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-pks-rebase-conflict-bug-v1-1-3d3ccf5022bc@pks.im>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQqCQBBAf0Xm3MC6kmJ3iS4FeowOu+toY7HKj
 kYg/ntbHR+P91YQCkwCh2SFQC8WHn2EdJeAuxvfE3IbGbTSuSp1htNDMJA1QuhG3z3ZzWiXHtM
 ip0zvTauKEmI9Ber4/Ttfoa6OddU0p8sZbn8nix3Izd81bNsH4xEHQYcAAAA=
X-Change-ID: 20260923-pks-rebase-conflict-bug-176e325ad079
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.15.2

In 6257588252 (commit: refuse to amend during conflict resolution,
2026-09-01), we have introduced logic to git-commit(1) that makes it
refuse creating a commit in some cases. This was done to remove a set of
common foot guns.

One of these foot guns is when the user is performing an interactive
rebase that stops at a conflict. Most of the time when we stop at a
specific commit we want the user to amend the HEAD commit, so they have
been trained to use `git commit --amend`. But when there's a conflict,
they are instead supposed to commit it directly without amending the
HEAD commit. So to remove that common pit fall, git-commit(1) now
refuses amending in that situation.

The logic that detects this scenario checks whether the file
"rebase-merge/stopped-sha" exists, while "rebase-merge/amend" doesn't.
And this is exactly the case when git-rebase(1) has stopped at such a
conflicting commit.

But there's one problem here: this state persists even after the user
has already committed the resolved conflict, and consequently they still
cannot amend after they have done so. This is overly restrictive though,
as it's quite likely that a user may want to change the resolved commit
once again.

Ideally, we'd be able to easily check whether HEAD has already been
updated to have the resolved conflict. But it seems like we do not have
sufficient information to determine the original state of HEAD when the
interactive rebase has stopped, so this is not a workable solution.

Instead, use the existence of "MERGE_MSG" to figure out whether the user
has already resolved and committed the conflict. It feels somewhat fishy
to base our decisions on the existence of that particular file, as it
really is only a proxy for what we are actually after. But the whole way
that we track rebase state is somewhat iffy in the first place.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this is a regression caused by 6257588252 (commit: refuse to amend
during conflict resolution, 2026-09-01). Ideally, we should probably fix
it before we release Git 2.56.

I'm not particularly happy with the proposed fix -- it feels quite fishy
to use the existence of MERGE_MSG as a proxy for whether or not the user
has already committed the resolved conflict. I couldn't come up with a
better proxy though, so if you have one please let me know.

Thanks!

Patrick
---
 sequencer.c                   |  4 ++++
 t/t3404-rebase-interactive.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index e25ef5eb61..0f718c1d38 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -7045,9 +7045,13 @@ enum ongoing_operation sequencer_ongoing_operation(struct repository *r,
 	 * `amend` unless it stopped with HEAD already pointing at the commit
 	 * to be amended (a clean edit/reword stop); its absence therefore
 	 * marks a conflicted stop.
+	 *
+	 * Note that we also check for MERGE_MSG. This is to catch the case
+	 * where the user has already resolved and committed the conflict.
 	 */
 	if (file_exists(apply_dir()) ||
 	    (file_exists(rebase_path_stopped_sha()) &&
+	     file_exists(git_path_merge_msg(r)) &&
 	     !file_exists(rebase_path_amend())))
 		return ONGOING_REBASE_CONFLICT;
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 8c63682b7f..d55afaa113 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -2486,6 +2486,40 @@ test_expect_success 'non-merge commands reject merge commits' '
 	test_cmp expect actual
 '
 
+test_expect_success 'can amend after committing a conflict' '
+	test_when_finished rm -rf repo &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit original file &&
+		test_commit modified file &&
+		cat >todo <<-EOF &&
+		break
+		edit $(git rev-parse HEAD)
+		EOF
+		set_replace_editor todo &&
+		git rebase -i HEAD~ &&
+
+		# Modify "file" to cause a conflict.
+		echo conflict >file &&
+		git commit -a --message conflict &&
+		test_must_fail git rebase --continue 2>err &&
+		test_grep "Resolve all conflicts manually" err &&
+
+		# Resolve the conflict.
+		echo resolved >file &&
+		git add file &&
+		git commit --message resolve &&
+
+		# And now try to amend to the conflict. This operation should
+		# succeed.
+		echo change >file &&
+		git commit --amend -a --no-edit &&
+		git rebase --continue
+	)
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged

---
base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
change-id: 20260923-pks-rebase-conflict-bug-176e325ad079

