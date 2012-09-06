From: Richard Browne <richard@timestone.com.au>
Subject: Re: stash -u deletes ignored files
Date: Thu, 6 Sep 2012 10:19:48 +1000
Message-ID: <0C1F1C86-DFCA-46B6-984A-6FFB82D12A3D@timestone.com.au>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1486\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: kiselevma@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 03:20:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9QlE-0001xl-N5
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 03:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760125Ab2IFBTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 21:19:53 -0400
Received: from aussie57.lnk.telstra.net ([139.130.97.98]:58538 "EHLO
	timestone.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754639Ab2IFBTw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Sep 2012 21:19:52 -0400
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Sep 2012 21:19:52 EDT
X-Vipre-Scanned: 571DB341003282571DB48E-TDI
Received: from [59.167.177.11] (account richard@timestone.com.au HELO [192.168.0.2])
  by timestone.com.au (CommuniGate Pro SMTP 5.4.5)
  with ESMTPSA id 9468927; Thu, 06 Sep 2012 10:19:38 +1000
X-Mailer: Apple Mail (2.1486)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204851>

We have been bitten by this bug too. git stash -u is deleting ignored files.

> There seems to a bug in git stash. Subfolders with ignored files are
> deleted if the subfolders themselves are not ignored.
> 
> How to reproduce.
> ---
> mkdir TestRepo
> cd TestRepo
> mkdir Ignored
> echo " " > Ignored/Ignored.txt
> echo "Ignored/Ignored.txt" > .gitignore
> echo > File1.txt
> git init
> git add .
> git commit --message="Initial commit"
> echo "Test change" > File1.txt
> git stash -u
> git stash pop
> 
> Expected result:
> Ignored/Ignored1.txt is present in the repository. It is either not
> deleted after stash or at least restored after pop.
> 
> Actual result:
> Ignored is deleted along with any files in it.
> 
> I use git version 1.7.9.msysgit.0
> 
> Sebastian Schuberth could reproduce this as well:
> 
> > I'm able to reproduce this with git version 1.7.10.msysgit.1 as well as
> > on Linux, so please report this upstream to the git mailing list. Thank you.
> 
> Original discussion on msysgit mailing list:
> https://groups.google.com/forum/?fromgroups#!topic/msysgit/FuAh7eXbPSw
> 
> -- 
> Regards,
> Max A. Kiselev
> --
