From: Jeff King <peff@peff.net>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Thu, 11 Apr 2013 14:14:39 -0400
Message-ID: <20130411181439.GA2820@sigill.intra.peff.net>
References: <1365572015.4658.51.camel@marge.simpson.net>
 <20130410135605.GB4694@odin.tremily.us>
 <1365651583.19620.8.camel@marge.simpson.net>
 <20130411054207.GE27795@sigill.intra.peff.net>
 <7vwqs9jd0t.fsf@alter.siamese.dyndns.org>
 <20130411172424.GC1255@sigill.intra.peff.net>
 <20130411181103.GJ27070@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Mike Galbraith <bitbucket@online.de>,
	"W. Trevor King" <wking@tremily.us>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 20:14:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQM1M-000181-V6
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 20:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688Ab3DKSOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 14:14:48 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40768 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504Ab3DKSOr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 14:14:47 -0400
Received: (qmail 17720 invoked by uid 107); 11 Apr 2013 18:16:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Apr 2013 14:16:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2013 14:14:39 -0400
Content-Disposition: inline
In-Reply-To: <20130411181103.GJ27070@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220904>

On Thu, Apr 11, 2013 at 11:11:03AM -0700, Jonathan Nieder wrote:

> > -- >8 --
> > Subject: [PATCH] daemon: set HOME when we switch to --user
> 
> Thanks for taking care of it.  For what it's worth,
> 
> Acked-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> I'm not sure whether to keep 96b9e0e (config: treat user and xdg
> config permission problem as errors) in the long run, BTW.  There have
> been multiple reports about dropping privileges and not being able to
> access the old HOME, and I'm not convinced any more that the
> predictability is worth the breakage for such people.  Though checking
> if $HOME is inaccessible and treating that case specially would be
> even worse...
> 
> Insights welcome.

I could go either way. I think 96b9e0e is the right thing to do
conceptually, but I kind of doubt it was affecting all that many people.
And though it's _possible_ for it to be a security problem, I find it
much more likely that the site admin tries to set some config, gets
annoyed when it doesn't work, and debugs it. So from a practical
perspective, 96b9e0e may be doing more harm than good, even though it's
the right thing.

-Peff
