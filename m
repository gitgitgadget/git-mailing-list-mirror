From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] http.c: don't rewrite the user:passwd string multiple
 times
Date: Wed, 19 Jun 2013 01:26:14 -0400
Message-ID: <20130619052613.GA17500@sigill.intra.peff.net>
References: <CA+sFfMcsOx14UdzLF_JsgkpUQU6yG7DE+00eA3d+Lo-qncDgew@mail.gmail.com>
 <1371609829-31813-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, daniel@haxx.se,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 07:26:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpAuX-0006So-4m
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 07:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322Ab3FSF0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 01:26:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:43793 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751915Ab3FSF0T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 01:26:19 -0400
Received: (qmail 24404 invoked by uid 102); 19 Jun 2013 05:27:17 -0000
Received: from mobile-032-132-054-112.mycingular.net (HELO sigill.intra.peff.net) (32.132.54.112)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Jun 2013 00:27:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Jun 2013 01:26:14 -0400
Content-Disposition: inline
In-Reply-To: <1371609829-31813-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228340>

On Tue, Jun 18, 2013 at 07:43:49PM -0700, Brandon Casey wrote:

> From: Brandon Casey <drafnel@gmail.com>
> 
> Curl older than 7.17 (RHEL 4.X provides 7.12 and RHEL 5.X provides
> 7.15) requires that we manage any strings that we pass to it as
> pointers.  So, we really shouldn't be modifying this strbuf after we
> have passed it to curl.
> 
> Our interaction with curl is currently safe (before or after this
> patch) since the pointer that is passed to curl is never invalidated;
> it is repeatedly rewritten with the same sequence of characters but
> the strbuf functions never need to allocate a larger string, so the
> same memory buffer is reused.
> 
> This "guarantee" of safety is somewhat subtle and could be overlooked
> by someone who may want to add a more complex handling of the username
> and password.  So, let's stop modifying this strbuf after we have
> passed it to curl, but also leave a note to describe the assumptions
> that have been made about username/password lifetime and to draw
> attention to the code.

Thanks.

Acked-by: Jeff King <peff@peff.net>

-Peff
