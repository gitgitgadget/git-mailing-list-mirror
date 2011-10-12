From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fix "git apply --index ..." not to deref NULL
Date: Wed, 12 Oct 2011 10:27:50 -0400
Message-ID: <20111012142750.GB25085@sigill.intra.peff.net>
References: <87lisq8vye.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Wed Oct 12 16:27:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDzmm-0004mJ-Rr
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 16:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433Ab1JLO1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 10:27:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58472
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022Ab1JLO1w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 10:27:52 -0400
Received: (qmail 11337 invoked by uid 107); 12 Oct 2011 14:27:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Oct 2011 10:27:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Oct 2011 10:27:50 -0400
Content-Disposition: inline
In-Reply-To: <87lisq8vye.fsf@rho.meyering.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183370>

On Wed, Oct 12, 2011 at 10:18:01AM +0200, Jim Meyering wrote:

> I noticed this when "git am CORRUPTED" unexpectedly failed with an
> odd diagnostic, and even removed one of the files it was supposed
> to have patched.
> 
> Reproduce with any valid old/new patch from which you have removed
> the "+++ b/FILE" line.  You'll see a diagnostic like this
> 
>     fatal: unable to write file '(null)' mode 100644: Bad address
> 
> and you'll find that FILE has been removed.

Yikes. Your fix looks right to me.

>  builtin/apply.c       |    3 +++
>  t/t4254-am-corrupt.sh |   43 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 0 deletions(-)
>  create mode 100644 t/t4254-am-corrupt.sh

Missing executable bit on the new test.

-Peff
