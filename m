From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/7] diff.c: take "prefix" argument in diff_opt_parse()
Date: Wed, 20 Jan 2016 15:29:46 -0500
Message-ID: <20160120202946.GA6092@sigill.intra.peff.net>
References: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
 <1453287968-26000-3-git-send-email-pclouds@gmail.com>
 <xmqqr3hc57at.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 21:29:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLzO6-0008FY-N3
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 21:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbcATU3v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2016 15:29:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:57250 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751985AbcATU3t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 15:29:49 -0500
Received: (qmail 13573 invoked by uid 102); 20 Jan 2016 20:29:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jan 2016 15:29:49 -0500
Received: (qmail 9259 invoked by uid 107); 20 Jan 2016 20:30:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jan 2016 15:30:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jan 2016 15:29:46 -0500
Content-Disposition: inline
In-Reply-To: <xmqqr3hc57at.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284462>

On Wed, Jan 20, 2016 at 12:23:38PM -0800, Junio C Hamano wrote:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>=20
> > This will be important later when diff_opt_parse() accepts paths as
> > arguments. Paths must be prefixed before access because setup code
> > moves cwd but does not (and cannot) update command line options.
>=20
> The above sounds like a sensible thing to do (note: I didn't read
> the patch or remainder of the series), but makes me wonder how the
> existing --orderfile option works without this support.  Perhaps it
> is not working and needs to be updated to take advantage of this
> change, too?

Yeah, I think it simply does not work.

  $ >main-order
  $ mkdir subdir && >subdir/sub-order
  $ cd subdir
  $ git show -Osub-order
  fatal: failed to read orderfile 'sub-order': No such file or director=
y
  $ git show -Omain-order
  [shows diff]

-Peff
