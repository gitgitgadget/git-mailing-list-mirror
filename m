From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: unmerged files listed in the beginning of git-status
Date: Tue, 1 Sep 2009 21:40:08 +0200
Message-ID: <200909012140.08953.j6t@kdbg.org>
References: <20090901145213.GB4194@debian.b2j> <7vljkypqfi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 21:40:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiZDJ-0002Js-UF
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 21:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870AbZIATkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 15:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbZIATkK
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 15:40:10 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:56607 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751774AbZIATkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 15:40:09 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 70F861001C;
	Tue,  1 Sep 2009 21:40:09 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1EB5212219;
	Tue,  1 Sep 2009 21:40:09 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vljkypqfi.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127550>

On Dienstag, 1. September 2009, Junio C Hamano wrote:
> bill lam <cbill.lam@gmail.com> writes:
> > git-status show unmerged files
> > with a clause of explanation.  This is very helpful. However these
> > unmerged files are listed in the beginning and followed by modified
> > files,
>
> "git status" is preview of what git commit does.  The "Changes to be
> committed" section is given at the beginning of the output because it is
> the most important one.  But while reviewing the conflicts, you would want
> to notice conflicted paths more than what are already resolved and staged.
>
> It used to be that unmerged paths were mixed together with locally
> modified paths in the "Changed but not updated" list, after the "Changes
> to be committed" list.  This made the unmerged paths harder to spot than
> necessary.
>
> To remedy this, unmerged ones are now:
>
>  (1) placed in a new, separate section that appears only when there are
>      unmerged paths, to make the fact that there is something unusual
>      going on (i.e. conflicts) stand out; and
>
>  (2) the new section is given at the top of the status output to give
>      these unmerged paths more prominence.

But this is very inconvenient if you merge a branch that touched many files, 
of which only a few have conflicts. In this case, the unmerged entries are 
scrolled out of view. If you want to copy-paste them into a 'git add' command 
then (at least my) xterm (and Windows's CMD, BTW) keeps scrolling down to the 
command line, and since I cannot bulk-select all of them at once, I have to 
scroll up in order select any individual of them.

Note that I do not complain about the "out of view" part (because if a list is 
long there is inevitably something that becomes invisible), but about 
the "must scroll around" part.

> But unmerged entries are something you need to deal with _first_ before
> being able to go further, so in that sense it is more important than
> anything else in the traditional output.

This is actually an argument to place the unmerged entries *last* because this 
is what will be visible after 'git status' finished. Remember that we don't 
pass its output through the pager.

> In the output, "the most important part first" rule is unlikely to change,
> if only because this is what you are shown when committing in the editor,
> and even in 1.7.0 when "git status" stops being "git commit --dry-run"
> because we would still keep consistency of the two outputs,

Of course, this argument is irrelevant for the placement of the list of 
unmerged entries because by the time you enter the commit message editor, 
this list is empty.

-- Hannes
