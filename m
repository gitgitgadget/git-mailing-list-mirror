From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] Added make options NO_GUI and WITH_P4IMPORT.
Date: Wed, 21 Mar 2007 19:01:26 +0300
Message-ID: <20070321160126.GH14837@codelabs.ru>
References: <20070320114525.GP96806@codelabs.ru> <etpuen$2uo$2@sea.gmane.org> <20070321051406.GW96806@codelabs.ru> <Pine.LNX.4.63.0703211213100.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070321115004.GB14837@codelabs.ru> <Pine.LNX.4.63.0703211522320.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070321144008.GE14837@codelabs.ru> <Pine.LNX.4.63.0703211630160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 21 17:02:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU3Fy-0004MV-Sx
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 17:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbXCUQBh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 12:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932702AbXCUQBh
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 12:01:37 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:59311 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932697AbXCUQBf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 12:01:35 -0400
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HU3Fl-0004ZV-9W; Wed, 21 Mar 2007 19:01:33 +0300
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703211630160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, score=-3.2 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42799>

Johannes,

Wed, Mar 21, 2007 at 04:35:03PM +0100, Johannes Schindelin wrote:
> I will make my point very clear now:
> 
> People like you compile the source not so much to develop _in_ Git, but 
> _with_ Git. So, you are likely to "./configure && make install".
> 
> For something like "./configure && make install", it makes tons of sense 
> to check which dependencies are there, and which are not. Then, depending 
> if it is possible to compile (or install) only parts of Git, because some 
> dependencies are not met, ./configure can figure out what flags to set.

Yes, I see your point. But up to date (with 1.5.0.3 tarball) I saw no
stock configure and thus used the 'make && make install' sequence with
the 'prefix' set to some good location. Reading the INSTALL file
I've found that the
'make configure && ./configure --prefix=<blah> && make && make install'
will do the trick too. I just was unaware of it since I was using the
first sequence. And thus I happened to do 'NO_GUI=yes make && make install'.

> Now, if you have no X11 installed (and consequently no Tk), it is very 
> easy for ./configure to find out what to do.
> 
> However, if you state that you want to have no gui (and you state it as 
> such), you are not caring if X11 is installed or not! And ./configure 
> cannot figure out what you want, based on what it finds, since it cannot 
> read your mind. At least that is what I expect.

OK. So configure needs the detection of the Tcl/Tk and the --disable-gui
option. And the Makefile can be modified to get the additional
NO_TCL_TK option that will help configure to inform the Makefile
that no Tcl/Tk is here.

Technically, the checks in Makefile will look as 'ifndef NO_GUI && NO_TCL_TK'
instead of 'ifndef NO_GUI'. Later they can diverge as the software will
evolve.

Are people happy with such plan?
-- 
Eygene
