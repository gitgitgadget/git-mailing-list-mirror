From: Shantanu Pavgi <pavgi@uab.edu>
Subject: removing files from history but not filesystem
Date: Tue, 28 Jun 2011 01:13:44 -0500
Message-ID: <CFCCFA00-B4BF-4A88-88A5-2F588630F7BB@uab.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 28 08:20:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbRfF-0008BL-LA
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 08:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677Ab1F1GUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 02:20:05 -0400
Received: from uabexht2.ad.uab.edu ([138.26.5.102]:38325 "EHLO
	UABEXHT2.ad.uab.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756531Ab1F1GTC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2011 02:19:02 -0400
X-Greylist: delayed 312 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jun 2011 02:19:02 EDT
Received: from UABEXMBS5.ad.uab.edu ([138.26.5.38]) by UABEXHT2.ad.uab.edu
 ([138.26.5.102]) with mapi; Tue, 28 Jun 2011 01:13:45 -0500
Thread-Topic: removing files from history but not filesystem
Thread-Index: Acw1WokaL7yLFR1OSPe4HJX2eA51qg==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176383>


Hi,

How do I delete files from commit history, but still keep these files untracked on the filesystem? 

I tried 'git rm --cached' command using 'git filter-branch'; however it deleted file from the filesystem as well. 

{{{
$ git filter-branch --index-filter 'git rm --cached --ignore-unmatch */one.txt' HEAD
}}}

I am guessing since file is getting deleted from commit history (where it was created/modified), it won't be present on the filesystem as well. Am I following it correctly? Any further elaboration on this problem will be really helpful. 

Do I need to move concerned files to some other temporary location and rename them back to original filename? I have tried following commands with tree-filter, but it is failing as of now (second mv command needs to know correct filesystem path which was matched for */one.txt): 
{{{
$ git filter-branch -f --tree-filter \
> 'if [ -f */one.txt ]; then mv */one.txt */one.txt.keep; fi; rm -f */one.txt; if [ -f */one.txt.keep ]; then mv -f */one.txt.keep */one.txt; fi' \
> HEAD
}}}
 
Any help?

--
Thanks,
Shantanu. 
