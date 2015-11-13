From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones
 fail
Date: Fri, 13 Nov 2015 00:35:47 -0500
Message-ID: <20151113053547.GD29708@sigill.intra.peff.net>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sbeller@google.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 13 06:35:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zx71d-0007lH-Tn
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 06:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbbKMFfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 00:35:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:56933 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750722AbbKMFft (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 00:35:49 -0500
Received: (qmail 14368 invoked by uid 102); 13 Nov 2015 05:35:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Nov 2015 23:35:49 -0600
Received: (qmail 21487 invoked by uid 107); 13 Nov 2015 05:36:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 00:36:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Nov 2015 00:35:47 -0500
Content-Disposition: inline
In-Reply-To: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281237>

On Thu, Nov 12, 2015 at 10:37:41AM +0100, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> "git clone --recursive --depth 1 --single-branch <url>" clones the
> submodules successfully. However, it does not obey "--depth 1" for
> submodule cloning.
> 
> The following workaround does only work if the used submodule pointer
> is on the default branch. Otherwise "git submodule update" fails with
> "fatal: reference is not a tree:" and "Unable to checkout".
> git clone --depth 1 --single-branch <url>
> cd <repo-name>
> git submodule update --init --recursive --depth 1
> 
> The workaround does not fail using the "--remote" flag. However, in that
> case the wrong commit is checked out.

Hrm. Do we want to make these workarounds work correctly? Or is the
final solution going to be that the first command you gave simply works,
and no workarounds are needed.  If the latter, I wonder if we want to be
adding tests for the workarounds in the first place.

I'm not clear on the expected endgame.

-Peff
