From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] refs.c: make ref_transaction_create a wrapper for
 ref_transaction_update
Date: Thu, 20 Nov 2014 11:00:01 -0500
Message-ID: <20141120160000.GA31738@peff.net>
References: <1416433224-29763-1-git-send-email-sbeller@google.com>
 <1416433224-29763-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, sahlberg@google.com, git@vger.kernel.org,
	mhagger@alum.mit.edu, jrnieder@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 17:00:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrU9U-0000NS-SB
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 17:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127AbaKTQAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 11:00:05 -0500
Received: from cloud.peff.net ([50.56.180.127]:42804 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751257AbaKTQAE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 11:00:04 -0500
Received: (qmail 13617 invoked by uid 102); 20 Nov 2014 16:00:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 10:00:03 -0600
Received: (qmail 13339 invoked by uid 107); 20 Nov 2014 16:00:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 11:00:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Nov 2014 11:00:01 -0500
Content-Disposition: inline
In-Reply-To: <1416433224-29763-2-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 19, 2014 at 01:40:23PM -0800, Stefan Beller wrote:

>  {
> -	struct ref_update *update;
> -
> -	assert(err);
> -
> -	if (transaction->state != REF_TRANSACTION_OPEN)
> -		die("BUG: create called for transaction that is not open");
> -
> -	if (!new_sha1 || is_null_sha1(new_sha1))
> -		die("BUG: create ref with null new_sha1");
> -
> -	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
> -		strbuf_addf(err, "refusing to create ref with bad name %s",
> -			    refname);
> -		return -1;
> -	}

You claimed in the cover letter that only BUG messages were changed. But
I think this third one is a real user-visible message.

That being said, I think the sum total of the change to the message is
s/create/update/, and it's probably fine.

-Peff
