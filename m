From: David Brown <git@davidb.org>
Subject: Re: CFLAGS usage
Date: Fri, 4 Nov 2005 10:23:44 -0800
Message-ID: <20051104182342.GA27711@old.davidb.org>
References: <118833cc0511040721w7f3990fbw631feaa6a4bda936@mail.gmail.com> <7voe50wblp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Morten Welinder <mwelinder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 19:25:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY6ED-0005GG-6R
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 19:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVKDSXt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 13:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVKDSXt
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 13:23:49 -0500
Received: from adsl-64-172-240-129.dsl.sndg02.pacbell.net ([64.172.240.129]:24449
	"EHLO mail.davidb.org") by vger.kernel.org with ESMTP
	id S1750731AbVKDSXt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 13:23:49 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.54 #1 (Debian))
	id 1EY6E4-0007HT-Ul; Fri, 04 Nov 2005 10:23:45 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7voe50wblp.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11149>

On Fri, Nov 04, 2005 at 09:45:38AM -0800, Junio C Hamano wrote:
> Morten Welinder <mwelinder@gmail.com> writes:
> 
> > Various stuff is being added to CFLAGS, but CFLAGS is not being used
> > after being composed in CFLAGS_ALL.
> 
> True.
> 
> We should move ALL_CFLAGS definition at the very end; is
> anything else needed?

Although it will work fine just as it is (it may be misleading, though).
Lazy evaluation in make is important, it allows such things as having
different CFLAGS that for different source files.

  foo.o: CFLAGS += -fspecial-option

And the additional CFLAGS will only apply to the compilation of foo.
Since the ALL_CFLAGS is expanded lazily, it gets expanded for each target,
and the rule above causes CFLAGS to have extra values only on that target.

Dave
