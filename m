From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/6] gitweb: Simplify git_diff_print
Date: Sun, 06 Aug 2006 12:22:48 +0200
Organization: At home
Message-ID: <eb4fs7$i7i$1@sea.gmane.org>
References: <200608060206.49086.jnareb@gmail.com> <200608060211.38604.jnareb@gmail.com> <7v8xm2b4g3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Aug 06 12:22:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9fm7-000382-AI
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 12:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWHFKWV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 06:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWHFKWV
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 06:22:21 -0400
Received: from main.gmane.org ([80.91.229.2]:20421 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750868AbWHFKWU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Aug 2006 06:22:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G9flr-00035C-0i
	for git@vger.kernel.org; Sun, 06 Aug 2006 12:22:11 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Aug 2006 12:22:10 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Aug 2006 12:22:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24971>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Copy to temporaty file more directly, not using temporary variable @file.
>> Use list form of open for diff invocation (we cannot use git-diff because
>> first it doesn't support -L/--label option, and we cannot generate diff
>> between /dev/null and blob given by it's sha1 identifier). 
>>
>> Use "local $/ = undef;" for (temporary) slurp mode.
>>
>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> 
> I think this part of the gitweb code predates the git-diff
> support by the core level.  If I recall correctly, back then we
> did not even have "git-diff-{tree,files,index}" when this part
> was written.
> 
> I think you could use "git-diff $from $to" instead of using
> temporary files and running /usr/bin/diff on it with today's
> git.  Which is a big win from both security and ease of
> administration point of view.  Not having to write anything into
> temporary file from gitweb.cgi means you do not have to worry
> about stray gitweb process leaving temporary files dangling
> behind, for example.

If I remember gitweb code correctly, diff to /dev/null is called
_only_ in commitdiff, where we can use git-diff -p to generate patch
directly, instead of generating difftree and calling diff on entries.

Still it would be nice if git-diff could diff between blob and arbitrary
file on filesystem (including /dev/null), and acquired -L/--label option.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
