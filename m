From: John Tapsell <johnflux@gmail.com>
Subject: [PATCH 4/6] Improve error message for git-filter-branch
Date: Thu, 19 Feb 2009 07:36:35 +0000
Message-ID: <200902190736.35364.johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 08:38:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La3U3-0002xi-8p
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 08:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbZBSHgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 02:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752680AbZBSHgj
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 02:36:39 -0500
Received: from wf-out-1314.google.com ([209.85.200.169]:20229 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbZBSHgi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 02:36:38 -0500
Received: by wf-out-1314.google.com with SMTP id 28so363579wfa.4
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 23:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:date:to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=cxIuG0ji4eVmCvUcMuVPsjmdiyvymvLpTKoa3j7QzyA=;
        b=wIrNvm4h+yMREON68PhVm9waD1+N57wY4q181jnNVsQwa5KzzLLmsZ/2z5xCWWT+xz
         CmfTGs2MjtxEkyWhfphWhd+izvbo1Lf2QfQbolHGY4nVyw8hQfrNcQoScu2R+y+0t6p5
         W2CYiokPzF49MwUj+7FEfuOV+8Vt/rWFQk+eE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:date:to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=TgTEnJ0fABiWIY1XvKjTTnI+jnySBCbGLVSwy5Z4mQbF38ygQ77GbhADZ2sqkte+Gp
         0Z8yDQ+na0X1nGrr5MQrzHvOKAzKbEeqpokhm2LLAyVXWr263NwRUOJESGMzohaj2tvf
         wtgYhSFQ4yGh21WH3Y8xIHO9RRRyxbUJ2Kdfs=
Received: by 10.142.54.11 with SMTP id c11mr4143937wfa.14.1235028997905;
        Wed, 18 Feb 2009 23:36:37 -0800 (PST)
Received: from johnflux-desktop.localnet (58-190-81-184.eonet.ne.jp [58.190.81.184])
        by mx.google.com with ESMTPS id 30sm2548124wfa.58.2009.02.18.23.36.36
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Feb 2009 23:36:37 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110638>

Tell the user that a backup (original) already exists, and how to solve
this problem (with -f option)
---
 git-filter-branch.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 27b57b8..1ca45e2 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -226,7 +226,8 @@ while read sha1 type name
 do
 	case "$force,$name" in
 	,$orig_namespace*)
-		die "Namespace $orig_namespace not empty"
+		die "Cannot backup - a previous backup already exists in $orig_namespace\n" \
+		    "Force overwriting the backup with -f"
 	;;
 	t,$orig_namespace*)
 		git update-ref -d "$name" $sha1
-- 
1.6.2.rc1.3.g7d31b.dirty
