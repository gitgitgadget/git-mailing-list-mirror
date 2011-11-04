From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Escape file:// URL's to meet subversion SVN::Ra requirements
Date: Thu, 03 Nov 2011 22:11:49 -0400
Message-ID: <1320372215-sup-8341@pinkfloyd.chass.utoronto.ca>
References: <1320251895-6348-1-git-send-email-bwalton@artsci.utoronto.ca> <1320251895-6348-2-git-send-email-bwalton@artsci.utoronto.ca> <20111102182015.GA11401@elie.hsd1.il.comcast.net> <1320260449-sup-479@pinkfloyd.chass.utoronto.ca> <20111102220941.GA3925@dcvr.yhbt.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Nov 04 03:11:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RM9G9-0007X1-5J
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 03:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236Ab1KDCLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 22:11:52 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:40572 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052Ab1KDCLv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 22:11:51 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:36449 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1RM9G1-0000p2-VB; Thu, 03 Nov 2011 22:11:49 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1RM9G1-0004xM-U9; Thu, 03 Nov 2011 22:11:49 -0400
In-reply-to: <20111102220941.GA3925@dcvr.yhbt.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184755>

Excerpts from Eric Wong's message of Wed Nov 02 18:09:41 -0400 2011:

Hi Eric,

> I don't have much time to help you fix it, but I got numerous errors
> on SVN 1.6.x (svn 1.6.12).  Can you make sure things continue to
> work on 1.6 and earlier, also?

Yes, it's a bit of a mess, I think.  It looks as though the
modification required within Git::SVN::Ra is going to negatively
impact other code paths that interact with that package from the
outside.

For example, when doing git svn init --minimize-url ..., the minimized
url is not escaped while the url is.  The minimized url is used to
strip off the head from the full url using a regex.  This now breaks
because of the escaping.

Fixing this locally to the use of the minimized url let me move on
farther but I then got another core dump.

> Maybe just enable the escaping for file:// on >= SVN 1.7

I think that it would be best if this change was only effective for
1.7.

I wonder if all URL-ish objects should be (conditionally iff svn >=
1.7) subjected to escaping?

This would require some restructuring and will take me a bit of time
to work out as I need to familiarize myself with the code to a deeper
level.

Pointers welcomed. :)

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
