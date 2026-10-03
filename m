Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8445B305692
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791034889; cv=none; b=K4F0GLsjSii7bNep8KmLfsR02BOiLfstEmPywZkcA4SXXT2qGLD2ueVu5et6sdxnSZyrTJN9z2aiJpiIsItXEfn4+LW7U45yh+MpkRSLHnc4U6g3ZrqnHI2juNhZJamUte/i9gZ+aPsvqT/9q2jepr16Q85ncGgu+t6ry8ycT+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791034889; c=relaxed/simple;
	bh=59++KilxEp1+davS2qtRR+TSwEVg049vYu4kzGi4NGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdO6jlCY71wVJgs3Z1tcCIVo6f/TFr8nCYXd6Lkh0/9A6lAYUlKVqqfbkGix4YNMzjkb/G6JuAa0ukI3ELPq1Bg18dgp165KGwGTTI+zqflyYNbotg0jCE62bQDHKKCTeKI5Ubg4lSrKqpWq1JyXNGMPsAvNSXSjX6NAJvNMZdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me; spf=pass smtp.mailfrom=5ouma.me; dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b=oGZj5qE0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BoPNS6fs; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=5ouma.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b="oGZj5qE0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BoPNS6fs"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A0B511400039
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 09:41:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 03 Oct 2026 09:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=5ouma.me; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1791034886; x=
	1791121286; bh=RKHk9TZHhg77KeShHxbmUSb1GHgbAbXbFAxBb1XGX6Q=; b=o
	GZj5qE0ggNc+QVFGepCg/wo99l176aD6dpHdeFdqT5iC3SEMOtOYib9a+epyCuzJ
	wDocAS/hIK/ctEFjq5blyNKv2DTUA8kHdyilPc7hvBzCm4lZbD65649Jtj6LadZd
	anfdfLWMWK+XPT3kXr22WAIliCp+UUBNzTS04pMO284Xtnu/5cyjE3nKIdjssYX/
	DuNcKV+TOYaWcoZBXhKDkXumH+mGrcZgEzcpyYiWrLpKQLkdX+ChhlLx6ZSmcfmq
	Yi6QZmEI9sLJgh8izQ7osm0wmpb3X/xNBxoR/4xWi3aJk8OmhHG9R091PGIEH+6I
	A1D50MKhOsMv8GKvze2tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791034886; x=1791121286; bh=R
	KHk9TZHhg77KeShHxbmUSb1GHgbAbXbFAxBb1XGX6Q=; b=BoPNS6fsUwT9Aud7z
	L4NZ+hIhOlD12Fyw8DV6ZbGqPGObWNaPrA22KKUvTo6ovBjQfrCco575vLCmeIPy
	87KA7VfDtwx/txxfYynEw8nCifFs2OSyWDbPCLEBYRLnS6BVqc0S18sdiDHkOAEv
	NtWqA4eGbWqTTnNoDrKuX59oaNDYgzfIyuec9swLUJWXNMbUeNH5xMfwS6UFD0cy
	YmpC7LDdhHwompB1vJyxqWNmm9/1XWnufP03FLZWIx5wxrZSlbKUj2a/Z05wDXwf
	atrAo5gbaEfwJI99NbzM2J8RBE/lJ99dpDbNDNeBxikaaUv0RYhuo2KNbuiuHHUE
	FCE6g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=5ouma.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791034886; d=5ouma.me;
	mf=PGdpdEA1b3VtYS5tZT4=; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:AYR8S9v4GVR35RtnVsC8W/rUY2goFjKCk0c/OkreubyLf/v
	r9t5P17Pxu+JtuJDelEXNv7YW7Ua2xQKUkyBucBNQlhOjtj1ozDKorLaEMBAzQWG
	vvlUqAoPkhc00ZyzwfrYVFIC/L35C1M9oIF27Ow/xrWrSx1ycW4bibNeafcGZxFd
	GKORdALgOeSR6wADZq67fVn0zyluYaqYP9F2ZpDBqj4yttHtl+2/A8blDHRqKJfC
	FsqtiU04yBiDMqbBuQksSWlC5uwdQcgOvTCNnHID7H9ZuVcN5nxUQ5MniE4oNV3r
	csQPCQ5k/afQ7t0vQ+GBMC764ypYz2mBiEeqllA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:BFg/JbshUFNI8h5nYOwdbI+yGJWD/GylToeUpgthpF4=:59++KilxEp1+davS2qtRR+TSwEVg049vYu4kzGi4NGw=;
X-ME-Sender: <xms:BgbBakuV2eIjeiz5XtLfLx8vDkXb1Sx9QeLeSXMiYuz7A2epWOoIBw>
    <xme:BgbBaoezGCF7TOdrUPXTqvJ_pV7uqtxsCLMsrVMaNRPnx3RIrSRWM6Ef3_IGfpadh
    a1Fys6O__4qOtvC08WfMEXjR900HfUJ87JAvalCskP7aKO2OKveXb6A>
X-ME-Received: <xmr:BgbBakzILUn1BE2RLaJo2kcp_mHfk7iEMj9Juf4cURB3MBQUFYdgJZ4YngrXz7LodKkB_7Jel0Jzw_xrohSbfVPjPQfV4ljaeYFVypYnxXc>
X-ME-Proxy-Cause: dmFkZTEOeC8kwRILiVjK/UYpCStXnnHQi/ufv/zo99gpz4aRFhpDLFRmf357u/EPpi4E91
    y2yoUIsgZ1j7/X3EppQ8948OxgwANuoJTHHdIj6Q89MciqLQV6a5EbcHM7sM1DNje9XBmT
    aEjUe25Bv17nuZEiIrli0J9OYhezIAb6fJrkNK8jwmlvDhdESEAlFc+/9npuWEkfdsZ3GO
    p0xnTc3VzHSkdQ2HPHji95s/JxRYR6ynPBk0M4JdPfpPQ+nacVBpw7XvxIjjbBJc0M6Aem
    dW2XOqCsZlkWe48ZVMM4R7fEnmEPyZvHc/Y/gGvj5JItfh1PtChTtfInHF2cwPBRXiK6iy
    4RTLg79nsIkSuegw7MvLsWVXgLOAr7Zn3EW6gzCniGN/IIssBNvpYUnIoX0eStEVYbRS08
    9IUDsThsM51xmVzrsLADULc6iBaShvcDzzElkxtqP6WtUeFiQ3yfwQ3+MMx56T3wh1wNcK
    wIWo120pkUwt3t3JHpZEA/0eK+A25wWZB/bFvYumGCmR2pYAY+ksPGqclVHaP9WOxsnXTe
    qMBZsJPFC1UZHVL5UiltA4XTZjAKnzKJpvgFQ0rsMJ7VWzsjBNWPSE2clHgxCFrOvLxNab
    8mxbMjMH3mvp21cf8gFkSOzuRtiSIMS6tsEi/HAWLttPDDFipFMKwBkgnpzQ
X-ME-Proxy: <xmx:BgbBamGeorFo-EiEl-Pu6D2e3a6U2Viz-C38JUBkHErV3PwbCyhoCw>
    <xmx:BgbBagzLNYmG_s9PbjwfBwHKG-23Dsahp8CPUqYuR02eAuYv8riMaA>
    <xmx:BgbBavuJ-qXxr80Tc4oLEwfyPUnCWXMP-oxTqvRdmbKZXFAu_1J0Zw>
    <xmx:BgbBal1V8ygCyKFpqxqo4pdJaxeQeVHPBDK1Gzt6BtPOe2YXaKyfXQ>
    <xmx:BgbBarZS8XcGxiiFuIuRdggvuDutfwi94SXzgBrJtbLMma_YcvCVGEun>
Feedback-ID: i4b264863:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Oct 2026 09:41:24 -0400 (EDT)
From: Souma <git@5ouma.me>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Souma <git@5ouma.me>
Subject: [PATCH v5 0/2] history: sign rewritten commits
Date: Sat,  3 Oct 2026 22:40:56 +0900
Message-ID: <20261003134058.23494-1-git@5ouma.me>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260703145037.69832-1-git@5ouma.me>
References: <20260703145037.69832-1-git@5ouma.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

History rewriting creates commits through two paths: the history commands
write replacement commits directly, while the replay machinery recreates
descendants above the rewritten range. Neither path currently honors
`commit.gpgSign` or an explicit signing request, so rewriting signed history
can leave the resulting commits unsigned.

Add a signing-key option to the replay API, then have the history commands
pass the selected signer through both paths. Expose the standard
`-S`/`--gpg-sign[=<key-id>]` and `--no-gpg-sign` options for `drop`, `fixup`,
`reword`, `split`, and `squash`. This applies one signing policy to every
commit created by the rewrite, including both commits from `split`, the
commit from `squash`, and replayed descendants.

The behavior follows rebase, cherry-pick, and revert:
`commit.gpgSign` supplies the default, command-line options override it, and
the last command-line option wins. The signature attests the current
committer's rewrite while preserving the original author identity.

Changes since v4:

 - Add Git completion coverage for `--gpg-sign` and `--no-gpg-sign` to the
   history subcommand option tests

Souma (2):
  replay: allow callers to sign commits
  history: sign rewritten commits

 Documentation/git-history.adoc | 18 +++++--
 builtin/history.c              | 96 +++++++++++++++++++++++++---------
 replay.c                       | 13 +++--
 replay.h                       |  6 +++
 t/t3451-history-reword.sh      | 63 ++++++++++++++++++++++
 t/t3452-history-split.sh       | 44 ++++++++++++++++
 t/t3453-history-fixup.sh       | 39 ++++++++++++++
 t/t3454-history-drop.sh        | 50 ++++++++++++++++++
 t/t3455-history-squash.sh      | 61 +++++++++++++++++++++
 t/t9902-completion.sh          |  2 +
 10 files changed, 358 insertions(+), 34 deletions(-)

Range-diff against v4:
1:  d45cce8e25 = 1:  d45cce8e25 replay: allow callers to sign commits
2:  8b4766fc0e ! 2:  65f3de1562 history: sign rewritten commits
    @@ t/t3455-history-squash.sh: check_commit_author () {
      test_expect_success 'setup linear history touching two files' '
      	test_commit base file a start &&
      	GIT_AUTHOR_NAME=One GIT_AUTHOR_EMAIL=one@example.com \
    +
    + ## t/t9902-completion.sh ##
    +@@ t/t9902-completion.sh: test_expect_success 'git history subcommand options' '
    + 	test_completion "git history split main --" <<-\EOF &&
    + 	--update-refs=Z
    + 	--dry-run Z
    ++	--gpg-sign Z
    ++	--no-... Z
    + 	--no-dry-run Z
    + 	EOF
    + 	test_completion "git history fixup --upd" "--update-refs=" &&
-- 
2.56.0
