From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH/RFC] config: Add --null/-z option for null-delimted output
Date: Tue, 19 Jun 2007 03:17:34 +0200
Message-ID: <20070619011734.GD19725@planck.djpig.de>
References: <f2t6na$5bi$1@sea.gmane.org> <11821227322913-git-send-email-frank@lichtenheld.de> <Pine.LNX.4.64.0706190151160.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 19 03:17:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0SLs-0002ro-6p
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 03:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770AbXFSBRq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 21:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756056AbXFSBRq
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 21:17:46 -0400
Received: from planck.djpig.de ([85.10.192.180]:4804 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754413AbXFSBRp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 21:17:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id E858C88102;
	Tue, 19 Jun 2007 03:17:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K-aqI35ODYuu; Tue, 19 Jun 2007 03:17:34 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 8451D88105; Tue, 19 Jun 2007 03:17:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706190151160.4059@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50436>

On Tue, Jun 19, 2007 at 01:55:24AM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 18 Jun 2007, Frank Lichtenheld wrote:
> 
> >  Note the FIXME. Does anyone remember the reason why --get-regexp
> >  and --list use different output format?
> 
> AFAIK --list was meant as a replacement to git-var --list. Thus, it had to 
> behave exactly the same.
> 
> As for the FIXME: If you have a config like this:
> 
> 	[core]
> 		Some = where
> 		over
> 		the = core.rainbow
> 
> git-config -z would output something like this:
> 
> 	core.some\0where\0core.over\0core.the\0core.rainbow\0
> 
> Right?

No. At least not with my patch. As you noted that would be
incredibly stupid and worthless. Instead we output something like

core.some\nwhere\0core.over\0core.the\ncore.rainbow\0

So you just can split on \0 and then split on \n. If there is
no \n between two \0, you have a key without value.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
