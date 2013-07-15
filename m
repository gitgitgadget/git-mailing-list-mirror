From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 00/19] Index-v5
Date: Mon, 15 Jul 2013 11:30:34 +0200
Message-ID: <87ehb0cgqt.fsf@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com> <CACsJy8AhmYBjzqPtF3f9Gk8hq2bk8-PtFCto9_4AkRePomvhAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 11:30:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyf7E-0004B9-D8
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 11:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642Ab3GOJak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 05:30:40 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:51434 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609Ab3GOJaj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 05:30:39 -0400
Received: by mail-ee0-f54.google.com with SMTP id t10so7501705eei.13
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 02:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=Q+MWfWjMr8xRRvHDZ+mvCZ+Eo/p6Cq4eB+6oHTN9gCQ=;
        b=AZnZ4Hsne5n08QRg+tieulf2mtONr9FHf/MDUTfoISUCahPrwJ/0264yGkkf7JavSt
         iliNIS3epT+64YzRr9LuzCojB2PFckDXmNO++r6imTAIRM6mkk5+OPkInjCpH2J9vZ3N
         iulbxemaJ44ac9UdqURlh7nCXPDIAbWClMouVwVrvmZD8vJArPFGJ/Au2a7J7VGmQke3
         5+y6J5YrICzALm8hxgniB3PGMt33AIlwSdmqWpM6jW9jtlbYyN8+RVmhrIxf8gdLWXaf
         1lz4xx+dUVUdqu+Unh7bOSCRU3bhgqxcXBIXHgO6qdnYUMUwy/bAosUEI4m7/YowEhud
         /ThA==
X-Received: by 10.14.110.194 with SMTP id u42mr58123115eeg.128.1373880637553;
        Mon, 15 Jul 2013 02:30:37 -0700 (PDT)
Received: from localhost ([2a02:27e8:10:1047:0:dacb:1376:714a])
        by mx.google.com with ESMTPSA id n42sm101066853eeh.15.2013.07.15.02.30.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 02:30:36 -0700 (PDT)
In-Reply-To: <CACsJy8AhmYBjzqPtF3f9Gk8hq2bk8-PtFCto9_4AkRePomvhAQ@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230446>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Jul 13, 2013 at 12:26 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>>  t/perf/p0003-index.sh                            |   59 +
>>  t/t2104-update-index-skip-worktree.sh            |    1 +
>
> For such a big code addition, the test part seems modest. Speaking
> from my experience, I rarely run perf tests and "make test" does not
> activate v5 code at all. A few more tests would be nice. The good news
> is I changed default index version to 5 and ran "make test", all
> passed.

I was using the test suite with index version 5 as default index version
for testing of the new index file format.   I think that's the best way
to test the index, as it covers all aspects.  Maybe we should add a test
that covers the basic functionality, just to make sure nothing obvious
is broken when running the test suite with index-v2?  Something like
this maybe:

--->8---

>From c476b521c94f1a9b0b4fcfe92d63321442d79c9a Mon Sep 17 00:00:00 2001
From: Thomas Gummerer <t.gummerer@gmail.com>
Date: Mon, 15 Jul 2013 11:21:06 +0200
Subject: [PATCH] t1600: add basic test for index-v5

Add a test that checks the index-v5 file format when running the
test-suite with index-v2 as default index format.  When making changes
to the index, the test suite still should be run with both index v2 and
index v5 as default index format, for better coverage of all aspects of
the index.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t1600-index-v5.sh | 133 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100755 t/t1600-index-v5.sh

diff --git a/t/t1600-index-v5.sh b/t/t1600-index-v5.sh
new file mode 100755
index 0000000..528c17e
--- /dev/null
+++ b/t/t1600-index-v5.sh
@@ -0,0 +1,133 @@
+#!/bin/sh
+#
+# Copyright (c) 2013 Thomas Gummerer
+
+test_description='Test basic functionaltiy of index-v5.
+
+This test just covers the basics, to make sure normal runs of the test
+suite cover this version of the index file format too.  For better
+testing of the index-v5 format, the default index version should be
+changed to 5 and the test suite should be re-run'
+
+. ./test-lib.sh
+
+check_resolve_undo () {
+	msg=$1
+	shift
+	while case $# in
+	0)	break ;;
+	1|2|3)	die "Bug in check-resolve-undo test" ;;
+	esac
+	do
+		path=$1
+		shift
+		for stage in 1 2 3
+		do
+			sha1=$1
+			shift
+			case "$sha1" in
+			'') continue ;;
+			esac
+			sha1=$(git rev-parse --verify "$sha1")
+			printf "100644 %s %s\t%s\n" $sha1 $stage $path
+		done
+	done >"$msg.expect" &&
+	git ls-files --resolve-undo >"$msg.actual" &&
+	test_cmp "$msg.expect" "$msg.actual"
+}
+
+prime_resolve_undo () {
+	git reset --hard &&
+	git checkout second^0 &&
+	test_tick &&
+	test_must_fail git merge third^0 &&
+	echo merge does not leave anything &&
+	check_resolve_undo empty &&
+	echo different >fi/le &&
+	git add fi/le &&
+	echo resolving records &&
+	check_resolve_undo recorded fi/le initial:fi/le second:fi/le third:fi/le
+}
+
+test_expect_success 'setup' '
+	git update-index --index-version=5 &&
+	echo file1 >file1 &&
+	echo file2 >file2 &&
+	mkdir -p top/sub &&
+	echo x >top/x &&
+	echo xy >top/xy &&
+	echo y >top/y &&
+	echo yx >top/yx &&
+	echo sub1 >top/sub/sub1 &&
+	git add . &&
+	git commit -m "initial import"
+'
+
+test_expect_success 'ls-files shows all files' '
+	cat >expected <<-EOF &&
+	100644 e2129701f1a4d54dc44f03c93bca0a2aec7c5449 0	file1
+	100644 6c493ff740f9380390d5c9ddef4af18697ac9375 0	file2
+	100644 48df0cb83fee5d667537343f60a6057a63dd3c9b 0	top/sub/sub1
+	100644 587be6b4c3f93f93c489c0111bba5596147a26cb 0	top/x
+	100644 5aad9376af82d7b98a34f95fb0f298a162f52656 0	top/xy
+	100644 975fbec8256d3e8a3797e7a3611380f27c49f4ac 0	top/y
+	100644 ba1575927fa5b1f4bce72ad0c349566f1b02508e 0	top/yx
+	EOF
+	git ls-files --stage >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'ls-files with pathspec in subdir' '
+	cd top/sub &&
+	cat >expected <<-EOF &&
+	../x
+	../xy
+	EOF
+	git ls-files --error-unmatch ../x* >actual &&
+	test_cmp expected actual &&
+	cd ../..
+'
+
+test_expect_success 'read-tree HEAD establishes cache-tree' '
+	git read-tree HEAD &&
+	cat >expected <<-EOF &&
+	84e73410ea7864ccada24d897462e8ce1e1b872b  (7 entries, 1 subtrees)
+	602482536bd3852e8ac2977ed1a9913a8c244aa0 top/ (5 entries, 1 subtrees)
+	20bb0109200f37a7e19283b4abc4a672be3f0adb top/sub/ (1 entries, 0 subtrees)
+	EOF
+	test-dump-cache-tree >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'setup resolve-undo' '
+	mkdir fi &&
+	printf "a\0a" >binary &&
+	git add binary &&
+	test_commit initial fi/le first &&
+	git branch side &&
+	git branch another &&
+	printf "a\0b" >binary &&
+	git add binary &&
+	test_commit second fi/le second &&
+	git checkout side &&
+	test_commit third fi/le third &&
+	git branch add-add &&
+	git checkout another &&
+	test_commit fourth fi/le fourth &&
+	git checkout add-add &&
+	test_commit fifth add-differently &&
+	git checkout master
+'
+
+test_expect_success 'add records switch clears' '
+	prime_resolve_undo &&
+	test_tick &&
+	git commit -m merged &&
+	echo committing keeps &&
+	check_resolve_undo kept fi/le initial:fi/le second:fi/le third:fi/le &&
+	git checkout second^0 &&
+	echo switching clears &&
+	check_resolve_undo cleared
+'
+
+test_done
--
1.8.3.453.g1dfc63d
