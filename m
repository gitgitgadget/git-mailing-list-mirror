From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Article about "git bisect run" on LWN
Date: Mon, 9 Feb 2009 14:15:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902091414310.10279@pacific.mpi-cbg.de>
References: <200902050747.50100.chriscool@tuxfamily.org> <20090205141336.GA28443@elte.hu> <200902060623.16046.chriscool@tuxfamily.org> <200902070541.29955.chriscool@tuxfamily.org> <ee77f5c20902070455h360d8476re76294735673b4ca@mail.gmail.com>
 <7vskmqw1s4.fsf@gitster.siamese.dyndns.org> <20090209121943.GG17782@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	David Symonds <dsymonds@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Andreas Ericsson <ae@op5.se>,
	Jeff Garzik <jeff@garzik.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bill Lear <rael@zopyra.com>,
	Jon Seymour <jon.seymour@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Mon Feb 09 14:16:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWVzl-0000xr-WB
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 14:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107AbZBINOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 08:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753623AbZBINOu
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 08:14:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:36927 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753515AbZBINOt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 08:14:49 -0500
Received: (qmail invoked by alias); 09 Feb 2009 13:14:47 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp025) with SMTP; 09 Feb 2009 14:14:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18iOaZcEpoiqUvVCH1l43SirZQGaPia75B2SGDuOe
	/c+oVmJ1LuItcE
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090209121943.GG17782@elte.hu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109067>

Hi,

On Mon, 9 Feb 2009, Ingo Molnar wrote:

> * Junio C Hamano <gitster@pobox.com> wrote:
> 
> > David Symonds <dsymonds@gmail.com> writes:
> > 
> > > On Sat, Feb 7, 2009 at 3:41 PM, Christian Couder
> > > <chriscool@tuxfamily.org> wrote:
> > >
> > >> It might be useful to have a list of always good commits too, and use it
> > >> like this:
> > >>
> > >> $ git bisect start <bad> <good> $(cat always_good.txt)
> > >> $ git bisect skip $(cat always_skipped.txt)
> > >> $ git bisect run ./my_test_script.sh
> > >
> > > Your test script could just do this at its start instead:
> > >
> > >   if cat always_good.txt | grep $(rev-parse HEAD); then
> > >     exit 0
> > >   elif cat always_skipped.txt | grep $(rev-parse HEAD); then
> > >     exit 125
> > >   fi
> > 
> > Don't cat a file into grep, please.
> 
> I do it all the time not because i dont know about grep's ability
> to take a file parameter, but because this way it's just a
> special-case of command piping and i can inject other commands as
> i extend/edit the command line interactively, etc.

I think Junio meant using '< $file' type redirection, to avoid an 
unnecessary fork().  (Good habit, avoiding fork()s...)

Ciao,
Dscho
