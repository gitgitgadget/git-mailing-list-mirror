From: Jeff King <peff@peff.net>
Subject: Re: encrypted repositories?
Date: Thu, 23 Jul 2009 06:40:32 -0400
Message-ID: <20090723104032.GB4247@coredump.intra.peff.net>
References: <op.uw7wmbr41e62zd@balu.cs.uni-paderborn.de>
 <alpine.LFD.2.01.0907171226460.13838@localhost.localdomain>
 <op.uxc712eh1e62zd@balu.cs.uni-paderborn.de>
 <20090720153024.GD5347@coredump.intra.peff.net>
 <op.uxesdcu41e62zd@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 23 12:40:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTvj9-00057q-Fy
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 12:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbZGWKkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 06:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752881AbZGWKkg
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 06:40:36 -0400
Received: from peff.net ([208.65.91.99]:56907 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752272AbZGWKkf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 06:40:35 -0400
Received: (qmail 10001 invoked by uid 107); 23 Jul 2009 10:42:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 23 Jul 2009 06:42:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jul 2009 06:40:32 -0400
Content-Disposition: inline
In-Reply-To: <op.uxesdcu41e62zd@merlin.emma.line.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123864>

On Tue, Jul 21, 2009 at 10:25:50AM +0200, Matthias Andree wrote:

> >The problem is that you need to expose not just the DAG, but also the
> >hashes of trees and blobs. Because if I know you have master^, and I want
> >to send you master, then I need to know which objects are referenced by
> >master that are not referenced by master^.
> 
> Yes, you need to know that.  Not all of the push logic needs to be
> implemented on the server though.

Yes, though fetching is much harder, since the server is the one holding
the information about how the transfer can be optimized. Still, you
should be able to achieve roughly the same performance as http fetching
from a dumb server.

> Or look at commit frequency and push sources. There's always a leak
> of information even if I just upload a series of
> blah-2009MMDD-NNN.tar.lzma.gpg files... The data is going to be
> obsolete, say, 3 months; students then write the exam and then it's
> sort of public anyways. Even if your model does not entail not
> publishing exams (as opposed to embargoed press releases under
> development), but you can't prevent someone from writing their
> recollection of the problems from memory afterwards and sharing it
> with other students.
> [...]
> Is your concern that the object name (SHA1) is derived from the
> unencrypted version?

Yes. You are potentially leaking considerable information about the
unencrypted contents which an attacker could use to guess those contents
(especially if the file is mostly composed of low-entropy parts, like
text formatting).

-Peff
