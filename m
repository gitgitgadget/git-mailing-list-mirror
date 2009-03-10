From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH][v2] http authentication via prompts (with correct line
 lengths)
Date: Tue, 10 Mar 2009 11:43:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903101132360.14295@intel-tinevez-2-302>
References: <49B5AF67.6050508@gmail.com> <7v1vt6dxg9.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903100143550.6358@intel-tinevez-2-302> <49B5DDA6.8070108@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Gaffney <mr.gaffo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 11:45:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgzSW-0000Il-PX
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 11:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701AbZCJKnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 06:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752434AbZCJKnf
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 06:43:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:53888 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751849AbZCJKne (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 06:43:34 -0400
Received: (qmail invoked by alias); 10 Mar 2009 10:43:31 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp070) with SMTP; 10 Mar 2009 11:43:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+W++xpjmqWe2L356tVsvp7ckkUeqw6BVQq6SumBb
	I+CWOFYRD8D3/Y
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <49B5DDA6.8070108@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112801>

Hi,

On Mon, 9 Mar 2009, Mike Gaffney wrote:

> I guess it makes sense to split the config out into two patches.

I guess, too, because it has been asked for.  I guess that since nobody 
contradicted that wish, it would make sense, I guess.

> I wanted both to help with automated builds, and as it's a read only 
> account I wasn't worried about someone reading the password. I'm not 
> very impressed with the permissions on the .netrc file actually 
> providing security so I can see not allowing the password in the config 
> either.

If Git were written for you, for that very specific setup, then yes, I can 
see that one does not need to care about storing passwords in plaintext 
files _there_.

However, in addition to you, Git was written for some others, too.

And $HOME/.netrc is a well established paradigm, many programs check the 
permissions and flatly refuse to run with a big red warning if the 
permissions are not set restrictively.  So there is definitely a big, 
huge, vast difference between storing passwords in $HOME/.netrc and 
storing them in .git/config.

> In my system at work, we have shared machines but all developers have 
> root access, so file permissions don't really secure anything for us. 
> It's also why we can't really use keys (there is no way to enforce that 
> a key is secured afaik).

Again, happily the Git team decided that in addition to you, we want to 
support other users.  For example us.

And we _do_ work on computers where only trustworthy people have root 
access.

> I wanted to do a remote specific config as well but a global works well 
> in many environments where your push repo is under http as you don't 
> keep having to configure it.

IMHO in this case, "works well" does not mean the same as "makes sense" at 
all.

Again, Git was written for other people, too.

It should not be necessary to say more, but here I go: on two projects I 
have to push to multiple HTTP servers, and I do have different passwords 
there.

However, I am pretty convinced that it is a good idea to have the 
passwords in $HOME/.netrc where they belong instead of in a config where 
it is all too easy to fsck up the permissions.

BTW that is another reason (in addition to it just being good style, 
separating different issues into different patches) why I want you to 
split the patch: to reject something insecure (storing passwords in 
config) and to accept the secure part (reading passwords interactively 
from the console).

> I also couldn't see a good way to do a remote specific config without 
> changing the remote struct (which seemd like putting specific in a 
> general). I would love some advice on this and where to put it.

Umm.  Into the remote struct?

> I can see your security points but I would argue that if that's what we 
> are worried about then we should not allow the netrc file at all.

See above.

> I added notes in the config documentation about this. I'm open to 
> discussion on this point.

Oh, so you mean you will address my concerns?  That's good, as I am 
looking forward to your answers to them.

Ciao,
Dscho
