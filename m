From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC][GSoC] make "git diff --no-index $directory $file" DWIM better.
Date: Sun, 15 Mar 2015 18:30:39 +0100
Message-ID: <vpq1tkq5fsw.fsf@anie.imag.fr>
References: <CAHLaBN+93mp6PQmtfjOHSvfW7iwDXwPitGQ5W1am9KBm9EZV2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Yurii Shevtsov <ungetch@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 18:31:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXCNe-0004gt-J1
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 18:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbbCORao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 13:30:44 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49810 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485AbbCORao (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 13:30:44 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t2FHUbmq030701
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 15 Mar 2015 18:30:37 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t2FHUd7X012235;
	Sun, 15 Mar 2015 18:30:39 +0100
In-Reply-To: <CAHLaBN+93mp6PQmtfjOHSvfW7iwDXwPitGQ5W1am9KBm9EZV2Q@mail.gmail.com>
	(Yurii Shevtsov's message of "Sun, 15 Mar 2015 17:35:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 15 Mar 2015 18:30:37 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t2FHUbmq030701
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1427045438.98905@m5wYsXrmGz7axPP/CUCLRQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265499>

Yurii Shevtsov <ungetch@gmail.com> writes:

> Changes 'git diff --no-index $directory $file' behaviour.
> Now it is transformed to 'git diff --no-index $directory/&file $file'

I guess the & should be a $.

> instead of throwing an error.

Try to insist on _why_ you did this more than what it does in the commit
message.

> Signed-off-by: Yurii Shevtsov <ungetch <at> gmail.com>

Please, use a real email adress, not a mangled one.

> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -97,8 +97,25 @@ static int queue_diff(struct diff_options *o,
>         if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
>                 return -1;
>
> -       if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
> -               return error("file/directory conflict: %s, %s", name1, name2);

I'm surprised to see this error message totally go away. The idea of the
microproject was to DWIM (do what I mean) better, but the dwim should
apply only when $directory/$file actually exists. Otherwise, the error
message should actually be raised.

> --
>
> I hope I understood task correct. I think this patch requires writing
> additional tests, so that's what I'm going to do now.

This text should go between the --- and the diffstat, not at the end of
the message.

And yes, this deserves tests ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
