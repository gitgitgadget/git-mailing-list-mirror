From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: WIP: asciidoc replacement
Date: Wed, 3 Oct 2007 12:50:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710031239410.28395@racer.site>
References: <Pine.LNX.4.64.0710030133020.28395@racer.site>
 <7vprzwhkgd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 13:51:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id2lF-0002xB-Af
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 13:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120AbXJCLvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 07:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755032AbXJCLvT
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 07:51:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:40346 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754272AbXJCLvS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 07:51:18 -0400
Received: (qmail invoked by alias); 03 Oct 2007 11:51:16 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 03 Oct 2007 13:51:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+BHyZmo2aBA/bnCuhIpEdTWbcvrpFYEI7kQ8ooqf
	sQwhJBdrUXGGU6
X-X-Sender: gene099@racer.site
In-Reply-To: <7vprzwhkgd.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59829>

Hi,

On Tue, 2 Oct 2007, Junio C Hamano wrote:

> 
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > So here it is: a perl script that does a good job on many .txt files 
> > in Documentation/, although for some it deviates from "make man"'s 
> > output, and for others it is outright broken.  It is meant to be run 
> > in Documentation/.
> >
> > My intention is not to fix the script for all cases, but to make 
> > patches to Documentation/*.txt themselves, so that they are more 
> > consistent (and incidentally nicer to the script).
> 
> How you spend your time is up to you, but I need to wonder...
> 
>  - Is "man" format important for msysGit aka Windows
>    environment?  I had an impression that their helpfile format
>    were closer to "html" output.

I wanted something that can output both "man" and "html" output (and if 
some suck^Wlos^Wtexi-fan wants to provide it, also a "texi" or even "info" 
backend).

IMHO "man" needs a stricter framework in place, so I went with that.

>  - Does it make sense in the longer term for us to maintain
>    in-house documentation tools?  Can we afford it?

In the long run, I expect only few bugs (and I will try hard to squash 
them when they crop up, _and_ make this beast more maintainable whenever 
somebody has an idea how to do that).

However, it should definitely help keeping the docs clean, as now nobody 
has an excuse to test doc changes a la "I do not have asciidoc, so I do 
not know if it works, so please test".

> It appears that we heard about breakages for every minor docbook 
> updates, and it is really appealing if we do not have to rely on xsl 
> toolchain for manpage generation.

Exactly.

> But if patching the text means making it compatible with the in-house 
> script _and_ incompatible with AsciiDoc, hmmm...

No, I do not want it _incompatible_.  I want it _stricter_.  For example, 
you can do this in asciidoc:


    This is some paragraph that is indented,
    but the funny thing is:

This paragraph:
---------------

	is indented all the same!


So one thing I absolutely detest here is that you are free to use one, 
two, three or more spaces, or tabs, and asciidoc does the DWIMery of 
handling them the same.  But _not_ if there was any indentation before 
that with _less_ spaces and/or tabs!

Therefore I'd like to enforce strict rules here: Tab it is.  One tab per 
indentation level.  No spaces, no ambiguities.

Ciao,
Dscho
