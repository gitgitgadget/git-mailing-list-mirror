From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t3200-branch: test setting branch as own upstream
Date: Fri, 28 Feb 2014 00:37:03 -0500
Message-ID: <20140228053703.GA32556@sigill.intra.peff.net>
References: <1393556659-32717-1-git-send-email-modocache@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 06:37:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJG8H-0002A8-5y
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 06:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbaB1FhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 00:37:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:58465 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750844AbaB1FhF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 00:37:05 -0500
Received: (qmail 6845 invoked by uid 102); 28 Feb 2014 05:37:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Feb 2014 23:37:05 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Feb 2014 00:37:03 -0500
Content-Disposition: inline
In-Reply-To: <1393556659-32717-1-git-send-email-modocache@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242886>

On Fri, Feb 28, 2014 at 12:04:18PM +0900, Brian Gesiak wrote:

> No test asserts that "git branch -u refs/heads/my-branch my-branch"
> emits a warning. Add a test that does so.

For an operation like "git branch foo origin" where setting up the
tracking is a side effect, a warning makes sense. But the sole purpose
of the command above is to set the upstream, and we didn't do it; should
this warning actually be upgraded to an error?

> +test_expect_success '--set-upstream-to shows warning if used to set branch as own upstream' '
> +	git branch --set-upstream-to refs/heads/my13 my13 2>actual &&
> +	cat >expected <<EOF &&
> +warning: Not setting branch my13 as its own upstream.
> +EOF
> +	test_cmp expected actual
> +'

This should use test_i18ncmp, as the string you are matching is
internationalized.

-Peff
