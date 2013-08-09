From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] parse-options: fix clang opterror() -Wunused-value
 warning
Date: Fri, 9 Aug 2013 06:32:49 -0400
Message-ID: <20130809103249.GA18878@sigill.intra.peff.net>
References: <1376039177-17560-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Max Horn <max@quendi.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 12:33:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7k0B-0001G2-PQ
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 12:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966835Ab3HIKc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 06:32:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:46219 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966522Ab3HIKcz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 06:32:55 -0400
Received: (qmail 28003 invoked by uid 102); 9 Aug 2013 10:32:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Aug 2013 05:32:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Aug 2013 06:32:49 -0400
Content-Disposition: inline
In-Reply-To: <1376039177-17560-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231969>

On Fri, Aug 09, 2013 at 05:06:17AM -0400, Eric Sunshine wrote:

> a469a1019352b8ef (silence some -Wuninitialized false positives;
> 2012-12-15) triggered "unused value" warnings when the return value of
> opterror() and several other error-related functions was not used.
> 5ded807f7c0be10e (fix clang -Wunused-value warnings for error functions;
> 2013-01-16) applied a fix by adding #if !defined(__clang__) in cache.h
> and git-compat-util.h, but misspelled it as #if !defined(clang) in
> parse-options.h. Fix this.
> 
> This mistake went unnoticed because existing callers of opterror()
> utilize its return value.  1158826394e162c5 (parse-options: add
> OPT_CMDMODE(); 2013-07-30), however, adds a new invocation of opterror()
> which ignores the return value, thus triggering the "unused value"
> warning.

Oops.

Patch looks obviously correct. Thanks for a nice explanation of what
happened.

-Peff
