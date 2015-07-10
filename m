From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] p5310: mend broken &&-chain
Date: Fri, 10 Jul 2015 22:40:57 +0200
Message-ID: <55A02DD9.3020909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 10 22:41:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDf7K-0006io-DW
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 22:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933253AbbGJUlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 16:41:47 -0400
Received: from mout.web.de ([212.227.15.3]:59955 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933243AbbGJUlj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 16:41:39 -0400
Received: from [192.168.178.27] ([79.253.139.191]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MVLsk-1ZUkeD1c7y-00Ygod; Fri, 10 Jul 2015 22:41:15
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
X-Provags-ID: V03:K0:G9jaFpxGVgwJHsWyQXXKVNppeAxjx/DlppD+3Pg2gl95Z+EbOa5
 m99PYv756zarv6dLBIIhkPC9A/56bG9bRusHyl5d1mEfW+lnJ48lfl9sjgLIKSTrVR1ZDXc
 B9+yQSVL9fLPXnb6471JOV5m/KT2+T2ywu2VmaNQAm/7DnsrAs/AmO0kUhYAum55OzD0NrQ
 sQW9DJJmjNSSyLTk3hV3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PfEdLQv25tE=:zT4ZB0Hb81Sxw0vQuH5A1u
 W64sL0Yvye/kZK5YDCtCIWAW8tfErcvw0URckui66HftpYJJtGA7Hv4J7AW3hciioNHFtvWu+
 t1SNyZM4App0W007zfsJxsHqYM1pACYuzCRiSiZtw0KI2YY6G6DwIoG7B6sDDjV/bXNtTNWTD
 z/lHCGCxqdf4AX+v2dyk2XMd/cDxc6pXfFLAo0hvjnLZ1YhyJJ+A5oEQzJhzCc4kQ6sEnBmwe
 ZB6uXkpbGHOhjOebq/FQVmAu+r74hWN7m+EB9Hj82fCKWofAHjhnaBs5dwrC4gXYNBfNXd3dZ
 muKNKbkreK+RJoS+ne5dv6ufBwO7R2ly2XEs3R1ImNGWa4JMBxU0oik1U7HCx5Q4bF0PFQNlU
 ON9rWBab6h6fOTaOJpcru7E3XQxklldV5gRUPcRSWu9bOiHd0fj1/Bjb3FpcChn2CA5+WK9mB
 hJVCLkHR6qo/uBbYDR0NmZRZRf5qgPIFcsr6Ps3OAv1s8SIDHvkC4ZHSpUoxmEPTmXKJNEnbD
 vpF5pZ4lKgKvq5QijBnstwpqZa8J2DZmns7DNE6cT8LAcz0X4adymuqSyDKZrDNG1XH2L/zPK
 zdvibVcyBYlErL1nyXSCMuOAGnQLgHOEGYiKKfk2ygwWu+GZArDyM1l7GxhD1LzAeimSYhd67
 T7qHVykK8e+65RiVHJCTPTxQmUkqC5zDRbGTen/llEQZK6g8njx2+VXRvRQ1uN7f3nuU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273833>

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
GIT_TEST_CHAIN_LINT complains about the missing &&s and is enabled
by default now.

 t/perf/p5310-pack-bitmaps.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index f8ed857..de2a224 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -39,14 +39,14 @@ test_expect_success 'create partial bitmap state' '
 
 	# now kill off all of the refs and pretend we had
 	# just the one tip
-	rm -rf .git/logs .git/refs/* .git/packed-refs
-	git update-ref HEAD $cutoff
+	rm -rf .git/logs .git/refs/* .git/packed-refs &&
+	git update-ref HEAD $cutoff &&
 
 	# and then repack, which will leave us with a nice
 	# big bitmap pack of the "old" history, and all of
 	# the new history will be loose, as if it had been pushed
 	# up incrementally and exploded via unpack-objects
-	git repack -Ad
+	git repack -Ad &&
 
 	# and now restore our original tip, as if the pushes
 	# had happened
-- 
2.4.4
