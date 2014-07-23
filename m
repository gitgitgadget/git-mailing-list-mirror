From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] config.c: change the function signature of `git_config_string()`
Date: Wed, 23 Jul 2014 10:42:06 +0200
Message-ID: <vpqegxccvq9.fsf@anie.imag.fr>
References: <1406026196-17877-1-git-send-email-tanayabh@gmail.com>
	<20140722110720.GA386@peff.net>
	<xmqqk375gx1n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Tanay Abhra <tanayabh@gmail.com>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 10:42:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9s8W-0004pI-Nc
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 10:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757425AbaGWImw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 04:42:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34970 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756802AbaGWImv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 04:42:51 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6N8g51B020811
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Jul 2014 10:42:05 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6N8g6AU018922;
	Wed, 23 Jul 2014 10:42:06 +0200
In-Reply-To: <xmqqk375gx1n.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 22 Jul 2014 09:47:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 23 Jul 2014 10:42:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6N8g51B020811
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406709727.17141@zslAUt7gSYF2WsTfVZbT6A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254062>

Junio C Hamano <gitster@pobox.com> writes:

> *1* We have safe_create_leading_directories_const() that works
> around this for input parameter around its _const less counterpart,
> which is ugly but livable solution.

I think it would actually be a reasonable solution to avoid casting here
and there on the caller side.

Another option would be to _return_ a non-const char * instead of
outputing it as a by-address parameter. We'd lose the consiseness of

   return git_config_get_string(...)

(but in cases where the return value is ignored, we do not really care)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
