From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] git-blame.el: show the when, who and what in the minibuffer.
Date: Mon, 11 Feb 2008 16:20:21 +0100
Message-ID: <87ve4vr03u.fsf@lysator.liu.se>
References: <87ve4vo7g4.dancerj%dancer@netfort.gr.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Xavier Maillard <zedek@gnu.org>
To: git@vger.kernel.org, Junichi Uekawa <dancer@netfort.gr.jp>
X-From: git-owner@vger.kernel.org Mon Feb 11 16:20:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOaSh-0005oj-Vs
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 16:20:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926AbYBKPUV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2008 10:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753860AbYBKPUT
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 10:20:19 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:50991 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873AbYBKPUQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2008 10:20:16 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 5A4FE200A1A5;
	Mon, 11 Feb 2008 16:20:15 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 15675-01-61; Mon, 11 Feb 2008 16:20:14 +0100 (CET)
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id C0450200A24D;
	Mon, 11 Feb 2008 16:20:14 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 9FCCC7B4077; Mon, 11 Feb 2008 16:20:21 +0100 (CET)
In-Reply-To: <87ve4vo7g4.dancerj%dancer@netfort.gr.jp> (Junichi Uekawa's message of "Tue\, 12 Feb 2008 00\:00\:07 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73539>

Junichi Uekawa <dancer@netfort.gr.jp> writes:

> Change the default operation to show 'when (day the commit was made),
> who (who made the commit), what (what the commit log was)' in the
> minibuffer instead of SHA1 and title of the commit log.
>
> Since the user may prefer other displaying options, it is made as a
> user-configurable option.

Good idea.

> ---
>  contrib/emacs/git-blame.el |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
> index bb671d5..99e2b6f 100644
> --- a/contrib/emacs/git-blame.el
> +++ b/contrib/emacs/git-blame.el
> @@ -105,6 +105,13 @@ selected element from l."
>       (setq ,l (remove e ,l))
>       e))
> =20
> +(defvar git-blame-log-oneline-format
> +  "format:[%cr] %cn: %s"
> +  "*Formatting option used for describing current line in the minibu=
ffer.
> +
> +This option is used to pass to git log --pretty=3D command-line opti=
on,=20
> +and describe which commit the current line was made.")
> +
>  (defvar git-blame-dark-colors
>    (git-blame-color-scale "0c" "04" "24" "1c" "2c" "34" "14" "3c")
>    "*List of colors (format #RGB) to use in a dark environment.
> @@ -371,7 +378,8 @@ See also function `git-blame-mode'."
>  (defun git-describe-commit (hash)
>    (with-temp-buffer
>      (call-process "git" nil t nil
> -                  "log" "-1" "--pretty=3Doneline"
> +                  "log" "-1"=20
> +		  (concat "--pretty=3D" git-blame-log-oneline-format)
>                    hash)
>      (buffer-substring (point-min) (1- (point-max)))))

--=20
David K=C3=A5gedal
