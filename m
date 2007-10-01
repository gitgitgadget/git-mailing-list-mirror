From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] Add a simple option parser for use by builtin-commit.c.
Date: Mon, 1 Oct 2007 19:13:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710011909291.28395@racer.site>
References: <1190868632-29287-1-git-send-email-krh@redhat.com> 
 <20070930131133.GA11209@diku.dk> <1191255975.25093.26.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonas Fonseca <fonseca@diku.dk>, gitster@pobox.com,
	git@vger.kernel.org
To: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 20:14:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcPn8-0007lw-Ve
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 20:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbXJASOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 14:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbXJASOm
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 14:14:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:51743 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751596AbXJASOl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 14:14:41 -0400
Received: (qmail invoked by alias); 01 Oct 2007 18:14:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 01 Oct 2007 20:14:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18btSQ4eoMbHQ21/QKa0V7nlvRzXGu6jLIutbskon
	eJKqtn05HdWP8I
X-X-Sender: gene099@racer.site
In-Reply-To: <1191255975.25093.26.camel@hinata.boston.redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59629>

Hi,

On Mon, 1 Oct 2007, Kristian H?gsberg wrote:

> On Sun, 2007-09-30 at 15:11 +0200, Jonas Fonseca wrote:
>
> > One of the last things I miss from Cogito is the nice abbreviated help 
> > messages that was available via '-h'. I don't know if it would be 
> > acceptable (at least for the main porcelain commands) to put this 
> > functionality into the option parser by adding a "description" member 
> > to struct option and have parse_options print a nice:
> > 
> > 	<error message if any>
> > 	<usage string>
> > 	<option summary>
> > 
> > on failure, or, if that is regarded as too verbose, simply when -h is 
> > detected.
> 
> Yeah, that might be nice.  We can add it in a follow-on patch, if the 
> list agrees that it's a good thing, I guess.

That's a good idea; I would put the usage string there, too.

> > > +
> > > +/* Parse the given options against the list of known options.  The
> > > + * order of the option structs matters, in that ambiguous
> > > + * abbreviations (eg, --in could be short for --include or
> > > + * --interactive) are matched by the first option that share the
> > > + * prefix.
> > > + */
> > 
> > This prefix aware option parsing has not been ported over to the other 
> > builtins when they were lifted from shell code. It might be nice to 
> > have of course. Is it really needed?
> 
> I don't ever use it myself and I think it's more confusing than helpful. 
> I only added it to avoid introducing behavior changes in the port.  I 
> don't have strong feelings either way.

It might be convenient, but I think that it is really more confusing than 
helpful, especially with options that share a prefix.  Besides, we have 
good completion for bash now (and I hear that this "zsh" thing also has 
quite good completion), I recommend <TAB> over prefix DWIMery.

> > > +
> > > +extern int parse_options(const char ***argv,
> > > +			 struct option *options, int count,
> > > +			 const char *usage_string);
> > 
> > I think the interface could be improved a bit. For example, it doesn't 
> > need to count argument since the last entry in the options array is 
> > OPTION_LAST and thus the size can be detected that way.
> 
> Hehe, yeah, that's how I did it first.  I don't have a strong preference 
> for terminator elements vs. ARRAY_SIZE(), but Junio prefers the 
> ARRAY_SIZE() approach, I guess.  At this point I'm just trying the get 
> the patches upstream...

FWIW I like the ARRAY_SIZE() approach better, too, since it is less error 
prone.

Ciao,
Dscho
