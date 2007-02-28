From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: My git repo is broken, how to fix it ?
Date: Wed, 28 Feb 2007 10:36:30 +0600
Message-ID: <200702281036.30539.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 05:36:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMGYV-0002F1-1z
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 05:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbXB1Egl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 23:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbXB1Egl
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 23:36:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:7272 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbXB1Egk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 23:36:40 -0500
Received: by ug-out-1314.google.com with SMTP id 44so24929uga
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 20:36:38 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nvswTOR2Se6VHj+EzrmCCMx+hWhHb//2nXuffDcYxAFI2VOSZHAe7+z0foEoxQPZFADmp/DN4usBVk9Nj7uk+Rzcx2nYxd463IUTFwO4WX+VKsKdMqFz0bzWx1UeJ7hIjq88Y3ORTzCfzS4IEQ81gQ/qZTNBwkh+yNC5dwwmsG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=o833//QOMQroEFM/YcomXCX2keEEY2gsPtCJCEdwkEwHiUBQzu5ODN2B+1RAwyKZEs+xLE5LZ3PUlUw/gFt8p68miZmGEGyxNN+Xpl3RCgOb7ReYyCDA46nuSqh5zgpqFIUOASAGaoefycghfEaSHzNW/M64tEabltX0WQNX310=
Received: by 10.67.29.12 with SMTP id g12mr135386ugj.1172637398916;
        Tue, 27 Feb 2007 20:36:38 -0800 (PST)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id 24sm77996ugf.2007.02.27.20.36.37;
        Tue, 27 Feb 2007 20:36:37 -0800 (PST)
User-Agent: KMail/1.8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40893>

Hello,

I use manualy compiled git under cygwin. Some time ago I have imported project 
from CVS and start to us it under git. To emulate 'separate remotes' schema 
for branches from CVS I clone imported git repo and work with it. From time 
to time I incrementaly update imported repo from cvs and sometimes use 
git-cvsexportcommit (from work repo) to export my changes and then get them 
using git-cvsimport.

Some times ago I descide to run fsck and found that by working repo is broken, 
while imported repo is correct. Is there way to fix it ? 

>git version
git version 1.5.0.GIT
(It was actualy compiled from e86d552 commit)
> git fsck
> git fsck --full
error: packed 7f5fed8131fb32972c602dede29b9257a053ba67 
from .git/objects/pack/pack-c4554978bbe079c9a43d6a13546a2fa314fe0884.pack is 
corrupt
sha1 mismatch 7f5fed8131fb32972c602dede29b9257a053ba67

(This is a blob, git cat-file blob 7f5fed813 shows me my c++ header file that 
is partialy broken with ^@ symbols)

The repo I get using git-cvsimport is correct and does not contains that blob. 
I also tried git-log -p for all by branches to force git to show me what is 
the commit was broken but git-log finished without errors.

By the way, several times I interrupt git's commands like commit and pull 
using Ctrl-C.

I tried to unpack all objects:
> git-unpack-objects -r 
< .git/objects/pack/pack-c4554978bbe079c9a43d6a13546a2fa314fe0884.pack; echo 
$?
Unpacking 12868 objects
 100% (12868/12868) done
0

No erorts here. But fsck find that broken blob:
> git fsck 
dangling blob beb992198d4d8813ea51fd1cbbf38313ef490c22

git-cat-file shows me this this is a broken object with correct sha1 sum.


As a cunclusion: my repo has broken file and I don't see there is the brakage. 
Can I reconstruct file by sha1 sum :-) or can I do something to stop fsck 
warn me ?
