From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: gitignore: negating path patterns
Date: Fri, 23 May 2008 09:52:19 +0200
Message-ID: <g15t3j$eoa$1@ger.gmane.org>
References: <g11cvn$ndr$1@ger.gmane.org> <5BBB5607-DF95-4C06-BE6C-C3D7AF475FBF@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 09:53:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzS5h-0002GB-Qi
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 09:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123AbYEWHwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 03:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754009AbYEWHwh
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 03:52:37 -0400
Received: from main.gmane.org ([80.91.229.2]:51997 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753966AbYEWHwh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 03:52:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JzS4k-0008Ou-Ug
	for git@vger.kernel.org; Fri, 23 May 2008 07:52:30 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 May 2008 07:52:30 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 May 2008 07:52:30 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <5BBB5607-DF95-4C06-BE6C-C3D7AF475FBF@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82689>

Kevin Ballard venit, vidit, dixit 23.05.2008 02:23:
> On May 21, 2008, at 7:52 AM, Michael J Gruber wrote:
> 
>> Hi there
>>
>> It seems that negating path patterns in gitignore doesn't work, or I
>> don't understand it (or both). With the attached script, git status
>> (1.5.5.1) reports "dir/a" as new and "dir/b" as untracked. I would
>> rather expect it to report "dir/c" as untracked also.
>>
>> It seems that "!b" matches to include "dir/b" (reverting the exclusion
>> "*" as expected), whereas "!dir/" does not match to include "dir/c".
>>
>> What's going on here?
> 
> "dir/" will not match anything, because paths are compared without  
> trailing slashes. Try "!dir".
> 

I am sorry, but this is plain wrong, at least if "man gitignore" is 
right (see below). "!dir" would match files whose name (pathname without 
leading directory name) matches "dir" (i.e.: is dir) and exclude those 
from exclusion (include them).

Also, replacing "!dir/" by "!dir" in my test script does not change the 
result. In fact, for "!dir" the result is as expected and documented, 
just for "!dir/" I would expect something else.

So, thanks for trying to help, although reading the manual or testing 
your advice before would be appreciated even more. ;)

Michael

 From man gitignore:

If the pattern ends with a slash, it is removed for the purpose of the 
following description, but it would only find a match with a directory. 
In other words, foo/ will match a directory foo and paths underneath it, 
but will not match a regular file or a symbolic link foo (this is 
consistent with the way how pathspec works in general in git).
