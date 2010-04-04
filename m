From: Jeff King <peff@peff.net>
Subject: Re: 'git gc --aggressive' effectively unusable
Date: Sun, 4 Apr 2010 17:49:44 -0400
Message-ID: <20100404214944.GA15104@coredump.intra.peff.net>
References: <201004030005.35737.elendil@planet.nl>
 <p2gb4087cc51004031433xc57e52bbq733d1d3c5f37f238@mail.gmail.com>
 <201004040123.06877.elendil@planet.nl>
 <87oci0m5v4.fsf@catnip.gol.com>
 <87zl1js248.fsf@troilus.org>
 <20100404203850.GA8798@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Miles Bader <miles@gnu.org>, Michael Witten <mfwitten@gmail.com>,
	Frans Pop <elendil@planet.nl>, git@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
X-From: git-owner@vger.kernel.org Sun Apr 04 23:50:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyXiC-0002dG-QU
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 23:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955Ab0DDVuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 17:50:00 -0400
Received: from peff.net ([208.65.91.99]:33558 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918Ab0DDVt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 17:49:59 -0400
Received: (qmail 13634 invoked by uid 107); 4 Apr 2010 21:50:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 04 Apr 2010 17:50:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Apr 2010 17:49:45 -0400
Content-Disposition: inline
In-Reply-To: <20100404203850.GA8798@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143952>

On Sun, Apr 04, 2010 at 04:38:50PM -0400, Jeff King wrote:

> I packed Frans' sample kernel repo with "git gc --aggressive" last
> night. It did finish after about 9 hours. I didn't take memory usage
> measurements, but here's what time said:
> 
>   real    535m38.898s
>   user    216m46.437s
>   sys     0m24.186s
> 
> That's 3.6 hours of CPU time over almost 9 hours (on a dual-core
> machine). The non-agressive pack was about 680M, and the result was
> 480M. The machine has 2G of RAM, and not much else running. So I would
> really not expect there to be much disk I/O required, but clearly we
> were waiting quite a bit.
> 
> I'll try tweaking a few of the pack memory limits and try again.

Hmm, this may be relevant:

  http://thread.gmane.org/gmane.comp.version-control.git/67791/focus=94797

In my experiments, memory usage is increasing but valgrind doesn't
leaks. So perhaps it is fragmentation in the memory allocator.

-Peff
