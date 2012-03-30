From: Jeff King <peff@peff.net>
Subject: Re: Is the "text" attribute meant *only* to specify end-of-line
 normalization behavior, or does it have broader implications?
Date: Fri, 30 Mar 2012 03:25:46 -0400
Message-ID: <20120330072546.GC30656@sigill.intra.peff.net>
References: <CANSc5vG0o_eAn7X39XhCzUoN4ab52pGCP+PvzOQCyTV31R8LGg@mail.gmail.com>
 <4F7555BC.1000804@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris Harris <ryguasu@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 30 09:26:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDWDu-0003sl-Ni
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 09:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757545Ab2C3H0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 03:26:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40971
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757512Ab2C3HZs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 03:25:48 -0400
Received: (qmail 12181 invoked by uid 107); 30 Mar 2012 07:25:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Mar 2012 03:25:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2012 03:25:46 -0400
Content-Disposition: inline
In-Reply-To: <4F7555BC.1000804@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194335>

On Fri, Mar 30, 2012 at 08:42:04AM +0200, Johannes Sixt wrote:

> Am 3/30/2012 4:19, schrieb Chris Harris:
> > I'm starting a new repository for a Windows-only project where I don't
> > think I want git to do any end-of-line normalization on my text files.
> > (I'm totally happy to have CRLFs both in the repo and in all the
> > working copies.)
> 
> The question is rather: Are you happy if someone commits a file that does
> *not* have CRLF, but only LF?
> 
> Because if you don't care, you are better off setting no attributes and no
> core.autocrlf and no core.eol at all. The git will take the file
> unmodified. If someone's editor changes the eol style of a file, it will
> be noticed because the diff will show that the entire file has changed.
> Your team mates should better have enough discipline not to ignore such a
> hint that something's gone awry, of course.

I think it may be slightly more complex than that. He may be OK with
"git does nothing" and assuming everybody's editor does the sane thing.
But he may _not_ be OK with a stray core.autocrlf setting in a project
member's git config normalizing all line endings whenever they touch a
file. Setting "-text" prevents the latter.

> (I didn't answer the question in the subject of your message, and I can't;
> I don't use the text attribute nor eol normalization, even though I work
> on Windows quite a lot.)

I don't use them either.

However, I find the behavior of "Git Extensions" to be questionable. I
can see the rationale for thinking that "-text" means more than just
handling line-endings, but I think "-diff" is probably a better choice
for seeing if something is binary (or even checking the "binary" macro).
Those are what git uses itself.

Perhaps it was a mistake to call it "text", as it invites this sort of
confusion.

-Peff

PS I think one could potentially work around the whole issue by setting
   "-crlf", which git treats equivalently to "-text" these days (and
   hopefully isn't also checked by Git Extensions).
