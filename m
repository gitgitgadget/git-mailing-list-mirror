From: =?UTF-8?B?SHJ2b2plIE5pa8WhacSH?= <hniksic@gmail.com>
Subject: Re: Converting merge to rebase in the presence of conflicts
Date: Mon, 11 Apr 2011 17:15:11 +0200
Message-ID: <BANLkTinVUdmG56oPQXvMhFh6hLcFj3_jZg@mail.gmail.com>
References: <BANLkTi=krC6JMEWj=a5CY1vRCcmh9b+BaQ@mail.gmail.com>
	<4DA3182B.2030305@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 11 17:15:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Ipk-0004gz-6h
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 17:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278Ab1DKPPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 11:15:12 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:38458 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754209Ab1DKPPL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 11:15:11 -0400
Received: by yia27 with SMTP id 27so2194290yia.19
        for <git@vger.kernel.org>; Mon, 11 Apr 2011 08:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=OVJz6XwuLAyNCL98LzyKlr6hCrG4XgNwKnG+/pWhCjg=;
        b=JDK/ff/awg3arWrx5DV3a+RgLhwSl35JXG14qUwGi6PMCULQdQ9AHAv+Pjgso3s/As
         Bnc4awdKAmx4CbCg3WzsOFQZwtabVhhErpbLOtruYL2PI1lrr+wF8hZ03KwxJ9S/SVkc
         2Pr+7hSO/Eesy19Hnv5z8puWIm4vMGeXA72tk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=w58tD+1WyANWTIttq4TE6b74hHiQTkM9u6RJfpndh238iZisD3q8zVasQohTCFVEi2
         TyGxJvBXYgYjpz/xcW1tPo98N5k0HtTiw6yG62OQduUa8lnbeM/QEmCW+zLBvgtwryyg
         ULgBD8JBfUT1rW7dqcDGooJy5fpRQ/bv1QNfg=
Received: by 10.91.21.1 with SMTP id y1mr4664928agi.169.1302534911164; Mon, 11
 Apr 2011 08:15:11 -0700 (PDT)
Received: by 10.90.63.17 with HTTP; Mon, 11 Apr 2011 08:15:11 -0700 (PDT)
In-Reply-To: <4DA3182B.2030305@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171333>

Thanks for the responses, rerere works nicely, if somewhat cryptic. At
the rebase step I got:

First, rewinding head to replay your work on top of it...
Applying: changed2
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
Auto-merging a
CONFLICT (content): Merge conflict in a
Resolved 'a' using previous resolution.
Failed to merge in the changes.
Patch failed at 0001 changed2

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase --abort".

That's a lot of output, some of it scary-looking. (OK, maybe not
scary-looking to me, but certainly so to someone not yet fully
comfortable with git.)  Running "git rebase --continue" told me I
needed to "edit all merge conflicts and then mark them as resolved",
whereas the conflicts are in fact already resolved, but rebase doesn't
know it.  Again, this isn't a big problem for me, but it's unfriendly.
 "git add" followed by "git rebase --continue" worked exactly as I
hoped it would.

I still wonder why rerere is necessary here. After all, even without
the rerere metadata, the information about conflict resolution is
right there, in the merge commit, and rebase could conceivably make
use of it. What am I missing?

Hrvoje
