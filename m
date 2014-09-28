From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Use SHELL_PATH as hash bang in test suite askpass helper
 script.
Date: Sun, 28 Sep 2014 19:14:28 -0400
Message-ID: <20140928231428.GA9061@peff.net>
References: <1411942867-3995-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 01:14:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYNfn-0005fx-5R
	for gcvg-git-2@plane.gmane.org; Mon, 29 Sep 2014 01:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439AbaI1XOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2014 19:14:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:52599 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751985AbaI1XOb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2014 19:14:31 -0400
Received: (qmail 23107 invoked by uid 102); 28 Sep 2014 23:14:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 28 Sep 2014 18:14:31 -0500
Received: (qmail 5754 invoked by uid 107); 28 Sep 2014 23:14:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 28 Sep 2014 19:14:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Sep 2014 19:14:28 -0400
Content-Disposition: inline
In-Reply-To: <1411942867-3995-1-git-send-email-bdwalton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257615>

On Sun, Sep 28, 2014 at 11:21:07PM +0100, Ben Walton wrote:

> The askpass script that is created for use by the test suite should
> use SHELL_PATH for its hash bang instead of /bin/sh. Commit 5a4352024
> introduced the use of idioms not supported in some legacy /bin/sh
> implementations.

Sounds good.

> -cat >askpass <<\EOF
> -#!/bin/sh
> +echo "#!$SHELL_PATH" >askpass
> +cat >>askpass <<\EOF

This can just become:

  write_script askpass <<\EOF

which handles this for us (and you can get rid of the manual chmod then,
too).

-Peff
