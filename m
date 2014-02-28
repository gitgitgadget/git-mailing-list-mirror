From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t3200-branch: test setting branch as own upstream
Date: Fri, 28 Feb 2014 08:03:41 -0500
Message-ID: <20140228130340.GB23448@sigill.intra.peff.net>
References: <1393556659-32717-1-git-send-email-modocache@gmail.com>
 <20140228053703.GA32556@sigill.intra.peff.net>
 <531032DD.9000904@viscovery.net>
 <20140228071401.GA1229@sigill.intra.peff.net>
 <20140228072606.GA622@sigill.intra.peff.net>
 <CAN7MxmXOvkrWPDEUH_Bqz5RVZUS7kuWkwi9kWmdwuwySszd=YA@mail.gmail.com>
 <20140228083718.GA11480@sigill.intra.peff.net>
 <CAN7MxmUUoz-HGFiTfgpvLpkXhvjBn_dYje7unoHE-Y=k3A0aqg@mail.gmail.com>
 <20140228105929.GA18960@sigill.intra.peff.net>
 <CAN7MxmVxYhF1VXWZNAXyfF8iBNQaqqwoyjmDAP_9_bc5NUUU6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 14:03:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJN6R-0005Cx-Ls
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 14:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbaB1NDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 08:03:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:58742 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751650AbaB1NDm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 08:03:42 -0500
Received: (qmail 2678 invoked by uid 102); 28 Feb 2014 13:03:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Feb 2014 07:03:42 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Feb 2014 08:03:41 -0500
Content-Disposition: inline
In-Reply-To: <CAN7MxmVxYhF1VXWZNAXyfF8iBNQaqqwoyjmDAP_9_bc5NUUU6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242954>

On Fri, Feb 28, 2014 at 08:16:13PM +0900, Brian Gesiak wrote:

> > I just don't want to regress somebody else's workflow due
> > to my lack of imagination.
> 
> This makes a lot of sense to me, although as-is the function emits a
> warning and returns immediately (although with a successful status
> code), so I'm also stumped as to what kind of workflow this would be
> included in.

I'm cc-ing Matthieu, who wrote 85e2233, which introduces the check. Its
commit message says:

  branch: warn and refuse to set a branch as a tracking branch of
  itself.

  Previous patch allows commands like "git branch --set-upstream foo
  foo", which doesn't make much sense. Warn the user and don't change
  the configuration in this case. Don't die to let the caller finish its
  job in such case.

For those just joining us, we are focused on the final statement, and
deciding whether we should die() in this case. But I am not clear what
job it would want to be finishing (creating the branch, I guess, but you
cannot be doing anything useful, since by definition the branch already
exists and you are not changing its tip). There wasn't any relevant
discussion on the list[1]. Matthieu, can you remember anything else that
led to that decision?

> In any case, if the jury's out on this one, I suppose the two patches
> I submitted are good to merge? Part of me thinks the bump from warning
> to error belongs in its own patch anyway.

Yeah, it should definitely be a separate patch on top.

-Peff

[1] Threads are:

      http://thread.gmane.org/gmane.comp.version-control.git/137297/focus=137299

    and

      http://thread.gmane.org/gmane.comp.version-control.git/137401/focus=137403

    but the discussion focused on the first part of the series.
