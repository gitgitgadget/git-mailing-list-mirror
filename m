From: Jeff King <peff@peff.net>
Subject: Re: file permissions in Git repo
Date: Thu, 16 Jan 2014 21:26:23 -0500
Message-ID: <20140117022623.GC12444@sigill.intra.peff.net>
References: <1389916737.92225.YahooMailNeo@web124906.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: SH <saajey@yahoo.com>
X-From: git-owner@vger.kernel.org Fri Jan 17 03:26:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3z8f-0004n9-QW
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 03:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbaAQC00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 21:26:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:33916 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751678AbaAQC0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 21:26:25 -0500
Received: (qmail 9212 invoked by uid 102); 17 Jan 2014 02:26:25 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jan 2014 20:26:25 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jan 2014 21:26:23 -0500
Content-Disposition: inline
In-Reply-To: <1389916737.92225.YahooMailNeo@web124906.mail.ne1.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240560>

On Thu, Jan 16, 2014 at 03:58:57PM -0800, SH wrote:

> We have a repository which holds lots of shell and perl scripts. We add the
> files to repository (from windows client) with executable permissions (using
> cygwin) but when we pull that repository on another machine (windows or linux),
> files dont have executable permission. Can you please provide a solutions for
> this?

Git does not preserve file permissions _except_ for the executable bit.
So this should be working.

However, I suspect that `core.fileMode` is set to `false` in your
repository, which causes git to ignore the executable bit. When a
repository is initialized, we check whether the filesystem simply
creates everything with the executable bit. If so, we turn off
core.fileMode for the repository (since otherwise every file would have
it set).

-Peff
