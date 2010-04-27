From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git and cvsimport
Date: Tue, 27 Apr 2010 09:37:52 +0200
Message-ID: <4BD69450.8040608@drmicha.warpmail.net>
References: <i2l717f7a3e1004260727wd87900a5tcfb61a3142d0ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marin Atanasov <dnaeon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 09:38:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6fMp-00005m-A3
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 09:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156Ab0D0Hh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 03:37:57 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:38760 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752656Ab0D0Hh4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Apr 2010 03:37:56 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 58D01EFEB2;
	Tue, 27 Apr 2010 03:37:55 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 27 Apr 2010 03:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=/K7WYirxrf/cAWaCc+NOYVZR534=; b=a3LH2Gg8xeKRvaa4W85lW5wkgsPF9CgX4CnXij55cv4Id4Ne9Vxa1bP+QEeTAnJ/wJF8QT2OPxbLquXOQOMJegFlfZqtVaqU4/cA7AvpLtsebGRaGy/ZJmUniccrswsELCmzFKizOfKdvt3E7qsolw2zGp/Nc8XXeuEyV5g7zXA=
X-Sasl-enc: bDlKD9kW7zITGtj5P/zOqD2znGtMeuuxC37mBwjl06wj 1272353874
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1A7A44C63F5;
	Tue, 27 Apr 2010 03:37:53 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100426 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <i2l717f7a3e1004260727wd87900a5tcfb61a3142d0ba@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145880>

Marin Atanasov venit, vidit, dixit 26.04.2010 16:27:
> Hello,
> 
> I need to import an existing CVS repo to Git. Using git-cvsimport
> works well for me when importing from the CVS server itself, but I
> need to do something different.
> 
> Here's a little info about what I'm doing.
> 
> $ pwd
> /home/<user>/test
> 
> $ git --version
> git version 1.5.6.5
> 
> $ git cvsimport -v -d :pserver:<user>@<server>:/var/
> cvsroot -C test.git test-repo
> Initialized empty Git repository in /home/<user>/test/test.git/.git/
> Running cvsps...
> connect error: Network is unreachable
> cvs rlog: Logging test-repo
> Fetching file1   v 1.1
> New file1: 14 bytes
> Fetching file2   v 1.1
> New file2: 14 bytes
> Fetching file3   v 1.1
> New file3: 14 bytes
> Tree ID bf675ce25c8ca3fd1f4a120ea933510c90ccda16
> Parent ID (empty)
> Committed patch 1 (origin +0000 2010-04-26 09:40:58)
> Commit ID 377641eae81975e214a579da9e6c0c5afd819b17
> Created tag 'SOMETAG' on 'origin'
> Fetching file1   v 1.2
> Update file1: 47 bytes
> Fetching file3   v 1.2
> Update file3: 47 bytes
> Tree ID 10ab70cdcc53bb94684d09e60817bb62cb8c3d98
> Parent ID 377641eae81975e214a579da9e6c0c5afd819b17
> Committed patch 2 (origin +0000 2010-04-26 09:44:22)
> Commit ID fea2a99c906e57df5c4735ba3f9627cbb8fba295
> DONE; creating master branch
> 
> The above commands works fine, when I directly get the files from the
> CVS server, but I want to do the following.
> 
>  - checkout files from CVS, which are already tagged with certain
> names to a local folder
>  - then import those files to Git with git-cvsimport
>  - fetch those imports later by a shared bare repo into different
> branches, so at the end each branch will contain the files with the
> certain tag.
> 
> So, If i do the following, then git-cvsimport fails:
> 
> $ pwd
> /home/<user>/test
> 
> $ cvs -d :pserver:<user>@<server>:/var/cvsroot co -r SOMETAG test-repo
> cvs checkout: Updating test-repo
> U test-repo/file1
> U test-repo/file2
> U test-repo/file3
> 
> $ git cvsimport -v -d /home/<user>/test -C test.git test-repo
> Expected Valid-requests from server, but got: E Cannot access
> /home/<user>/test/CVSROOT
> 
> Can you give me some hints how to do this? Seems that I can import CVS
> repos from remote server, but cannot do this from a local folder..

... because a folder is not a server, and a cvs checkout is not a cvs repo.

It's not completely clear to me what you want and why, but the simplest
way seems to be to checkout each cvs tag using cvs, and (add &) commit
the result to the git branch of your choice using git. You don't seem to
want to convert the cvs repo, so don't use git cvs-import.

But, really, I don't know what you want - history-less git branches from
cvs tags?

Michael
