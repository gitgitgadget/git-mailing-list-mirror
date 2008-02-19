From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH(TIC)] push: annoy all users by deprecating the default
 semantics
Date: Tue, 19 Feb 2008 16:14:35 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802191610480.30505@racer.site>
References: <E7DE807861E8474E8AC3DC7AC2C75EE50542F2F1@34093-EVS2C1.exchange.rackspace.com> <20080219043353.GA23239@sigill.intra.peff.net> <76718490802190509k20225092o66853916f48e08b1@mail.gmail.com> <20080219150826.GA24499@sigill.intra.peff.net>
 <76718490802190718t5e70abb2x8f96fc7154576594@mail.gmail.com> <20080219152549.GC24499@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Jason Garber <jgarber@ionzoft.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 19 17:15:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRV7v-0003tP-SK
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 17:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757195AbYBSQOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 11:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757212AbYBSQOw
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 11:14:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:47095 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756146AbYBSQOv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 11:14:51 -0500
Received: (qmail invoked by alias); 19 Feb 2008 16:14:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 19 Feb 2008 17:14:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+pqaE1bFmpbabazYS4fvjBUl1hK4YdxRFcTcvj2D
	kIO5fCitee2kIk
X-X-Sender: gene099@racer.site
In-Reply-To: <20080219152549.GC24499@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74421>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	On Tue, 19 Feb 2008, Jeff King wrote:

	> On Tue, Feb 19, 2008 at 10:18:09AM -0500, Jay Soffian wrote:
	> > > > It seems like the default should be to push just the 
	> > > > current branch ... this would correspond to what a user of 
	> > > > git pull expects (even though the converse of git-push is 
	> > > > really git-fetch, for a new user, that might not be 
	> > > > entirely clear).
	> > >
	> > > I agree with you, but others do not
	> > 
	> > Sounds like an opportunity for a config option.
	> 
	> Again I agree, though I think there is some resistance to that 
	> (see the thread I mentioned). Junio's opinion seems to be "why 
	> can't they just use 'git push <remote> HEAD'?" (and he suggested 
	> a 'git push HEAD' shorthand syntax, as well).

	FWIW I would resist, just because that config option would change 
	the _semantics_ of a git program.

	Just think about the IRC channel.  "How do I update only HEAD?" --
	"Just say 'git push'" -- "No, that updates nothing" -- "Well, 
	works here" -- "But not here!" ... "Can _nobody_ help me?"

	Having inconsistent semantics is wrong, wrong, wrong.

	> But then, nobody has put forth a patch, so I think if you wanted
	> to argue it, the best way would be to do so (though I think it 
	> would be rejected, it would give those who wanted to try it 
	> something to play with).

	This is a tongue-in-cheek patch.  Just so that nobody can say that
	there were no patches.

 builtin-push.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index c8cb63e..7bcb141 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -134,6 +134,14 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		flags |= TRANSPORT_PUSH_ALL;
 	if (mirror)
 		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
+	if (!all && argc < 2)
+		warning("Pushing without branch names is deprecated.\n"
+			"Too many users just assumed what it should do\n"
+			"according to them, got burned, and blamed us,\n"
+			"the good git developers.\n\n"
+			"So everybody has to suffer now, and get used to\n"
+			"new semantics.\n\n"
+			"Thank you for your time.\n");
 
 	if (argc > 0) {
 		repo = argv[0];
