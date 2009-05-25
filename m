From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] t8005: convert CP1251 character set to ISO8859-5
Date: Mon, 25 May 2009 05:20:27 -0400
Message-ID: <20090525092027.GA22382@coredump.intra.peff.net>
References: <7vhbzd85ux.fsf@alter.siamese.dyndns.org> <p2A1PR1KFf_G_uMMwQZtVeaDE_VcBr8lFjs9Jsg_OIkeypNbwPPRHP32EUHJ4leCZsycUOhFjHc@cipher.nrlssc.navy.mil> <p2A1PR1KFf_G_uMMwQZtVXPPBSNcQqEAV1ZnkoQLMJaPzWwJrkH_HCs5Kbt70yQlltZJxs4WxXo@cipher.nrlssc.navy.mil> <7vskiw4ooe.fsf@alter.siamese.dyndns.org> <7vhbzc4oht.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 25 11:20:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8WMG-00058o-Mx
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 11:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbZEYJUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 05:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbZEYJU3
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 05:20:29 -0400
Received: from peff.net ([208.65.91.99]:45464 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751707AbZEYJU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 05:20:28 -0400
Received: (qmail 2611 invoked by uid 107); 25 May 2009 09:20:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 25 May 2009 05:20:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 25 May 2009 05:20:27 -0400
Content-Disposition: inline
In-Reply-To: <7vhbzc4oht.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119905>

On Fri, May 22, 2009 at 06:06:06PM -0700, Junio C Hamano wrote:

> It also appears that we do not need OLD_ICONV anymore, as our Makefile
> suggests for older releases.
> 
> It would be nice if people with older Solaris can check if I am not
> breaking things for them...

Git builds fine on my Solaris 8 test box with this patch. It also builds
fine if I drop OLD_ICONV, so it may be that we can unconditionally do
so (but I don't have any older boxen to test with).

With current 'next' and NO_PERL set, I can pass every test except:

  t3900 - still problems in the eucJP test. I haven't looked closely,
          but my understanding is that this might need extra language
          packs installed (I know virtually nothing about Solaris
          administration and the box is not mine).

  t8005 - git produces incorrect (or at least not expected) results for
          the iso8859-5 to sjis conversion. It all looks like control
          characters to me, so I'm not sure how to diagnose (and it may
          just be an installation issue again).

  t4116,t5000,t5001 - Solaris tar doesn't like pax headers that
                      git-archive generates

  t7700 - seems to be some problem invoking touch. This might be easily
          fixable, so I'll look into it.

-Peff
