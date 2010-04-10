From: Jeff King <peff@peff.net>
Subject: Re: [BUG] - git rebase -i performs rebase when it shouldn't?
Date: Sat, 10 Apr 2010 00:47:30 -0400
Message-ID: <20100410044730.GB24295@coredump.intra.peff.net>
References: <z2q76c5b8581004091235ucd9b2a52i223b3191b288c42a@mail.gmail.com>
 <20100410042609.GA24295@coredump.intra.peff.net>
 <7vsk73zzt1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 06:48:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0Sc8-0006Wp-S7
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 06:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308Ab0DJEry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 00:47:54 -0400
Received: from peff.net ([208.65.91.99]:49176 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924Ab0DJErx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 00:47:53 -0400
Received: (qmail 14713 invoked by uid 107); 10 Apr 2010 04:47:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 10 Apr 2010 00:47:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Apr 2010 00:47:30 -0400
Content-Disposition: inline
In-Reply-To: <7vsk73zzt1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144505>

On Fri, Apr 09, 2010 at 09:39:22PM -0700, Junio C Hamano wrote:

> I used to religiously rebase slushy topics that are not in any stable
> integration branches (we used to have only 'master' and 'pu'), and
> 
> 	git rebase master foo
>         git rebase master bar
>         git rebase master baz
> 
> was far easier to type than
> 
> 	git checkout foo && git rebase master
> 	git checkout bar && git rebase master
> 	git checkout baz && git rebase master

Interestingly, I faced a similar problem a few months ago. I have many
half-finished topics, and I aggressively rebase them against master
(mostly to see and fix conflicts early). But I wrote a script so I don't
have to type each one individually. :)

It uses for-each-ref with a filter to get the list of topics, and then
rebases in a loop.  It just barfs when a rebase has conflicts, which is
OK. You fix them, finish the rebase, and restart the script, which just
skips over the noop rebases. Eventually it finishes successfully.

-Peff
