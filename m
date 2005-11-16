From: Junio C Hamano <junkio@cox.net>
Subject: Re: stgit truncates binary files to zero length when applying patches
Date: Wed, 16 Nov 2005 10:30:19 -0800
Message-ID: <7vr79g8mys.fsf@assigned-by-dhcp.cox.net>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>
	<b0943d9e0511160311k725526d8v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 19:33:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcS36-000481-Dk
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 19:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbVKPSaW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 13:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030425AbVKPSaW
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 13:30:22 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:23786 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030424AbVKPSaV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 13:30:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051116183022.FUXF25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Nov 2005 13:30:22 -0500
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <b0943d9e0511160311k725526d8v@mail.gmail.com> (Catalin Marinas's
	message of "Wed, 16 Nov 2005 11:11:56 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12037>

Catalin Marinas <catalin.marinas@gmail.com> writes:

> ... When pushing a patch, if
> a merge is needed (like in your case, the base of the foo patch has
> changed), StGIT first tries "git-diff-tree | git-apply" for speed
> reasons. If this fails, it falls back to a three-way merge.

I think many of the scripts rely on git-apply failing reliably
for unapplicable patches.  I'll do a new test script in git.git/t
and if it fails on binary files, try to fix it today.

Incidentally, for the last couple of days, I was working on
adding a very limited binary file diff support to "diff piped to
apply" pattern, and the result has been posted as "reworked
rebase" patches.  It is very limited in the sense that the diff
output does not attempt to be useful if the patch consumer does
not have both pre- and post-image blob, but for the use of
StGIT's internal patch replaying purposes that is not a concern,
so you might be interested in taking a look.
