From: Jeff King <peff@peff.net>
Subject: Re: [HELP] Adding git awareness to the darning patch management
 system.
Date: Wed, 30 Nov 2011 02:22:48 -0500
Message-ID: <20111130072248.GG5317@sigill.intra.peff.net>
References: <4ED59232.3000807@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Peter Williams <peter_ono@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Nov 30 08:22:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVeVP-0005lF-4T
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 08:22:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919Ab1K3HWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 02:22:51 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56037
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193Ab1K3HWu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 02:22:50 -0500
Received: (qmail 8176 invoked by uid 107); 30 Nov 2011 07:29:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Nov 2011 02:29:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Nov 2011 02:22:48 -0500
Content-Disposition: inline
In-Reply-To: <4ED59232.3000807@users.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186113>

On Wed, Nov 30, 2011 at 12:17:22PM +1000, Peter Williams wrote:

> 1. presenting the file tree of the sources being patched in a way
> that makes sense to the user including the current status of files
> from the point of view of the underlying SCM (in this case, git), and

I'm not exactly sure what this means.

> 2. detecting files with uncommitted changes (from the SCM's point of
> view) when the user adds them to a patch (or pushes a patch that
> contains them) so that they may be alerted to the fact and offered
> the choice of absorbing the uncommitted changes into the patch (or
> not).

For this, you probably want "git diff-files --name-only", which will
show files with differences in the working tree. Keep in mind that git
has an "index" or "staging area", which means that you have three states
of content for a given path:

  1. the state of the prior commit (i.e., HEAD)

  2. the state that is marked to be committed when "git commit" is run
     (i.e., the index)

  3. the state in the working tree

You can compare the first two with "git diff-index", and the latter two
with "git diff-files". You can also use "git status --porcelain" to get
a machine-readable output that shows how the three states match up, with
one line per file.

> I've already implemented this interface for Mercurial (with which I
> am familiar) and looked at doing the same with git but had difficulty
> discovering the definitive mechanisms for obtaining the necessary
> data.  So I'm soliciting your help in overcoming these problems.

I hope the above helps you some. If not, just ask. It might be easier to
understand what you are looking for if you can give concrete examples.

-Peff
