From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH] t9157-*.sh: Add an svn version check
Date: Tue, 11 Jan 2011 18:21:46 +0000
Message-ID: <4D2C9FBA.9080306@ramsay1.demon.co.uk>
References: <4D260A03.90903@ramsay1.demon.co.uk> <1294478342.2791.4.camel@fixed-disk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	stevenrwalter@gmail.com, normalperson@yhbt.net
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Jan 11 19:35:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcj3p-0007VS-Bw
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 19:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299Ab1AKSe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 13:34:59 -0500
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:42413 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932191Ab1AKSe6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jan 2011 13:34:58 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1Pcj3Z-0005mu-kF; Tue, 11 Jan 2011 18:34:57 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <1294478342.2791.4.camel@fixed-disk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164969>

Anders Kaseorg wrote:
> On Thu, 2011-01-06 at 18:29 +0000, Ramsay Jones wrote:
>> +svn_ver="$(svn --version --quiet)"
>> +case $svn_ver in
>> +[0-1].[0-4].[0-6])
> 
> Thanks for the patch.  Can I suggest the more precise
> 
> 0.* | 1.[0-4].*)
> 

Heh, yeah that would be more accurate! Thanks. ;-)

Junio, I've attached a fix-up patch below...

ATB,
Ramsay Jones

--- >8 ---
From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Date: Mon, 10 Jan 2011 23:21:26 +0000
Subject: [PATCH] t9157-*.sh: Make the svn version check more precise

These tests require an svn version 1.5 or newer to run correctly.
In particular, all 1.4.x versions and earlier are too old, so fix
up the case label regex to cover this range exactly.

[Fix provided by Anders Kaseorg <andersk@MIT.EDU>]

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/t9157-git-svn-fetch-merge.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9157-git-svn-fetch-merge.sh b/t/t9157-git-svn-fetch-merge.sh
index accf61e..991d2aa 100755
--- a/t/t9157-git-svn-fetch-merge.sh
+++ b/t/t9157-git-svn-fetch-merge.sh
@@ -8,7 +8,7 @@ test_description='git svn merge detection'
 
 svn_ver="$(svn --version --quiet)"
 case $svn_ver in
-[0-1].[0-4].[0-6])
+0.* | 1.[0-4].*)
 	skip_all="skipping git-svn test - SVN too old ($svn_ver)"
 	test_done
 	;;
-- 
1.7.3
