From: Jeff King <peff@peff.net>
Subject: Re: diffcore-rename performance mode
Date: Tue, 18 Sep 2007 05:01:05 -0400
Message-ID: <20070918090105.GA11854@coredump.intra.peff.net>
References: <20070918082321.GA9883@coredump.intra.peff.net> <7vsl5cwe6p.fsf@gitster.siamese.dyndns.org> <20070918085413.GA11751@coredump.intra.peff.net> <7vhclswdsm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 11:01:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXYxJ-0003lY-Gr
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 11:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbXIRJBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 05:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbXIRJBJ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 05:01:09 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3445 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067AbXIRJBI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 05:01:08 -0400
Received: (qmail 26263 invoked by uid 111); 18 Sep 2007 09:01:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 18 Sep 2007 05:01:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Sep 2007 05:01:05 -0400
Content-Disposition: inline
In-Reply-To: <7vhclswdsm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58556>

On Tue, Sep 18, 2007 at 01:58:17AM -0700, Junio C Hamano wrote:

> > I thought we were holding counts of hashes, in which case there _is_ no
> > overflow.
> 
> The raw hashval (the fingerprint recorded in struct spanhash) is
> further reduced and used as an index into spahash_top.data[].
> So more than one hashval can try to sit in the same slot in
> spanhash_top.data[] array.

Right, that's sort of what I was hinting at in the original message. Can
we just make the hash table big enough to use the fingerprint hashes
directly? It's going to use a bit more memory, but lookups should be
very fast. I'll try to experiment and get some numbers.

-Peff
