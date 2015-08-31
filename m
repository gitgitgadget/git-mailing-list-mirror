From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v14 00/13] Port tag.c to use ref-filter.c
Date: Mon, 31 Aug 2015 08:50:58 +0200
Message-ID: <vpqvbbwhrxp.fsf@anie.imag.fr>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 08:51:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWIvw-0005l0-2d
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 08:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbbHaGvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 02:51:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43109 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476AbbHaGvH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 02:51:07 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t7V6ovFg029630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 31 Aug 2015 08:50:57 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7V6owZ0006751;
	Mon, 31 Aug 2015 08:50:58 +0200
In-Reply-To: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sat, 29 Aug 2015 19:42:04 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 31 Aug 2015 08:50:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7V6ovFg029630
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441608659.42922@2/UnVxRMq53aovVAq3ueLA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276849>

Karthik Nayak <karthik.188@gmail.com> writes:

> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 06d468e..1b48b95 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -149,6 +149,7 @@ Its first line is `contents:subject`, where subject is the concatenation
>  of all lines of the commit message up to the first blank line.  The next
>  line is 'contents:body', where body is all of the lines after the first
>  blank line.  Finally, the optional GPG signature is `contents:signature`.
> +The first `N` lines of the object is obtained using `contents:lines=N`.

"Finally" in the last line of the context is no longer accurate.

> +test_expect_success 'check `%(contents:lines=X)`' '
> +	cat >expect <<-\EOF &&
> +	master three
> +	side four
> +	odd/spot three
> +	double-tag Annonated doubly
> +	four four
> +	one one
> +	signed-tag A signed tag message
> +	three three
> +	two two
> +	EOF
> +	git for-each-ref --format="%(refname:short) %(contents:lines=1)" >actual &&
> +	test_cmp expect actual
> +'

Nit: I would find it more readable with an actual separator (anything
but a space) between %(refname) and %(contents).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
