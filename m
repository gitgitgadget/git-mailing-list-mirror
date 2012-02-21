From: "Neal Kreitzinger" <neal@rsss.com>
Subject: how do you review auto-resolved files
Date: Tue, 21 Feb 2012 14:41:57 -0600
Message-ID: <ji0vik$e48$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 21:42:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzwXg-0003jX-H0
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 21:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159Ab2BUUmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 15:42:19 -0500
Received: from plane.gmane.org ([80.91.229.3]:53187 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755729Ab2BUUmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 15:42:16 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RzwXL-0003af-U3
	for git@vger.kernel.org; Tue, 21 Feb 2012 21:42:11 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 21:42:11 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 21:42:11 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191181>

When git does a merges (merge/rebase/cherry-pick) it auto-resolves same-file 
changes that do not conflict on the same line(s).

Technical Question:  What are the recommended commands for reviewing the 
files that auto-resolved after a "merge"?

It seems like the commands might be different depending on the type of 
merge: git-merge, git-rebase, git-cherry-pick.  I imagine there are three 
steps to the "review auto-resolutions" procedure:

(1)  Determine the list of files that were changed on both sides (same-file 
edits) and which of those were auto-resolved during the merge.  (Preferably 
excluding those files that merge-conflicted since you already know how you 
manually resolved those.)

(2)  Review the auto-resolved files in full context to verify whether the 
auto-resolutions are desirable.

(3)  Manually remediate the merge-result (auto-resolution) or redo the 
merge-of-that-file for any files with undesirable auto-resolutions.  Perhaps 
an edit of the auto-resolved file is sufficient for simple remediations, but 
for more challenging remediations a manual redo of the merge-of-that-file 
would be desired.

Please advise on the proven (tried and tested) ways that others are using to 
verify/ensure that their auto-resolve results are correct.


Procedural/Philosophical Question:  What are the pros and cons of 
auto-resolved files?

Currently, we address the problem up-front instead of after-the-fact by 
enforcing merge-conflicts on every same-file edit by means of a 
"user-date-stamp" on "line 1" of every source file changed by performing 
keyword expansion (# $User$ $Date$) in our pre-commit hook.  I don't think 
keyword expansion or forcing merge-conflicts for every same-file edit is a 
common practice among git users.  Therefore, this seems like somewhat of a 
kludgey hack.  Furthermore, I assume that all git users are somehow 
reviewing their auto-resolutions.  (There is no way I would assume that git 
merged my same-file edits correctly.  It's great that git 
does-the-right-thing most-of-the-time, but that doesn't change the fact that 
I still have to review everything for undesirable resolutions.)

In light of this, it seems that there is no advantage to letting git 
auto-resolve same-file changes because the review process after-the-fact 
would actually be more error-prone and tedious than just manually-merging 
same-file edits up-front.  If I force you to resolve merge-conflicts 
up-front then I'm ensuring the merge-resolution is deliberate (and hopefully 
intelligent).  If I expect/assume you are going to review the 
auto-resolutions after-the-fact then you can neglect this because you:

  - have become complacent that git usually does-what-you-want so "you don't 
really need to do it",
  - are lazy and do it half-way,
  - forget to do it,
  - think "git magically does your work for you",
  - don't know how to do it,
  - don't even realize that anything auto-resolved or what auto-resolved,
  - decide you don't have to do it because that is what testing if for,
  - you think that your time is so valuable that an ounce-of-prevention on 
your part is not worth a pound-of-cure on the part of others.

Please comment on the pros and cons of "manual-merge up-front for same-file 
edits" vs. "review-and-remediate after-the-fact for auto-resolutions of 
same-file edits".

Thanks in advance for your replies!

v/r,
neal 
