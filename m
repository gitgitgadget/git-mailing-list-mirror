From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] Fall back to three-way merge when applying a patch.
Date: Thu, 06 Oct 2005 08:52:33 -0600
Message-ID: <m1wtkqk89a.fsf@ebiederm.dsl.xmission.com>
References: <7vd5mk7pv6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510042155090.31407@g5.osdl.org>
	<7vslvg1mcs.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510050725510.31407@g5.osdl.org>
	<7vslvfcy0g.fsf@assigned-by-dhcp.cox.net>
	<m1mzln9zi1.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0510051909390.31407@g5.osdl.org>
	<m1y8575i9y.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0510060731560.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 16:58:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENX8P-00008m-4H
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 16:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbVJFOyJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 10:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbVJFOyJ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 10:54:09 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29833 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751065AbVJFOyH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2005 10:54:07 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j96EqYBH023382;
	Thu, 6 Oct 2005 08:52:34 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j96EqXdS023381;
	Thu, 6 Oct 2005 08:52:33 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510060731560.31407@g5.osdl.org> (Linus
 Torvalds's message of "Thu, 6 Oct 2005 07:35:58 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9772>

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 5 Oct 2005, Eric W. Biederman wrote:
>>
>> Ah.  I had missed that git-whatchanged can be given a filename that is
>> nice.  One of the better kept secrets of git.  That makes my whole
>> question worthwhile :)
>
> That's definitely not a secret - it was part of the whole point of 
> git-whatchanged. It's the native git version of "annotate", and I 
> personally find it much more useful.
>
> It's not even just a filename. You can do
>
> 	git-whatchanged -p drivers/scsi/ include/scsi
>
> to limit the set to those two subdirectories. IOW, you can give 
> git-whatchanged an arbitrary list of individual pathnames or directory 
> names.

Which probably means it's time for me to generate a patch to the
git-whatchanged documentation.

>> But if you happen to have at least the file level sha1 you can
>> actually know if the patch was against what you think it is against.
>
> Yes, a file-level SHA1 may be useful. On the other hand, I suspect that by 
> that time (since you have to search for the version anyway) you might as 
> well have the "just try to apply the patch" approach. It's basically the 
> same search space.

Maybe.

After thinking about it I don't think you need to look through the
history to use it for a merge3 operation.   As I recall merge3 only
looks at the base and the two derived versions of the file.  If we
have the sha1 of the original in the git repository I think all we
need to compute is the diff between that sha1 the current version
file.  And then apply the merge3 algorithm to combine the two sets of
changes.


Eric
