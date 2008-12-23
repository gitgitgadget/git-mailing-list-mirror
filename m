From: Johan Herland <johan@herland.net>
Subject: Re: Can `git config` override entries in .gitconfig?
Date: Tue, 23 Dec 2008 18:59:13 +0100
Message-ID: <200812231859.13619.johan@herland.net>
References: <4950D41A.5050009@vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Nicholas LaRoche <nlaroche@vt.edu>
X-From: git-owner@vger.kernel.org Tue Dec 23 19:00:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFBYo-0001VO-Im
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 19:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbYLWR7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 12:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbYLWR7c
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 12:59:32 -0500
Received: from smtp.getmail.no ([84.208.20.33]:45159 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955AbYLWR7b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 12:59:31 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KCC0000TCN5DM00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 23 Dec 2008 18:59:29 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KCC00KVWCMQSU40@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 23 Dec 2008 18:59:14 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KCC00AOUCMPA370@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 23 Dec 2008 18:59:14 +0100 (CET)
In-reply-to: <4950D41A.5050009@vt.edu>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103839>

On Tuesday 23 December 2008, Nicholas LaRoche wrote:
> Is there a direct way to change the user.email entry for a git
> repository for one user (applied to all previous commits)?
>
> I tried `git config --unset user.email` followed by `git config
> user.email email2` but it just sets a second field called user.email
> that shows up in `git config -l` as a duplicate. My ~/.gitconfig file
> contains email1 for the user.email entry.
>
> Also, when the repository is created can I specify a second set of
> contact information (i.e. using a project specific email) which isn't a
> part of ~/.gitconfig?
>
> output of `git config -l`:
> user.email=email1
> ..
> ..
> user.email=email2

Hi,

Use git-config's --global option to set options in your ~/.gitconfig. 
Otherwise, your config changes are stored in the current repo's config 
(.git/config).

In your case, when you did `git config --unset user.email`, you unset the 
(non-existing) user.email in your repo config, without touching the one in 
~/.gitconfig, and when you did `git config user.email email2`, you set 
user.email in the repo config (without changing the one in your 
~/.gitconfig).

Although `git config -l` displays options from both ~/.gitconfig and the 
repo config, AFAIK the repo config does _override_ the ~/.gitconfig, so 
when you have user.email set in both, your new commits will use the one in 
the repo config (i.e. "email2").

As for rewriting your email address in all previous commits, that is 
impossible to do without rewriting your entire history. Rewriting your 
history is probably not something you want to do if you have published your 
repo, and other people have started working on top of your commits. If you 
_do_ want to rewrite your history, you should look at the "git 
filter-branch" command.


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
