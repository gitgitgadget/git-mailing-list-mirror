From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Preserve the protection mode for the Git config files
Date: Thu, 23 Jul 2009 00:37:11 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907230031450.3155@pacific.mpi-cbg.de>
References: <20090721152435.16642.47207.stgit@pc1117.cambridge.arm.com> <7vab2wlh4y.fsf@alter.siamese.dyndns.org> <20090723070815.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Catalin Marinas <catalin.marinas@arm.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 00:35:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTkPG-0007a6-Tk
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 00:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800AbZGVWe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 18:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753641AbZGVWe5
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 18:34:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:40676 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753926AbZGVWe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 18:34:57 -0400
Received: (qmail invoked by alias); 22 Jul 2009 22:34:56 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp043) with SMTP; 23 Jul 2009 00:34:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/LJnYZL5fLnju2kFRk/uVfV101GPDmZdnPpv4FU2
	RMwHdCwNTS1oRt
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090723070815.6117@nanako3.lavabit.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123808>

Hi,

On Thu, 23 Jul 2009, Nanako Shiraishi wrote:

> 1. Why would you keep sensitive information in the config file in the 
>    first place? Wouldn't it be better to introduce a level of 
>    indirection, making a variable in the config file to point to a 
>    private file only you can read and store secrets in the latter?

I agree that secret information should probably go to another file, 
although care has to be taken not to write that other file with "git 
config -f", as that would display the very same issue.

> 2. Why is your config file more secret than your history?

That one's easy.  If you store passwords in the config file, it _is_ more 
secret than the history.  You might be very willing to show people what 
you did, but still be unwilling to allow people to push commits with your 
credentials.

> Wouldn't it solve your problem without any patch if you set 
> core.sharedrepository to 0600?

I doubt it, as that config setting does not change anything in the working 
directory retro-actively.

You _could_ chmod 0700 .git.  But that is probably not what Catalin 
wanted.

Ciao,
Dscho
