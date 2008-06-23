From: Jeff King <peff@peff.net>
Subject: Re: about c8af1de9 (git status uses pager)
Date: Mon, 23 Jun 2008 11:23:10 -0400
Message-ID: <20080623152309.GA24101@sigill.intra.peff.net>
References: <alpine.LNX.1.10.0806212319410.22036@fbirervta.pbzchgretzou.qr> <19f34abd0806211430x3d7195d8idc61b7103f899947@mail.gmail.com> <7vzlpe8nyo.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.10.0806212343560.18093@fbirervta.pbzchgretzou.qr> <alpine.LNX.1.10.0806221107540.15126@fbirervta.pbzchgretzou.qr> <7vtzflolis.fsf@gitster.siamese.dyndns.org> <7vtzfln5zw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan Engelhardt <jengelh@medozas.de>,
	Vegard Nossum <vegard.nossum@gmail.com>,
	Bart Trojanowski <bart@jukie.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 17:24:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAntw-0005GY-NL
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 17:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917AbYFWPXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 11:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755127AbYFWPXN
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 11:23:13 -0400
Received: from peff.net ([208.65.91.99]:4317 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754917AbYFWPXN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 11:23:13 -0400
Received: (qmail 26797 invoked by uid 111); 23 Jun 2008 15:23:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 23 Jun 2008 11:23:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jun 2008 11:23:10 -0400
Content-Disposition: inline
In-Reply-To: <7vtzfln5zw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85871>

On Sun, Jun 22, 2008 at 03:01:07AM -0700, Junio C Hamano wrote:

> Jeff had a patch to allow boolean configuration variable "pager.<command>"
> to override the built-in pager settings during 1.5.6 cycle, and I think it
> was a reasonable approach to take.  People who want to page output from
> git-status can then set "pager.status = true" in their configuration (and
> then we can revert c8af1de (make git-status use a pager, 2008-04-23)).
> Alternatively we could keep the current status-quo for the default, and
> people can say "pager.status = false" in their configuration.

I have been running with the patch for a month or two, and it works fine
for controlling the pager. Unfortunately, there is a nasty interaction
in the git wrapper with reading the config file early, and we end up not
calculating the GIT_DIR and worktree in the same way. I think this is
part of a larger problem which needs solving, but everytime I look at
it, my eyes start bleeding (and I have to admit, since the patch does
work, I have forgotten how annoyed I was at the paging behavior in the
first place, and I don't have as much motivation to work on it).

I think this is deeply related to the "git config alias.st status && cd
.git && git st" problem, which is also on my long-term todo. So I'll see
if I can do something about it during this release cycle.

-Peff
