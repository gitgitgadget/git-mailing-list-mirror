From: Jeff King <peff@peff.net>
Subject: Re: libreoffice merge issue ...
Date: Tue, 15 Feb 2011 04:45:46 -0500
Message-ID: <20110215094546.GA25530@sigill.intra.peff.net>
References: <1297699635.31477.253.camel@lenovo-w500>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Norbert Thiebaud <nthiebaud@gmail.com>,
	kendy <kendy@novell.com>
To: Michael Meeks <michael.meeks@novell.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 10:45:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpHTn-0005hx-12
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 10:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608Ab1BOJpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 04:45:49 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:52786 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754587Ab1BOJps (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 04:45:48 -0500
Received: (qmail 29433 invoked by uid 111); 15 Feb 2011 09:45:45 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 15 Feb 2011 09:45:45 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Feb 2011 04:45:46 -0500
Content-Disposition: inline
In-Reply-To: <1297699635.31477.253.camel@lenovo-w500>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166834>

On Mon, Feb 14, 2011 at 04:07:15PM +0000, Michael Meeks wrote:

> Setup (some large repos):
> 
> 	git clone git://anongit.freedesktop.org/libreoffice/libs-core
> 	git checkout integration/dev300_m98
> 	git remote add stage git://anongit.freedesktop.org/libreoffice/staging/@REPO@
> 	git fetch stage
> 
> 	Test[1]:
> 
> 	git merge stage/premerge/dev300_m98
> 	git diff idl/source/cmptools/lex.cxx
> 
> 	yields:
> [a conflict in idl/source/cmptools/lex.cxx]
> 
> 	With the above master hash; whereas with v1.7.3.4 it yields nothing (as
> it should IMHO) - we havn't edited things around that chunk in master.

Interesting. I looked at both sides of the merge and the merge base, and
there definitely should not be a conflict there. The regression bisects
to 83c9031 (unpack_trees(): skip trees that are the same in all input,
2010-12-22). Reverting that commit makes the problem go away.

-Peff
