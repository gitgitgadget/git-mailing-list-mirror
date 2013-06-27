From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] pull: require choice between rebase/merge on non-fast-forward pull
Date: Fri, 28 Jun 2013 00:16:53 +0200
Message-ID: <vpqwqpf9p2i.fsf@anie.imag.fr>
References: <20130522115042.GA20649@inner.h.apk.li>
	<7v4ndukhx0.fsf@alter.siamese.dyndns.org>
	<20130523090657.GB23933@inner.h.apk.li>
	<CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
	<7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	John Keeping <john@keeping.me.uk>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 00:17:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsKVd-0007uJ-2I
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 00:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895Ab3F0WR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 18:17:28 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56056 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752033Ab3F0WR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 18:17:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5RMGqSD016246
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 28 Jun 2013 00:16:52 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UsKUo-0007oj-1J; Fri, 28 Jun 2013 00:16:54 +0200
In-Reply-To: <7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 27 Jun 2013 12:48:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 28 Jun 2013 00:16:55 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229162>

Junio C Hamano <gitster@pobox.com> writes:

> Because letting a trivial merge automatically handled by Git is so
> easy with "git pull", a person who is new to Git may not realize
> that the project s/he is interacting with may prefer "rebase"
> workflow.  Add a safety valve to fail "git pull" that is not a
> fast-forward until/unless the user expressed her preference between
> the two.

IMHO, that would be terrible for beginners.

My experience with many beginners/students is: they run "git pull" to
get changes from their co-workers, don't read the messages. When there's
no conflict, it's OK, Git creates the merge commit and they continue
working. When there are conflicts, they fix it (or not), and forget to
commit, continue working, and commit when they really need to, later.
That's bad: mixing merges with actual changes is terrible. But that
works. And that's a very common mistake in my experience :-(.

Now, give the same user as above "git pull --rebase". rebase may stop
because of conflicts, the user may fix it, but then if the user
continues working, he's on a detached HEAD with a rebase ongoing. Some
of the changes went away, they may come back one day if the user runs
"git rebase --continue".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
