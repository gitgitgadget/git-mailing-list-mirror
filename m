From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Cleaning up die() error messages
Date: Tue, 11 Oct 2005 22:02:36 -0700
Message-ID: <7vek6rnx8z.fsf@assigned-by-dhcp.cox.net>
References: <20051010105008.GB30202@gentoo.org>
	<7vzmph42j2.fsf@assigned-by-dhcp.cox.net>
	<pan.2005.10.11.19.48.04.675482@smurf.noris.de>
	<434C2590.3040107@zytor.com>
	<pan.2005.10.12.01.20.17.917829@smurf.noris.de>
	<434C8095.4080201@zytor.com> <7vd5mbqs2x.fsf@assigned-by-dhcp.cox.net>
	<434C93C5.9040505@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 07:04:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPYla-0005wb-F9
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 07:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbVJLFCi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 01:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbVJLFCi
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 01:02:38 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:19141 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932446AbVJLFCh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 01:02:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051012050228.HVXU4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Oct 2005 01:02:28 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <434C93C5.9040505@zytor.com> (H. Peter Anvin's message of "Tue,
	11 Oct 2005 21:40:37 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10006>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Not unless any of those linked structures can be reached from outside 
> the git library.

OK.  How about things like open file descriptors and mmap'ed
regions then?  That is:

    fd = open();
    xmalloc(); /* may die now */
    close(fd);

I think in the long run we would be better off if we properly
dealt with the case where (x)malloc returns NULL.  Of course,
that would make libification a bigger task, so we do not have to
do it from day one.
