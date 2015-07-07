From: Jeff King <peff@peff.net>
Subject: Re: Git force push fails after a rejected push (unpack failed)?
Date: Tue, 7 Jul 2015 15:49:56 -0400
Message-ID: <20150707194956.GA13792@peff.net>
References: <DUB120-W5049F72955243F44BB2511F6920@phx.gbl>
 <20150707141305.GA629@peff.net>
 <DUB120-W36B78FEE6DC80BDCB05D7FF6920@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: X H <music_is_live_lg@hotmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 21:50:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCYsX-00017j-2a
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 21:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932914AbbGGTuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 15:50:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:57071 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932695AbbGGTt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 15:49:59 -0400
Received: (qmail 8542 invoked by uid 102); 7 Jul 2015 19:49:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jul 2015 14:49:59 -0500
Received: (qmail 12623 invoked by uid 107); 7 Jul 2015 19:50:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jul 2015 15:50:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jul 2015 15:49:56 -0400
Content-Disposition: inline
In-Reply-To: <DUB120-W36B78FEE6DC80BDCB05D7FF6920@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273596>

On Tue, Jul 07, 2015 at 09:31:25PM +0200, X H wrote:

> For the moment, I'm the only one pushing to the remote, always with
> the same user (second user is planned). I use git-for-windows which is
> based on MSYS2. I have mounted the network share with noacl option so
> permissions should be handled by the Windows share. I'm in a group
> which has read/write access. I have not configured
> core.sharedrepository, I don't think it is useful with noacl since
> unix group are not used in this case. The permission for the folder
> above the file with permission denied is rw, but this file is read
> only so if git try to modify it it won't work.

Ah, so this is not a push to a server, but to a share mounted on the
local box?

That is leaving my realm of expertise. I'm not sure if it could be a
misconfiguration in your share setup, or that git is trying to do
something that would work on a Unix machine, but not on a Windows share.
You might want to ask on the msysgit list:

  https://groups.google.com/forum/#!forum/msysgit

> Why does git try to write a file with the same name? If I amend a
> commit isn't the sha modified?

Yes, but remember that git stores all of the objects for all of the
commits. So for some reason your push is perhaps trying to send an
object that the other side already has. Usually this does not happen
(the receiver says "I already have these commits, do not bother sending
their objects"), but it's possible that you have an object that is not
referenced by any commit, or a similar situation. It's hard to say
without looking at the repository.

-Peff
