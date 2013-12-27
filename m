From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: git:// protocol over SSL/TLS
Date: Fri, 27 Dec 2013 18:14:06 +0400
Message-ID: <20131227181406.aa6c3427b3e52c978205b8b2@domain007.com>
References: <CAErtv27qUMo9LsGAZtk5Zv9qnZRB_YAXhtskvrrNbWGqadQh7Q@mail.gmail.com>
	<20131227173655.3f3109e7ba848c90b302e2f9@domain007.com>
	<CAErtv25JGxEs3ytAB019yajQooNs4k=bzukSE9kuHWAbir9-BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Git List <git@vger.kernel.org>
To: Sergey Sharybin <sergey.vfx@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 27 15:14:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwYBC-0007mM-2g
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 15:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053Ab3L0OOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 09:14:18 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:41833 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848Ab3L0OOR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 09:14:17 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id rBREE5KT018186;
	Fri, 27 Dec 2013 18:14:06 +0400
In-Reply-To: <CAErtv25JGxEs3ytAB019yajQooNs4k=bzukSE9kuHWAbir9-BQ@mail.gmail.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239731>

On Fri, 27 Dec 2013 19:58:19 +0600
Sergey Sharybin <sergey.vfx@gmail.com> wrote:

[...]
> > Yes, but it will only be secure if you've managed to verify the
> > server's certificate and do trust its issuer (or a CA higher up the
> > cert's trust chain) -- people tend to confuse "encrypted" with
> > "secure" which is not at all the same thing.
> 
> We've got CA-signed certificate atm and it's about to be also
> EV-signed for our server (git.blender.org). So this is not gonna to be
> an issue. Cloning over https:// works fine, but we wanted to be sure
> all the bits are secure.

This setup sounds to be just the right thing.

> So guess we just need to recommend using https:// protocol instead of
> git:// for our users?

I think yes.  HTTP[S] once was dumb and slow but now it should be
comparable in speed to git:// as essentially using this protocol (which
became "smart" [1]) means spawning a git server process once per fetch/push
session and making the client and server Git processes communicate all by
themselves, so HTTP is there for request routing, authentication and
session setup while data transfer is carried out by Git processes
themselves [2].

1. http://git-scm.com/blog/2010/03/04/smart-http.html
2. https://www.kernel.org/pub/software/scm/git/docs/git-http-backend.html
