From: Daniel Drake <dsd@gentoo.org>
Subject: HTTP repo referencing stale heads (can't clone)
Date: Mon, 03 Apr 2006 17:01:48 +0100
Message-ID: <443146EC.7060704@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Apr 03 17:50:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQRK2-0007K7-N5
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 17:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbWDCPu1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 11:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbWDCPu1
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 11:50:27 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:42340 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751744AbWDCPu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Apr 2006 11:50:26 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com with ESMTP
          id <20060403155025.KTHY29040.mtaout02-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>
          for <git@vger.kernel.org>; Mon, 3 Apr 2006 16:50:25 +0100
Received: from [192.168.0.2] (really [86.14.216.162])
          by aamtaout03-winn.ispmail.ntl.com with ESMTP
          id <20060403155024.OLSJ16286.aamtaout03-winn.ispmail.ntl.com@[192.168.0.2]>
          for <git@vger.kernel.org>; Mon, 3 Apr 2006 16:50:24 +0100
User-Agent: Mail/News 1.5 (X11/20060401)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18340>

Hi,

I maintain a small git repo. I upload it over ssh (with git-push) to a 
machine where it is distributed over http:

http://dsd.object4.net/git/zd1211.git/

For some reason it is no longer possible to clone this repo over http:

walk 35afe6b3a859242a18812e7485ea8b211e24abaf
walk 93d9a9f469282e1e392c16ce571da4c08805e8bb
error: Couldn't get 
http://dsd.object4.net/git/zd1211.git/refs/heads/softmac-old for 
heads/softmac-old
The requested URL returned error: 404
error: Could not interpret heads/softmac-old as something to pull

"softmac-old" is an old branch, which I have recently deleted. I deleted 
it by removing the .git/refs/heads/softmac-old file, and relying on 
git-prune to clear out old objects.

Even on the server-side, there is no obvious reference to this old head:

$ find -name '*softmac*'
$ grep -R softmac *
(no results for either)

"git-fsck-objects" reports nothing, "git-fsck-objects --full" reports:
dangling commit 7cc423c942975005f96f308186537ad6e7808c2e
dangling commit b36378de6231f1b5100b1517b9c8c243a21090fd

I have tried running git-prune and git-update-server-info, but that 
doesn't help.

Any ideas? I'm still new to git.
I am running git-1.2.4

Thanks,
Daniel
