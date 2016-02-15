From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] remote: actually check if remote exits
Date: Mon, 15 Feb 2016 13:23:24 -0500
Message-ID: <20160215182324.GG26443@sigill.intra.peff.net>
References: <1455558150-30267-1-git-send-email-t.gummerer@gmail.com>
 <1455558150-30267-4-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 19:23:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVNo3-0008TI-A6
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 19:23:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbcBOSX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 13:23:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:42290 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751758AbcBOSX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 13:23:27 -0500
Received: (qmail 25504 invoked by uid 102); 15 Feb 2016 18:23:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 13:23:26 -0500
Received: (qmail 10052 invoked by uid 107); 15 Feb 2016 18:23:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 13:23:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 13:23:24 -0500
Content-Disposition: inline
In-Reply-To: <1455558150-30267-4-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286225>

On Mon, Feb 15, 2016 at 06:42:29PM +0100, Thomas Gummerer wrote:

> When converting the git remote command to a builtin in 211c89 ("Make
> git-remote a builtin"), a few calls to check if a remote exists were
> converted from:
>        if (!exists $remote->{$name}) {
>        	  [...]
> to:
>        remote = remote_get(argv[1]);
>        if (!remote)
>           [...]
> 
> The new check is not quite correct, because remote_get() never returns
> NULL if a name is given.  This leaves us with the somewhat cryptic error
> message "error: Could not remove config section 'remote.test'", if we
> are trying to remove a remote that does not exist, or a similar error if
> we try to rename a remote.
> 
> Use the remote_is_configured() function to check whether the remote
> actually exists, and die with a more sensible error message ("No such
> remote: $remotename") instead if it doesn't.
> 
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  builtin/remote.c  |  4 ++--
>  t/t5505-remote.sh | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+), 2 deletions(-)

Nice. Very cleanly explained and implemented.

-Peff
