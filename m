From: Jeff King <peff@peff.net>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 1 May 2008 11:34:57 -0400
Message-ID: <20080501153457.GB11469@sigill.intra.peff.net>
References: <4819CF50.2020509@tikalk.com> <4819D98E.1040004@tikalk.com> <32541b130805010827r22169651s37c707071f3448f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ittay Dror <ittayd@tikalk.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 17:35:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrap4-0007N2-BV
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 17:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759773AbYEAPfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 11:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760891AbYEAPe7
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 11:34:59 -0400
Received: from peff.net ([208.65.91.99]:2148 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760804AbYEAPe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 11:34:58 -0400
Received: (qmail 14578 invoked by uid 111); 1 May 2008 15:34:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 01 May 2008 11:34:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 May 2008 11:34:57 -0400
Content-Disposition: inline
In-Reply-To: <32541b130805010827r22169651s37c707071f3448f2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80924>

On Thu, May 01, 2008 at 11:27:34AM -0400, Avery Pennarun wrote:

> Before you say this is not a realistic use case, I've personally had
> this exact problem:
> 
> - I had a project with all of my work in a folder "src"
> - I decided that the 'src' folder was redundant, so I moved it all to
> the root folder
> - Someone else was working on an old maintenance branch which still had 'src'
> - When I merged from that person, some new files were created under
> 'src', and of course didn't work.

Sure. But we've also had the exact case of:

  - there are some files in subdir/, but that is not a good name, and
    there is something else that you are going to add that would be
    better named as subdir/.
  - you rename subdir/ to bettername/
  - you create subdir/newfile

but you _don't_ want newfile to go into bettername/. It's _replacing_
what went into bettername/.

So I don't think you can always track the intent automatically.

Though if you could specify the intent to the SCM, you could
differentiate at the time of move between these two cases, and the merge
could do the right thing later. Or alternatively, you could specify at
time of merge which to do.  It's just that nobody has implemented it.

-Peff
