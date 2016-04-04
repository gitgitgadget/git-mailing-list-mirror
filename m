From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/4] tag: use pgp_verify_function in tag -v call
Date: Mon, 4 Apr 2016 16:19:37 -0400
Message-ID: <20160404201937.GB4570@sigill.intra.peff.net>
References: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
 <1459638975-17705-5-git-send-email-santiago@nyu.edu>
 <20160403045600.GD1519@sigill.intra.peff.net>
 <20160404041203.GE28933@LykOS>
 <20160404133853.GB25404@sigill.intra.peff.net>
 <20160404182447.GA6773@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Mon Apr 04 22:19:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anAyP-0006Ji-Pr
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 22:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756070AbcDDUTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 16:19:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:43925 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754070AbcDDUTl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 16:19:41 -0400
Received: (qmail 31534 invoked by uid 102); 4 Apr 2016 20:19:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 Apr 2016 16:19:41 -0400
Received: (qmail 28362 invoked by uid 107); 4 Apr 2016 20:19:42 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 Apr 2016 16:19:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Apr 2016 16:19:37 -0400
Content-Disposition: inline
In-Reply-To: <20160404182447.GA6773@LykOS>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290720>

On Mon, Apr 04, 2016 at 02:24:48PM -0400, Santiago Torres wrote:

> > I think it can be part of this series, but doesn't have to be. As I
> > understand it, the current code is just handing the name to the `git
> > verify-tag` process, so if we continue to do so, that would be OK.
> 
> IIRC, the current code for git tag -v hands the hex-representation[1] of
> the sha1 to git verify-tag --- I believe that's related to the
> desamgibuation issue I've seen people discuss.  I think this behavior is
> lost unless we add this on top of the patch.

Oh, you're right. I didn't notice that. So yeah, we should make sure in
this series to hand the sha1 over to gpg_verify_tag().

> > Yes, though I'd generally advise against a function taking either a name or
> > a sha1, and ignoring the other option. That often leads to confusing
> > interfaces for the callers. Instead, perhaps just take the sha1, and let
> > the caller do the get_sha1() themselves. Or possibly provide two
> > functions, one of which is a convenience to translate the name to sha1
> > and then call the other.
> 
> I think the former sounds easier. I can replace the name argument and
> move the sha1-resolution code to in verify-tag. git tag -v already
> resolves the tagname to a sha1, so it is easier there.
> 
> Does this sound reasonable?

Yes, I think that is a good solution.

Thanks.

-Peff
