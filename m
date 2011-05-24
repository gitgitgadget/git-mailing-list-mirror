From: Jeff King <peff@peff.net>
Subject: Re: commit a1f6baa5 (wrap long header lines) breaks my habit
Date: Tue, 24 May 2011 16:07:16 -0400
Message-ID: <20110524200716.GF584@sigill.intra.peff.net>
References: <20110524160253.GA7723@scotty.home>
 <7vboys83nh.fsf@alter.siamese.dyndns.org>
 <20110524164616.GB7723@scotty.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
X-From: git-owner@vger.kernel.org Tue May 24 22:07:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOxtG-0005U8-TZ
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 22:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755551Ab1EXUHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 16:07:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44319
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467Ab1EXUHS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 16:07:18 -0400
Received: (qmail 21273 invoked by uid 107); 24 May 2011 20:07:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 May 2011 16:07:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 May 2011 16:07:16 -0400
Content-Disposition: inline
In-Reply-To: <20110524164616.GB7723@scotty.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174339>

On Tue, May 24, 2011 at 06:46:16PM +0200, Stefan-W. Hahn wrote:

> Mail von Junio C Hamano, Tue, 24 May 2011 at 09:27:46 -0700:
> 
> > >    git format-patch -k --stdout a..b | git am -k -3
> > 
> > Why -k to am?
> 
> Just first "-k", and "git am -3". Wrong in mind here at home before my
> computer.

Then it should preserve your long subject line just fine, as mailsplit
(called by "am") will reassemble the folded line according to rfc822
header folding rules.

With "am -k", it does keep the fold. This is an artifact of the original
behavior, where the folds were literally included from a multi-line
subject. We should probably stop doing that now that we fold on length
(and should probably embed newlines via rfc2047 encoding in
format-patch, at least with "-k", so that you can losslessly move
multi-line subjects between the two if you always use "-k").

-Peff
