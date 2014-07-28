From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 4/6] add a test for semantic errors in config files
Date: Mon, 28 Jul 2014 13:38:41 +0200
Message-ID: <vpqr415r9vi.fsf@anie.imag.fr>
References: <1406543635-19281-1-git-send-email-tanayabh@gmail.com>
	<1406543635-19281-5-git-send-email-tanayabh@gmail.com>
	<vpqmwbtu3rh.fsf@anie.imag.fr> <53D63389.5090205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 13:38:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBjGX-0001YB-On
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 13:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595AbaG1Liu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 07:38:50 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48062 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982AbaG1Lit (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 07:38:49 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6SBcdmj032595
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Jul 2014 13:38:39 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6SBcfh5015835;
	Mon, 28 Jul 2014 13:38:41 +0200
In-Reply-To: <53D63389.5090205@gmail.com> (Tanay Abhra's message of "Mon, 28
	Jul 2014 16:57:05 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 28 Jul 2014 13:38:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6SBcdmj032595
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407152322.81088@HgjGLUViyVfaMRVZH20FUg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254313>

Tanay Abhra <tanayabh@gmail.com> writes:

> On 7/28/2014 4:52 PM, Matthieu Moy wrote:
>> Tanay Abhra <tanayabh@gmail.com> writes:
>> 
>>> +test_expect_success 'check line errors for malformed values' '
>>> +	mv .git/config .git/config.old &&
>>> +	test_when_finished "mv .git/config.old .git/config" &&
>>> +	cat >.git/config <<-\EOF &&
>>> +	[alias]
>>> +		br
>>> +	EOF
>>> +	test_expect_code 128 git br 2>result &&
>>> +	grep "fatal: bad config file line 2 in .git/config" result
>>> +'
>> 
>> This is PATCH 4, and it tests a bug fixed in PATCH 1. It would have
>> eased review to group both patches, either
>> 
>> PATCH 1: introduce test_expect_failure test to demonstrate the failure
>
> Didn't Junio comment that he wouldn't recommend inserting a test_expect_failure
> for new tests and then flipping them after in the series.

No, he even said it was good practice:

http://thread.gmane.org/gmane.comp.version-control.git/254101/focus=254104

his point was to avoid breaking something and repairing in another patch
(which your initial series was doing because the test patch was coming
between "rewrite git_config() to use the config-set API" and "add line
number and file name info to `config_set`").

The situation is different when you have a pre-existing bug.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
