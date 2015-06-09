From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/4] bisect: replace hardcoded "bad|good" by variables
Date: Tue, 09 Jun 2015 08:45:03 +0200
Message-ID: <vpqtwuhl6s0.fsf@anie.imag.fr>
References: <1433794930-5158-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433794930-5158-2-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com
To: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 09 08:45:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2DHf-00074Q-Rv
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 08:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749AbbFIGpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 02:45:12 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37790 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753348AbbFIGpK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 02:45:10 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t596j2bh029434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Jun 2015 08:45:02 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t596j3EI017562;
	Tue, 9 Jun 2015 08:45:03 +0200
In-Reply-To: <1433794930-5158-2-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	(Antoine Delaite's message of "Mon, 8 Jun 2015 22:22:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 09 Jun 2015 08:45:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t596j2bh029434
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434437106.15591@ZVI6vN2oBqJqq5BSNjSYkA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271147>

Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:

> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -32,6 +32,8 @@ OPTIONS_SPEC=
>  
>  _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
>  _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
> +NAME_BAD="bad"
> +NAME_GOOD="good"

I would have written

NAME_NEW=bad
NAME_OLD=good

"old/new" are the generic wording, so I think it would make more sense
for the codebase to use it when we don't hardcode old/new.

(and the double-quotes are not needed)

> @@ -249,8 +254,8 @@ bisect_state() {
>  			bisect_write "$state" "$rev"
>  		done
>  		check_expected_revs $hash_list ;;
> -	*,bad)
> -		die "$(gettext "'git bisect bad' can take only one argument.")" ;;
> +	*,"$NAME_BAD")
> +		die "$(gettext "'git bisect $NAME_BAD' can take only one argument.")" ;;

As Junio mentionned, you'll need an eval_gettext here.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
