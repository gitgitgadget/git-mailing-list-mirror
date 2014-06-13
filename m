From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] verify-commit: scriptable commit signature
 verification
Date: Fri, 13 Jun 2014 04:02:29 -0400
Message-ID: <20140613080229.GJ7908@sigill.intra.peff.net>
References: <cover.1402063795.git.git@drmicha.warpmail.net>
 <cc5fd1d554e0357dfb514e3f9ad100d98c16d4d5.1402063796.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 10:02:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvMRa-0007xh-OH
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 10:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbaFMICd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 04:02:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:43268 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750852AbaFMICb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 04:02:31 -0400
Received: (qmail 11151 invoked by uid 102); 13 Jun 2014 08:02:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jun 2014 03:02:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2014 04:02:29 -0400
Content-Disposition: inline
In-Reply-To: <cc5fd1d554e0357dfb514e3f9ad100d98c16d4d5.1402063796.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251533>

On Fri, Jun 06, 2014 at 04:15:28PM +0200, Michael J Gruber wrote:

> Commit signatures can be verified using "git show -s --show-signature"
> or the "%G?" pretty format and parsing the output, which is well suited
> for user inspection, but not for scripting.
> 
> Provide a command "verify-commit" which is analogous to "verify-tag": It
> returns 0 for good signatures and non-zero otherwise, has the gpg output
> on stderr and (optionally) the commit object on stdout, sans the
> signature, just like "verify-tag" does.
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

I think the general direction of this series is reasonable.

Did you give any thought to just having a "git verify" command, instead
of separate tag/verify commands?

Another thought, that may be orthogonal to your series: what does it
mean to verify a commit? We check for _some_ signature from a key that
is in your keyring. But we do not check whether the signature matches
the committer field (or for tags, the tagger field). You have to parse
the gpg output, run "git cat-file", and then correlate the two. Should
there be an option to have git check that one of the signed uids from
gpg matches the commit's committer?

-Peff
