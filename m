From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 8/8] gitk: show modified files with separate work tree
Date: Sun, 10 Apr 2011 12:03:18 +1000
Message-ID: <20110410020318.GB25368@brick.ozlabs.ibm.com>
References: <1301969659-19703-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1301969659-19703-9-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 04:03:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8k0E-0000M9-5c
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 04:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602Ab1DJCDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 22:03:31 -0400
Received: from ozlabs.org ([203.10.76.45]:33022 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271Ab1DJCDb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 22:03:31 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id BDB9C1007D1; Sun, 10 Apr 2011 12:03:25 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <1301969659-19703-9-git-send-email-martin.von.zweigbergk@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171232>

On Mon, Apr 04, 2011 at 10:14:19PM -0400, Martin von Zweigbergk wrote:

> Is the test in proc hasworktree good?

The first parameter to 'if' is evaluated as an expression, so you
don't need the extra exprs.

> Why do git commands that need a work tree not work under .git? Why
> don't they show the same output as if they had been run from the work
> tree? (Btw, the check for valid work tree does not work for aliases,
> so e.g. 'git st', with 'st' as alias for 'status' will show all files
> as deleted.)

Don't know, ask Junio. :)

> How do I simplify the Tcl code to just return the boolean right away?

You can do:

    return [expr {[exec git rev-parse --is-bare-repository] == "false" &&
		  [exec git rev-parse --is-inside-git-dir] == "false"}]

> Why is the hasworktree variable reset in updatecommits? The only reason
> I can think of is when 'core.worktree' is set/changed, but I don't
> think that case worked very well before this series anyway. Should
> gitdir also be recalculated?

I don't know that there's any particularly strong reason to do it in
updatecommits.  It could probably be done once at startup.

Paul.
