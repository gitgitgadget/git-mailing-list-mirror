From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 3/7] change `git_config()` return value to void
Date: Thu, 31 Jul 2014 13:32:19 +0200
Message-ID: <vpq1tt1epbw.fsf@anie.imag.fr>
References: <1406799857-28048-1-git-send-email-tanayabh@gmail.com>
	<1406799857-28048-4-git-send-email-tanayabh@gmail.com>
	<vpqoaw5epsa.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 13:32:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCob9-0004oi-9r
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 13:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbaGaLcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 07:32:35 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50899 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbaGaLce (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 07:32:34 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6VBWIam004256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2014 13:32:18 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6VBWJ8P024897;
	Thu, 31 Jul 2014 13:32:19 +0200
In-Reply-To: <vpqoaw5epsa.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	31 Jul 2014 13:22:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 31 Jul 2014 13:32:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6VBWIam004256
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407411141.46541@Iolv8jm0Y2JZZQu+YHSB1Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254555>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Tanay Abhra <tanayabh@gmail.com> writes:
>
>> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
>
> I think I deserve a bit of credit here ;-).
>
>>  {
>> -	return git_config_with_options(fn, data, NULL, 1);
>> +	if (git_config_with_options(fn, data, NULL, 1) < 0)
>> +		/*
>> +		 * git_config_with_options() normally returns only
>> +		 * positive values, as most errors are fatal, and
>> +		 * non-fatal potential errors are guarded by "if"
>> +		 * statements that are entered only when no error is
>> +		 * possible.
>> +		 *
>> +		 * If we ever encounter a non-fatal error, it means
>> +		 * something went really wrong and we should stop
>> +		 * immediately.
>> +		 */
>> +		die("Unknown error occured while reading the configuration files");
>>  }
>
> My bad, but this should be die(_("..."));, so that the message can be
> translated. Not really serious since it's not really meant to be seen by
> the user, though.

Also, other error messages do not start with a capital, hence it should
be "unknown..., not "Unknown. My bad again.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
