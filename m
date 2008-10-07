From: Jeff Kowalczyk <jtk@yahoo.com>
Subject: Re: Repairing fatal: ref HEAD is not a symbolic ref (git checkout of svn remote)
Date: Tue, 07 Oct 2008 12:49:34 -0400
Message-ID: <pan.2008.10.07.16.49.29.153703@yahoo.com>
References: <pan.2008.10.06.14.00.57.104051@yahoo.com> <20081006140243.GB8203@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 07 18:51:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnFmA-0007IJ-Mq
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 18:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313AbYJGQt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 12:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756048AbYJGQt4
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 12:49:56 -0400
Received: from main.gmane.org ([80.91.229.2]:39317 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755701AbYJGQty (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 12:49:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KnFkp-0006GZ-KM
	for git@vger.kernel.org; Tue, 07 Oct 2008 16:49:47 +0000
Received: from rrcs-208-125-175-153.nys.biz.rr.com ([208.125.175.153])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Oct 2008 16:49:47 +0000
Received: from jtk by rrcs-208-125-175-153.nys.biz.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Oct 2008 16:49:47 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: rrcs-208-125-175-153.nys.biz.rr.com
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97726>

On Mon, 06 Oct 2008 07:02:43 -0700, Shawn O. Pearce wrote:

> Jeff Kowalczyk <jtk@yahoo.com> wrote:
>> To test a particular upstream revision, on a git svn remote checkout (i.e.
>> branches/1.2, 76c7af2...), I checked out the equivalent of HEAD^^ (git
>> checkout 4a3d99c0c9).
>> 
>> Now back at the branch tip, I get fatal: ref HEAD is not a symbolic ref
>> on git svn rebase: 
>> 
>> (4a3d99c...) $ git checkout 76c7af2
>> HEAD is now at 76c7af2... Minor changes to CONTRIBUTORS
>> (76c7af2...) $ git svn rebase
>> fatal: ref HEAD is not a symbolic ref Current branch HEAD is up to date.
>> Segmentation fault
>> 
>> How can I manually correct ref HEAD?
> 
> git checkout whateverbranchyouwereonbefore
> git svn rebase

Thanks, and the other svn remotes are working fine. I still have the
problem on the svn remote 'branches/1.2'. The following illustrates:

  (1.2_mybranch) $ git checkout 1.2
  Note: moving to "1.2" which isn't a local branch
  If you want to create a new branch from this checkout, you may do so
  (now or later) by using -b with the checkout command again. Example:
    git checkout -b <new_branch_name>
  HEAD is now at 76c7af2... Minor changes to CONTRIBUTORS

  (76c7af2...) $ git svn fetch
  	M	CONTRIBUTORS
  	M	LedgerSMB/AM.pm
  r2353 = ddd452af128f9b4698a1c1d6cc7fe2f23a0e6c90 (1.2)
  	M	LedgerSMB/AM.pm
  r2354 = fc6857004eeabf6963a9b2856f51db8842c00b70 (1.2)
  Segmentation fault

  (fc68570...) $ git checkout 1.2_print_pdf_default 
  Previous HEAD position was fc68570... (commit message snip)
  Switched to branch "1.2_print_pdf_default"

  (1.2_print_pdf_default) $ git svn rebase
  First, rewinding head to replay your work on top of it...
  Applying: naive replacement to option selected value="pdf" where PDF is format option,
  Segmentation fault

  (76c7af2...) $ git svn rebase
  fatal: ref HEAD is not a symbolic ref
  First, rewinding head to replay your work on top of it...
  Fast-forwarded HEAD to refs/remotes/1.2.
  Segmentation fault


This last git svn rebase on 'branches/1.2' (whether it's correct procedure
or not for a svn remote) used to work without the error until I issued
that one command (git checkout 4a3d99c0c9).

Thanks for any suggestions.
