From: Jeff King <peff@peff.net>
Subject: Re: 3 failures on test t9100 (svn)
Date: Tue, 2 Mar 2010 16:28:06 -0500
Message-ID: <20100302212806.GA21413@coredump.intra.peff.net>
References: <20100302194518.GA12942@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Tue Mar 02 22:28:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmZdY-0008EY-1W
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 22:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430Ab0CBV2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 16:28:10 -0500
Received: from peff.net ([208.65.91.99]:51848 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588Ab0CBV2J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 16:28:09 -0500
Received: (qmail 31411 invoked by uid 107); 2 Mar 2010 21:28:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 02 Mar 2010 16:28:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Mar 2010 16:28:06 -0500
Content-Disposition: inline
In-Reply-To: <20100302194518.GA12942@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141416>

On Tue, Mar 02, 2010 at 08:45:18PM +0100, Nicolas Sebrecht wrote:

> Some tests in t9100 don't pass here with current next (full log
> attached). Any idea?
> [...]
>   test_cmp:1: command not found: diff -u

Probably related to this line. Assuming you have "diff" in your PATH,
based on that message I would guess that your shell is trying to execute
"diff -u" as a single file, which obviously won't work. The relevant
code in test-lib.sh is something like:

  GIT_TEST_CMP='diff -u'
  test_cmp() {
    $GIT_TEST_CMP "$@"
  }

which _should_ split the "diff -u" on whitespace. What platform are you
on? Which shell is /bin/sh on your system?

-Peff
