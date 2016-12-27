Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7BBB200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 19:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932320AbcL0T1O (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 14:27:14 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:45575 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752522AbcL0T1M (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 27 Dec 2016 14:27:12 -0500
X-AuditID: 12074411-fbbff700000009b7-6b-5862bf2567a5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 02.F4.02487.52FB2685; Tue, 27 Dec 2016 14:21:10 -0500 (EST)
Received: from [192.168.69.190] (p5B10401B.dip0.t-ipconnect.de [91.16.64.27])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBRJL73M020888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 27 Dec 2016 14:21:08 -0500
To:     git discussion list <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Subject: Intermittent failure of t0021
Message-ID: <ec454def-88a7-5562-1bfe-9d52de42dc55@alum.mit.edu>
Date:   Tue, 27 Dec 2016 20:21:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsUixO6iqKu2PynCYMsyZYuuK91MFo8fLmF1
        YPLYOesuu8fnTXIBTFFcNimpOZllqUX6dglcGX/23mUp+CtY0bz4HEsD42a+LkZODgkBE4ln
        h+4xdTFycQgJXGaUuNq5mREkISRwlkli3f9wEFtEIFHiz/utzCA2m4CuxKKeZiYQW1hATWJl
        33ewOK+AvcSyN//AelkEVCWmnnsEViMqECJxec5RNogaQYmTM5+wgNjMAuoSf+ZdYoaw5SW2
        v53DPIGRZxaSsllIymYhKVvAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdULzezRC81pXQT
        IySMBHcwzjgpd4hRgINRiYc3YFVihBBrYllxZe4hRkkOJiVR3pZJSRFCfEn5KZUZicUZ8UWl
        OanFhxglOJiVRHhn7wLK8aYkVlalFuXDpKQ5WJTEefmWqPsJCaQnlqRmp6YWpBbBZGU4OJQk
        eIv2AjUKFqWmp1akZeaUIKSZODhBhvMADV8DUsNbXJCYW5yZDpE/xagoJc7rCZIQAElklObB
        9cLi/BWjONArwrw/QKp4gCkCrvsV0GAmoMH69fEgg0sSEVJSDYxery1Ez/3Mf3GpZIZnE4fd
        SvksmdKU8+KT/x+4/VjOd/NGIV2f6l+B+zYJtraUJ53aN4uh7t3HjCOXnjEofi/jUxc9ezXw
        wcY7q/ZaGrBP7Zo7XYuJo+xOipUbt6Had/10BaVTfdPvXTy4cmm363WPCZ1ySf/9/ztWvXFW
        v9qTk7nsl9PkNg8lluKMREMt5qLiRACc4NPTzgIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm seeing intermittent failures of t0021. If I run it as follows (using
a ramdisk as temporary space, and `EXPENSIVE` turned off), it fails on
average about every 40 attempts:

$ make -j8 O=0 && (cd t && for i in $(seq 200); do if ./t0021-*.sh ;
then echo "passed attempt $i"; else echo "failed on attempt $i"; break;
fi ; done )

(I've also seen it fail while running the whole test suite, so it is not
the tight test loop that triggers the problem.)

The output when it fails is

Initialized empty Git repository in
/home/mhagger/self/proj/git/git/t/trash
directory.t0021-conversion/repo/.git/
[master (root-commit) 56d459b] test commit 1
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 .gitattributes
[master c30c7fc] test commit 2
 Author: A U Thor <author@example.com>
 4 files changed, 5 insertions(+)
 create mode 100644 test.r
 create mode 100644 test2.r
 create mode 100644 test4-empty.r
 create mode 100644 testsubdir/test3 'sq',$x.r
sort: cannot read: rot13-filter.log: No such file or directory
--- expected.log	2016-12-27 17:58:18.017505012 +0000
+++ rot13-filter.log	2016-12-27 17:58:18.017505012 +0000
@@ -1,7 +0,0 @@
-x IN: clean test.r 57 [OK] -- OUT: 57 . [OK]
-x IN: clean test2.r 14 [OK] -- OUT: 14 . [OK]
-x IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
-x IN: clean testsubdir/test3 'sq',$x.r 49 [OK] -- OUT: 49 . [OK]
-      1 START
-      1 STOP
-      1 init handshake complete
not ok 15 - required process filter should filter data

The failure bisects to

    9c48b4f "t0021: minor filter process test cleanup", 2016-12-04

If I test the two parts of that commit separately, it is the removal of
the `.` arguments from `git commit` that triggers the failures (i.e.,
not the removal of the creation of `.gitignore`).

It's possible that the test was unreliable or racy even before this
change, but I have run the same test 1000+ times against the parent
commit (b18f6a00662524443cfb82f5fed7d3b54524c8ab) under the same
conditions without seeing a single failure. So *something* seems to have
been changed for the worse by this commit.

I don't plan to look into it any further, but if you have trouble
reproducing the problem don't hesitate to contact me.

Michael
