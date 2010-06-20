From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] builtin/checkout: DWIM with -f -b
Date: Sun, 20 Jun 2010 17:16:05 -0400
Message-ID: <20100620211605.GA2559@sigill.intra.peff.net>
References: <1277051592-4552-1-git-send-email-rctay89@gmail.com>
 <1277051592-4552-2-git-send-email-rctay89@gmail.com>
 <1277051592-4552-3-git-send-email-rctay89@gmail.com>
 <1277051592-4552-4-git-send-email-rctay89@gmail.com>
 <7vvd9dtt54.fsf@alter.siamese.dyndns.org>
 <20100620201137.GA8502@coredump.intra.peff.net>
 <7vpqzltnp3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 20 23:16:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQRsK-0001pm-9P
	for gcvg-git-2@lo.gmane.org; Sun, 20 Jun 2010 23:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661Ab0FTVQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jun 2010 17:16:13 -0400
Received: from peff.net ([208.65.91.99]:37409 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778Ab0FTVQM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jun 2010 17:16:12 -0400
Received: (qmail 8846 invoked by uid 107); 20 Jun 2010 21:17:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 20 Jun 2010 17:17:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Jun 2010 17:16:06 -0400
Content-Disposition: inline
In-Reply-To: <7vpqzltnp3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149406>

On Sun, Jun 20, 2010 at 02:10:32PM -0700, Junio C Hamano wrote:

> FWIW, I often end up doing this when rebuilding 'pu' (and 'jch' that is
> used internally that keeps a version of 'next' with cleaner history).
> 
>     ... a script to regenerate jch on top of master (and pu on jch)
>     $ Meta/Reintegrate master..jch >Meta/redo-jch.sh
>     $ Meta/Reintegrate jch..pu >Meta/redo-pu.sh
> 
>     ... rewind and rebuild jch on top of updated master
>     $ git checkout -f -b jch master
>     ... error ... oops
>     $ git branch -f jch master
>     $ git checkout jch
>     $ Meta/redo-jch.sh
>     $ git diff next
>     ... no output---good.

I'm certainly sympathetic, but as I understand it, with this new patch
you are doing the equivalent of:

  git branch -f jch master
  git checkout -f jch

which is different than what you wrote above.  For your workflow, I
doubt it matters, but it is potentially destructive.

-Peff
