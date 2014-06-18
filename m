From: Jeff King <peff@peff.net>
Subject: [PATCH 0/7] cleaning up determine_author_info
Date: Wed, 18 Jun 2014 16:19:44 -0400
Message-ID: <20140618201944.GA23238@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 22:19:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxMKk-0004qH-TU
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 22:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754944AbaFRUTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 16:19:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:46993 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754767AbaFRUTq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 16:19:46 -0400
Received: (qmail 32472 invoked by uid 102); 18 Jun 2014 20:19:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 15:19:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 16:19:44 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252055>

This is another function I ran across in today's cleanups. The memory
leak in it has bugged me for a while (even though it's really not a big
deal in practice). So this is mostly minor cleanups, but I did find a
bug in the commit parser.

  [1/7]: commit: provide a function to find a header in a buffer
  [2/7]: record_author_info: fix memory leak on malformed commit
  [3/7]: record_author_info: use find_commit_header
  [4/7]: ident_split: store begin/end pairs on their own struct
  [5/7]: use strbufs in date functions
  [6/7]: determine_author_info: reuse parsing functions
  [7/7]: determine_author_info: stop leaking name/email

I built it on top of my commit-slab topic, as otherwise you get some
textual conflicts in determine_author_info. But I notice that Junio's
jk/commit-buffer-length is based on an older master; applying there
produces some other minor textual conflicts. I can build it on whatever
is convenient and handle the conflicts myself. But if
jk/commit-buffer-length is set to graduate soon (as it is marked in WC),
I can just hold onto this until then.

-Peff
