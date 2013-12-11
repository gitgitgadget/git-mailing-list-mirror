From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [Question] Git recovery with HEAD commit broken
Date: Wed, 11 Dec 2013 16:01:48 +0100
Message-ID: <vpqzjo7whwj.fsf@anie.imag.fr>
References: <CAP9B-Q=ARp00Bj5zJ0J=3qv9R16YGu5AZgLpqoO0y+cY1at1Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Wang Shilong <wangsl.fnst@cn.fujitsu.com>
To: Shilong Wang <wangshilong1991@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 11 16:02:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqlIc-0006OR-5C
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 16:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400Ab3LKPCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 10:02:01 -0500
Received: from mx1.imag.fr ([129.88.30.5]:45244 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350Ab3LKPCA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 10:02:00 -0500
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id rBBF1lAa031980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Dec 2013 16:01:47 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id rBBF1mZa019500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 11 Dec 2013 16:01:49 +0100
In-Reply-To: <CAP9B-Q=ARp00Bj5zJ0J=3qv9R16YGu5AZgLpqoO0y+cY1at1Zw@mail.gmail.com>
	(Shilong Wang's message of "Wed, 11 Dec 2013 22:38:37 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 11 Dec 2013 16:01:48 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: rBBF1lAa031980
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1387378911.3227@0H30xolmgfeXl9gytnH16Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239203>

Shilong Wang <wangshilong1991@gmail.com> writes:

> A power off cause my top commit broken, and then git
> branch/log/reflog..etc won't work.

With a bit of luck, the reflog actually contain useful information. Look
at .git/logs/HEAD (or refs/heads/* instead of HEAD for branches'
reflog). It's a human-readable text format. You should be able to walk
up the history looking for a good commit.

> I do a hack that

Before anything else: do a backup of your full repository while it's
still time.

> i change the HEAD commit to the one that i can make sure is right,

(don't forget to run "git fsck" to make sure that not only the commit
but also its ancestry is right).

> In fact, i hope git fsck can fix up such problems(maybe can backup top
> commit for example)...

Not as far as I know. But "git fsck" has a --lost-found option that can
help recovering unreachable (dangling) commits.

You may have a look at http://hackage.haskell.org/package/git-repair but
I do not think it would solve your particular case.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
