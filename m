From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/7] rewrite git_config() to use the config-set API
Date: Wed, 23 Jul 2014 21:55:38 +0200
Message-ID: <vpq4my7vohx.fsf@anie.imag.fr>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<1406140978-9472-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:55:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA2dl-0007dN-NH
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 21:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933322AbaGWTzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 15:55:49 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60797 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932896AbaGWTzs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 15:55:48 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6NJtZpS006152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Jul 2014 21:55:35 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6NJtcLY026342;
	Wed, 23 Jul 2014 21:55:38 +0200
In-Reply-To: <1406140978-9472-3-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Wed, 23 Jul 2014 11:42:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 23 Jul 2014 21:55:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6NJtZpS006152
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406750138.61776@rIlokA9mYwN/bIy8QJtWow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254116>

Tanay Abhra <tanayabh@gmail.com> writes:

> -int git_config(config_fn_t fn, void *data)
> +static int git_config_raw(config_fn_t fn, void *data)

As you noticed already, this change breaks several tests. You are going
to repair them later in the series, but your patch series produces a
non-bisectable history.

The history should pass tests at each commit. If needed, you can ensure
that with eg.

git rebase HEAD~7 --exec "make && cd t/ && ./t1308-config-set.sh && ./t4018-diff-funcname.sh" -i

(or --exec 'make test', but that takes really long)

So, this patch should come later in the series (not hard, just a
reordering with rebase -i).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
