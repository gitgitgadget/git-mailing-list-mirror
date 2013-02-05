From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Should "log --cc" imply "log --cc -p"?
Date: Tue, 5 Feb 2013 04:33:07 -0500
Message-ID: <20130205093307.GC24973@sigill.intra.peff.net>
References: <7vmwvl6lj9.fsf@alter.siamese.dyndns.org>
 <510F95D7.6010107@drmicha.warpmail.net>
 <7vfw1c3ujo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 10:33:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2euK-0001mP-S0
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 10:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511Ab3BEJdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 04:33:18 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33014 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507Ab3BEJdL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 04:33:11 -0500
Received: (qmail 27599 invoked by uid 107); 5 Feb 2013 09:34:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Feb 2013 04:34:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Feb 2013 04:33:07 -0500
Content-Disposition: inline
In-Reply-To: <7vfw1c3ujo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215473>

On Mon, Feb 04, 2013 at 08:36:43AM -0800, Junio C Hamano wrote:

> "git log/diff-files -U8" do not need "-p" to enable textual patches,
> for example.  It is "I already told you that I want 8-line context.
> For what else, other than showing textual diff, do you think I told
> you that for?" and replacing "8-line context" with various other
> options that affect patch generation will give us a variety of end
> user complaints that would tell us that C) is more intuitive to
> them.

Yeah, I'd agree with this. My feeling is that when there are two
options, A and B, and A is a no-op if B is not also specified, that it
makes sense for A to imply B. We do it in several places already (and I
just added some for "git branch --list" recently).

Is "--cc" a no-op when "-p" is not specified? Certainly "-c" is not, but
I do not think you are proposing that. At first glance, "--cc" is
nonsensical without "-p", but what about other xdiff callers? For
example, in:

  git log --cc --stat

the "--cc" is significant. So I don't think it is right for "--cc" to
always imply "-p". But if the rule kicked in only when no other format
had been specified, that might make sense.

-Peff
