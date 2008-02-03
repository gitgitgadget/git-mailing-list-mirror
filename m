From: Wink Saville <wink@saville.com>
Subject: Re: git-svn segmetation fault
Date: Sat, 02 Feb 2008 17:21:59 -0800
Message-ID: <47A51737.7050905@saville.com>
References: <47A39DFD.9020905@saville.com> <47A3BE6F.6080304@saville.com> <20080202034258.GA27814@dervierte> <47A3E9A8.1060102@saville.com> <20080202160332.GA25945@dervierte> <47A4BCE8.5030308@saville.com> <20080202210348.GA11722@dervierte>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 02:22:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLTZR-0002X9-2h
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 02:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbYBCBWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 20:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbYBCBWL
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 20:22:11 -0500
Received: from an-out-0708.google.com ([209.85.132.245]:28337 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbYBCBWD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 20:22:03 -0500
Received: by an-out-0708.google.com with SMTP id d31so400953and.103
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 17:22:02 -0800 (PST)
Received: by 10.100.228.17 with SMTP id a17mr11294464anh.17.1202001722543;
        Sat, 02 Feb 2008 17:22:02 -0800 (PST)
Received: from ?192.168.0.133? ( [70.91.206.233])
        by mx.google.com with ESMTPS id 7sm3091222agc.8.2008.02.02.17.22.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 Feb 2008 17:22:01 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <20080202210348.GA11722@dervierte>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72312>

Steven Walter wrote:
> On Sat, Feb 02, 2008 at 10:56:40AM -0800, Wink Saville wrote:
>   
>> <I did that but a rebase command resulted in: />
>>
>> wink@ic2d1:$ git svn rebase
>> Unable to determine upstream SVN information from working tree history
>>
>> <I've bee using git-svn for a few days without trouble. Do I need
>> the do another "git svn clone" using the base url rather than
>> pointing to the trunk? />
>>     
>
> You shouldn't have to clone again.  First time removing .git/svn, then
> running "git svn fetch" (which ought to rebuild what was there).  You
> ought to be able to rebase after that.
>   
I've messed something up, I've just re-cloned and all is well.

Actually, a related question which you seem to imply from
your answer to the crash. I have the local git repo and also
one on a local server which I created as follows:

local$: git svn clone -s https://async-msgcomp.googlecode.com/svn amc
local$: ssh srvr
srvr$: cd <to local server/path to repo>
srvr$: mkdir amc.git
srvr$: cd amc.git
srvr$: git --bare init --shared
srvr$: exit
local$: cd amc
local$: git remote add origin git:<to local server/path to repo/amc.git>
local$: git push --all



So at this point amc/.git/config looks like:

[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[svn-remote "svn"]
        url = https://async-msgcomp.googlecode.com/svn
        fetch = trunk:refs/remotes/trunk
        branches = branches/*:refs/remotes/*
        tags = tags/*:refs/remotes/tags/*
[remote "origin"]
        url = git://192.168.0.8/amc.git
        fetch = +refs/heads/*:refs/remotes/origin/*
wink@ic2d1:$




I now have three repositories one local git repo, one git repo on srvr
and one svn repo at googlecode.com. I feel really good and backed up
to the max:) But assume the svn repo is huge and the initial git svn
clone takes a long time.

What steps would be needed to recreate a "local git repo" from the
"git repo on srvr" that I could use against the svn repo?

I tried a little test, I cloned my git repo on srvr locally to amc-xx
and added the [svn-remote "svn"] section to amc-xx/.git/config
and then did a git-svn fetch. From what happened it looks like I
just did a git svn clone and didn't save any time.

Also, a follow up can I create an svn repo from a git repo.

Anyway, thanks for the help,

Wink
