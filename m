From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] send-email: allow multiple emails using --cc --to and --bcc
Date: Thu, 28 May 2015 13:47:21 +0200
Message-ID: <vpqd21kvs8m.fsf@anie.imag.fr>
References: <1432809733-4321-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1432809733-4321-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 28 13:47:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxwHb-0006K8-VJ
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 13:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704AbbE1Lr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 07:47:28 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54101 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753518AbbE1Lr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 07:47:27 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4SBlJuf013294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 May 2015 13:47:20 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4SBlLWw007954;
	Thu, 28 May 2015 13:47:21 +0200
In-Reply-To: <1432809733-4321-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Thu, 28 May 2015 12:42:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 28 May 2015 13:47:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4SBlJuf013294
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433418442.98674@tyVMZDt6ezN2wZwgk1wx2A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270138>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -519,6 +519,12 @@ Result: OK
>  EOF
>  "
>  
> +replace_variable_fields () {
> +	sed	-e "s/^\(Date:\).*/\1 DATE-STRING/" \
> +		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
> +		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/"
> +}
> +
>  test_suppression () {
>  	git send-email \
>  		--dry-run \
> @@ -526,10 +532,7 @@ test_suppression () {
>  		--from="Example <from@example.com>" \
>  		--to=to@example.com \
>  		--smtp-server relay.example.com \
> -		$patches |
> -	sed	-e "s/^\(Date:\).*/\1 DATE-STRING/" \
> -		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
> -		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/" \
> +		$patches | replace_variable_fields \

I wouldn't insist on that, but this change would be better done in a
separate, preparatory patch (that would be PATCH 1/2, and the actual
code would be PATCH 2/2).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
