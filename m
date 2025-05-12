Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1D125D8E9
	for <git@vger.kernel.org>; Mon, 12 May 2025 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041614; cv=none; b=PXbj6jY56dgbuM47l2YX5oRB2Ot76gZoqmbCjwxCY+spDSavuhVG5OBzA5Dce6hVCygCw0nf2vqLU4zghBcFIjCN6nu4Ne4aJW8XSU1ZIzntLZWhUv8OTuj4EUBCVCy5lwNfA68456oZsfwcDdZHyAvvjQR+AvUw/ecNckc0GHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041614; c=relaxed/simple;
	bh=TXFzpnHEaae4Y9YvAEl5bNEYSCZ5YydUo8/2Ktw/fP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CKeWhLSmzlKXVnO5/4wYFP64GGpKwlo26gC1xo9FSFHOKxUvTaQvoSmUR8T+P6EYx7sNQ53gPEY7M672LlDmmVqUOb0jgTOAo2tSm4KFaZamLafeO8c+PTv30/iUi/7xu/BTM6x2yawnE8q6YdEJTi7UR02yf8exLrd2PumBSX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Am/6uc2y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z2Pu/2H9; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Am/6uc2y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z2Pu/2H9"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 77C7B2540115;
	Mon, 12 May 2025 05:20:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 12 May 2025 05:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747041611;
	 x=1747128011; bh=MvzPy7VbtO2JjudAVnrea7LieCeB8+i76ybtyuQq/E4=; b=
	Am/6uc2y0adxspes3hCag37VaOLZWp3fqkQHK1P5JDJgcchG+LBjopcJDAOr02PY
	Wp3QYpFanzjlAH1zUwp53I0J4kfiAZ1rUG7whsXn5XHftbXYyyXXsnt9GUr/hq0v
	EW0D15BtTqeEs8VhIlpdx+MSCUmIqZc9d9VysN7CZ3mr/T2NIBGJgrSxGG7IrJJr
	C+4ptcXTXTEbah2s7zPFelB6ewe1M0iYKJWxdu6/qo4rC1ALTa44u1zRmTB6AHUW
	P33sIHX+3Vi8Aba3TMpgpXOSXbHZc0SuMNfyU6rzhQ1fB4BYBl9XEeDY7fSGc9EH
	Sl3FXACnM6HpslChWbGS+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747041611; x=
	1747128011; bh=MvzPy7VbtO2JjudAVnrea7LieCeB8+i76ybtyuQq/E4=; b=Z
	2Pu/2H9DyEpUm+Z+UW7XwvTtWNe84uUIAJAChiNzR8Ce8VBO9Yo+Ee7BoslYONA7
	r5uFJeA6Fjs3FDUZS1PWHnjxeta+vrwT9hWgtlRGq+AgPsJPVCITBr+JE42bxvcs
	JLa223NSKNUs1ePCND+czAmAHf5jStTNKJjm4NJk/U4gPTrUpXNVbXZ/4YvNv/D8
	diddxZ+FvqG0RjFGqBLUysTkg3QT0RmawxTbcHD8JpwVDsbLhU59npfPjYeoNjgT
	ouroFG8qwBxajXzoaE+mMwkLLx79sS03wDpY3i/qO2detsHpJDWJXvNyiENvWeaj
	F+9KRrrfyNCv9fPV5k9fg==
X-ME-Sender: <xms:S70haA3Nhh_2s_WIDaXv1Zen5kcx4EqGrax5AnQYOj4P3AEE5F4sOQ>
    <xme:S70haLEYkR5EH9BB9jD3Ae-hQt3PxbqoO_R32wv2SxKgR4HIGszh-dctshbB_7WRB
    qE6kcQdNWuYFc1CSA>
X-ME-Received: <xmr:S70haI7hgph_VDB-0WjoEbNfgmEkPawVzMpXaNgVbEaKh1q3NGc_Kzd9S5d7OWajxkJXOpfDgzE_QTMiwd_N19b49-_-1Y-kR650fY719jo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddtkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeeuvddujeelgfevjeelueejvefgueeftdfhkedu
    hfduueevhfegvddtvddugefftdenucffohhmrghinhepshhtrggtkhhovhgvrhhflhhofi
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepthhmiiesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehmrghtthhhihgv
    uhdqmhhohidrfhhrpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtoh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:S70haJ0JK97DHukfNxizk_sfS66zsaB1K3_cao0y8mZvgFKTW_a63A>
    <xmx:S70haDHq9YEJ67EVc6w_-I03iDo1fHoAii9Xx6iP5YsIiQ4z3zVBoQ>
    <xmx:S70haC9ZLyox8Mgu1bUqebeloal9drvRhyS17hcPbERkxB1svWcD7Q>
    <xmx:S70haInEOuxjW9WzIAbHxbVbDjBNM_Zm0JJYYq5q4cZV9aBgfZkScg>
    <xmx:S70haEG_5mNzXeDuvhOJy67Yd9WFn3ISs5YiAcT7E8WVtkXnbtZLCH4f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 05:20:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3a4e94f6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 12 May 2025 09:20:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 May 2025 11:19:58 +0200
Subject: [PATCH v3 08/11] contrib: remove "git-resurrect.sh"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250512-pks-contrib-spring-cleanup-v3-8-32e151b0bfb0@pks.im>
References: <20250512-pks-contrib-spring-cleanup-v3-0-32e151b0bfb0@pks.im>
In-Reply-To: <20250512-pks-contrib-spring-cleanup-v3-0-32e151b0bfb0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Matthieu Moy <git@matthieu-moy.fr>, Eric Sunshine <sunshine@sunshineco.com>, 
 Todd Zullinger <tmz@pobox.com>, Elijah Newren <newren@gmail.com>
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
2.49.0.1101.gccaa498523.dirty

