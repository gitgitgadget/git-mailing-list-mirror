From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 12:58:22 +0200
Message-ID: <vpqbo9gqcvl.fsf@grenoble-inp.fr>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
	<1365887729-9630-4-git-send-email-artagnon@gmail.com>
	<vpq38us2oov.fsf@grenoble-inp.fr>
	<7vbo9g15po.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 12:58:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URh7N-0006Rk-Rx
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 12:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614Ab3DOK6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 06:58:33 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55806 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753420Ab3DOK6c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 06:58:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r3FAwLCI024441
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Apr 2013 12:58:23 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1URh78-0003iE-QW; Mon, 15 Apr 2013 12:58:22 +0200
In-Reply-To: <7vbo9g15po.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 15 Apr 2013 02:52:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 15 Apr 2013 12:58:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3FAwLCI024441
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1366628304.95367@8196CmKlXmxi8PmYPOKsxw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221221>

Junio C Hamano <gitster@pobox.com> writes:

> Yes, that is why I said for pull-merge, --authsquash is neutral-to-better
> and pull.autosquash is harmful.

To speak from my experience: I find myself typing "git stash && git pull
&& git stash pop" relatively often. Typical use-case: I start working on
something, a colleague works on the same thing and I need to see what he
did to continue. Probably not something so frequent for large projects,
but very frequent for small projects (e.g. writing a paper together with
a single .tex file and the deadline approaching). In this case, "git
pull --rebase" makes sense for advanced enough users, but newbies who
have been told "rebase is too dangerous for you, don't use it", it would
be cool to have --autostash too.

I tend to agree that pull.autostash is harmful. At least in its current
form, it is really too easy to overlook the "Please run 'git stash pop'
after commiting the conflict resolution." message:

<do some important changes>
$ git pull
<fix conflicts>
$ git status
<tells me to commit>
$ git commit
<WTF, where are my important changes?!?>

rebase wouldn't have this issue if "stash pop" is part of the sequence
to apply.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
