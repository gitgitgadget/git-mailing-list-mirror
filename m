From: Jeff King <peff@peff.net>
Subject: [PATCH v2 0/2] fix corner case with lock_ref_sha1_basic and
 REF_NODEREF
Date: Tue, 12 Jan 2016 04:56:39 -0500
Message-ID: <20160112095638.GA4773@sigill.intra.peff.net>
References: <20160111154651.GA25338@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 10:56:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIvh8-0006E8-QY
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 10:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933498AbcALJ4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 04:56:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:51997 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932987AbcALJ4l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 04:56:41 -0500
Received: (qmail 21150 invoked by uid 102); 12 Jan 2016 09:56:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 04:56:41 -0500
Received: (qmail 11515 invoked by uid 107); 12 Jan 2016 09:56:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 04:56:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2016 04:56:39 -0500
Content-Disposition: inline
In-Reply-To: <20160111154651.GA25338@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283782>

On Mon, Jan 11, 2016 at 10:46:51AM -0500, Jeff King wrote:

> I came across an interesting regression case with the new
> create_symref() that uses lock_ref_sha1_basic(). It turns out that the
> bug is actually in the latter function, but that it's slightly easier to
> tickle it since we added new callers.
> 
> The bug and fix are rather involved, so I won't repeat the explanation
> from patch 2/2 here. The first patch is just a cleanup necessary to
> accurately in test in the second.
> 
>   [1/2]: checkout,clone: check return value of create_symref
>   [2/2]: lock_ref_sha1_basic: handle REF_NODEREF with invalid refs

Here's a re-roll incorporating feedback from Michael. Patch 1 now has a
test for git-checkout (doing one for clone seems rather hard without
being racy). Patch 2 has a typo fix in the commit message, and the test
script is adjusted to account for the new test.

-Peff
