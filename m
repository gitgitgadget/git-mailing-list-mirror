From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 6/6] Make sure that index-pack --strict checks tag
 objects
Date: Fri, 12 Sep 2014 10:04:30 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1409120952380.990@s15462909.onlinehome-server.info>
References: <alpine.DEB.1.00.1409101552250.990@s15462909.onlinehome-server.info> <cover.1410445430.git.johannes.schindelin@gmx.de> <2738eace005dce9002c1a1f5e87ad63aebdf83ef.1410445431.git.johannes.schindelin@gmx.de> <xmqqha0edony.fsf@gitster.dls.corp.google.com>
 <xmqqoauldfij.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 10:04:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSLqf-0003NQ-KM
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 10:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbaILIEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 04:04:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:58684 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752788AbaILIEm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 04:04:42 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MIyCj-1XUogI0mwz-002aHD;
 Fri, 12 Sep 2014 10:04:31 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqoauldfij.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:iazUpfcmwl5Lm45wdEWUS/vZj9cvsNIx+tmSLmBPDasSV6prnHs
 X3NK4uqoQ29a1XNvOLvAJuRNw6GcWB9t10FaalZVxlyBC9dO9CmYpKnN2gPV08cikAMjxtH
 OujKy14m83Kxd4l5PfeOpfeowqzAePi03adnAGYORMhypkjVuG4JoNlEzALXln1qOj4w+JT
 Y9ff94uIELVUHF563sIcA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256905>

Hi Junio,

On Thu, 11 Sep 2014, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > When our toolset has become too tight without leaving enough escape
> > hatch to hinder further development, it is very sensible to at least
> > think about adding a new "--for-debug" option to hash-object and
> > pack-objects that allows us to deliberately create broken
> > datastreams to test against.
> >
> > [...]
> 
> It wasn't too painful to do one of them, and the result looks rather
> nice.

I was loathe to make it easier for interested parties to create invalid
Git objects and to push them onto servers that cannot yet benefit from my
patch series. At the very least, I would have preferred to put such
functionality into test-* executables (where I searched for that
functionality in the first place), i.e. outside the distributed binaries.

But since you already did the work and it does the job, I won't worry
about it.

A bigger worry is that the additional test verifies that fsck catches the
invalid tag object and exits, when we really want to be certain that "git
fetch --strict" will abort on such an object. So the test is still
indirect, although I admit that it is closer now to what we want.

Version 4 of the patch series (without your hash-object --literally patch
because mailed patch series cannot declare on what branches from 'pu' they
rely, I always base my patch series on 'next' for that reason [*1*])
coming up.

Ciao,
Dscho

Footnote *1*: As always, I push my patch series to a topic branch on
GitHub. The one corresponding to the upcoming patch series is in
https://github.com/dscho/git/compare/next...fsck-tag, the one with your
additional test in
https://github.com/dscho/git/compare/next...fsck-tag-plus (the latter
being a thicket rather than a linear topic branch).
