From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Thu, 26 Jun 2014 18:43:21 +0200
Message-ID: <vpqha37mxjq.fsf@anie.imag.fr>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>
	<1403518300-23053-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 18:43:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0Cm6-000747-No
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 18:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbaFZQnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 12:43:47 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52207 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753575AbaFZQnq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 12:43:46 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s5QGhQNb016186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 Jun 2014 18:43:26 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s5QGhLAP014786;
	Thu, 26 Jun 2014 18:43:21 +0200
In-Reply-To: <1403518300-23053-3-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 23 Jun 2014 03:11:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 26 Jun 2014 18:43:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s5QGhQNb016186
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1404405809.98642@5JLjn5egILeNJ3HIxi6RXw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252507>

Tanay Abhra <tanayabh@gmail.com> writes:

> +Querying For Specific Variables
> +-------------------------------
> +
> +For programs wanting to query for specific variables in a non-callback
> +manner, the config API provides two functions `git_config_get_string`
> +and `git_config_get_string_multi`.They both read values from an internal
> +cache generated previously from reading the config files.
> +
> +`git_config_get_string` takes two parameters,
> +
> +- a key string in canonical flat form for which the corresponding value
> +  with the highest priority (i.e. value in the repo config will be
> +  preferred over value in user wide config for the same variable) will
> +  be retrieved.
> +
> +- a pointer to a string which will point to the retrieved value.
> +
> +`git_config_get_string` returns 0 for success, or -1 for no value found.
> +
> +`git_config_get_string_multi` returns a `string_list` containing all the
> +values for the key passed as parameter, sorted in order of increasing
> +priority (Note: NULL values are flagged as 1, check `util` for each
> +'string_list_item` for flag value).

I think you need to add something like:

   Both functions return pointers to values owned by the config cache. The
   caller need not free them, but should not modify them.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
