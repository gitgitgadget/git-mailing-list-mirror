From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v12 10/13] tag.c: use 'ref-filter' data structures
Date: Wed, 19 Aug 2015 16:56:15 +0200
Message-ID: <vpqzj1n2upc.fsf@anie.imag.fr>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
	<1439923052-7373-11-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 16:56:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS4mv-0004ey-IL
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 16:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbbHSO4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 10:56:21 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50605 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753386AbbHSO4U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 10:56:20 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t7JEuEYN008724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 19 Aug 2015 16:56:14 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7JEuFgm020681;
	Wed, 19 Aug 2015 16:56:15 +0200
In-Reply-To: <1439923052-7373-11-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Wed, 19 Aug 2015 00:07:29 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 19 Aug 2015 16:56:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7JEuEYN008724
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1440600974.98545@Pxc9XGOFxY832oLWfu7Law
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276179>

Karthik Nayak <karthik.188@gmail.com> writes:

> This is a temporary step before porting 'tag.c' to use 'ref-filter'
> completely. As this is a temporary step, most of the code
> introduced here will be removed when 'tag.c' is ported over to use
> 'ref-filter' APIs

If you resend: missing '.' at the end of sentence.

> -	if (lines != -1)
> +	if (filter.lines != -1)
>  		die(_("-n option is only allowed with -l."));
> -	if (with_commit)
> +	if (filter.with_commit)
>  		die(_("--contains option is only allowed with -l."));
> -	if (points_at.nr)
> +	if (filter.points_at.nr)
>  		die(_("--points-at option is only allowed with -l."));

It may make sense to factor these checks into a function like

  void check_filter_consistancy(struct ref_filter *filter)

in ref-filter.c, since for-each-ref, branch and tag will eventually have
the same set of constraints on the options.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
