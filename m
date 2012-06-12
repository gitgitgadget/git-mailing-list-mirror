From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] add git credential login to remote mediawiki
Date: Tue, 12 Jun 2012 16:51:18 +0200
Message-ID: <vpq8vfsoa6x.fsf@bauges.imag.fr>
References: <1339512125-32761-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Javier Roucher <jroucher@gmail.com>
To: Javier.Roucher-Iglesias@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Tue Jun 12 16:52:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeSRt-0002cP-Fj
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 16:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294Ab2FLOvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 10:51:55 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33773 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752555Ab2FLOvy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 10:51:54 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5CEgMvA032025
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 12 Jun 2012 16:42:22 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SeSRD-0007MF-2i; Tue, 12 Jun 2012 16:51:19 +0200
In-Reply-To: <1339512125-32761-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
	(Javier Roucher-Iglesias's message of "Tue, 12 Jun 2012 16:42:05
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 12 Jun 2012 16:42:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5CEgMvA032025
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340116944.75011@vP8aD7X739NPDmyp3tKGxg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199797>

Javier.Roucher-Iglesias@ensimag.imag.fr writes:

>  # MediaWiki API instance, created lazily.
> +sub run_credential {

How is the code related to the comment right above?

> +	my $Prog = "git credential $op";
> +	open2 (*Reader, *Writer, $Prog);
> +	print Writer $msg;
> +	close (Writer);

No space before "(" for function calls (already mentionned twice).

>  my $mediawiki;

Didn't I already mention (twice?) that this declaration was meant to
stay right above mw_connect_maybe?

> +			run_credential("reject");
> +#			exit 1;

Do you, or do you not want to "exit 1". Either remove this, or uncomment
it.

>  sub mw_connect_maybe {
> +
>  	if ($mediawiki) {

Why do you add this blank line? (already mentionned)

> -	if ($wiki_login) {
> -		if (!$mediawiki->login({
> -			lgname => $wiki_login,
> -			lgpassword => $wiki_passwd,
> -			lgdomain => $wiki_domain,
> -		})) {
> -			print STDERR "Failed to log in mediawiki user \"$wiki_login\" on $url\n";
> -			print STDERR "(error " .
> -			    $mediawiki->{error}->{code} . ': ' .
> -			    $mediawiki->{error}->{details} . ")\n";
> -			exit 1;
> -		} else {
> -			print STDERR "Logged in with user \"$wiki_login\".\n";
> -		}
> -	}
> +	ask_credential();

This means you can't use the wiki anonymously anymore. This is an
unacceptable regression.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
