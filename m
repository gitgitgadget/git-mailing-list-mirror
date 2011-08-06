From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/40] test whitespace - perform trivial whitespace clean
 ups of test scripts.
Date: Sat, 6 Aug 2011 03:20:29 -0600
Message-ID: <20110806092029.GA7645@sigill.intra.peff.net>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 06 11:20:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qpd3e-0002PG-53
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 11:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883Ab1HFJUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 05:20:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37615
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752482Ab1HFJUd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 05:20:33 -0400
Received: (qmail 5322 invoked by uid 107); 6 Aug 2011 09:21:07 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 06 Aug 2011 05:21:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Aug 2011 03:20:29 -0600
Content-Disposition: inline
In-Reply-To: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178874>

On Sat, Aug 06, 2011 at 06:41:59PM +1000, Jon Seymour wrote:

> The series applies cleanly to both master and pu.
> 
> The first patch contains a script, t/test-cleaner.sh, that can
> automate whitespace cleanup of tests.

Hmm. Can't we do something similar using git itself, and clean up all
sorts of whitespace errors?

I tried:

  rm t/t1006-cat-file.sh
  git diff -R | git apply --whitespace=fix

and ended up with the same blob as your script.

In theory you could do the whole tree:

  git ls-files -z | xargs -0 rm
  git diff -R --binary | git apply --whitespace=fix

though it reports 604 whitespace errors, but only 489 lines fixed. And
t1006 is not among the modified files. So I wonder if this is a bug in
git-apply, or am I missing something.

-Peff
