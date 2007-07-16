From: "Bradford Smith" <bradford.carl.smith@gmail.com>
Subject: Re: git-config: replaces ~/.gitconfig symlink with real file
Date: Mon, 16 Jul 2007 09:26:01 -0400
Message-ID: <f158199e0707160626j1025ab2cp3339ca6ab91d9af0@mail.gmail.com>
References: <f158199e0707151427h52da3e38rae3be6e44e27e918@mail.gmail.com>
	 <dbfc82860707160237v6772b5b8o541f2045ccd824d5@mail.gmail.com>
	 <f158199e0707160433v27fe7073w9c550712c41c32e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nikolai Weibull" <now@bitwi.se>
X-From: git-owner@vger.kernel.org Mon Jul 16 15:27:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAQbe-0008Tc-Pg
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 15:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765320AbXGPN0H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 09:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765096AbXGPN0G
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 09:26:06 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:5341 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765320AbXGPN0E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 09:26:04 -0400
Received: by wr-out-0506.google.com with SMTP id i30so530767wra
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 06:26:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kbSROw91kd4/90q0zve9UGQoLcZkSqiiryOAl1qvA75cmGE33t+IuQkFGeAzyWaKiK+nbIWEpHuU9bDzOTwUz7JfYLPyVy3eKH52oAtT0Xm5vBmT7ihZ+iQ/t9rh1CAR6UD31fBTuswCSiyiQLPY5KDJF1P3Hya9w3CsAAoDnF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m7PH9nM7RcvPPA/KbY560TS4I/gQiID+SgP+XLC54jzEUeYhsQ767qZwlj8hkH+em64fGGOgGTt0B9iHoDqWwy1Xa4IOOVEDO6XgJgzAKsBjkOLngzbf9lNquJfSKxXyTqpgTudmIJSGtDYW2NwUCRpS0z2aL7FX7Ju5T8VqOOg=
Received: by 10.78.137.7 with SMTP id k7mr1166525hud.1184592361402;
        Mon, 16 Jul 2007 06:26:01 -0700 (PDT)
Received: by 10.78.178.10 with HTTP; Mon, 16 Jul 2007 06:26:01 -0700 (PDT)
In-Reply-To: <f158199e0707160433v27fe7073w9c550712c41c32e8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52674>

On 7/16/07, Bradford Smith <bradford.carl.smith@gmail.com> wrote:
> On 7/16/07, Nikolai Weibull <now@bitwi.se> wrote:
> > On 7/15/07, Bradford Smith <bradford.carl.smith@gmail.com> wrote:
> > > Since the number of dot-files and dot-directories that I have in my
> > > home directory these days is somewhat overwhelming, I like to keep
> > > those I directly edit all together in an ~/etc directory so I can
> > > easily back them up and/or copy them in bulk to new accounts.  So,
> > > several of my home dot-files are just symlinks to something in ~/etc,
> > > including ~/.gitconfig.
> >
> > How about adding an environment variable telling Git where to find
> > user-global .gitconfig instead?
> > > home directory these days is somewhat overwhelming, I like to keep
> > > those I directly edit all together in an ~/etc directory so I can
> > > easily back them up and/or copy them in bulk to new accounts.  So,
> > > several of my home dot-files are just symlinks to something in ~/etc,
> > > including ~/.gitconfig.
> >
> > How about adding an environment variable telling Git where to find
> > user-global .gitconfig instead?
>
> Thanks for suggesting that.
>
> Actually, by looking at the code I discovered I could use the
> environment variable GIT_CONFIG to specify where the configuration
> file is, and I have already changed my setup to use this.
> Unfortunately, I found the documentation for this variable in
> git-config(1) confusing or I would have used it before.  If I get the
> chance, I'll submit a patch for git-config.txt, and maybe for git.txt
> as well, since it lists lots of other environment variables but not
> GIT_CONFIG or GIT_CONFIG_LOCAL.
>
> Thanks,
>
> Bradford
>

Drat!  The documentation wasn't as wrong as I had hoped.  If I set
GIT_CONFIG, git will ignore $(prefix)/etc/gitconfig and ~/.git/config,
which isn't what I want.  So, I guess I need to add a GIT_CONFIG_HOME
environment variable.  If I get that done, I'll send a patch to the
list including doc updates.

Of course, if someone else wants to do it first, I won't complain. B')

Thanks,

Bradford
