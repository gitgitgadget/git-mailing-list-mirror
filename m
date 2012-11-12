From: Jeff King <peff@peff.net>
Subject: Re: RFD: fast-import is picky with author names (and maybe it should
 - but how much so?)
Date: Mon, 12 Nov 2012 16:41:27 -0500
Message-ID: <20121112214127.GA10531@sigill.intra.peff.net>
References: <CAMP44s3Lhxzcj93=e8TXwqAVvGJBKhZEVX33G8Q=n2+8+UfCww@mail.gmail.com>
 <509E8EB2.7040509@drmicha.warpmail.net>
 <CAMP44s219Zi2NPt2vA+6Od_sVstFK85OXZK-9K1OCFpVh220+A@mail.gmail.com>
 <509EAA45.8020005@gmail.com>
 <CAMP44s1dsEU=E8tdgMYxWFyFw+F03bstdb5o7Ww_-RCQPd3R0w@mail.gmail.com>
 <509FD9BC.7050204@gmail.com>
 <20121111171518.GA20115@sigill.intra.peff.net>
 <CAMP44s1mny-fBCxywM0V=AgEoxV5EZdDWc_0NK3gepcKf32nww@mail.gmail.com>
 <20121111181406.GA21654@sigill.intra.peff.net>
 <CAMP44s1m8sAD9D0F-6b=+dm_AvLb_4_f7h=3A_VMYMDUEcTW7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 22:41:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY1lP-0004Yf-Ew
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 22:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245Ab2KLVld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 16:41:33 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45074 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301Ab2KLVlb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 16:41:31 -0500
Received: (qmail 14475 invoked by uid 107); 12 Nov 2012 21:42:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 16:42:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 16:41:27 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s1m8sAD9D0F-6b=+dm_AvLb_4_f7h=3A_VMYMDUEcTW7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209530>

On Sun, Nov 11, 2012 at 07:48:14PM +0100, Felipe Contreras wrote:

> >   3. Exporters should not use it if they have any broken-down
> >      representation at all. Even knowing that the first half is a human
> >      name and the second half is something else would give it a better
> >      shot at cleaning than fast-import would get.
> 
> I'm not sure what you mean by this. If they have name and email, then
> sure, it's easy.

But not as easy as just printing it. What if you have this:

  name="Peff <angle brackets> King"
  email="<peff@peff.net>"

Concatenating them does not produce a valid git author name. Sending the
concatenation through fast-import's cleanup function would lose
information (namely, the location of the boundary between name and
email).

Similarly, one might have other structured data (e.g., CVS username)
where the structure is a useful hint, but some conversion to name+email
is still necessary.

-Peff
