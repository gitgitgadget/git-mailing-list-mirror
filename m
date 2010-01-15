From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git push --track
Date: Fri, 15 Jan 2010 14:26:50 +0100
Message-ID: <vpq3a277b39.fsf@bauges.imag.fr>
References: <op.u6g8jnixg402ra@nb-04>
	<be6fef0d1001131727r128c7727td2b948018d308719@mail.gmail.com>
	<20100114070316.GC1528@rm.endoftheinternet.org>
	<7vr5ps5jx1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rudolf Polzer <divVerent@alientrap.org>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 14:27:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVmD6-0001uI-9F
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 14:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920Ab0AON11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 08:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752396Ab0AON11
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 08:27:27 -0500
Received: from mx1.imag.fr ([129.88.30.5]:51307 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752283Ab0AON11 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 08:27:27 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o0FDQOBt010481
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 15 Jan 2010 14:26:24 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NVmCQ-0007wu-Ur; Fri, 15 Jan 2010 14:26:50 +0100
In-Reply-To: <7vr5ps5jx1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 14 Jan 2010 15\:46\:50 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 15 Jan 2010 14:26:25 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o0FDQOBt010481
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1264166786.02003@FB1n4JaMzsJUuw7NjwyX0Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137066>

Junio C Hamano <gitster@pobox.com> writes:

> The small nit is that "branch -f --track me origin/me" will happily
> overwrite "me", even when your "me" is not up to date with "origin/me",
> losing commits.

And another issue is:

$ git branch -f --track my-branch origin/my-branch
fatal: Cannot force update the current branch.
$ git branch --track my-branch origin/my-branch
fatal: A branch named 'my-branch' already exists.

Actually, I just can't find a natural set of commands doing:

1. create a branch (git checkout -b)
2. work on it
3. send it upstream (git push)
4. set the upstream as tracking (???)

with the current version of Git. I just do 4. with $EDITOR
.git/config ...

> Perhaps we could teach "branch --track me origin/me" (i.e. no "-f") not to
> barf even when "me" exists, as long as "me" is a subset of "origin/me",
> and treat it as a request to re-configure the upstream information for the
> existing branch "me" and at the same time fast-forward it to
> "origin/me"?

+1, and in addition, allow doing this on the checkout branch if it
doesn't actually change the reference (i.e. touch .git/config, not
.git/refs/...).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
