From: Jeff King <peff@peff.net>
Subject: Re: [PATCH, take 1] Linear-time/space rename logic (exact renames
	only)
Date: Mon, 22 Oct 2007 03:21:53 -0400
Message-ID: <20071022072153.GA6205@coredump.intra.peff.net>
References: <alpine.LFD.0.999.0710211603200.10525@woody.linux-foundation.org> <20071022070750.GM1179MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Kastrup <dak@gnu.org>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon Oct 22 09:22:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijrbz-00036H-Oo
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 09:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbXJVHV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 03:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbXJVHV4
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 03:21:56 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2313 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235AbXJVHVz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 03:21:55 -0400
Received: (qmail 18090 invoked by uid 111); 22 Oct 2007 07:21:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 22 Oct 2007 03:21:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Oct 2007 03:21:53 -0400
Content-Disposition: inline
In-Reply-To: <20071022070750.GM1179MdfPADPa@greensroom.kotnet.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61964>

On Mon, Oct 22, 2007 at 09:07:50AM +0200, Sven Verdoolaege wrote:

> Aren't you truncating the ptr list after the first entry here?
> (While you still need the whole list in free_file_table.)

Yes, good eyes. And because we actually reverse the list, it's not as
simple as just sticking the two broken up pieces together again; the
original head must end up as the head of the list after they are glued
together again, but it is actually the tail of one of the lists.

-Peff
