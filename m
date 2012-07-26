From: Jeff King <peff@peff.net>
Subject: [PATCH 0/6] t7502 fixes
Date: Thu, 26 Jul 2012 16:26:44 -0400
Message-ID: <20120726202644.GA15043@sigill.intra.peff.net>
References: <CANYiYbHbMw1HpvoCr4yBbWF=Q9Hoc1Zsq3-WoTrx4aQg7R0e4g@mail.gmail.com>
 <20120726130348.GA965@sigill.intra.peff.net>
 <7vtxwu8orw.fsf@alter.siamese.dyndns.org>
 <20120726171256.GC13942@sigill.intra.peff.net>
 <7v8ve672ar.fsf@alter.siamese.dyndns.org>
 <20120726193359.GA28711@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 22:26:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuUe4-000272-Ta
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 22:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182Ab2GZU0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 16:26:47 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37577 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877Ab2GZU0q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 16:26:46 -0400
Received: (qmail 13234 invoked by uid 107); 26 Jul 2012 20:26:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jul 2012 16:26:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jul 2012 16:26:44 -0400
Content-Disposition: inline
In-Reply-To: <20120726193359.GA28711@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202302>

On Thu, Jul 26, 2012 at 03:33:59PM -0400, Jeff King wrote:

> I'm close to finished with a series that I think will at least make it
> better. Stay tuned.

Here it is. I was able to replicate the original problem by munging my
/etc/passwd, and I've confirmed that this series fixes it by skipping
the related test. I also added in a test for the early-quit behavior
introduced by f20f387. It can't run everywhere, of course, but it seems
we have at least one tester whose system will run it (and I did confirm
that it works with my munged /etc/passwd).

One other option is that we could introduce a
GIT_PRETEND_THIS_IS_MY_GECOS_NAME variable. That would let us wrong both
sides of the test on all systems. I just hate to add an interface that
will be carried around in production code just for the sake of a test.

  [1/6]: t7502: clean up fake_editor tests
  [2/6]: t7502: properly quote GIT_EDITOR
  [3/6]: t7502: narrow checks for author/committer name in template
  [4/6]: t7502: drop confusing test_might_fail call
  [5/6]: t7502: handle systems where auto-identity is broken
  [6/6]: t7502: test early quit from commit with bad ident

-Peff
