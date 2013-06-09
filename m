From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: Re: git-daemon: needs /root/.config/git/config?
Date: Sun, 9 Jun 2013 14:47:57 +0200
Message-ID: <20130609124757.GA3347@client.brlink.eu>
References: <20130604141314.GD22308@pomac.netswarm.net>
 <20130604160815.GB15953@sigill.intra.peff.net>
 <20130605111918.GE22308@pomac.netswarm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Ian Kumlien <pomac@vapor.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 14:48:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulf2d-0007fW-1P
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 14:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458Ab3FIMsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 08:48:10 -0400
Received: from server.brlink.eu ([78.46.187.186]:42654 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751906Ab3FIMsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 08:48:09 -0400
Received: from client.brlink.eu 
	by server.brlink.eu with esmtpsa (tls-peer-hash KfHJgA)
	id 1Ulf2U-0005y3-Lo; Sun, 09 Jun 2013 14:48:06 +0200
Received: with local; Sun, 09 Jun 2013 14:48:00 +0200
Content-Disposition: inline
In-Reply-To: <20130605111918.GE22308@pomac.netswarm.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226959>

* Ian Kumlien <pomac@vapor.com> [130605 13:31]:
> Yes, i agree, it's suboptimal but I for one would use getpwuid to get
> the home directory of the executing user to avoid this - though i don't
> know how portable it is (or if there is any other issues)

It's not only suboptimal but simply wrong. getpwuid gives at best the
initial home directory, and even there it is only a guess. (If you are
looking for some home directory of a different user it might be a good
guess). But using getpwuid(getuid())->pw_dir if HOME is set is a serious
mistake, as you throw out the good value for some almost but not quite
totally unrelated value.

        Bernhard R. Link
