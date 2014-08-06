From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v8 0/8] Rewrite `git_config()` using config-set API
Date: Wed, 06 Aug 2014 17:26:29 +0200
Message-ID: <vpqy4v1vdui.fsf@anie.imag.fr>
References: <1407336792-16962-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 17:26:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF36x-0006kX-1M
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 17:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164AbaHFP0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 11:26:39 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42248 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754092AbaHFP0i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 11:26:38 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s76FQRpN003886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 Aug 2014 17:26:27 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s76FQT3b024807;
	Wed, 6 Aug 2014 17:26:29 +0200
In-Reply-To: <1407336792-16962-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Wed, 6 Aug 2014 07:53:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 06 Aug 2014 17:26:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s76FQRpN003886
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407943591.2746@wm5q59Pa6ssMUNZ/5+RuWA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254866>

Tanay Abhra <tanayabh@gmail.com> writes:

> --- a/cache.h
> +++ b/cache.h
> @@ -1406,8 +1406,14 @@ extern int git_config_get_bool(const char *key, int *dest);
[...]
> +struct key_value_info {
> +	const char *filename;
> +	int linenr;
> +};
[...]
> diff --git a/config.c b/config.c
> index cf9124f..427850a 100644
> --- a/config.c
> +++ b/config.c
> @@ -1224,11 +1224,6 @@ int git_config_with_options(config_fn_t fn, void *data,
>  	return ret;
>  }
>  
> -struct key_value_info {
> -	const char *filename;
> -	int linenr;
> -};
> -

Why is this needed? Are you now using key_value_info outside config.c?
Or is it a leftover from a previous experiment?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
