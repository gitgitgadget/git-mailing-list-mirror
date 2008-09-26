From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2 4/4] diff.c: convert builtin funcname patterns to non-GNU
 extended regex syntax
Date: Fri, 26 Sep 2008 12:49:17 -0500
Message-ID: <ZOivOHIiBa1yoDqFPq18uB0VuTttUsV4lS5k7YcyEsM@cipher.nrlssc.navy.mil>
References: <7vskry1485.fsf@gitster.siamese.dyndns.org> <4i0Mu795rKpv37JoHytmE6kODBjwgwITn0-DuKdZiFs3ZnUlyJC-Fw@cipher.nrlssc.navy.mil> <7v7i97swv3.fsf@gitster.siamese.dyndns.org> <7vy71n482x.fsf@gitster.siamese.dyndns.org> <loom.20080920T200157-713@post.gmane.org> <7vmyi21mf8.fsf@gitster.siamese.dyndns.org> <i-l9YX2TO45e2OB9LuoxrAN6a2iFYaH_eEGlVmRsP0oa97XuwX4eGQ@cipher.nrlssc.navy.mil> <qzJgAPRiQZfGnPgFs3xqeXM_jkaODH54dU-hZgP_AftxmMjJxFOfyQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 26 19:51:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjHTO-0005YN-L4
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 19:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbYIZRuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 13:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752211AbYIZRuL
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 13:50:11 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41580 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbYIZRuK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 13:50:10 -0400
Received: by mail.nrlssc.navy.mil id m8QHnHvV008816; Fri, 26 Sep 2008 12:49:17 -0500
In-Reply-To: <qzJgAPRiQZfGnPgFs3xqeXM_jkaODH54dU-hZgP_AftxmMjJxFOfyQ@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 26 Sep 2008 17:49:17.0591 (UTC) FILETIME=[327CFA70:01C92000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96879>


Shawn,

When you get around to merging this series into maint and master,
you'll probably want to redo the merge of Junio's
bc/maint-diff-hunk-header-fix into bc/master-diff-hunk-header-fix.

After applying 'diff hunkpattern: fix misconverted "\{" tex macro introducers'
to bc/maint-diff-hunk-header-fix, he made a mistake when merging
96d1a8e9 into his bc/master-diff-hunk-header-fix which was at 3d8dccd7 to
produce 92bb9785. (gitk fdac6692 makes this easier to see. fdac6692 should
be the current tip of bc/master-diff-hunk...)

The resulting diff.c in 92bb9785, contains _two_ bibtex patterns, one fixed
by the 'diff hunkpattern:...' patch, and one unfixed. The broken bibtex
pattern was eventually fixed, but the duplicate pattern is still there on
the tip of that branch and in next. It would be nice if the merge could be
redone.

Here are the commands, since sometimes it makes more sense this way:

git branch bc/maint-diff-hunk-header-fix 96d1a8e9
git checkout -b bc/master-diff-hunk-header-fix 3d8dccd7
git merge bc/maint-diff-hunk-header-fix
# fix conflict, make sure you choose the right bibtex pattern
# and delete the other. The builtin-funcname patterns were
# also alphabetized on the master branch, so the correct bibtex
# should be moved to the first entry.

# then reapply the other two patches
git checkout bc/maint-diff-hunk-header-fix
git cherry-pick e3bf5e43
git checkout bc/master-diff-hunk-header-fix
git merge bc/maint-diff-hunk-header-fix
git cherry-pick fdac6692
git commit --amend
# Remove Junio's comment about 'fixes bibtex pattern breakage exposed
# by this test'

-brandon
