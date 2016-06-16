From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] friendlier handling of overflows in archive-tar
Date: Thu, 16 Jun 2016 00:35:23 -0400
Message-ID: <20160616043523.GA13615@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 16 06:35:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDP1n-0008QY-EN
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jun 2016 06:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbcFPEfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2016 00:35:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:55427 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751270AbcFPEf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 00:35:26 -0400
Received: (qmail 29961 invoked by uid 102); 16 Jun 2016 04:35:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 00:35:26 -0400
Received: (qmail 12082 invoked by uid 107); 16 Jun 2016 04:35:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 00:35:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2016 00:35:23 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297409>

The ustar format has some fixed-length numeric fields, and it's possible
to generate a git tree that can't be represented (namely file size and
mtime). Since f2f0267 (archive-tar: use xsnprintf for trivial
formatting, 2015-09-24), we detect and die() in these cases. But we can
actually do the friendly (and POSIX-approved) thing, and add extended
pax headers to represent the correct values.

  [1/2]: archive-tar: write extended headers for file sizes >= 8GB
  [2/2]: archive-tar: write extended headers for far-future mtime

-Peff
