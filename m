From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
Subject: Re: Correct way of making existing remote repository "bare"
Date: Wed, 15 Jul 2009 16:12:42 +0200
Message-ID: <4A5DE3DA.1010004@dirk.my1.cc>
References: <h3khis$3tq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 16:16:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR5HP-0007bo-5W
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 16:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028AbZGOOP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 10:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754813AbZGOOPG
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 10:15:06 -0400
Received: from smtprelay07.ispgateway.de ([80.67.31.30]:44024 "EHLO
	smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443AbZGOOPE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 10:15:04 -0400
Received: from [84.176.68.208] (helo=[192.168.2.100])
	by smtprelay07.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1MR5Dv-0003YJ-FG; Wed, 15 Jul 2009 16:12:44 +0200
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <h3khis$3tq$1@ger.gmane.org>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123311>

Am 15.07.2009 14:20 schrieb Graeme Geldenhuys:
> Hi,
> 
> Yesterday I initialized a new repository on our server. I did some 
> coding locally, added the remote server (git remote add ....) and then 
> pushed my changes to the remote server.
> 
> But I noticed that my remote server is not a "bare" repository and git 
> complains when I push to it again. What is the correct way to make an 
> existing remote repository bare?
> 
> This is what I did and it worked, but not sure if this is the correct 
> way of doing it.
> 
> Steps I done:
> 
> * ssh to remote server
> * git clone --bare -l <path_to_repos> <new_dir>
> * renamed old repository directory
> * renamed new repository dir to what old repository used to be.
> 
> Like I said, this did the tick, but is this the correct way of doing it?
> 
> 
> Regards,
>   - Graeme -
> 

Sounds like that's the correct way. I sometimes faced the same problem 
and was lazy:

$ ssh to the remote && cd repo
$ rm everything except for the .git directory (make sure everything is 
committed before doing this)
$ mv .git/* . && rmdir .git # i.e.move the .git contents one level up
$ edit config
change 'core.bare=false' to 'core.bare=true' (or add a similar line)

done.

I think what you did is 'porcellain' while my solution is 'plumbing'.
Any complaints?

     Dirk
