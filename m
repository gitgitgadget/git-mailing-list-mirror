From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-submodule - register module url if adding in place
Date: Tue, 8 Jul 2008 13:34:33 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807081332580.4319@eeepc-johanness>
References: <1215484630-3784-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 13:35:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGBTe-0002OP-KH
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 13:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314AbYGHLeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 07:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754272AbYGHLeY
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 07:34:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:35582 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754190AbYGHLeX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 07:34:23 -0400
Received: (qmail invoked by alias); 08 Jul 2008 11:34:21 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp063) with SMTP; 08 Jul 2008 13:34:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18gTB0ugAkgfKMQs+EddHfOV34d3UdL4Yd3chiZPA
	PghMU/Yn3T38yr
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1215484630-3784-1-git-send-email-mlevedahl@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87751>

Hi,

On Mon, 7 Jul 2008, Mark Levedahl wrote:

> When adding a new submodule in place, meaning the user created the 
> submodule as a git repo in the tree first, we don't go through git 
> submodule init to register the module. Thus, the url is not stored in 
> .git/config, and no git operation will ever do so. In this case, assume 
> the url the user supplies to git add is the one that should be 
> registered, and do so.

I agree with Sylvain here, namely that this is too dangerous.  Imagine 
this very valid scenario:

	$ git clone <somewhere> abc
	$ git submodule add abc

Bummer.

Yes, happened to me.

So I'd like this to be an error, not something that tries to be helpful, 
when it clearly cannot be.

Ciao,
Dscho
