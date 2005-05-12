From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Wed, 11 May 2005 20:30:38 -0700
Message-ID: <20050512033037.GF1185@ca-server1.us.oracle.com>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com> <1115854733.22180.202.camel@tglx> <200505111941.04104.dtor_core@ameritech.net> <1115858670.22180.259.camel@tglx> <4282ACD3.50009@zytor.com> <4282ADC9.2010900@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, Dmitry Torokhov <dtor_core@ameritech.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 05:23:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW4IR-0005YU-DA
	for gcvg-git@gmane.org; Thu, 12 May 2005 05:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVELDaz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 23:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVELDaz
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 23:30:55 -0400
Received: from rgminet02.oracle.com ([148.87.122.31]:57979 "EHLO
	rgminet02.oracle.com") by vger.kernel.org with ESMTP
	id S261200AbVELDas (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 23:30:48 -0400
Received: from rgmgw2.us.oracle.com (rgmgw2.us.oracle.com [138.1.191.11])
	by rgminet02.oracle.com (Switch-3.1.6/Switch-3.1.7) with ESMTP id j4C3UdhT027882;
	Wed, 11 May 2005 21:30:40 -0600
Received: from rgmgw2.us.oracle.com (localhost [127.0.0.1])
	by rgmgw2.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with ESMTP id j4C3UdIJ028847;
	Wed, 11 May 2005 21:30:39 -0600
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.118.41])
	by rgmgw2.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with ESMTP id j4C3UdDB028839;
	Wed, 11 May 2005 21:30:39 -0600
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.50)
	id 1DW4PH-0005pk-6l; Wed, 11 May 2005 20:30:39 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <4282ADC9.2010900@zytor.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, May 11, 2005 at 06:13:45PM -0700, H. Peter Anvin wrote:
> What I meant with that is I think .git/repoid is the right thing, if the 
> file doesn't exist a new ID file is generated.

	Count me in the "what does repoid help?" camp.  If we create a
new UUID on each clone, imagine this typical usage:

	linux-2.6.git has repoid AAAAAA.
	I clone it locally, local-2.6-clean, repoid BBBBBB
	I clone the local one, local-2.6-working, repoid CCCCCC
	I work in the local one and commit my change.  commit abcd,
		repoid CCCCCC.
	I then rsync, copy, or clone that working repository to some
		place that Linus can pull from.
	I then throw away the copy with repoid CCCCCC, because I'm done
		with that temporary work area.
	lather, rinse, repeat.

	IOW, each of my changes, if I work like this, has a different
repoid.  And when a problem arises, the repoid tells us diddly.  I
thought one of the tenents of bk/git/codeville/whatever development is
that clone is the way to do any temporary area.  You work in a clone or
10, and then clean up for submission.  Which of the 10 clones is the
associated repoid seems, well, unimporant.
	
Joel

-- 

Life's Little Instruction Book #99

	"Think big thoughts, but relish small pleasures."

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
