From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: What's in git.git
Date: Thu, 3 Aug 2006 14:32:24 +0200
Message-ID: <81b0412b0608030532v4241322dted5f42baa196af88@mail.gmail.com>
References: <7v1ws0xb9y.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0608020702q2fd4ec83ga43714c15538f7ad@mail.gmail.com>
	 <7vd5bis9ha.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0608030109g6f49113ep5cf577475117469b@mail.gmail.com>
	 <7vmzamqivk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 03 14:32:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8cNL-0001eO-Gg
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 14:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWHCMc0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 08:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWHCMc0
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 08:32:26 -0400
Received: from wx-out-0102.google.com ([66.249.82.197]:36642 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932424AbWHCMcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 08:32:25 -0400
Received: by wx-out-0102.google.com with SMTP id s14so1010480wxc
        for <git@vger.kernel.org>; Thu, 03 Aug 2006 05:32:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XU6NGW28lgK+ogXCXQBt15EZAp+UEgEttPaIS4+RqikBwQC3pP9Fra5uPAYfspExeTDeW+JGksWCvNDeCMBBxMJNmF6SYcnelRenpvWfcgLDg64AWAwDK4Huiu1omaxcdKkchGbKjaPYeWezha7xHuEJsJG8wXf3EcIzCFmTqKc=
Received: by 10.78.147.3 with SMTP id u3mr692342hud;
        Thu, 03 Aug 2006 05:32:24 -0700 (PDT)
Received: by 10.78.160.12 with HTTP; Thu, 3 Aug 2006 05:32:24 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vmzamqivk.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24720>

On 8/3/06, Junio C Hamano <junkio@cox.net> wrote:
> >> What's the standard workflow/procedure ActiveState users would
> >> use to build and install .xs extensions?  Maybe they have their
> >> own $(MAKE) equivalent that groks such a Makefile with
> >> backslashed pathnames and CRLF endings?
> >
> > I don't know. It's a bit more than backslashes and CRLF. The pathnames
> > must be _completely_ converted from windows to cygwin. Cygwin even
> > provides an utility for that (cygpath). Besides, there still is that stupid
> > case-sensitivity problem.
>
> What I meant to say was that the real mistake might be for us to
> try using the Cygwin toolchain (GNU make, gcc and GNU C library)
> while working with ActiveState.

Luckily, only ActiveState Perl users are hit. Which, I suppose,
is not all that much (it's really crappy environment to work in,
an only real stupid corporate users can keep doing that),
and they're used to pain.

> Now, I admit I know very little about ActiveState and know
> nothing about Windows build environment, but I would not be
> surprised if in ActiveState land there were a MakeMaker
> equivalent that spits out Makefile equivalent that is suitable
> for MS development environment, and the users are expected to
> work in that environment, perhaps using MS C compiler toolchain,

AFAICS, it is not suitable for anything: generated Makefile is not
parsable by nmake(what MS thinks is a make) and is more like a
broken gmake Makefile. Also -fno-strict-aliasing points at gcc.

> to produce object files if they want to link with ActiveState
> stuff.  If that were the case, maybe what is needed is to port
> the build infrastructure to MS development environment, and
> making Makefile generated from perl/Makefile.PL usable might not
> be of much use.

I'd suggest to add NO_PERL_XS option to the top-level Makefile.
Really core tools do not need Git.pm.
