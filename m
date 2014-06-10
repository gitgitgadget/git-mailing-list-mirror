From: Jeff King <peff@peff.net>
Subject: [PATCH 0/6] fix repack.packKeptObjects regression in v2.0
Date: Tue, 10 Jun 2014 16:07:41 -0400
Message-ID: <20140610200741.GA11248@sigill.intra.peff.net>
References: <vpqmwdljhu8.fsf@anie.imag.fr>
 <20140610185321.GA25845@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 10 22:07:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuSKj-0003af-BJ
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 22:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbaFJUHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 16:07:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:41233 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754965AbaFJUHm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 16:07:42 -0400
Received: (qmail 13159 invoked by uid 102); 10 Jun 2014 20:07:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 15:07:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 16:07:41 -0400
Content-Disposition: inline
In-Reply-To: <20140610185321.GA25845@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251222>

Here's a cleaned up version of the fix I posted earlier, with related
fixes on top.

  [1/6]: repack: do not accidentally pack kept objects by default

    This is the most critical one for 'maint', as it fixes the
    regression for people who are not using bitmaps at all.

  [2/6]: repack: respect pack.writebitmaps

    We probably want to apply this one to maint, too, as the first one
    breaks people depending on repack.packKeptObjects being impacted by
    pack.writebitmaps (it never worked properly, but the breakage fixed
    by the first patch covered it up).

  [3/6]: repack: s/write_bitmap/&s/ in code
  [4/6]: pack-objects: stop respecting pack.writebitmaps
  [5/6]: repack: simplify handling of --write-bitmap-index
  [6/6]: repack: introduce repack.writeBitmaps config option

    These ones can go the normal route, but see the regression comments in
    4/6.

-Peff
