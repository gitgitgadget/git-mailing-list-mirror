From: Jeff King <peff@peff.net>
Subject: Re: [cygwin] Re: Lack of case-sensitive filename handling with git
 1.7.9-1 for Cygwin 64-bit
Date: Fri, 16 Aug 2013 09:21:01 -0400
Message-ID: <20130816132101.GE20138@sigill.intra.peff.net>
References: <CAGZiy71u1Ci_2Uw6jgAw3-9gCgwVrS1ae2Bpz9HCbnj2+EZexA@mail.gmail.com>
 <20130816081743.GC2562@calimero.vinschen.de>
 <4D206B626EE941D28F6CB93E38293863@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: 'Git List' <git@vger.kernel.org>
To: Jason Pyeron <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Fri Aug 16 15:21:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAJyO-0007Ry-KT
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 15:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806Ab3HPNVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 09:21:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:56518 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754680Ab3HPNVF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 09:21:05 -0400
Received: (qmail 27771 invoked by uid 102); 16 Aug 2013 13:21:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 Aug 2013 08:21:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Aug 2013 09:21:01 -0400
Content-Disposition: inline
In-Reply-To: <4D206B626EE941D28F6CB93E38293863@black>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232427>

On Fri, Aug 16, 2013 at 07:54:57AM -0400, Jason Pyeron wrote:

> > The interesting thing here is, if you try this the other way 
> > around, you'll see the exact same effect.  If you created the 
> > above git repo with 64 bit git, everything works exactly as 
> > in the 32 bit version and the two files are correctly recognized.
> > 
> > I assume the format of the git database files depends on the 
> > architecture.  Therefore it's probably not advisable to use a 
> > git repo created under 32 bit git with a 64 bit git and vice versa.
> 
> Is this the best explanation for this?

If it is, that is a bug. There should be nothing architecture-dependent
in the index file.

In the test described, it would be worth double-checking that
core.ignorecase is set properly. Git will detect and set that option
when creating the repository based on a test of the filesystem. But it's
possible that there is some weirdness in the packaging or defaults of
the two builds.

It's also worth seeing if newer versions of git behave differently.
There were a lot of bugs in the case-insensitivity code that were fixed
in the late v1.7.x range. Though if I understand the test correctly, we
_shouldn't_ be using the case-insensitive code in the first place.

-Peff
