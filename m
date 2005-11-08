From: Jon Loeliger <jdl@freescale.com>
Subject: Re: Expected Behavior?
Date: Mon, 07 Nov 2005 21:43:15 -0600
Message-ID: <E1EZKOB-0002j5-VY@jdl.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 04:44:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZKOY-0002Kd-Ce
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 04:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVKHDnR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 22:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbVKHDnR
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 22:43:17 -0500
Received: from jdl.com ([66.118.10.122]:63942 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S932246AbVKHDnQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 22:43:16 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EZKOB-0002j5-VY
	for git@vger.kernel.org; Mon, 07 Nov 2005 21:43:16 -0600
To: git@vger.kernel.org
In-Reply-To: 7vy841utif.fsf@assigned-by-dhcp.cox.net
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11309>

> Yup, it uses "git-ls-files --others", which considers that
> unmerged paths do not "exist" in the index.  This is wrong.
> 
> The attached is a patch to fix ls-files.
> 
> I also think that file3 should not appear in "Updated but not
> checked in (will commit)" list -- we are _not_ going to commit
> unmerged paths until you tell git what you want to do with
> them.  The patch in the next message fixes it.

Patch looks good here!  Thanks!

    % git status
    #
    # Updated but not checked in:
    #   (will commit)
    #
    #       modified: file1
    #       deleted:  file2
    #
    #
    # Changed but not updated:
    #   (use git-update-index to mark for commit)
    #
    #       unmerged: file3
    #

But I have a lingering question.  Same script as before.

    % git diff file3
    * Unmerged path file3

    % cat file3
    Stuff for a conflict.

Why didn't file3 show something like:

    % cat file3
    <<<<<
    Stuff for a conflict.
    =====
    Another file!
    >>>>>

That is, after the merge, file3 appears to have simply kept
the contents of the current, master branch.  Why wasn't the
dev branch represented here?

I _almost_ think I get it, and then *poof*...

Thanks,
jdl
