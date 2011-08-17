From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] update-index: add --swap to swap index and worktree
 content
Date: Tue, 16 Aug 2011 19:17:27 -0700
Message-ID: <20110817021727.GA29585@sigill.intra.peff.net>
References: <1313158058-7684-1-git-send-email-pclouds@gmail.com>
 <7vippxgm6y.fsf@alter.siamese.dyndns.org>
 <20110816210108.GA13710@sigill.intra.peff.net>
 <7vbovpggva.fsf@alter.siamese.dyndns.org>
 <20110816222212.GA19471@sigill.intra.peff.net>
 <7vzkj9eza2.fsf@alter.siamese.dyndns.org>
 <20110816230654.GA21793@sigill.intra.peff.net>
 <CACsJy8Ad4xPz79jT3O64c3XsCeM8XETJ9bnjK0aisagrYN0CMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 04:17:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtVhI-0001Di-DZ
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 04:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167Ab1HQCRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 22:17:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51650
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751771Ab1HQCRb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 22:17:31 -0400
Received: (qmail 8277 invoked by uid 107); 17 Aug 2011 02:18:10 -0000
Received: from 173-164-171-125-SFBA.hfc.comcastbusiness.net (HELO sigill.intra.peff.net) (173.164.171.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Aug 2011 22:18:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Aug 2011 19:17:27 -0700
Content-Disposition: inline
In-Reply-To: <CACsJy8Ad4xPz79jT3O64c3XsCeM8XETJ9bnjK0aisagrYN0CMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179497>

On Wed, Aug 17, 2011 at 09:11:32AM +0700, Nguyen Thai Ngoc Duy wrote:

> I blame git for training me always do "git diff" before update index.
> But if we add "add -e", I could also make "add -e -p" work, (edit
> temporary file first, then fall back to interactive mode and let me
> review my changes).

Yeah, that would be cool. But note that "git add -e" already exists for
patch editing.

> Two reasons. I already mentioned the ability to quickly checkout index
> for a quick test (though there could be more problems down that road).

That's a good thought. However, in practice, I find I also need other
files from the index to do a successful test. So I end up just
committing what I think is right, and then afterwards do:

  GIT_EDITOR='sed -i "/^pick .*/aexec make test/"' git rebase -i

to test and fixup each commit individually.

You could probably use "checkout-index" to create a pristine workspace
to test. It's a little inefficient to write out all of the files again,
but probably the actual build and test procedure would be much more
expensive, anyway.

-Peff
