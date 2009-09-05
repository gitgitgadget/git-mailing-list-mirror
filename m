From: Jeff King <peff@peff.net>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Sat, 5 Sep 2009 02:18:04 -0400
Message-ID: <20090905061804.GB29863@coredump.intra.peff.net>
References: <20090902080305.GA11549@neumann>
 <20090902081917.GA5447@coredump.intra.peff.net>
 <20090904070216.GA3996@darc.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Sep 05 08:18:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjobH-0007sv-Dw
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 08:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbZIEGSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 02:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbZIEGSG
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 02:18:06 -0400
Received: from peff.net ([208.65.91.99]:48492 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089AbZIEGSF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 02:18:05 -0400
Received: (qmail 25134 invoked by uid 107); 5 Sep 2009 06:18:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 05 Sep 2009 02:18:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Sep 2009 02:18:04 -0400
Content-Disposition: inline
In-Reply-To: <20090904070216.GA3996@darc.dnsalias.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127780>

On Fri, Sep 04, 2009 at 09:02:16AM +0200, Clemens Buchacher wrote:

> On Wed, Sep 02, 2009 at 04:19:17AM -0400, Jeff King wrote:
> 
> > [1] I would prefer "git add -u ." to add only the current directory, and
> > "git add -u" to touch everything.
> 
> FWIW, I feel the same way. And there is no easy way to do that now. (cd `git
> rev-parse --show-cdup`; git add -u) ?

I suspect it is too late to change it due to compatibility issues. OTOH,
I think the intent of v1.7.0 is to allow a few small breakages like
these. You could always write an RFC patch and generate some discussion;
I'm not 100% sure that there are enough people that agree with us to
change the default.

I guess we could add a "git add --absolute" option, though it is
slightly annoying, because I generally do not realize that I needed to
use such an option until several minutes after running "git add".

I would be fine with a "be absolute, not relative" config option such as
what we have for status (in fact, a global "be absolute, not relative"
option to cover all commands might be handy). The only obstacle is that
I think "git add" is often used as plumbing in scripts (arguably, they
should be using update-index, but "git add ." is just so convenient).

-Peff
