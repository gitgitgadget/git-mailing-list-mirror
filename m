Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28782203EA
	for <e@80x24.org>; Sun, 11 Dec 2016 12:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbcLKMRr (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Dec 2016 07:17:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752399AbcLKMRq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2016 07:17:46 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EEA5861BAA
        for <git@vger.kernel.org>; Sun, 11 Dec 2016 12:17:45 +0000 (UTC)
Received: from krava (dhcp-1-167.brq.redhat.com [10.34.1.167])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id uBBCHiKQ019128
        for <git@vger.kernel.org>; Sun, 11 Dec 2016 07:17:45 -0500
Date:   Sun, 11 Dec 2016 13:17:44 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     git@vger.kernel.org
Subject: [BUG] git crash for git remote update tip tip
Message-ID: <20161211121744.GA1973@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 11 Dec 2016 12:17:46 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hi,
I accidentaly added 2 remotes and git remote update
crashed, see the attached output.

[jolsa@krava perf]$ git --version
git version 2.7.4

thanks,
jirka


[jolsa@krava perf]$ git remote update tip tip
Fetching tip
Fetching tip
*** Error in `git': double free or corruption (fasttop): 0x000055afef92c560 ***
======= Backtrace: =========
/lib64/libc.so.6(+0x7570b)[0x7f1ff79b170b]
/lib64/libc.so.6(+0x7deaa)[0x7f1ff79b9eaa]
/lib64/libc.so.6(cfree+0x4c)[0x7f1ff79bd40c]
git(+0x13aa30)[0x55afed553a30]
git(+0x44936)[0x55afed45d936]
git(+0x1189f)[0x55afed42a89f]
git(+0x10970)[0x55afed429970]
/lib64/libc.so.6(__libc_start_main+0xf1)[0x7f1ff795c731]
git(+0x10e59)[0x55afed429e59]
======= Memory map: ========
55afed419000-55afed5ed000 r-xp 00000000 fd:01 1321939                    /usr/libexec/git-core/git
55afed7ec000-55afed7f0000 r--p 001d3000 fd:01 1321939                    /usr/libexec/git-core/git
55afed7f0000-55afed7f8000 rw-p 001d7000 fd:01 1321939                    /usr/libexec/git-core/git
55afed7f8000-55afed824000 rw-p 00000000 00:00 0 
55afef106000-55afef946000 rw-p 00000000 00:00 0                          [heap]
7f1fec000000-7f1fec021000 rw-p 00000000 00:00 0 
7f1fec021000-7f1ff0000000 ---p 00000000 00:00 0 
7f1ff0c61000-7f1ff0c77000 r-xp 00000000 fd:01 1311838                    /usr/lib64/libgcc_s-6.2.1-20160916.so.1
7f1ff0c77000-7f1ff0e76000 ---p 00016000 fd:01 1311838                    /usr/lib64/libgcc_s-6.2.1-20160916.so.1
7f1ff0e76000-7f1ff0e77000 r--p 00015000 fd:01 1311838                    /usr/lib64/libgcc_s-6.2.1-20160916.so.1
7f1ff0e77000-7f1ff0e78000 rw-p 00016000 fd:01 1311838                    /usr/lib64/libgcc_s-6.2.1-20160916.so.1
7f1ff0e78000-7f1ff793c000 r--p 00000000 fd:01 1588307                    /usr/lib/locale/locale-archive
7f1ff793c000-7f1ff7af5000 r-xp 00000000 fd:01 1316983                    /usr/lib64/libc-2.23.so
7f1ff7af5000-7f1ff7cf4000 ---p 001b9000 fd:01 1316983                    /usr/lib64/libc-2.23.so
7f1ff7cf4000-7f1ff7cf8000 r--p 001b8000 fd:01 1316983                    /usr/lib64/libc-2.23.so
7f1ff7cf8000-7f1ff7cfa000 rw-p 001bc000 fd:01 1316983                    /usr/lib64/libc-2.23.so
7f1ff7cfa000-7f1ff7cfe000 rw-p 00000000 00:00 0 
7f1ff7cfe000-7f1ff7d05000 r-xp 00000000 fd:01 1317075                    /usr/lib64/librt-2.23.so
7f1ff7d05000-7f1ff7f04000 ---p 00007000 fd:01 1317075                    /usr/lib64/librt-2.23.so
7f1ff7f04000-7f1ff7f05000 r--p 00006000 fd:01 1317075                    /usr/lib64/librt-2.23.so
7f1ff7f05000-7f1ff7f06000 rw-p 00007000 fd:01 1317075                    /usr/lib64/librt-2.23.so
7f1ff7f06000-7f1ff7f1d000 r-xp 00000000 fd:01 1315488                    /usr/lib64/libpthread-2.23.so
7f1ff7f1d000-7f1ff811c000 ---p 00017000 fd:01 1315488                    /usr/lib64/libpthread-2.23.so
7f1ff811c000-7f1ff811d000 r--p 00016000 fd:01 1315488                    /usr/lib64/libpthread-2.23.so
7f1ff811d000-7f1ff811e000 rw-p 00017000 fd:01 1315488                    /usr/lib64/libpthread-2.23.so
7f1ff811e000-7f1ff8122000 rw-p 00000000 00:00 0 
7f1ff8122000-7f1ff8137000 r-xp 00000000 fd:01 1312081                    /usr/lib64/libz.so.1.2.8
7f1ff8137000-7f1ff8336000 ---p 00015000 fd:01 1312081                    /usr/lib64/libz.so.1.2.8
7f1ff8336000-7f1ff8337000 r--p 00014000 fd:01 1312081                    /usr/lib64/libz.so.1.2.8
7f1ff8337000-7f1ff8338000 rw-p 00015000 fd:01 1312081                    /usr/lib64/libz.so.1.2.8
7f1ff8338000-7f1ff83aa000 r-xp 00000000 fd:01 1320777                    /usr/lib64/libpcre.so.1.2.7
7f1ff83aa000-7f1ff85a9000 ---p 00072000 fd:01 1320777                    /usr/lib64/libpcre.so.1.2.7
7f1ff85a9000-7f1ff85aa000 r--p 00071000 fd:01 1320777                    /usr/lib64/libpcre.so.1.2.7
7f1ff85aa000-7f1ff85ab000 rw-p 00072000 fd:01 1320777                    /usr/lib64/libpcre.so.1.2.7
7f1ff85ab000-7f1ff85cf000 r-xp 00000000 fd:01 1311836                    /usr/lib64/ld-2.23.so
7f1ff8705000-7f1ff87af000 rw-p 00000000 00:00 0 
7f1ff87cc000-7f1ff87ce000 rw-p 00000000 00:00 0 
7f1ff87ce000-7f1ff87cf000 r--p 00023000 fd:01 1311836                    /usr/lib64/ld-2.23.so
7f1ff87cf000-7f1ff87d0000 rw-p 00024000 fd:01 1311836                    /usr/lib64/ld-2.23.so
7f1ff87d0000-7f1ff87d1000 rw-p 00000000 00:00 0 
7ffe37593000-7ffe375b4000 rw-p 00000000 00:00 0                          [stack]
7ffe375e4000-7ffe375e6000 r--p 00000000 00:00 0                          [vvar]
7ffe375e6000-7ffe375e8000 r-xp 00000000 00:00 0                          [vdso]
ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]
error: fetch died of signal 6
