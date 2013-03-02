From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] am --abort on null cache entries fails
Date: Fri, 1 Mar 2013 19:57:05 -0500
Message-ID: <20130302005705.GB15836@sigill.intra.peff.net>
References: <51314D40.9030209@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
X-From: git-owner@vger.kernel.org Sat Mar 02 01:57:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBala-0001ks-7M
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 01:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559Ab3CBA5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 19:57:08 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39683 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751269Ab3CBA5H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 19:57:07 -0500
Received: (qmail 6052 invoked by uid 107); 2 Mar 2013 00:58:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Mar 2013 19:58:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Mar 2013 19:57:05 -0500
Content-Disposition: inline
In-Reply-To: <51314D40.9030209@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217317>

On Fri, Mar 01, 2013 at 04:52:16PM -0800, Stephen Boyd wrote:

> I was trying git am -3 with a patch that touched files that didn't exist
> in the branch I was on. Obviously it failed badly, so I wanted to abort
> out of the git am state with git am --abort. Unfortunately, it seems
> that git am --abort in this scenario fails with this error:
> 
> error: cache entry has null sha1: <non-existant-file>
> 
> and then leaves the file in my working tree untracked. This didn't used
> to happen, so I bisected it down to this commit
> 
> commit 4337b5856f88f18da47c176e3cbc95a35627044c
> Author: Jeff King <peff@peff.net>
> Date: Sat Jul 28 11:05:24 2012 -0400
> do not write null sha1s to on-disk index
> 
> Which definitely introduced that error message.

Yep. It's a bug, but that commit does not introduce it; it actually just
notices the bug earlier.

> How do we fix this?

See this thread for the current discussion and some possible fixes:

  http://thread.gmane.org/gmane.comp.version-control.git/217172

-Peff
