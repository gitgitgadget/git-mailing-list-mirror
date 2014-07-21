From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 2/6] branch.c: replace `git_config()` with `git_config_get_string()`
Date: Mon, 21 Jul 2014 20:06:41 +0200
Message-ID: <vpqppgymvri.fsf@anie.imag.fr>
References: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
	<1405941145-12120-3-git-send-email-tanayabh@gmail.com>
	<xmqqiomqk2yu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 20:06:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9HzF-0005Hj-QG
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 20:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933314AbaGUSGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 14:06:53 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46027 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932320AbaGUSGx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 14:06:53 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6LI6dvX012153
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jul 2014 20:06:39 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6LI6f51028438;
	Mon, 21 Jul 2014 20:06:41 +0200
In-Reply-To: <xmqqiomqk2yu.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 21 Jul 2014 10:59:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 21 Jul 2014 20:06:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6LI6dvX012153
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406570800.36328@bMWdmbP9ZTfQEhe19tmZ1Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253984>

Junio C Hamano <gitster@pobox.com> writes:

> Tanay Abhra <tanayabh@gmail.com> writes:
>
>> -	if (cb.value)
>> -		strbuf_addstr(buf, cb.value);
>> +	strbuf_addstr(buf, v);
>> +	free((char*)v);
>
> In this cast, I smell an API mistake to insist an extra constness to
> the output parameter of git_config_get_string() in [3/4] of the
> previous series.  Unlike the underlying git_config_get_value(),
> which lets the caller peek into the internal cached copy, the caller
> of git_config_get_string() is given its own copy, and I do not
> offhand see a good reason to forbid the caller from modifying it.

Indeed. My suggestion to change the declaration of char * variables
actually seem like a workaround for an API mistake after reading this.

(well, actually, the declaration could be modified if we think it brings
any new safety, but that should be another topic)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
