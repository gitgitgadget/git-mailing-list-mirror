From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Use case I don't know how to address
Date: Sat, 5 Sep 2009 19:23:28 +0200
Message-ID: <200909051923.28831.j6t@kdbg.org>
References: <4AA20CEC.8060408@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alan Chandler <alan@chandlerfamily.org.uk>
X-From: git-owner@vger.kernel.org Sat Sep 05 19:23:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjyzG-0007R6-Er
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 19:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbZIERXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 13:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752575AbZIERXb
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 13:23:31 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:21359 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576AbZIERXa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 13:23:30 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DCE8410011;
	Sat,  5 Sep 2009 19:23:29 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 2979A3E65E;
	Sat,  5 Sep 2009 19:23:29 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <4AA20CEC.8060408@chandlerfamily.org.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127821>

On Samstag, 5. September 2009, Alan Chandler wrote:
> The problem comes when I want to now merge back further work that I did
> on the master branch (the 5-6 transition) to the fan club site
>
>
>         2' - 2a - 3' - 4' ----------------- 6' SITE
>        /         /    /                    /
> 1 -  2  ------ 3  - 4  ------------6'''- 6a TEST
>                       \            /
>                         5  ------ 6  MASTER
>                          \         \
>                            5''- 5a- 6'' DEMO
>
>
> What will happen is the changes made in 4->5 will get applied to the
> (now) Test branch as part of the 6->6'' merge, and I will be left having
> to add a new commit, 6a, to undo them all again.  Given this is likely
> to be quite a substantial change I want to try and avoid it if possible.
>
> Is there any way I could use git to remember the 4->5 transition,
> reverse it and apply it back to the Test branch before hand.

Basically, your mistake was to rename master to test and continue development 
on the demo branch. So what you should do instead is this:

        2' - 2a - 3' - 4' ------ 6' SITE
       /         /    /         /
1 -  2  ------ 3  - 4  ------- 6  MASTER
                      \         \
                        5 - 5a - 6'' DEMO

IOW, you keep developing on master, and merge that into the two deployment 
branches.

In practice, it may be easier to develop commit 6 on DEMO (because you can 
debug it more easily, or for similar reasons), but then you should rebase it 
back to MASTER, reset DEMO back to 5a, and finally merge MASTER into DEMO.

-- Hannes
