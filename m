From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 3/8] branch: roll show_detached HEAD into regular ref_list
Date: Sun, 20 Sep 2015 21:11:48 +0200
Message-ID: <vpqmvwggb2j.fsf@anie.imag.fr>
References: <1442772627-25421-1-git-send-email-Karthik.188@gmail.com>
	<1442772627-25421-4-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 20 21:12:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zdk1u-0006le-UJ
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 21:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755378AbbITTMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2015 15:12:01 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42514 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755298AbbITTMA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2015 15:12:00 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8KJBjFK006964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 20 Sep 2015 21:11:45 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8KJBmLv009325;
	Sun, 20 Sep 2015 21:11:48 +0200
In-Reply-To: <1442772627-25421-4-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sun, 20 Sep 2015 23:40:22 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 20 Sep 2015 21:11:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8KJBjFK006964
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443381107.65231@EEviVG+TpY7PS5oYtwjqvQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278259>

Karthik Nayak <karthik.188@gmail.com> writes:

> @@ -681,14 +684,12 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
>  
>  	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
>  
> -	detached = (detached && (kinds & REF_LOCAL_BRANCH));
> -	if (detached && match_patterns(pattern, "HEAD"))
> -		show_detached(&ref_list, maxwidth);
> -
>  	for (i = 0; i < ref_list.index; i++) {
> -		int current = !detached &&
> -			(ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
> +		int current = !detached && (ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
>  			!strcmp(ref_list.list[i].name, head);
> +		/*  If detached the first ref_item is the current ref */

This relies on the fact that sorting (qsort above) did not move HEAD
from its first position. This is OK, as we don't have a --sort option
yet. Good.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
