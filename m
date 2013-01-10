From: Jeff King <peff@peff.net>
Subject: Re: about vim contrib support
Date: Thu, 10 Jan 2013 08:36:19 -0500
Message-ID: <20130110133619.GA19232@sigill.intra.peff.net>
References: <50EEA34B.7070102@gmail.com>
 <20130110113958.GA17137@sigill.intra.peff.net>
 <50EEAB36.6060508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 14:36:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtIJQ-0004l7-AJ
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 14:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205Ab3AJNgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 08:36:24 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53665 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753119Ab3AJNgX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 08:36:23 -0500
Received: (qmail 8453 invoked by uid 107); 10 Jan 2013 13:37:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Jan 2013 08:37:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jan 2013 08:36:19 -0500
Content-Disposition: inline
In-Reply-To: <50EEAB36.6060508@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213142>

On Thu, Jan 10, 2013 at 12:51:18PM +0100, Manlio Perillo wrote:

> .patch files are handled by diff highlight.
> What I would like to do is to use gitcommit syntax highlight, in order
> to also enable commit subject message hightlight.

Using the regular gitcommit highlighter would not make sense, as it is
intended for the message templates seen when making a commit. Whereas
format-patch .patch files have the headers as email headers.

You can load the mail header highlighting on top of diff highlighting
like this (which only triggers for patches that look like emails):

  au FileType diff
    \ if getline(1) =~ '^From ' |
    \   unlet b:current_syntax |
    \   runtime! syntax/mail.vim |
    \ endif

But maybe there is something else that you wanted to highlight. It's not
clear to me what you want from gitcommit's highlighting. Is it the
"complain about long lines" highlighting? I think that you'd have to
pull out of the gitcommit.vim and execute manually (and you'd have to
tweak the regex to take into account the "Subject: [PATCH] bits).

-Peff
