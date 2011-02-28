From: Jeff King <peff@peff.net>
Subject: Re: git diff: add option for omitting the contents of deletes
Date: Mon, 28 Feb 2011 16:54:54 -0500
Message-ID: <20110228215454.GB5854@sigill.intra.peff.net>
References: <7vk4gm7dz3.fsf@alter.siamese.dyndns.org>
 <4D6A6291.8050206@drmicha.warpmail.net>
 <7v7hclulz0.fsf@alter.siamese.dyndns.org>
 <7v39n9uldp.fsf@alter.siamese.dyndns.org>
 <4D6B4F6B.1040209@drmicha.warpmail.net>
 <20110228121726.GA5197@sigill.intra.peff.net>
 <20110228122335.GB5197@sigill.intra.peff.net>
 <4D6B95E3.7040603@drmicha.warpmail.net>
 <20110228125909.GA9054@sigill.intra.peff.net>
 <4D6B9DA1.4070805@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Mart =?utf-8?B?U8O1bWVybWFh?= <mrts.pydev@gmail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 28 22:55:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuB3V-0002PU-Tk
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 22:55:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837Ab1B1Vy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 16:54:56 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:54485 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752496Ab1B1Vyz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 16:54:55 -0500
Received: (qmail 28952 invoked by uid 111); 28 Feb 2011 21:54:52 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 28 Feb 2011 21:54:52 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Feb 2011 16:54:54 -0500
Content-Disposition: inline
In-Reply-To: <4D6B9DA1.4070805@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168153>

On Mon, Feb 28, 2011 at 02:05:37PM +0100, Michael J Gruber wrote:

> When I said "copy patch" I actually meant a patch which records the copy
> "Makefile -> Dofile". What is it today? Is it me? I know I wrote the
> "mv" example first, but still :)

Yeah, I looked at the "mv" example and totally glossed over the word
"copy" in your text.

> I mean, Alice:
> cp Makefile Dofile
> sends me a -C patch
> 
> I:
> Break everything by hacking Makefile
> send her a crappy patch
> 
> Both:
> apply the received patch
> 
> Now I end up with a borked Makefile and a borked Dofile, but Alice still
> has a good Dofile, and it's all my fault, so I don't deserve any better.
> But still.

OK, this is a much better example. Yes, you have different state at the
end, and there were no conflicts. I don't think we can resolve the
situation automagically, but I think it would at least be nice to
mention the conflict.

I guess the big question is how to mention it. Should it cause the patch
application to fail? I'm worried about that creating unnecessary false
positives for cases that are really quite harmless. Should patch
application just give a warning unless --strict-renames or something is
used? I dunno. This is one of those corner cases where we can see that
there is a potential problem, but it hasn't actually come up in
practice, so it's difficult to see what would be most useful in the real
world. Maybe that means we are wasting our time thinking about it. :)

> This is orthogonal to the "-D" suggestion", but "-D" could write the
> index line to start with.

Yeah. I had just assumed that "-D" would be the same as the current
text, minus the actual patch lines. IOW:

  diff --git a/Makefile b/Makefile
  deleted file mode 100644
  index c9ff69c..0000000

-Peff
