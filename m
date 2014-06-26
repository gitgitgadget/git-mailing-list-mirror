From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] imap-send.c: replace git_config with git_config_get_string
Date: Thu, 26 Jun 2014 18:50:22 +0200
Message-ID: <vpqbntfmx81.fsf@anie.imag.fr>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
	<1403520105-23250-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 18:51:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0Ct5-0003Ia-Kk
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 18:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756890AbaFZQu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 12:50:58 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52355 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756110AbaFZQu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 12:50:57 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s5QGoKdD020253
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 Jun 2014 18:50:20 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s5QGoMH6014870;
	Thu, 26 Jun 2014 18:50:22 +0200
In-Reply-To: <1403520105-23250-3-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 23 Jun 2014 03:41:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 26 Jun 2014 18:50:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s5QGoKdD020253
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1404406221.12515@9m0tym7OcmLO+FD608VOrA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252509>

Tanay Abhra <tanayabh@gmail.com> writes:

> +	if (!git_config_get_string("imap.user", &value))
> +		server.user = xstrdup(value);
> +	if (!git_config_get_string("imap.pass", &value))
> +		server.pass = xstrdup(value);
> +	if (!git_config_get_string("imap.port", &value))
> +		server.port = git_config_int("port", value);
> +	if (!git_config_get_string("imap.tunnel", &value))
> +		server.tunnel = xstrdup(value);
> +	if (!git_config_get_string("imap.authmethod", &value))
> +		server.auth_method = xstrdup(value);

Given this kind of systematic code, I find it very tempting to factor
this with a new helper function as

...
git_config_get_string_dup("imap.tunnel", &server.tunnel)
git_config_get_string_dup("imap.authmethod", &server.auth_method)

Is there any reason not to do so?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
