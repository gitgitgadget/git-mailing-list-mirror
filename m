From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv2 1/2] wt-status: better advices for git status
Date: Sun, 27 May 2012 15:10:47 +0200
Message-ID: <vpq8vgdlqg8.fsf@bauges.imag.fr>
References: <1337852264-32619-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338035905-24166-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Sun May 27 15:11:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYdFX-0000iP-VP
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 15:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617Ab2E0NLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 09:11:04 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41239 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975Ab2E0NKx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 09:10:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4RD2euI011380
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 27 May 2012 15:02:40 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SYdFA-0007kj-Jk; Sun, 27 May 2012 15:10:48 +0200
In-Reply-To: <1338035905-24166-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	(Kong Lucien's message of "Sat, 26 May 2012 14:38:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 27 May 2012 15:02:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4RD2euI011380
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1338728562.19869@2DBHZiXtxmXAdyfnmM/6Bw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198590>

Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:

> +	const char *git_dir = getenv(GIT_DIR_ENVIRONMENT);

get_git_dir() would do the same more cleanly I think. And you don't
actually need it because git_path("...") does what you're doing with
mkpath already.

> +		it = &(s->change.items[i]);
> +		d = it->util;

Isn't it a complex way to say

                d = s->change.items[i].util

?

> +				status_printf_ln(s, c, _("You are currently editing in a rebase progress."));

I find the wording strange.

"You are currently editing a commit during a rebase"

?

> +	wt_status_print_in_progress(s);
> +

I think this deserves several functions (e.g. one for rebase in
progress, one for bisect, ...). The one you have is already rather long,
and may get longer when you start using the advice mechanism.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
