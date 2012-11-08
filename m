From: Jeff King <peff@peff.net>
Subject: Re: Long clone time after "done."
Date: Thu, 8 Nov 2012 15:33:32 -0500
Message-ID: <20121108203332.GQ15560@sigill.intra.peff.net>
References: <CAMJd5AQBbnFqT5xrFuPOEsJevwDE=jUgBVFZ5KqTZk5zv5+NOw@mail.gmail.com>
 <CAMJd5ASL1UPfzUmfXqACuYuGhXQjJLqbsjq7dfpRpF4K-hZFtA@mail.gmail.com>
 <20121108155607.GD15560@sigill.intra.peff.net>
 <CAMJd5AQ24u11BH6rMAHvR95N4ys6KHfEQKD1uLzr+=TDgN_69Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Uri Moszkowicz <uri@4refs.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 21:33:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWYnO-0001te-9C
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 21:33:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756872Ab2KHUdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 15:33:37 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36688 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756624Ab2KHUdg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 15:33:36 -0500
Received: (qmail 32523 invoked by uid 107); 8 Nov 2012 20:34:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Nov 2012 15:34:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2012 15:33:32 -0500
Content-Disposition: inline
In-Reply-To: <CAMJd5AQ24u11BH6rMAHvR95N4ys6KHfEQKD1uLzr+=TDgN_69Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209189>

On Thu, Nov 08, 2012 at 11:20:29AM -0600, Uri Moszkowicz wrote:

> I tried the patch but it doesn't appear to have helped :( Clone time
> with it was ~32m.

That sounds ridiculously long.

> Do you all by any chance have a tool to obfuscate a repository?
> Probably I still wouldn't be permitted to distribute it but might make
> the option slightly more palatable. Anything else that I can do to
> help debug this problem?

I don't have anything already written. What platform are you on? If it's
Linux, can you try using "perf" to record where the time is going?

How many refs do you have? What does:

  echo "heads: $(git for-each-ref refs/heads | wc -l)"
  echo " tags: $(git for-each-ref refs/tags | wc -l)"

report? How long does it take to look up a tag, like:

  time git cat-file tag refs/tags/some-tag

?

-Peff
