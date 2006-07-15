From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] array index mixup
Date: Sat, 15 Jul 2006 14:59:06 +0200
Message-ID: <E1G1jje-0007ey-OA@moooo.ath.cx>
References: <e9aff7$nk1$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 15 14:59:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1jjl-00065E-It
	for gcvg-git@gmane.org; Sat, 15 Jul 2006 14:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161270AbWGOM7K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Jul 2006 08:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161274AbWGOM7K
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Jul 2006 08:59:10 -0400
Received: from moooo.ath.cx ([85.116.203.178]:61383 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1161270AbWGOM7J (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Jul 2006 08:59:09 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <e9aff7$nk1$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23933>

---
Jakub Narebski <jnareb@gmail.com> wrote:
> git diff output for files specified by revision is somewhat unexpected. 
> 
>   $ git diff <revision_1>:<file> <revision_2>:<file>
> 
> outputs the following diff metainfo
> 
>   diff --git a/<revision_2>:<file> b/<revision_2>:<file>
>   index 5eabe06..2e87de4 100644
>   --- a/<revision_2>:<file>
>   +++ b/<revision_2>:<file>
> 
> Is it intended, or is it a bug? Looks like a bug to me...
I dunno if this is really an index mixup or was intended.  If this is
intended please add a comment what it's for.  (Without this you get
rename information, perhaps this is the reason.)
---
 builtin-diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index cb38f44..4d43a5c 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -136,7 +136,7 @@ static int builtin_diff_blobs(struct rev
 	stuff_change(&revs->diffopt,
 		     mode, mode,
 		     blob[1].sha1, blob[0].sha1,
-		     blob[0].name, blob[0].name);
+		     blob[1].name, blob[0].name);
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
 	return 0;
-- 
1.4.1.ga3e6
