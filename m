From: Jeff King <peff@peff.net>
Subject: Re: git symbolic-ref vs. reflog (vs. rebase)
Date: Fri, 29 Apr 2011 18:48:30 -0400
Message-ID: <20110429224829.GC3434@sigill.intra.peff.net>
References: <ipek0o$l0v$1@dough.gmane.org>
 <7vk4edyqqn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Csaba Henk <csaba@lowlife.hu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 00:48:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFwUH-00075n-Ow
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 00:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134Ab1D2Wsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 18:48:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38691
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755065Ab1D2Wsc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 18:48:32 -0400
Received: (qmail 17209 invoked by uid 107); 29 Apr 2011 22:50:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Apr 2011 18:50:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Apr 2011 18:48:30 -0400
Content-Disposition: inline
In-Reply-To: <7vk4edyqqn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172505>

On Fri, Apr 29, 2011 at 09:19:44AM -0700, Junio C Hamano wrote:

> Csaba Henk <csaba@lowlife.hu> writes:
> 
> > "git symbolic-ref" is a dangerous command in the sense that it can
> > change your HEAD position without updating the reflog. Is it
> > intended behaviour?
> 
> Yes, it is.  But you can choose to do:
> 
> 	$ git branch side
> 	$ git symoblic-ref -m "move to side" HEAD refs/heads/side
>         $ git log --oneline -g HEAD@{0}
>         05ddb9b HEAD@{0}: move to side
> 	e69de29 HEAD@{1}: commit (initial): first commit
> 
> if you wanted to.

I think every caller should be using "-m" these days.  I know we can't
_require_ it for historical reasons. But shouldn't symbolic-ref always
write a reflog entry? Even something like "we changed and I can't tell
you why" to cover older scripts that call symbolic-ref?

-Peff
