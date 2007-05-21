From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config: Add --quoted option to produce machine-parsable
 output
Date: Mon, 21 May 2007 19:46:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705211945470.6410@racer.site>
References: <20070520225953.GK4085@planck.djpig.de>
 <11797696193384-git-send-email-frank@lichtenheld.de> <7vejladpfr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 21 20:47:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqCv2-0002WB-Ba
	for gcvg-git@gmane.org; Mon, 21 May 2007 20:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163AbXEUSrh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 14:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755627AbXEUSrh
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 14:47:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:42305 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755163AbXEUSrg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 14:47:36 -0400
Received: (qmail invoked by alias); 21 May 2007 18:47:35 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp027) with SMTP; 21 May 2007 20:47:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/p3eodEjvp7QNLgNaUqEMq4ewGC3U4saEKiRZVhu
	sTITPTklsTqzPk
X-X-Sender: gene099@racer.site
In-Reply-To: <7vejladpfr.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48040>

Hi,

On Mon, 21 May 2007, Junio C Hamano wrote:

> Frank Lichtenheld <frank@lichtenheld.de> writes:
> 
> > This option will enclose key names in quotes (") if they
> > contain a subsection and then escape " and \. It will also
> > escape line breaks in values. Together this should produce
> > an easily parsable output.
> >
> > Affects --list and --get-*
> >
> > Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
> > ---
> >  builtin-config.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++++-----
> >  1 files changed, 83 insertions(+), 9 deletions(-)
> >
> > Will add asciidoc documentation and test cases if people think that 
> > this is a good idea.
> >
> > I'm writing C about once a year, so I really don't mind being told if 
> > it's crap ;)
> 
> We probably would want to make this compatible with the quoting rules 
> various fo "host" language have.  quote.c has host language support to 
> implement {perl,python,tcl}_quote_print() for single string values or 
> keys, so we should extend that idea.
> 
> In your application, what you are trying to do is to show a "hash" (key 
> => value) in a notation that is friendly to the host language.
> 
> Git.pm could simply do:
> 
> 	my $eval = `git config --perl --get-regexp 'gitcvs\..*'`;
> 	my $cfg = eval "$eval";
> 
> if you code your "perl" notation to produce:
> 
> 	+{
> 		'gitcvs.ext.enabled' => 'false',
>                 'gitcvs.logfile' => '/var/log/gitcvs.log',
> 	}
> 
> in order to read things in.
> 
> Hmm?

IOW, something like 
http://article.gmane.org/gmane.comp.version-control.git/36922

Hmm?

Ciao,
Dscho
