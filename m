From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: Merge-Recursive Improvements
Date: Tue, 12 Feb 2008 18:03:00 -0500
Message-ID: <jwv3arxairx.fsf-monnier+gmane.comp.version-control.git@gnu.org>
References: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 00:03:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP4AJ-0000IM-8V
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 00:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbYBLXDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 18:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbYBLXDL
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 18:03:11 -0500
Received: from main.gmane.org ([80.91.229.2]:38870 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015AbYBLXDK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 18:03:10 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JP49a-0007Zv-43
	for git@vger.kernel.org; Tue, 12 Feb 2008 23:03:06 +0000
Received: from vpn-132-204-232-187.acd.umontreal.ca ([132.204.232.187])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Feb 2008 23:03:06 +0000
Received: from monnier by vpn-132-204-232-187.acd.umontreal.ca with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Feb 2008 23:03:06 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: vpn-132-204-232-187.acd.umontreal.ca
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:fvI8aVYLOCAnFc1XZ+kvK1yrfQA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73708>

> "ORIG_HEAD...MERGE_HEAD" diffs to see what was going on. I could use an
> external diff tool (yuck), but I would like to modify the conflict markers
> to resemble those of Perforce:

>>>>>>>> merge-base:file.txt
>   Original code.
>   ======= HEAD:file.txt
>   Head code.
>   ======= merge:file.txt
>   Merged code.
>   <<<<<<<

Having such 3-parts conflicts helps tremendously when you have to do
the merge by hand, so I'm 100% in favor of such a change.

BUT Please, please, pretty please, don't follow Perforce who blindly
disregards previous standards.  Instead use the format used by diff3
which has been there for ages:

   <<<<<<< foo
   original text
   ||||||| bar
   ancestor
   =======
   new text
   >>>>>>> baz

> Third, git doesn't appear to have any sense of context when performing a
> merge. Another contrived example which wouldn't be flagged as a merge
> conflict:

>   ptr = malloc(len); // Added in HEAD.
>   init();            // Included in merge-base.
>   ptr = malloc(len); // Added in "merge".

Yes, that's nasty.

> Fourth, git doesn't provide a mechanism for merges to ignore whitespace
> changes.

I can live with that.  As long as the conflict is clearly marked with
all 3 parts, I can use any external tool I want to resolve the conflict.


        Stefan
