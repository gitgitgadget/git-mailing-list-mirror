From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 01/10] Add support for -i/--interactive to git-clean
Date: Sun, 12 May 2013 18:54:37 +0200
Message-ID: <vpqvc6oi1f6.fsf@grenoble-inp.fr>
References: <cover.1368011946.git.worldhello.net@gmail.com>
	<cover.1368011946.git.worldhello.net@gmail.com>
	<ad26375dece854339d64dcb82c17f19f8edccf48.1368011946.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 12 18:54:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbZY2-0003D3-4l
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 18:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614Ab3ELQyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 12:54:54 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54264 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754293Ab3ELQyx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 12:54:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r4CGsa3D005293
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 12 May 2013 18:54:36 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UbZXi-0007NF-8P; Sun, 12 May 2013 18:54:38 +0200
In-Reply-To: <ad26375dece854339d64dcb82c17f19f8edccf48.1368011946.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Wed, 8 May 2013 19:38:46 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 12 May 2013 18:54:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4CGsa3D005293
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1368982480.88348@91swBd71AjUYXO7uzIAQqg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224052>

Jiang Xin <worldhello.net@gmail.com> writes:

> +			putchar('\n');
> +
> +			/* Display dels in "Would remove ..." format */
> +			for_each_string_list_item(item, &del_list) {
> +				qname = quote_path_relative(item->string, -1, &buf, *the_prefix);
> +				printf(_(msg_would_remove), qname);
> +			}
> +			putchar('\n');


> +		putchar('\n');
> +
> +		/* Display dels in "Would remove ..." format */
> +		for_each_string_list_item(item, &del_list) {
> +			qname = quote_path_relative(item->string, -1, &buf, *the_prefix);
> +			printf(_(msg_would_remove), qname);
> +		}
> +		putchar('\n');

These two pieces of code are surprisingly similar ... Shouldn't they be
factored into a small helper function?

> +		/* Confirmation dialog */
> +		printf(_("Remove ([y]es/[n]o/[e]dit) ? "));

To be more consistent with "git add -p", this should use [] instead of
(), and have no space before "?".

> +			die(_("clean.requireForce defaults to true and neither -i, -n nor -f given; "
>  				  "refusing to clean"));

That makes it a 85 characters message, and we usually break lines before
80. Adding \n after ";" (instead of a space) would be better IMO.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
