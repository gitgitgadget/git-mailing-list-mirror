From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH] Documentation/githooks: Explain pre-rebase parameters
Date: Tue, 19 Feb 2013 06:03:24 -0500
Message-ID: <c19c03f51d71a58fa3795f665fe4a4c0461fa58f.1361271116.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 12:04:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7kzL-0004lk-7J
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 12:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700Ab3BSLDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 06:03:31 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:34390 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932339Ab3BSLDa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 06:03:30 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIG00AC5S1TBG10@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 19 Feb 2013 05:03:30 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 9DA0A8ABBB2; Tue,
 19 Feb 2013 06:03:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361271809; bh=oPweHVe6b7CWXqug2tas/EjvTx5VQKjWhvrNkDLbMKc=;
	h=From:To:Cc:Subject:Date;
	b=tEYyDYdsaQSzFaFSnl8wdB72KH08V/0K//mdi0YAM1/SjAsZsQv4gu+ojBZzgZm1m
 /ARWT4UGzAVyBTQ5UFNn+yNLU62iWdBl8y2ZEOy4H+5llW6EccdTSgAtht8oj+mKLt
 NUnIg6o5RXN0gOaQo7lYDa67b69yaTAnhhA7o/LA=
X-Mailer: git-send-email 1.7.12.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216604>

From: "W. Trevor King" <wking@tremily.us>

Descriptions borrowed from templates/hooks--pre-rebase.sample.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
I'm not 100% convinced about this, because the git-rebase.sh uses:

  "$GIT_DIR/hooks/pre-rebase" ${1+"$@"}

I haven't been able to find documentation for the ${1+"$@"} syntax.
Is it in POSIX?  It's not in the Bash manual:

  $ man bash | grep '\${.*[+]'
              (${BASH_SOURCE[$i+1]})  where  ${FUNCNAME[$i]}  was  called  (or
              ${BASH_SOURCE[$i+1]}.
              ${BASH_SOURCE[$i+1]}  at  line  number  ${BASH_LINENO[$i]}.  The
       ${parameter:+word}

In my local tests, it seems equivalent to "$@".

Also, it appears that the `git-rebase--*.sh` handlers don't use the
pre-rebase hook.  Is this intentional?

Cheers,
Trevor

 Documentation/githooks.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index b9003fe..bc837c6 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -140,9 +140,10 @@ the outcome of 'git commit'.
 pre-rebase
 ~~~~~~~~~~
 
-This hook is called by 'git rebase' and can be used to prevent a branch
-from getting rebased.
-
+This hook is called by 'git rebase' and can be used to prevent a
+branch from getting rebased.  The hook takes two parameters: the
+upstream the series was forked from and the branch being rebased.  The
+second parameter will be empty when rebasing the current branch.
 
 post-checkout
 ~~~~~~~~~~~~~
-- 
1.8.1.336.g94702dd
