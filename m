From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 0/5] verify-commit: verify commit signatures
Date: Mon, 23 Jun 2014 13:28:05 -0400
Message-ID: <20140623172805.GD4838@sigill.intra.peff.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
 <cover.1403506792.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 19:28:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz82O-00038j-SU
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 19:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756550AbaFWR2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 13:28:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:49751 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753213AbaFWR2H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 13:28:07 -0400
Received: (qmail 2907 invoked by uid 102); 23 Jun 2014 17:28:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 Jun 2014 12:28:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jun 2014 13:28:05 -0400
Content-Disposition: inline
In-Reply-To: <cover.1403506792.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252356>

On Mon, Jun 23, 2014 at 09:05:46AM +0200, Michael J Gruber wrote:

> This incorporates all remarks about the test coding guidelines and
> rearranging the series.
> 
> Open questions:
> - There was some debate about (optionally) verifying more than what
> git-verify-{commit,tag} currently do, or going for a generic git-verify command.
> The former would require both to be changed (in order to treat similar cases similarly),
> the latter would need a deprecation for git-verify-tag.

I think that a potential "git verify" doesn't need to block this series,
per the logic I gave elsewhere.

The one thing that does give me pause is that we do not seem to have any
way of accessing mergetag signatures. We should perhaps stop and think
for a second about how we might expose those (and whether it would fit
into the "git-verify-{commit,tag}" paradigm). I am tempted to say that
"git verify-tag" on a commit should verify the mergetag (right now it
would simply be an error). But I haven't though that hard on it.

I don't think implementation of that needs to be a blocker for this
series, but I'd rather see at least a vague plan so that we do not paint
ourselves into a corner.

> Michael J Gruber (5):
>   gpg-interface: provide clear helper for struct signature_check
>   gpg-interface: provide access to the payload
>   verify-commit: scriptable commit signature verification
>   t7510: exit for loop with test result
>   t7510: test verify-commit

I didn't see anything objectionable here. I think you may want to rebase
on top of jk/pretty-G-format-fixes. That makes your patch 4 redundant,
and your patch 5 will probably need a few minor updates to match
cleanups in the surrounding code.

-Peff
