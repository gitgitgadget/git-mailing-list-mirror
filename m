From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 3 Oct 2007 12:59:27 -0400
Message-ID: <20071003165927.GA25055@coredump.intra.peff.net>
References: <20070927023633.GA28902@coredump.intra.peff.net> <20071002041652.GA32133@coredump.intra.peff.net> <7vsl4up0tf.fsf@gitster.siamese.dyndns.org> <20071002050820.GA4261@coredump.intra.peff.net> <20071002051332.GA4462@coredump.intra.peff.net> <86ejge6o8b.fsf@lola.quinscape.zz> <20071002161114.GC6828@coredump.intra.peff.net> <86ve9p32cp.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0710021916080.3579@woody.linux-foundation.org> <85641oy5ge.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 18:59:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id7ZT-0008Tf-BG
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 18:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbXJCQ7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 12:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbXJCQ7a
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 12:59:30 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3906 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035AbXJCQ7a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 12:59:30 -0400
Received: (qmail 18136 invoked by uid 111); 3 Oct 2007 16:59:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 03 Oct 2007 12:59:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2007 12:59:27 -0400
Content-Disposition: inline
In-Reply-To: <85641oy5ge.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59858>

On Wed, Oct 03, 2007 at 10:20:49AM +0200, David Kastrup wrote:

> Part of the reason is that it is not actually what I had in mind.  Why
> create the hash array as a hash array?  Filling the hash array in
> basically random order, then sort+compressing it is what is causing
> much of the costs.  My idea was to just fill the "hash array"
> linearly.  It is quite pointless (and certainly very inefficient with
> regard to cache poisoning) to do it in hash order when we are going to
> sort it anyway.

Try profiling the code, and you will see that the creation of the hashes
is totally dwarfed by the comparisons. So yes, you might be able to
speed up the creation code, but it's going to have a minimal impact on
the overall run time.

-Peff
