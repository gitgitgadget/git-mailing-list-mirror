From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH 17/19] Portable alloca for Git
Date: Fri, 28 Feb 2014 21:00:12 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20140228170012.GA5247@tugrik.mns.mnsspb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
 <f08867ee212e27074dbb4cbb06af408b16dba0a1.1393257006.git.kirr@mns.spb.ru>
 <CABPQNSaVQuXBEnSrs6hdHwEbaBKFr-NjKpuBRNnbkM+HtfJ4Ag@mail.gmail.com>
 <CABPQNSadTGfiue6G+6x7_o10Ri1E7D5vZFU=Cp8rAha+j9jwSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Gerrit Pape <pape@smarden.org>,
	Petr Salinger <Petr.Salinger@seznam.cz>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Schwinge <tschwinge@gnu.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 17:58:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJQlo-0001oi-G8
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 17:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804AbaB1Q6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 11:58:40 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:33582 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752593AbaB1Q6j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 11:58:39 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WJQlb-0001ef-4d; Fri, 28 Feb 2014 20:58:31 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WJQnE-0001PQ-CX; Fri, 28 Feb 2014 21:00:12 +0400
Content-Disposition: inline
In-Reply-To: <CABPQNSadTGfiue6G+6x7_o10Ri1E7D5vZFU=Cp8rAha+j9jwSA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242987>

On Fri, Feb 28, 2014 at 02:50:04PM +0100, Erik Faye-Lund wrote:
> On Fri, Feb 28, 2014 at 2:44 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> > On Mon, Feb 24, 2014 at 5:21 PM, Kirill Smelkov <kirr@mns.spb.ru> wrote:
> >> diff --git a/Makefile b/Makefile
> >> index dddaf4f..0334806 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -316,6 +321,7 @@ endif
> >>  ifeq ($(uname_S),Windows)
> >>         GIT_VERSION := $(GIT_VERSION).MSVC
> >>         pathsep = ;
> >> +       HAVE_ALLOCA_H = YesPlease
> >>         NO_PREAD = YesPlease
> >>         NEEDS_CRYPTO_WITH_SSL = YesPlease
> >>         NO_LIBGEN_H = YesPlease
> >
> > In MSVC, alloca is defined in in malloc.h, not alloca.h:
> >
> > http://msdn.microsoft.com/en-us/library/wb1s57t5.aspx
> >
> > In fact, it has no alloca.h at all. But we don't have malloca.h in
> > mingw either, so creating a compat/win32/alloca.h that includes
> > malloc.h is probably sufficient.
> 
> "But we don't have alloca.h in mingw either", sorry.

Don't we have that for MSVC already in

    compat/vcbuild/include/alloca.h

and

    ifeq ($(uname_S),Windows)
        ...
        BASIC_CFLAGS = ... -Icompat/vcbuild/include ...


in config.mak.uname ?

And as I've not touched MINGW part in config.mak.uname the patch stays
valid as it is :) and we can incrementally update what platforms have
working alloca with follow-up patches.

In fact that would be maybe preferred, for maintainers to enable alloca
with knowledge and testing, as one person can't have them all at hand.

Thanks,
Kirill
