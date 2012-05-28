From: Jeff King <peff@peff.net>
Subject: Re: Alphabetize git config --list
Date: Mon, 28 May 2012 17:23:09 -0400
Message-ID: <20120528212309.GA4220@sigill.intra.peff.net>
References: <CAFus=5=cp62hpLM_Odog--Q0vER8kkT5Doqo28i-yZQyfvv4gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Zach <zach@letmesearchthat.com>
X-From: git-owner@vger.kernel.org Mon May 28 23:23:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZ7PR-0005Dc-F9
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 23:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605Ab2E1VXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 17:23:15 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:34473
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397Ab2E1VXL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 17:23:11 -0400
Received: (qmail 16240 invoked by uid 107); 28 May 2012 21:23:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 May 2012 17:23:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 May 2012 17:23:09 -0400
Content-Disposition: inline
In-Reply-To: <CAFus=5=cp62hpLM_Odog--Q0vER8kkT5Doqo28i-yZQyfvv4gQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198724>

On Mon, May 28, 2012 at 01:58:28PM -0700, Zach wrote:

> I was wondering if it would be possible to alphabetically order git
> config --list by default.
> 
> Essentially this
> $ git config --list | sort

No, it's not a good idea; the order of keys is important. For example,
this config:

  [color]
    ui = true
    ui = false

is different than this:

  [color]
    ui = false
    ui = true

While that seems like a contrived example, consider something like a
.git/config repo-specific config file overriding a user-wide
~/.gitconfig file. We do it by overwriting the old key.

There are also some "multi" values which accept multiple entries to
create a list, and the list order may be relevant (I'd have to check,
though; the only one that comes to mind is refspecs, and I don't know
that order matters there).

-Peff
