From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/3] tests: Prepare --textconv tests for
 correctly-failing conversion program
Date: Tue, 28 Sep 2010 09:23:57 -0400
Message-ID: <20100928132356.GA5829@sigill.intra.peff.net>
References: <cover.1285351816.git.kirr@landau.phys.spbu.ru>
 <66d4603c7e21561557f612690d6196e7ae0b38f9.1285351816.git.kirr@landau.phys.spbu.ru>
 <7vsk0vyriw.fsf@alter.siamese.dyndns.org>
 <20100928120722.GA29525@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Cl??ment Poulain <clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Tue Sep 28 15:24:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0aAB-0008JT-4t
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 15:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685Ab0I1NYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 09:24:00 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:59700 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754631Ab0I1NYA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 09:24:00 -0400
Received: (qmail 28376 invoked by uid 111); 28 Sep 2010 13:23:59 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 28 Sep 2010 13:23:59 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Sep 2010 09:23:57 -0400
Content-Disposition: inline
In-Reply-To: <20100928120722.GA29525@landau.phys.spbu.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157422>

On Tue, Sep 28, 2010 at 04:07:22PM +0400, Kirill Smelkov wrote:

> > Granted, echo is forgiving and will concatenate the arguments it gets with
> > a space in between, but you would either want to either:
> > 
> >  (1) make it more explicit that helper gets only one argument, by saying
> >      "$1" instead of "$@", in all places in the helper script; or
> > 
> >  (2) if you are planning to make 'helper' capable of handling multiple
> >      input files, show the error message for the ones that are not binary
> >      (you would probably need a loop for that).
> > 
> > I think (1) would be sufficient in this case.
> 
> I too think (1) is right. It was just that originally there was $@
> (which I now understand was wrong). So ok to apply the following patch
> on top of this series? (I assume it's ok, and will repost the whole
> thing)

No, "helper" is supposed to be able to take multiple arguments, at least
in t4042. See the "changing textconv invalidates cache" test. The extra
argument comes from the user, not from git.

>  t/t4042-diff-textconv-caching.sh |    4 ++--

Why are we touching t4042 at all in this series? We are not actually
adding any tests to it, AFAICT.

>  t/t8006-blame-textconv.sh        |    4 ++--
>  t/t8007-cat-file-textconv.sh     |    4 ++--

These ones simply copied the helper script, and could be switched to use
$1.

-Peff
