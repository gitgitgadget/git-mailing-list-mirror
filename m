From: Jeff King <peff@peff.net>
Subject: Re: Can I use git protocol to push change to remote repo?
Date: Tue, 16 Dec 2008 02:38:35 -0500
Message-ID: <20081216073835.GA2468@coredump.intra.peff.net>
References: <856bfe0e0812152318h1375401fx944834ad6410835d@mail.gmail.com> <856bfe0e0812152322i3a7fa376h8a35466b7abf82a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Emily Ren <lingyan.ren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 08:41:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCUY8-00012W-N6
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 08:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756876AbYLPHij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 02:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754930AbYLPHij
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 02:38:39 -0500
Received: from peff.net ([208.65.91.99]:4941 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756858AbYLPHii (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 02:38:38 -0500
Received: (qmail 11534 invoked by uid 111); 16 Dec 2008 07:38:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 16 Dec 2008 02:38:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Dec 2008 02:38:35 -0500
Content-Disposition: inline
In-Reply-To: <856bfe0e0812152322i3a7fa376h8a35466b7abf82a5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103255>

On Tue, Dec 16, 2008 at 03:22:17PM +0800, Emily Ren wrote:

> I can clone a remote repo with git protocol, but I can't push my
> branch to origin repo with git protocol. If I use ssh protocol, I can
> push sccuessfully. I'm confused, can someone give me a guide on this?
> Can I use git protocol to push my branch to remote repo? If yes, how
> can I do ? Thank you for your help in advance !

Yes, git-daemon does not support pushing by default, since it doesn't do
any authentication of the pushing users. The recommended practice is to
push over ssh, which uses the exact same protocol, but is tunneled over
ssh, so the user is authenticated and the incoming data has an integrity
check (note that pulling by ssh is also the same protocol as pulling via
git://, except of course that it is also tunneled over ssh; this means
that if you are pushing and pulling, you can just set your remote to
talk to the ssh version).

If you _really_ want totally anonymous, unsecured pushing to your repo
(e.g., because you are on a restricted LAN and everybody is trusted),
you can enable the receive-pack service. See the git-daemon
documentation for details.

-Peff
