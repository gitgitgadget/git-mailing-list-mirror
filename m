From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Support "core.excludesfile = ~/.gitignore"
Date: Tue, 26 Aug 2008 20:25:06 -0400
Message-ID: <20080827002506.GB7347@coredump.intra.peff.net>
References: <quack.20080821T2114.lthvdxtvg7b@roar.cs.berkeley.edu> <7vsksw92nh.fsf@gitster.siamese.dyndns.org> <quack.20080824T0140.lth3aku956e@roar.cs.berkeley.edu> <7vprnyqo59.fsf@gitster.siamese.dyndns.org> <20080824220854.GA27299@coredump.intra.peff.net> <7vzln2j9y2.fsf@gitster.siamese.dyndns.org> <20080824231343.GC27619@coredump.intra.peff.net> <7vhc9aj82i.fsf@gitster.siamese.dyndns.org> <quack.20080825T1207.lthk5e46hi4_-_@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Wed Aug 27 02:26:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY8rY-00043P-UG
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 02:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbYH0AZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 20:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752433AbYH0AZJ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 20:25:09 -0400
Received: from peff.net ([208.65.91.99]:3500 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753987AbYH0AZI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 20:25:08 -0400
Received: (qmail 3149 invoked by uid 111); 27 Aug 2008 00:25:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 26 Aug 2008 20:25:07 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2008 20:25:06 -0400
Content-Disposition: inline
In-Reply-To: <quack.20080825T1207.lthk5e46hi4_-_@roar.cs.berkeley.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93840>

On Mon, Aug 25, 2008 at 12:07:15PM -0700, Karl Chen wrote:

> Based on the discussion it sounds like there are complications to
> supporting relative paths (due to worktree config), and "$HOME"
> (when generalized, due to bootstrapping issues with $GIT_*).

I think that is fine for now. One other simple possibility would be to
expand _just_ $HOME, and then if we later decided to do all environment
variables it would naturally encompass that. However, we might want to
support "~" then anyway, so I think doing "~" first is fine.

However, there are two problems with the patch:

  1. It should probably re-use path.c:user_path, as Johannes mentioned.

  2. There is no documentation update.

Also, are there any other config variables which would benefit from this
substitution (I can't think of any off-hand, but there are quite a few I
don't use).

-Peff
