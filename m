From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 00/16] Make Gnome Credential helper more Gnome-y and
 support ancient distros
Date: Mon, 23 Sep 2013 23:49:32 -0400
Message-ID: <20130924034932.GB2766@sigill.intra.peff.net>
References: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, john@szakmeister.net, pah@qo.cx,
	felipe.contreras@gmail.com, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 05:49:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOJd7-0008UL-0B
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 05:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476Ab3IXDth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 23:49:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:52444 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753448Ab3IXDtg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 23:49:36 -0400
Received: (qmail 27242 invoked by uid 102); 24 Sep 2013 03:49:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 Sep 2013 22:49:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Sep 2013 23:49:32 -0400
Content-Disposition: inline
In-Reply-To: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235254>

On Mon, Sep 23, 2013 at 11:49:01AM -0700, Brandon Casey wrote:

> Brandon Casey (16):
>   contrib/git-credential-gnome-keyring.c: remove unnecessary
>     pre-declarations
> [...]

Thanks, I think this is a good change. There were patches[1] from
Philipp about a year ago that went in the opposite direction, factoring
out common credential functions to be used by several helpers. We ended
up not merging them, because porting the wincred helper to the generic
implementation introduced complications.

And that was part of the reason for splitting out the helpers in the
first place: to let them worry about their own individual
system-specific quirks (and take advantage of system-specific helpers).
IOW, to make the gnome helper more gnome-y than git-y. And your patches
go in that direction, which I think is sane.

[1] http://thread.gmane.org/gmane.comp.version-control.git/204154/focus=204157

>   contrib/git-credential-gnome-keyring.c: report failure to store
>     password

Your subject lines are rather on the long side. I wonder if they would
be more readable as just:

  gnome-keyring: report failure to store password

and so forth. Anyone familiar with git.git knows that the "contrib"
and "git-credential-" bits are implied by "gnome-keyring". But it's not
a huge deal either way.

> Inserts a patch to fix the style issues for block statements.
> i.e. use "if ()" instead of "if()"

There are a ton of other style issues in the existing code (lack of
whitespace around operators and function arguments, and "char* foo"
instead of "char *foo" were the two I noticed). As a separate contrib/
project, I'm not that concerned, and I would say it is up to whoever is
nominally in charge of maintaining that contrib directory (Philipp or
John, in this case).

-Peff
