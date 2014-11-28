From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] t0050-*.sh: mark the rename (case change) test as passing
Date: Fri, 28 Nov 2014 16:57:18 +0000
Message-ID: <5478A96E.8030706@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 28 17:57:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuOrF-0002tv-5V
	for gcvg-git-2@plane.gmane.org; Fri, 28 Nov 2014 17:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbaK1Q5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2014 11:57:21 -0500
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:45070 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751302AbaK1Q5U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2014 11:57:20 -0500
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 7BE886F9626;
	Fri, 28 Nov 2014 16:57:10 +0000 (GMT)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 37E2A6F95D3;
	Fri, 28 Nov 2014 16:57:10 +0000 (GMT)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Fri, 28 Nov 2014 16:57:10 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260371>


Since commit baa37bff ("mv: allow renaming to fix case on case
insensitive filesystems", 08-05-2014), the 'git mv' command has
been able to rename a file, to one which differs only in case,
on a case insensitive filesystem.

This results in the 'rename (case change)' test, which used to fail
prior to this commit, to now (unexpectedly) pass. Mark this test as
passing.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

I noticed this last week while testing on cygwin. I have only tested
this on (64-bit) cygwin/ntfs, but I would assume that other case
insensitive filesystems would be OK, since there have been no complaints
about t6039-merge-ignorecase.sh not working.

Note that I didn't remove $test_case, despite having removed its last
use in this test, in case there will be a future need. I'm not sure
there will be a future need, of course, so if you would rather I got
rid of it, just let me know.

ATB,
Ramsay Jones

 t/t0050-filesystem.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 6b3cedc..988c392 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -64,7 +64,7 @@ test_expect_success "setup case tests" '
 	git checkout -f master
 '
 
-$test_case 'rename (case change)' '
+test_expect_success 'rename (case change)' '
 	git mv camelcase CamelCase &&
 	git commit -m "rename"
 '
-- 
2.1.0
