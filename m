From: Junio C Hamano <junkio@cox.net>
Subject: Re: CFLAGS usage
Date: Fri, 04 Nov 2005 10:47:46 -0800
Message-ID: <7vek5ww8q5.fsf@assigned-by-dhcp.cox.net>
References: <118833cc0511040721w7f3990fbw631feaa6a4bda936@mail.gmail.com>
	<7voe50wblp.fsf@assigned-by-dhcp.cox.net>
	<20051104182342.GA27711@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Morten Welinder <mwelinder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 19:50:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY6bR-00064g-P2
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 19:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbVKDSrt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 13:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVKDSrt
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 13:47:49 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:30973 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750826AbVKDSrs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 13:47:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051104184705.HGP29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Nov 2005 13:47:05 -0500
To: David Brown <git@davidb.org>
In-Reply-To: <20051104182342.GA27711@old.davidb.org> (David Brown's message of
	"Fri, 4 Nov 2005 10:23:44 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11151>

David Brown <git@davidb.org> writes:

> And the additional CFLAGS will only apply to the compilation of foo.
> Since the ALL_CFLAGS is expanded lazily, it gets expanded for each target,
> and the rule above causes CFLAGS to have extra values only on that target.

Lazy expansion is true, but the reason we did ALL_CFLAGS was to
make CFLAGS overridable from the command line.

I suspect that this would currently fail to add -I/some/where/include
on the compilation command line:

	make CFLAGS='-Os -g' CURLDIR=/some/where

while CURL_LIBCURL is set correctly on the linkage command line.
