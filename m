From: "Neal Kreitzinger" <neal@rsss.com>
Subject: Re: force "unmerged" for same-file auto-merges
Date: Thu, 25 Mar 2010 20:04:11 -0500
Message-ID: <hoh16f$koe$1@dough.gmane.org>
References: <hobqoc$5h3$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 02:04:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nuxye-0005Zd-0q
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 02:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232Ab0CZBEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 21:04:38 -0400
Received: from lo.gmane.org ([80.91.229.12]:36906 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753207Ab0CZBEh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 21:04:37 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NuxyS-0005T6-Md
	for git@vger.kernel.org; Fri, 26 Mar 2010 02:04:32 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 02:04:32 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 02:04:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5843
X-RFC2646: Format=Flowed; Response
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143204>

In other words, when two people modify the same file in different places I 
want the automerge results file, but I want the resulting file marked as 
unmerged so the programmer can then run git-mergetool to review the merge 
results.  This also prevents the programmer from running git-commit 
immediately after the automerge without reviewing the merge results.  Can 
"mark automerge of samefile as 'unmerged'" be done in git via config 
settings or command options?



v/r,

Neal



"Neal Kreitzinger" <neal@rsss.com> wrote in message 
news:hobqoc$5h3$1@dough.gmane.org...
> Scenario:  "same-file auto-merge":  when two different people change the 
> same file in their separate repos.  Their changes do not conflict in the 
> sense that they are changes to the same lines.  However, their changes do 
> conflict in the sense that the resulting merged logic is incorrect.
>
> Concern:
> The same-file auto-merge results are overlooked (not reviewed) by the 
> programmer because there is nothing preventing a git-commit immediately 
> after the auto-merge completes.
>
> Desired Solution:
> Perform same-file auto-merge and produce auto-merge results, but mark all 
> such auto-merged files as "unmerged" so that they must be 
> reviewed/resolved before a git-commit.  The "unmerged" status allows 
> git-mergetool to be run (e.g. kdiff3) so that the merged lines can be 
> reviewed.  In this way, all auto-merged files are reviewed.
>
> Does anyone know if there are configuration and/or command-line options in 
> git that can accomplish this in a fairly straightforward manner?  For 
> example, something like this:
>
>
> Example config:
> $ cat gitconfig
> [merge]
>            samefileauto = forceconflict
>
>
> Example command:
> $ git merge -s sameautoforceconflict branchx
>
>
> Example results:
> $ git merge -s sameautoforceconflict branchx
> Merging:
> 11a99zz examplecommitb
> virtual branchx
> found 1 common ancestor(s):
> 22b88yy examplecommita
> Auto-merging examplepgm
> Merge made by recursive.
> examplepgm |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
> $git status
> examplepgm: needs merge
> # On branch branchx
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working 
> directory)
> #
> #       unmerged:   examplepgm
> #
> no changes added to commit (use "git add" and/or "git commit -a")
>
>
> v/r,
> Neal
>
> 
