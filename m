From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCHv2 03/10] refs.c: Refactor code for mapping between
 shorthand names and full refnames
Date: Wed, 15 May 2013 19:49:59 +0000
Message-ID: <20130515194959.GB28720@dcvr.yhbt.net>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
 <1368289280-30337-4-git-send-email-johan@herland.net>
 <7vmwrzsck1.fsf@alter.siamese.dyndns.org>
 <CALKQrgf0m8r-Ofb+Ss1OpEF67dPS73b8nB+usVxH=Y=h3441Wg@mail.gmail.com>
 <7v8v3jqsy7.fsf@alter.siamese.dyndns.org>
 <7vwqr2liv6.fsf@alter.siamese.dyndns.org>
 <CALKQrgcDBMPeXPzTnpGyeosipR6Ln_zLh4Q_i1A7-eFUnTnBcA@mail.gmail.com>
 <51932F1B.9000200@alum.mit.edu>
 <CALKQrgdsBzcdtyej=qvaL-2rr-5t_UzXdOL-ZZ3a-rGW5V_i7Q@mail.gmail.com>
 <CALKQrgdroLDSf=Xc58NiHSf7fp8cRMbrR0mGrfKY7Rg0FpPFJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jrnieder@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed May 15 21:50:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UchiB-0001AA-0o
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 21:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757548Ab3EOTuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 15:50:00 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53402 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753086Ab3EOTuA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 15:50:00 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE86D1F44D;
	Wed, 15 May 2013 19:49:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CALKQrgdroLDSf=Xc58NiHSf7fp8cRMbrR0mGrfKY7Rg0FpPFJg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224445>

Johan Herland <johan@herland.net> wrote:
> Unfortunately, using "refs/remotes/%1/%*" instead of "refs/remotes/%*"
> breaks a number of git-svn tests which puts refs directly within
> refs/remotes/, and then does things like "git reset --hard trunk"
> (expecting trunk -> refs/remotes/trunk, which the refs/remotes/%1/%*
> doesn't match).
> 
> I don't know if putting refs directly within refs/remotes/ is
> something that git-svn does by default (which would prevent us from
> changing "refs/remotes/%*" to "refs/remotes/%1/%*"), or whether it is
> specific to the tests (in which case we should fix the tests).

Yes, git-svn uses refs/remotes/%* by default.

This was a design mistake on my part.  I think it's too late to change,
now, as existing users will encounter breakage and/or out-of-date
documentation (which is even more confusing, as git-svn is often the
first introduction to git for SVN users).
