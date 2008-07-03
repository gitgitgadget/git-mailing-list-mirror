From: Jeff King <peff@peff.net>
Subject: Re: finding deleted file names
Date: Thu, 3 Jul 2008 15:47:28 -0400
Message-ID: <20080703194728.GA18443@sigill.intra.peff.net>
References: <93c3eada0807021701m13b7adddv51537f4cf9d52533@mail.gmail.com> <20080703103658.GA11571@sigill.intra.peff.net> <7vzloyzrew.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Geoff Russell <geoffrey.russell@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 21:48:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEUn6-0003sS-IK
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 21:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbYGCTrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 15:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753495AbYGCTrb
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 15:47:31 -0400
Received: from peff.net ([208.65.91.99]:3007 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbYGCTra (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 15:47:30 -0400
Received: (qmail 3526 invoked by uid 111); 3 Jul 2008 19:47:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 03 Jul 2008 15:47:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jul 2008 15:47:28 -0400
Content-Disposition: inline
In-Reply-To: <7vzloyzrew.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87310>

On Thu, Jul 03, 2008 at 12:41:43PM -0700, Junio C Hamano wrote:

> Once reflog entries begin expiring, we won't have the null_sha1 on the
> previous side of them, and after that we will keep returning the
> oldest-known one, so nobody should be expecting to find out when a ref was
> first created in this repository by checking with what timestamp that
> syntax breaks in the existing interface.

Right, that was my thought: though perhaps not technically as precise,
it is much more DWIM.

My other concern, which I failed to voice in the original mail was:
should we do this magic for other reflog entries besides the first one?
It is possible to end up with a null sha1 in any other entry? Branch
creation shouldn't do it, because we will have deleted any previous
reflog when killing off the branch before, so we always end up putting
in the "oldest" reflog entry. Cloning shouldn't do it for obvious
reasons.

> Sorry for not being Shawn ;-)

Heh.

-Peff
