From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] tag: support --sort=<spec>
Date: Thu, 27 Feb 2014 08:11:00 -0500
Message-ID: <20140227131100.GA22783@sigill.intra.peff.net>
References: <1393330935-22229-1-git-send-email-pclouds@gmail.com>
 <1393505812-7171-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 14:11:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ0k4-0007RN-VN
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 14:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbaB0NLF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Feb 2014 08:11:05 -0500
Received: from cloud.peff.net ([50.56.180.127]:58022 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751898AbaB0NLC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 08:11:02 -0500
Received: (qmail 24243 invoked by uid 102); 27 Feb 2014 13:11:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Feb 2014 07:11:01 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Feb 2014 08:11:00 -0500
Content-Disposition: inline
In-Reply-To: <1393505812-7171-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242818>

On Thu, Feb 27, 2014 at 07:56:52PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> --sort=3Dversion:refname (or --sort=3Dv:refname for short) sorts tags=
 as
> if they are versions. --sort=3D-refname reverses the order (with or
> without ":version").
>=20
> versioncmp() is copied from string/strverscmp.c in glibc commit
> ee9247c38a8def24a59eb5cfb7196a98bef8cfdc, reformatted to Git coding
> style. The implementation is under LGPL-2.1 and according to [1] I ca=
n
> relicense it to GPLv2.

This looks good to me. One minor typo:

> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 404257d..9b05931 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -95,6 +95,12 @@ OPTIONS
>  	using fnmatch(3)).  Multiple patterns may be given; if any of
>  	them matches, the tag is shown.
> =20
> +--sort=3D<type>::
> +	Sort in a specific order. Supported type is "refname"
> +	(lexicographic order), "version:refname" or "v:refname" (tags
> +	name are treated as versions). Prepend "-" to reverse sort

s/tags name/tag names/

You had mentioned earlier tweaking the version comparison to handle
things like -rc better. I think that can come on top of this initial
patch, but we should probably figure out the final sort order before
including this in a release.

-Peff
