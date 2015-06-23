From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 0/2] bumping repository format version
Date: Tue, 23 Jun 2015 06:50:42 -0400
Message-ID: <20150623105042.GA10888@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 23 12:50:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7Ln5-0008Hy-5T
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 12:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbbFWKuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 06:50:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:50403 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753853AbbFWKup (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 06:50:45 -0400
Received: (qmail 18264 invoked by uid 102); 23 Jun 2015 10:50:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Jun 2015 05:50:45 -0500
Received: (qmail 17887 invoked by uid 107); 23 Jun 2015 10:50:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Jun 2015 06:50:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Jun 2015 06:50:42 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272447>

We've managed to avoid bumping core.repositoryformatversion for the past
10 years, which is great. But I think there are some looming features
that are going to need it. The most obvious one is changing the ref
storage, where we need some way to tell older gits "no, please don't
think that taking 'refs/heads/foo.lock' is sufficient to actually lock".

The first patch in this series is an attempt to pave the way for version
bumps like this in as painless a way as possible, by letting us mark
incompatible "extensions" by name. That way we can version things like
"how do you lock a ref" independent of the main repositoryformatversion
setting (just like we do for index version, for example).

See the explanation in the first patch for more details. The second
patch shows another use of the "extension" feature to provide safety
in shared-object repos against older versions of git.

  [1/2]: introduce "extensions" form of core.repositoryformatversion
  [2/2]: introduce "preciousObjects" repository extension

-Peff
