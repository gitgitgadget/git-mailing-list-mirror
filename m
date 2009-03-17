From: Jeff King <peff@peff.net>
Subject: Re: Transparently encrypt repository contents with GPG
Date: Tue, 17 Mar 2009 03:40:54 -0400
Message-ID: <20090317074054.GA18475@coredump.intra.peff.net>
References: <978bdee00903121419o61cd7a87rb55809796bd257d7@mail.gmail.com> <fabb9a1e0903121434u4a3d71bdi6277071f54557a7e@mail.gmail.com> <49BA39A1.9090203@drmicha.warpmail.net> <200903131215.49336.trast@student.ethz.ch> <fabb9a1e0903130417x36121bd5ya8b323e0a80bbd8f@mail.gmail.com> <49BA6606.1070403@fastmail.fm> <7vy6v9f9zn.fsf@gitster.siamese.dyndns.org> <49BB920A.20301@drmicha.warpmail.net> <7viqmcaqov.fsf@gitster.siamese.dyndns.org> <49BE77DD.5020407@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Matthias Nothhaft <matthias.nothhaft@googlemail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 17 08:43:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjTwx-0004w2-Tr
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 08:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbZCQHlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 03:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752764AbZCQHlE
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 03:41:04 -0400
Received: from peff.net ([208.65.91.99]:51566 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481AbZCQHlC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 03:41:02 -0400
Received: (qmail 2653 invoked by uid 107); 17 Mar 2009 07:41:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 17 Mar 2009 03:41:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Mar 2009 03:40:54 -0400
Content-Disposition: inline
In-Reply-To: <49BE77DD.5020407@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113431>

On Mon, Mar 16, 2009 at 05:01:33PM +0100, Michael J Gruber wrote:

> Now, a simple test shows that git diff obviously does this when diffing
> HEAD to worktree:
> 
> diff between HEAD and clean(worktree)
> 
> Which is the right thing. It just seems so that textconv is not even
> called "in the wrong place of the chain", but messes the diff up in this
> way:
> 
> diff between textconv(HEAD) and textconv(worktree)
> 
> (I expected clean(textconv(worktree)) first, which would be wrong, too).
> I.e., the clean filter is ignored completely in the presence of textconv.

Yeah, I think this should probably be textconv(clean(worktree)) to match
the regular HEAD/worktree diff (if it isn't already). Can you put
together a test that shows the breakage?

-Peff
