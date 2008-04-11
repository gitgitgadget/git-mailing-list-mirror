From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Re: how to use two bare repositories?
Date: Sat, 12 Apr 2008 01:19:53 +0200
Message-ID: <47FFF219.1080707@gmx.ch>
References: <20080411222205.GN29940@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Sat Apr 12 01:20:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkSXv-0001ft-UM
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 01:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755801AbYDKXT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 19:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755742AbYDKXT4
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 19:19:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:34994 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755586AbYDKXT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 19:19:56 -0400
Received: (qmail invoked by alias); 11 Apr 2008 23:19:54 -0000
Received: from 123-62.79-83.cust.bluewin.ch (EHLO [192.168.123.202]) [83.79.62.123]
  by mail.gmx.net (mp001) with SMTP; 12 Apr 2008 01:19:54 +0200
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX193u69dQWx3u33Uu/TQG7zO2n1mOfMj8gh+U4M2yW
	mLJl1aR8KYId5G
User-Agent: Thunderbird 2.0.0.12 (X11/20080229)
In-Reply-To: <20080411222205.GN29940@cs-wsok.swansea.ac.uk>
X-Enigmail-Version: 0.95.6
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79309>

Oliver Kullmann wrote:
> I have the following problem:
> 
> We use a public repository, a bare repository A,
> used with push and pull via ssh.
> A is only to be used by the core developer group.
> 
> Now I want to create another public repository B,
> from which anonymous pull is possible via http.
> So B should be another bare repository.
> 
> The problem is now that it seems not to be possible
> to update B:
> 
> 1. pulling from A is not possible since B is bare;
> 2. fetching from A seems to work, checking the content of
>    B via gitk seems to indicate that B has been updated
>  --- however pulling from B doesn't work: The newly
>  fetched changes are not transported to a repository
>  which pulls from B ???

Probably in your setup, B is tracking A as a remote and if you
fetch, only those remotes are updated, but not the local branches
in B.  If you then clone from B, you don't get B's remotes, you
get B's branches.  You probably want to do this:

path/to/B$ git remote rm origin
path/to/B$ git remote add --mirror origin path/to/A

Though, I wonder if it makes sense to have a 'git clone --bare'
set up the remote in mirror mode by default.  I'm unsure of what
use remotes are in a bare repo.

jlh
