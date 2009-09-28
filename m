From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-am: force egrep to use correct characters set
Date: Mon, 28 Sep 2009 03:16:09 -0400
Message-ID: <20090928071609.GB20483@coredump.intra.peff.net>
References: <215cc4f241162377b9249c2b3d74050cc77bac16.1253893253.git.chressie@gmail.com>
 <f0bd48168975c3b2328cf26f9a37a0f54b898473.1253896646.git.chressie@gmail.com>
 <20090927074015.GB15393@coredump.intra.peff.net>
 <20090928065519.GA24773@lamagra.informatik.uni-ulm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Christian Himpel <chressie@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 09:16:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsAT5-0007Gs-HE
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 09:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbZI1HQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 03:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbZI1HQJ
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 03:16:09 -0400
Received: from peff.net ([208.65.91.99]:35912 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751546AbZI1HQI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 03:16:08 -0400
Received: (qmail 24178 invoked by uid 107); 28 Sep 2009 07:19:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 28 Sep 2009 03:19:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Sep 2009 03:16:09 -0400
Content-Disposition: inline
In-Reply-To: <20090928065519.GA24773@lamagra.informatik.uni-ulm.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129231>

On Mon, Sep 28, 2009 at 08:55:19AM +0200, Christian Himpel wrote:

> > Do you happen to know a charset in which this is a problem, just for
> > reference?
> 
> No, I don't know any charset with stray ascii-chars.  I just listened
> attentively, when I read the part about the mixed alphabet characters in
> the grep(1) manpage.
> 
> I did some quick checks just now.  It seems the characters (' ' to '~')
> are in any locale, offered by glibc, at the same place.
> 
> Maybe, we can just leave the charset as it is and ignore this patch,
> until someone complains.

Thanks for looking into it. My question was more of a "how bad is this,
and should we be fixing these other callsites, too". But I think 0-7 is
probably a pretty safe range in any charset.

Usually with portability issues, I am inclined to say "wait for a
problem", as we try to code to match actual reality instead of
documentation or standards. But in this case, we are unlikely to test
with strange charsets (or even know which strange charsets exist;
checking what's in glibc is reasonable, but I have no idea what else is
out there in other countries), and that the resulting bug would be
subtle and hard to find, it probably makes sense to be a little
defensive.

-Peff
