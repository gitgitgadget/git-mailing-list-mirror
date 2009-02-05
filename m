From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: "git revert" feature suggestion: revert the last commit to a
 file
Date: Thu, 05 Feb 2009 13:03:20 -0800
Organization: YPO4
Message-ID: <498B5418.4050103@xenotime.net>
References: <20090205202104.GA11267@elte.hu> <7vvdrobobc.fsf@gitster.siamese.dyndns.org> <498B51E8.8030801@xenotime.net> <20090205210055.GC21500@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Feb 05 22:05:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVBPD-0005DK-0c
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 22:05:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbZBEVDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 16:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753562AbZBEVDO
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 16:03:14 -0500
Received: from xenotime.net ([72.52.64.118]:33512 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752268AbZBEVDN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 16:03:13 -0500
Received: from ::ffff:71.117.247.66 ([71.117.247.66]) by xenotime.net for <git@vger.kernel.org>; Thu, 5 Feb 2009 13:03:09 -0800
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
In-Reply-To: <20090205210055.GC21500@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108623>

Ingo Molnar wrote:
> * Randy Dunlap <rdunlap@xenotime.net> wrote:
> 
>> Junio C Hamano wrote:
>>> Ingo Molnar <mingo@elte.hu> writes:
>>>
>>>> So i have to do something like:
>>>>
>>>>    git revert $(git log -1 --pretty=format:"%h" kernel/softlockup.c)
>>>>
>>>> (tucked away in a tip-revert-file helper script.)
>>>>
>>>> But it would be so much nicer if i could do the intuitive:
>>>>
>>>>    git revert kernel/softlockup.c
>>>>
>>>> Or at least, to separate it from revision names cleanly, something like:
>>>>
>>>>    git revert -- kernel/softlockup.c
>>> All three shares one issue.  Does the syntax offer you a way to give
>>> enough information so that you can confidently say that it will find the
>>> commit that touched the path most recently?  How is the "most recently"
>>> defined?
>>>
>>> At least you can restate the first one to:
>>>
>>>     git revert $(git log -1 --pretty=format:"%h" core/softlockup -- kernel/softlockup.c)
>>>
>>> to limit to "the one that touched this file _on this topic_".
>>>
>>>> Would something like this be possible in generic Git? It would sure be a 
>>>> nice little touch that i would make use of frequently.
>>>>
>>>> Or is it a bad idea perhaps? Or have i, out of sheer ignorance, failed to 
>>>> discover some nice little shortcut that can give me all of this already?
>>> The closest I can think of is
>>>
>>> 	git revert ':/the title of the commit'
>>>
>>> but it shares the exact same issue of "how would I limit the search space
>>> to make sure it finds the right commit".
>> And it should revert whatever commit is the last/most recent to the 
>> currently used file, i.e., not always revert the same commit.
> 
> i'm not sure i understand, what do you mean precisely?

Just that someone should be able to use "git revert <filename>" on the
same file more than one time and git will revert <last> then <last-1> then
<last-2> etc...

Or it will always revert <last>, where <last> is relative to the currently
used version of the file.

Does that help?

~Randy
