From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH v2 1/2] perl: redirect stderr to /dev/null instead of
 closing
Date: Sat, 6 Apr 2013 12:34:26 +0200
Message-ID: <20130406103426.GE6137@machine.or.cz>
References: <20130404011653.GA28492@dcvr.yhbt.net>
 <801ebb2a75d7cddfeee70eb86e8854c78d22eb3e.1365107899.git.trast@inf.ethz.ch>
 <20130405144828.GX6137@machine.or.cz>
 <7vsj34byb4.fsf@alter.siamese.dyndns.org>
 <20130405233450.GA6137@machine.or.cz>
 <878v4wrsj7.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>,
	Marcin Owsiany <marcin@owsiany.pl>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:39:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWTd-0001b9-Hx
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 19:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758083Ab3DFKeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 06:34:31 -0400
Received: from pasky.or.cz ([84.242.80.195]:59555 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757206Ab3DFKea (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 06:34:30 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id B95FB1700058; Sat,  6 Apr 2013 12:34:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <878v4wrsj7.fsf@linux-k42r.v.cablecom.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220221>

On Sat, Apr 06, 2013 at 10:07:40AM +0200, Thomas Rast wrote:
> The manpage for dup2 does, however, say
> 
>    If newfd was open, any errors  that  would  have  been  reported  at
>    close(2) time are lost.  A careful programmer will not use dup2() or
>    dup3() without closing newfd first.
> 
> which is probably what you were referring to.

Yes, that's probably one reason why I had this stuck in my mind (though,
how often does anyone bother to detect errors on close()...? ;-).

Funnily enough, POSIX.2008 specifies that if closing newfd would fail,
dup2() reports EIO and newfd is not closed, eliminating this problem.

The manpage does not cover this; well, that's fair enough as Linux just
doesn't care and never does that if I didn't miss anything in the code.

-- 
			Petr "Pasky who might even send
				a patch, but the matter is
				oh so obscure" Baudis
