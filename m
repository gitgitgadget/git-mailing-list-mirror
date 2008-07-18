From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] shrink git-shell by avoiding redundant dependencies
Date: Fri, 18 Jul 2008 00:58:14 +0000
Message-ID: <20080718005814.GA4155@spearce.org>
References: <1214602538-7888-1-git-send-email-dpotapov@gmail.com> <7vod5mpmp7.fsf@gitster.siamese.dyndns.org> <20080627223107.GH5737@dpotapov.dyndns.org> <20080718002620.GE8421@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jul 18 02:59:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJeJc-0004Lo-AB
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 02:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbYGRA6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 20:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755843AbYGRA6P
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 20:58:15 -0400
Received: from george.spearce.org ([209.20.77.23]:59068 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbYGRA6P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 20:58:15 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B9794382A4; Fri, 18 Jul 2008 00:58:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080718002620.GE8421@leksak.fem-net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88942>

Stephan Beyer <s-beyer@gmx.net> wrote:
> >  
> > +/* Stubs for functions that make no sense for git-shell. These stubs
> > + * are provided here to avoid linking in external redundant modules.
> > + */
> > +void release_pack_memory(size_t need, int fd){}
> > +void trace_argv_printf(const char **argv, const char *fmt, ...){}
> > +void trace_printf(const char *fmt, ...){}
> 
> I don't really understand why this works.
> You redefine libgit.a functions here

On Solaris you cannot compile git with the Solaris compiler
and linker, as the linker will not put up with the duplicate
definition of these functions.

I told my co-worker who is taking over "that git stuff" from
me at day-job to post a message to the list, or look at the
Solaris manual pages and figure out what he needs to do in
the Makefile to get it to work right.  Neither has happened
yet, and those day-job systems are the only Solaris boxen I
touch, so I won't be fixing it anytime soon myself.

I have to wonder why its important we avoid linking to
all of libgit.a here.  So what if git-shell is a little
bigger?  This is certainly not fully portable, and does
give warnings on some systems.

-- 
Shawn.
