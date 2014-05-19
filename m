From: Jeff King <peff@peff.net>
Subject: Re: Misspelled directory
Date: Mon, 19 May 2014 10:28:28 -0400
Message-ID: <20140519142827.GA20289@sigill.intra.peff.net>
References: <CALQBTK_JchndNSd6ey746vY=N2TiHUc0Z1PJvp-vXYUZCkgc3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alexandre Badez <alexandre.badez@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 16:28:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmOYN-0006ax-4p
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 16:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754291AbaESO2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 10:28:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:55027 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751544AbaESO2a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 10:28:30 -0400
Received: (qmail 16275 invoked by uid 102); 19 May 2014 14:28:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 May 2014 09:28:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 May 2014 10:28:28 -0400
Content-Disposition: inline
In-Reply-To: <CALQBTK_JchndNSd6ey746vY=N2TiHUc0Z1PJvp-vXYUZCkgc3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249580>

On Mon, May 19, 2014 at 03:05:42PM +0200, Alexandre Badez wrote:

> The '.' directory is not the same as the root directory; you can see
> that the /README.md and /./README.md are different.

Right. Inside git trees, "." as an entry name does not have any special
meaning. However, because it does have meaning in filesystems, git
itself will never create such an entry, and "git fsck" will warn about
it.

> I've reported the bug to stackedit (
> https://github.com/benweet/stackedit/issues/405
> ) who ignore it (not their fault).

GitHub normally blocks objects that do not pass "fsck" from being
pushed, but there are some loopholes when going through the API, which
stackedit does. I'll bring this one to the attention of the GitHub API
developers.

However, the end result will probably be GitHub rejecting the API
request from stackedit to create the bogus tree. So stackedit may end up
wanting to adjust their code to handle the situation more gracefully
anyway.

-Peff
