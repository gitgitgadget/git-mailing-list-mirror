From: Jeff King <peff@peff.net>
Subject: Re: Issue with compiling git 1.8.4 under uclibc with gcc 4.6.3
Date: Mon, 26 Aug 2013 16:59:01 -0400
Message-ID: <20130826205901.GC23598@sigill.intra.peff.net>
References: <521BB643.304@gmail.com>
 <20130826201804.GB13130@blizzard>
 <521BBA98.7010102@gmail.com>
 <20130826203154.GA21357@blizzard>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lance <lancethepants@gmail.com>, git@vger.kernel.org
To: Lukas Fleischer <git@cryptocrack.de>
X-From: git-owner@vger.kernel.org Mon Aug 26 22:59:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE3sV-00030y-Ip
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 22:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694Ab3HZU7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 16:59:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:39965 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576Ab3HZU7G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 16:59:06 -0400
Received: (qmail 31532 invoked by uid 102); 26 Aug 2013 20:59:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Aug 2013 15:59:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Aug 2013 16:59:01 -0400
Content-Disposition: inline
In-Reply-To: <20130826203154.GA21357@blizzard>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233028>

On Mon, Aug 26, 2013 at 10:31:54PM +0200, Lukas Fleischer wrote:

> > I also had to change line 224 to the following
> > 
> >                 c = (cf->fgetc)(cf);
> > 
> > Once both places were changes, it compiled successfully.
> 
> Sounds like a parser bug to me. Should we patch this in Git in order to
> make it compile with (broken?) GCC versions?

Hmm. I wonder if fgetc is a macro in uclibc? Just grepping their
stdio.h, it looks like that is a possibility.

I think they are probably wrong to do so (but I'd have to check the
standard). However, the cleaner workaround would probably be to call the
fgetc struct member something else.

-Peff
