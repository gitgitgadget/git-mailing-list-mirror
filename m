From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] format-patch handling in-body From headers
Date: Wed, 3 Jul 2013 03:07:20 -0400
Message-ID: <20130703070719.GA17638@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 03 09:07:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuH9z-0006PV-NX
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 09:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246Ab3GCHHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 03:07:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:36047 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753938Ab3GCHHX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 03:07:23 -0400
Received: (qmail 28655 invoked by uid 102); 3 Jul 2013 07:08:33 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Jul 2013 02:08:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jul 2013 03:07:20 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229456>

As I've mentioned before on the list, I don't use git-send-email, but
rather a home-grown script that interacts more closely with my regular
MUA.  After embarrassing myself on multiple occasions by its inability
to automatically handle sending patches by other authors, I decided to
implement send-email's "stick the original author in a body header"
scheme.

However, doing it right is kind of tricky due to rfc822 quoting, rfc2047
encoding, and handling non-ascii names correctly. Instead, this patch
series takes a different approach: it teaches format-patch to do the
transformation itself, so that it can be used by my script along with
any other non-send-email workflows that exist (e.g., git-imap-send
suffers from the same problem).

  [1/2]: pretty.c: drop const-ness from pretty_print_context
  [2/2]: teach format-patch to place other authors into in-body "From"

-Peff
