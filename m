From: Jeff King <peff@peff.net>
Subject: Re: Gitweb 1.7.5 and Textconv Configuration
Date: Sat, 2 Jul 2011 06:43:13 -0400
Message-ID: <20110702104313.GA10245@sigill.intra.peff.net>
References: <CALWDD1x-_rEx+c9bpAgVk-hvnGz1bt0mbJoDkSjZkbe=gLscUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Al Haraka <alharaka@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 02 12:53:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qcxp4-0006it-8x
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 12:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309Ab1GBKnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jul 2011 06:43:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59510
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754199Ab1GBKnR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2011 06:43:17 -0400
Received: (qmail 15938 invoked by uid 107); 2 Jul 2011 10:43:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 02 Jul 2011 06:43:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Jul 2011 06:43:13 -0400
Content-Disposition: inline
In-Reply-To: <CALWDD1x-_rEx+c9bpAgVk-hvnGz1bt0mbJoDkSjZkbe=gLscUg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176553>

On Sat, Jul 02, 2011 at 12:50:12PM +0300, Al Haraka wrote:

> So, I tried different variations of this, specifically for repos.
> Now, I have tried it globally as that was tedious and it was not
> working anyway. That works some of the time if I try commands over the
> console (git log  -p for quick testing), but never in Gitweb.  It
> continues to only say they are differing binary files.  Does Gitweb
> 1.7.5 support the use of this?  Is there something special I must do?
> Below is my current config:

The default gitweb configuration doesn't allow textconv (or external
diff) for security reasons; it would mean repo owners could execute
arbitrary commands as the gitweb user.

If that's OK for your site, you can probably enable it with:

  push @diff_opts, '--allow-textconv';

I don't know that anybody has tested that, though. It will use textconv
_everywhere_ in gitweb, including the "format-patch" invocation for
showing raw patches of commits. It might make sense in the long run for
gitweb to have another variable like @diff_opts that is used for
human-readable output (e.g., the HTML output, but not anything you might
import to a tool).

-Peff
