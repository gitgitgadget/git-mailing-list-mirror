From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Support environment variables in config file
Date: Mon, 4 Jun 2007 18:59:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706041856270.4046@racer.site>
References: <20070603223727.GA16637@admingilde.org> <20070604053443.GA15148@moooo.ath.cx>
 <20070604072707.GE16637@admingilde.org> <Pine.LNX.4.64.0706041657210.4046@racer.site>
 <20070604174719.GH16637@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 20:01:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvGsI-0003rK-Rq
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 20:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304AbXFDSBr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 14:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754491AbXFDSBr
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 14:01:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:45342 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754248AbXFDSBq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 14:01:46 -0400
Received: (qmail invoked by alias); 04 Jun 2007 18:01:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 04 Jun 2007 20:01:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+zSrVVBxez4qNBul1Fz6KdDfmZPl5n6/US7B4Yu5
	GEp/8dJN5EOxg7
X-X-Sender: gene099@racer.site
In-Reply-To: <20070604174719.GH16637@admingilde.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49121>

Hi,

On Mon, 4 Jun 2007, Martin Waitz wrote:

> On Mon, Jun 04, 2007 at 04:57:35PM +0100, Johannes Schindelin wrote:
> > I actually would like it more if the calling program did the 
> > interpolation itself.
> 
> That's another possibility, perhaps along the line of git_config_int.

Maybe...

> > So, for example if you want a script to access whatever.my.url, and 
> > want to allow to interpolate any environment variable, why not
> > 
> > 	url=$(eval $(git config whatever.my.url))
> 
> Well, complete shell syntax does too much: it also supports $() and 
> friends.

Good point.

> > I am just hesitant to change the existing behaviour, and possibly 
> > introduce weird breakages. (There could even be some unwanted env 
> > leakages in programs like gitweb...)
> 
> exactly.
> 
> So should we simply update semantics of config variables to not require 
> any environment variables?

Well, actually there is a perfect example when you would want to do even 
more than just expanding environment variables: aliases.

I'm happy to understand the config as a relatively versatile key/value 
store, without much in the way of pre- or post-processing from git-config 
or git_config().

But if there are a few callers of git_config() which want environment 
variable interpolation, git_config_expand_envs() would be good.

Ciao,
Dscho
