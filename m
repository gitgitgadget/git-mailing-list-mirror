From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Added basic color support to git add --interactive
Date: Tue, 23 Oct 2007 02:41:07 -0400
Message-ID: <20071023064106.GA30351@coredump.intra.peff.net>
References: <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com> <20071013172745.GA2624@coredump.intra.peff.net> <20071013175127.GA3183@coredump.intra.peff.net> <47112491.8070309@gmail.com> <20071015034338.GA4844@coredump.intra.peff.net> <20071016194709.3c1cb3a8@danzwell.com> <20071017015152.GN13801@spearce.org> <20071022163244.4af72973@danzwell.com> <20071023040315.GA28312@coredump.intra.peff.net> <D1795135-AD5E-491C-99E6-30486E189B13@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Zwell <dzwell@zwell.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 08:41:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkDS6-00039I-Oo
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 08:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbXJWGlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 02:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbXJWGlL
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 02:41:11 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3680 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751707AbXJWGlK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 02:41:10 -0400
Received: (qmail 337 invoked by uid 111); 23 Oct 2007 06:41:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 23 Oct 2007 02:41:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Oct 2007 02:41:07 -0400
Content-Disposition: inline
In-Reply-To: <D1795135-AD5E-491C-99E6-30486E189B13@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62114>

On Tue, Oct 23, 2007 at 08:28:28AM +0200, Wincent Colaiuta wrote:

> I did too, where you add a third, optional "trailer" parameter to the 
> function where you pass the newline if there is one (following the style of 
> the functions in color.c). Pasting it below.

The problem with that approach is that you can only send in a single
line at a time (with the newline detached!), so it makes life harder for
the caller. E.g., there is at least one spot that uses a here-doc with
many lines; splitting that into a bunch of print_ansi_color calls would
be unnecessarily ugly.

> Having said that, I think this kind of function belongs in Git.pm, and the 

Yes! Most of this is obviously library-ish code, and should go into the
library.

> dependency on Term::ANSIColor should be replaced with dependency-free code 
> that generates the colors itself; this should be easy because the number of 

Out of curiosity, are people really running perl < 5.6?  Term::ANSIColor
has been in the base distribution for 7 years now.

-Peff
