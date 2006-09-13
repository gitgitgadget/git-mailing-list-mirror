From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Marking abandoned branches
Date: Wed, 13 Sep 2006 18:12:13 +0200
Organization: At home
Message-ID: <ee9akc$d62$1@sea.gmane.org>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com> <20060913152451.GH23891@pasky.or.cz> <9e4733910609130859v347a7a9ew5c3ebc982bf9b07b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 13 18:14:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNXMl-0002I5-By
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 18:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWIMQNM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 12:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWIMQNM
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 12:13:12 -0400
Received: from main.gmane.org ([80.91.229.2]:65237 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750977AbWIMQNK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 12:13:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GNXLv-000268-Q1
	for git@vger.kernel.org; Wed, 13 Sep 2006 18:12:43 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 18:12:43 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 18:12:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26920>

Jon Smirl wrote:

> On 9/13/06, Petr Baudis <pasky@suse.cz> wrote:
>> Dear diary, on Wed, Sep 13, 2006 at 05:17:59PM CEST, I got a letter
>> where Jon Smirl <jonsmirl@gmail.com> said that...
>> > Abandoned branches are common in CVS since it is not distributed.
>> > People start working on something in the main repo and then decide it
>> > was a bad idea. In the git world these branches usually don't end up
>> > in the main repo.
>>
>> Can't you just toss the branch away in that case? :-)
> 
> It is a historical import. Everything that was in the initial repo
> needs to be preserved otherwise they aren't going to get rid of the
> old CVS repo.

You can leave this in historical repository, and strip current repository
from abandoned work, by the way.

>> You could also stash the ref to refs/heads-abandoned/ instead of
>> refs/heads/ if you want to keep the junk around for some reason. Of
>> course you don't get the nice marker with explanation of why is this
>> abandoned and who decided that, but you can just use an empty commit for
>> the same purpose.
> 
> If this is done with an object there should probably be some way to
> encode it into the existing commit object.

As it was said somewhere in this thread, you can use tags (tag objects) for
that, i.e. tag each of the abandoned branches, explaining why branch wa
abandoned for example, remove head refs, and move tag refs to
refs/abandoned or refs/tags-abandoned/ or refs/Attic/ or in refs-abandoned/
(the last has the advantage to not be included by default in any command,
even when --all is given)
 
> Moving the refs into refs/abandoned would work too. We would need new
> git commands to do this and flags on the visualization tools to
> include the abandoned branches. On the other hand doing this is
> recording state about the repository in the refs directory instead of
> writing this state into the repo itself.

There is no need for new flag. If you give --all flag to the gitk command
line or the list of commits option field, all the refs in $GIT_DIR/refs/
would be included. If you will use refs-abandoned/ instead, it would be
enough I guess to give refs-abandoned/ or refs-abandoned/*. Of course you
would need some change to visualisers to mar abandoned branches in
different way.

gitweb as of now uses only refs/heads and refs/tags; markers are taken from
$GIT_DIR/info/refs or "git-ls-remotes ." (i.e. all refs/)
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
