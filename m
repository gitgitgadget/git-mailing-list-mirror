From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: thoughts on a possible "pre-upload" hook
Date: Tue, 22 Sep 2009 18:05:33 +0200
Message-ID: <vpqd45jvub6.fsf@bauges.imag.fr>
References: <2e24e5b90909220320rbd5fd1l40c7898656445232@mail.gmail.com>
	<867hvr2cms.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Tue Sep 22 18:09:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mq7vK-0006nd-0y
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 18:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbZIVQIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 12:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756501AbZIVQIw
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 12:08:52 -0400
Received: from imag.imag.fr ([129.88.30.1]:55773 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756069AbZIVQIv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 12:08:51 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n8MG5YGJ007702
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 22 Sep 2009 18:05:34 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Mq7rx-0001LK-PH; Tue, 22 Sep 2009 18:05:33 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Mq7rx-0006kF-No; Tue, 22 Sep 2009 18:05:33 +0200
In-Reply-To: <867hvr2cms.fsf@blue.stonehenge.com> (Randal L. Schwartz's message of "Tue\, 22 Sep 2009 09\:00\:11 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 22 Sep 2009 18:05:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128945>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Sitaram" == Sitaram Chamarty <sitaramc@gmail.com> writes:
>
> Sitaram> Hello,
> Sitaram> As git is used more and more in corporate-type environments, at some
> Sitaram> point it becomes convenient to have *branches* (or more accurately,
> Sitaram> refs) that are not readable.  The simplest way to do this (from git's
> Sitaram> point of view) is to allow a "pre-upload" hook, rather like the
> Sitaram> "pre-receive" hook or "update" hook.
>
> It would seem that you would need to do this even before the commit.  So
> you're looking for the pre-commit hook.  Otherwise, the commit is invalid,
> because it doesn't accurately represent everything it references.  And the
> commit is the unit of transfer between repos.

I don't get the point. The OP's question is not about commiting, but
about preventing a branch from being fetched. So, right before sending
the commits in a branch, the server would execute a hook, and fail if
it's not allowed.

But that alone would make it rather painfull for the user : "git
clone" would fail if any branch in the repository is not readable, for
example.

Also, don't forget that branches are just references, which means that
if you prevent reference A from being uploaded, then another reference
B may point to the same commits as A, and then you can bypass the
safety hook on A by using B.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
