From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] valgrind bug roundup
Date: Fri, 29 Jan 2010 05:25:18 -0500
Message-ID: <20100129102518.GA5875@coredump.intra.peff.net>
References: <20100128145216.GA29727@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 11:25:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nao2e-00023m-E2
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 11:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648Ab0A2KZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 05:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752601Ab0A2KZX
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 05:25:23 -0500
Received: from peff.net ([208.65.91.99]:33605 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172Ab0A2KZW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 05:25:22 -0500
Received: (qmail 3905 invoked by uid 107); 29 Jan 2010 10:25:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 29 Jan 2010 05:25:22 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jan 2010 05:25:18 -0500
Content-Disposition: inline
In-Reply-To: <20100128145216.GA29727@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138306>

On Thu, Jan 28, 2010 at 09:52:16AM -0500, Jeff King wrote:

> I'm running the whole test suite under valgrind for the current
> 'master'. This was the first hit, but it's very s-l-o-w, so there might
> be more as the day progresses.

And here they are. The first two are actual bugs, the third silences a
false positive:

  [1/3]: fix memcpy of overlapping area
  [2/3]: fix off-by-one allocation error
  [3/3]: add shebang line to git-mergetool--lib.sh

It really has been a while since I've run the whole test suite under
valgrind. The breakage in 3/3 dates back to last April. The bug in 1/3
is also quite old (v1.5.0). I'm not sure why I didn't find it in
previous valgrind runs; perhaps it is only recent valgrinds that have
grown support for finding overlapping memcpy. The bug in 2/3 is new, and
has never been in a released version.

-Peff
