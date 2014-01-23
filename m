From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] setup_pager: set MORE=R
Date: Wed, 22 Jan 2014 21:14:07 -0500
Message-ID: <20140123021407.GG17254@sigill.intra.peff.net>
References: <20140117041430.GB19551@sigill.intra.peff.net>
 <20140117042153.GB23443@sigill.intra.peff.net>
 <398F146D-72F1-44CD-B205-729665FD8765@gmail.com>
 <20140121053026.GC5878@sigill.intra.peff.net>
 <5B91161D-7B06-4C80-9554-89F379C4E2A6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Yuri <yuri@rawbw.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 03:14:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W69o6-0000Rz-Pf
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 03:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779AbaAWCOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 21:14:10 -0500
Received: from cloud.peff.net ([50.56.180.127]:37280 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752394AbaAWCOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 21:14:09 -0500
Received: (qmail 8219 invoked by uid 102); 23 Jan 2014 02:14:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 22 Jan 2014 20:14:09 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Jan 2014 21:14:07 -0500
Content-Disposition: inline
In-Reply-To: <5B91161D-7B06-4C80-9554-89F379C4E2A6@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240896>

On Tue, Jan 21, 2014 at 12:42:58AM -0800, Kyle J. McKay wrote:

> This attempts to show colors but doesn't work properly:
> 
>   LESS=-+R git -c color.ui=auto -c color.pager=true log --oneline --graph
> 
> but this does
> 
>   LESS=-R git -c color.ui=auto -c color.pager=true log --oneline --graph
> 
> so yeah, just checking for 'R' in $LESS is only approximate.  :)
> Also -r is good enough to show colors too...

Ugh, yeah. I think LESS=+R would also break. Doing it right would
involve parsing less's option format, including "-", "+", and "-+". It's
not _that_ much code, but it feels awfully wrong to be so intimate with
a subprogram that we do not control.

-Peff
