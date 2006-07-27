From: Robert Shearman <rob@codeweavers.com>
Subject: [PATCH 1/2] rebase: Fix the detection of fast-forwarding of the current
 branch to upstream.
Date: Thu, 27 Jul 2006 10:32:25 +0100
Organization: CodeWeavers
Message-ID: <44C88829.3020705@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070107050107070504080701"
X-From: git-owner@vger.kernel.org Thu Jul 27 11:33:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G62En-0002Mu-SE
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 11:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWG0Jc7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 05:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbWG0Jc6
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 05:32:58 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:30357 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S932513AbWG0Jc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jul 2006 05:32:58 -0400
Received: from host86-139-253-196.range86-139.btcentralplus.com ([86.139.253.196] helo=[172.16.0.10])
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1G62Ej-0005k5-Iz
	for git@vger.kernel.org; Thu, 27 Jul 2006 04:32:57 -0500
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060725)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24272>

This is a multi-part message in MIME format.
--------------070107050107070504080701
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Previously, a rebasing operation with on a branch that is just tracking 
an upstream branch would output a confusing "Nothing to do" due to no 
patches being given to git-am.

The test brings the behaviour back into line with that of just before 
e646c9c8c0aa995eac284ea0a2117add19c4461c.
Signed-off-by: Robert Shearman <rob@codeweavers.com>
---
  git-rebase.sh |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

--------------070107050107070504080701
Content-Type: text/x-patch;
 name="5d77c657b6e3b8fabe8690171a10aa54ec2cf641.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="5d77c657b6e3b8fabe8690171a10aa54ec2cf641.diff"

diff --git a/git-rebase.sh b/git-rebase.sh
index 29028dd..5554541 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -281,7 +281,7 @@ git-reset --hard "$onto"
 
 # If the $onto is a proper descendant of the tip of the branch, then
 # we just fast forwarded.
-if test "$mb" = "$onto"
+if test "$mb" = "$branch"
 then
 	echo >&2 "Fast-forwarded $branch to $newbase."
 	exit 0


--------------070107050107070504080701--
