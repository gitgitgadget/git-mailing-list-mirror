From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] Trace into a file if GIT_TRACE can interpreted as a filename.
Date: Wed, 16 Aug 2006 14:18:56 -0700
Message-ID: <7vhd0c2xbz.fsf@assigned-by-dhcp.cox.net>
References: <20060816225846.ae424b46.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 23:19:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDSn1-0002CT-T3
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 23:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWHPVTA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 17:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWHPVTA
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 17:19:00 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:43958 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932236AbWHPVS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 17:18:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060816211857.NNSO554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Aug 2006 17:18:57 -0400
To: Christian Couder <chriscool@tuxfamily.org>
In-Reply-To: <20060816225846.ae424b46.chriscool@tuxfamily.org> (Christian
	Couder's message of "Wed, 16 Aug 2006 22:58:46 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25530>

Christian Couder <chriscool@tuxfamily.org> writes:

> So this change is not compatible with the previous
> behavior, because stderr will not be used anymore if
> GIT_TRACE is set to something other than "1" or "true".
> No file locking is done. This maybe a problem.

I wonder if we can pass an already opened file descriptor to
GIT_TRACE.  E.g.

	GIT_TRACE=9 make test 9>/var/tmp/trace.log

and make the trace code to emit the message with one write(2) to
make sure messages from processes do not get mixed up in the
middle.
