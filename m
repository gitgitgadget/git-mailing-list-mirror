From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 16a/19] gitweb: Remove workaround for git-diff bug fixed in f82cd3c
Date: Sat, 26 Aug 2006 12:33:17 +0200
Message-ID: <200608261233.18337.jnareb@gmail.com>
References: <200608240015.15071.jnareb@gmail.com> <200608252113.34731.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Aug 26 12:33:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGvTk-0002bM-Uz
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 12:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbWHZKdX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 06:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbWHZKdX
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 06:33:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:48396 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751363AbWHZKdW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 06:33:22 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1109395ugc
        for <git@vger.kernel.org>; Sat, 26 Aug 2006 03:33:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Xbx0zMmld9d1Wem9V8vYa3RENh3saed+zIcBgH5I1hSYrlnoKOsEejkB3gDEZkmMGJ6mxDl/x/GbRTjLeKcvSH0u/RaFVd7fwDpnoGUcRFFhCf5KxWpx4pcBVfo9/fQWc4kuf2OlBdKL9QmnbE76MdPRwdn1bXIhPvrbC+mNtHw=
Received: by 10.67.93.6 with SMTP id v6mr2446628ugl;
        Sat, 26 Aug 2006 03:33:21 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id j1sm5245667ugf.2006.08.26.03.33.20;
        Sat, 26 Aug 2006 03:33:20 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608252113.34731.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26046>

Remove workaround in git_blobdiff for error in git-diff (showing
reversed diff for diff of blobs), corrected in commit
 f82cd3c  Fix "git diff blob1 blob2" showing the diff in reverse.
which is post 1.4.2-rc2 commit.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e5a0db5..36a28a4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2841,8 +2841,7 @@ sub git_blobdiff {
 		}
 
 		# open patch output
-		#open $fd, "-|", $GIT, "diff", '-p', $hash_parent, $hash
-		open $fd, "-|", $GIT, "diff", '-p', $hash, $hash_parent
+		open $fd, "-|", $GIT, "diff", '-p', $hash_parent, $hash
 			or die_error(undef, "Open git-diff failed");
 	} else  {
 		die_error('404 Not Found', "Missing one of the blob diff parameters")
-- 
1.4.1.1
