From: Jeff King <peff@peff.net>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Tue, 3 Aug 2010 08:48:31 -0400
Message-ID: <20100803124831.GB11608@coredump.intra.peff.net>
References: <i372v0$3np$1@dough.gmane.org>
 <m3hbjcptyr.fsf@localhost.localdomain>
 <4C57D997.5010003@drmicha.warpmail.net>
 <201008031202.53804.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	"Joel C. Salomon" <joelcsalomon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 14:48:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgGvD-0005Ik-5u
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 14:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756262Ab0HCMsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 08:48:37 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38167 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756062Ab0HCMsg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 08:48:36 -0400
Received: (qmail 12371 invoked by uid 111); 3 Aug 2010 12:48:36 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Tue, 03 Aug 2010 12:48:36 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Aug 2010 08:48:31 -0400
Content-Disposition: inline
In-Reply-To: <201008031202.53804.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152508>

On Tue, Aug 03, 2010 at 12:02:52PM +0200, Jakub Narebski wrote:

> > Hmm, sizeof(time_t) == 8 for my x86_64 Fedora, but committing ancient
> > times fails.
> 
> That's because git *porcelain* either does not use time_t consistently,
> or has some sanity checks that are good heuristic for ordinary use (like
> e.g. commit time not too far in past where git didn't even exists),
> or both.
> 
> It is not a problem on lowest level, i.e. repository format and plumbing.
> I was able to create a commit that had author time before Unix epoch 
> using plumbing:

I am not sure there isn't some unportability at the lowest level. We
freely interchange between time_t and unsigned long in the low-level
date code. It probably happens to work because casting the bits back and
forth between signed and unsigned types generally works, as long as you
end up with the type that you want. But it isn't necessarily portable,
and there can be subtle bugs. See, for example, my recent 9ba0f033.

-Peff
