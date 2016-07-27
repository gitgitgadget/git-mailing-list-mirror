Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F1AA203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 18:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758034AbcG0Sz2 (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 14:55:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:50039 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756884AbcG0Sz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 14:55:26 -0400
Received: (qmail 2917 invoked by uid 102); 27 Jul 2016 18:55:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 14:55:26 -0400
Received: (qmail 19634 invoked by uid 107); 27 Jul 2016 18:55:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 14:55:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2016 14:55:23 -0400
Date:	Wed, 27 Jul 2016 14:55:23 -0400
From:	Jeff King <peff@peff.net>
To:	Phil Pennock <phil@pennock-tech.com>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] t4205: indent here documents
Message-ID: <20160727185523.GB6626@sigill.intra.peff.net>
References: <20160727185256.GA11657@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160727185256.GA11657@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Our usual style in the test scripts is to indent here
documents with tabs, and use "<<-" to strip the tabs. The
result is easier to read.

This old test script did not do so in its inception, and
further tests added onto it followed the local style. Let's
bring it in line with our usual style.

Some of the tests actually care quite a bit about
whitespace, but none of them do so at the beginning of the
line (because they things like qz_to_tab_space to avoid
depending on the literal whitespace), so we can do a fairly
mechanical conversion.

Most of the here-docs also use interpolation, so they have
been left as "<<-EOF". In a few cases, though, where
interpolation was not in use, I've converted them to
"<<-\EOF" to match our usual "don't interpolate unless you
need to" style.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4205-log-pretty-formats.sh | 392 +++++++++++++++++++++---------------------
 1 file changed, 196 insertions(+), 196 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index d6518fa..f5435fd 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -145,199 +145,199 @@ test_expect_success 'setup more commits' '
 
 test_expect_success 'left alignment formatting' '
 	git log --pretty="tformat:%<(40)%s" >actual &&
-	qz_to_tab_space <<EOF >expected &&
-message two                            Z
-message one                            Z
-add bar                                Z
-$(commit_msg)                    Z
-EOF
+	qz_to_tab_space <<-EOF >expected &&
+	message two                            Z
+	message one                            Z
+	add bar                                Z
+	$(commit_msg)                    Z
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'left alignment formatting. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(40)%s" >actual &&
-	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
-message two                            Z
-message one                            Z
-add bar                                Z
-$(commit_msg)                    Z
-EOF
+	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
+	message two                            Z
+	message one                            Z
+	add bar                                Z
+	$(commit_msg)                    Z
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'left alignment formatting at the nth column' '
 	git log --pretty="tformat:%h %<|(40)%s" >actual &&
-	qz_to_tab_space <<EOF >expected &&
-$head1 message two                    Z
-$head2 message one                    Z
-$head3 add bar                        Z
-$head4 $(commit_msg)            Z
-EOF
+	qz_to_tab_space <<-EOF >expected &&
+	$head1 message two                    Z
+	$head2 message one                    Z
+	$head3 add bar                        Z
+	$head4 $(commit_msg)            Z
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'left alignment formatting at the nth column' '
 	COLUMNS=50 git log --pretty="tformat:%h %<|(-10)%s" >actual &&
-	qz_to_tab_space <<EOF >expected &&
-$head1 message two                    Z
-$head2 message one                    Z
-$head3 add bar                        Z
-$head4 $(commit_msg)            Z
-EOF
+	qz_to_tab_space <<-EOF >expected &&
+	$head1 message two                    Z
+	$head2 message one                    Z
+	$head3 add bar                        Z
+	$head4 $(commit_msg)            Z
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'left alignment formatting at the nth column. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%h %<|(40)%s" >actual &&
-	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
-$head1 message two                    Z
-$head2 message one                    Z
-$head3 add bar                        Z
-$head4 $(commit_msg)            Z
-EOF
+	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
+	$head1 message two                    Z
+	$head2 message one                    Z
+	$head3 add bar                        Z
+	$head4 $(commit_msg)            Z
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'left alignment formatting with no padding' '
 	git log --pretty="tformat:%<(1)%s" >actual &&
-	cat <<EOF >expected &&
-message two
-message one
-add bar
-$(commit_msg)
-EOF
+	cat <<-EOF >expected &&
+	message two
+	message one
+	add bar
+	$(commit_msg)
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'left alignment formatting with no padding. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(1)%s" >actual &&
-	cat <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
-message two
-message one
-add bar
-$(commit_msg)
-EOF
+	cat <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
+	message two
+	message one
+	add bar
+	$(commit_msg)
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'left alignment formatting with trunc' '
 	git log --pretty="tformat:%<(10,trunc)%s" >actual &&
-	qz_to_tab_space <<EOF >expected &&
-message ..
-message ..
-add bar  Z
-initial...
-EOF
+	qz_to_tab_space <<-\EOF >expected &&
+	message ..
+	message ..
+	add bar  Z
+	initial...
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'left alignment formatting with trunc. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(10,trunc)%s" >actual &&
-	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
-message ..
-message ..
-add bar  Z
-initial...
-EOF
+	qz_to_tab_space <<-\EOF | iconv -f utf-8 -t $test_encoding >expected &&
+	message ..
+	message ..
+	add bar  Z
+	initial...
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'left alignment formatting with ltrunc' '
 	git log --pretty="tformat:%<(10,ltrunc)%s" >actual &&
-	qz_to_tab_space <<EOF >expected &&
-..sage two
-..sage one
-add bar  Z
-..${sample_utf8_part}lich
-EOF
+	qz_to_tab_space <<-EOF >expected &&
+	..sage two
+	..sage one
+	add bar  Z
+	..${sample_utf8_part}lich
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'left alignment formatting with ltrunc. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(10,ltrunc)%s" >actual &&
-	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
-..sage two
-..sage one
-add bar  Z
-..${sample_utf8_part}lich
-EOF
+	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
+	..sage two
+	..sage one
+	add bar  Z
+	..${sample_utf8_part}lich
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'left alignment formatting with mtrunc' '
 	git log --pretty="tformat:%<(10,mtrunc)%s" >actual &&
-	qz_to_tab_space <<EOF >expected &&
-mess.. two
-mess.. one
-add bar  Z
-init..lich
-EOF
+	qz_to_tab_space <<-\EOF >expected &&
+	mess.. two
+	mess.. one
+	add bar  Z
+	init..lich
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'left alignment formatting with mtrunc. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(10,mtrunc)%s" >actual &&
-	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
-mess.. two
-mess.. one
-add bar  Z
-init..lich
-EOF
+	qz_to_tab_space <<-\EOF | iconv -f utf-8 -t $test_encoding >expected &&
+	mess.. two
+	mess.. one
+	add bar  Z
+	init..lich
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'right alignment formatting' '
 	git log --pretty="tformat:%>(40)%s" >actual &&
-	qz_to_tab_space <<EOF >expected &&
-Z                            message two
-Z                            message one
-Z                                add bar
-Z                    $(commit_msg)
-EOF
+	qz_to_tab_space <<-EOF >expected &&
+	Z                            message two
+	Z                            message one
+	Z                                add bar
+	Z                    $(commit_msg)
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'right alignment formatting. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%>(40)%s" >actual &&
-	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
-Z                            message two
-Z                            message one
-Z                                add bar
-Z                    $(commit_msg)
-EOF
+	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
+	Z                            message two
+	Z                            message one
+	Z                                add bar
+	Z                    $(commit_msg)
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'right alignment formatting at the nth column' '
 	git log --pretty="tformat:%h %>|(40)%s" >actual &&
-	qz_to_tab_space <<EOF >expected &&
-$head1                      message two
-$head2                      message one
-$head3                          add bar
-$head4              $(commit_msg)
-EOF
+	qz_to_tab_space <<-EOF >expected &&
+	$head1                      message two
+	$head2                      message one
+	$head3                          add bar
+	$head4              $(commit_msg)
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'right alignment formatting at the nth column' '
 	COLUMNS=50 git log --pretty="tformat:%h %>|(-10)%s" >actual &&
-	qz_to_tab_space <<EOF >expected &&
-$head1                      message two
-$head2                      message one
-$head3                          add bar
-$head4              $(commit_msg)
-EOF
+	qz_to_tab_space <<-EOF >expected &&
+	$head1                      message two
+	$head2                      message one
+	$head3                          add bar
+	$head4              $(commit_msg)
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'right alignment formatting at the nth column. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%h %>|(40)%s" >actual &&
-	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
-$head1                      message two
-$head2                      message one
-$head3                          add bar
-$head4              $(commit_msg)
-EOF
+	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
+	$head1                      message two
+	$head2                      message one
+	$head3                          add bar
+	$head4              $(commit_msg)
+	EOF
 	test_cmp expected actual
 '
 
@@ -345,110 +345,110 @@ EOF
 # as in previous test.
 test_expect_success 'right alignment formatting at the nth column with --graph. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --graph --pretty="tformat:%h %>|(40)%s" >actual &&
-	iconv -f utf-8 -t $test_encoding >expected <<EOF&&
-* $head1                    message two
-* $head2                    message one
-* $head3                        add bar
-* $head4            $(commit_msg)
-EOF
+	iconv -f utf-8 -t $test_encoding >expected <<-EOF &&
+	* $head1                    message two
+	* $head2                    message one
+	* $head3                        add bar
+	* $head4            $(commit_msg)
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'right alignment formatting with no padding' '
 	git log --pretty="tformat:%>(1)%s" >actual &&
-	cat <<EOF >expected &&
-message two
-message one
-add bar
-$(commit_msg)
-EOF
+	cat <<-EOF >expected &&
+	message two
+	message one
+	add bar
+	$(commit_msg)
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'right alignment formatting with no padding and with --graph' '
 	git log --graph --pretty="tformat:%>(1)%s" >actual &&
-	cat <<EOF >expected &&
-* message two
-* message one
-* add bar
-* $(commit_msg)
-EOF
+	cat <<-EOF >expected &&
+	* message two
+	* message one
+	* add bar
+	* $(commit_msg)
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'right alignment formatting with no padding. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%>(1)%s" >actual &&
-	cat <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
-message two
-message one
-add bar
-$(commit_msg)
-EOF
+	cat <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
+	message two
+	message one
+	add bar
+	$(commit_msg)
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'center alignment formatting' '
 	git log --pretty="tformat:%><(40)%s" >actual &&
-	qz_to_tab_space <<EOF >expected &&
-Z             message two              Z
-Z             message one              Z
-Z               add bar                Z
-Z         $(commit_msg)          Z
-EOF
+	qz_to_tab_space <<-EOF >expected &&
+	Z             message two              Z
+	Z             message one              Z
+	Z               add bar                Z
+	Z         $(commit_msg)          Z
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'center alignment formatting. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%><(40)%s" >actual &&
-	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
-Z             message two              Z
-Z             message one              Z
-Z               add bar                Z
-Z         $(commit_msg)          Z
-EOF
+	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
+	Z             message two              Z
+	Z             message one              Z
+	Z               add bar                Z
+	Z         $(commit_msg)          Z
+	EOF
 	test_cmp expected actual
 '
 test_expect_success 'center alignment formatting at the nth column' '
 	git log --pretty="tformat:%h %><|(40)%s" >actual &&
-	qz_to_tab_space <<EOF >expected &&
-$head1           message two          Z
-$head2           message one          Z
-$head3             add bar            Z
-$head4       $(commit_msg)      Z
-EOF
+	qz_to_tab_space <<-EOF >expected &&
+	$head1           message two          Z
+	$head2           message one          Z
+	$head3             add bar            Z
+	$head4       $(commit_msg)      Z
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'center alignment formatting at the nth column' '
 	COLUMNS=70 git log --pretty="tformat:%h %><|(-30)%s" >actual &&
-	qz_to_tab_space <<EOF >expected &&
-$head1           message two          Z
-$head2           message one          Z
-$head3             add bar            Z
-$head4       $(commit_msg)      Z
-EOF
+	qz_to_tab_space <<-EOF >expected &&
+	$head1           message two          Z
+	$head2           message one          Z
+	$head3             add bar            Z
+	$head4       $(commit_msg)      Z
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'center alignment formatting at the nth column. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%h %><|(40)%s" >actual &&
-	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
-$head1           message two          Z
-$head2           message one          Z
-$head3             add bar            Z
-$head4       $(commit_msg)      Z
-EOF
+	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
+	$head1           message two          Z
+	$head2           message one          Z
+	$head3             add bar            Z
+	$head4       $(commit_msg)      Z
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'center alignment formatting with no padding' '
 	git log --pretty="tformat:%><(1)%s" >actual &&
-	cat <<EOF >expected &&
-message two
-message one
-add bar
-$(commit_msg)
-EOF
+	cat <<-EOF >expected &&
+	message two
+	message one
+	add bar
+	$(commit_msg)
+	EOF
 	test_cmp expected actual
 '
 
@@ -457,34 +457,34 @@ EOF
 old_head1=$(git rev-parse --verify HEAD~0)
 test_expect_success 'center alignment formatting with no padding. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%><(1)%s" >actual &&
-	cat <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
-message two
-message one
-add bar
-$(commit_msg)
-EOF
+	cat <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
+	message two
+	message one
+	add bar
+	$(commit_msg)
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'left/right alignment formatting with stealing' '
 	git commit --amend -m short --author "long long long <long@me.com>" &&
 	git log --pretty="tformat:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual &&
-	cat <<EOF >expected &&
-short long  long long
-message ..   A U Thor
-add bar      A U Thor
-initial...   A U Thor
-EOF
+	cat <<-\EOF >expected &&
+	short long  long long
+	message ..   A U Thor
+	add bar      A U Thor
+	initial...   A U Thor
+	EOF
 	test_cmp expected actual
 '
 test_expect_success 'left/right alignment formatting with stealing. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual &&
-	cat <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
-short long  long long
-message ..   A U Thor
-add bar      A U Thor
-initial...   A U Thor
-EOF
+	cat <<-\EOF | iconv -f utf-8 -t $test_encoding >expected &&
+	short long  long long
+	message ..   A U Thor
+	add bar      A U Thor
+	initial...   A U Thor
+	EOF
 	test_cmp expected actual
 '
 
@@ -515,22 +515,22 @@ test_expect_success 'log decoration properly follows tag chain' '
 	git tag -d tag1 &&
 	git commit --amend -m shorter &&
 	git log --no-walk --tags --pretty="%H %d" --decorate=full >actual &&
-	cat <<EOF >expected &&
-$head1  (tag: refs/tags/tag2)
-$head2  (tag: refs/tags/message-one)
-$old_head1  (tag: refs/tags/message-two)
-EOF
+	cat <<-EOF >expected &&
+	$head1  (tag: refs/tags/tag2)
+	$head2  (tag: refs/tags/message-one)
+	$old_head1  (tag: refs/tags/message-two)
+	EOF
 	sort actual >actual1 &&
 	test_cmp expected actual1
 '
 
 test_expect_success 'clean log decoration' '
 	git log --no-walk --tags --pretty="%H %D" --decorate=full >actual &&
-	cat >expected <<EOF &&
-$head1 tag: refs/tags/tag2
-$head2 tag: refs/tags/message-one
-$old_head1 tag: refs/tags/message-two
-EOF
+	cat >expected <<-EOF &&
+	$head1 tag: refs/tags/tag2
+	$head2 tag: refs/tags/message-one
+	$old_head1 tag: refs/tags/message-two
+	EOF
 	sort actual >actual1 &&
 	test_cmp expected actual1
 '
-- 
2.9.2.607.g98dce7b
