From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/5 v2] merge-recursive: porcelain messages for checkout
Date: Tue, 15 Jun 2010 14:36:12 +0200
Message-ID: <vpqr5k8zd4z.fsf@bauges.imag.fr>
References: <1276604576-28092-1-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276604576-28092-2-git-send-email-diane.gasselin@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 15 14:36:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOVNS-0004Ac-Vp
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 14:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522Ab0FOMgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 08:36:15 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35638 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961Ab0FOMgO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 08:36:14 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o5FCSCic008447
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 15 Jun 2010 14:28:12 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OOVNE-0002ye-V2; Tue, 15 Jun 2010 14:36:12 +0200
In-Reply-To: <1276604576-28092-2-git-send-email-diane.gasselin@ensimag.imag.fr> (Diane Gasselin's message of "Tue\, 15 Jun 2010 14\:22\:52 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 15 Jun 2010 14:28:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5FCSCic008447
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1277209692.64912@Fp4fXthuGeNbgCRQ7ybPHQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149179>

Diane Gasselin <diane.gasselin@ensimag.imag.fr> writes:

> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -372,6 +372,7 @@ static int merge_working_tree(struct checkout_opts *opts,
>  		topts.src_index = &the_index;
>  		topts.dst_index = &the_index;
>  
> +		topts.msgs = get_porcelain_error_msgs("checkout");
>  		topts.msgs.not_uptodate_file = "You have local changes to '%s'; cannot switch branches.";

It's nice to get accurate messages for all cases, but then why do you
keep the special-case for not_uptodate_file? If there's a good reason
for it, a comment in the code would be welcome.

> +	/* would_overwrite */
> +	msgs.would_overwrite = malloc(sizeof(char) * 72);
> +	sprintf((char *)msgs.would_overwrite,
> +		"Your local changes to '%%s' would be overwritten by %s.  Aborting.",
> +		cmd);

This yields:

  Your local changes to 'foo' would be overwritten by checkout.  Aborting.

I tend to prefer Junio's wording:

  You have local changes to 'foo'; cannot switch branches.

--
Matthieu Moy
http://www-verimag.imag.fr/~moy/
