From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] credential-cache: give daemon a predictable cwd
Date: Tue, 23 Feb 2016 02:14:27 -0500
Message-ID: <20160223071427.GA7489@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jon Griffiths <jon_p_griffiths@yahoo.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 08:14:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY7B5-0008Qy-2H
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 08:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756969AbcBWHOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 02:14:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:47351 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756759AbcBWHOa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 02:14:30 -0500
Received: (qmail 12164 invoked by uid 102); 23 Feb 2016 07:14:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 02:14:30 -0500
Received: (qmail 26259 invoked by uid 107); 23 Feb 2016 07:14:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 02:14:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Feb 2016 02:14:27 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287029>

The credential-cache--daemon may live forever in whatever directory it
happened to be spawned in (in practice, probably the root of some git
repo's work tree). This can prevent umount from unmounting a filesystem
that contains that directory, even though credential-cache doesn't care
one way or the other.

Jon Griffiths sent a patch to me and to the list, but it seems that vger
blocks all mail from yahoo, including him. Eep. So he and I had some
off-list back-and-forth, and ended up at this series, which I agreed to
pass along.

I've made a few minor tweaks from the last version he sent me. Hopefully
nothing he disagrees with, but of course he has no means to complain to
the list if so. :)

  [1/3]: credential-cache--daemon: refactor check_socket_directory
  [2/3]: credential-cache--daemon: disallow relative socket path
  [3/3]: credential-cache--daemon: change to the socket dir on startup

-Peff
