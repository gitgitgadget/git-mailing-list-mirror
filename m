From: Jeff King <peff@peff.net>
Subject: Re: Question re. git remote repository
Date: Thu, 17 Jan 2013 15:49:13 -0800
Message-ID: <20130117234912.GA14936@sigill.intra.peff.net>
References: <201301161749.r0GHnGV6007806@smtpb02.one-mail.on.ca>
 <20130116220615.48c159546bccfa5b9cd9028e@domain007.com>
 <20130116182156.GB4426@sigill.intra.peff.net>
 <20130116233744.7d0775eaec98ce154a9de180@domain007.com>
 <0630A778-9AC8-4023-889C-4FC58ABAB683@gmail.com>
 <alpine.DEB.2.02.1301161459060.21503@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephen Smith <ishchis2@gmail.com>,
	Konstantin Khomoutov <kostix+git@007spb.ru>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Lang, David" <David.Lang@uhn.ca>
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Fri Jan 18 00:49:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvzDG-0001YY-0k
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 00:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587Ab3AQXtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 18:49:17 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36718 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753176Ab3AQXtR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 18:49:17 -0500
Received: (qmail 25598 invoked by uid 107); 17 Jan 2013 23:50:34 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (207.86.76.198)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 17 Jan 2013 18:50:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Jan 2013 15:49:13 -0800
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1301161459060.21503@nftneq.ynat.uz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213891>

On Wed, Jan 16, 2013 at 03:00:41PM -0800, David Lang wrote:

> >>This one [1] for instance.  I also recall seing people having other
> >>"mystical" problems with setups like this so I somehow developed an idea
> >>than having a repository on a networked drive is asking for troubles.
> >>Of course, if there are happy users of such setups, I would be glad to
> >>hear as my precautions might well be unfounded for the recent versions
> >>of Git.
> >>
> >>1. http://code.google.com/p/msysgit/issues/detail?id=130
> >
> >A group I was with used a master repository on a windows share for quite some time without a database corruption being seen.   --
> 
> I think the risk is that if you have multiple people doing actions on
> the shared filesystem you can run into trouble.
> 
> As long as only one copy of git is ever running against the
> repository, I don't see any reason for there to be a problem.

That should not be an issue. Git on a server has to deal with multiple
independent receive-pack's running to accept several simultaneous
pushes. They coordinate through the use of file locks. Having multiple
machines pushing over a shared filesystem should work the same, as long
as the filesystem support atomic creation of files with O_EXCL.

There may be other subtle issues lurking (e.g., the Windows issue that
Konstantin mentioned), but as far as I know, it _should_ work in
general.

-Peff
