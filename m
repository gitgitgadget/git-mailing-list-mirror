From: Jeff King <peff@peff.net>
Subject: Re: I lost my commit signature
Date: Wed, 15 Jun 2016 00:34:50 -0400
Message-ID: <20160615043450.GA3975@sigill.intra.peff.net>
References: <CAGrdoOrrpc7OiU74fa-qpjLNxOtm4upAOAfWPG6VbWUjyE0C2Q@mail.gmail.com>
 <20160614075824.GB12563@sigill.intra.peff.net>
 <CAGrdoOp=dDkiTr+Sb-uZWx66b4hoZCYAiRjfgYqoE8H4-kXJvg@mail.gmail.com>
 <20160614081854.GA13457@sigill.intra.peff.net>
 <CAGrdoOqfcacG488u-MA7UiapgvJEGNX2QaRq8BMmycEWg-BGWg@mail.gmail.com>
 <20160614094121.GA13971@sigill.intra.peff.net>
 <e129da8e-4e1d-c535-ca62-d2a4c2e23799@drmicha.warpmail.net>
 <CAGrdoOoxphU0tRjV22yduXrhmOSyCc_zVnhuO9fFA6UPRd9WiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: ZhenTian <loooseleaves@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 06:34:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bD2XY-0007D7-NR
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 06:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbcFOEex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 00:34:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:55026 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750849AbcFOEex (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 00:34:53 -0400
Received: (qmail 32677 invoked by uid 102); 15 Jun 2016 04:34:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Jun 2016 00:34:53 -0400
Received: (qmail 3078 invoked by uid 107); 15 Jun 2016 04:35:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Jun 2016 00:35:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jun 2016 00:34:50 -0400
Content-Disposition: inline
In-Reply-To: <CAGrdoOoxphU0tRjV22yduXrhmOSyCc_zVnhuO9fFA6UPRd9WiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297354>

On Wed, Jun 15, 2016 at 12:27:15PM +0800, ZhenTian wrote:

> I got two more lines from gpg -v during commit with -S:
> ```
> gpg: writing to stdout
> gpg: RSA/SHA1 signature from: "2EF2AD6E Tian Zhen <tianzhen@honovation.com>"
> ```
> 
> after I commit, I push it to remote, but someone had pushed before to
> master branch, so I pull on master branch(`git pull --rebase`), then I
> check my commit via `git log --show-signature`, there is no signature
> in it, so I commit it with --ament and -S again, the signature is come
> back.
> 
> I haven't check signature before push, because I have checked four
> commits before, every commit is fine.
> 
> I don't know whether the `git pull` influenced signature or not.

Ah, so the problem is probably that you had a signature _initially_, but
that it did not survive the rebase. Which makes sense, as rebase would
need to re-sign.  It does not by default, but you can tell it to do so
with "-S". Or you can set `commit.gpgsign`, which should sign in both
cases.

-Peff
