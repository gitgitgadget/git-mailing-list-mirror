From: Jeff King <peff@peff.net>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 15:54:52 -0500
Message-ID: <20100120205452.GA8843@coredump.intra.peff.net>
References: <20100120050343.GA12860@gnu.kitenet.net>
 <201001201148.11701.johan@herland.net>
 <20100120182438.GB31507@gnu.kitenet.net>
 <7vhbqg376b.fsf@alter.siamese.dyndns.org>
 <20100120195626.GA6641@gnu.kitenet.net>
 <7vska01qrt.fsf@alter.siamese.dyndns.org>
 <20100120203636.GA9221@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 21:55:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXha1-0003HF-PV
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 21:55:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062Ab0ATUy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 15:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729Ab0ATUy7
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 15:54:59 -0500
Received: from peff.net ([208.65.91.99]:60693 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240Ab0ATUy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 15:54:58 -0500
Received: (qmail 9781 invoked by uid 107); 20 Jan 2010 20:59:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 20 Jan 2010 15:59:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jan 2010 15:54:52 -0500
Content-Disposition: inline
In-Reply-To: <20100120203636.GA9221@gnu.kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137576>

On Wed, Jan 20, 2010 at 03:36:36PM -0500, Joey Hess wrote:

> I was asking hypothetically, trying to point out that parts of git log
> seem to make sense to be used as plumbing, with the hope I can continue
> to use it that way.
> 
> (Note that git instaweb parses output of git log --pretty=format:%H --raw
> like it's plumbing.)

I think this is a valid point. Note that "gitk" uses "git log
--pretty=raw". However, I believe it splits the entries on "^commit". So
I think there is some precedent for scripting "git log"; it has features
that are simply not available through other interfaces. And scripting
around "--pretty=raw" seems pretty reasonable to me, too. Why else would
you want the raw format?

Is splitting on blank lines an error? I don't think so. The original
format was never strictly defined, but given the --pretty=raw format, it
seems like a fairly obvious thing to do.

I am inclined to cut the notes output from --pretty=raw, and let callers
ask for them explicitly with --show-notes or something similar. We can
leave them on by default in the "normal" output. This will still break
scripts doing "git log | ./script", but I don't think we have ever
condoned that practice.

-Peff
