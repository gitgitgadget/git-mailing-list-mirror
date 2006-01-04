From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Strange unable to unlink error with git-prune-packed
Date: Wed, 4 Jan 2006 17:46:26 +1300
Message-ID: <46a038f90601032046l31f51742k93f3f9f5a826bef1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Jan 04 05:46:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eu0Xf-0006QP-Ee
	for gcvg-git@gmane.org; Wed, 04 Jan 2006 05:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbWADEq1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jan 2006 23:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965215AbWADEq1
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jan 2006 23:46:27 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:49897 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965165AbWADEq0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 Jan 2006 23:46:26 -0500
Received: by wproxy.gmail.com with SMTP id 57so2296174wri
        for <git@vger.kernel.org>; Tue, 03 Jan 2006 20:46:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FJt+8uoObf4ICCbEshw7ZInaQlgktXTVralsGDMkaokP0XWcdISS1SHg5uyx62INOeTxrgi4vrRh6FKRHnJA4dJ+y3whucSHfD46cmThVS2pu/IOJhloqSFPMx40qZPm8juIi8pjlQ4rBFVSFRQ6PQFHX8z45iMgU3zBmgSex/s=
Received: by 10.54.114.7 with SMTP id m7mr2117693wrc;
        Tue, 03 Jan 2006 20:46:26 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Tue, 3 Jan 2006 20:46:26 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14172>

Weilding a recent git version 1.0.6-g58e3 it turns out I cannot run
git-prune-packed on a simple repo on my OSX (Panther 10.3.9). The
local repo looks fine in my eyes, and permissions are similar to those
on Linux. Relaxing permissions doesn't help either, so there may be
something else afoot.

When I invoke git-prune-packed I am greeted by (3-line sample):

error: unable to unlink .git/objects/43/2251e8488dc3c72d94d698ed69003137c47244
error: unable to unlink .git/objects/43/6bc8b274ab96944a6f8c3cf5e3fbeef422042b
error: unable to unlink .git/objects/43/fe47e9508289ad4eca71613a9f20d7f3323602

File modes after I ran chmod -R u+w .git/objects to see if
prune-packed was taking the mode too seriously on OSX

$ ls -la .git/objects/43
total 24
drwxr-xr-x    5 martin  martin   170  4 Jan 17:37 .
drwxr-xr-x  229 martin  martin  7786  4 Jan 17:37 ..
-rw-r--r--    1 martin  martin   211 30 Dec 11:21
2251e8488dc3c72d94d698ed69003137c47244
-rw-r--r--    1 martin  martin    53 30 Dec 11:21
6bc8b274ab96944a6f8c3cf5e3fbeef422042b
-rw-r--r--    1 martin  martin   152 30 Dec 11:21
fe47e9508289ad4eca71613a9f20d7f3323602

This is low priority for me, and so weird that it has to be a pilot
error -- OTOH I may do a bisect to try and figure out whether it's a
recent change...

cheers,


martin
