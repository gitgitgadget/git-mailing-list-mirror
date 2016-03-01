From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] builtin/receive-pack.c: use parse_options API
Date: Tue, 01 Mar 2016 18:57:30 +0100
Message-ID: <vpqio1613p1.fsf@anie.imag.fr>
References: <1456846560-9223-1-git-send-email-tigerkid001@gmail.com>
	<vpq60x62jvt.fsf@anie.imag.fr> <56D5D601.8030601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 18:57:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaoYD-0008GU-MY
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 18:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbcCAR5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 12:57:34 -0500
Received: from mx2.imag.fr ([129.88.30.17]:34899 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139AbcCAR5d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 12:57:33 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u21HvRno025062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 1 Mar 2016 18:57:27 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u21HvU9D018741;
	Tue, 1 Mar 2016 18:57:30 +0100
In-Reply-To: <56D5D601.8030601@gmail.com> (Sidhant Sharma's message of "Tue, 1
	Mar 2016 23:18:49 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 01 Mar 2016 18:57:28 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u21HvRno025062
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457459848.57816@eudE6npBO7xOzXRHrF1qcA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288047>

Sidhant Sharma <tigerkid001@gmail.com> writes:

>>> +	if (argc > 1)
>>> +		usage_msg_opt(_("Too many arguments."), receive_pack_usage, options);
>>> +	if (argc == 0)
>>> +		usage_msg_opt(_("You must specify a directory."), receive_pack_usage, options);
>> Before that, the loop was ensuring that service_dir was assigned once
>> and only once, and now you check that you have one non-option arg and
>> assign it unconditionally:
>>
>>> +	service_dir = argv[0];
>> ... so isn't this "if" dead code:
>>
>>>  	if (!service_dir)
>>> -		usage(receive_pack_usage);
>>> +		usage_with_options(receive_pack_usage, options);
>> ?
>>
>>
> Yes, I just realized that is dead code (sorry). Removing the 'if'
> statement would correct that?

Yes.

> Also, is the unconditional assignment to service_dir correct in this
> case, or should some other test condition be added?

Since usage_msg_opt is NORETURN, it's OK: if you reach this point, you
know that argv[0] contains something.

> Another thing I'd like to ask is when I prepare the next patch, should
> it be sent as reply in this thread, or as a new thread?

No strict rule on that, but I usually use --in-reply-to on the root of
the thread for previous iteration. If you don't, include a link (e.g.
gmane) to the previous iteration in the cover-letter.

format-patch has a -v2 option to let you get [PATCH v2 ...]
automatically.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
