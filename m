From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v9 3/8] add line number and file name info to `config_set`
Date: Thu, 07 Aug 2014 22:11:47 +0200
Message-ID: <vpqegwsm54s.fsf@anie.imag.fr>
References: <1407412759-13833-1-git-send-email-tanayabh@gmail.com>
	<1407412759-13833-4-git-send-email-tanayabh@gmail.com>
	<53E3D494.1070606@ramsay1.demon.co.uk> <vpqlhr0m5tl.fsf@anie.imag.fr>
	<xmqqwqakjc43.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 22:12:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFU2Z-0000xq-GO
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 22:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbaHGULz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 16:11:55 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41716 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955AbaHGULz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 16:11:55 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s77KBjou009254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 Aug 2014 22:11:45 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s77KBlv9004974;
	Thu, 7 Aug 2014 22:11:47 +0200
In-Reply-To: <xmqqwqakjc43.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 07 Aug 2014 13:09:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 07 Aug 2014 22:11:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s77KBjou009254
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1408047107.15264@mJTvZy/WY0PXxcgMkZ7osg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254995>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>> ...
>>>> diff --git a/cache.h b/cache.h
>>>> ...
>>>> +struct key_value_info {
>>>> +	const char *filename;
>>>> +	int linenr;
>>>> +};
>>>> +
>>>
>>> I haven't checked, but does this series now include a user for
>>> this struct outside of config.c? If not, then I think it would
>>> be better to leave the declaration in config.c until it is needed.
>>> (To make it easier to see if it is necessary in the context of the
>>> patch which will make use of it).
>>
>> I disagree: this patch series is essentially about introducing a new
>> API, and this struct declaration is part of the API.
>
> Hmm, is it?  How would the customer of the API use it?  die_config
> and friends may internally use the information recorded using the
> structure, but I had an impression that it is an implementation
> detail that does not need to be exposed to the customers of the API.
> Am I mistaken?

It does if you want to provide error message while iterating over the
string_list. Not the common case, but shouldn't be forbidden either.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
