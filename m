From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t1050-large: replace dd by test-genrandom
Date: Wed, 14 Jan 2015 06:27:00 -0500
Message-ID: <20150114112659.GA23474@peff.net>
References: <54B5579B.4080607@kdbg.org>
 <20150113214733.GA16582@peff.net>
 <54B59D24.7030508@kdbg.org>
 <20150113223849.GA3144@peff.net>
 <xmqq4mruckrp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 12:27:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBM6V-0005Ue-3i
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 12:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbbANL1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 06:27:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:34265 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752079AbbANL1D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 06:27:03 -0500
Received: (qmail 22018 invoked by uid 102); 14 Jan 2015 11:27:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jan 2015 05:27:03 -0600
Received: (qmail 2006 invoked by uid 107); 14 Jan 2015 11:27:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jan 2015 06:27:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jan 2015 06:27:00 -0500
Content-Disposition: inline
In-Reply-To: <xmqq4mruckrp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262373>

On Tue, Jan 13, 2015 at 03:40:10PM -0800, Junio C Hamano wrote:

> >> -	test-genrandom seed2 2500000 >huge &&
> >> +	printf "\0%2500000s" Y >huge &&
> [...]
> Are we depending on the binary-ness of these test files by the way?
> The leading NUL \0 looked a bit strange to me.

I don't think so. We do not want to do a text diff, because that would
overflow our GIT_ALLOC_LIMIT. But the core.bigfilethreshold check is
what will make them binary, not the actual content. So a gigantic text
file is arguably a better test of the feature in question.

-Peff
