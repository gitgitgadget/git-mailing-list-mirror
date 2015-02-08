From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] config: do not ungetc EOF
Date: Sun, 8 Feb 2015 22:13:34 +0100
Message-ID: <20150208211334.GA3796@book.hvoigt.net>
References: <20150205065327.GA7807@peff.net>
 <20150205210024.GA30724@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 08 22:23:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKZKM-0006vG-Rg
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 22:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759027AbbBHVXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 16:23:34 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.27]:44005 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213AbbBHVXe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 16:23:34 -0500
Received: from [77.20.146.160] (helo=book.hvoigt.net)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1YKZAi-0000Pt-1O; Sun, 08 Feb 2015 22:13:40 +0100
Content-Disposition: inline
In-Reply-To: <20150205210024.GA30724@peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263533>

On Thu, Feb 05, 2015 at 04:00:24PM -0500, Jeff King wrote:
> On Thu, Feb 05, 2015 at 01:53:27AM -0500, Jeff King wrote:
> 
> > I also notice that config_buf_ungetc does not actually ungetc the
> > character we give it; it just rewinds one character in the stream. This
> > is fine, because we always feed the last-retrieved character. I dunno if
> > it is worth fixing (it also would have fixed this infinite loop, but for
> > the wrong reason; we would have stuck "-1" back into the stream, and
> > retrieved it on the next fgetc rather than the same '\r' over and over).
> 
> Here's a patch to deal with that. I'm not sure if it's worth doing or
> not.
> 
> -- >8 --
> Subject: [PATCH] config_buf_ungetc: warn when pushing back a random character

Thanks for noticing and fixing both. I think it is worth adding this
assertion. If someone in the future comes along and uses our fake
ungetc() wrong it might save some trouble figuring out whats wrong.

Cheers Heiko
