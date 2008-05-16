From: Jeff King <peff@peff.net>
Subject: Re: To page or not to page
Date: Fri, 16 May 2008 00:51:39 -0400
Message-ID: <20080516045139.GA10858@sigill.intra.peff.net>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org> <20080502054508.GA28506@sigill.intra.peff.net> <20080502060930.GA1079@sigill.intra.peff.net> <7vd4o5xm62.fsf@gitster.siamese.dyndns.org> <20080502125553.GB2923@sigill.intra.peff.net> <7v1w4ky3hh.fsf@gitster.siamese.dyndns.org> <20080506055128.GA26311@sigill.intra.peff.net> <20080516044238.GA6784@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 16 06:52:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwrvk-0001Gu-6k
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 06:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbYEPEvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 00:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbYEPEvl
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 00:51:41 -0400
Received: from peff.net ([208.65.91.99]:2580 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750935AbYEPEvl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 00:51:41 -0400
Received: (qmail 26594 invoked by uid 111); 16 May 2008 04:51:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 16 May 2008 00:51:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 May 2008 00:51:39 -0400
Content-Disposition: inline
In-Reply-To: <20080516044238.GA6784@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82257>

On Fri, May 16, 2008 at 12:42:38AM -0400, Jeff King wrote:

> So the logic in setup_git_env seems bogus, but should basically never be
> invoked because we do generally call setup_git_directory_gently before
> then. Either it should probably call setup_git_directory_gently (though
> I am afraid of what awful side effects that could have), or it should
> just barf, and people should do setup_git_directory beforehand (and I'm
> sure that will break something too).

Hrm. So there are lots of programs that actually _do_ end up needing
this lazy load of the git_dir, but it's just that we have
setup_git_directory'd ourselves into the top of the work tree by then.

So it would be nice if we could move that earlier so that the wrapper
could do useful things like look at the proper config. But I think that
opens a whole can of worms with running setup_git_directory twice, IIRC.

-Peff
