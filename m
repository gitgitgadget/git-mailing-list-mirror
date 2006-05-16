From: Santi <sbejar@gmail.com>
Subject: Re: "git add $ignored_file" fail
Date: Wed, 17 May 2006 00:42:25 +0200
Message-ID: <8aa486160605161542u704ccf03w@mail.gmail.com>
References: <8aa486160605161507w3a27152dq@mail.gmail.com>
	 <Pine.LNX.4.64.0605161526210.16475@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 17 00:42:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg8FJ-0002t3-TD
	for gcvg-git@gmane.org; Wed, 17 May 2006 00:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWEPWm1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 18:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWEPWm1
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 18:42:27 -0400
Received: from wx-out-0102.google.com ([66.249.82.201]:2402 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932252AbWEPWm0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 18:42:26 -0400
Received: by wx-out-0102.google.com with SMTP id s6so63674wxc
        for <git@vger.kernel.org>; Tue, 16 May 2006 15:42:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X0krzbn4KwiV2HowcupRAlpudyzZhhnSMBmudp8m0bXhSBjtairxGfYXmvcfYtcAu8tTvBTLLOrNE8zlQzoKwLu234oI6eaxrK25ONMzamLGI6ywr9DHQkocMNzGcJPZYgIN0d5AD/PA7eU1wwGld6K1HvjDO6CvjYZHh+bp1Eg=
Received: by 10.70.53.3 with SMTP id b3mr324450wxa;
        Tue, 16 May 2006 15:42:25 -0700 (PDT)
Received: by 10.70.20.2 with HTTP; Tue, 16 May 2006 15:42:25 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605161526210.16475@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20145>

2006/5/17, Linus Torvalds <torvalds@osdl.org>:
>
>
> On Wed, 17 May 2006, Santi wrote:
> >
> >      When you try to add ignored files with the git-add command it
> > fails because the call to:
> >
> > git-ls-files -z \
> >        --exclude-from="$GIT_DIR/info/exclude" \
> >        --others --exclude-per-directory=.gitignore
> >
> >      does not output this file because it is ignored. I know I can do it with:
> >
> > git-update-index --add $ignored_file
> >
> > I understand the behaviour of git-ls-files but I think it is no the
> > expected for git-add, at least for me.
>
> Well, the thing is, git-add doesn't really take a "file name", it takes a
> filename _pattern_.
>
> Clearly we can't add everything that matches the pattern, because one
> common case is to add a whole subdirectory, and thus clearly the
> .gitignore file must override the pattern.
>
> So it's consistent that it overrides it also for a single filename case,
> no?
>

It's consistent from an implementation point of view, but not from the
(my?) user point of view. This is why I say I understand it for
git-ls-files. For the case of git-add even the usage and the man page
talk about <file>...

Clearly for the case of a whole subdirectory, or even ".",  the
.gitignore file must override the pattern, but not for the case of a
pattern that is a single existing file.

Santi
