From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] gc --aggressive: three phase repacking
Date: Tue, 18 Mar 2014 00:50:50 -0400
Message-ID: <20140318045050.GB8240@sigill.intra.peff.net>
References: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
 <1394976904-15395-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 05:51:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPlzs-0006n9-Ht
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 05:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbaCREux convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Mar 2014 00:50:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:41628 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750815AbaCREuw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 00:50:52 -0400
Received: (qmail 21034 invoked by uid 102); 18 Mar 2014 04:50:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Mar 2014 23:50:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Mar 2014 00:50:50 -0400
Content-Disposition: inline
In-Reply-To: <1394976904-15395-6-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244328>

On Sun, Mar 16, 2014 at 08:35:04PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> As explained in the previous commit, current aggressive settings
> --depth=3D250 --window=3D250 could slow down repository access
> significantly. Notice that people usually work on recent history only=
,
> we could keep recent history more loosely packed, so that repo access
> is fast most of the time while the pack file remains small.

One thing I have not seen is real-world timings showing the slowdown
based on --depth. Did I miss them, or are we just making assumptions
based on one old case from 2009 (that, AFAIK does not have real numbers=
,
just speculation)? Has anyone measured the effect of bumping the delta
cache size (and its hash implementation)?

> git.git is not a great repo to test it because its size is modest but
> so are my laptop's cpu and memory, so here are the timings and pack
> sizes
>=20
>             size  time
> old aggr.   36MB  5m51
> new aggr.   37MB  6m13
> repack -adf 48MB  1m12

I am not clear on what these times mean. It looks like the new code is
slower _and_ bigger. Can you explain them?

-Peff
