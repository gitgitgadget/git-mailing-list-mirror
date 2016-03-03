From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] index-pack: correct --keep[=<msg>]
Date: Thu, 3 Mar 2016 14:47:27 -0500
Message-ID: <20160303194727.GA26087@sigill.intra.peff.net>
References: <xmqq1t7r2x21.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 20:47:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abZDk-0008N1-6h
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 20:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439AbcCCTrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 14:47:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:54362 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754660AbcCCTra (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 14:47:30 -0500
Received: (qmail 12912 invoked by uid 102); 3 Mar 2016 19:47:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Mar 2016 14:47:29 -0500
Received: (qmail 9200 invoked by uid 107); 3 Mar 2016 19:47:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Mar 2016 14:47:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Mar 2016 14:47:27 -0500
Content-Disposition: inline
In-Reply-To: <xmqq1t7r2x21.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288207>

On Thu, Mar 03, 2016 at 11:14:46AM -0800, Junio C Hamano wrote:

> When 592ce208 (index-pack: use strip_suffix to avoid magic numbers,
> 2014-06-30) refactored the code to derive names of .idx and .keep
> files from the name of .pack file, a copy-and-paste typo crept in,
> mistakingly attempting to create and store the keep message file in
> the .idx file we just created, instead of .keep file.
> 
> As we create the .keep file with O_CREAT|O_EXCL, and we do so after
> we write the .idx file, we luckily do not clobber the .idx file, but
> because we deliberately ignored EEXIST when creating .keep file
> (which is justifiable because only the existence of .keep file
> matters), nobody noticed this mistake so far.

Eek. Sorry about that. Your explanation and fix looks obviously correct.

-Peff
