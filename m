Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA02320285
	for <e@80x24.org>; Tue, 29 Aug 2017 08:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbdH2IVG (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 04:21:06 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:51553 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751236AbdH2IU4 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Aug 2017 04:20:56 -0400
X-AuditID: 12074411-f95ff70000007f0a-b7-59a523e734a1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 9F.C9.32522.7E325A95; Tue, 29 Aug 2017 04:20:55 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC836.dip0.t-ipconnect.de [87.188.200.54])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7T8KcS1002808
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 29 Aug 2017 04:20:54 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/10] t1404: demonstrate two problems with reference transactions
Date:   Tue, 29 Aug 2017 10:20:31 +0200
Message-Id: <caaa44126f18869158872e5473e53478db780ba9.1503993268.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1503993268.git.mhagger@alum.mit.edu>
References: <cover.1503993268.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqPtceWmkwd/rJhZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHs969zB6
        XLyk7PF5k1wAWxSXTUpqTmZZapG+XQJXxu3HCgU7lSreTYprYDwp3cXIySEhYCKx7eE5li5G
        Lg4hgR1MErNPXGaDcE4ySbSsvs0MUsUmoCuxqKeZCcQWEVCTmNh2CKyDWeApk8TOk3dZuxg5
        OIQFgiQWTyoBqWERUJXoO/GVBSTMKxAl0b4/FGKZvMS5BxAjOQUsJC59fsQIYgsJmEuc7nzA
        PIGRZwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXVO93MwSvdSU0k2MkNAS3ME446TcIUYB
        DkYlHt6V1ksihVgTy4orcw8xSnIwKYnyZigsjRTiS8pPqcxILM6ILyrNSS0+xCjBwawkwhvM
        DpTjTUmsrEotyodJSXOwKInz8i1R9xMSSE8sSc1OTS1ILYLJynBwKEnwcgFjSEiwKDU9tSIt
        M6cEIc3EwQkynAdouBNIDW9xQWJucWY6RP4Uo6KUOO8ERaCEAEgiozQPrhcW+68YxYFeEeb1
        BWnnAaYNuO5XQIOZgAYrCi4EGVySiJCSamBctujoUqkJyxX3blEITJm1muu8aDqz44433hlb
        5p9oWHi1+5vBtUalE1GdHDl+vHNKl73pKjeOFrj2rK7wefLFLf+vGp39WRB3vfLNr7AvJhPW
        3P4YsiVDOk3XkYmn1Sn4x5Uc9u1ai7bICLNI/4zPjFzs6Xr45MHcmx9Unix99r3kZkZ96o/n
        SizFGYmGWsxFxYkAsu7aV9gCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, a loose reference is deleted even before locking the
`packed-refs` file, let alone deleting any packed version of the
reference. This leads to two problems, demonstrated by two new tests:

* While a reference is being deleted, other processes might see the
  old, packed value of the reference for a moment before the packed
  version is deleted. Normally this would be hard to observe, but we
  can prolong the window by locking the `packed-refs` file externally
  before running `update-ref`, then unlocking it before `update-ref`'s
  attempt to acquire the lock times out.

* If the `packed-refs` file is locked so long that `update-ref` fails
  to lock it, then the reference can be left permanently in the
  incorrect state described in the previous point.

In a moment, both problems will be fixed.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
The first of the new tests is rather involved; it uses two background
processes plus a foreground process that polls the value of a
reference. But despite sensitivity to timing, I think it should be
robust even in this broken state. Once the functionality being tested
is fixed, this test should never produce false positives, though
really bad timing (e.g., if it takes more than a second for
`update-ref` to get going) could still lead to false negatives.

Each of the new tests takes about a second to run because they
simulate lock contention.

If anybody has suggestions for better ways to test these things,
please speak up :-)

 t/t1404-update-ref-errors.sh | 71 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index c34ece48f5..752f83c377 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -404,4 +404,75 @@ test_expect_success 'broken reference blocks indirect create' '
 	test_cmp expected output.err
 '
 
+test_expect_failure 'no bogus intermediate values during delete' '
+	prefix=refs/slow-transaction &&
+	# Set up a reference with differing loose and packed versions:
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	git update-ref $prefix/foo $D &&
+	git for-each-ref $prefix >unchanged &&
+	# Now try to update the reference, but hold the `packed-refs` lock
+	# for a while to see what happens while the process is blocked:
+	: >.git/packed-refs.lock &&
+	test_when_finished "rm -f .git/packed-refs.lock" &&
+	{
+		sleep 1 &&
+		rm -f .git/packed-refs.lock &
+	} &&
+	pid1=$! &&
+	{
+		# Note: the following command is intentionally run in the
+		# background. We extend the timeout so that `update-ref`
+		# tries to acquire the `packed-refs` lock longer than it
+		# takes the background process above to delete it:
+		git -c core.packedrefstimeout=2000 update-ref -d $prefix/foo &
+	} &&
+	pid2=$! &&
+	ok=true &&
+	while kill -0 $pid2 2>/dev/null
+	do
+		sha1=$(git rev-parse --verify --quiet $prefix/foo || echo undefined) &&
+		case "$sha1" in
+		$D)
+			# This is OK; it just means that nothing has happened yet.
+			: ;;
+		undefined)
+			# This is OK; it means the deletion was successful.
+			: ;;
+		$C)
+			# This value should never be seen. Probably the loose
+			# reference has been deleted but the packed reference
+			# is still there:
+			echo "$prefix/foo incorrectly observed to be C" &&
+			break
+			;;
+		*)
+			# WTF?
+			echo "$prefix/foo unexpected value observed: $sha1" &&
+			break
+			;;
+		esac
+	done >out &&
+	wait $pid1 &&
+	wait $pid2 &&
+	test_must_be_empty out &&
+	test_must_fail git rev-parse --verify --quiet $prefix/foo
+'
+
+test_expect_failure 'delete fails cleanly if packed-refs file is locked' '
+	prefix=refs/locked-packed-refs &&
+	# Set up a reference with differing loose and packed versions:
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	git update-ref $prefix/foo $D &&
+	git for-each-ref $prefix >unchanged &&
+	# Now try to delete it while the `packed-refs` lock is held:
+	: >.git/packed-refs.lock &&
+	test_when_finished "rm -f .git/packed-refs.lock" &&
+	test_must_fail git update-ref -d $prefix/foo >out 2>err &&
+	git for-each-ref $prefix >actual &&
+	grep "Unable to create $Q.*packed-refs.lock$Q: File exists" err &&
+	test_cmp unchanged actual
+'
+
 test_done
-- 
2.14.1

