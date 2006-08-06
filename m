From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-diff between /dev/null and blob
Date: Sun, 06 Aug 2006 23:02:33 +0200
Organization: At home
Message-ID: <eb5ld6$36k$1@sea.gmane.org>
References: <eajl4r$b7o$1@sea.gmane.org> <7vmzaq9sjs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Aug 06 23:03:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9plu-0006Xe-Di
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 23:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWHFVCu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 17:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWHFVCu
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 17:02:50 -0400
Received: from main.gmane.org ([80.91.229.2]:26081 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750711AbWHFVCu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Aug 2006 17:02:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G9pli-0006Vh-1i
	for git@vger.kernel.org; Sun, 06 Aug 2006 23:02:42 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Aug 2006 23:02:42 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Aug 2006 23:02:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24990>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Currently, due to artifact of git-diff argument parsing you can get diff 
>> of two arbitrary blobs given by their sha1 id, e.g.
>>   git diff ab8050ceb4e43522e858768cc2c02fcb91839370 fd05278808d458602587bb024a48726018d30926
> 
> Just FYI, it is pretty much by design not artifact to allow
> something like this:
> 
>       git diff master:Makefile next:Makefile

Which we could get using

        git diff master next -- Makefile

Currently ('next' branch) git-diff manpage talks only about comparing trees.

* When  no  <ent>  is given, the working tree and the index file is compared,
  using git-diff-files.

* When one <ent> is given, the working tree and the named tree  is  compared,
  using git-diff-index. The option --cached can be given to compare the index
  file and the named tree.

* When  two  <ent>s  are  given,  these  two   trees   are   compared   using
  git-diff-tree.

And the only way to compare blobs is by giving directly or indirectly 
(like above) sha1 of the blobs, i.e. only the third case is supported. 

git-diff doesn't understand :<stage>:<filename> and :<filename> for
accessing index version of blob (git-cat-file for example understands
it). Note: <filename> in <revision>:<filename> and <stage>:<filename>
must be wrt GIT_DIR.

It is also no way to specify working tree version of file (blob). We 
could use ::<filename> for that, I think...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
