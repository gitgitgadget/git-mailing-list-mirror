From: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Subject: Re: [PATCH v10 3/4] add `config_set` API for caching config-like
 files
Date: Fri, 18 Jul 2014 11:40:07 +0200 (CEST)
Message-ID: <1849775492.2606791.1405676407530.JavaMail.zimbra@imag.fr>
References: <1405675142-20300-1-git-send-email-tanayabh@gmail.com> <1405675142-20300-4-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 11:40:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X84eL-0005tw-DU
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 11:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761342AbaGRJkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 05:40:16 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38813 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760988AbaGRJkO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 05:40:14 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6I9e7eG010387
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 18 Jul 2014 11:40:07 +0200
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6I9e8TF019901;
	Fri, 18 Jul 2014 11:40:08 +0200
In-Reply-To: <1405675142-20300-4-git-send-email-tanayabh@gmail.com>
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF30 (Linux)/8.0.6_GA_5922)
Thread-Topic: add `config_set` API for caching config-like files
Thread-Index: Uyx0splFQ/t7i447U8yQmR3X5qCKMQ==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 18 Jul 2014 11:40:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6I9e7eG010387
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1406281208.64449@9Yfs+hhf+reF9PdsSGRIow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253804>

----- Original Message -----
>  Documentation/technical/api-config.txt | 137 +++++++++++++++++
>  cache.h                                |  30 ++++
>  config.c                               | 263
>  +++++++++++++++++++++++++++++++++
>  3 files changed, 430 insertions(+)

I think the added call to git_config_clear() I proposed yesterday in setup_git_directory_gently_1 should be part of this patch (with the associated comment), just like this call:

> @@ -1707,6 +1967,9 @@ int git_config_set_multivar_in_file(const char
> *config_filename,
>  	lock = NULL;
>  	ret = 0;
>  
> +	/* Invalidate the config cache */
> +	git_config_clear();
> +
>  out_free:
>  	if (lock)
>  		rollback_lock_file(lock);

I have limited access to my email and no way to apply the patches today, so I can't do a detailed review. But other than the remark above, I guess the patch series is now all right and ready to cook in pu.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
