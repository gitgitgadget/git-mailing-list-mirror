From: Gelonida <gelonida@gmail.com>
Subject: Re: how to delete the entire history before a certain commit
Date: Tue, 04 May 2010 01:11:52 +0200
Message-ID: <hrnl7o$nnf$1@dough.gmane.org>
References: <hrnidr$etm$1@dough.gmane.org> <m3ocgwfvw2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 04 01:12:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O94o7-0001us-GV
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 01:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759743Ab0ECXMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 19:12:05 -0400
Received: from lo.gmane.org ([80.91.229.12]:40500 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759729Ab0ECXMB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 19:12:01 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O94nw-0001rd-BV
	for git@vger.kernel.org; Tue, 04 May 2010 01:12:00 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 May 2010 01:12:00 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 May 2010 01:12:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <m3ocgwfvw2.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146268>

Hi Jakub,

Jakub Narebski wrote:
> Gelonida <gelonida@gmail.com> writes:
> 
>> We have a git repository, whose size we want to reduce drastically due
>> to frequent clone operations and a slow network connection.
>  
> Why frequent *clone* operations, instead of using "git fetch" or
> equivalent ("git pull" which is fetch+merge, or "git remote update")?

The clone is part of the deployment process and would IIRC be equivalent
to a 'svn export'
Almost certainly one can also improve this, but this should probably
discussed in another thread.

The sequence on some remote hosts is.
- git clone tag dirname
- rm -rf dirname/.git
- tar cvfz dirname.tgz dirname


> 
> If network is slow, you can do what others did in similar situations:
> use hook to allow only not to large fetches (to prevent cloning)


> directly on server, and provide bundle (see git-bundle(1)) to "seed"
> the clone; it can be on dumb server (served resumably), and can be
> also served by BitTorrent or equivalent.
The server NW is fast, but the clients' network connection not therefore
no need to offload the server.
>  
>> The idea is following:
>>
>> * archive the git repository just in case we really have to go back in
>> history.
>>
>>
>> create a new git repository, which shall only contain last month's activity.
>>
>> all changes before should be squashed together.
>> It would be no problem if the very first commit remains unmodified.
> 
> If you want to simply _remove_ history before specified commit,
> instead of squashing it, the best solution would be to use grafts to
> cauterize (cut) history, check using [graphical] history viewer that
> you cut it correctly, and then then use git-filter-branch to make this
> cut permanent.

This sounds exactly as what I'd like to do.
I used "git gui" => "Visualize All Branch History" y to choose a nice
single cutoff point.
I just didn't know how to apply the cut.

So the command to look for is git-filter-branch, right ?
I'll read the doc.

> 
> You can later use grafts or refs/replaces/ mechanism to join "current"
> history with historical repository.

Probably we wont need this, but this sounds rather interesting and is
good to know.



Thanks a lot
