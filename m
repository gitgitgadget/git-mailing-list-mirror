Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFC4E1F576
	for <e@80x24.org>; Tue,  6 Mar 2018 10:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932646AbeCFKSJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 05:18:09 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:65429 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeCFKSB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 05:18:01 -0500
Received: from lindisfarne.localdomain ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id t9fNelwjTlYtpt9fSexEq3; Tue, 06 Mar 2018 10:17:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1520331478;
        bh=G/C1O7xgUbKsMn+Uddh8xaVjJ8VXFJLEQjg+ZB2+41c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=Yp2cDYUtjo0Q1EjP1n6YpTeLcd+qqjLNXZU1zS4wEDSYT+IIieC4o4oZYmUFHo5Kf
         OQq/fCm+aPyhQmXZKK8DKxUZRnDBpgh3nny8jX09AXck+cor1gK1ykN+90XYFKVq4t
         xdSjAb+RJiMEkXEZkj97h0FHPqS7MNX8XnUI1EWQ=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=JZeSU3CV c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=evINK-nbAAAA:8 a=5rxgeBVgAAAA:8
 a=vZxbLtyPAAAA:8 a=GXyMKu8wU2J1TnQW_HYA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
 a=On91qT0BcnyzFpC6:21 a=pr7JLpGipAkUpjN-:21 a=RfR_gqz1fSpA9VikTjo0:22
 a=PwKx63F5tFurRwaNxrlG:22 a=YIznc7gRMHvxYRuyG5Sm:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gustavo Leite <gustavoleite.ti@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 0/3] add -p: select individual hunk lines
Date:   Tue,  6 Mar 2018 10:17:47 +0000
Message-Id: <20180306101750.18794-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180219113619.26566-1-phillip.wood@talktalk.net>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfEEM4u91oe4oCQsKLPKn2yi7FKDbyr16fFfxFkULFgZ+0jkbm13jK6bGvqIIVi0K0yiz+6llubtqNL5yprs2BIDJ73UWtMcdaqA+th4IorcsTXCB9L4q
 z83u3U6qGCues15smgpAANYDA9na3XsXECXkoF/dSigsYKgsmj8J/4WdZ1qrDb/3TeZmHesOgXc9gZekGXFTW6xK+hTMq2JlSABwGnETZE//RJGT8T5gtOON
 TwsW9fD8DdoWlgoDkq8Te/OaWuS4YeoOQj14xR7/JL+xjyPXJ8TyJx4D5ndGlMoE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

I've added some documentation to git-add.txt for the new selection
mode and cleaned up some style issues, otherwise these are unchanged
since v1.  These patches build on top of the recount fixes in [1]. The
commit message for the first patch describes the motivation:

"When I end up editing hunks it is almost always because I want to
stage a subset of the lines in the hunk. Doing this by editing the
hunk is inconvenient and error prone (especially so if the patch is
going to be reversed before being applied). Instead offer an option
for add -p to stage individual lines. When the user presses 'l' the
hunk is redrawn with labels by the insertions and deletions and they
are prompted to enter a list of the lines they wish to stage. Ranges
of lines may be specified using 'a-b' where either 'a' or 'b' may be
omitted to mean all lines from 'a' to the end of the hunk or all lines
from 1 upto and including 'b'."

[1] https://public-inbox.org/git/xmqqbmg29x1n.fsf@gitster-ct.c.googlers.com/T/#m01d0f1af90f32b698e583b56f8e53b986bcec7c6

Interdiff from v1:

 Documentation/git-add.txt  |  9 +++++++++
 git-add--interactive.perl  | 19 ++++++++++++++-----
 t/t3701-add-interactive.sh | 12 +++++++-----
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index d50fa339dc..d52acfc722 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -332,10 +332,19 @@ patch::
        J - leave this hunk undecided, see next hunk
        k - leave this hunk undecided, see previous undecided hunk
        K - leave this hunk undecided, see previous hunk
+       l - select hunk lines to use
        s - split the current hunk into smaller hunks
        e - manually edit the current hunk
        ? - print help
 +
+If you press "l" then the hunk will be reprinted with each insertion
+or deletion labelled with a number and you will be prompted to enter
+which lines you wish to select. Individual line numbers should be
+separated by a space or comma (these can be omitted if there are fewer
+than ten labelled lines), to specify a range of lines use a dash
+between them. To invert the selection prefix it with "\^" so "^3-5,8"
+will select everything except lines 3, 4, 5 and 8.
++
 After deciding the fate for all hunks, if there is any hunk
 that was chosen, the index is updated with the selected hunks.
 +
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index aa474c5149..9a6bcd5085 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1018,8 +1018,11 @@ sub label_hunk_lines {
 	my $hunk = shift;
 	my $i = 0;
 	my $labels = [ map { /^[-+]/ ? ++$i : 0 } @{$hunk->{TEXT}} ];
-	$i > 1 and @{$hunk}{qw(LABELS MAX_LABEL)} = ($labels, $i);
-	return $i > 1;
+	if ($i > 1) {
+		@{$hunk}{qw(LABELS MAX_LABEL)} = ($labels, $i);
+		return 1;
+	}
+	return 0;
 }
 
 sub select_hunk_lines {
@@ -1064,7 +1067,9 @@ sub select_hunk_lines {
 	# If this hunk has previously been edited add the offset delta
 	# of the old hunk to get the real delta from the original
 	# hunk.
-	$hunk->{OFS_DELTA} and $newhunk->{OFS_DELTA} += $hunk->{OFS_DELTA};
+	if ($hunk->{OFS_DELTA}) {
+		$newhunk->{OFS_DELTA} += $hunk->{OFS_DELTA};
+	}
 	return $newhunk;
 }
 
@@ -1135,7 +1140,9 @@ sub parse_hunk_selection {
 			my $hi = $2 eq '' ? $max_label : $2;
 			check_hunk_label($hunk, $lo) or return undef;
 			check_hunk_label($hunk, $hi) or return undef;
-			$hi < $lo and ($lo, $hi) = ($hi, $lo);
+			if ($hi < $lo) {
+				($lo, $hi) = ($hi, $lo);
+			}
 			@selected[$lo..$hi] = (1) x (1 + $hi - $lo);
 		} elsif (/^([0-9]+)$/) {
 			check_hunk_label($hunk, $1) or return undef;
@@ -1145,7 +1152,9 @@ sub parse_hunk_selection {
 			return undef;
 		}
 	}
-	$invert and @selected = map { !$_ } @selected;
+	if ($invert) {
+		@selected = map { !$_ } @selected;
+	}
 	return \@selected;
 }
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 7bea4a2341..d3bce154da 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -363,6 +363,7 @@ test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
 test_expect_success 'setup expected diff' '
 	cat >expected <<-\EOF
 	diff --git a/test b/test
+	index 0889435..341cc6b 100644
 	--- a/test
 	+++ b/test
 	@@ -1,6 +1,9 @@
@@ -385,13 +386,14 @@ test_expect_success 'can stage individual lines of patch' '
 	printf "%s\n" l "-2 4" |
 	EDITOR=: git add -p 2>error &&
 	test_must_be_empty error &&
-	git diff --cached HEAD | sed /^index/d >actual &&
-	test_cmp expected actual
+	git diff --cached HEAD >actual &&
+	diff_cmp expected actual
 '
 
 test_expect_success 'setup expected diff' '
 	cat >expected <<-\EOF
 	diff --git a/test b/test
+	index 0889435..cc6163b 100644
 	--- a/test
 	+++ b/test
 	@@ -1,6 +1,8 @@
@@ -411,8 +413,8 @@ test_expect_success 'can reset individual lines of patch' '
 	printf "%s\n" l ^13 |
 	EDITOR=: git reset -p 2>error &&
 	test_must_be_empty error &&
-	git diff --cached HEAD | sed /^index/d >actual &&
-	test_cmp expected actual
+	git diff --cached HEAD >actual &&
+	diff_cmp expected actual
 '
 
 test_expect_success 'patch mode ignores unmerged entries' '
@@ -635,7 +637,7 @@ test_expect_success 'add -p selecting lines works with pathological context line
 	git reset &&
 	printf "%s\n" l 2 y |
 	GIT_EDITOR=./editor git add -p &&
-	git cat-file blob :a > actual &&
+	git cat-file blob :a >actual &&
 	test_cmp expected-2 actual
 '
 

Phillip Wood (3):
  add -p: select individual hunk lines
  add -p: allow line selection to be inverted
  add -p: optimize line selection for short hunks

 Documentation/git-add.txt  |   9 +++
 git-add--interactive.perl  | 188 +++++++++++++++++++++++++++++++++++++++++++++
 t/t3701-add-interactive.sh |  65 ++++++++++++++++
 3 files changed, 262 insertions(+)

-- 
2.16.2

