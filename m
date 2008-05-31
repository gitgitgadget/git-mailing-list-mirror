From: david@lang.hm
Subject: Re: unable to push
Date: Sat, 31 May 2008 09:10:26 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0805310855000.15294@asgard.lang.hm>
References: <alpine.DEB.1.10.0805310759540.15294@asgard.lang.hm> <20080531155036.GA27397@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 31 18:11:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2TgI-00013B-6U
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 18:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754310AbYEaQK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 12:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754295AbYEaQK4
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 12:10:56 -0400
Received: from mail.lang.hm ([64.81.33.126]:49890 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754289AbYEaQKY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 12:10:24 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m4VGAEKm026893;
	Sat, 31 May 2008 09:10:14 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20080531155036.GA27397@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83394>

On Sat, 31 May 2008, Jeff King wrote:

> On Sat, May 31, 2008 at 08:03:47AM -0700, david@lang.hm wrote:
>
>> for some reason when I try to push to my public repo I get a message that
>> everything is up to date, but if I switch to that repo and do a pull it
>> updates properly
>
> If you "git push" without a refspec, it pushes "matching branches". See
> git-push(1) for more details.
>
>> root@asgard:/var/www/adastra/xml2pdf/current# git ls-remote public
>> d3f3d8474db1c006a53be8b5f5c1a0d866d7e357        HEAD
>> d3f3d8474db1c006a53be8b5f5c1a0d866d7e357        refs/heads/localmaster
>
> So you have only one branch, "localmaster".
>
>> root@asgard:/var/www/adastra/xml2pdf/current# git ls-remote .
>> 71ab4eea48eb3407a2ff4eef2befe9251897d676        HEAD
>> 71ab4eea48eb3407a2ff4eef2befe9251897d676        refs/heads/master
>
> But the remote has only one branch, "master".
>
> If you want to push your localmaster to his master, you can do:
>
>  git push origin localmaster:master
>
> You can also set it up permanently by adding a "remote.origin.push" line
> to your config file.
>
> But I do wonder why you don't just name your local branch "master" in
> the first place (it won't conflict in your local repo with the remote's
> master, which can be named as "origin/master").

I created localmaster in an attempt to get things working again. I'll try 
creating a new master branch... that does make it work again, thanks.

what I'm not understanding completely is how I broke things in the first 
place.

going back through .git/logs/HEAD it looks like I did a checkout HEAD^^^ 
and never properly recovered. should I have done a checkout master to get 
things back on track? I had thought that I could do a checkout of an old 
version, modify it, do a commit, and the commit would go on top of the old 
HEAD and I could just keep going (the reason for doing this instead of a 
reset is that I had already published the intermediate commits to the 
public repo, so I didn't want to roll back the history, just get the old 
version of one of the files)

>> root@asgard:/var/www/git/xml2pdf.git# git pull
>> remote: Counting objects: 8, done.
>> remote: Compressing objects: 100% (6/6), done.
>> remote: Total 6 (delta 4), reused 0 (delta 0)
>> Unpacking objects: 100% (6/6), done.
>> From /movies/www/adastra/xml2pdf/current/
>>    d3f3d84..71ab4ee  master     -> origin/master
>>  * [new tag]         1.8.5      -> 1.8.5
>> Updating d3f3d84..71ab4ee
>> Fast forward
>>  xml2pdf.pl |   22 +++++++++++-----------
>>  1 files changed, 11 insertions(+), 11 deletions(-)
>
> And this pulls from master -> localmaster, presumably because you have a
> branch.localmaster.merge config option (which is generally set up by
> default these days).

I manually setup the localmaster when I was having trouble getting things 
to work in either direction.

David Lang
