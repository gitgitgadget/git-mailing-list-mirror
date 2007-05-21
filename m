From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Mon, 21 May 2007 12:44:16 +0200
Message-ID: <200705211244.16374.Josef.Weidendorfer@gmx.de>
References: <11796842882917-git-send-email-skimo@liacs.nl> <20070520222621.GG25462@steel.home> <20070521095749.GI942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon May 21 12:44:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq5NL-0000We-5Z
	for gcvg-git@gmane.org; Mon, 21 May 2007 12:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755859AbXEUKoU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 06:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756383AbXEUKoU
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 06:44:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:52895 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755859AbXEUKoT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 06:44:19 -0400
Received: (qmail invoked by alias); 21 May 2007 10:44:17 -0000
Received: from p5496B42B.dip0.t-ipconnect.de (EHLO noname) [84.150.180.43]
  by mail.gmx.net (mp002) with SMTP; 21 May 2007 12:44:17 +0200
X-Authenticated: #352111
X-Provags-ID: V01U2FsdGVkX187Y2BQlLw7SyPszTpQAAEsYrsxEkRWMgzlEGdVBm
	k7TdYbejcKgL2m
User-Agent: KMail/1.9.6
In-Reply-To: <20070521095749.GI942MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48007>

On Monday 21 May 2007, Sven Verdoolaege wrote:
> On Mon, May 21, 2007 at 12:26:21AM +0200, Alex Riesen wrote:
> > Sven Verdoolaege, Sun, May 20, 2007 23:47:32 +0200:
> > > 
> > > How would _you_ specify which subprojects to checkout ?
> > > 
> > 
> > Aren't the ones which already have .git in them are kind of specified?
> > 
> 
> Would you always recurse into these submodules, regardless of
> any option?
> Or would you want two options, one for handling the submodules
> you have explicitly marked someway and one for getting all submodules?

There should be a way for a superproject to specify useful sets of
subprojects for different developer roles, and these sets should be
versioned. It is also useful for a superproject to be able to say
"for this subproject to work, that other subprojects needs to be
checked out".

Both issues could be supported with a "dependson" setting in .gitmodules
(or better call this file ".gitprojects"?)

 [subproject "german-translation"]
    path = lang/german
    dependson = docbuilds

 [subproject "all-translations"]
    dependson = german-translation france-translation japanese-translation 

The syntax here only is RFC, including the fact that this example
puts the subproject identifier into the key, and the path as config.
If we do not go the .gitattributes way, IMHO this is more logical.

When cloning, one should be allowed to specify the subprojects one wants
to track, e.g.

 git-clone --subproject=all-translations ...

Josef
