From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: Trouble building newer git with older
Date: Tue, 8 Aug 2006 17:52:25 -0500
Message-ID: <20060808225225.GA5906@us.ibm.com>
References: <20060808184716.GC4546@us.ibm.com> <7v7j1jvvh7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 09 00:52:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAaRB-0003co-LG
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 00:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbWHHWw2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 18:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbWHHWw2
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 18:52:28 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:25224 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965065AbWHHWw1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Aug 2006 18:52:27 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k78MqRxp029356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Tue, 8 Aug 2006 18:52:27 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k78MqQMw245360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 8 Aug 2006 18:52:26 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k78MqQGQ008847
	for <git@vger.kernel.org>; Tue, 8 Aug 2006 18:52:26 -0400
Received: from joust (dyn9047017076.beaverton.ibm.com [9.47.17.76])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k78MqQeo008817;
	Tue, 8 Aug 2006 18:52:26 -0400
Received: by joust (Postfix, from userid 1000)
	id 7564D936F7; Tue,  8 Aug 2006 17:52:25 -0500 (CDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7j1jvvh7.fsf@assigned-by-dhcp.cox.net>
X-Operating-System: Linux 2.6.15-26-386 (i686)
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25097>

On 08.08.2006 [13:11:16 -0700], Junio C Hamano wrote:
> Nishanth Aravamudan <nacc@us.ibm.com> writes:
> 
> > This is because GIT-VERSION-GEN attempts to invoke `git describe` but
> > describe is not a valid parameter to the current version of git. This is
> > not treated as a failure case, though, as output is stored in VN.
> > Perhaps the return code of `git describe` should also be checked? Or am
> > I just not supposed to upgrade from this old of a version of git via
> > git?
> 
> No, it was broken when this patch was applied.
> 
>         commit 1100ac81a90b03e0c037a286569a340decf7489b
>         Author: Sean <seanlkml@sympatico.ca>
>         Date:   Mon May 22 00:39:52 2006 -0400
> 
> Luckily, my copy of GNU interactive tools, when invoked like this:
> 
> 	git describe --abbrev=4 HEAD 2>/dev/null
> 
> exits with an error code 1, so the existing code already catches it.
> 
> How about this patch?
> 
> -- >8 --
> GIT-VERSION-GEN: adjust for ancient git
> 
> When an ancient "git" that does not understand "describe"
> command is on the $PATH, "git describe" emitted a Usage message
> without exiting non-zero status (which is a mistake we cannot
> fix retroactively).  Catch this case to make sure we do not try
> using phoney multi-line string as a version number.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

Looks good to me and I can confirm this fixes the problem here.

Acked-by: Nishanth Aravamudan <nacc@us.ibm.com>

Thanks,
Nish
