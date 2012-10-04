From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] log --grep: accept --basic-regexp and --perl-regexp
Date: Thu, 4 Oct 2012 04:12:12 -0400
Message-ID: <20121004081212.GC31305@sigill.intra.peff.net>
References: <7v626r48cv.fsf@alter.siamese.dyndns.org>
 <1349314419-8397-1-git-send-email-gitster@pobox.com>
 <1349314419-8397-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:33:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtUp-0001w8-A2
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381Ab2JDIMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 04:12:17 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40505 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754446Ab2JDIMP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 04:12:15 -0400
Received: (qmail 17947 invoked by uid 107); 4 Oct 2012 08:12:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Oct 2012 04:12:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Oct 2012 04:12:12 -0400
Content-Disposition: inline
In-Reply-To: <1349314419-8397-5-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207009>

On Wed, Oct 03, 2012 at 06:33:37PM -0700, Junio C Hamano wrote:

> When we added the "--perl-regexp" option (or "-P") to "git grep", we
> should have done the same for the commands in the "git log" family,
> but somehow we forgot to do so.  This corrects it.
> 
> Also introduce the "--basic-regexp" option for completeness, so that
> the "last one wins" principle can be used to defeat an earlier -E
> option, e.g. "git log -E --basic-regexp --grep='<bre>'".  Note that
> it cannot have the short "-G" option as the option is to grep in the
> patch text in the context of "log" family.

Good, I think the addition of --basic-regexp is a nice touch.

> +	} else if (!strcmp(arg, "--perl-regexp") || !strcmp(arg, "-P")) {
> +		grep_set_pattern_type_option(GREP_PATTERN_TYPE_PCRE, &revs->grep_filter);

Do we want to yield short-and-sweet "-P" to perl-regexp? git-grep does
so to match GNU grep, but we are not matching anything here (except
ourselves in git-grep). I'd think most people who use it regularly would
just set grep.patternType.

I could go either way, though.

-Peff
