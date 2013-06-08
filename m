From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 02/22] git-remote-mediawiki: Use the Readonly module
 instead of the constant pragma
Date: Fri, 7 Jun 2013 23:23:25 -0400
Message-ID: <20130608032324.GA20226@sigill.intra.peff.net>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
 <1370641344-4253-3-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, benoit.person@ensimag.fr,
	matthieu.moy@grenoble-inp.fr
To: =?utf-8?B?Q8OpbGVzdGlu?= Matte <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Sat Jun 08 05:23:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul9kp-0006ry-4A
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 05:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113Ab3FHDXb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 23:23:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:48535 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927Ab3FHDXa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 23:23:30 -0400
Received: (qmail 5213 invoked by uid 102); 8 Jun 2013 03:24:18 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 07 Jun 2013 22:24:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jun 2013 23:23:25 -0400
Content-Disposition: inline
In-Reply-To: <1370641344-4253-3-git-send-email-celestin.matte@ensimag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226782>

On Fri, Jun 07, 2013 at 11:42:03PM +0200, C=C3=A9lestin Matte wrote:

> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw=
-to-git/git-remote-mediawiki.perl
> index 4893442..e60793a 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -26,21 +26,21 @@ use IPC::Open2;
>  use Readonly;

What does this series apply on top of? The existing version in "master"
does not have "use Readonly" in it at all. The first version of your
series introduced that line, but here it is shown as an existing line.
Did you miss a commit when putting your patches together?

>  # Mediawiki filenames can contain forward slashes. This variable dec=
ides by which pattern they should be replaced
> -use constant SLASH_REPLACEMENT =3D> "%2F";
> +Readonly my $SLASH_REPLACEMENT =3D> "%2F";

What advantage does this have over "use constant"? I do not mind
following guidelines from perlcritic if they are a matter of style, but
in this case there is a cost: we now depend on the "Readonly" module,
which is not part of the standard distribution. I.e., users now have to
deal with installing an extra dependency. Is it worth it?

-Peff
