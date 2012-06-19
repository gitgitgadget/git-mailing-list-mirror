From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] symbolic-ref: check format of given reference
Date: Tue, 19 Jun 2012 10:47:12 -0400
Message-ID: <20120619144712.GB12085@sigill.intra.peff.net>
References: <4FDE3D7D.4090502@elegosoft.com>
 <7vaa017j51.fsf@alter.siamese.dyndns.org>
 <4FDF18E5.7020908@elegosoft.com>
 <7vr4tc4lsc.fsf@alter.siamese.dyndns.org>
 <7vipeo4kcp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Schubert <mschub@elegosoft.com>, git <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 16:47:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgziA-0005sW-MP
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 16:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754395Ab2FSOrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 10:47:15 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:32770
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754272Ab2FSOrO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 10:47:14 -0400
Received: (qmail 9687 invoked by uid 107); 19 Jun 2012 14:47:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Jun 2012 10:47:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2012 10:47:12 -0400
Content-Disposition: inline
In-Reply-To: <7vipeo4kcp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200202>

On Mon, Jun 18, 2012 at 10:10:14AM -0700, Junio C Hamano wrote:

> For that matter, shouldn't symbolic-ref be forbidden to point
> outside refs/heads/, not just restricted in refs/ like the current
> code does?

We tried that already but reverted it due to topgit. See:

    commit e9cc02f0e41fd5d2f51e3c3f2b4f8cfa9e434432
    Author: Jeff King <peff@peff.net>
    Date:   Fri Feb 13 13:26:09 2009 -0500

        symbolic-ref: allow refs/<whatever> in HEAD

        Commit afe5d3d5 introduced a safety valve to symbolic-ref to
        disallow installing an invalid HEAD. It was accompanied by
        b229d18a, which changed validate_headref to require that
        HEAD contain a pointer to refs/heads/ instead of just refs/.
        Therefore, the safety valve also checked for refs/heads/.

        As it turns out, topgit is using refs/top-bases/ in HEAD,
        leading us to re-loosen (at least temporarily) the
        validate_headref check made in b229d18a. This patch does the
        corresponding loosening for the symbolic-ref safety valve,
        so that the two are in agreement once more.

-Peff
