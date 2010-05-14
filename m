From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [PATCH v5 01/18] Makefile: pass CPPFLAGS through to fllow
 customization
Date: Fri, 14 May 2010 10:58:32 +0000
Message-ID: <20100514105832.GB31921@thor.il.thewrittenword.com>
References: <20100514093131.249094000@mlists.thewrittenword.com>
 <20100514093725.884968000@mlists.thewrittenword.com>
 <robbat2-20100514T094909-157386852Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Fri May 14 12:58:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCsbH-0001zG-7z
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 12:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636Ab0ENK6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 06:58:33 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:55327 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab0ENK6d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 06:58:33 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id BA9655C71;
	Fri, 14 May 2010 11:15:24 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com BA9655C71
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 4F56ACD4;
	Fri, 14 May 2010 10:58:32 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id 3E2A4BAAE; Fri, 14 May 2010 10:58:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <robbat2-20100514T094909-157386852Z@orbis-terrarum.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147081>

Hi Robin,

On Fri, May 14, 2010 at 09:53:30AM +0000, Robin H. Johnson wrote:
> On Fri, May 14, 2010 at 09:31:32AM +0000, Gary V. Vaughan wrote:
> > Without this patch there is no straight forward way to pass additional
> > CPPFLAGS at configure-time.  At TWW, everything non-vendor package is
> > installed to its own subdirectory, so we need the following to show
> > the preprocessor where the headers for the libraries we will link
> > later can be found:
> As a point of comparision, this is what we use in Gentoo, to allow us to
> override many of the variables:
> sed -i \
>     -e 's:^\(CFLAGS =\).*$:\1 $(OPTCFLAGS) -Wall:' \
>     -e 's:^\(LDFLAGS =\).*$:\1 $(OPTLDFLAGS):' \
>     -e 's:^\(CC = \).*$:\1$(OPTCC):' \
>     -e 's:^\(AR = \).*$:\1$(OPTAR):' \
>     Makefile || die "sed failed"
> 
> Which would be equivilent to changing the Makefile to have:
> CFLAGS = $(OPTCFLAGS) -Wall
> LDFLAGS = $(OPTLDFLAGS)
> CC = $(OPTCC)
> AR = $(OPTAR)
> 
> Thereafter, we pass in the relevant values for those variables.
> 
> CPPFLAGS is reserved for flags destined for ONLY the preprocessor, and we don't
> want to introduce for that reason.

Letting the user pass preprocessor flags to the preprocessor with
CPPFLAGS at build and/or configure time is a *very* standard feature.
Why would you want to stop a person who builds git from using it?

As a matter of fact, Automake even jumps through hoops with
AM_CPPFLAGS to make sure that the package maintainer doesn't
accidentally trample over the package builder's CPPFLAGS settings - I
can't think of a scenario where the person who writes the build system
for a package knows more about what CPPFLAGS the person who builds it
will need that the person doing the actual building.

I'm pretty sure I'm missing the point though, since letting the
package builder choose their own CPPFLAGS has been at the core of
building Unix packages for as long as I can remember...

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
