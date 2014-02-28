From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t3200-branch: test setting branch as own upstream
Date: Fri, 28 Feb 2014 05:59:29 -0500
Message-ID: <20140228105929.GA18960@sigill.intra.peff.net>
References: <1393556659-32717-1-git-send-email-modocache@gmail.com>
 <20140228053703.GA32556@sigill.intra.peff.net>
 <531032DD.9000904@viscovery.net>
 <20140228071401.GA1229@sigill.intra.peff.net>
 <20140228072606.GA622@sigill.intra.peff.net>
 <CAN7MxmXOvkrWPDEUH_Bqz5RVZUS7kuWkwi9kWmdwuwySszd=YA@mail.gmail.com>
 <20140228083718.GA11480@sigill.intra.peff.net>
 <CAN7MxmUUoz-HGFiTfgpvLpkXhvjBn_dYje7unoHE-Y=k3A0aqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 11:59:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJLAU-0001gr-Qh
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 11:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbaB1K7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 05:59:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:58680 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751296AbaB1K7d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 05:59:33 -0500
Received: (qmail 26756 invoked by uid 102); 28 Feb 2014 10:59:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Feb 2014 04:59:33 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Feb 2014 05:59:29 -0500
Content-Disposition: inline
In-Reply-To: <CAN7MxmUUoz-HGFiTfgpvLpkXhvjBn_dYje7unoHE-Y=k3A0aqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242940>

On Fri, Feb 28, 2014 at 07:44:10PM +0900, Brian Gesiak wrote:

> > I notice that the warning comes from install_branch_config, which gets
> > used both for "branch -u", but also in the "side effect" case I
> > mentioned above. Is it possible to trigger this as part of such a case?
> > I think maybe "git branch -f --track foo foo" would do it. If so, we
> > should perhaps include a test that it does not break if we upgrade the
> > "-u" case to an error.
> 
> Do you mean that install_branch_config should continue to emit a
> warning in the "side effect" case? I'm not sure I agree--how is "git
> branch -f --track foo foo" less erroneous than "git branch -u foo
> refs/heads/foo"? Perhaps I'm missing some insight on how "--track" is
> used.

I'd be more worried about triggering it via the config. E.g.:

  git config branch.autosetupmerge always
  git branch -f foo foo

Should the second command die? I admit I'm having a hard time coming up
with a feasible reason why anyone would do "branch -f foo foo" in the
first place. I just don't want to regress somebody else's workflow due
to my lack of imagination.

-Peff
