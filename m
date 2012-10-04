From: Jeff King <peff@peff.net>
Subject: Re: git pull takes ~8 seconds on up-to-date Linux git tree
Date: Thu, 4 Oct 2012 14:43:14 -0400
Message-ID: <20121004184314.GA15389@sigill.intra.peff.net>
References: <20121004141454.GA246@x4>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>
X-From: git-owner@vger.kernel.org Fri Oct 05 01:09:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtft-00033L-So
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816Ab2JDSnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 14:43:17 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40886 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753783Ab2JDSnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 14:43:16 -0400
Received: (qmail 23174 invoked by uid 107); 4 Oct 2012 18:43:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Oct 2012 14:43:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Oct 2012 14:43:14 -0400
Content-Disposition: inline
In-Reply-To: <20121004141454.GA246@x4>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207046>

On Thu, Oct 04, 2012 at 04:14:54PM +0200, Markus Trippelsdorf wrote:

> with current trunk I get the following on an up-to-date Linux tree:
> 
> markus@x4 linux % time git pull
> Already up-to-date.
> git pull  7.84s user 0.26s system 92% cpu 8.743 total
> 
> git version 1.7.12 is much quicker:
> 
> markus@x4 linux % time git pull
> Already up-to-date.
> git pull  0.10s user 0.02s system 16% cpu 0.740 total

Yikes. I can easily reproduce here. Bisecting between master and
v1.7.12 gives a curious result: the slowdown first occurs with the merge
commit 34f5130 (Merge branch 'jc/merge-bases', 2012-09-11). But neither
of its parents is slow. I don't see anything obviously suspect in the
merge, though.

-Peff
