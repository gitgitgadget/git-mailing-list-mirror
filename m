From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv4 1/3] wt-status.*: better advices for git status added
Date: Thu, 31 May 2012 08:29:14 +0200
Message-ID: <vpqipfcsw1x.fsf@bauges.imag.fr>
References: <1338226598-16056-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu May 31 08:29:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZysu-0008Fd-Mz
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 08:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598Ab2EaG3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 02:29:20 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47030 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751518Ab2EaG3U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 02:29:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q4V6KnX2007755
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 31 May 2012 08:20:49 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SZysl-0002D5-2C; Thu, 31 May 2012 08:29:15 +0200
In-Reply-To: <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	(Kong Lucien's message of "Wed, 30 May 2012 15:23:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 31 May 2012 08:20:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4V6KnX2007755
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339050051.80503@lnaKKPCp08caLtgzUmF4Hw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198861>

Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:

> The new messages are not shown when using options such as
> -s or --porcelain.The messages about the current

space between . and The (normally, 2 spaces in english).

> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -176,6 +179,7 @@ advice.*::
>  		Advice shown when you used linkgit:git-checkout[1] to
>  		move to the detach HEAD state, to instruct how to create
>  		a local branch after the fact.
> +
>  --

Why add a blank line here?

> +	if (state->merge_in_progress) {
> +		wt_status_merge_in_progress(s, state, state_color);
> +	}
> +	else if (state->am_in_progress) {
> +		wt_status_am_in_progress(s, state, state_color);
> +	}
> +
> +	else if (state->rebase_in_progress || state->rebase_interactive_in_progress) {
> +		wt_status_rebase_in_progress(s, state, state_color);
> +	}
> +
> +	else if (state->cherry_pick_in_progress) {
> +		wt_status_cherry_pick_in_progress(s, state, state_color);
> +	}
> +
> +	if (state->bisect_in_progress) {
> +		wt_status_bisect_in_progress(s, state, state_color);
> +	}

Do these have to be if/else if/... ?

In most cases, the user will have only one of these at the same time,
but in the few cases where there's, e.g. a rebase during a bisect or so,
I think it makes more sense to show both advices to the user (probably
as a sign that something's wrong).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
