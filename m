From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 1/8] branch: refactor width computation
Date: Sun, 13 Sep 2015 13:51:53 +0200
Message-ID: <vpqio7ev8o6.fsf@anie.imag.fr>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
	<1442129035-31386-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 13:52:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zb5pP-0006zL-N0
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 13:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbbIMLwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 07:52:09 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40588 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431AbbIMLwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 07:52:08 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t8DBpq64016345
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 13 Sep 2015 13:51:52 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8DBprRd003705;
	Sun, 13 Sep 2015 13:51:53 +0200
In-Reply-To: <1442129035-31386-2-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sun, 13 Sep 2015 12:53:48 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 13 Sep 2015 13:51:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8DBpq64016345
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1442749914.3482@XSp4muk90GwMkn54pbppLw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277774>

Karthik Nayak <karthik.188@gmail.com> writes:

> @@ -667,26 +675,22 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
>  			clear_commit_marks(item->commit, ALL_REV_FLAGS);
>  		}
>  		clear_commit_marks(filter, ALL_REV_FLAGS);
> -
> -		if (verbose)
> -			ref_list.maxwidth = calc_maxwidth(&ref_list);
>  	}
> +	if (verbose)
> +		maxwidth = calc_maxwidth(&ref_list, strlen(remote_prefix));

I don't understand this hunk. To give a bit more context, the closing
brace corresponds to:

	if (merge_filter != NO_FILTER) {

Hence this patch gets the two lines out of this "if". Actually, I don't
understand how it could work previously. Wasn't this "calc_maxwidth"
needed regardless of merge_filter from the beginning?

In any case, that remark is not an objection on your patch, but I'd like
to understand.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
