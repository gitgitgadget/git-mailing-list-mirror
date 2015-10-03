From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 7/9] ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
Date: Sat, 03 Oct 2015 14:08:06 +0200
Message-ID: <vpqio6o9mu1.fsf@grenoble-inp.fr>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
	<1443807546-5985-8-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 14:08:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiLbt-0003l9-Sa
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 14:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272AbbJCMIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 08:08:14 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53212 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154AbbJCMIN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 08:08:13 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t93C85cH006098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 3 Oct 2015 14:08:05 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t93C86CG003308;
	Sat, 3 Oct 2015 14:08:06 +0200
In-Reply-To: <1443807546-5985-8-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Fri, 2 Oct 2015 23:09:04 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 03 Oct 2015 14:08:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t93C85cH006098
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444478887.65378@BAt9SNYy1aJuCn7td26Wvw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278969>

Karthik Nayak <karthik.188@gmail.com> writes:

> diff --git a/ref-filter.c b/ref-filter.c
> index 099acd6..48b06e3 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1133,8 +1133,10 @@ static void populate_value(struct ref_array_item *ref)
>  				char buf[40];
>  
>  				if (stat_tracking_info(branch, &num_ours,
> -						       &num_theirs, NULL))
> +						       &num_theirs, NULL)) {
> +					v->s = xstrdup("[gone]");

I think just "[gone]" without the xstrdup is OK, and avoids leaking one
string.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
