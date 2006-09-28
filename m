From: Shawn Pearce <spearce@spearce.org>
Subject: Re: daemon.c fails to build on Darwin
Date: Thu, 28 Sep 2006 12:06:52 -0400
Message-ID: <20060928160652.GC2947@spearce.org>
References: <86ejtw3sbv.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 18:09:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSyQi-0000bc-JH
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 18:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWI1QHp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 12:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWI1QHH
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 12:07:07 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:12750 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932511AbWI1QG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 12:06:56 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GSyPQ-00055T-HC; Thu, 28 Sep 2006 12:06:48 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C99D620FB28; Thu, 28 Sep 2006 12:06:52 -0400 (EDT)
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <86ejtw3sbv.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28011>

"Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
> 
> If this is obvious, can someone fix it?  If not, I'll try to sort it out later
> tonight.
> 
>     gcc -o daemon.o -c -g -O2 -Wall -I/sw/include -I/opt/local/include -DSHA1_HEADER='<openssl/sha.h>' -DNO_STRLCPY daemon.c
>     daemon.c: In function 'fill_in_extra_table_entries':
>     daemon.c:460: error: 'HOST_NAME_MAX' undeclared (first use in this function)
>     daemon.c:460: error: (Each undeclared identifier is reported only once
>     daemon.c:460: error: for each function it appears in.)
>     daemon.c:460: warning: unused variable 'addrbuf'
>     make: *** [daemon.o] Error 1
> 
> This is with 2d5b459107cf07bbb307cfb196c2007c497a6dd2.

According to pickaxe it was dd4676299dde0a4c6f8a471e6353170f86a78c8a.

Looks like HOST_NAME_MAX isn't defined on Darwin.  Looking at how
daemon.c is using it this just needs to be defined to a suitable
length if its not already defined.  Sort of like PATH_MAX on some
other systems...

-- 
Shawn.
