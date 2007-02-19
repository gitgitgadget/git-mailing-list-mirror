From: Yann Dirson <ydirson@altern.org>
Subject: Re: StGIT discards local commits on "stg pull"
Date: Tue, 20 Feb 2007 00:44:25 +0100
Message-ID: <20070219234425.GJ4248@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070212022625.rvyyo0kc0wowgogc@webmail.spamcop.net> <b0943d9e0702120131r528fb29ete143b8ce5a0a99e9@mail.gmail.com> <20070212202634.GX4266@nan92-1-81-57-214-146.fbx.proxad.net> <20070212214704.GS5362@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0702191507m636348e7yab2a712925f9f55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 01:49:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJJC2-0007vO-66
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 01:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965802AbXBTAtQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 19:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965808AbXBTAtQ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 19:49:16 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:40298 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965802AbXBTAtO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 19:49:14 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 214BB547FB;
	Tue, 20 Feb 2007 00:45:37 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id B9BDF1F087; Tue, 20 Feb 2007 00:44:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <b0943d9e0702191507m636348e7yab2a712925f9f55@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40180>

On Mon, Feb 19, 2007 at 11:07:09PM +0000, Catalin Marinas wrote:
> >Thinking about it, detecting whether we're going to lose a commit is
> >just checking *before pulling* whether the current base is reachable
> >from the parent's current head.
> 
> There is a potential problem with this approach - pulling/fetching
> from a tree which is always rebased (either managed with StGIT or
> simply running git-rebase before publishing it) would report an error
> since the old base is no longer reachable from the current head.

Right - a better solution is highlighted in today's proposal (which I
have started to implement).

> In this case, the current fetch+rebase behaviour would be desirable.
>
> I think the fail-safe solution would be to leave the old behaviour
> (i.e. git-pull and pull-does-rebase=no) and people that need to pull
> from branches like that described above would use the fetch+rebase
> approach.

We could do this, but I only see this as a temporary measure to avoid
unleashing the new behaviour onto unsuspicious users before we've
ironed out the final behaviour.  I still think that the current
behaviour belongs to a very specific workflow which is not that
expected by most users.


> Ideally, we'll have this configurable per-branch (and could
> leave the global one as well if the most specific is not available,

Right.

> but should default to git-pull).
>
> Let me know what you think so that I'll try to release a 0.12.1 update
> (I already have the simple patch for using git-pull by default if you
> are OK with this scenario).

Since it is important that users don't unknowingly loose commits, yes
it is preferable to release 0.12.1 with the old behaviour.  Let's take
the time to shake things more for 0.13, and we can reconsider this
choice by then.

Best regards,
-- 
Yann.
