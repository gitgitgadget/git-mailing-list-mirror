From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: Multiple remote.<...>.fetch and .push patterns
Date: Tue, 01 Jul 2008 11:00:54 +0200
Message-ID: <g4croa$3eu$1@ger.gmane.org>
References: <308083c30806301158i1100c84dqe7f50daad417934c@mail.gmail.com>	 <48693434.4090402@freescale.com> <308083c30806301252l25f072anafbc457f48c6b19e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 11:03:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDbkY-0004nz-Cm
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 11:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088AbYGAJBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 05:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754094AbYGAJBJ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 05:01:09 -0400
Received: from main.gmane.org ([80.91.229.2]:37582 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754087AbYGAJBI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 05:01:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KDbjW-0008JI-GY
	for git@vger.kernel.org; Tue, 01 Jul 2008 09:01:06 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Jul 2008 09:01:06 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Jul 2008 09:01:06 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <308083c30806301252l25f072anafbc457f48c6b19e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87010>

Adr3nal D0S venit, vidit, dixit 30.06.2008 21:52:
> In reference to my question about .git/remotes/ko, Jon Loeliger
> <jdl@freescale.com> wrote:
> 
>> You can have both Push: and Pull: lines for a remote there.
>>
>> Or have I misunderstood your question here?
> 
> I know that I can create files in .git/remotes that look like Linus'
> ko sample.  But I was wondering if this could be done with git-config.
>  I have some developers that are new to SCMs in general and git in
> particular. They are a little nervous playing in the git directory.
> 
> Also, I was uncertain how settings in .git/remotes files interact with
> git-config ...fetch and ...push settings, if at all.

The files under remotes are the old way of configuring remotes (see git 
help push). The new are config lines in the remotes section, as written 
by "git remote". I don't think "git remote" can write the lines you 
want, so I'd suggest:

git config remote.ko.url kernel.org:/pub/scm/git/git.git
git config remote.ko.fetch refs/heads/master:refs/tags/ko-master
git config --add remote.ko.fetch refs/heads/next:refs/tags/ko-next
git config --add remote.ko.fetch refs/heads/maint:refs/tags/ko-maint

You can add similar lines for push with the key remote.ko.push. Note 
that you have to use "--add" if you want to have multiple lines for the 
same key in config. Also, you can add a "+" in front of the refspec, but 
I'm a bit surprised you want that on pushing to ko.

Cheers,
Michael
