From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Proposal: create meaningful aliases for git reset's hard/soft/mixed
Date: Wed, 23 Nov 2011 09:49:13 +0100
Message-ID: <vpq4nxvusty.fsf@bauges.imag.fr>
References: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 09:49:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RT8WF-0003Bz-Ly
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 09:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586Ab1KWItU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 03:49:20 -0500
Received: from mx2.imag.fr ([129.88.30.17]:44415 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752340Ab1KWItT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 03:49:19 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id pAN8hxwb004620
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 23 Nov 2011 09:43:59 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RT8W1-0005tp-8o; Wed, 23 Nov 2011 09:49:13 +0100
In-Reply-To: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com>
	(Philippe Vaucher's message of "Wed, 23 Nov 2011 09:28:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 23 Nov 2011 09:43:59 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: pAN8hxwb004620
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1322642643.00925@YwcFMdcFKbTrKCHL0VuwsA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185827>

Philippe Vaucher <philippe.vaucher@gmail.com> writes:

> A lot of time when I want to use reset for smth else than "--hard" I
> have to go and look the documentation.

I have to agree with this, I took a lot of time to understand/memorize
the meaning of reset options.

> Optional: a new mode would be introduced for consistency:
> --worktree (or maybe --tree): only updates the worktree but not the index

That would be an alias for "git checkout <rev> -- path", right?

I don't really like this "there is more than one way to do it" in Git's
command-line, I think we should think very carefully before introducing
yet another instance of it.

> --keep could be removed in favor of an additional --safe flag

If you are to change the option names, then you should also make the
behavior safe by default:

* "git reset --all" = "git reset --keep"
* "git reset --all --force" = "git reset --hard"

With the current terminology, --hard has the advantage that it makes it
realatively clear how dangerous it is. Still, I've seen users losing
data because they did a "git reset --hard" with uncommited changes. Git
is safe by default most of the time, and "git reset --hard" is one
unfortunate exception (because it was there before --keep, people are
more used to it).

"git reset --all" would make it worse, because the option name is less
scary, people would be less reluctant to use it, and would get more
chance to lose data.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
