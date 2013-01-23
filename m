From: John Keeping <john@keeping.me.uk>
Subject: Re: What's cooking in git.git (Jan 2013, #08; Tue, 22)
Date: Wed, 23 Jan 2013 09:28:58 +0000
Message-ID: <20130123092858.GJ7498@serenity.lan>
References: <7va9s0n8gv.fsf@alter.siamese.dyndns.org>
 <20130122234554.GI7498@serenity.lan>
 <7vobgglpv4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Chris Rorvick <chris@rorvick.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 10:29:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxweQ-0005s1-L6
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 10:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123Ab3AWJ3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 04:29:24 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:46026 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754657Ab3AWJ3K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 04:29:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 110A26065A1;
	Wed, 23 Jan 2013 09:29:09 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZYqqAU316RYO; Wed, 23 Jan 2013 09:29:08 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 0D3FB60659B;
	Wed, 23 Jan 2013 09:29:07 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id E3F41161E34E;
	Wed, 23 Jan 2013 09:29:07 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cq5f2WBMumJI; Wed, 23 Jan 2013 09:29:07 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 68482161E54F;
	Wed, 23 Jan 2013 09:29:00 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vobgglpv4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214305>

On Tue, Jan 22, 2013 at 04:11:59PM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
>> Would you mind holding off on this?  As it stands there are a couple of
>> issues with the cvsimport-3 script including: ...
> 
> Actually I do. I think this, at least the early part of it, should
> be merged to 'next' as soon as possible, *unless*
> 
>  (1) The cvsimport-2 & cvsps2 combo this series ships gives worse
>      experience than cvsimport we ship in v1.8.1 to end users of the
>      current cvsimport with cvsps2; and/or
> 
>  (2) The cvsimport-3 in this series, which is a copy of an older
>      version of what Eric has, is so broken that we are better off
>      starting cvsimport-3 by getting a fresh copy from Eric which
>      has been rewritten in a major way, than applying huge
>      incremental update patches that amounts to a total rewrite.
> 
> The point (1) is important from "no regression" point of view, and
> in a sense more important between the two because it is the first
> step in the overall transition plan.
> 
> Even though there may be remaining issues in cvsimport-3 and cvsps3
> (what new piece of software don't have issues?), my limited
> observation of the exchanges between you and Eric suggests me that
> the problem is not something that requires a total rewrite of how
> cvsimport-3 works, so I do not expect the point (2) to be true,
> either, but if I am mistaken, please let me know.

ESR's cvsimport.py in the cvsps repository has no fixes over what's
here.  I think his comment in [1] indicates that he won't do any more
work on git-cvsimport.

[1] http://article.gmane.org/gmane.comp.version-control.git/214057

In my opinion the incremental import support really is substantially
worse in cvsimport-3 than cvsimport-2.  cvsimport-2 looks at the output
of git-for-each-ref to calculate the dates from which to continue each
branch.  cvsps cannot be told this information and so the cvsimport-3
script just takes the date of the last commit on the current branch.

On top of that, the incremental switch to cvsps-3 just causes it to
output:

    from: refs/heads/branch^0

on the first commit for each branch, which I can't see working if a new
branch is created in CVS.

> By advancing the topic to 'next', we will give people a more solid
> (read: not getting rewound) foundation to work with than "if you are
> really interested, grab the tip of 'pu', replace it with even newer
> copy from Eric's repository and try it out", so that more people can
> help us polish the scaffolding to let us ship two versions and also
> find issues in the new cvsimport-3 and help fixing them.  At least,
> that is what I've been hoping.

That's what I've done and it's convinced me that cvsps-3 is not ready
for use with incremental imports as it stands.

> I could stop at the first three patches, that is, introducing the
> version switch wrapper that switches between cvsps2+cvsimport-2
> combo and nothing, and then let you and Eric redo the "start adding
> cvsps 3.x support" and later patches when cvsimport-3 is ready.
> That would give you a larger lattitude to rework cvsimport-3.  Is
> that preferrable?

My preference would be for something like this, possibly with an
expanded examples section showing how to pipe the output of cvsps-3 or
cvs2git into git-fast-import:

-- >8 --

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 9d5353e..20b846e 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -18,6 +18,11 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
+*WARNING:* `git cvsimport` uses cvsps version 2, which is considered
+deprecated; it does not work with cvsps version 3 and later.  If you are
+performing a one-shot import of a CVS repository consider using cvsps-3,
+cvs2git or parsecvs directly.
+
 Imports a CVS repository into git. It will either create a new
 repository, or incrementally import into an existing one.
 
-- 8< --


John
