From: Jeff King <peff@peff.net>
Subject: Re: CVS to git: parsing ChangeLog entries?
Date: Thu, 13 Mar 2008 13:03:22 -0400
Message-ID: <20080313170322.GA3580@sigill.intra.peff.net>
References: <20080312190827.GE3198@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 18:04:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZqqo-0002gh-2R
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 18:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943AbYCMRD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 13:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754017AbYCMRD0
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 13:03:26 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1841 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753022AbYCMRDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 13:03:25 -0400
Received: (qmail 15787 invoked by uid 111); 13 Mar 2008 17:03:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 13 Mar 2008 13:03:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2008 13:03:22 -0400
Content-Disposition: inline
In-Reply-To: <20080312190827.GE3198@ins.uni-bonn.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77105>

On Wed, Mar 12, 2008 at 08:08:27PM +0100, Ralf Wildenhues wrote:

> when migrating a project that uses GNU-style ChangeLogs from CVS
> to git, is it possible to extract patch author information from
> the ChangeLog entries rather than from the CVS commit logs?
> For simplicity let's first assume the project used only one
> ChangeLog file.

I don't think there is a way to do this automatically with
git-cvsimport. However, once imported, I think you could rewrite history
using git-filter-branch with a filter that looked at the diff of
ChangeLog for that commit and rewrote the author. See the documentation
for git-filter-branch.

> Related question: when CVS commit logs have varying encoding,
> say, some latin1 and some UTF-8, is it possible to have uniformly
> encoded git log entries?

I don't think git-cvsimport does much with encodings at all. But again,
you could probably go back through the imported repo with
git-filter-branch and iconv the commit messages as appropriate.

-Peff
