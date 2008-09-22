From: Jeff King <peff@peff.net>
Subject: Re: Re* [RFC/PATCH] extend meaning of "--root" option to index
	comparisons
Date: Mon, 22 Sep 2008 09:15:57 -0400
Message-ID: <20080922131556.GA7133@sigill.intra.peff.net>
References: <bd6139dc0809151411p49f5adeaq4beff452574ca980@mail.gmail.com> <20080915223442.GD20677@sigill.intra.peff.net> <bd6139dc0809152319m31a79877h5dc1b701a8210802@mail.gmail.com> <20080916062105.GA12708@coredump.intra.peff.net> <20080918092152.GA18732@coredump.intra.peff.net> <3665a1a00809180931t191b5a24wd58554cdb761535@mail.gmail.com> <20080919142537.GA1287@coredump.intra.peff.net> <7vskrvswxp.fsf@gitster.siamese.dyndns.org> <20080921135616.GA25238@sigill.intra.peff.net> <3665a1a00809210858r1c494d22p77b5e9964c06424e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, sverre@rabbelier.nl,
	Git Mailing List <git@vger.kernel.org>
To: Anatol Pomozov <anatol.pomozov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 15:17:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhlI4-0003Fa-3K
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 15:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbYIVNQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 09:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753286AbYIVNQI
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 09:16:08 -0400
Received: from peff.net ([208.65.91.99]:1209 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753089AbYIVNQH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 09:16:07 -0400
Received: (qmail 6565 invoked by uid 111); 22 Sep 2008 13:16:03 -0000
Received: from c-75-75-5-148.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (75.75.5.148)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 22 Sep 2008 09:16:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Sep 2008 09:15:57 -0400
Content-Disposition: inline
In-Reply-To: <3665a1a00809210858r1c494d22p77b5e9964c06424e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96479>

On Sun, Sep 21, 2008 at 08:58:30AM -0700, Anatol Pomozov wrote:

> revision is broken (like we have a junk in the HEAD file) from the
> case when "branch is not created yet" (which is part of normal
> workflow).
> 
> What about following algorithm. HEAD points to ref and ref is not
> created yet. Additional check could be
>  a) there are no other refs
>  or/and b) object database is empty

I don't think those things have to do with "branch not created yet".
They are about "repository has no branches".

The only thing that indicates you a branch has not been created is the
absence of that ref. So you really have two situations there:

  1. a symref like HEAD points to a branch that does not exist

  2. the user inputs a ref-name that does not exist

In the former, that means we are on a branch that hasn't been created
yet (which generally does mean a new repo, but it's possible to reach
this state in other ways). Or it means somebody made a mistake when they
updated the symref.

In the latter, it _could_ mean that we are interested in a branch yet to
be born, but in general we consider it to mean the user made a typo.

-Peff
