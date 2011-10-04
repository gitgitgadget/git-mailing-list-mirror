From: Jeff King <peff@peff.net>
Subject: Re: pack-object poor performance (with large number of objects?)
Date: Tue, 4 Oct 2011 07:07:02 -0400
Message-ID: <20111004110702.GA18599@sigill.intra.peff.net>
References: <CAA01CspZijOO_xbR=OcaRaesTeSy=6RM4DR01-07qimVzxvJZA@mail.gmail.com>
 <CAJo=hJtw+sYrP09zrDbZJNGHDYOeguQLkOe88FBYQDZrnaqsAw@mail.gmail.com>
 <CAA01CsppPf_6Zp5UPYBsxa1JEwLGF-FqacRa7kBJ45Ges2ujrw@mail.gmail.com>
 <7v62k5g988.fsf@alter.siamese.dyndns.org>
 <CAA01CsoSTsBLNcbv5o6Jx6YrjG4g8T=yodX811ymBLXg7sjDJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 13:07:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB2q8-00086a-Pi
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 13:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755747Ab1JDLHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 07:07:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52115
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755040Ab1JDLHG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 07:07:06 -0400
Received: (qmail 7573 invoked by uid 107); 4 Oct 2011 11:12:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Oct 2011 07:12:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2011 07:07:02 -0400
Content-Disposition: inline
In-Reply-To: <CAA01CsoSTsBLNcbv5o6Jx6YrjG4g8T=yodX811ymBLXg7sjDJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182760>

On Tue, Oct 04, 2011 at 09:59:08AM +0200, Piotr Krukowiecki wrote:

> I've run the command and it took about 20 minutes in "Counting
> objects" to count up to 500000 on idle machine and there's still 700MB
> RAM free.
> [...]
> So it looks it's not a problem with git but rather with my disk/file
> system/linux...

You mentioned that git was in the 'D' state earlier. And it sounds like
you have 1.7 million objects, _completely_ unpacked.

So my guess is that it is simply taking an enormous amount of disk
space, and git is mostly waiting on the disk to read in files. What does
"du -sh .git/objects" say?

-Peff
