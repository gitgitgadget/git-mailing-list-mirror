From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] do not pretend sha1write returns errors
Date: Sun, 22 Dec 2013 11:55:36 +0100
Message-ID: <87lhzdqhnb.fsf@thomasrast.ch>
References: <20131221141325.GA23828@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 22 11:55:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VughQ-0005Iv-GF
	for gcvg-git-2@plane.gmane.org; Sun, 22 Dec 2013 11:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143Ab3LVKzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Dec 2013 05:55:52 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:54757 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753843Ab3LVKzv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Dec 2013 05:55:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 854CA4D6574;
	Sun, 22 Dec 2013 11:55:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 291aOcC3ilHc; Sun, 22 Dec 2013 11:55:37 +0100 (CET)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 160B24D64C4;
	Sun, 22 Dec 2013 11:55:37 +0100 (CET)
In-Reply-To: <20131221141325.GA23828@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 21 Dec 2013 09:13:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239642>

Jeff King <peff@peff.net> writes:

> The sha1write function returns an int, but it will always be
> "0". The failure-prone parts of the function happen in the
> "flush" callback, which cannot pass an error back to us. So
> we just end up calling die() during the flush.
>
> Let's just drop the return value altogether, as it only
> confuses callers into thinking that it might be useful.
>
> Only one call site actually checked the return value. We can
> drop that check, since it just led to a die() anyway.
>
> Signed-off-by: Jeff King <peff@peff.net>

Thanks.

> This is kind of a step backwards if we ever wanted to actually make
> sha1write's return code mean anything. But I just don't foresee that
> happening.

Meh.  It hasn't returned a useful value since its introduction in 2005.

-- 
Thomas Rast
tr@thomasrast.ch
