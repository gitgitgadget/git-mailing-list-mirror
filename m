From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Git commit generation numbers
Date: Fri, 15 Jul 2011 09:18:46 -0700
Message-ID: <CAJo=hJtuxNLhSjn_sDJxG7xu5k2wbJ_QLf_n+Z1E=o2AndAuJQ@mail.gmail.com>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
 <20110714183710.GA26820@sigill.intra.peff.net> <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
 <20110714190844.GA26918@sigill.intra.peff.net> <CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
 <20110714200144.GE26918@sigill.intra.peff.net> <69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
 <20110714203141.GA28548@sigill.intra.peff.net> <CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
 <20110715074656.GA31301@sigill.intra.peff.net> <CA+55aFzS3KDNvKt-dXvYpuAQwFwD3+GCj8y8bRQCycPvrynT8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 18:19:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qhl6g-0007Ib-JV
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 18:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949Ab1GOQTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 12:19:08 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58873 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab1GOQTH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 12:19:07 -0400
Received: by eyx24 with SMTP id 24so744470eyx.19
        for <git@vger.kernel.org>; Fri, 15 Jul 2011 09:19:06 -0700 (PDT)
Received: by 10.205.65.200 with SMTP id xn8mr1261742bkb.316.1310746746227;
 Fri, 15 Jul 2011 09:19:06 -0700 (PDT)
Received: by 10.204.100.7 with HTTP; Fri, 15 Jul 2011 09:18:46 -0700 (PDT)
In-Reply-To: <CA+55aFzS3KDNvKt-dXvYpuAQwFwD3+GCj8y8bRQCycPvrynT8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177203>

On Fri, Jul 15, 2011 at 09:10, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Right now, we do *have* a "generation number". It's just that it's
> very easy to corrupt even by mistake. It's called "committer date". We
> could improve on it.
...
> If I had realized how small the patch was to add generation counters,
> and that it wouldn't have broken backwards compatibility (ie fsck
> doesn't start complaining). I would have done it originally, instead
> of all the crazy hacks we did for commit date verification.

What about going forward making the requirement that a new commit must
have a committer date whose date is >= the maximum date of its
parents?

We could also add a check during fast-forward merges to refuse to
perform the merge if the incoming commit has a committer date too far
forward in the future (e.g. more than 5 minutes). If you pull from a
moron whose system clock is set such that the committer date isn't a
proxy for generation number, Git would just refuse the merge, and you
could ask them to fix their objects.

-- 
Shawn.
