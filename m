From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 08/23] ewah: compressed bitmap implementation
Date: Thu, 23 Jan 2014 15:13:45 -0500
Message-ID: <20140123201344.GA32580@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
 <20131221135953.GH21145@sigill.intra.peff.net>
 <20140123020536.GP18964@google.com>
 <20140123183320.GA22995@sigill.intra.peff.net>
 <20140123195206.GU18964@google.com>
 <20140123200311.GA31920@sigill.intra.peff.net>
 <20140123201223.GX18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 21:13:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6Qes-0005LV-Ga
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 21:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbaAWUNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 15:13:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:37723 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751167AbaAWUNq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 15:13:46 -0500
Received: (qmail 28593 invoked by uid 102); 23 Jan 2014 20:13:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jan 2014 14:13:46 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jan 2014 15:13:45 -0500
Content-Disposition: inline
In-Reply-To: <20140123201223.GX18964@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240942>

On Thu, Jan 23, 2014 at 12:12:23PM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> > On Thu, Jan 23, 2014 at 11:52:06AM -0800, Jonathan Nieder wrote:
> 
> >> My main worry about the patches is that they will probably run into
> >> an analagous problem to the one that v1.7.12-rc0~1^2~2
> [...]
> > I think this probably works in practice because align_ntohl is inlined,
> > and any sane compiler will never actually load the variable.
> 
> I don't think that's safe to rely on.  The example named above didn't
> pose any problems except on one platform.  All the relevant functions
> were static and easy to inline.  GCC just followed the standard
> literally and chose to break by reading one word at a time, just like
> in this case it could break e.g. by copying one word at a time in
> __builtin_memcpy (which seems perfectly reasonable to me ---
> optimization involves a lot of constraint solving, and if you can't
> trust your constraints then there's not much you can do).

I wasn't disagreeing with you. I was guessing at why it did not fail out
of the box when I tested it.  What do you think of the alternative I
posted?

-Peff
