From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 16/19] reset [--mixed] --quiet: don't refresh index
Date: Wed, 9 Jan 2013 12:01:19 -0500
Message-ID: <20130109170119.GA5332@sigill.intra.peff.net>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1357719376-16406-17-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 18:01:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsz2A-0000JX-Cw
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 18:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341Ab3AIRB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 12:01:27 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50778 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932298Ab3AIRB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 12:01:26 -0500
Received: (qmail 30403 invoked by uid 107); 9 Jan 2013 17:02:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Jan 2013 12:02:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jan 2013 12:01:19 -0500
Content-Disposition: inline
In-Reply-To: <1357719376-16406-17-git-send-email-martinvonz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213068>

On Wed, Jan 09, 2013 at 12:16:13AM -0800, Martin von Zweigbergk wrote:

> "git reset [--mixed]" without --quiet refreshes the index in order to
> display the "Unstaged changes after reset". When --quiet is given,
> that output is suppressed, removing the need to refresh the index.
> Other porcelain commands that care about a refreshed index should
> already be refreshing it, so running e.g. "git reset -q && git diff"
> is still safe.

Hmm. But "git reset -q && git diff-files" would not be?

We have never been very clear about which commands refresh the index.
Since "reset" is about manipulating the index, I'd expect it to be
refreshed afterwards. On the other hand, since we have never guaranteed
anything, perhaps a careful script should always use "git update-index
--refresh". I would not be too surprised if some of our own scripts are
not that careful, though.

-Peff
