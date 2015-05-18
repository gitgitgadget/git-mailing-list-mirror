From: Kevin Daudt <me@ikke.info>
Subject: Re: Git Server Repository Security?
Date: Mon, 18 May 2015 21:15:55 +0200
Message-ID: <20150518191555.GA27248@vps892.directvps.nl>
References: <CABQ4iYiWu17H1XhPYebmP27x=R11SKW0P91AW2y9S=r-2c0B1A@mail.gmail.com>
 <20150518102633.GA15186@book.hvoigt.net>
 <CABQ4iYgjtdw46Psow_e7uGLqx0ZiFt+TQOgXvCmP1-W10LGEmg@mail.gmail.com>
 <20150518115749.GA16841@book.hvoigt.net>
 <CABQ4iYjwa-KmZAQV=p5efQYBZu3ymQRNwTC4TGXdpo4groArCA@mail.gmail.com>
 <20150518123948.GA17075@book.hvoigt.net>
 <CABQ4iYgauiENEv5ESbJTgUWVhRjt3NxmJfxTZTaa8U072atDEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: John McIntyre <joh98.mac@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 21:16:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuQWG-0008FE-CC
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 21:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698AbbERTP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 15:15:58 -0400
Received: from ikke.info ([178.21.113.177]:36402 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754224AbbERTP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 15:15:57 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id 9FFEA4400AA; Mon, 18 May 2015 21:15:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CABQ4iYgauiENEv5ESbJTgUWVhRjt3NxmJfxTZTaa8U072atDEQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269303>

On Mon, May 18, 2015 at 04:07:49PM +0100, John McIntyre wrote:
> 2015-05-18 13:39 GMT+01:00 Heiko Voigt <hvoigt@hvoigt.net>:
> > On Mon, May 18, 2015 at 01:32:07PM +0100, John McIntyre wrote:
> >
> > I do not know, because I always used /home/git. In case not: How about
> > just using a symlink? And there is a lot of information on google ;-)
> 
> 
> I'm confused.   If I run the gitolite command again, in the /opt/git
> directory, will that set it up correctly?

It's recommended to put it inside /home/git/, but if you want, you can
set $REPO_BASE inside /home/git/.gitolite.rc

> 
> And I thought that access was via key?  In the example config files
> I've seen, there is no mention of different keys in the config file.

Yes, but these keys are managed through a special repository called
gitolite-admin.git. You can add the keys to this repository and change
the config to give people access. When you commit and push this
repository, those changes come into effect.

> 
> Our users can currently ssh into the box.  I want to stop that, but
> since they all ssh in as the use 'git', if I change the shell of that
> user to /sbin/nologin or something similar, I'm effectively locking
> out the git user.

gitolite itself cares for that through the mechanism mentioned earlier.
When you try to log in, gitolite takes over, lists the repositories you
have access to, and then closes the connection, so no need to set login
to /sbin/nologin.

Note that there is also git-shell, which is a shell which can only be
used for git commands.
