From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] rebase -i: commit when continuing after "edit"
Date: Tue, 25 Sep 2007 18:04:54 +0200
Message-ID: <86ir5y689l.fsf@lola.quinscape.zz>
References: <20070923224502.GB7249@potapov> <Pine.LNX.4.64.0709240121080.28395@racer.site> <7vlkav71bv.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709251249450.28395@racer.site> <46F90C95.5060903@viscovery.net> <Pine.LNX.4.64.0709251439070.28395@racer.site> <46F91879.6030301@viscovery.net> <86ve9y6bvm.fsf@lola.quinscape.zz> <46F92F26.6050204@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 25 18:15:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaD4X-0007FB-IX
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 18:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695AbXIYQPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 12:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752727AbXIYQPd
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 12:15:33 -0400
Received: from main.gmane.org ([80.91.229.2]:60871 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397AbXIYQPc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 12:15:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IaD0H-0001iY-CF
	for git@vger.kernel.org; Tue, 25 Sep 2007 16:11:17 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Sep 2007 16:11:17 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Sep 2007 16:11:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:8sljOsUf+HapBDrfV4L1Qk0E7Xg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59145>

Johannes Sixt <j.sixt@viscovery.net> writes:

> David Kastrup schrieb:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>> I poked around a bit, but one major obstacle is that the assignments
>>> in $author_script are on separate lines, which you would have to
>>> splice into a single line before you can insert them in the eval.
>>
>> Hm?  Why?  Newlines separate assignments just as reliable as spaces
>> do.  They are primarily special to the tty as line separators, not the
>> shell as such.
>
> The task here is to have the assignments on the same line as the
> command at the end so that they are locally exported. Here we are
> inside an 'eval', and the new-lines *do* what their name suggest: make
> new lines.

The documentation to eval clearly states:

`eval'
          eval [ARGUMENTS]
     The arguments are concatenated together into a single command,
     which is then read and executed, and its exit status returned as
     the exit status of `eval'.  If there are no arguments or only
     empty arguments, the return status is zero.

So we are talking about a single command here.  However, we indeed get

$ eval "echo x
> y
> z"
x
bash: y: command not found
bash: z: command not found
$

Um, so I have been talking nonsense.  Does "the docs made me do it"
count as excuse?

-- 
David Kastrup
