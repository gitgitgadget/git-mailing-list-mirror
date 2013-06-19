From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] send-email: allow use of basic email list in --cc --to and --bcc
Date: Wed, 19 Jun 2013 13:51:02 +0200
Message-ID: <vpqwqpqjp3t.fsf@anie.imag.fr>
References: <1371641640-3897-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
To: Jorge-Juan.Garcia-Garcia@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Wed Jun 19 13:51:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpGv1-0002ZM-HS
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 13:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934159Ab3FSLvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 07:51:13 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59030 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933666Ab3FSLvM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 07:51:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5JBp0K3019901
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 19 Jun 2013 13:51:02 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UpGuk-0002NQ-9t; Wed, 19 Jun 2013 13:51:02 +0200
In-Reply-To: <1371641640-3897-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
	(Jorge-Juan Garcia-Garcia's message of "Wed, 19 Jun 2013 13:34:00
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 19 Jun 2013 13:51:07 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228392>

Jorge-Juan.Garcia-Garcia@ensimag.imag.fr writes:

> Changes since v1:
> [...]
>  - did not change the two regexp into one, because it's faster with two

(I find it strange to describe non-change in a list of changes)

I don't think speed is an argument here: it's a one-time operation and
will be instantaneous for the user in any case.

> +sub split_emails {
> +    my ($emails) = @_;
> +    my @split_list;
> +    if ($emails =~ /,/) {
> +	@split_list = split(/,/, $emails);
> +    } else {
> +	@split_list = $emails;
> +    }

Do you need this "if"? Wouldn't split do the right thing if $emails does
not contain comma?

> +    # Removal of unwanted spaces
> +    for (my $j = 0; $j <= $#split_list; $j++) {

Sounds very un-perl-ish. Something like this maybe?

foreach $email (@emails) {
	$email =~ s/^\s+|\s+$//;
}

> +    return @split_list;
> +}

This is indented with tab/spaces mix. Please, use tabs only in Git's
source.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
