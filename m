From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] apply: fix access to an uninitialized mode variable,
	found by valgrind
Date: Wed, 4 Feb 2009 10:31:50 -0500
Message-ID: <20090204153150.GC6896@sigill.intra.peff.net>
References: <cover.1233712140u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0902040249030.9822@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Don Zickus <dzickus@redhat.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 04 16:33:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUjkz-0000xl-VH
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 16:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160AbZBDPb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 10:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753180AbZBDPb4
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 10:31:56 -0500
Received: from peff.net ([208.65.91.99]:55189 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752674AbZBDPb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 10:31:56 -0500
Received: (qmail 29674 invoked by uid 107); 4 Feb 2009 15:32:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 04 Feb 2009 10:32:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Feb 2009 10:31:50 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902040249030.9822@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108379>

On Wed, Feb 04, 2009 at 02:50:15AM +0100, Johannes Schindelin wrote:

> When 'tpatch' was initialized successfully, st_mode was already taken
> from the previous diff.  We should not try to override it with data
> from an lstat() that was never called.

Yay. Valgrind For The Win, as the kids are saying these days.

Was this being triggered by t4121 and t4127? If so, then I think it
solves the mystery valgrind errors I reported in the last paragraph
here:

  http://article.gmane.org/gmane.comp.version-control.git/98898

-Peff
