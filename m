From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] archive: do not read .gitattributes in working
	directory
Date: Thu, 16 Apr 2009 03:06:26 -0400
Message-ID: <20090416070626.GB20071@coredump.intra.peff.net>
References: <1239848917-14399-1-git-send-email-gitster@pobox.com> <1239848917-14399-2-git-send-email-gitster@pobox.com> <1239848917-14399-3-git-send-email-gitster@pobox.com> <1239848917-14399-4-git-send-email-gitster@pobox.com> <1239848917-14399-5-git-send-email-gitster@pobox.com> <7vhc0pnpn3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 09:08:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuLhd-00057w-81
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 09:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbZDPHGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 03:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbZDPHGc
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 03:06:32 -0400
Received: from peff.net ([208.65.91.99]:46963 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751568AbZDPHGb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 03:06:31 -0400
Received: (qmail 594 invoked by uid 107); 16 Apr 2009 07:06:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 16 Apr 2009 03:06:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2009 03:06:26 -0400
Content-Disposition: inline
In-Reply-To: <7vhc0pnpn3.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116676>

On Wed, Apr 15, 2009 at 10:17:36PM -0700, Junio C Hamano wrote:

> > +	/* tar-tree defaults to fix-attributes as before */
> > +	nargv[nargc++] = "--fix-attributes";
> > +
> >  	switch (argc) {
> >  	default:
> >  		usage(tar_tree_usage);
> 
> I screwed up this part; nargv[] array needs to be enlarged by one element
> because of this change.  It resulted in a funny breakage in tests that
> triggered only when run from the toplevel of the tree but did not surface
> when the individual test was done from t/ directory, which my final
> testing on the k.org machine caught, and that is why I still haven't
> managed to push the result out for tonight.

FWIW, running t5000 with --valgrind does catch it. I'll try to run the
full test suite with valgrind on the last -rc before 1.6.3 to catch any
hidden issues which have cropped up during this cycle (I can do it
earlier, too, but it is a real pain to run the whole thing, so I want to
just wait until the last minute).

-Peff
