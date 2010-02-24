From: Ian Hobson <ian@ianhobson.co.uk>
Subject: Re: Handling non-git config files
Date: Wed, 24 Feb 2010 18:27:50 +0000
Message-ID: <4B856FA6.4050808@ianhobson.co.uk>
References: <8440EA2C12E50645A68C4AA9887166513FC19C@SERVER.webdezign.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Richard Lee <richard@webdezign.co.uk>
X-From: git-owner@vger.kernel.org Wed Feb 24 19:43:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkMCb-0007P2-W7
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 19:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757530Ab0BXSnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 13:43:12 -0500
Received: from queueout01-winn.ispmail.ntl.com ([81.103.221.31]:63575 "EHLO
	queueout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757382Ab0BXSnL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2010 13:43:11 -0500
X-Greylist: delayed 921 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Feb 2010 13:43:10 EST
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100224182748.WBQS4474.mtaout02-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>
          for <git@vger.kernel.org>; Wed, 24 Feb 2010 18:27:48 +0000
Received: from jupiter.ianhobson.co.uk ([86.12.69.89])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100224182748.KIXB2093.aamtaout03-winn.ispmail.ntl.com@jupiter.ianhobson.co.uk>
          for <git@vger.kernel.org>; Wed, 24 Feb 2010 18:27:48 +0000
Received: (qmail 22143 invoked by uid 453); 24 Feb 2010 18:27:46 -0000
X-Virus-Checked: Checked by ClamAV on ianhobson.co.uk
Received: from pc-00012.ianhobson.co.uk (HELO [192.168.0.12]) (192.168.0.12)
    by ianhobson.co.uk (qpsmtpd/0.40) with ESMTP; Wed, 24 Feb 2010 18:27:45 +0000
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <8440EA2C12E50645A68C4AA9887166513FC19C@SERVER.webdezign.local>
X-Cloudmark-Analysis: v=1.1 cv=1ggfb5FlKZQUfF3vzm9UBYZ2uTfLsbs/8dSljwg5+mE= c=1 sm=0 a=Oh8D53mqLQd77L9eggoA:9 a=Cubwwa4HWokI2cgHK_EA:7 a=BIsWlLbjxtT7Sxfum4xkBrRUzpQA:4 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140969>

Richard Lee wrote:
> So my quesstion is that is there any way to have several checked out
> copies of a git repo each with their own slightly different config
> files, yet still being able to perform git operations with respect to a
> centralised repository as if they were identical?
>
>   
Hi Richard,

Yes. They are called branches :)

What I do is have a branch for each version that I need.

To fix a problem I checkout master, make the repair, and commit.

Then to deploy that change I perform three steps (for each production 
version).

git checkout <clientBranch>
git rebase master
rsync to the production server (ignoring .git and temp files)

All the differences between versions - config files, images, logos, etc 
- are all included in the GIT,
repo and I don't have to worry about them. To set up the branches, I 
simply checked out a new branch for each and applied the changes for 
that production version, and committed. It works very well in practise. 
(Do take care to checkout the version you want to work on before you 
start work, or you may have to lose your work to recover!).

Ian
