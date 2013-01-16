From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Question re. git remote repository
Date: Wed, 16 Jan 2013 22:06:15 +0400
Message-ID: <20130116220615.48c159546bccfa5b9cd9028e@domain007.com>
References: <201301161749.r0GHnGV6007806@smtpb02.one-mail.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "'git@vger.kernel.org'" <git@vger.kernel.org>
To: "Lang, David" <David.Lang@uhn.ca>
X-From: git-owner@vger.kernel.org Wed Jan 16 19:06:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvXNu-0006VA-KV
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 19:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757082Ab3APSG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 13:06:26 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:53465 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757077Ab3APSGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 13:06:25 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r0GI6GGi008698;
	Wed, 16 Jan 2013 22:06:18 +0400
In-Reply-To: <201301161749.r0GHnGV6007806@smtpb02.one-mail.on.ca>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213785>

On Wed, 16 Jan 2013 17:49:09 +0000
"Lang, David" <David.Lang@uhn.ca> wrote:

> We're just in the process of investigating a versioning tool and are
> very interesting in git. We have one question we're hoping someone
> can answer. In regards to the repositories, I think I understand
> correctly that each developer will have a local repository that they
> will work from, and that there will also be a remote repository
> (origin) that will hold the original version of the project.

The name "origin" is purely arbitrary: any local repository might have

> It appears from the limited reading I've done that the remote
> repository must be hosted at github.com. Is this the case?
Of course not.  github is just a Git hosting provider.  There are
plenty of them -- both commercial and not-for-profit (a well-known
service bitbucket.org is one example).

> Ideally we'd prefer to simply create our remote repository on a drive
> of one of our local network servers. Is this possible?

Yes, this is possible, but it's not advised to keep such a "reference"
repository on an exported networked drive for a number of reasons (both
performance and bug-free operation).

Instead, the canonical way to host "reference" repositories is to make
them accessible via SSH or via HTTP[S].  To do this, a server running
some POSIX OS (Linux- or *BSD-based) is the best bet.  Both kinds of
access require Git itself installed on the server.  Obviously, SSH
access requires an SSH server software (such as OpenSSH) as well and
HTTP[S] access requires a web server (such as Apache).  Of course,
everything mentioned is available on any sensible OS you might install
on your server.  Read-only access might be provided by a special tool
named "Git daemon" which is a part of Git.

If you have more than a couple of developers you might want to install
certain front-end Git software on the server which provides for
"virtualized" Git users and fine-grained control over who can do what.
Using gitolite [3] for this is the current trend.

Web-browsing for your repositories, if needed, is usually provided by
the tool named gitweb [4].

Everything I've just summarised is well explained in [5] and [6] (as an
addendum).

Another approach is to set up a "turn-key" solution such as GitLab [1]
or gitblit [2].

1. http://gitlabhq.com/
2. http://gitblit.com/
3. https://github.com/sitaramc/gitolite
4. https://git.wiki.kernel.org/index.php/Gitweb
5. http://git-scm.com/book/en/Git-on-the-Server
6. http://git-scm.com/2010/03/04/smart-http.html
