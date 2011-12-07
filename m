From: Jeff King <peff@peff.net>
Subject: Re: Odd issue - The Diffs That WILL NOT DIE.
Date: Wed, 7 Dec 2011 17:03:45 -0500
Message-ID: <20111207220345.GA21596@sigill.intra.peff.net>
References: <CAJ8P3RBm=RhNf6LKLqprqX6Rqx0OgRnJR+=+-Qhg4PvpeqaUDg@mail.gmail.com>
 <20111206215102.GA3654@centaur.lab.cmartin.tk>
 <CAJ8P3RCPt9Kwi1F7_TEkZQhkm1mwR_TFKhYszS5LL50kXU8oNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Chris Patti <cpatti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 23:03:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYPai-00010L-7Q
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 23:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005Ab1LGWDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 17:03:48 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42902
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752444Ab1LGWDr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 17:03:47 -0500
Received: (qmail 20489 invoked by uid 107); 7 Dec 2011 22:10:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Dec 2011 17:10:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Dec 2011 17:03:45 -0500
Content-Disposition: inline
In-Reply-To: <CAJ8P3RCPt9Kwi1F7_TEkZQhkm1mwR_TFKhYszS5LL50kXU8oNQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186508>

On Wed, Dec 07, 2011 at 11:54:26AM -0500, Chris Patti wrote:

> OK.  Let me give you a very specific series of commands, sorry about
> the poor question / report (Not convinced it's a bug, probably pilot
> error?)
> 
> If my understanding of the way Git works is correct, there should be
> NO pending diffs in a freshly cloned repository, yes?

Yes. It's probably a bug, perhaps related to the case-insensitive
filesystem (we've seen similar weird "phantom changes right after clone"
bugs before).

> 11:35][admin@Hiram-Abiff-2:~/src]$ rm -rf framework/
> [11:37][admin@Hiram-Abiff-2:~/src]$
> [11:44][admin@Hiram-Abiff-2:~/src]$ git clone
> ssh://git.bluestatedigital.com/home/git/framework.git
> Cloning into 'framework'...
> remote: Counting objects: 378540, done.
> remote: Compressing objects: 100% (100469/100469), done.
> remote: Total 378540 (delta 261046), reused 374685 (delta 258447)
> Receiving objects: 100% (378540/378540), 148.33 MiB | 2.08 MiB/s, done.
> Resolving deltas: 100% (261046/261046), done.
> [11:51][admin@Hiram-Abiff-2:~/src]$ cd framework/
> [11:51][admin@Hiram-Abiff-2:~/src/framework(master)]$ git diff
> diff --git a/app/modules/Core/controllers/CloudSponge.php b/app/modules/Core/con
> index 615a7b3..911d456 100644
> --- a/app/modules/Core/controllers/CloudSponge.php
> +++ b/app/modules/Core/controllers/CloudSponge.php

Are there other files in the repository that differ from this path only
in capitalization? Can you show us the output of "git ls-files"?

Is it possible to make this repo public, or at least available privately
to git developers?

You mentioned v1.7.8. Do you see the bug with other git versions? If
not, can you try bisecting?

-Peff
