From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 0/5] git_config callers rewritten with the new config cache API
Date: Wed, 30 Jul 2014 18:45:08 +0200
Message-ID: <vpqiomeokx7.fsf@anie.imag.fr>
References: <1406727549-22334-1-git-send-email-tanayabh@gmail.com>
	<vpq1tt3rmbt.fsf@anie.imag.fr> <53D8FB39.7040904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 18:45:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCX0C-0003Ik-T5
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 18:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948AbaG3QpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 12:45:14 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46879 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753483AbaG3QpN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 12:45:13 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6UGj6fE008719
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Jul 2014 18:45:06 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6UGj8Cl015375;
	Wed, 30 Jul 2014 18:45:08 +0200
In-Reply-To: <53D8FB39.7040904@gmail.com> (Tanay Abhra's message of "Wed, 30
	Jul 2014 19:33:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 30 Jul 2014 18:45:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6UGj6fE008719
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407343508.5344@Qo3duLA3wURvOarvpAlMOg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254500>

Tanay Abhra <tanayabh@gmail.com> writes:

> Yes you are right, there is a call to git_die_config() also in the series. I will add
> the info in the next reroll.

If unsure, rebase your branch locally on the commit on which it is meant
to apply, and check that it works for you.

> Also, any thoughts on what to do with git_default_config()? We can,
>
> 1> make a new function git_load_default_config(), use it for the rewrites.

That seems the most sensible option. It could be called it git.c before
the command-dependant part, so that any call to git loads this.

I didn't check if it was correct (e.g. do some command rely on the fact
that the default config is not loaded?)

> 2> git_default_config() is rewritten to be loaded only once even if it is called
> again and again during the process run, so that we use the same function in callbacks
> and in the new API using rewrites.

Seems like a workaround, and to me the point of your GSoC is to make the
code cleaner, hence avoid workaraounds ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
