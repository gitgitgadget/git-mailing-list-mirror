From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Preallocate hash tables when the number of inserts are
 known in advance
Date: Sun, 17 Mar 2013 04:51:07 -0400
Message-ID: <20130317085107.GB934@sigill.intra.peff.net>
References: <1363490886-29729-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 09:51:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH9Jn-0000hI-Ve
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 09:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756221Ab3CQIvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 04:51:23 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54212 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756139Ab3CQIvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 04:51:09 -0400
Received: (qmail 8021 invoked by uid 107); 17 Mar 2013 08:52:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Mar 2013 04:52:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Mar 2013 04:51:07 -0400
Content-Disposition: inline
In-Reply-To: <1363490886-29729-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218354>

On Sun, Mar 17, 2013 at 10:28:06AM +0700, Nguyen Thai Ngoc Duy wrote:

> This avoids unnecessary re-allocations and reinsertions. On webkit.git
> (i.e. about 182k inserts to the name hash table), this reduces about
> 100ms out of 3s user time.

Good idea.

I had a similar thought when analyzing the hashing behavior of
pack-objects' "Counting objects..." phase, but it had even less impact
there. The insertions are just drowned out by the number of lookups in
that case.

-Peff
