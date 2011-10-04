From: Jeff King <peff@peff.net>
Subject: Re: pack-object poor performance (with large number of objects?)
Date: Tue, 4 Oct 2011 08:45:02 -0400
Message-ID: <20111004124502.GB30162@sigill.intra.peff.net>
References: <CAA01CspZijOO_xbR=OcaRaesTeSy=6RM4DR01-07qimVzxvJZA@mail.gmail.com>
 <CAJo=hJtw+sYrP09zrDbZJNGHDYOeguQLkOe88FBYQDZrnaqsAw@mail.gmail.com>
 <CAA01CsppPf_6Zp5UPYBsxa1JEwLGF-FqacRa7kBJ45Ges2ujrw@mail.gmail.com>
 <7v62k5g988.fsf@alter.siamese.dyndns.org>
 <CAA01CsoSTsBLNcbv5o6Jx6YrjG4g8T=yodX811ymBLXg7sjDJQ@mail.gmail.com>
 <20111004110702.GA18599@sigill.intra.peff.net>
 <CAA01CsodyUQJOnj5vV0LdVEWpkvwSW2TAONzyY9J82o9VwC6Ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 14:45:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB4N0-0007uD-6t
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 14:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118Ab1JDMpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 08:45:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52166
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932089Ab1JDMpF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 08:45:05 -0400
Received: (qmail 8309 invoked by uid 107); 4 Oct 2011 12:50:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Oct 2011 08:50:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2011 08:45:02 -0400
Content-Disposition: inline
In-Reply-To: <CAA01CsodyUQJOnj5vV0LdVEWpkvwSW2TAONzyY9J82o9VwC6Ag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182768>

On Tue, Oct 04, 2011 at 02:22:55PM +0200, Piotr Krukowiecki wrote:

> > So my guess is that it is simply taking an enormous amount of disk
> > space, and git is mostly waiting on the disk to read in files. What does
> > "du -sh .git/objects" say?
> 
> It isn't that big - it's 11G.
> .git/objects/pack/ is 666MB currently.

But you have 4G of RAM, no? So depending on the access patterns, you are
thrashing your disk cache and always pulling each object straight from
disk.

-Peff
