From: <osv@javad.com>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Tue, 13 Nov 2007 20:58:20 +0300
Message-ID: <87d4ue81tv.fsf@osv.gnss.ru>
References: <874pfq9q8s.fsf@osv.gnss.ru> <200711131703.16357.jnareb@gmail.com>
	<A919E788-C5D0-4404-95D4-869BAFE868AC@zib.de>
	<200711131842.03622.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 18:59:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is02h-0000jQ-V5
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 18:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758292AbXKMR6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 12:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756394AbXKMR6f
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 12:58:35 -0500
Received: from javad.com ([216.122.176.236]:3004 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756564AbXKMR6e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 12:58:34 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lADHwS042361;
	Tue, 13 Nov 2007 17:58:28 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1Is01k-0004lL-7C; Tue, 13 Nov 2007 20:58:20 +0300
In-Reply-To: <200711131842.03622.jnareb@gmail.com> (Jakub Narebski's message of "Tue\, 13 Nov 2007 18\:42\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64819>

Jakub Narebski <jnareb@gmail.com> writes:
> Steffen Prohaska wrote:
>> On Nov 13, 2007, at 5:03 PM, Jakub Narebski wrote:
>>> Sergei Organov <osv@javad.com> wrote:
>
>>>> Isn't "git branch -d -r" supposed to do whatever magic is required to
>>>> get rid of the remote branch? Currently it seems like a bug  
>>>> introduced by addition of wildcards refspecs, right?
>>>
>>> No, the '-r' part translates 'pu' into 'refs/remotes/origin/pu', and
>>> the '-d' option removes branch locally. It is meant I think to remove
>>> tracking of branches which were dropped in remote, as I think that
>>> wildcard refspec does create new branches, but do not delete dropped
>>> branches.
>> 
>> "git remote prune origin" should be used to clean up stale
>> remote-tracking branches.
>
> "git remote prune <name>" deletes _all_ stale tracking branches
> under <name>. With "git branch -d -r <branch>" you can delete
> _single_ tracking branch.
>
>>> So I'm not sure if it is a bug, misfeature or a feature.
>> 
>> It doesn't make sense to delete remote-tracking branches
>> locally if they are still present at the remote.  The main
>> purpose of a remote-tracking branch is to be identical to the
>> real remote branch.
>
> True, but it would be nice to have an option to _exclude_ some
> branches from fetching (for example 'html' and 'man' branches
> of git.git), while still picking up new branches automatically
> on fetch.

Guys, could you please read man git-branch? What do you think this
example is doing?:

<quote Documentation/git-branch.txt>
Delete unneeded branch::
+
------------
$ git clone git://git.kernel.org/.../git.git my.git
$ cd my.git
$ git branch -d -r origin/todo origin/html origin/man   <1>
$ git branch -D test                                    <2>
------------
+
<1> Delete remote-tracking branches "todo", "html", "man"
</quote>

That's *exactly* what I did! And it *doesn't work*! Well, it does delete
the branches, but they are automagically re-created on the next fetch,
so "deleting" them this way is useless.

-- 
Sergei.
