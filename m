From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Use File::Find::find in git_get_projects_list
Date: Thu, 14 Sep 2006 20:43:29 +0200
Organization: At home
Message-ID: <eec7rp$vjd$1@sea.gmane.org>
References: <200609140839.56181.jnareb@gmail.com> <7v8xkm6gr6.fsf@assigned-by-dhcp.cox.net> <200609140959.04061.jnareb@gmail.com> <7v1wqe6buv.fsf@assigned-by-dhcp.cox.net> <7vbqpi47vi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Sep 14 20:43:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNwBl-0006Hn-T2
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 20:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWINSnv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 14:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWINSnv
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 14:43:51 -0400
Received: from main.gmane.org ([80.91.229.2]:37579 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751017AbWINSnu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Sep 2006 14:43:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GNwBL-0006Dc-Pw
	for git@vger.kernel.org; Thu, 14 Sep 2006 20:43:27 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 20:43:27 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 20:43:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27025>

Junio C Hamano wrote:

> Side note:
> 
> While
> 
>       return unless -d $_
> 
> there is definitely more correct than "return unless -d _" which
> is not, it is not the most efficient.  Because you use fast_xxx,
> you know the last stat was lstat so "-d _" would be true if the
> thing you are looking at is a real directory and will be a
> zero-cost operation.  The only case you want to be careful is a
> symlink pointing at a directory, so
> 
>       return unless ((-d _) || (-l _ && -d $_))
> 
> would be more efficient.
> 
> I have a strange suspicion that Merlyn will soon join us with
> more expertise if we keep talking about Perl ;-)

Truth to be told, I didn't know about '-d _', and File::Find(3pm) 
does talk only about $_.

Besides, I guess that the possible speedup is negligible, and of 
course depend if for example the whole $projectroot aka. $projects_list
is for example populated by symlinks. Then it would be slower.

This is the place where more readable should win.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
