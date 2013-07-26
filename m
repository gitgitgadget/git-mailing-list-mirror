From: Jeff King <peff@peff.net>
Subject: Re: [REQUEST 1/1] docs: update http.<url>.* options documentation
Date: Fri, 26 Jul 2013 00:37:48 -0400
Message-ID: <20130726043748.GA20286@sigill.intra.peff.net>
References: <4b44f95a1b574b5d92a15254e4e8523@f74d39fa044aa309eaea14b9f57fe79>
 <ec5ecd4fe44af87e83778ce8e297afe@f74d39fa044aa309eaea14b9f57fe79>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 06:37:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2Zmu-0007Nz-2k
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 06:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192Ab3GZEhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 00:37:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:54295 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067Ab3GZEhv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 00:37:51 -0400
Received: (qmail 28274 invoked by uid 102); 26 Jul 2013 04:37:50 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Jul 2013 23:37:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jul 2013 00:37:48 -0400
Content-Disposition: inline
In-Reply-To: <ec5ecd4fe44af87e83778ce8e297afe@f74d39fa044aa309eaea14b9f57fe79>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231163>

On Thu, Jul 25, 2013 at 03:39:13PM -0700, Kyle J. McKay wrote:

> Overhaul the text of the http.<url>.* options documentation
> providing a hopefully easier to understand itemized list of
> matching behavior as suggested by and including text from
> Jeff King.
> ---

Signed-off-by: Jeff King <peff@peff.net>

You should add your S-O-B, too, for your bits.

> +--
> +. Scheme (e.g., `https` in `https://example.com/`). This field
> +  must match exactly between the config key and the URL.
> +. Host/domain name (e.g., `example.com` in `https://example.com/`).
> +  This field must match exactly between the config key and the URL.

These look fine in the rendered manpage, but I think the source might be
a little easier to read with a blank line between items.

> +. Port number (e.g., `8080` in `http://example.com:8080/`).
> +  This field must match exactly between the config key and the URL.
> +  Omitted port numbers are automatically converted to the correct
> +  default for the scheme before matching.

Thanks, I forgot to include port number in my original suggested text.

> +. Exact user name match (e.g., `user` in `https://user@example.com/repo.git`).
> +  If the config key has a user name it must match the user name in the URL
> +  exactly.
> +. Any user name match.  If a config key does not have a user name, that config
> +  key will match a URL with any user name (including none).

IMHO, this would be more clear as a single item, like:

  . User name (e.g., `user` in `https://user@example.com/repo.git`). If
    the config key has a user name it must match the user name in the
    URL exactly. If the config key does not have a user name, that
    config key will match a URL with any user name (including none).

> +All URLs are normalized before attempting any matching (the password part,
> +if embedded in the URL, is always ignored for matching purposes) so that
> +equivalent urls that are simply spelled differently will match properly.

And this nicely ties up the open questions I had after re-reading the
list. Good.

We could define "equivalent" here (the %-encoding thing is obvious, I
think, but which components are case-sensitive and which are not is
perhaps a bit subtle). I do not necessarily know that it is useful to
the user, though, and is one more thing to confuse them.  And somebody
who really cares can look at the appropriate RFCs.

So this patch looks pretty good to me; the two points I raised above are
how I would have done it, but they are relatively minor if you do not
agree.

-Peff
