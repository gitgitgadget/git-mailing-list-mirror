From: David Kastrup <dak@gnu.org>
Subject: Re: How do I manage this setup with git-svn and/or git remotes?
Date: Sat, 18 Aug 2007 09:07:23 +0200
Message-ID: <85643dwcb8.fsf@lola.goethe.zz>
References: <86y7gaxef5.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0708171042570.30176@woody.linux-foundation.org>
	<86d4xmxbjf.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0708171142510.30176@woody.linux-foundation.org>
	<7vvebdg8r5.fsf@gitster.siamese.dyndns.org>
	<85mywpx2wl.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 18 09:07:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMIPf-00048G-AG
	for gcvg-git@gmane.org; Sat, 18 Aug 2007 09:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbXHRHHe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Aug 2007 03:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbXHRHHe
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Aug 2007 03:07:34 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:45909 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751877AbXHRHHd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Aug 2007 03:07:33 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id DEECA1336D;
	Sat, 18 Aug 2007 09:07:31 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id CC87C2130E6;
	Sat, 18 Aug 2007 09:07:31 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-041-107.pools.arcor-ip.net [84.61.41.107])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 6E5823425E7;
	Sat, 18 Aug 2007 09:07:27 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 0A5E31C36605; Sat, 18 Aug 2007 09:07:23 +0200 (CEST)
In-Reply-To: <85mywpx2wl.fsf@lola.goethe.zz> (David Kastrup's message of "Fri\, 17 Aug 2007 23\:32\:58 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3978/Sat Aug 18 06:51:41 2007 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56102>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>>
>> My reading of the project David is talking about is that its dsp
>> project which is a "subproject" part gets non generic commits within
>> the context of the superproject --- which means (1) you would have
>> branches in the subproject not superproject, and (2) once you did
>> that, the subproject is not really a subproject anymore, as you
>> cannot merge that back to the standalone dsp project without
>> dragging the non-generic bits along with it.
>
> Ok, I should perhaps should not make things harder than they are: the
> superprojects, being particular to one customer each, don't really
> branch (except that git-svn makes a git branch from every Subversion
> tag).  The subproject is the one that has considerable branching and
> merges.  What usually gets pulled into the superproject is a copy of a
> stable subproject branch.  Once this copy is in, only fixes (from the
> stable branch) or features (from the development branch) that the
> customer definitely needs are merged into the superproject.  While
> there might happen some subproject work in the customer branch, this
> mostly happens during bugfixing for the customer, and the changes are
> typically pulled back into the subproject proper at some point of
> time.  Inside of the subproject tree, there is really no superproject
> _development_ going on.

I think I got it.  My mistake was focusing all the time what I could
do with the git repository of "great" to facilitate two-way merges.

Instead I need to import great/trunk/dsp into a remote branch in my
_dsp_ git repository.  Since for git-svn, every Subversion directory
is as good to import as any other (there is no concept of a worktree
root in the repository) that should be all it takes.

I'll need to use the dsp repository when doing merge work, but apart
from that, I can work in the great repository r/w even while in the
dsp subdirectory.

If one could tell git in a remote section to
fetch/consider/synchronize/push just a subdirectory as the repo root,
then the same setup for bidirectional merges could be made to work
with projects like gitk.  Though I am fuzzy about the merge
information...  But that is a problem when pushing merges with private
branches, anyway, isn't it?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
