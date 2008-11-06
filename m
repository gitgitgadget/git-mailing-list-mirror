From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC v3] git add -i: Answer questions with a single
	keypress
Date: Thu, 6 Nov 2008 03:42:36 -0500
Message-ID: <20081106084230.GA4407@sigill.intra.peff.net>
References: <200811042215.31147.sunaku@gmail.com> <200811050959.25824.sunaku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Suraj N. Kurapati" <sunaku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 06 09:44:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky0Tf-0005si-Ib
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 09:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386AbYKFIm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 03:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753364AbYKFIm7
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 03:42:59 -0500
Received: from peff.net ([208.65.91.99]:2240 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753386AbYKFIm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 03:42:58 -0500
Received: (qmail 18908 invoked by uid 111); 6 Nov 2008 08:42:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 06 Nov 2008 03:42:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Nov 2008 03:42:36 -0500
Content-Disposition: inline
In-Reply-To: <200811050959.25824.sunaku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100220>

On Wed, Nov 05, 2008 at 09:59:25AM -0800, Suraj N. Kurapati wrote:

> Allows the user to answer 'Stage this hunk' questions with a
> single keypress, just like in Darcs.  Previously, the user was
> forced to press the Return key after every choice they made.
> This quickly becomes tiring, burdensome work for the fingers.

I think this is a reasonable goal, but I have a few questions/concerns.

 - There are three versions of your patch, but nobody has commented.
   Clearly we can see what changed, but it is not clear what advantage
   one patch has over the other. Care to elaborate?

 - Term::ReadKey, while common, is not part of base perl. So I think
   using it needs to be conditional, and on systems without it we can
   degrade to the current behavior.

 - There's no facility in your patch for restoring the terminal if we
   break out of the loop in an unexpected way (e.g., via the user
   hitting ^C).

 - This only enhances one particular input, the patch loop. It is
   probably worth being consistent and allowing these behavior for other
   menus (though the numeric inputs are a bit trickier).

-Peff
