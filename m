From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] log --grep: honor grep.patterntype etc.
 configuration variables
Date: Thu, 4 Oct 2012 04:17:32 -0400
Message-ID: <20121004081732.GD31305@sigill.intra.peff.net>
References: <7v626r48cv.fsf@alter.siamese.dyndns.org>
 <1349314419-8397-1-git-send-email-gitster@pobox.com>
 <1349314419-8397-7-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:13:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtUw-0001w8-9C
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999Ab2JDIRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 04:17:37 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40514 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932554Ab2JDIRf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 04:17:35 -0400
Received: (qmail 17990 invoked by uid 107); 4 Oct 2012 08:18:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Oct 2012 04:18:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Oct 2012 04:17:32 -0400
Content-Disposition: inline
In-Reply-To: <1349314419-8397-7-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206976>

On Wed, Oct 03, 2012 at 06:33:39PM -0700, Junio C Hamano wrote:

> Read grep.extendedregexp, grep.patterntype, etc. from the
> configuration so that "log --grep='<pcre>'" honors the user
> preference without an explicit -P from the command line.
> 
> Now that the callback parameter, which was so far unused, to
> git_log_config() has to be of type "struct rev_info *", stop passing
> it down to git_diff_ui_config().  The latter does not currently take
> any callback parameter, and when it does, we would need to make a
> structure that has rev info and that parameter and pass it to
> git_log_config() anyway, and until that happens, passing NULL will
> be less error prone.

Hmm. So I think this is a nice feature for some people, but I wonder if
we would run into any plumbing compatibility issues. People do tend to
use "log" as plumbing (since rev-list is not as capable). On the other
hand, I'd think most internal uses of "log --grep" would be passing
something along from the user, and the user would be happy to have it
interpreted by their chosen set of rules.

-Peff
