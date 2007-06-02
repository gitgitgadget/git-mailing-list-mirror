From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] Let .git/config specify the url for submodules
Date: Sat, 02 Jun 2007 09:44:10 +0200
Message-ID: <20070602074410.GA955MdfPADPa@greensroom.kotnet.org>
References: <8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com>
 <20070601085705.GT955MdfPADPa@greensroom.kotnet.org>
 <8c5c35580706010225p7c34c3ceu8bbfb9996388d673@mail.gmail.com>
 <20070601093554.GV955MdfPADPa@greensroom.kotnet.org>
 <8c5c35580706010745l76fc5410l21f2e3f385693ad9@mail.gmail.com>
 <20070601145104.GY955MdfPADPa@greensroom.kotnet.org>
 <8c5c35580706010856s390b1157p3ea0d28cb2074cae@mail.gmail.com>
 <alpine.LFD.0.98.0706010919360.3957@woody.linux-foundation.org>
 <7vfy5bzby1.fsf@assigned-by-dhcp.cox.net>
 <8c5c35580706020013g2a4039fcsdf8974da8cd4c2c2@mail.gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 09:44:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuOHe-0000Bm-Mn
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 09:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155AbXFBHoO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 03:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755857AbXFBHoO
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 03:44:14 -0400
Received: from psmtp13.wxs.nl ([195.121.247.25]:60724 "EHLO psmtp13.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756227AbXFBHoN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 03:44:13 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp13.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JJ000L6U05MWY@psmtp13.wxs.nl> for git@vger.kernel.org; Sat,
 02 Jun 2007 09:44:11 +0200 (MEST)
Received: (qmail 29618 invoked by uid 500); Sat, 02 Jun 2007 07:44:10 +0000
In-reply-to: <8c5c35580706020013g2a4039fcsdf8974da8cd4c2c2@mail.gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48913>

On Sat, Jun 02, 2007 at 09:13:55AM +0200, Lars Hjemli wrote:
> Then Sven suggested to create a submodule section for the url, which would 
> allow
> 
>  $ name=$(GIT_CONFIG=.gitmodules git-config path."$path".submodule)
>  $ url=$(GIT_CONFIG=.gitmodules git-config submodule."$name".url)
> 
> 
> But I don't see an easy way to do the mapping from path to url/submodule 
> with:
> 
> [submodule "xyzzylib"]
>  path=lib
>  url=git://xyzzy/lib-1.2.3
> 
> Suggestions?

I'm not a shell programmer, but it could look something like this

    $ name=$(git config --get-regexp 'submodule\..*\.path' | while read module modulepath; do if test "$modulepath" = "$path"; then echo $module | sed -e 's/^submodule.//' -e 's/.path//'; fi; done)

skimo
