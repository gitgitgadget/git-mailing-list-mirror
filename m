From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] tests: suppress global and system gitattributes
Date: Tue, 15 Mar 2011 03:16:25 -0400
Message-ID: <20110315071625.GA11754@sigill.intra.peff.net>
References: <20110315064909.GA25738@elie>
 <20110315065643.GB29530@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Onderka <gsvick@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 08:17:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzOVu-0005C3-L2
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 08:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754457Ab1COHQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 03:16:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38075
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754389Ab1COHQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 03:16:27 -0400
Received: (qmail 19617 invoked by uid 107); 15 Mar 2011 07:16:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Mar 2011 03:16:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Mar 2011 03:16:25 -0400
Content-Disposition: inline
In-Reply-To: <20110315065643.GB29530@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169049>

On Tue, Mar 15, 2011 at 01:56:43AM -0500, Jonathan Nieder wrote:

> Set GIT_ATTR_NOGLOBAL and GIT_ATTR_NOSYSTEM in test-lib to make
> tests more reliable in two ways:
> 
>  - an invalid GIT_ATTR_NOGLOBAL or GIT_ATTR_NOSYSTEM setting
>    should not cause tests to fail with
> 
> 	fatal: bad config value for 'GIT_ATTR_NOGLOBAL'
> 
>  - /etc/gitattributes should not change the outcome of tests.

We already munge $HOME, as you note in 1/3, I don't know that there is
much point in setting GIT_ATTR_NOGLOBAL. The alternative would be to
drop your 1/3 and unset GIT_ATTR_NOGLOBAL in test-lib.sh.

I don't care much either way. Having it set prevents others tests from
accidentally triggering global attributes (since we have the odd case of
$HOME and the repo in the same directory). But IIRC, they'd have to set
core.attributesfile anyway, so that is not likely to happen.

And what you're doing at least matches what GIT_CONFIG_* does (I think
GIT_CONFIG_NOGLOBAL is also redundant in the tests at this point).

So I'm fine with either strategy. But definitely it should be protected,
so thanks for looking into it.

-Peff
