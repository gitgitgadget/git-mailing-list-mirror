From: "Josh England" <jjengla@sandia.gov>
Subject: Re: [PATCH] Add post-merge hook.
Date: Tue, 04 Sep 2007 14:32:55 -0600
Message-ID: <1188937975.6192.59.camel@beauty>
References: <11885136172952-git-send-email-jjengla@sandia.gov>
 <7v7inc7hao.fsf@gitster.siamese.dyndns.org>
 <1188923110.6192.15.camel@beauty>
 <7vmyw2ny05.fsf@gitster.siamese.dyndns.org>
 <1188934573.6192.35.camel@beauty>
 <7vodgimc53.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 22:32:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISf4I-0003Oy-Vj
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 22:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620AbXIDUcJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 16:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753474AbXIDUcI
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 16:32:08 -0400
Received: from mm03snlnto.sandia.gov ([132.175.109.20]:4851 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490AbXIDUcH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 16:32:07 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Tue, 04 Sep 2007 14:31:46 -0600
X-Server-Uuid: 6CEB1540-FE13-491B-9872-FD67060ED864
Received: from [132.175.2.191] (beauty.son.sandia.gov [132.175.2.191])
 by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id l84KVjeW012732;
 Tue, 4 Sep 2007 14:31:45 -0600
In-Reply-To: <7vodgimc53.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940,
 Antispam-Data: 2007.9.4.130324
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0,
 __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0,
 __MIME_VERSION 0, __SANE_MSGID 0'
X-TMWD-Spam-Summary: TS=20070904203147; SEV=2.2.2; DFV=B2007090415;
 IFV=2.0.4,4.0-9; AIF=B2007090415; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230372E34364444433042332E303037303A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007090415_5.02.0125_4.0-9
X-WSS-ID: 6AC31F382E01264165-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57641>

On Tue, 2007-09-04 at 13:03 -0700, Junio C Hamano wrote:
> >> >>  * Do you want to run the post-merge hook even for a squash
> >> >>    merge?
> >> >
> >> > Yes.  I'd like to run it at any time that the working tree might be
> >> > updated.
> >> 
> >> If that is the case, perhaps your hook may want to get a
> >> parameter to tell it what kind of "git-merge" invocation it was?
> >> Squash merge does not even advance the HEAD and is of a very
> >> different nature from a normal merge.
> >
> > OK.  Should it just pass in a flag (squash or normal), or are there
> > other merge types it should need to know about.
> 
> I suspect you have thought abuot the issues involved longer than
> I have ;-), so you should take whatever I say with grain of
> salt, but I think you would also want to know fast-forwards and
> up-to-dates if the hook wants to be generic, not "for Josh's
> workflow only".

Generic is great, I'm just trying to figure out when/why someone would
need to know the exact type of merge operation used.  The hook should be
generic, yet not require an end user to know any git internals not
explicitly mentioned in the git-merge man page.  I'm thinking that it
will be sufficient to pass a flag indicating whether the working tree
has been modified or not.  The flag can be set for normal merge and
fast-forward merges, and unset for up-to-dates and squash merges.  I
don't really know git internals myself.  Am I missing anything?

-JE
