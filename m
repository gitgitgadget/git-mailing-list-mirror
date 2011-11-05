From: David Aguilar <davvid@gmail.com>
Subject: Re: How do I get a squashed diff for review
Date: Sat, 5 Nov 2011 02:15:15 -0700
Message-ID: <20111105091514.GA97860@gmail.com>
References: <CAH_EFyZ_0JB0-5cw-6VEJkfJhSjbmA=3upByQ3YpmnVSvR+9Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Roland Kaufmann <rlndkfmn+git@gmail.com>
To: Alexander Usov <a.s.usov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 05 10:15:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMcM1-0000Tm-QL
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 10:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129Ab1KEJPq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Nov 2011 05:15:46 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53665 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064Ab1KEJPp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 05:15:45 -0400
Received: by ywf7 with SMTP id 7so3352545ywf.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 02:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yf949wZkCJggxbQP+UCI7LQMzPafKlEIWD0Ei76eGCw=;
        b=DUKdq/LyZO6pa8t3G5Y81XZULwmGVCV8gCI3/Ysz41lN0Pi6cLBmwBMHxQF+XUvWj2
         PxWXTAut1arXCScgy8dEpq2HAU+sGYDdhYW0+n7REAqd1/JVi1m6m5oEczb9XX1OUp5Z
         3ayG5epIQSRG1Uj38dbcH6uw0p8flB49HrotU=
Received: by 10.50.36.161 with SMTP id r1mr19693354igj.37.1320484544808;
        Sat, 05 Nov 2011 02:15:44 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net. [208.106.56.2])
        by mx.google.com with ESMTPS id t5sm17114174pbb.13.2011.11.05.02.15.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 02:15:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAH_EFyZ_0JB0-5cw-6VEJkfJhSjbmA=3upByQ3YpmnVSvR+9Pg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184839>

On Fri, Nov 04, 2011 at 07:15:01PM +0000, Alexander Usov wrote:
> Hi,
>=20
> I'm wondering if there is an easy way to get a squashed diff of the
> changes done on the=C2=A0feature=C2=A0branch for review.
> In the simple cases (where feature branch is linear) there is an
> absolutely fantastic way to get a patch for review:
> git diff master...feature
>=20
> However if the feature branch happened to be long-lived and had
> mainline merged into it it's not going to work -- the
> resulting diff would contain changes from the merge. The way we are
> doing things now is to merge master into it
> once more and then diff, however this is somewhat cumbersome. Is ther=
e
> easier way to do it?

"git diff A...B" is equivalent to "git diff <merge-base A B> B".
The merge-base can be found with "git merge-base A B"
and is simply the common ancestor of A and B.

Diffing against the merge base (which doesn't contain the merged
work done in master) is why you're seeing the merges in the diff.

It sounds like you want the simpler form of "diff" which doesn't
do any merge-base calculation.

e.g. "git diff A B" and its synonymn "git diff A..B".


> And while we are on the topic -- is there a tool for git similar to "=
bzr qdiff"?
> It's a simple graphical diff viewer with 2 nice features -- it shows
> complete diff (of multiple files) in a single window and
> has a checkbox to switch between diff-only & full-text modes.
> I have seen difftool, but it seems to work on per-file basis, and
> something like "vi <(git diff ...)" lacks the easy way to
> switch into full-text mode.

difftool is a wrapper around specialized diff tools, so the
ability to switch from diff to full view is tool-dependent.

A contrib "git-dirdiff" script was posted to the list recently.
It builds upon diff tools that can diff directory trees.

http://thread.gmane.org/gmane.comp.version-control.git/184528

There may be a newer version of this script, too.  Roland would
know for sure...
--=20
					David
