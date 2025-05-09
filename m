Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020B627E1A7
	for <git@vger.kernel.org>; Fri,  9 May 2025 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746782241; cv=none; b=qP3lpELfBEfAODFRJJbUH7TcoyXh/Sp+Rm00MNsD/f/CFhoBGs4oLJ1+9wy2oBXmNjR2Xli2M3WPRGGJ2OI6L8tKtnx7w0urHYjcabk62q397eApDz9XSMMDFO9n5tha7PmlY/dK+aT0JeIklL28iXL2/0RstDqXx1h3Jz1U1RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746782241; c=relaxed/simple;
	bh=/7c3G8u6YXNFusv8M91lQYqKBj6/Ug21I7o3qpEzHp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JniB12doTCbUoMItkaxaEtWrGUmTVqxvKNvzGR4JJyEoe8UpHovbGnz4kfzmL5+Jk1hgcRxzyqYSwh3cnvmrGuLddliLc/zKHCl8OXpoo3gHWX1rM6FbUS7oS7qOQyTYRORCuYO0Ol6qrk/gutKZce2d1ouTBYBYP6DpjusYues=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HU3Lf12e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=toK3loeG; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HU3Lf12e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="toK3loeG"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 4037A13801C4;
	Fri,  9 May 2025 05:17:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 09 May 2025 05:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746782238;
	 x=1746868638; bh=wFlt7hNx4Wx+beE1MTAc5Z3v0LE7J9nUFKSrnL2mCvc=; b=
	HU3Lf12elR+dA/k5tWidSPo1PLOtoKaVix/1kjiNKc7FwpRMteo++NCMWk2Eeyyb
	iMK4tqIEAkLxmgyq9WOpYZ9slG0tMjKLWQUFeFZq+iwsK0hw/084ZMgN6zsdGTI/
	16IXmj3CAL1YVGRVxp7N/mObZLs5JmWGJgN8lvcbhMSS3XVJx2E/jXid4Z4E2+yM
	bLoce15Yk1U6jHojOXdf7SIY3rAKPaa5PnIiyJCwlfy+dJSS83FVlZId+OQ0tqJZ
	V3jmgvM6WOGlylkqGPZz4cyjoylTIh/1XD5i85zNik9QNBVRBlp71RGqt8/+iyHW
	ozP05ak9LEoc3Qu/LnqgLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746782238; x=
	1746868638; bh=wFlt7hNx4Wx+beE1MTAc5Z3v0LE7J9nUFKSrnL2mCvc=; b=t
	oK3loeGTpkgGGRL3RzC1bZxELA3xKjPJjwqKblAliaCUhU+kPnTGVruQ9DtRP8Z2
	vNO7LQzYnN3GZxrmdLeWeOBve7R7O0WR3Dp/OgMZCwmH1PhBK1DLRrNRozWMB3Kb
	7ReoflhJBq4viGWF+jAuFWfzqnmSiZC03Pd3A3MiMf2/J5uHUsffUhpqT64QUqUv
	shcwoxPGeUwwsjlQGcvZnGWtuUViluZHmauoz8+lMSZWxbUBbx2z0BRDl9VQ2NIr
	OKRi38YfLAaDPTkO+m8aITl1n7Sf4O2XV16fcyei7QSiNOWzL6Q3UIhEWmIf9/1w
	OkJOOcA78BJe8PhnuSGPg==
X-ME-Sender: <xms:HsgdaF6mj6eBmz5V1xWgIbjazWaNNOrqy4cWj8CSE8BfTn4Tg-QlZQ>
    <xme:HsgdaC5mQJJ3xxsuLoy5bGcAeCb1NKjHYS2JgOAYzAyjnLGYUzGNbqnS82YsAfE2k
    ThIaaQGqv4rcsVoKA>
X-ME-Received: <xmr:HsgdaMctAS-mI6kKAPtK2WoQZeYvAdPGzDhWLVcnnOYz8GrmeJvQNx3Z_tVcrJEoKvR4xEbGPfew5Gkk-_cCrkfL6ijcJ3KXgoLeYJW_hw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeeuvddujeelgfevjeelueejvefgueeftdfhkedu
    hfduueevhfegvddtvddugefftdenucffohhmrghinhepshhtrggtkhhovhgvrhhflhhofi
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepghhithesmhgrthhthhhivghuqdhmohihrdhfrhdprhgtphht
    thhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:HsgdaOKz-BzWfnVgbO532yK6PZ72DC4GUUwP3yeO0-R44RRYMELn7g>
    <xmx:HsgdaJJnHdSHr8kYwslXS9FI5Ld7g7HWSlsdgFX9h2qNLDciwVd9SA>
    <xmx:HsgdaHzhEFNRy1xhaGC_f4xJk2zKwgqqqyScVK2f20Qrq5_20W1ScA>
    <xmx:HsgdaFL7smHIowz26RV4s_D-vMORvfnJ3-VW-77hRjrT41EW8B0aVg>
    <xmx:HsgdaBYkk5MviZKIC8DbLti86YyAKZmsqh409PPaT75LfBhrlXGCCto0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 05:17:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 23c13ab3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 09:17:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 May 2025 11:17:08 +0200
Subject: [PATCH v2 08/11] contrib: remove "git-resurrect.sh"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-pks-contrib-spring-cleanup-v2-8-14e20d95ec68@pks.im>
References: <20250509-pks-contrib-spring-cleanup-v2-0-14e20d95ec68@pks.im>
In-Reply-To: <20250509-pks-contrib-spring-cleanup-v2-0-14e20d95ec68@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Matthieu Moy <git@matthieu-moy.fr>, Eric Sunshine <sunshine@sunshineco.com>, 
 Todd Zullinger <tmz@pobox.com>
X-Mailer: b4 0.14.2

The "git-resurrect.sh" script can be used to find traces of a branch tip
in the reflog and resurrect that branch. Despite a couple of global
cleanups, the script hasn't seen any activity since it was introduced in
e1ff064e1bf (contrib git-resurrect: find traces of a branch name and
resurrect it, 2009-02-04).

Furthermore, the tool does not work with the "reftable" backend at all
as it directly reads ".git/logs/HEAD". As reflogs are stored as part of
the individual tables though that file wouldn't exist in a "reftable"-
enabled repository.

Last but not least, the tool doesn't even work unless it is explicitly
invoked via `git resurrect` as it sources "git-sh-setup". As none of our
build systems know to install this script, users thus have to go out of
their way to really make it work, which is highly unlikely.

Another source that indicates that this tool can be removed is a
question for how to restore deleted branches on StackOverflow [1]. The
top-voted answer uses git-reflog(1) directly and has received more than
3000 votes to date. While "git-resurrect.sh" is also mentioned, it only
got 16 upvotes, and comments mention the above caveat that users have to
do some manual setup to make it work.

It's thus rather clear that the tool doesn't have a lot or even any
users. Remove it.

[1]: https://stackoverflow.com/questions/3640764/can-i-recover-a-branch-after-its-deletion-in-git

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
2.49.0.1077.gc0e912fd4c.dirty

