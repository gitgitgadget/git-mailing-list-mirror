From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: Make test failure!?
Date: Thu, 15 Sep 2005 16:34:06 +0900 (JST)
Organization: USAGI/WIDE Project
Message-ID: <20050915.163406.95477939.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 09:34:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFoEQ-0001WD-Ou
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 09:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965229AbVIOHc1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 03:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965228AbVIOHc1
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 03:32:27 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:48398 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S965229AbVIOHcZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 03:32:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP
	id 1BEC833CC2; Thu, 15 Sep 2005 16:34:07 +0900 (JST)
To: junkio@cox.net
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8590>

Hello.

"make test" goes fine on my notebook, but it fails on another machine.
(Of course, the git source code are the same!)

*** t4101-apply-nonl.sh ***
*   ok 1: apply diff between 0 and 1
*   ok 2: apply diff between 0 and 2
*   ok 3: apply diff between 0 and 3
*   ok 4: apply diff between 1 and 0
*   ok 5: apply diff between 1 and 2
*   ok 6: apply diff between 1 and 3
*   ok 7: apply diff between 2 and 0
*   ok 8: apply diff between 2 and 1
* FAIL 9: apply diff between 2 and 3
        git-apply <diff.2-3 && diff frotz.3 frotz
*   ok 10: apply diff between 3 and 0
*   ok 11: apply diff between 3 and 1
* FAIL 12: apply diff between 3 and 2
        git-apply <diff.3-2 && diff frotz.2 frotz
* failed 2 among 12 test(s)
make[1]: *** [all] Error 1
make[1]: Leaving directory `/disk2/gitroot/git/t'
make: *** [test] Error 2

Diff follows:

--- /tmp/maketest.berry	2005-09-15 16:21:02.873664224 +0900
+++ /tmp/maketest.jupiter	2005-09-15 16:21:09.029728360 +0900
@@ -1,8 +1,8 @@
-Script started on Thu Sep 15 16:20:02 2005
-yoshfuji@berry:~/GIT/git % unsetenv LANG
-yoshfuji@berry:~/GIT/git % make test
+Script started on Thu Sep 15 16:20:52 2005
+yoshfuji@jupiter:~/GIT/git % unsetenv LANG
+yoshfuji@jupiter:~/GIT/git % make test
 make -C templates
-make[1]: Entering directory `/home/yoshfuji/GIT/git/templates'
+make[1]: Entering directory `/disk2/gitroot/git/templates'
 ls *--* 2>/dev/null | \
 while read boilerplate; \
 do \
@@ -18,22 +18,22 @@
 : no custom templates yet
 find blt
 blt
-blt/info
-blt/info/exclude
-blt/remotes
+blt/branches
 blt/hooks
-blt/hooks/pre-applypatch
 blt/hooks/applypatch-msg
-blt/hooks/update
-blt/hooks/post-commit
-blt/hooks/pre-commit
 blt/hooks/commit-msg
+blt/hooks/post-commit
 blt/hooks/post-update
-blt/branches
+blt/hooks/pre-applypatch
+blt/hooks/pre-commit
+blt/hooks/update
+blt/info
+blt/info/exclude
+blt/remotes
 blt/description
-make[1]: Leaving directory `/home/yoshfuji/GIT/git/templates'
+make[1]: Leaving directory `/disk2/gitroot/git/templates'
 make -C t/ all
-make[1]: Entering directory `/home/yoshfuji/GIT/git/t'
+make[1]: Entering directory `/disk2/gitroot/git/t'
 *** t0000-basic.sh ***
 *   ok 1: .git/objects should be empty after git-init-db in an empty repo.
 *   ok 2: .git/objects should have 258 subdirectories.
@@ -446,200 +446,17 @@
 *   ok 6: apply diff between 1 and 3
 *   ok 7: apply diff between 2 and 0
 *   ok 8: apply diff between 2 and 1
-*   ok 9: apply diff between 2 and 3
+* FAIL 9: apply diff between 2 and 3
+	git-apply <diff.2-3 && diff frotz.3 frotz
 *   ok 10: apply diff between 3 and 0
 *   ok 11: apply diff between 3 and 1
-*   ok 12: apply diff between 3 and 2
-* passed all 12 test(s)
-*** t4102-apply-rename.sh ***
-*   ok 1: setup
-*   ok 2: apply
-*   ok 3: validate
-* passed all 3 test(s)
-*** t4109-apply-multifrag.sh ***
-*   ok 1: S = git-apply (1)
-*   ok 2: S = patch (1)
-*   ok 3: S = cmp (1)
-*   ok 4: S = git-apply (2)
-*   ok 5: S = patch (2)
-*   ok 6: S = cmp (2)
-*   ok 7: S = git-apply (3)
-*   ok 8: S = patch (3)
-*   ok 9: S = cmp (3)
-* passed all 9 test(s)
-*** t4110-apply-scan.sh ***
-*   ok 1: S = git-apply scan
-*   ok 2: S = patch scan
-*   ok 3: S = cmp
-* passed all 3 test(s)
-*** t4112-apply-renames.sh ***
-*   ok 1: check rename/copy patch
-*   ok 2: apply rename/copy patch
-* passed all 2 test(s)
-*** t5000-tar-tree.sh ***
-*   ok 1: populate workdir
-*   ok 2: add files to repository
-*   ok 3: git-tar-tree
-*   ok 4: validate file modification time
-*   ok 5: git-get-tar-commit-id
-*   ok 6: extract tar archive
-*   ok 7: validate filenames
-*   ok 8: validate file contents
-*   ok 9: git-tar-tree with prefix
-*   ok 10: extract tar archive with prefix
-*   ok 11: validate filenames with prefix
-*   ok 12: validate file contents with prefix
-* passed all 12 test(s)
-*** t5300-pack-object.sh ***
-*   ok 1: setup
-*   ok 2: pack without delta
-*   ok 3: unpack without delta
-*   ok 4: check unpack without delta
-*   ok 5: pack with delta
-*   ok 6: unpack with delta
-*   ok 7: check unpack with delta
-*   ok 8: use packed objects
-*   ok 9: use packed deltified objects
-*   ok 10: verify pack
-*   ok 11: corrupt a pack and see if verify catches
-* passed all 11 test(s)
-*** t5400-send-pack.sh ***
-*   ok 1: setup
-*   ok 2: pushing rewound head should not barf but require --force
-* passed all 2 test(s)
-*** t6001-rev-list-merge-order.sh ***
-*   ok 1: rev-list has correct number of entries
-*   ok 2: --merge-order produces as many or fewer discontinuities
-*   ok 3: simple merge order
-*   ok 4: two diamonds merge order (g6)
-*   ok 5: multiple heads
-*   ok 6: multiple heads, prune at a1
-*   ok 7: multiple heads, prune at l1
-*   ok 8: cross-epoch, head at l5, prune at l1
-*   ok 9: duplicated head arguments
-*   ok 10: prune near merge
-*   ok 11: head has no parent
-*   ok 12: two nodes - one head, one base
-*   ok 13: three nodes one head, one internal, one base
-*   ok 14: linear prune l2 ^root
-*   ok 15: linear prune l2 ^l0
-*   ok 16: linear prune l2 ^l1
-*   ok 17: linear prune l5 ^a4
-*   ok 18: linear prune l5 ^l3
-*   ok 19: linear prune l5 ^l4
-*   ok 20: max-count 10 - merge order
-*   ok 21: max-count 10 - non merge order
-*   ok 22: --max-age=c3, no --merge-order
-*   ok 23: --max-age=c3, --merge-order
-*   ok 24: one specified head reachable from another a4, c3, --merge-order
-*   ok 25: one specified head reachable from another c3, a4, --merge-order
-*   ok 26: one specified head reachable from another a4, c3, no --merge-order
-*   ok 27: one specified head reachable from another c3, a4, no --merge-order
-*   ok 28: graph with c3 and a4 parents of head
-*   ok 29: graph with a4 and c3 parents of head
-*   ok 30: head ^head --merge-order
-*   ok 31: head ^head no --merge-order
-*   ok 32: simple merge order (l5r1)
-*   ok 33: simple merge order (r1l5)
-*   ok 34: don't print things unreachable from one branch
-*   ok 35: --merge-order a4 l3
-* passed all 35 test(s)
-*** t6002-rev-list-bisect.sh ***
-*   ok 1: bisection diff --bisect l0 ^root <= 0
-*   ok 2: bisection diff --bisect l1 ^root <= 0
-*   ok 3: bisection diff --bisect l2 ^root <= 0
-*   ok 4: bisection diff --bisect a0 ^root <= 0
-*   ok 5: bisection diff --bisect a1 ^root <= 0
-*   ok 6: bisection diff --bisect a2 ^root <= 0
-*   ok 7: bisection diff --bisect a3 ^root <= 0
-*   ok 8: bisection diff --bisect b1 ^root <= 0
-*   ok 9: bisection diff --bisect b2 ^root <= 0
-*   ok 10: bisection diff --bisect b3 ^root <= 0
-*   ok 11: bisection diff --bisect c1 ^root <= 0
-*   ok 12: bisection diff --bisect c2 ^root <= 0
-*   ok 13: bisection diff --bisect c3 ^root <= 0
-*   ok 14: bisection diff --bisect E ^F <= 0
-*   ok 15: bisection diff --bisect e1 ^F <= 0
-*   ok 16: bisection diff --bisect e2 ^F <= 0
-*   ok 17: bisection diff --bisect e3 ^F <= 0
-*   ok 18: bisection diff --bisect e4 ^F <= 0
-*   ok 19: bisection diff --bisect e5 ^F <= 0
-*   ok 20: bisection diff --bisect e6 ^F <= 0
-*   ok 21: bisection diff --bisect e7 ^F <= 0
-*   ok 22: bisection diff --bisect f1 ^F <= 0
-*   ok 23: bisection diff --bisect f2 ^F <= 0
-*   ok 24: bisection diff --bisect f3 ^F <= 0
-*   ok 25: bisection diff --bisect f4 ^F <= 0
-*   ok 26: bisection diff --bisect E ^F <= 0
-*   ok 27: bisection diff --bisect V ^U <= 1
-*   ok 28: bisection diff --bisect V ^U ^u1 ^u2 ^u3 <= 0
-*   ok 29: bisection diff --bisect u1 ^U <= 0
-*   ok 30: bisection diff --bisect u2 ^U <= 0
-*   ok 31: bisection diff --bisect u3 ^U <= 0
-*   ok 32: bisection diff --bisect u4 ^U <= 0
-*   ok 33: bisection diff --bisect u5 ^U <= 0
-*   ok 34: --bisect l5 ^root
-*   ok 35: --bisect l5 ^root ^c3
-*   ok 36: --bisect l5 ^root ^c3 ^b4
-*   ok 37: --bisect l3 ^root ^c3 ^b4
-*   ok 38: --bisect l5 ^b3 ^a3 ^b4 ^a4
-*   ok 39: --bisect l4 ^a2 ^a3 ^b ^a4
-*   ok 40: --bisect l3 ^a2 ^a3 ^b ^a4
-*   ok 41: --bisect a4 ^a2 ^a3 ^b4
-*   ok 42: --bisect a4 ^a2 ^a3 ^b4 ^c2
-*   ok 43: --bisect a4 ^a2 ^a3 ^b4 ^c2 ^c3
-*   ok 44: --bisect a4 ^a2 ^a3 ^b4
-*   ok 45: --bisect c3 ^a2 ^a3 ^b4 ^c2
-* passed all 45 test(s)
-*** t6003-rev-list-topo-order.sh ***
-*   ok 1: rev-list has correct number of entries
-*   ok 2: simple topo order
-*   ok 3: two diamonds topo order (g6)
-*   ok 4: multiple heads
-*   ok 5: multiple heads, prune at a1
-*   ok 6: multiple heads, prune at l1
-*   ok 7: cross-epoch, head at l5, prune at l1
-*   ok 8: duplicated head arguments
-*   ok 9: prune near topo
-*   ok 10: head has no parent
-*   ok 11: two nodes - one head, one base
-*   ok 12: three nodes one head, one internal, one base
-*   ok 13: linear prune l2 ^root
-*   ok 14: linear prune l2 ^l0
-*   ok 15: linear prune l2 ^l1
-*   ok 16: linear prune l5 ^a4
-*   ok 17: linear prune l5 ^l3
-*   ok 18: linear prune l5 ^l4
-*   ok 19: max-count 10 - topo order
-*   ok 20: max-count 10 - non topo order
-*   ok 21: --max-age=c3, no --topo-order
-*   ok 22: one specified head reachable from another a4, c3, --topo-order
-*   ok 23: one specified head reachable from another c3, a4, --topo-order
-*   ok 24: one specified head reachable from another a4, c3, no --topo-order
-*   ok 25: one specified head reachable from another c3, a4, no --topo-order
-*   ok 26: graph with c3 and a4 parents of head
-*   ok 27: graph with a4 and c3 parents of head
-*   ok 28: head ^head --topo-order
-*   ok 29: head ^head no --topo-order
-*   ok 30: simple topo order (l5r1)
-*   ok 31: simple topo order (r1l5)
-*   ok 32: don't print things unreachable from one branch
-*   ok 33: --topo-order a4 l3
-* passed all 33 test(s)
-*** t6101-rev-parse-parents.sh ***
-*   ok 1: start is valid
-*   ok 2: start^0
-*   ok 3: start^1 not valid
-*   ok 4: second^1 = second^
-*   ok 5: final^1^1^1
-*   ok 6: final^1^1^1 = final^^^
-*   ok 7: final^1^2
-*   ok 8: final^1^2 != final^1^1
-*   ok 9: final^1^3 not valid
-*   ok 10: --verify start2^1
-*   ok 11: --verify start2^0
-* passed all 11 test(s)
-make[1]: Leaving directory `/home/yoshfuji/GIT/git/t'
-yoshfuji@berry:~/GIT/git % exit
+* FAIL 12: apply diff between 3 and 2
+	git-apply <diff.3-2 && diff frotz.2 frotz
+* failed 2 among 12 test(s)
+make[1]: *** [all] Error 1
+make[1]: Leaving directory `/disk2/gitroot/git/t'
+make: *** [test] Error 2
+yoshfuji@jupiter:~/GIT/git % exit
+exit
 
-Script done on Thu Sep 15 16:21:02 2005
+Script done on Thu Sep 15 16:21:05 2005

-----------

I don't know if matters, but one is Debian 3.1 and the other is 3.0.

yoshfuji@berry:~/GIT/git % ldd git-apply
        libz.so.1 => /usr/lib/libz.so.1 (0xb7fc1000)
        libcrypto.so.0.9.7 => /usr/lib/i686/cmov/libcrypto.so.0.9.7 (0xb7ec1000)
        libc.so.6 => /lib/tls/libc.so.6 (0xb7d8c000)
        libdl.so.2 => /lib/tls/libdl.so.2 (0xb7d89000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0xb7fde000)

yoshfuji@jupiter:~/GIT/git % ldd git-apply
        libz.so.1 => /usr/lib/libz.so.1 (0x40019000)
        libcrypto.so.0.9.6 => /usr/lib/libcrypto.so.0.9.6 (0x40027000)
        libc.so.6 => /lib/libc.so.6 (0x400e8000)
        libdl.so.2 => /lib/libdl.so.2 (0x40205000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)

Hmm???

-- 
YOSHIFUJI Hideaki @ USAGI Project  <yoshfuji@linux-ipv6.org>
GPG-FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
