From: Jeff King <peff@peff.net>
Subject: Re: Cannot rewrite branch(es) with a dirty working directory
Date: Thu, 1 Sep 2011 17:50:03 -0400
Message-ID: <20110901215003.GC16308@sigill.intra.peff.net>
References: <CACyv8dfL-G0Px0aFe3VFNHP-1xRUDLsFxgUu3amPGzO7qKp7jQ@mail.gmail.com>
 <vpqmxeoqj61.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James Blackburn <jamesblackburn@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 01 23:50:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzF9K-0005VR-Lm
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 23:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758061Ab1IAVuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 17:50:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51449
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757961Ab1IAVuG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 17:50:06 -0400
Received: (qmail 24745 invoked by uid 107); 1 Sep 2011 21:50:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Sep 2011 17:50:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Sep 2011 17:50:03 -0400
Content-Disposition: inline
In-Reply-To: <vpqmxeoqj61.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180574>

On Thu, Sep 01, 2011 at 07:14:30PM +0200, Matthieu Moy wrote:

> James Blackburn <jamesblackburn@gmail.com> writes:
> 
> > Is there a particular reason why filter-branch thinks the tree is
> > dirty,
> 
> No idea. It comes after a "git reset --hard", so it's supposed to be
> clean.

I wonder if there are racily clean entries[1] in the index, and
diff-index reports them as potential changes.

At any rate, filter-branch should probably be refreshing the index
before checking for dirtiness, which would give the correct answer
either way.

-Peff

[1] See Documentation/technical/racy-git.txt for more information.
