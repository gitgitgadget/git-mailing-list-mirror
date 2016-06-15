From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4212: handle systems with post-apocalyptic gmtime
Date: Wed, 26 Mar 2014 16:38:30 -0400
Message-ID: <20140326203830.GA16332@sigill.intra.peff.net>
References: <20140224073348.GA20221@sigill.intra.peff.net>
 <20140224074905.GE9969@sigill.intra.peff.net>
 <20140326110559.GA32625@hashpling.org>
 <20140326182103.GB7087@sigill.intra.peff.net>
 <20140326185153.GA12912@sigill.intra.peff.net>
 <xmqqr45oixa6.fsf@gitster.dls.corp.google.com>
 <20140326192536.GA13989@sigill.intra.peff.net>
 <20140326193359.GA14105@sigill.intra.peff.net>
 <20140326194043.GB14105@sigill.intra.peff.net>
 <20140326203618.GA6991@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <cbailey32@bloomberg.net>
X-From: git-owner@vger.kernel.org Wed Mar 26 21:38:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSuar-000618-Rd
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 21:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195AbaCZUic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 16:38:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:47921 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751683AbaCZUic (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 16:38:32 -0400
Received: (qmail 22500 invoked by uid 102); 26 Mar 2014 20:38:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Mar 2014 15:38:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2014 16:38:30 -0400
Content-Disposition: inline
In-Reply-To: <20140326203618.GA6991@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245224>

On Wed, Mar 26, 2014 at 08:36:18PM +0000, Charles Bailey wrote:

> On Wed, Mar 26, 2014 at 03:40:43PM -0400, Jeff King wrote:
> > On Wed, Mar 26, 2014 at 03:33:59PM -0400, Jeff King wrote:
> > 
> > > That being said, is the AIX value actually right? I did not look closely
> > > at first, but just assumed that it was vaguely right. But:
> > > 
> > >   999999999999999999 / (86400 * 365)
> > > 
> > > is something like 31 billion years in the future, not 160 million.
> > > A real date calculation will have a few tweaks (leap years, etc), but
> > > that is orders of magnitude off.
> > 
> > Assuming my math is right, then here is the most sensible patch, IMHO.
> > 
> 
> Perhaps hold onto this one for a little while longer. Splitting things
> out from the test is giving me some inconsistent results, there may be
> something else going wrong in our environment here.

By the way, can you confirm that this is a 64-bit system? On a 32-bit
system, we should be triggering different code paths (we fail at the
strtoul level). Those should be checked by the previous tests, but I'd
like to make sure.

-Peff
