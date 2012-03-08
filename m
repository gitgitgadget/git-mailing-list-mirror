From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git 1.7.10-rc0
Date: Thu, 8 Mar 2012 01:30:54 -0500
Message-ID: <20120308063054.GD7643@sigill.intra.peff.net>
References: <7v7gyvkh84.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 07:31:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5WsQ-0002zm-1A
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 07:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880Ab2CHGa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 01:30:57 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44331
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753238Ab2CHGa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 01:30:56 -0500
Received: (qmail 389 invoked by uid 107); 8 Mar 2012 06:31:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Mar 2012 01:31:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Mar 2012 01:30:54 -0500
Content-Disposition: inline
In-Reply-To: <7v7gyvkh84.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192524>

On Wed, Mar 07, 2012 at 05:35:07PM -0800, Junio C Hamano wrote:

>  * A content filter (clean/smudge) used to be just a way to make the
>    recorded contents "more useful", and allowed to fail; a filter can
>    new optionally be marked as "required".

s/new/now/

>  * "git am" learned to pass "-b" option to underlying "git mailinfo", so
>    that bracketed string other than "PATCH" at the beginning can be kept.

s/bracketed/a &/

(or s/string/&s/)

>  * "git clone" learned to detach the HEAD in the resulting repository
>    when the source repository's HEAD does not point to a branch.

Hmm. Hasn't this been the case for a while? The jk/clone-detached topic
went into v1.7.7, and it was just fixes for some corner cases; actually
writing a detached HEAD is much older than that, even.

I assume this entry is due to the nd/clone-detached topic. Reading over
those commits, it seems like it is more about properly checking the
"--branch" argument for being detached, so we can handle
"--branch=v1.0". So maybe:

  * "git clone" learned to detach the HEAD in the resulting repository
    when the user specifies a tag with "--branch" (e.g., "--branch=v1.0").
    Clone also learned to print the usual "detached HEAD" advice in such
    a case, similar to "git checkout v1.0".

>  * "git log -G" learned to pay attention to the "-i" option and can
>    find patch hunks that introduce or remove a string that matches the
>    given pattern ignoring the case.

This didn't parse well for me. Also, it affects -S, too, doesn't it?
Maybe:

  * "git log -G" and "git log -S" learned to pay attention to the "-i"
    option. When "-i" is given, their patterns will match
    case-insensitively.

>  * The advise message given when the user didn't give enough clue on
>    what to merge to "git pull" and "git merge" has been updated to
>    be more concise and easier to understand.

s/advise/advice/

-Peff
