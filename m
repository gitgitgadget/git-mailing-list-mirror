From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] add -u: get rid of "treewideupdate" configuration
Date: Fri, 8 Apr 2011 13:54:32 -0400
Message-ID: <20110408175149.GA3917@sigill.intra.peff.net>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 19:54:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8FtK-0004fg-8I
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 19:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630Ab1DHRyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 13:54:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55751
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871Ab1DHRyg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 13:54:36 -0400
Received: (qmail 2656 invoked by uid 107); 8 Apr 2011 17:55:22 -0000
Received: from 205.158.58.41.ptr.us.xo.net (HELO sigill.intra.peff.net) (205.158.58.41)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Apr 2011 13:55:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Apr 2011 13:54:32 -0400
Content-Disposition: inline
In-Reply-To: <1302138996-10006-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171137>

On Wed, Apr 06, 2011 at 06:16:34PM -0700, Junio C Hamano wrote:

> Thanks to the magic ":/" pathspec, it is much easier to invoke both
> tree-wide operation and limited-to-cwd operation on demand from the
> command line.

I am mildly negative on this patch. Having the config variable helps two
types of users:

  1. Ones who see the warning for new behavior, say "great, I've been
     informed and am ready to use it", and don't want to see the message
     again. They are stuck typing "./" or ":/" every time, or end up
     getting spammed by the migration message.

  2. Users who prefer the current behavior and would rather keep it. We
     give them no out except to type "./" every time. Changing the
     default is one thing; an irate user can see the change and fix it.
     But to give them no way of changing the default back seems
     unnecessarily limiting.

> What remains is the downside of the configuration variable,
> namely, that it makes git behave differently depending on who you are and
> in which repository you are using it, hence making it harder to help
> and/or teach others.

I have never been a fan of this reasoning. Sure, it is slightly harder
to help people when the system is configurable. But dropping
configurability comes at the cost of people who are using the system
day-to-day. And isn't making it pleasant to use every day more important
than the minority of times you are telling somebody else how to use it?

Besides which, if you are helping somebody remotely or sitting at an
unfamiliar git installation, it still wouldn't be safe to recommend
pathspec-less "git add -u" without first checking which version of git
the person is running (though to be fair, in 2 or 3 years it will be
reasonable to assume a certain behavior, and a config option would still
exist).

-Peff
