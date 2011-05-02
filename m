From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] specifying ranges: we did not mean to make ".." an
 empty set
Date: Mon, 2 May 2011 17:01:41 -0400
Message-ID: <20110502210141.GA15753@sigill.intra.peff.net>
References: <7vr58glxro.fsf@alter.siamese.dyndns.org>
 <20110502193321.GB10487@sigill.intra.peff.net>
 <7vhb9clu0n.fsf@alter.siamese.dyndns.org>
 <7v62pslt2k.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 23:01:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QH0FY-0004HO-GE
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 23:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754163Ab1EBVBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 17:01:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33399
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752913Ab1EBVBn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 17:01:43 -0400
Received: (qmail 8914 invoked by uid 107); 2 May 2011 21:03:26 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 May 2011 17:03:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 May 2011 17:01:41 -0400
Content-Disposition: inline
In-Reply-To: <7v62pslt2k.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172632>

On Mon, May 02, 2011 at 01:56:51PM -0700, Junio C Hamano wrote:

> Either end of revision range operator can be omitted to default to HEAD,
> as in "origin.." (what did I do since I forked) or "..origin" (what did
> they do since I forked).  But the current parser interprets ".."  as an
> empty range "HEAD..HEAD", and worse yet, because ".." does exist on the
> filesystem, we get this annoying output:
> 
>   $ cd Documentation/howto
>   $ git log .. ;# give me recent commits that touch Documentation/ area.
>   fatal: ambiguous argument '..': both revision and filename
>   Use '--' to separate filenames from revisions
> 
> Surely we could say "git log ../" or even "git log -- .." to disambiguate,
> but we shouldn't have to.
> 
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looks good to me.

Doing "..." is still allowed, but will never produce any useful results.
I don't know if it is worth disallowing it to catch errors. I am tempted
to say it should be magic for "@{u}...HEAD", but I think just "..." is
getting unreadably magical. "@{u}...HEAD" is already pretty concise and
is much more readable.

-Peff
