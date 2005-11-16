From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: recent patch breaks the build ?
Date: Thu, 17 Nov 2005 00:25:06 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511170023040.9284@wbgn013.biozentrum.uni-wuerzburg.de>
References: <437B6997.8010903@mc.com> <7v64qs8kuo.fsf@assigned-by-dhcp.cox.net>
 <437B8CEC.8040002@mc.com> <20051116203334.GA3968@reactrix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Wozniak <awozniak@mc.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 00:26:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcWeP-0001U7-SX
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 00:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161013AbVKPXZK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 18:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161016AbVKPXZK
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 18:25:10 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:45272 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1161013AbVKPXZI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 18:25:08 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5B63813FB3B; Thu, 17 Nov 2005 00:25:07 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 425B49F328; Thu, 17 Nov 2005 00:25:07 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2E0C79F0FB; Thu, 17 Nov 2005 00:25:07 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 83EF513FB3B; Thu, 17 Nov 2005 00:25:06 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051116203334.GA3968@reactrix.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12070>

Hi,

On Wed, 16 Nov 2005, Nick Hengeveld wrote:

> On Wed, Nov 16, 2005 at 02:47:56PM -0500, Andrew Wozniak wrote:
> 
> > Unfortunately, now there are other failures:
> > 
> > gcc -o http-push.o -c -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'
> > http-push.c
> > http-push.c: In function `start_mkcol':
> > http-push.c:479: `CURLOPT_HTTPGET' undeclared (first use in this
> > function)
> 
> http-push requires a curl option that looks like it was added around
> version 7.8.1.  If you have the option to upgrade your version of curl,
> it should fix the problem.  You can also disable building http-push but
> keep http-fetch by defining NO_EXPAT.

It was 7.8.1. I checked. You might want to add this somewhere:

#if LIBCURL_VERSION_NUM < 0x070801
#error http-push needs curl >= 7.8.1 (because of CURLOPT_HTTPGET)
#endif

I tried quite a few things to work around it. Alas, I am now convinced 
that no set of option setting does exactly the same thing as 
CURLOPT_HTTPGET for a specific curl version < 7.8.1 (the one I tested 
with).

Ciao,
Dscho
 
