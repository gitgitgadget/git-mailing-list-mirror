From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add commit.infodisplay option to give message editor
 empty file
Date: Sat, 5 Dec 2009 11:28:27 -0500
Message-ID: <20091205162827.GA9584@sigill.intra.peff.net>
References: <1259967879-65517-1-git-send-email-jh@jameshoward.us>
 <7vpr6t6fnz.fsf@alter.siamese.dyndns.org>
 <20091205154753.GA3717@thermopylae.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "James P. Howard, II" <jh@jameshoward.us>
X-From: git-owner@vger.kernel.org Sat Dec 05 17:28:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGxUv-0003ye-AX
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 17:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757134AbZLEQ21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 11:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757126AbZLEQ20
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 11:28:26 -0500
Received: from peff.net ([208.65.91.99]:36268 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757116AbZLEQ2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 11:28:25 -0500
Received: (qmail 25436 invoked by uid 107); 5 Dec 2009 16:32:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 05 Dec 2009 11:32:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Dec 2009 11:28:27 -0500
Content-Disposition: inline
In-Reply-To: <20091205154753.GA3717@thermopylae.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134609>

On Sat, Dec 05, 2009 at 10:47:53AM -0500, James P. Howard, II wrote:

> >  - While the amount of change necessary for this change doesn't look too
> >    bad, is it really worth it?  What is wrong with "1,$p" while using ed
> >    as your editor?
> 
> I tried a few variants of this, and shell script wrappers for ex (and
> gate, which is a specizalized text editor that actually works kind of
> well for commit message editing), and it worked fairly well.
> 
> The real motivation is that this feature ditches all assumptions about
> the capabilities of the text editor.  I am not sure where that leads
> yet, but I'd rather make it possible.

Is your problem that your editor doesn't show the template content and
you want to see it, or is it that your editor isn't pleasant to use when
the buffer is pre-filled with the template?

If the former, it seems like just dumping it to stdout isn't all that
satisfying, either. What happens when your editing causes the
information to scroll off the screen and you want to see it again?
Couldn't you get the same thing just by doing "git status; git commit"?

If the latter, I think we would be better served by an option to simply
turn off the template. Then that is also helpful for the case of people
using decent editors, but who don't want to waste the CPU time on
generating the template information (which can be substantial for things
like media repositories).

I suspect your answer will be that it is some of both, but this just
really feels like we are putting hacks into git because of one
featureless editor. Hacks like that would be better suited (IMHO) to a
wrapper script for the editor.

-Peff
