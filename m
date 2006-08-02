From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb: optionally read config from GITWEB_CONFIG
Date: Wed, 2 Aug 2006 16:41:54 -0400
Message-ID: <20060802204154.GA15678@sigio.intra.peff.net>
References: <20060802192333.GA30861@coredump.intra.peff.net> <ear1fp$j9p$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 22:42:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8NXU-0000TX-22
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 22:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWHBUl4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 16:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWHBUl4
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 16:41:56 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:56540 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751285AbWHBUl4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 16:41:56 -0400
Received: (qmail 31716 invoked from network); 2 Aug 2006 16:41:20 -0400
Received: from unknown (HELO sigio.intra.peff.net) (10.0.0.10)
  by segfault.intra.peff.net with SMTP; 2 Aug 2006 16:41:20 -0400
Received: by sigio.intra.peff.net (sSMTP sendmail emulation); Wed,  2 Aug 2006 16:41:54 -0400
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <ear1fp$j9p$2@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24681>

On Wed, Aug 02, 2006 at 10:21:43PM +0200, Jakub Narebski wrote:

> > @@ -56,7 +50,7 @@ # URI of GIT logo
> >  our $logo = "@@GITWEB_LOGO@@";
> >  
> >  # source of projects list
> > -our $projects_list = "@@GITWEB_LIST@@" || "$projectroot";
> > +our $projects_list = "@@GITWEB_LIST@@";
> >  
> >  # default blob_plain mimetype and default charset for text/plain blob
> >  our $default_blob_plain_mimetype = 'text/plain';
> 
> But why that change?

Because the previous order was:
  1. set projectroot to build-time default
  2. set projects_list to build-time default or $projectroot
  3. read variables, including $projectroot, from config file
If you kept $projects_list empty but set $projectroot in your config,
the value of projects_list would be the build-time $projectroot, not the
config-time. If you look further in the patch, you will see that we set
up projects_list later.

-Peff
