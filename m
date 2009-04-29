From: Jeff King <peff@peff.net>
Subject: Re: error: Unable to append to
	.git/logs/refs/remotes/origin/master: Permission denied
Date: Wed, 29 Apr 2009 04:06:50 -0400
Message-ID: <20090429080650.GA25227@coredump.intra.peff.net>
References: <20090428073138.GA9094@elte.hu> <20090429032943.GB8826@coredump.intra.peff.net> <20090429040719.GA14912@coredump.intra.peff.net> <20090429073256.GB22129@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Apr 29 10:07:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz4or-0006Yo-AN
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 10:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757086AbZD2IG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 04:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753831AbZD2IG4
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 04:06:56 -0400
Received: from peff.net ([208.65.91.99]:44387 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757330AbZD2IGx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 04:06:53 -0400
Received: (qmail 3458 invoked by uid 107); 29 Apr 2009 08:07:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 29 Apr 2009 04:07:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Apr 2009 04:06:50 -0400
Content-Disposition: inline
In-Reply-To: <20090429073256.GB22129@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117865>

On Wed, Apr 29, 2009 at 09:32:56AM +0200, Ingo Molnar wrote:

> > So I think we would need to simulate the errno setting, like the 
> > patch below. That should generate the hint only when it would 
> > actually be useful.
> 
> it wasnt hard to figure out what's going on. So this was more of a 
> FYI, not really a bug report. Maybe if someone tries to pull into a 
> read-only repo the same could happen? My particular breakage (of a 
> single ref being root-owned - the rest was mingo owned) is atypical 
> enough to be ignored.

Actually, it is a little bit tough to get your breakage. A pure
read-only repo would error out much earlier (permission denied on
FETCH_HEAD or writing to object db). But if yours was just "accidentally
fetched once as root", then that doesn't seem too uncommon.

> If there's no easy/clean solution then please ignore my report.

I think the patch I posted isn't too bad. We'll see what others say.

-Peff
