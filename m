From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Expected Behavior?
Date: Thu, 10 Nov 2005 12:04:11 +1300
Message-ID: <46a038f90511091504l7218df18k251bec75491891e9@mail.gmail.com>
References: <E1EZKOB-0002j5-VY@jdl.com>
	 <7vwtjjllw4.fsf@assigned-by-dhcp.cox.net>
	 <20051108210332.GB23265@c165.ib.student.liu.se>
	 <20051109112452.GD30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Junio C Hamano <junkio@cox.net>,
	Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 00:06:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZyzJ-00079j-DR
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 00:04:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbVKIXEN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 18:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbVKIXEN
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 18:04:13 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:81 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751549AbVKIXEM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 18:04:12 -0500
Received: by zproxy.gmail.com with SMTP id 40so246573nzk
        for <git@vger.kernel.org>; Wed, 09 Nov 2005 15:04:12 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hmndfGH/tOvGlncLauZGB6h/fxdgHMrYeXmXNNUyHQO5CCFLx0ZZ7KooG0Iu7b1F3EpgFXcJiNSqQLvOjZMCZNB4iRuhsZHI3R4iWhJ6wc1C2fYHMXM0a1/yFoDpX0U9zqaTT3ri2E/rs+AyZ2DxH3ZP8pK40hDvkAtsps4obbc=
Received: by 10.65.218.2 with SMTP id v2mr57736qbq;
        Wed, 09 Nov 2005 15:04:12 -0800 (PST)
Received: by 10.64.242.4 with HTTP; Wed, 9 Nov 2005 15:04:11 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051109112452.GD30496@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11432>

On 11/10/05, Petr Baudis <pasky@suse.cz> wrote:
> The world would be so much better if there would be just a _single_
> per-file automerger instead of three right now...

I don't quite agree with this. The multi-merger mechanism is something
(relatively) unique and powerful in GIT. Having fast+stupid, with
fallback to slow+smart is an excellent strategy, and having the
mechanism in place means that if someone is crazy enough to write a
smarter merge script for a language or a particular project (say, to
ease the transition to a new directory layout) it is entirely
possible.

In the end, merges are tricky and need to be controlled by the end
user. We can help this giving the user good control and good
visibility of what decisions the merger is taking.

> I'm planning to feed back the automerger stuff from Cogito to GIT like I
> already did once.

I use both mergers (cg and git) and I'd really _really_ like to turn
cg-merge into a wrapper for git-merge. The cg merger does the basics:
trivial merge, fast forwards and diff3 merges. Adding the rest is
_hard_ and debugging/auditing it is even harder. IMHO, having strong,
high quality mergers is a must, and it's a complex enough space that a
porcelain should align itself with git so we get a strong set of
mergers done in a way that all porcelains can hook into.

I made an initial half-attempt but it's trickier that I had expected
because cg-merge relies on cg-commit to wrap up, marke the index as
resolved, and commit, and I'm not entirely sure of how that works in
detail. My changes were going in the direction of breaking the current
usage patterns, so it was a no-go really.

cheers,


martin
