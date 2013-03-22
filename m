From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/4] match-trees: drop "x = x" initializations
Date: Fri, 22 Mar 2013 17:36:28 -0400
Message-ID: <20130322213628.GA7471@sigill.intra.peff.net>
References: <20130322161837.GG3083@sigill.intra.peff.net>
 <20130322162155.GB25857@sigill.intra.peff.net>
 <7v1ub76s8c.fsf@alter.siamese.dyndns.org>
 <7vtxo35dcz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 22:37:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ9e5-0004Tj-Dr
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 22:37:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423037Ab3CVVgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 17:36:37 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36145 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422966Ab3CVVgh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 17:36:37 -0400
Received: (qmail 5663 invoked by uid 107); 22 Mar 2013 21:38:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Mar 2013 17:38:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Mar 2013 17:36:28 -0400
Content-Disposition: inline
In-Reply-To: <7vtxo35dcz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218852>

On Fri, Mar 22, 2013 at 02:33:16PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > These three are all updated by the same tree_entry_extract() call,
> > and whenever we use mode[12] we use path[12], so if it decides path1
> > is used or assigned, it should be able to tell mode1 is, too.
> >
> > Unsatisfactory, it surely is...
> 
> And immediately after I wrote the above, I am greeted by this:
> 
>     gcc (Debian 4.4.5-8) 4.4.5
>     match-trees.c:75: error: 'elem1' may be used uninitialized in this function
>     match-trees.c:77: error: 'path1' may be used uninitialized in this function
> 
> and this crazy one on top squelches it.

Ugh, yeah, I should have tried with more compilers. 4.6 complains, but
4.7 doesn't (although I still find it really weird that 4.7 gets it
_half_ right).

> I'll initialize all of them to nonsense values for now.

I think that's sensible.

-Peff
