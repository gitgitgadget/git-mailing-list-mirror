From: Jeff King <peff@peff.net>
Subject: Re: git branch command is incompatible with bash
Date: Tue, 28 Jul 2015 12:25:17 -0400
Message-ID: <20150728162516.GA28031@peff.net>
References: <20150727121253.GC17338@2vizcon.com>
 <55B69E68.90306@kdbg.org>
 <xmqqh9opgtjz.fsf@gitster.dls.corp.google.com>
 <55B72F09.3030000@kdbg.org>
 <xmqq4mkogvb7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	Anatol Rudolph <a.rudolph@2vizcon.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 18:25:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK7gz-0002bF-GR
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 18:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbbG1QZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 12:25:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:35805 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751124AbbG1QZU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 12:25:20 -0400
Received: (qmail 9595 invoked by uid 102); 28 Jul 2015 16:25:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Jul 2015 11:25:19 -0500
Received: (qmail 17505 invoked by uid 107); 28 Jul 2015 16:25:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Jul 2015 12:25:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Jul 2015 12:25:17 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4mkogvb7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274784>

On Tue, Jul 28, 2015 at 08:23:40AM -0700, Junio C Hamano wrote:

> I can see that "symbolic-ref --short" is much newer than the other
> one, so addition of "--abbrev-ref" to "rev-parse" may have been a
> mistake made while being desperate (i.e. not having a way to do so
> with plumbing, we wanted "some" way to do so and chose poorly).

I think --abbrev-ref can handle much more than just shortening symrefs,
though:

E.g. resolving other symbolic names:

  $ git rev-parse --abbrev-ref @{u}
  origin/master

Or resolving any arbitrary name you happen to have:

  $ git rev-parse --abbrev-ref refs/heads/master
  master

Even ones that aren't fully qualified (which would be tough to do with
simple pattern substitution):

  $ git rev-parse --abbrev-ref remotes/origin/master
  origin/master

Or handling ambiguities during abbreviation:

  $ git tag master
  $ git rev-parse --abbrev-ref HEAD
  heads/master

-Peff
