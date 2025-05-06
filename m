Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11152820C8
	for <git@vger.kernel.org>; Tue,  6 May 2025 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540770; cv=none; b=Q2AdkluRUTCj4mXkQ2nxfp4i1Z2Fz0Dvoq8A7p3F6nUHEE550FOgCWiNShFIlQJMDzShES0Ai9D9g+cYcM6EU+xUpxLNyI8EzDdtAMDVJUAy4+DpHydxKKBaotSTJPwFOeTtl5AUqigaGhoNZ4Gjq5HKmITcUl/yMlvvCKA4L8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540770; c=relaxed/simple;
	bh=232BauiBaKf/IKnv0Czrg89is7OWflLG9qfxfFTZ4BM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=arhFFVsG3CkIhKPXREVev5FFT4NMvyO82xgI8l36sfNJjZ1MNRrKqKcGut//dVfc26cHx+V/bU+MAIxwBadjBODL4sqblAYvANdfQEJWyMl6EEF0qWrdeLRowgkLSIq6KlQDUo4wUUgr729D18Zw2wIGIAeoRFRec69aRKmK6Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RcYeMcsU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dDfbeNhk; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RcYeMcsU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dDfbeNhk"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 532291380EF8
	for <git@vger.kernel.org>; Tue,  6 May 2025 10:12:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 06 May 2025 10:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746540768;
	 x=1746627168; bh=VKoIjnZmkYL8WRitVHoY16z99aRlcpBd6DYKoS74EAo=; b=
	RcYeMcsUe4bKpc5adhSHVTD3XSGTkAILMybaNiLne9AlUbFRzfsLVcsCUqhGMHsr
	PW33AcxRgYPs5YQ/9+2ohvnFXXl4UMbPzMSan/ymv0KySd7DTAU2P33QJFyjzDwQ
	Hnv+K1GOIFEjlZsg/NAZyQu8lDlJFL5Qluv829SSPD2X/+lgtXAFkGB8UpE6EoQM
	9wCg413dRaJtpu/qdKmfH/hTBYzqq45kKY+cRxWJ4sLM22JNGkahek01JSu7Ztt7
	vcV9sl4si+Y9DZj9E/3QnljmgwpSuFmgnE29BLC4OnbHHaI2iVsPCZPqsG6CIwZa
	rKWpVzatkX3XH4YQ9Y6DiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746540768; x=
	1746627168; bh=VKoIjnZmkYL8WRitVHoY16z99aRlcpBd6DYKoS74EAo=; b=d
	DfbeNhk0ywb2q396pdSdcjZqLISx/pHqewaZtDQ8KKd7U+/kFSBiNcDStBifTtRL
	3YuMZur9GyS2CXeye0xPcYu1moDbb0acWyKZWaKk+59agxVx+ecJl4zmj4ATqFsg
	wYYosJ9AnzZJ9MM9kBAfiR+S91USocY1M2PTQsdUD+Q7Sh2+K1cgsUZN+nBAL41O
	iqIFpR/MmJDAfCRuMBlWCmlOp2eTYqApPIIMHybJX+1nciBS/1lgZeyyaMrCk052
	2h0TqMMHtCCmMsFxCqIVpWNHigeF4PdhuxfXfTuZnp7WifNW0gWa3Xl0ulQCsl2w
	a2expytF+fv5Sf95+eH2Q==
X-ME-Sender: <xms:4BgaaJC4SEQs9FUbmaVs0nuUt7d4db_frOpjzKxfqmDrpDwPLNGcyA>
    <xme:4BgaaHgRfrXqycABQ4eVzwMK8ljFdr8252Dxg2p0qU4VX8TdKna7ZjEO38nfgUcNC
    iviY-29_83fwj_Z1w>
X-ME-Received: <xmr:4BgaaEmYX6w3rNL-KlrRuqovMk8qsMZOl4kyLKPj35jE7-vIkDwbSxxu6MYtY4cfDzThVJbCViJqr3ISnS1bluQVCrgzmJImTdVG-N5K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4BgaaDzZtD0I3-XxO1y1iVI-0iKU62Z7PaD47pj2VJyPWECjezX5Dg>
    <xmx:4BgaaOQqwEiVx2EpUgClY8KZPrAdR6SgkSowMVmTUDwuW0xHzHbPGA>
    <xmx:4BgaaGa3cWMxJchBuOzgZTQygOrqXFCgfAiKjH1B0X7cbv2yMSLUgQ>
    <xmx:4BgaaPRL1nooGcmW7Wd6rhJz17KJv8xwfntBSYBwUXLDk6aJ3aQqZA>
    <xmx:4BgaaP_A4iBBTFyBkkWC2fjuiNw5L3ofnM18H_OyoSnSxRQu-bFm5_Nj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 10:12:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 40f164f7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 14:12:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 May 2025 16:12:41 +0200
Subject: [PATCH 08/10] contrib: remove "git-resurrect.sh"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-pks-contrib-spring-cleanup-v1-8-e6d5ddd79a72@pks.im>
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
In-Reply-To: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The "git-resurrect.sh" script can be used to find traces of a branch tip
in the reflog and resurrect that branch. Despite a couple of global
cleanups, the script hasn't seen any activity since it was introduced in
e1ff064e1bf (contrib git-resurrect: find traces of a branch name and
resurrect it, 2009-02-04).

Remove it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/git-resurrect.sh | 181 -----------------------------------------------
 1 file changed, 181 deletions(-)

diff --git a/contrib/git-resurrect.sh b/contrib/git-resurrect.sh
deleted file mode 100755
index d843df3afd0..00000000000
--- a/contrib/git-resurrect.sh
+++ /dev/null
@@ -1,181 +0,0 @@
-#!/bin/sh
-
-USAGE="[-a] [-r] [-m] [-t] [-n] [-b <newname>] <name>"
-LONG_USAGE="git-resurrect attempts to find traces of a branch tip
-called <name>, and tries to resurrect it.  Currently, the reflog is
-searched for checkout messages, and with -r also merge messages.  With
--m and -t, the history of all refs is scanned for Merge <name> into
-other/Merge <other> into <name> (respectively) commit subjects, which
-is rather slow but allows you to resurrect other people's topic
-branches."
-
-OPTIONS_KEEPDASHDASH=
-OPTIONS_STUCKLONG=
-OPTIONS_SPEC="\
-git resurrect $USAGE
---
-b,branch=            save branch as <newname> instead of <name>
-a,all                same as -l -r -m -t
-k,keep-going         full rev-list scan (instead of first match)
-l,reflog             scan reflog for checkouts (enabled by default)
-r,reflog-merges      scan for merges recorded in reflog
-m,merges             scan for merges into other branches (slow)
-t,merge-targets      scan for merges of other branches into <name>
-n,dry-run            don't recreate the branch"
-
-. git-sh-setup
-
-search_reflog () {
-	sed -ne 's~^\([^ ]*\) .*	checkout: moving from '"$1"' .*~\1~p' \
-		< "$GIT_DIR"/logs/HEAD
-}
-
-search_reflog_merges () {
-	git rev-parse $(
-		sed -ne 's~^[^ ]* \([^ ]*\) .*	merge '"$1"':.*~\1^2~p' \
-			< "$GIT_DIR"/logs/HEAD
-	)
-}
-
-oid_pattern=$(git hash-object --stdin </dev/null | sed -e 's/./[0-9a-f]/g')
-
-search_merges () {
-	git rev-list --all --grep="Merge branch '$1'" \
-		--pretty=tformat:"%P %s" |
-	sed -ne "/^$oid_pattern \($oid_pattern\) Merge .*/ {s//\1/p;$early_exit}"
-}
-
-search_merge_targets () {
-	git rev-list --all --grep="Merge branch '[^']*' into $branch\$" \
-		--pretty=tformat:"%H %s" --all |
-	sed -ne "/^\($oid_pattern\) Merge .*/ {s//\1/p;$early_exit} "
-}
-
-dry_run=
-early_exit=q
-scan_reflog=t
-scan_reflog_merges=
-scan_merges=
-scan_merge_targets=
-new_name=
-
-while test "$#" != 0; do
-	case "$1" in
-	    -b|--branch)
-		shift
-		new_name="$1"
-		;;
-	    -n|--dry-run)
-		dry_run=t
-		;;
-	    --no-dry-run)
-		dry_run=
-		;;
-	    -k|--keep-going)
-		early_exit=
-		;;
-	    --no-keep-going)
-		early_exit=q
-		;;
-	    -m|--merges)
-		scan_merges=t
-		;;
-	    --no-merges)
-		scan_merges=
-		;;
-	    -l|--reflog)
-		scan_reflog=t
-		;;
-	    --no-reflog)
-		scan_reflog=
-		;;
-	    -r|--reflog_merges)
-		scan_reflog_merges=t
-		;;
-	    --no-reflog_merges)
-		scan_reflog_merges=
-		;;
-	    -t|--merge-targets)
-		scan_merge_targets=t
-		;;
-	    --no-merge-targets)
-		scan_merge_targets=
-		;;
-	    -a|--all)
-		scan_reflog=t
-		scan_reflog_merges=t
-		scan_merges=t
-		scan_merge_targets=t
-		;;
-	    --)
-		shift
-		break
-		;;
-	    *)
-		usage
-		;;
-	esac
-	shift
-done
-
-test "$#" = 1 || usage
-
-all_strategies="$scan_reflog$scan_reflog_merges$scan_merges$scan_merge_targets"
-if test -z "$all_strategies"; then
-	die "must enable at least one of -lrmt"
-fi
-
-branch="$1"
-test -z "$new_name" && new_name="$branch"
-
-if test ! -z "$scan_reflog"; then
-	if test -r "$GIT_DIR"/logs/HEAD; then
-		candidates="$(search_reflog $branch)"
-	else
-		die 'reflog scanning requested, but' \
-			'$GIT_DIR/logs/HEAD not readable'
-	fi
-fi
-if test ! -z "$scan_reflog_merges"; then
-	if test -r "$GIT_DIR"/logs/HEAD; then
-		candidates="$candidates $(search_reflog_merges $branch)"
-	else
-		die 'reflog scanning requested, but' \
-			'$GIT_DIR/logs/HEAD not readable'
-	fi
-fi
-if test ! -z "$scan_merges"; then
-	candidates="$candidates $(search_merges $branch)"
-fi
-if test ! -z "$scan_merge_targets"; then
-	candidates="$candidates $(search_merge_targets $branch)"
-fi
-
-candidates="$(git rev-parse $candidates | sort -u)"
-
-if test -z "$candidates"; then
-	hint=
-	test "z$all_strategies" != "ztttt" \
-		&& hint=" (maybe try again with -a)"
-	die "no candidates for $branch found$hint"
-fi
-
-echo "** Candidates for $branch **"
-for cmt in $candidates; do
-	git --no-pager log --pretty=tformat:"%ct:%h [%cr] %s" --abbrev-commit -1 $cmt
-done \
-| sort -n | cut -d: -f2-
-
-newest="$(git rev-list -1 $candidates)"
-if test ! -z "$dry_run"; then
-	printf "** Most recent: "
-	git --no-pager log -1 --pretty=tformat:"%h %s" $newest
-elif ! git rev-parse --verify --quiet $new_name >/dev/null; then
-	printf "** Restoring $new_name to "
-	git --no-pager log -1 --pretty=tformat:"%h %s" $newest
-	git branch $new_name $newest
-else
-	printf "Most recent: "
-	git --no-pager log -1 --pretty=tformat:"%h %s" $newest
-	echo "** $new_name already exists, doing nothing"
-fi

-- 
2.49.0.1045.g170613ef41.dirty

