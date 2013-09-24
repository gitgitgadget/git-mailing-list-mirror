From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] build: add default aliases
Date: Tue, 24 Sep 2013 01:37:12 -0400
Message-ID: <20130924053712.GA6114@sigill.intra.peff.net>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
 <20130924045325.GD2766@sigill.intra.peff.net>
 <CAMP44s1tirA5w91L2YomaduZVkqL3=n1j79eoueB6XeGuyY3Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 07:37:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOLJJ-00063i-WD
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 07:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730Ab3IXFhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 01:37:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:53173 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706Ab3IXFhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 01:37:16 -0400
Received: (qmail 552 invoked by uid 102); 24 Sep 2013 05:37:15 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Sep 2013 00:37:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Sep 2013 01:37:12 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s1tirA5w91L2YomaduZVkqL3=n1j79eoueB6XeGuyY3Mw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235266>

On Tue, Sep 24, 2013 at 12:32:46AM -0500, Felipe Contreras wrote:

> > You are making things more consistent for people who already define
> > those aliases in the same way (they are available everywhere, even if
> > they have not moved their config to a new installation), but less so for
> > people who define them differently. Rather than get an obvious:
> >
> >   git: 'co' is not a git command. See 'git --help'.
> >
> > the result will be subtly different (especially so in the case of
> > "commit" versus "commit -a").
> 
> Before:
> 
> # machine A: git ci
> git: 'ca' is not a git command. See 'git --help'.
> 
> # machine B: git ci
> commits
> 
> After:
> 
> # machine A: git ci
> no changes added to commit (use "git add" and/or "git commit -a")
> 
> # machine B: git ci
> commits

That is the output if there are no files to commit. What about while
resolving a merge, or after using "git add" on a path? In that case we
create a commit, but it is subtly different than what the user intended.

I think for the merge case, it is probably OK, as the "surprise" should
always go in the safe direction (user expects "commit -a", gets
"commit", and commit balks). But the other omits intended files from the
commit.

-Peff
