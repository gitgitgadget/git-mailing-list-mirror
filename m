From: Jeff King <peff@peff.net>
Subject: Re: Does "git config --local core.excludefiles" exclude files in a
 single repository?
Date: Tue, 3 Jul 2012 03:30:16 -0400
Message-ID: <20120703073016.GC16679@sigill.intra.peff.net>
References: <A0DB01D693D8EF439496BC8B037A0AEF02C738@xmb-rcd-x15.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"git-users(mailer list)" <git-users@cisco.com>
To: "Matt Seitz (matseitz)" <matseitz@cisco.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 09:30:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlxZ3-0002RP-PJ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 09:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549Ab2GCHaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 03:30:20 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:52117
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752086Ab2GCHaU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 03:30:20 -0400
Received: (qmail 19041 invoked by uid 107); 3 Jul 2012 07:30:27 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jul 2012 03:30:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2012 03:30:16 -0400
Content-Disposition: inline
In-Reply-To: <A0DB01D693D8EF439496BC8B037A0AEF02C738@xmb-rcd-x15.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200904>

On Fri, Jun 29, 2012 at 06:11:06PM +0000, Matt Seitz (matseitz) wrote:

> Will git ignore files in an exclusion file that is specified in a
> local ($GIT_DIR/config) "core.excludefiles" configuration option?

Yes, git should treat it the same as if it were mentioned in
$HOME/.gitconfig (modulo the correct spelling of "core.excludesfile").
It will override any core.excludesfile found in a system-level or
user-level git config file.

> I know that "$GIT_DIR/info/exclude" is normally used for listing files
> that a single user wants exclude from a single repository.  And I know
> that "git config --global core.excludefiles=<file>" is normally used
> for listing files that a single user wants to exclude from all
> repositories.  But I didn't see any explicit documentation for whether
> "git config core.excludefiles=<file>" would exclude files for a single
> user in a single repository.

In general, git does not care about the exact source of config
variables. Options in more specific files override less-specific ones,
but there is no per-variable code that cares specifically about the
location of core.excludesfile or any other option.

-Peff
