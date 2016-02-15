From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 1/3] t: do not hide Git's exit code in tests
Date: Mon, 15 Feb 2016 12:41:57 -0500
Message-ID: <20160215174157.GA26443@sigill.intra.peff.net>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com>
 <1455531466-16617-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sschuberth@gmail.com,
	ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
	hvoigt@hvoigt.net, sbeller@google.com, Johannes.Schindelin@gmx.de,
	gitster@pobox.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 15 18:42:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVN9y-0000Cy-BF
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 18:42:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbcBORmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 12:42:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:42206 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750918AbcBORmA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 12:42:00 -0500
Received: (qmail 23205 invoked by uid 102); 15 Feb 2016 17:41:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 12:41:59 -0500
Received: (qmail 9554 invoked by uid 107); 15 Feb 2016 17:42:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 12:42:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 12:41:57 -0500
Content-Disposition: inline
In-Reply-To: <1455531466-16617-2-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286212>

On Mon, Feb 15, 2016 at 11:17:44AM +0100, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Git should not be on the left-hand side of a pipe, because it hides the exit
> code, and we want to make sure git does not fail.

I think this is a nice cleanup.

> There is one more occurrence of this pattern in t9010-svn-fe.sh which is to
> evolved to change it easily.

The final sentence in the commit message needs s/to/too/. However, I'm
not sure this is the only remaining case. Doing:

  git grep -E 'git.*[^|]\|($|[^|])'

shows quite a few. I guess you just looked for "nul_to_q". There is
certainly no need to fix all of them, but you may want to note the
extent of your grepping in your commit message.

-Peff
