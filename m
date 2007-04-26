From: Andy Parkins <andyparkins@gmail.com>
Subject: git submodule support feedback
Date: Thu, 26 Apr 2007 12:38:49 +0100
Message-ID: <200704261238.51234.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 13:39:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hh2Jo-0007Tr-Uf
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 13:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030664AbXDZLjS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 07:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030685AbXDZLjS
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 07:39:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:7001 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030664AbXDZLjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 07:39:16 -0400
Received: by ug-out-1314.google.com with SMTP id 44so595842uga
        for <git@vger.kernel.org>; Thu, 26 Apr 2007 04:39:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=B6yTckOXIJ5PXzt2hPo9qCL/u+77VlEpYh4IVoGqyKb3b8BJf6KJ723R4n6ju3ZtnLr8AvIdQUR/encU0i69z1Qt/3fsbIrDX1i05Ej2iVCuudxpOhUiEutUvmkWygrILrpZVh79+YwdO2hhBAErL4y2oj1H/JpOnrHGNMKOJaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TCzIVq2G+776E0B0NyNQbcLZmGxVrWQe4WqAdfe+yxT+GqtTGc94CYjml5nNXWhk97J59qumE+pDSSslQR/QBHRG+QB2pawniHQsMVjtJP/RIS/Xg5kvvLPQLzYfzyIRlKZsUP+2/jubbMTFrtEuLPnQlw5u71Jfdb9mKFUrTdw=
Received: by 10.82.138.6 with SMTP id l6mr2934063bud.1177587555118;
        Thu, 26 Apr 2007 04:39:15 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b30sm53520ika.2007.04.26.04.39.05;
        Thu, 26 Apr 2007 04:39:11 -0700 (PDT)
User-Agent: KMail/1.9.6
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45629>

Hello,

I've started using submodule support in one of my projects.  I was previously 
using my own poorman's submodule support where I kept the commit in a 
file, .gitmodules.  Git's new submodule support is superior to this method 
and doesn't lose me any features over what I had so I thought I'd change.

My general comment is that it's great.  I've tried to trip it up a few times, 
but it works exactly as one would expect.  I was surprised how little I had 
to understand in order to make it work, I didn't even need git update-index.  
git-add and git-rm work fine when the directory you're adding is a git 
repository in itself.  Lovely.

I'll report further as I come across any stumbling blocks; but here is one to 
get you going: (It's not a problem with git really, and the workaround is 
simple, I'm reporting it for your information rather than to get it fixed).

In the master branch I deleted my .gitmodules file and did
 
 $ git add submodule
 $ git commit -m "Chuck poorman's-submodule use gitman's-submodule"

This took over the submodule management beautifully.  Now, I swapped to 
another branch and tried to merge the master branch:

 $ git checkout somebranch
 $ git merge master
 fatal: Updating 'submodule' would lose untracked files in it
 Merge with strategy recursive failed.

I appreciate why this has happened - submodule, from the point of view of 
git - doesn't exist in that branch, but the directory always has, as that's 
where I've kept it as my pseudo-submodule.  The fix was to do

 $ mv submodule submodule.tmp
 $ git merge master
 $ rmdir submodule
 $ mv submodule.tmp submodule

I bring this up only because anyone who's moving from non-submodule to 
submodule support might run into the same problem.

In short: great stuff - this is already more facility than I had, thanks 
chaps.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
