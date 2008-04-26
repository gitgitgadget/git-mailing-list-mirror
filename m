From: Jeff King <peff@peff.net>
Subject: Re: warning: too many files, skipping inexact rename detection
Date: Sat, 26 Apr 2008 10:52:36 -0400
Message-ID: <20080426145236.GA4367@sigill.intra.peff.net>
References: <20080426063209.5615dd5e.akpm@linux-foundation.org> <20080426135737.GA382@sigill.intra.peff.net> <20080426070656.e7a01d91.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 16:54:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jplmg-0001kD-6n
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 16:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758550AbYDZOwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 10:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753369AbYDZOwh
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 10:52:37 -0400
Received: from peff.net ([208.65.91.99]:4902 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758550AbYDZOwg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 10:52:36 -0400
Received: (qmail 27929 invoked by uid 111); 26 Apr 2008 14:52:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 26 Apr 2008 10:52:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Apr 2008 10:52:36 -0400
Content-Disposition: inline
In-Reply-To: <20080426070656.e7a01d91.akpm@linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80380>

On Sat, Apr 26, 2008 at 07:06:56AM -0700, Andrew Morton wrote:

> > The default rename limit is 100, but you can bump it via the
> > diff.renamelimit config option.
> 
> <wonders how to set that>

git config --global diff.renamelimit 200

(or edit your ~/.gitconfig)

> > Are you running into actual problems with rename detection, or is the
> > message just too scary and confusing?
> 
> No observed problems, just scared!
> 
> I don't use rename detection anyway - I use git to extract plain old diffs
> only.

Ah, OK. If you are just doing a fast-forward merge, there is no rename
detection going on as part of the merge. But the diffstat for a large is
probably enough to trigger this behavior. So perhaps we should only
print that message on merges.

> Perhaps the default should be bumped up a bit based on your measurements,
> dunno.

Probably. I'll work up a patch for that, as well as suppressing the
message on diffstat (where you really shouldn't care, and it serves only
to scare users).

-Peff
