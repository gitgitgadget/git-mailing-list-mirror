From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] fix corner case with lock_ref_sha1_basic and REF_NODEREF
Date: Mon, 11 Jan 2016 10:46:51 -0500
Message-ID: <20160111154651.GA25338@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 16:47:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIegN-0005Ua-HY
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 16:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759928AbcAKPqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 10:46:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:51214 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758065AbcAKPqy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 10:46:54 -0500
Received: (qmail 32008 invoked by uid 102); 11 Jan 2016 15:46:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jan 2016 10:46:54 -0500
Received: (qmail 615 invoked by uid 107); 11 Jan 2016 15:47:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jan 2016 10:47:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jan 2016 10:46:51 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283657>

I came across an interesting regression case with the new
create_symref() that uses lock_ref_sha1_basic(). It turns out that the
bug is actually in the latter function, but that it's slightly easier to
tickle it since we added new callers.

The bug and fix are rather involved, so I won't repeat the explanation
from patch 2/2 here. The first patch is just a cleanup necessary to
accurately in test in the second.

  [1/2]: checkout,clone: check return value of create_symref
  [2/2]: lock_ref_sha1_basic: handle REF_NODEREF with invalid refs

-Peff
